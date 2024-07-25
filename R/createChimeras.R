
ReadPic <- function(filepath) {
  magick::image_read(filepath)
}

UnequalDims <- function(image1, image2) {
  (magick::image_info(image1) == magick::image_info(image2)) %>%
    .[, c(2, 3)] %>%
      all(.) %>%
        { ! . }
}

PrintDims <- function(image) {
  magick::image_info(image) %>%
    .[1, c(2, 3)] %>%
      { paste0(.[[1]], "x", .[[2]]) }
}

WarningDims <- function(name, image, imageTruth) {
  paste("Unusual dimensions on", name, "; expected", PrintDims(imageTruth), "but got", PrintDims(image))
}

Short <- function(filepath, rule) {
  basename(filepath) %>%
    gsub("\\.[^.]+?$", "", .) %>%
      gsub(rule, "", .) %>%
        gsub("[-_.,=+]", "", .) %>%
          substring(., 1, 4) %>%
            stringr::str_to_title(.)
}

CreateImage <- function(filename, guess, ...) {
  images = list(...)
  dims = PrintDims(images[[1]]) %>%
    strsplit(., "x") %>%
      .[[1]] %>%
        as.numeric(.)
  
  composite = magick::image_blank(dims[[1]], dims[[2]])
  
  for (ptr in images) {
    composite = magick::image_mosaic(c(composite, ptr), operator = guess)
  }
  
  magick::image_write(composite, filename, flatten = FALSE)
}

Stepwise <- function(root, guess, headRule, armsRule, bodyRule, legsRule, tailRule) {
  heads = list.files(root, headRule, full.names = T, recursive = T)
  arms = list.files(root, armsRule, full.names = T, recursive = T)
  body = list.files(root, bodyRule, full.names = T, recursive = T)
  legs = list.files(root, legsRule, full.names = T, recursive = T)
  tails = list.files(root, tailRule, full.names = T, recursive = T)
  
  dims = magick::image_read(heads[[1]])
  pathSeparator = gsub(basename(heads[[1]]), "", gsub(dirname(heads[[1]]), "", heads[[1]]))
  workingDir = paste0(dirname(heads[[1]]), pathSeparator, "outputs")
  dir.create(workingDir, showWarnings = FALSE)
  
  for (head in heads) {
    hImage = magick::image_read(head)
    if (UnequalDims(hImage, dims)) { warning(WarningDims(head, hImage, dims)) }
    for (arm in arms) {
      aImage = magick::image_read(arm)
      if (UnequalDims(aImage, dims)) { warning(WarningDims(arm, aImage, dims)) }
      for (bod in body) {
        bImage = magick::image_read(bod)
        if (UnequalDims(bImage, dims)) { warning(WarningDims(bod, bImage, dims)) }
        for (leg in legs) {
          lImage = magick::image_read(leg)
          if (UnequalDims(lImage, dims)) { warning(WarningDims(leg, lImage, dims)) }
          for (tail in tails) {
            tImage = magick::image_read(tail)
            if (UnequalDims(tImage, dims)) { warning(WarningDims(tail, tImage, dims)) }
            
            constructedName = paste0(
              workingDir, pathSeparator, Short(head, headRule), Short(arm, armsRule),
              Short(bod, bodyRule), Short(leg, legsRule), Short(tail, tailRule), ".png"
            )
            
            CreateImage(constructedName, guess, lImage, tImage, bImage, aImage, hImage)
          }
        }
      }
    }
  }
  
  workingDir
}

CreateSpritesheet <- function(root, guess) {
  sprites = list.files(root, "\\.png$", full.names = T, recursive = F) %>%
    .[! grepl("spritesheet", ., TRUE)]
  len = ceiling(sqrt(length(sprites) + 2))
  fullLen = length(sprites)
  startPos = seq.int(from = 1, to = length(sprites), by = len)
  pathSeparator = gsub(basename(root), "", gsub(dirname(root), "", root))

  images = NULL
  imagesVert = NULL

  blankDims = magick::image_read(sprites[[1]]) %>%
    PrintDims(.) %>%
      strsplit(., "x") %>%
        .[[1]] %>%
          as.numeric(.)
  
  for (pos in startPos) {
    horiz = magick::image_read(sprites[[pos]])
    skipFirst = as.numeric(pos == 1)
    imageSeq = seq.int(from = pos, by = 1, length.out = len) %>%
      .[. <= fullLen] %>%
        .[-1]
    blanks = seq_len(len - length(imageSeq))
    
    for (num in imageSeq) {
      im = magick::image_read(sprites[[num]])
      horiz = c(horiz, im)
    }
    
    for (count in blanks) {
      horiz = c(horiz, magick::image_blank(blankDims[[1]], blankDims[[2]]))
    }
    
    if (skipFirst) {
      images = magick::image_append(horiz, stack = FALSE)
    } else {
      images = c(images, magick::image_append(horiz, stack = FALSE))
    }
  }
  
  result = magick::image_append(images, stack = TRUE)
  print(guess)
  magick::image_write(result, paste0(root, pathSeparator, guess, "-spritesheet.png"), flatten = FALSE)
}

CreateChimeras <- function() {
  folder = "."
  headRule = "head"
  armsRule = "arms"
  bodyRule = "body"
  legsRule = "legs"
  tailRule = "tail"
  
  justGuess = magick::compose_types() %>%
    .[! . %in% c("Blur")]
  justGuess = NULL
  
  sapply(justGuess, function(x) {
    nextFolder = Stepwise(folder, x, headRule, armsRule, bodyRule, legsRule, tailRule)
    CreateSpritesheet(nextFolder, x)
  })
}
