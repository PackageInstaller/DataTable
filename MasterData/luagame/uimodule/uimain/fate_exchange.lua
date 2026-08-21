local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local AssetBarView = require("ui.asset_bar.asset_bar")
local Shop_Helper = require("uimodule.shop.shop_helper")
local SHOW_STR = "是否消耗<color=#{1}>{2}</color>{3}兑换<color=#{4}>{5}</color>{6}"
local SHOW_STR_COLOR = ShareRes.get_comm_string_value("ItemExchangeNumColor") or "EC7F00"

function ui:ui_finish_load()
  Util.get_text("Main/Text", self.v_object).text = "道具兑换"
  self:set_button("Add_Btn", function()
    self:on_click_add_btn()
  end)
  self:set_button("Back", function()
    self:ui_hide()
  end)
  self:set_button("Cancel", function()
    self:ui_hide()
  end)
  self:set_button("Confirm", function()
    self:on_click_confirm_btn()
  end)
  self:set_button("Reduce_Btn", function()
    self:on_click_reduce_btn()
  end)
  self:set_slider_listener(self.v_uicompents.Slider_sld, function()
    self:onclick_slider()
  end)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:on_click_add_btn()
  if self.v_cur_exchange_num + 1 > self.v_can_exchange_max_num then
    return
  end
  self.v_cur_exchange_num = self.v_cur_exchange_num + 1
  self.v_lack_cnt = self.v_lack_cnt + 1
  self.v_uicompents.Slider_sld.value = self.v_cur_exchange_num
  self:refresh_view()
end

function ui:on_click_reduce_btn()
  if self.v_cur_exchange_num - 1 < 1 then
    self.v_uicompents.Slider_sld.value = 0
    return
  end
  self.v_cur_exchange_num = self.v_cur_exchange_num - 1
  self.v_lack_cnt = self.v_lack_cnt - 1
  self.v_uicompents.Slider_sld.value = self.v_cur_exchange_num
  self:refresh_view()
end

function ui:on_click_confirm_btn()
  if self.v_callback then
    self.v_callback()
  else
    self:response_click_confirm_btn()
  end
end

function ui:response_click_confirm_btn()
  local target_id = self.v_target_id
  local item_id = self.v_item_id
  local target_item_cfg = UtilUI.get_item_cfg(target_id)
  local item_possess_num = BagMgr:get_item_num(target_id)
  if item_possess_num < target_item_cfg.MaxCount and self.v_can_exchange_max_num < 1 then
    UIMgr:get_ui("uiforcerecharg"):ui_show(nil, self.v_need_sp_count)
    return
  end
  local exchange_config = CharacterMgr:get_exchange_config(Config.EXCHANGE_TYPE.DEFAULT, target_id, item_id)
  CharacterMgr:request_exchange_item(exchange_config.Id, self.v_cur_exchange_num, function()
    Util.show_message_tip(2229)
    self:ui_hide()
  end)
end

function ui:onclick_slider()
  self.v_cur_exchange_num = math.floor(self.v_uicompents.Slider_sld.value)
  self:update_exchange_num(self.v_target_id, self.v_lack_cnt, self.v_item_id)
end

function ui:ui_on_show(target_id, lack_cnt, item_id, exchange_item_cnt, next_exchange_cost_id, next_exchange_cost_cnt, callback)
  self.v_target_id = target_id
  self.v_item_id = item_id
  self.v_lack_cnt = lack_cnt or 1
  self.v_callback = callback
  self.v_exchange_item_cnt = exchange_item_cnt
  self:show_item(target_id, lack_cnt, item_id, exchange_item_cnt)
  self:update_exchange_num(target_id, lack_cnt, item_id, exchange_item_cnt)
  local list = Shop_Helper.get_asset_list({target_id, item_id})
  self.v_asset_bar:reset_config(list)
  self.v_asset_bar:on_create()
  self:bind_auto_mq(Const.MSG_ON_PLAYER_SP_UPDATE, self.refresh_view, self)
end

function ui:refresh_view()
  local target_id, item_id = self.v_target_id, self.v_item_id
  local lack_cnt = self.v_lack_cnt
  self:show_item(target_id, lack_cnt, item_id)
  self:update_exchange_num(target_id, lack_cnt, item_id)
end

