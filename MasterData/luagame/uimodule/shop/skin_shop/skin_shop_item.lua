local Shop_Helper = require("uimodule.shop.shop_helper")
local ShopCfg = require("uimodule.shop.shop_config")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local CT_Timer = Global.ct_timer
local enough_color = Util.CommonColor_White
local not_enough_color = Util.CommonColor_RedWarm
local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self.v_tog = Util.get_toggle(nil, self.v_object)
  self:set_toggle_listener(self.v_tog, function(isOn)
    self:_on_click_tog(isOn)
  end)
  self:set_button("BtnActJump", function()
    self:on_click_jump()
  end)
  self.v_canvas_group = self:get_canvas_group(nil, self.v_object)
end

function ui:on_click_jump()
  if not FashionMgr:check_during_special_jump(self.v_fashion_cfg) then
    self.v_uiobjects.BtnActJump:SetActive(false)
    return
  end
  SysOpenMgr:jump_to_sys(self.v_fashion_cfg.SpecialJumpId, true)
end

function ui:ui_on_show(cfg, ...)
  if not cfg then
    return
  end
end

function ui:ui_on_hide()
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
  if self.v_sq then
    self.v_sq:Kill()
  end
  self:clear_spine_rt()
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
end

function ui:set_linked_parent(parent)
  self.v_linked_parent = parent
end

function ui:set_data(go, data_list, index)
  self.v_gift_cfg = data_list[index]
  self.v_index = index
  self.v_gift_list = data_list
  self.v_is_blank = next(self.v_gift_cfg) == nil
  self.v_is_weapon = self.v_gift_cfg.Paging == ShopCfg.WEAPON_SKIN_GIFT_SHOP_SHELF
  self.v_canvas_group.alpha = 0
  self.v_uiobjects.DefaultJumpBg:SetActive(self.v_is_blank)
  self.v_uiobjects.SkinContent:SetActive(not self.v_is_blank)
  if not self.v_is_blank then
    self:_set_goods_info()
    self:_set_tips()
    self:_set_time()
    self:_set_discount()
    self:_set_goods_state()
  end
  self.v_tog.isOn = false
  self:_set_ani(index)
  self:unbind_all_auto_mq()
end

function ui:_set_goods_info()
  local award = ShareRes.get_award_item_data(self.v_gift_cfg.AwardID)
  if self.v_is_weapon then
    self.v_fashion_cfg = ShareRes.get_weapon_fashion_cfg(award[1][1])
    self.v_has_fashion = FashionMgr:has_weapon_fashion(self.v_fashion_cfg.Id)
  else
    self.v_fashion_cfg = ShareRes.get_fashion_cfg(award[1][1])
    self.v_has_fashion = FashionMgr:check_has_bought_fashion(self.v_fashion_cfg.Id)
  end
  self:_set_fashion_main_img()
  self:_set_fashion_bg()
  self:_set_fashion_suit_weapon()
  self:_set_weapon_owner_icon()
  self:_set_price()
end

function ui:_set_fashion_main_img()
  local skin_cfg = self.v_fashion_cfg
  local use_spine = not skin_cfg.FullSprite and skin_cfg.ShopSpineId ~= nil
  self:clear_spine_rt()
  self.v_uiobjects.FashionIcon:SetActive(not use_spine and not self.v_is_weapon)
  self.v_uiobjects.FashionSpine:SetActive(use_spine and not self.v_is_weapon)
  self.v_uiobjects.FashionIcon_Weapon:SetActive(self.v_is_weapon)
  self.v_uiobjects.WeaponChar:SetActive(self.v_is_weapon)
  self.v_uiobjects.BtnActJump:SetActive(FashionMgr:check_during_special_jump(skin_cfg))
  local ui_rect
  if use_spine then
    ui_rect = self.v_uicompents.FashionSpine_rect
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.FashionSpine)
    SpineHelper.load_char_spine_res(self.v_spine_rt, skin_cfg.ShopSpineId, self.v_uiobjects.FashionSpine)
  else
    local icon_img = self.v_is_weapon and self.v_uicompents.FashionIcon_Weapon_img or self.v_uicompents.FashionIcon_img
    local icon_path = skin_cfg.FullSprite or skin_cfg.Icon[5] or skin_cfg.SpriteId
    ui_rect = icon_img.transform
    ResMgr:load_set_icon(icon_img, icon_path, nil, true, self)
    icon_img:SetNativeSize()
  end
  local param = skin_cfg.ShopItemOffset
  local x, y, z, scale, rotate = 0, 0, 0, 1, 0
  if param then
    x, y, z, scale, rotate = param[1] or 0, param[2] or 0, param[3] or 0, param[4] or 1, param[5] or 0
  end
  ui_rect:SetLocalPositionA(x, y, z)
  ui_rect:SetLocalScaleA(scale, scale, scale)
  ui_rect:SetLocalEuler(0, 0, rotate)
