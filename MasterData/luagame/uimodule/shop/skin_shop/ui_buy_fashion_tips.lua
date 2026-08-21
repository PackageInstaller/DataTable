local ShopCfg = require("uimodule.shop.shop_config")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local ITEM_OBJ_CLASS = require("uimodule.item.item_obj_com")
local AWARD_ITEM_KEY = "BUY_FASION_TIPS_AWARD_ITEM_TEMP_KEY"
local CT_Timer = Global.ct_timer
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BtnCancel", function()
    self:ui_hide()
  end)
  self:set_button("BtnBuy", function()
    self:do_buy()
  end)
  self:register_exist_auto_template(AWARD_ITEM_KEY, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.Content)
end

function ui:do_buy()
  if self.v_is_end then
    Util.show_message_tip(2277)
    self:ui_hide()
    return
  end
  
  local function cb(ok)
    self.v_timer = Timer:add_timer("ui_buy_fashion_tips", 0.5, function()
      self:ui_hide()
    end)
  end
  
  self.v_uicompents.BtnBuy_btn.interactable = false
  RechargeMgr:request_buy_gift(self.v_id, cb)
end

function ui:ui_on_show(gift_cfg, id, privilege_id)
  self.v_id = id
  self.v_privilege_id = privilege_id
  self.v_gift_cfg = gift_cfg
  self.v_end_time = gift_cfg.EndTime and Date.get_time_stamp_by_scheme_id(gift_cfg.EndTime) or 0
  self.v_uicompents.BtnBuy_btn.interactable = true
  self.v_is_weapon = gift_cfg.Paging == ShopCfg.WEAPON_SKIN_GIFT_SHOP_SHELF
  local award = ShareRes.get_award_item_data(gift_cfg.AwardID)
  local skin_cfg
  if self.v_is_weapon then
    skin_cfg = ShareRes.get_weapon_fashion_cfg(award[1][1])
  else
    skin_cfg = ShareRes.get_fashion_cfg(award[1][1])
  end
  local use_spine = not skin_cfg.FullSprite and skin_cfg.ShopSpineId ~= nil
  self:clear_spine_rt()
  self.v_uiobjects.FashionIcon:SetActive(not use_spine and not self.v_is_weapon)
  self.v_uiobjects.FashionSpine:SetActive(use_spine)
  self.v_uiobjects.WeaponIcon:SetActive(self.v_is_weapon)
  local ui_rect
  if use_spine then
    ui_rect = self.v_uicompents.FashionSpine_rect
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.FashionSpine)
    SpineHelper.load_char_spine_res(self.v_spine_rt, skin_cfg.ShopSpineId, self.v_uiobjects.FashionSpine)
  else
    local icon_path = skin_cfg.FullSprite or skin_cfg.Icon[5] or skin_cfg.SpriteId
    local icon_img = self.v_is_weapon and self.v_uicompents.WeaponIcon_img or self.v_uicompents.FashionIcon_img
    ui_rect = icon_img.transform
    ResMgr:load_set_icon(icon_img, icon_path, nil, true, self)
    icon_img:SetNativeSize()
  end
  local param = skin_cfg.ShopItemOffset
  if param then
    ui_rect:SetLocalPositionA(param[1], param[2], param[3])
    ui_rect:SetLocalScaleA(param[4], param[4], param[4])
  end
  self.v_uiobjects.BackBg1:SetActive(1 == skin_cfg.ShopBgType)
  self.v_uiobjects.BackBg2:SetActive(2 == skin_cfg.ShopBgType)
  self.v_uiobjects.WeaponBg:SetActive(3 == skin_cfg.ShopBgType)
  local buddy_name = ShareRes.get_buddy_name(skin_cfg.BuddyId)
  self.v_uicompents.FashionName_txt.text = skin_cfg.Name
  self.v_uicompents.CharName_txt.text = string.format("[%s]", buddy_name)
  self.v_uicompents.FashionDesc_txt.text = skin_cfg.Describe
  self:_show_award(gift_cfg.AwardID)
  self:_set_tips()
  self:_set_time()
end

function ui:_show_award(award_group_id)
  self:give_back_auto_cache(AWARD_ITEM_KEY)
  self:clear_wrap_award()
  self.v_item_list = {}
  local awards = {}
  ShareRes.get_item_obj_use_award_list(award_group_id, awards)
  for _, award_data in ipairs(awards) do
    local item_obj = self:get_auto_cache(AWARD_ITEM_KEY)
    local item = ITEM_OBJ_CLASS:ui_wrap_ex(self, item_obj, true)
    item:set_data(award_data, true, true)
    table.insert(self.v_item_list, item)
  end
end

function ui:_set_tips()
  if not self.v_gift_cfg.EndTime or not self.v_gift_cfg.StateTipTxt then
    self.v_uiobjects.LimitTips:SetActive(false)
    return
  end
  local start_time = 0
  if self.v_gift_cfg.EffectTime then
    start_time = Date.get_time_stamp_by_scheme_id(self.v_gift_cfg.EffectTime) or 0
  end
  local end_time = Date.get_time_stamp_by_scheme_id(self.v_gift_cfg.EndTime) or 0
  local ser_time = Date.server_time()
  self.v_uiobjects.LimitTips:SetActive(start_time < ser_time and end_time > ser_time)
  self.v_uicompents.LimitTipsTxt_txt.text = self.v_gift_cfg.StateTipTxt
  if self.v_gift_cfg.StateTipBg then
    ResMgr:load_set_icon(self.v_uicompents.LimitTipsBg_img, self.v_gift_cfg.StateTipBg)
  end
end

function ui:_set_time()
  self.v_is_end = false
  local has_time = self.v_end_time > 0
  self.v_uiobjects.Time:SetActive(has_time)
  if not has_time then
    return
  end
  self:clear_reset_timer()
  local total_sec = self.v_end_time - Date.server_time()
  if total_sec <= 0 then
    self.v_uiobjects.Time:SetActive(false)
    self.v_is_end = true
    return
  end
  self.v_uicompents.RemainderTime_txt.text = Date.get_time_formate_2(total_sec)
  self.v_reset_timer = CT_Timer:add_timer("reset_timer", total_sec, function(sec)
    if sec > 0 then
      self.v_uicompents.RemainderTime_txt.text = Date.get_time_formate_2(sec)
    else
      self.v_uicompents.RemainderTime_txt.text = Util.format_str("已过期")
      self.v_is_end = true
      self:clear_reset_timer()
    end
  end)
end

function ui:ui_on_hide()
  self:clear_wrap_award()
  self:clear_spine_rt()
  self:clear_reset_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
end

function ui:ui_on_destroy()
  self:clear_wrap_award()
  self:clear_spine_rt()
  self:clear_reset_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:clear_reset_timer()
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
end

function ui:clear_wrap_award()
  if self.v_item_list then
    for key, item in pairs(self.v_item_list) do
      item:ui_hide()
      item:ui_destroy()
      self.v_item_list[key] = nil
    end
    self.v_item_list = nil
  end
end

return ui
