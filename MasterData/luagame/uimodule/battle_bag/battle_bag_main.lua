local Base = require("ui.uibase")
local HeroItemClass = require("uimodule.battle_bag.hero_item")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local bagConfig = require("gamelogic.character.fight_bag_configs")
local Item_Helper = require("utils.item_helper")
local CommonDef = require("cs_share.common_define")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local CHAL_TYPE2FORMN_TYPE = CommonDef.CHAL_TYPE2FORMN_TYPE
local NOT_PROGRESS_BATTLE_TYPE = Config.NOT_PROGRESS_BATTLE_TYPE
local ui = Util.create_child_mt(Base)
local Cs_color = UnityEngine.Color
local COLOR_1 = Cs_color(0.7372549019607844, 0.7058823529411765, 0.6470588235294118, 0.6)
local COLOR_2 = Cs_color(0.8470588235294118, 0.8, 0.6235294117647059, 1)
local BAG_SOURCE = {NONE = 1, SHOP = 2}
local ITEM_ICON_PATH = "Icon/BattleItem/%s"
local RING_TOG = {
  [3] = 3,
  [4] = 4
}
local CHALLGENGT_BAG_POINT = 28
local ITEM_PAGE_POINT = 29

function ui:ui_finish_load()
  self:set_button("BtnRet", function()
    self:ui_hide()
  end)
  self:set_button("QuitBtn", function()
    self:_onclick_quit_btn()
  end)
  self:set_button("SettingBtn", function()
    UIMgr:get_ui("battle_setting"):ui_show()
  end)
  self.v_color_1 = COLOR_1
  self.v_color_2 = COLOR_2
  self.v_tog_list = {}
  self.v_sold_obj = {}
  for i = 1, 4 do
    local name = self:get_text("ShopName", self.v_uiobjects["GoodsTem" .. i])
    local eng_name = self:get_text("ShopEng", self.v_uiobjects["GoodsTem" .. i])
    local is_on = self.v_uicompents["GoodsTem" .. i .. "_tog"].isOn
    name.color = is_on and self.v_color_2 or self.v_color_1
    eng_name.color = is_on and self.v_color_2 or self.v_color_1
    self.v_tog_list[i] = self:set_toggle("GoodsTem" .. i, function(isOn)
      name.color = isOn and self.v_color_2 or self.v_color_1
      eng_name.color = isOn and self.v_color_2 or self.v_color_1
      self:_onclick_tog(i, isOn)
    end)
    if 4 == i then
      table.insert(self.v_sold_obj, self:get_child_gameobj("Marks/SoldObj", self.v_uiobjects["GoodsTem" .. i]))
    end
  end
  self.v_tog_panels = {
    [1] = self.v_panels.collect_bag_view,
    [2] = self.v_panels.rune_bag_view,
    [3] = self.v_panels.equip_bag_view,
    [4] = self.v_panels.item_bag_view
  }
  self.v_hero_view = {}
  for i = 1, 3 do
    local obj = self.v_uiobjects["Hero" .. i]
    self.v_hero_view[i] = HeroItemClass:ui_wrap(self, obj, false)
  end
  self.v_currency_list = {}
  self.v_template_key = "current_item" .. self:ui_get_name()
  self:register_exist_auto_template(self.v_template_key, self.v_uiobjects.Asset_Item, self.v_uiobjects.AssetBar)
  self.v_tog_group = self:get_toggle_group(nil, self.v_uiobjects.HeroView)
  self.v_hero_tra = self.v_uiobjects.HeroView.transform
  self.v_auto_pick = self:set_button("AutoPick", function()
    self:_onclick_auto_pick()
  end)
  self.v_open_pick = self:get_child_gameobj("Open", self.v_auto_pick.gameObject)
  self.v_close_pick = self:get_child_gameobj("Close", self.v_auto_pick.gameObject)
  local red = self:get_child_gameobj("Marks/RedPoint", self.v_uiobjects.GoodsTem4)
  RedPointMgr:bind_redpoint(self, red, ITEM_PAGE_POINT, CHALLGENGT_BAG_POINT)
end

