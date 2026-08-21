local Base = require("uimodule.battle_treasure.battle_treasure_item")
local M = Util.create_child_mt(Base)
local util_get_color = Util.get_unity_color_by_hex
local not_have_suit_color = util_get_color(tonumber("777777", 16))
local have_suit_color = util_get_color(tonumber("c3beb6", 16))

function M:set_suit_active_color(suit_dec, suit_detail)
  suit_dec.color = have_suit_color
  suit_detail.color = have_suit_color
end

function M:set_suit_unactive_color(suit_dec, suit_detail)
  suit_dec.color = not_have_suit_color
  suit_detail.color = not_have_suit_color
end

function M:set_job_color(engough)
  return engough and "<color=#c3beb6>" or "<color=#777777>"
end

return M
