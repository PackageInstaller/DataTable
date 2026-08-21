local M = {}
local FIGHT_DEFINE = require("cs_share.fight_define")
local ATTR_TYPE = FIGHT_DEFINE.ATTR_TYPE
M.AREA_TYPE = {
  none = 0,
  shop = 1,
  cast_room = 2,
  treasure = 3,
  restore_hp = 4,
  near_item = 5
}
M.TREASURE_STATUS = {CLOSE = 0, OPEN = 1}
M.FUNC_NPC_STATUS = {UN_INTERACT = 0, IS_INTERACT = 1}
M.FUNC_NPC_TYPE = {award_npc1 = 1}
M.ROOM_CUSTOM_STATUS = {
  CHAL_CARD_WIN = "chal_card_win"
}
M.NAME2ROOM_CUSTOM_STATUS = {}
for k, v in pairs(M.ROOM_CUSTOM_STATUS) do
  M.NAME2ROOM_CUSTOM_STATUS[v] = k
end
M.TIMELINE_ACTION_TYPE = {START = 1, END = 2}
M.SCENE_LOGIC_ACTION = {PAUSE = 1, CONTINUE = 2}
return M
