local Base = require("ui.uiobject")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local GoodsItemClass = require("uimodule.battle_bag.battle_item")
local ItemInfoClass = require("uimodule.battle_bag.item_info")
local EquipInfoClass = require("uimodule.battle_bag.equip_item_info")
local Fight_Item_Helper = require("uimodule.fight_bag.fight_item_helper")
local Item_Helper = require("utils.item_helper")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_panel_rect = {
    "InfoPanel",
    BIND_TYPE.TRANSFORM
  },
  v_item_mask_rect = {
    "Mask",
    BIND_TYPE.TRANSFORM
  },
  v_talent_mask = {
    "TalentMask",
    BIND_TYPE.OBJECT
  },
  v_suit_mask = {
    "SuitMask",
    BIND_TYPE.OBJECT
  },
  v_item_obj = {
    "ItemObj",
    BIND_TYPE.OBJECT
  },
  v_item_name = {
    "ItemName",
    BIND_TYPE.TEXT
  },
  v_item_type = {
    "ItemType",
    BIND_TYPE.TEXT
  },
  v_equip_lv = {
    "EquipLv",
    BIND_TYPE.TEXT
  },
  v_item_info = {
    "ItemInfo",
    BIND_TYPE.OBJECT
  },
  v_talent_info = {
    "TalentInfo",
    BIND_TYPE.OBJECT
  },
  v_suit_info = {
    "SuitInfo",
    BIND_TYPE.OBJECT
  },
  v_equip_info = {
    "EquipInfo",
    BIND_TYPE.OBJECT
  },
  v_talent_pos_obj = {
    "TalentPos",
    BIND_TYPE.TRANSFORM
  },
  v_suit_pos_obj = {
    "SuitPos",
    BIND_TYPE.TRANSFORM
  },
  v_sold_panel = {
    "SoldPanel",
    BIND_TYPE.OBJECT
  },
  v_buy_panel = {
    "BuyPanel",
    BIND_TYPE.OBJECT
  },
  v_use_panel = {
    "UsePanel",
    BIND_TYPE.OBJECT
  },
  v_amout_panel = {
    "AmountPanel",
    BIND_TYPE.OBJECT
  },
  v_price_panel = {
    "PricePanel",
    BIND_TYPE.OBJECT
  },
  v_price_obj = {
    "PriceObj",
    BIND_TYPE.TRANSFORM
  },
  v_price_pos1 = {
    "PricePos1",
    BIND_TYPE.TRANSFORM
  },
  v_price_pos2 = {
    "PricePos2",
    BIND_TYPE.TRANSFORM
  },
  v_item_price = {
    "ItemPrice",
    BIND_TYPE.TEXT
  },
  v_select_num = {
    "SelectAmount",
    BIND_TYPE.TEXT
  },
  v_sold_btn = {
    "SoldBtn",
    BIND_TYPE.BUTTON
  },
  v_buy_btn = {
    "BuyBtn",
    BIND_TYPE.BUTTON
  }
}
local ORIGHT_POS_Y = -233
local MASK_SHOW_TYPE = {
  NONE = 1,
  MASK = 2,
  SUIT_MASK = 3,
  TALENT_MASK = 4
}
local TIPS_TYPE = {
  NONE = 1,
  USE_TIPS = 2,
  BUY_TIPS = 3,
  SOLD_TIPS = 4
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("Mask", function()
    self:_onclick_close_btn()
  end)
  for i = 1, 4 do
    local tb = self:get_button("Mask" .. i, self.v_talent_mask)
    self:set_button_listener(tb, function()
      self:_onclick_close_btn()
    end)
  end
  for i = 1, 4 do
    local tb = self:get_button("Mask" .. i, self.v_suit_mask)
    self:set_button_listener(tb, function()
      self:_onclick_close_btn()
    end)
  end
  self:set_button("SoldBtn", function()
    self:_onclick_sold()
  end)
  self:set_button("BuyBtn", function()
    self:_onclick_buy()
  end)
  self:set_button("BtnMax", function()
    self:_onclick_max_btn()
  end)
  self:set_button("BtnAdd", function()
    self:_onclick_add_btn()
  end)
  self:set_button("BtnReduce", function()
    self:_onclick_reduce_btn()
  end)
  self:set_button("BtnUse", function()
    self:_onclick_use_btn()
  end)
  self.v_talent_pos = self.v_talent_pos_obj.anchoredPosition
  self.v_suit_pos = self.v_suit_pos_obj.anchoredPosition
  self.v_item_view = GoodsItemClass:ui_wrap(self, self.v_item_obj)
  self.v_item_info_view = ItemInfoClass:ui_wrap(self, self.v_item_info, false)
  self.v_equip_info_view = EquipInfoClass:ui_wrap(self, self.v_equip_info, false)
  self.v_layouts = self.v_object:GetComponentsInChildren(typeof(UnityEngine.UI.VerticalLayoutGroup))
  self.v_fitters = self.v_object:GetComponentsInChildren(typeof(UnityEngine.UI.ContentSizeFitter))
end

function ui:ui_on_show(item_id, param, ...)
  if not item_id then
    return
  end
  if not param then
    Log.Error("param is nil", item_id)
    Log.Error(debug.traceback())
  end
  self.v_item_id = item_id
  self.v_param = param
  self.v_item_cfg = param.item_data and param.item_data.Cfg or Item_Helper.get_item_cfg(item_id)
  self.v_item_data = param.item_data
  if param.formation_type then
    self.v_formation_type = param.formation_type
  end
  self.v_tip_source = param.tips_source and param.tips_source or BagCfg.TIPS_SOURCE.BAG
  self.v_bag_source = param.bag_source
  self.v_item_go = param.go
  self.v_is_collect = Item_Helper.get_is_collect(self.v_item_id)
  self.v_is_equip_collect = Item_Helper.get_is_equip_collect(self.v_item_id)
  self.v_is_consume = self.v_item_cfg.Type == BagCfg.CONSUMABLES_ITEM_TYPE.Type and self.v_item_cfg.Subtype == BagCfg.CONSUMABLES_ITEM_TYPE.SubType
  self:_refresh_data()
  self:_regist_client_event()
  self.v_times = 0
end

function ui:ui_on_update()
end

function ui:ui_on_hide()
  self.v_item_info_view:set_enable(false)
  self.v_item_view:set_enable(false)
  self.v_equip_info_view:set_enable(false)
  self.v_use_hero = nil
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_CLICK_RING_HERO_ITEM, self.response_click_hero_event, self)
end