function ui:ui_on_show(formation_type, source)
  local fight_info = TowerMgr:get_fight_info()
  if not formation_type and fight_info then
    formation_type = CHAL_TYPE2FORMN_TYPE[fight_info.type]
  end
  self.v_formation_type = formation_type
  self.v_bag_open_source = source or BAG_SOURCE.NONE
  for _, v in pairs(self.v_sold_obj) do
    v:SetActive(self.v_bag_open_source == BAG_SOURCE.SHOP)
  end
  self:_set_pages()
  self.v_tog_group.allowSwitchOff = true
  self:_refresh_hero()
  self:_refresh_currency_list()
  self:_regist_client_event()
  local open = Util.get_auto_pick()
  self.v_open_pick:SetActive(open)
  self.v_close_pick:SetActive(not open)
  local tower = TowerMgr:get_tower()
  self.v_in_challenge_ring = tower and tower:is_challenge_ring_tower()
  self.v_uiobjects.QuitBtn:SetActive(not self.v_in_challenge_ring)
  self.v_uiobjects.SettingBtn:SetActive(not self.v_in_challenge_ring)
  if not self.v_in_challenge_ring then
    SceneMgr:set_game_pause(true)
  end
end

function ui:ui_on_update()
end

function ui:ui_on_hide()
  self.v_currency_list = {}
  if not self.v_in_challenge_ring then
    SceneMgr:set_game_pause(false)
  end
  for _, v in pairs(self.v_hero_view) do
    v:set_enable(false)
  end
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_CLICK_RING_BAG_ITEM, self.response_click_item_event, self)
  self:bind_auto_mq(Const.MSG_ON_CLICK_RING_HERO_ITEM, self.response_click_hero_event, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self._refresh_currency_list, self)
  self:bind_auto_mq(Const.MSG_ON_CLOSE_RING_BAG_ITEM_TIPS, self.response_close_tip_event, self)
end

function ui:response_click_item_event(msg)
  if msg.mm_y == false then
    self.v_tog_group:SetActive(false)
    for _, v in pairs(self.v_hero_view) do
      v:reset_tog_state()
    end
    self:set_group(true, true)
    self.v_tog_group:SetActive(true)
    self.v_panels.item_tips:set_enable(false)
    return
  end
  if not msg.mm_x then
    return
  end
  self.v_panels.item_tips:set_enable(true)
  local is_consume = Item_Helper.get_is_consume(msg.mm_x.id)
  local click = true
  if is_consume and self.v_bag_open_source == BagCfg.BAG_SOURCE.NONE then
    self.v_hero_tra:SetAsLastSibling()
    local range = Item_Helper.get_effect_range(msg.mm_x.id)
    self:set_group(range == Item_Helper.Effect_Range.Single, false)
    click = self:get_can_click(true, range)
  else
    self.v_hero_tra:SetSiblingIndex(3)
  end
  for _, v in pairs(self.v_hero_view) do
    v:set_can_click(click)
  end
  local param = {
    item_data = msg.mm_x,
    formation_type = self.v_formation_type,
    bag_source = self.v_bag_open_source,
    go = msg.mm_obj
  }
  if self.v_panels.item_tips.v_enable == true then
    self.v_panels.item_tips:ui_on_show(msg.mm_x.id, param)
  else
    self.v_panels.item_tips:set_enable(true, msg.mm_x.id, param)
  end
end

function ui:response_close_tip_event(msg)
  self:_refresh_hero()
end

function ui:response_click_hero_event(msg)
  if msg.mm_x == false then
    UIMgr:get_ui("ring_skill"):ui_show(self.v_formation_type, msg.mm_obj)
  elseif msg.mm_obj:is_die() and self.v_select_hero then
    for _, v in pairs(self.v_hero_view) do
      local hero = v:get_cur_hero()
      if hero and hero.uuid == self.v_select_hero.uuid then
        v:set_toggle_value(true)
        return
      end
    end
  end
  self.v_select_hero = msg.mm_obj
end

function ui:_refresh_hero()
  local list = SceneMgr:get_hero_list()
  self.v_hero_num = UtilTable.hash_lenth(list)
  local cur_fight_pos, team_list = FormationMgr:get_formation_info_by_id(self.v_formation_type)
  if not team_list then
    return
  end
  for uuid, hero in pairs(list) do
    for _, team in pairs(team_list) do
      if team.buddy_id == hero.buddy_cfg.ModelId and self.v_hero_view[team.pos] ~= nil then
        self.v_hero_view[team.pos]:set_enable(true, hero)
      end
    end
  end