end

function ui:_set_fashion_bg()
  local shop_bg_type = self.v_fashion_cfg.ShopBgType
  self.v_uicompents.FashionName_txt.text = self.v_fashion_cfg.Name
  self.v_uicompents.CharName_txt.text = ShareRes.get_buddy_name(self.v_fashion_cfg.BuddyId)
  self.v_uiobjects.BackBg1:SetActive(1 == shop_bg_type)
  self.v_uiobjects.BackBg2:SetActive(2 == shop_bg_type)
  self.v_uiobjects.BackBg3:SetActive(3 == shop_bg_type)
  self.v_uiobjects.FrontBg1:SetActive(1 == shop_bg_type)
  self.v_uiobjects.FrontBg2:SetActive(2 == shop_bg_type)
  self.v_uiobjects.FrontBg3:SetActive(3 == shop_bg_type)
end

function ui:_set_fashion_suit_weapon()
  local has_suit_weapon = self.v_fashion_cfg.ShopWeaponIcon ~= nil
  self.v_uiobjects.FashionWeapon:SetActive(has_suit_weapon)
  if has_suit_weapon then
    ResMgr:load_set_icon(self.v_uicompents.WeaponIcon_img, self.v_fashion_cfg.ShopWeaponIcon, nil, true)
  end
end

function ui:_set_weapon_owner_icon()
  self.v_uiobjects.WeaponChar:SetActive(self.v_is_weapon)
  if self.v_is_weapon then
    local path = UtilUI.get_hero_images(self.v_fashion_cfg.BuddyId, 1)
    ResMgr:load_set_icon(self.v_uicompents.CharIcon_img, path)
  end
end

function ui:_set_price()
  local has_discount = self.v_gift_cfg.Discount ~= nil
  self.v_uiobjects.PriceBefore:SetActive(has_discount)
  self.v_uiobjects.CurrIcon:SetActive(not self.v_gift_cfg.ShowPrice and self.v_gift_cfg.CostItem)
  if self.v_gift_cfg.CostItem then
    ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, Shop_Helper.get_item_icon(self.v_gift_cfg.CostItem))
    local cur_price = self.v_gift_cfg.CostItemNum
    local origin_pricce = has_discount and self.v_gift_cfg.Discount or cur_price
    local is_enough = BagMgr:get_cost_enough(self.v_gift_cfg.CostItem, cur_price)
    self.v_uicompents.Price_txt.text = self.v_gift_cfg.CostItemNum
    self.v_uicompents.Price_txt.color = is_enough and enough_color or not_enough_color
    self.v_uicompents.PriceBefore_txt.text = origin_pricce
  elseif self.v_gift_cfg.ShowPrice then
  else
    self.v_price_num.text = Util.format_str("免费")
    self.v_uicompents.Price_txt.color = enough_color
  end
end

function ui:_set_goods_state()
  self.v_uiobjects.Owned:SetActive(self.v_has_fashion)
  self.v_uiobjects.NotOwned:SetActive(not self.v_has_fashion)
end