function ui:show_item(target_id, lack_cnt, item_id, exchange_item_cnt)
  local cfg = CharacterMgr:get_exchange_config(Config.EXCHANGE_TYPE.DEFAULT, target_id, item_id)
  lack_cnt = lack_cnt or 1
  local target_item_cfg = ShareRes.create("item.item", target_id)
  local material_icon_path = UtilUI.get_item_icon(item_id)
  local target_icon_path = UtilUI.get_item_icon(target_id)
  local material_quality = UtilUI.get_item_quality_icon(item_id)
  local target_quality = UtilUI.get_item_quality_icon(target_id)
  ResMgr:load_set_icon(self.v_uicompents.useIcon_img, material_icon_path)
  ResMgr:load_set_icon(self.v_uicompents.getIcon_img, target_icon_path)
  ResMgr:load_set_icon(self.v_uicompents.useQuaBg_img, material_quality)
  ResMgr:load_set_icon(self.v_uicompents.getQuaBg_img, target_quality)
  local item_possess_num = BagMgr:get_item_num(target_id)
  local material_item_num = BagMgr:get_item_num(item_id)
  local left_time = CharacterMgr:get_exchange_remain_time(cfg.Id)
  local can_get_max_num = math.floor(material_item_num / cfg.Num[1] * cfg.Count)
  if lack_cnt then
    self.v_need_sp_count = (lack_cnt - can_get_max_num) * (cfg.Num[1] * cfg.Count)
  end
  local can_exchange_num = target_item_cfg.MaxCount - item_possess_num
  self.v_can_exchange_max_num = can_get_max_num >= can_exchange_num and can_exchange_num or can_get_max_num
  if left_time < self.v_can_exchange_max_num then
    self.v_can_exchange_max_num = left_time
  end
  local max_value = 0 == self.v_can_exchange_max_num and 1 or self.v_can_exchange_max_num
  max_value = max_value > target_item_cfg.MaxCount and target_item_cfg.MaxCount or max_value
  self.v_slider_max_value = max_value
  self.v_uicompents.ChargeMax_txt.text = max_value
  self.v_uicompents.Slider_sld.maxValue = max_value
  self.v_cur_exchange_num = lack_cnt
  local own_num = BagMgr:get_item_num(item_id)
  self.v_uicompents.ItemNow_txt.text = own_num
  self.v_uicompents.ItemNow_txt.color = own_num >= cfg.Num[1] * lack_cnt and Util.CommonColor_White or Util.CommonColor_RedWarm
  if lack_cnt <= self.v_can_exchange_max_num then
    self.v_uicompents.ChargeNow_txt.text = 1
    Util.apply_grey_ex(self.v_uiobjects.Confirm, false)
    self.v_uicompents.Slider_sld.interactable = true
    self.v_cur_exchange_num = lack_cnt or 1
    self.v_uicompents.Slider_sld.value = self.v_lack_cnt or 0
  else
    self.v_uicompents.ChargeNow_txt.text = "<color=red>1</color>"
    self.v_uicompents.ItemNeed_txt.text = 0
    self.v_uicompents.GetNum_txt.text = 0
    Util.apply_grey_ex(self.v_uiobjects.Confirm, true)
    self.v_uicompents.Slider_sld.interactable = false
    self.v_uicompents.Slider_sld.value = self.v_lack_cnt or 1
  end
end

function ui:update_exchange_num(target_id, lack_cnt, item_id, exchange_item_cnt)
  lack_cnt = lack_cnt or 1
  self.v_cur_exchange_num = lack_cnt or self.v_cur_exchange_num
  self.v_cur_exchange_num = self.v_cur_exchange_num > 1 and self.v_cur_exchange_num or 1
  local cfg = CharacterMgr:get_exchange_config(Config.EXCHANGE_TYPE.DEFAULT, target_id, item_id)
  local cfg1 = UtilUI.get_item_cfg(target_id)
  local cfg2 = UtilUI.get_item_cfg(item_id)
  local need_count = cfg.Num[1] * self.v_cur_exchange_num
  local get_count = cfg.Count * self.v_cur_exchange_num
  self.v_uicompents.ItemNeed_txt.text = need_count
  self.v_uicompents.ChargeStr_txt.text = Util.format_str(SHOW_STR, SHOW_STR_COLOR, need_count, cfg2.Name, SHOW_STR_COLOR, get_count, cfg1.Name)
  self.v_uicompents.ItemNow_txt.text = BagMgr:get_item_num(item_id)
  self.v_uicompents.GetNum_txt.text = get_count
  self.v_uicompents.Slider_sld.minValue = 1
  self.v_uicompents.Slider_sld.maxValue = self.v_slider_max_value
  if self.v_cur_exchange_num >= self.v_slider_max_value then
    Util.apply_grey_ex(self.v_uiobjects.Add_Btn, true)
    self.v_uicompents.Add_Btn_btn.enabled = false
  else
    Util.apply_grey_ex(self.v_uiobjects.Add_Btn, false)
    self.v_uicompents.Add_Btn_btn.enabled = true
  end
  if self.v_cur_exchange_num < 1 then
    Util.apply_grey_ex(self.v_uiobjects.Reduce_Btn, true)
    self.v_uicompents.Reduce_Btn_btn.enabled = false
  else
    Util.apply_grey_ex(self.v_uiobjects.Reduce_Btn, false)
    self.v_uicompents.Reduce_Btn_btn.enabled = true
  end
  if 1 == self.v_can_exchange_max_num then
    self.v_uicompents.Slider_sld.interactable = false
    self.v_uicompents.Slider_sld.value = 1
    self.v_uicompents.Slider_sld.minValue = 0
  else
    self.v_uicompents.Slider_sld.value = self.v_cur_exchange_num
  end
end

function ui:ui_on_hide()
  if self.v_asset_bar then
    self.v_asset_bar:on_hide()
  end
  if self.v_open_charg_on_hide then
    UIMgr:get_ui("uiforcerecharg"):ui_show()
  end
  self.v_open_charg_on_hide = nil
end

function ui:ui_on_destroy()
  if self.v_asset_bar then
    self.v_asset_bar:on_destory()
    self.v_asset_bar = nil
  end
end

function ui:set_open_charg_on_hide(is_open)
  self.v_open_charg_on_hide = is_open
end

function ui:check_can_exchange()
  return self.v_can_exchange_max_num >= self.v_lack_cnt
end

function ui:get_cur_lack_cnt()
  return self.v_lack_cnt
end

return ui