function ui:response_click_hero_event(msg)
  if self.v_use_hero and self.v_use_hero.uuid == msg.mm_obj.uuid then
    return
  end
  self.v_use_hero = msg.mm_obj
end

function ui:_refresh_data()
  local mask_type = self:_get_mask_show_type()
  local tips_type = self:_get_tips_type()
  self.v_tips_type = tips_type
  local item_param
  if self.v_tip_source == BagCfg.TIPS_SOURCE.BAG then
    item_param = {
      show_num = FightBagMgr:get_grid_stack_num(self.v_item_data.uuid),
      item_data = self.v_item_data
    }
  else
    item_param = {
      show_num = self.v_param.show_num
    }
  end
  self.v_item_view:set_enable(false, self.v_item_id, item_param)
  self.v_item_num = item_param.show_num
  self.v_item_name.text = self.v_item_cfg.Name
  self.v_equip_lv:SetActive(false)
  if self.v_is_collect then
    self.v_item_type.text = Util.format_str("收藏品")
  else
    local cfg = ShareRes.create("battle.battle_item_type", self.v_item_cfg.Type)
    self.v_item_type.text = cfg.name
  end
  self.v_use_hero = nil
  self:_select_hero()
  self.v_item_info_view:set_enable(not self.v_is_collect, self.v_item_id)
  self:_refresh_operate_panel(tips_type)
  self:_refresh_mask(mask_type)
  self:_set_layout()
  self:_refresh_desc_panel(tips_type)
