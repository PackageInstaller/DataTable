local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local icon_path_prefix = "Icon/item/%s"
local ward_text = "当前可领:%u次"
local ward = "领取"
local FINAL_AWARD_TIPS_ITEMOBJCOM = "FINAL_AWARD_TIPS_ITEMOBJCOM"
local Quality_Img = {
  [1] = "UICommon/Common_pzk_01",
  [2] = "UICommon/Common_pzk_02",
  [3] = "UICommon/Common_pzk_02",
  [4] = "UICommon/Common_pzk_03",
  [5] = "UICommon/Common_pzk_04"
}

function ui:ui_finish_load()
  self:set_button("BgBtn", function()
    self:ui_hide()
  end)
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self:set_button("BtnRecive", function()
    self:recive_award()
  end)
  self:register_exist_auto_template(FINAL_AWARD_TIPS_ITEMOBJCOM, self.v_uiobjects.ItemObjCom, self.v_uiobjects.AwardLayout)
end

function ui:ui_on_show(param)
  self.v_parent = param.parent
  self:give_back_auto_cache(FINAL_AWARD_TIPS_ITEMOBJCOM)
  self.v_uiobjects.Tips:SetActive(true)
  self.v_uiobjects.BtnGeted:SetActive(false)
  self.v_uiobjects.BtnCantGet:SetActive(false)
  self.v_uicompents.Tips_txt.text = string.format(ward_text, param.gift_count)
  local label_txt = Util.get_text("Label", self.v_uiobjects.BtnRecive)
  label_txt.text = ward
  local award_list = ShareRes.get_awards(param.award_group_id)
  for index, value in ipairs(award_list) do
    local item_obj = self:get_auto_cache(FINAL_AWARD_TIPS_ITEMOBJCOM)
    local item_id = value.ItemId
    local item_cfg = ShareRes.get_item_cfg(item_id)
    local icon_path = string.format(icon_path_prefix, item_cfg.Icon)
    local item_quality = Util.get_image("ItemQuality_", item_obj)
    local icon_img = Util.get_image("ItemIcon_", item_obj)
    local amount_txt = Util.get_text("ItemAmount_/Bg/ItemNum_", item_obj)
    ResMgr:load_set_icon(item_quality, Quality_Img[item_cfg.Quality])
    ResMgr:load_set_icon(icon_img, icon_path)
    amount_txt.text = value.Num
  end
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:recive_award()
  PassPortMgr:request_get_final_award(function()
    self.v_parent:refresh()
    self:ui_hide()
  end)
end

return ui