end

function ui:_refresh_currency_list()
  for idx, v in pairs(bagConfig.SHOW_CURRENCY) do
    if not self.v_currency_list[idx] then
      local obj = self:get_auto_cache(self.v_template_key)
      self.v_currency_list[idx] = obj
    end
    self:_set_currency(self.v_currency_list[idx], idx)
  end
end

function ui:_set_currency(obj, index)
  if nil == obj then
    Log.Error("获取货币item对象失败！！！")
    return
  end
  obj:SetActiveEx(true)
  local data = bagConfig.SHOW_CURRENCY[index]
  local cfg = FightBagMgr:get_cfg_by_id(data)
  local moneyIcon = self:get_image("Label", obj)
  ResMgr:load_set_icon(moneyIcon, string.format(ITEM_ICON_PATH, cfg.Icon))
  local moneyNum = self:get_text("Aomunt", obj)
  moneyNum.text = CharacterMgr:get_res_val(data)
end

function ui:_onclick_tog(togIdx, isOn)
  if togIdx == self.v_tog_idx and isOn then
    return
  end
  self.v_tog_idx = togIdx
  for k, v in pairs(self.v_tog_panels) do
    v:set_enable(isOn and togIdx == k)
  end
end

function ui:_onclick_auto_pick()
  Util.toggle_auto_pick()
  local open = Util.get_auto_pick()
  self.v_open_pick:SetActive(open)
  self.v_close_pick:SetActive(not open)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_formation_type, self.v_bag_open_source
end

function ui:get_in_rune_bag()
  return self.v_panels.rune_bag_view:get_enable()
end

function ui:set_group(need_group, allow)
  local group
  if need_group then
    group = self.v_tog_group
  end
  for _, v in pairs(self.v_hero_view) do
    v:set_toggle_group(group)
  end
  self.v_tog_group.allowSwitchOff = allow
end

function ui:get_can_click(is_consume, range)
  if not is_consume then
    return true
  end
  if range == Item_Helper.Effect_Range.Team then
    return false
  end
  return true
end

function ui:_set_pages()
  local show_list = RING_TOG
  local idx = 0
  for i, v in ipairs(self.v_tog_list) do
    local show = true
    if show_list then
      show = show_list[i]
    end
    v:SetActive(show)
    if show and 0 == idx then
      idx = i
    end
  end
  self.v_tog_idx = 0
  self.v_tog_list[idx].isOn = true
  self:_onclick_tog(idx, true)
end

function ui:_onclick_quit_btn()
  local fight_info = TowerMgr:get_fight_info()
  if fight_info and fight_info.type == CommonDef.CHALLENGE_TYPE.BEST_CONF then
    self:_exit_top_ver_tower()
  else
    self:_exit_tower(fight_info)
  end
end

function ui:_exit_top_ver_tower()
  local tip = Util.format_str("是否立即退出关卡")
  local sure_btn = Util.format_str("退出")
  
  local function sure_callback()
    UIMgr:get_ui("top_ver_settlement"):ui_show()
  end
  
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip, sure_btn)
end

function ui:_exit_tower(fight_info)
  local tip = Util.format_str("是否立即退出关卡")
  local sure_btn = Util.format_str("中继保存")
  local cancel_btn = Util.format_str("直接结算")
  
  local function sure_callback()
    self:ui_hide()
    
    local function cb()
      Global.scene_mgr:on_enter_main_scene()
      UIMgr:revert_cache_ui()
    end
    
    if TowerMgr then
      TowerMgr:on_exit_tower(cb)
    end
  end
  
  local function cancel_callback()
    if fight_info and NOT_PROGRESS_BATTLE_TYPE[fight_info.type] then
      UIMgr:get_ui("not_progress_battle_def_settle"):ui_show()
    else
      UIMgr:get_ui("fight_settlement"):ui_show(CHAPTER_CONFIG.POINTSTATE.quit)
    end
  end
  
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, cancel_callback, tip, sure_btn, cancel_btn)
end

return ui