end

function ui:_refresh_operate_panel(tips_type)
  self.v_sold_panel:SetActive(tips_type == TIPS_TYPE.SOLD_TIPS)
  self.v_buy_panel:SetActive(tips_type == TIPS_TYPE.BUY_TIPS)
  self.v_use_panel:SetActive(tips_type == TIPS_TYPE.USE_TIPS)
  self.v_sold_btn.enabled = true
  self.v_buy_btn.enabled = true
  if tips_type == TIPS_TYPE.SOLD_TIPS then
    self.v_sell_price = self:_get_sold_price(self.v_item_data)
  elseif tips_type == TIPS_TYPE.BUY_TIPS then
    self.v_buy_price = BattleShopMgr:get_buy_price_by_item_id(self.v_item_id) * self.v_param.show_num
  end
  local show_price = tips_type == TIPS_TYPE.SOLD_TIPS or tips_type == TIPS_TYPE.BUY_TIPS
  if show_price then
    local parent = tips_type == TIPS_TYPE.SOLD_TIPS and self.v_sold_panel.transform or self.v_buy_panel.transform
    self.v_price_panel.transform:SetParent(parent)
    self.v_price_panel.transform:ResetAttr()
  end
  self.v_price_panel:SetActive(show_price)
  local show_amount = self.v_is_consume and (tips_type == TIPS_TYPE.SOLD_TIPS or tips_type == TIPS_TYPE.USE_TIPS)
  self.v_amout_panel:SetActive(show_amount)
  self.v_use_num = 1
  self.v_select_num.text = 1
  if self.v_price_panel.activeSelf then
    self.v_item_price.text = tips_type == TIPS_TYPE.SOLD_TIPS and self.v_use_num * self.v_sell_price or self.v_use_num * self.v_buy_price
  end
end

function ui:_refresh_mask(mask_type)
  self.v_item_mask_rect:SetActive(mask_type == MASK_SHOW_TYPE.MASK)
  self.v_talent_mask:SetActive(mask_type == MASK_SHOW_TYPE.TALENT_MASK)
  self.v_suit_mask:SetActive(mask_type == MASK_SHOW_TYPE.SUIT_MASK)
end

function ui:_refresh_desc_panel(tips_type)
  self.v_equip_info_view:set_enable(false)
  self.v_panel_rect:SetAnchoredPositionA(0, ORIGHT_POS_Y, 0)
  if self.v_is_collect then
    self.v_equip_info_view:set_enable(true, self.v_item_data)
  end
  if self.v_tip_source == BagCfg.TIPS_SOURCE.BAG then
    local bag_interval_x = 196
    local limit_diff_x = 563
    local limit_diff_y = 40
    local bag_interval_y = 68
    if self.v_is_equip_collect then
      bag_interval_y = 130
      limit_diff_x = 693
    end
    self:_refresh_item_info_pos(bag_interval_x, bag_interval_y, limit_diff_x, limit_diff_y)
  end
end

function ui:_refresh_item_info_pos(interval_x, interval_y, limit_diff_x, limit_diff_y)
  local height = self.v_panel_rect.sizeDelta.y
  self.v_panel_rect.transform.position = self.v_item_go.transform.position
  local item_rect = Util.get_rect_transform(nil, self.v_item_go.transform)
  local item_height = item_rect.sizeDelta.y
  local diff_x = interval_x
  local diff_y = interval_y
  local x = self.v_panel_rect.anchoredPosition.x + diff_x
  local y = self.v_panel_rect.anchoredPosition.y + diff_y
  self.v_panel_rect:SetAnchoredPositionA(x, y)
  local right_rect = Util.get_rect_transform(nil, self.v_uiobjects.Right)
  local right_pos = UIMgr.root_camera:WorldToScreenPoint(right_rect.position)
  local bottom_rect = Util.get_rect_transform(nil, self.v_uiobjects.Bottom)
  local bottom_pos = UIMgr.root_camera:WorldToScreenPoint(bottom_rect.position)
  if right_pos.x > Global.screen_width then
    x = x - limit_diff_x
  end
  if bottom_pos.y - height < -Global.screen_height / 2 + item_height then
    y = y + height - item_height + limit_diff_y
  end
  self.v_panel_rect:SetAnchoredPositionA(x, y)
