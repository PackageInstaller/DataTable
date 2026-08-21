local FIGHT_DEFINE = require("cs_share.fight_define")
local FIGHT_CALC = require("cs_share.fight_calc")
local ATTR_TYPE = FIGHT_DEFINE.ATTR_TYPE
local ATTR_GROUP_TYPE = {
  BASE = 1,
  ADDITIVE = 2,
  MODULE_ATTR = 3,
  EQUIP_ATTR = 4,
  NO_FIGHT_ATTR = 5
}
local ATTR_SET_TYPE = {CHANGE_BY_DELTA = 1, REPLACE = 2}
local VALUE_TYPE = {FIXED = 1, RATIO = 2}
local t = {}

function t.calc_room_recover(attr_mgr, random_ctx)
  t._calc_recover(attr_mgr, random_ctx, "CHAR_ROOM_FIXED_REC_ATTR_LL_", "CHAR_ROOM_FIXED_REC_ATTR_UL_", "CHAR_ROOM_RATIO_REC_ATTR_LL_", "CHAR_ROOM_RATIO_REC_ATTR_UL_")
end

function t.calc_floor_recover(attr_mgr, random_ctx)
  t._calc_recover(attr_mgr, random_ctx, "CHAR_FLOOR_FIXED_REC_ATTR_LL_", "CHAR_FLOOR_FIXED_REC_ATTR_UL_", "CHAR_FLOOR_RATIO_REC_ATTR_LL_", "CHAR_FLOOR_RATIO_REC_ATTR_UL_")
end

function t._calc_recover(attr_mgr, random_ctx, fix_min_id_name, fix_max_id_name, ratio_min_id_name, ratio_max_id_name)
  local fix_min, fix_max, ratio_min, ratio_max, fix_min_attr_type, fix_max_attr_type, ratio_min_attr_type, ratio_max_attr_type, recover_attr_type
end

return t
