local helper = {}
local UI_SHOW_LIST_BY_UI_NAME = {
  uitreasure = {NormalTreasureObj = true},
  ui_cr_treasure_box = {NormalTreasureObj = false}
}

function helper.control_obj_show(ui_name)
  return UI_SHOW_LIST_BY_UI_NAME[ui_name]
end

return helper