end

function ui:_onclick_close_btn()
  self:set_enable(false)
  MsgGame:mq_publish2(Const.MSG_ON_CLOSE_RING_BAG_ITEM_TIPS)
end

function ui:_get_mask_show_type()
  if self.v_tip_source ~= BagCfg.TIPS_SOURCE.BAG then
    return MASK_SHOW_TYPE.NONE
  end
  if not self.v_is_collect then
    return MASK_SHOW_TYPE.MASK
  end
  if self.v_item_cfg.Type == BagCfg.CollectType.COMMON then
    return MASK_SHOW_TYPE.TALENT_MASK
  else
    return MASK_SHOW_TYPE.NONE
  end
end

function ui:_get_tips_type()
  if self.v_bag_source == BagCfg.BAG_SOURCE.SHOP then
    if self.v_item_cfg.Type == BagCfg.CollectType.EQUIP then
      return TIPS_TYPE.NONE
    end
    return TIPS_TYPE.SOLD_TIPS
  end
  if self.v_tip_source == BagCfg.TIPS_SOURCE.SHOP then
    if self.v_item_cfg.Type == BagCfg.CollectType.EQUIP and FightBagMgr:has_same_type_equip(self.v_item_id) then
      return TIPS_TYPE.NONE
    end
    if not self.v_param.has_buy then
      return TIPS_TYPE.BUY_TIPS
    end
  end
  if self.v_is_collect then
    if self.v_item_cfg.Type == BagCfg.CollectType.EQUIP then
      if self.v_tip_source == BagCfg.TIPS_SOURCE.BAG then
        return TIPS_TYPE.NONE
      end
      return TIPS_TYPE.NONE
    end
  else
    if self.v_tip_source ~= BagCfg.TIPS_SOURCE.BAG then
      return TIPS_TYPE.NONE
    end
    if self.v_is_consume or Item_Helper.get_is_use_item(self.v_item_id) and not self:_get_has_used(self.v_item_data.uuid) then
      return TIPS_TYPE.USE_TIPS
    end
  end
  return TIPS_TYPE.NONE
end

function ui:_select_hero()
  if self.v_tips_type ~= TIPS_TYPE.USE_TIPS then
    return
  end
  if not self.v_formation_type then
    return
  end
  if self.v_is_collect then
    return
  end
  if not self.v_is_consume then
    return
  end
  local list = SceneMgr:get_hero_list()
  local cur_fight_pos, team_list = FormationMgr:get_formation_info_by_id(self.v_formation_type)
  if not team_list or not list then
    return
  end
  local first_hero, choose_hero
  for _, team in ipairs(team_list) do
    if 0 ~= team.buddy_id then
      for _, hero in pairs(list) do
        if hero:is_die() == false and hero.buddy_cfg.ModelId == team.buddy_id then
          first_hero = first_hero or hero
          if Fight_Item_Helper.check_can_use(self.v_item_id, {role = hero, num = 1}, true) then
            choose_hero = hero
          end
        end
        if choose_hero then
          break
        end
      end
    end
    if choose_hero then
      break
    end
  end
  if self.v_item_cfg.Arg[2] == Item_Helper.Effect_Range.Team then
    MsgGame:mq_publish2(Const.MSG_ON_CHOOSE_ALL_HERO_ITEM)
  else
    local msg = MsgGame:mq_publish2(Const.MSG_ON_CHOOSE_HERO_ITEM)
    msg.mm_x = choose_hero and choose_hero.uuid or first_hero.uuid
    msg.mm_obj = self.v_item_data
  end
  self.v_use_hero = choose_hero and choose_hero or first_hero
end

