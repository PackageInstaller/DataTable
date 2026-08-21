local M = {}
M.CardType = {
  battle = 1,
  event = 2,
  treasure = 3,
  recovery = 4
}
M.TalentInfo = {
  Power = 99,
  Perception = 100,
  Agility = 101,
  Physique = 102,
  WillPower = 103,
  Luck = 104
}
M.AniType = {CardDeck = 1, Card = 2}
M.CARD_DECK_STATE = {
  INIT = 1,
  IDLE = 2,
  ROTATE = 3,
  SELECT = 4,
  SELECTTING = 5,
  DELETE = 6,
  DRAW_CARD = 7,
  CREATE_KEY_CARD = 8,
  CONTINUE_SELECTING = 9,
  DELETING = 10,
  CREATE_DOOR_CARD = 11,
  CONTINUE_DARW_CARD = 12
}
return M
