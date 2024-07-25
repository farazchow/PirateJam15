
SpeciesKey = tibble::tribble(
  ~Species, ~Legs, ~Tail, ~Torso, ~Arms, ~Head, ~Level, ~Prime,
  Celestials, "legs.png", "tail.png", "torso.png", "arms.png", "head.png", 1, 7,
  Centaurs, "a", "b", "c", "d", "e", 1, 17,
  Demons, "a", "b", "c", "d", "e", 1, 11,
  Fiends, "a", "b", "c", "d", "e", 1, 13,
)

Placements = tibble::tribble(
  ~Species, ~Part, ~Dimensions, ~Root, ~TorsoArms, ~TorsoTail
  Celestials, "Legs", "50x200", "25x180", NA, NA,
  Celestials, "Torso", "90x400", "45x380", "50x350", "10x10",
)

OrderOfOperations = tibble::tribble(
  ~Part, ~ZOrder, ~BodyPK,
  BackLegs, 100, 100000,
  BackArms, 200, 200000,
  Tail, 300, 300000,
  Torso, 400, 400000,
  FrontLegs, 500, 500000,
  Head, 600, 600000
  Front Arms, 700, 700000,
)

Exceptions = tibble::trible(
  ~Legs, ~Tail, ~Torso, ~Arms, ~Head,
  ~NewOoO_Legs, ~NewOoO_Tail, ~NewOoO_Torso, ~NewOoO_Arms, ~NewOoO_Head,
  ~NewPlcm_Legs, ~NewPlcm_Tail, ~NewPlcm_Torso, ~NewPlcm_Arms, ~NewPlcm_Head,
  ~NewOoO_autogen, ~NewPlcm_autogen,
  NA, NA, Centaur, NA, NA,
  NA, NA, NA, NA, NA,
  NA, NA, NA, "240x100", "270x210",
  NA, NA
)