function ui:_onclick_sold()
  if self.v_tip_source == BagCfg.TIPS_SOURCE.OTHER then
  else
    self:_sold_item_in_bag()
  end
end

function ui:_sold_item_in_bag()
  local submit_data = {
    id = self.v_item_id,
    uuid = self.v_item_data.uuid,
    count = self.v_use_num
  }
  
  local function cb()
    local msg = MsgGame:mq_publish2(Const.MSG_ON_SHOP_ITEM_SELL)
    msg.mm_x = self.v_item_data.uuid
    self:_onclick_close_btn()
  end
  
  if self.v_is_equip_collect then
    BattleShopMgr:sell_battle_shop_equip_item(submit_data, true, cb)
  else
    BattleShopMgr:sell_battle_shop_item(submit_data, cb)
  end
end

function ui:_onclick_buy()
  if self.v_use_num * self.v_buy_price > CharacterMgr:get_res_val(BagCfg.CURRENCY[1]) then
    Util.show_message_tip(2106)
    self:_onclick_close_btn()
    return
  end
  
  local function cb()
    local msg = MsgGame:mq_publish2(Const.MSG_ON_SHOP_ITEM_BUY)
    msg.mm_x = self.v_param.buy_idx
    self:_onclick_close_btn()
  end
  
  if self.v_is_equip_collect then
    BattleShopMgr:buy_battle_shop_equip_item(self.v_param.buy_idx, true, cb)
  else
    BattleShopMgr:buy_battle_shop_item(self.v_param.buy_idx, cb)
  end
end

function ui:_onclick_use_btn()
  local is_use_story_item, story_id = Item_Helper.check_use_story_item(self.v_item_id)
  if is_use_story_item and story_id then
    UIMgr:get_ui("desc_story"):ui_show(story_id)
    return
  end
  if not self:_get_in_fight() then
    Util.show_message_tip(2108)
    self:_onclick_close_btn()
    return
  end
  local is_buff_item = Item_Helper.get_is_use_item(self.v_item_id)
  if is_buff_item then
    self.v_use_hero = Global.hero
  end
  if not self.v_use_hero then
    Util.show_message_tip(2109)
    return
  end
  local can_use = true
  if not is_buff_item then
    can_use = Fight_Item_Helper.check_can_use(self.v_item_id, {
      role = self.v_use_hero,
      num = self.v_use_num
    })
  end
  if not can_use then
    return
  end
  FightBagMgr:request_use_item(self.v_use_hero, self.v_item_data, self.v_use_num, function()
    self:_onclick_close_btn()
  end, true)
end

function ui:_onclick_max_btn()
  if self.v_item_id == nil then
    Log.Error("没有物品数据！！！！")
    return
  end
  local can_click = true
  local bag_max = self.v_item_num
  if self.v_tips_type == TIPS_TYPE.SOLD_TIPS then
    if self.v_use_num == bag_max then
      Util.show_message_tip(2110)
      can_click = false
    end
    self.v_use_num = bag_max
  else
    local max = math.min(bag_max, self:get_used_max_num())
    if self.v_use_num == max then
      Util.show_message_tip(2111)
      can_click = false
    end
    self.v_use_num = max
  end
  if not can_click then
    return
  end
  self.v_select_num.text = self.v_use_num
  if self.v_bag_source == BagCfg.BAG_SOURCE.SHOP then
    self.v_item_price.text = self.v_use_num * self.v_sell_price
  end
end

function ui:_onclick_add_btn()
  if self.v_item_id == nil then
    Log.Error("没有物品数据！！！！")
    return
  end
  local can_click = true
  local bag_max = self.v_item_num
  if self.v_tips_type == TIPS_TYPE.SOLD_TIPS then
    if self.v_use_num == bag_max then
      Util.show_message_tip(2110)
      can_click = false
    end
  else
    local max = math.min(bag_max, self:get_used_max_num())
    if self.v_use_num == max then
      Util.show_message_tip(2111)
      can_click = false
    end
  end
  if not can_click then
    return
  end
  self.v_use_num = self.v_use_num + 1
  self.v_select_num.text = self.v_use_num
  if self.v_bag_source == BagCfg.BAG_SOURCE.SHOP then
    self.v_item_price.text = self.v_use_num * self.v_sell_price
  end
