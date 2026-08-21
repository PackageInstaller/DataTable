local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local Item_Helper = require("utils.item_helper")
local ITEM_ICON_PATH = "Icon/Item/"
local bagConfig = require("gamelogic.character.fight_bag_configs")

function M:set_data(data)
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local item_btn = self:get_button(nil, self.go)
  self:set_button_listener(item_btn, function()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = data.reward.ItemId,
      jump_cb = function()
        UIMgr:try_hide_ui("material_stage_info")
      end
    })
  end)
  local item_cfg = Item_Helper.get_item_cfg(data.reward.ItemId)
  local ItemQuality_img = ucom.Quality_img
  ResMgr:load_set_icon(ItemQuality_img, bagConfig.Quality_Img[item_cfg.Quality])
  local ItemIcon_img = ucom.Icon_img
  local icon_path = ITEM_ICON_PATH .. item_cfg.Icon
  ResMgr:load_set_icon(ItemIcon_img, icon_path)
  ucom.FirstGet_rect:SetActive(data.reward_type == ChapterMaterialMgr.first_pass or data.reward_type == ChapterMaterialMgr.first_pass_received)
  ucom.DropUp_rect:SetActive(data.reward_type == ChapterMaterialMgr.prob_up)
  if data.reward_type == ChapterMaterialMgr.first_pass_received then
    ucom.Received_img:SetActive(true)
  else
    ucom.Received_img:SetActive(false)
  end
  local curr_num = 1
  if data.reward_type ~= ChapterMaterialMgr.first_pass and data.reward_type ~= ChapterMaterialMgr.first_pass_received then
    curr_num = ChapterMaterialMgr:get_curr_multiple_num()
  end
  local show_count = data.reward.Num * curr_num
  local ItemAmount_obj = uobj.ItemNumObj
  ItemAmount_obj:SetActive(true)
  local ItemNum_txt = ucom.Num_txt
  ItemNum_txt.text = show_count
end

function M:on_clear()
end

return M
