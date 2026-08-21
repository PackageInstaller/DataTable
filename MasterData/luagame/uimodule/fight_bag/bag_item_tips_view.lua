local Base = require("ui.uiobject")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local Item_Helper = require("uimodule.fight_bag.fight_item_helper")
local bagConfig = require("gamelogic.character.fight_bag_configs")
local ui = Util.create_child_mt(Base)
local ITEM_QUALITY_PATH = "Icon/BattleCommon/Ba_%dx"
local ITEM_ICON_PATH = "Icon/BattleItem/%s"
local ITEM_SIZE = {150, 150}

function ui:ui_finish_load()
  self:set_button("Mask", function()
    self:_onclick_close_btn()
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
  self.v_info_rect = self:get_rect_transform(nil, self.v_uiobjects.InfoPanel)
  self.v_info_size = {
    x = self.v_info_rect.rect.width,
    y = self.v_info_rect.rect.height
  }
  self.v_location = {
    [1] = self:get_rect_transform(nil, self.v_uiobjects.Up),
    [2] = self:get_rect_transform(nil, self.v_uiobjects.Left),
    [3] = self:get_rect_transform(nil, self.v_uiobjects.Down),
    [4] = self:get_rect_transform(nil, self.v_uiobjects.Right)
  }
  self.v_pivot_height = self.v_info_rect.anchoredPosition.y
end

function ui:ui_on_show(data, ...)
  if not data then
    self:_onclick_close_btn()
    return
  end
  self.v_hero = data.hero
  self:_set_tips_pos(data.bag_pos)
  self:set_data(data.item)
  self:_regist_client_event()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_CLICK_HERO, self.response_click_hero_event, self)
end

function ui:response_click_hero_event(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  self.v_hero = msg.mm_obj.hero
end

function ui:_set_tips_pos(pos)
  self.v_info_rect.position = pos
  local anchoredPosition = self.v_info_rect.anchoredPosition
  self.v_info_rect:SetAnchoredPositionA(anchoredPosition.x + self.v_info_size.x / 2 + ITEM_SIZE[1], anchoredPosition.y - self.v_info_size.y / 2)
  local position = Global.ui_mgr.root_camera:WorldToScreenPoint(self.v_location[4].position)
  if position.x >= Global.screen_width then
    anchoredPosition = self.v_info_rect.anchoredPosition
    self.v_info_rect:SetAnchoredPositionA(anchoredPosition.x - self.v_info_size.x - ITEM_SIZE[1], anchoredPosition.y)
  end
  position = Global.ui_mgr.root_camera:WorldToScreenPoint(self.v_location[3].position)
  if position.y < 0 then
    anchoredPosition = self.v_info_rect.anchoredPosition
    self.v_info_rect:SetAnchoredPositionA(anchoredPosition.x, self.v_pivot_height)
  end
end

function ui:set_data(data)
  self.v_data = data
  local components = self.v_uicompents
  components.ItInfoName_txt.text = self.v_data.Name
  components.ItInfoQuatlity_img.color = BagCfg.Quality_Color[self.v_data.Quality]
  ResMgr:load_set_icon(components.ItInfoIcon_img, string.format(ITEM_ICON_PATH, self.v_data.Icon))
  local had_count = FightBagMgr:get_item_num_by_id(self.v_data.id)
  components.ItInfoAmount_txt.text = had_count
  local desc = ""
  if self.v_data.Cfg.Desc ~= nil and "" ~= self.v_data.Cfg.Desc then
    desc = self.v_data.Cfg.Desc
  else
    desc = Util.format_str("无")
  end
  components.ItInfoDesc1_txt.text = desc
  if nil ~= self.v_data.Cfg.WorldDesc and "" ~= self.v_data.Cfg.WorldDesc then
    desc = self.v_data.Cfg.WorldDesc
  else
    desc = Util.format_str("无")
  end
  components.ItInfoDesc2_txt.text = desc
  local item_type_cfg = ShareRes.create("battle.battle_item_type")
  local show = item_type_cfg[self.v_data.Type].type == BagCfg.CONSUMABLES
  components.CostItem_img.gameObject:SetActiveEx(show)
  components.BtnUse_btn.gameObject:SetActiveEx(show)
  self.v_use_num = 1
  components.SelectAmount_txt.text = self.v_use_num
end

function ui:_onclick_close_btn()
  MsgGame:mq_publish2(Const.MSG_ON_CLOSE_FIGHT_ITEM_TIPS)
  self:set_enable(false)
end

function ui:_onclick_use_btn()
  local tower = TowerMgr:get_tower()
  local is_pass = tower:is_pass_room(tower:get_room_num())
  if false == is_pass then
    Util.show_message_tip(2108)
    self:_onclick_close_btn()
    return
  end
  if not Item_Helper.check_can_use(self.v_data.id, {
    role = self.v_hero,
    num = self.v_use_num
  }) then
    return
  end
  FightBagMgr:request_use_item(self.v_hero, self.v_data, self.v_use_num, function()
    self:_onclick_close_btn()
  end)
end

function ui:_onclick_max_btn()
  if self.v_data == nil then
    Log.Error("没有物品数据！！！！")
    return
  end
  if self.v_use_num == FightBagMgr:get_item_num_by_id(self.v_data.id) then
    Util.show_message_tip(2183)
    return
  end
  self.v_use_num = FightBagMgr:get_item_num_by_id(self.v_data.id)
  self.v_uicompents.SelectAmount_txt.text = self.v_use_num
end

function ui:_onclick_add_btn()
  if self.v_data == nil then
    Log.Error("没有物品数据！！！！")
    return
  end
  if self.v_use_num == FightBagMgr:get_item_num_by_id(self.v_data.id) then
    Util.show_message_tip(2183)
    return
  end
  self.v_use_num = self.v_use_num + 1
  self.v_uicompents.SelectAmount_txt.text = self.v_use_num
end

function ui:_onclick_reduce_btn()
  if self.v_data == nil then
    Log.Error("没有物品数据！！！！")
    return
  end
  if 1 == self.v_use_num then
    Util.show_message_tip(2113)
    return
  end
  self.v_use_num = self.v_use_num - 1
  self.v_uicompents.SelectAmount_txt.text = self.v_use_num
end

return ui