end

function ui:_onclick_reduce_btn()
  if self.v_item_id == nil then
    Log.Error("没有物品数据！！！！")
    return
  end
  local can_click = true
  if 1 == self.v_use_num then
    if self.v_tips_type == TIPS_TYPE.SOLD_TIPS then
      Util.show_message_tip(2112)
    else
      Util.show_message_tip(2113)
    end
    can_click = false
  end
  if not can_click then
    return
  end
  self.v_use_num = self.v_use_num - 1
  self.v_select_num.text = self.v_use_num
  if self.v_bag_source == BagCfg.BAG_SOURCE.SHOP then
    self.v_item_price.text = self.v_use_num * self.v_sell_price
  end
end

function ui:get_used_max_num()
  local range = Item_Helper.get_effect_range(self.v_item_id)
  if range == Item_Helper.Effect_Range.Single then
    return math.max(Fight_Item_Helper.get_used_max_num(self.v_use_hero, self.v_item_id), 1)
  else
    local num = 0
    local list = SceneMgr:get_hero_list()
    for _, hero in pairs(list) do
      if not hero:is_die() then
        local cur = Fight_Item_Helper.get_used_max_num(hero, self.v_item_id)
        if num < cur then
          num = cur
        end
      end
    end
    return math.max(num, 1)
  end
end

function ui:_get_in_fight()
  local tower = TowerMgr:get_tower()
  if tower and tower:is_challenge_ring_tower() then
    return tower:get_room():is_get_all_drop_item()
  else
    local is_pass = tower:is_pass_room(tower:get_room_num())
    return is_pass
  end
end

function ui:_get_sold_price(item_data)
  local item_id = item_data.id
  local price = BattleShopMgr:get_sell_price_by_item_id(item_id)
  local buffs = FightBagMgr:get_item_buffs()
  for _, v in pairs(buffs) do
    if v.buff_cfg.Type == BagCfg.ITEM_BUFF_TYPE.ITEM_STOCK and v.arg[1].value == item_data.uuid then
      local cur_round = ChallengeRingMgr:get_cur_round()
      if v.arg[3] then
        local reduce_round = cur_round - v.arg[3].value + 1
        local add_round = v.arg[3].value - v.arg[2].value - 1
        return math.max(0, price + v.buff_cfg.Arg[3] * (add_round - reduce_round))
      else
        return math.max(0, price + v.buff_cfg.Arg[3] * (cur_round - v.arg[2].value))
      end
    end
  end
  local extra = 0
  for _, v in pairs(buffs) do
    if v.buff_cfg.Type == BagCfg.ITEM_BUFF_TYPE.RECYCLE_ADD_MONEY then
      local effect_cfg = ShareRes.create("battle.battle_buff_effect", v.buff_cfg.Arg[1])
      if effect_cfg then
        for _, t in pairs(effect_cfg.Arg) do
          if t == item_id then
            extra = extra + Item_Helper.get_new_rune_lv(v.buff_cfg.Arg[2]) * v.buff_cfg.Arg[3]
          end
        end
      end
    end
  end
  return math.floor(price + extra)
end

function ui:_set_layout()
  for i = 0, self.v_layouts.Length - 1 do
    self.v_layouts[i]:SetLayoutVertical()
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_layouts[i].transform)
  end
  for i = 0, self.v_fitters.Length - 1 do
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_fitters[i].transform)
  end
end

function ui:_get_has_used(uuid)
  local buffs = FightBagMgr:get_item_buffs()
  for _, v in pairs(buffs) do
    if v.buff_cfg.Type == BagCfg.ITEM_BUFF_TYPE.ITEM_STOCK and v.arg[1].value == uuid then
      return true
    end
  end
  return false
end

return ui