function ui:_set_tips()
  if not (self.v_gift_cfg.EndTime and self.v_gift_cfg.StateTipTxt) or self.v_has_fashion then
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
  local end_time = 0
  if self.v_gift_cfg.EffectTime then
    end_time = Date.get_time_stamp_by_scheme_id(self.v_gift_cfg.EffectTime) or 0
  end
  if end_time - Date.server_time() <= 0 and self.v_gift_cfg.EndTime then
    end_time = Date.get_time_stamp_by_scheme_id(self.v_gift_cfg.EndTime) or 0
  end
  local has_time = end_time > 0 and not self.v_has_fashion
  self.v_uiobjects.Time:SetActive(has_time)
  if not has_time then
    return
  end
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
  local total_sec = end_time - Date.server_time()
  if total_sec <= 0 then
    self.v_uiobjects.Time:SetActive(false)
    return
  end
  self.v_uicompents.RemainderTime_txt.text = Date.get_time_formate_2(total_sec)
  self.v_reset_timer = CT_Timer:add_timer("reset_timer", total_sec, function(sec)
    if sec > 0 then
      self.v_uicompents.RemainderTime_txt.text = Date.get_time_formate_2(sec)
    else
      if self.v_reset_timer then
        CT_Timer:remove_timer(self.v_reset_timer)
        self.v_reset_timer = nil
      end
      MsgGame:mq_publish2(Const.MSG_ON_TIME_CUT_FINISH)
    end
  end)
end

function ui:_set_discount()
  local has_tag = self.v_gift_cfg.ShowTag ~= nil
  self.v_uiobjects.DiscountBg:SetActive(has_tag)
  if not has_tag then
    return
  end
  local tag_cfg = ShareRes.create("recharge.gift_tag", self.v_gift_cfg.ShowTag)
  if tag_cfg.TagBgIcon and tag_cfg.TagBgIcon ~= "" then
    ResMgr:load_set_icon(self.v_uicompents.DiscountBg_img, tag_cfg.TagBgIcon, nil, false)
  end
  self.v_uiobjects.DiscountNum:SetActive(nil ~= self.v_gift_cfg.Discount)
  self.v_uiobjects.DiscountDesc:SetActive(nil == self.v_gift_cfg.Discount)
  if self.v_gift_cfg.Discount then
    local lab = self.v_gift_cfg.Discount
    self.v_uicompents.Discount_txt.text = lab
  else
    local lab = tag_cfg.Name
    self.v_uicompents.DiscountDesc_txt.text = lab
  end
end

function ui:_set_ani(index)
  if self.v_sq then
    self.v_sq:Kill()
  end
  if not self.v_linked_parent:get_need_ani() then
    self.v_canvas_group.alpha = 1
    return
  end
  self.v_sq = Util.create_sequence()
  self.v_sq:AppendInterval(0.05 * index)
  self.v_sq:Append(self.v_canvas_group:DOFade(1, 0.1))
end

function ui:_on_click_tog(isOn)
  if not isOn then
    return
  end
  if self.v_is_blank then
    UIMgr:get_ui("fashion_book"):ui_show()
  else
    local award_id = self.v_gift_list[self.v_index].AwardID
    if not award_id then
      Log.Error("时装礼包奖励配置AwardID为空", self.v_gift_list[self.v_index])
      return
    end
    local award = ShareRes.get_award_item_data(award_id)
    local fashion_id = award[1][1]
    if self.v_is_weapon then
      UIMgr:get_ui("ui_fashionable_dress_shop"):ui_show(nil, fashion_id, self.v_gift_list[self.v_index])
    else
      UIMgr:get_ui("ui_fashionable_dress_shop"):ui_show(fashion_id, nil, self.v_gift_list[self.v_index])
    end
  end
end

function ui:play_in_eff()
  self.v_object:SetActive(true)
end

function ui:eff_init()
  self.v_object:SetActive(false)
end

function ui:is_visible_item()
  return self.v_visible
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

return ui
