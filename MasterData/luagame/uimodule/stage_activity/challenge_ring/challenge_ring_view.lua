local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local HeroItemClass = require("uimodule.battle_bag.hero_item")
local EmblemClass = require("uimodule.stage_activity.challenge_ring.emblem_item")
local GoodsItemClass = require("uimodule.battle_bag.battle_item")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local CommonDef = require("cs_share.common_define")
local RING_CARD_TYPE = CommonDef.CHL_RING_CARD_TYPE
local CR_HELPER = require("uimodule.stage_activity.challenge_ring.cr_helper")
local Item_Helper = require("utils.item_helper")
local CR_KEY_CARD_KEY = "CR_KEY_CARD_KEY"
local CR_CARD_TYPE_KEY = "CR_CARD_TYPE_KEY"
local CR_TALENT_KEY = "CR_TALENT_KEY"
local CR_CR_ITEM_BUFF_KEY = "CR_CR_ITEM_BUFF_KEY"
local CR_RING_CFG_PATH = require("uimodule.stage_activity.challenge_ring.challenge_ring_cfg")
local CARD_CFG_PATH = "activity.challenge_ring_card"
local CARD_TYPE_ICON_PATH = "UIMap/%s"
local CARD_TYPE_PATH = "UIChallengeRing/%s"
local ITEM_ICON_PATH = "Icon/BattleItem/%s"
local ATTR_ICON_PATH = "UIChar/new/%s"
local bagConfig = require("gamelogic.character.fight_bag_configs")
local SHOW_OBJ_QUEUE = require("uimodule.stage_activity.challenge_ring.show_obj_queue")
local _insert = table.insert
local _tsort = table.sort
local _min = math.min
local _max = math.max
local util_get_color = Util.get_unity_color_by_hex
local ENTER_BAG_EFFECT = "Fx_UI_Card_06_1"
local TALENT_INFO_EFFECT = "Fx_UI_Card_05"
local active_card_type_col = util_get_color(tonumber("c0b299", 16))
local unactive_card_type_col = util_get_color(tonumber("979797", 16))
local CHALLGENGT_BAG_POINT = 28
local MODEL = {
  v_back_obj = {
    "BackObj",
    BIND_TYPE.BUTTON
  },
  v_bag_bg = {
    "BagBg",
    BIND_TYPE.IMAGE
  },
  v_bag_obj = {
    "BagObj",
    BIND_TYPE.BUTTON
  },
  v_bag_text = {
    "BagText",
    BIND_TYPE.TEXT
  },
  v_blur = {
    "Blur",
    BIND_TYPE.RAW_IMAGE
  },
  v_btn_ret = {
    "BtnRet",
    BIND_TYPE.BUTTON
  },
  v_card_type_item = {
    "CardTypeItem",
    BIND_TYPE.OBJECT
  },
  v_card_type_list = {
    "CardTypeList",
    BIND_TYPE.OBJECT
  },
  v_card_type_obj = {
    "CardTypeObj",
    BIND_TYPE.OBJECT
  },
  v_currency_obj = {
    "CurrencyObj",
    BIND_TYPE.OBJECT
  },
  v_full_screen_background1 = {
    "FullScreenBackground1",
    BIND_TYPE.RAW_IMAGE
  },
  v_full_screen_background2 = {
    "FullScreenBackground2",
    BIND_TYPE.RAW_IMAGE
  },
  v_full_screen_background3 = {
    "FullScreenBackground3",
    BIND_TYPE.RAW_IMAGE
  },
  v_fx_ui_card_05 = {
    "Fx_UI_Card_05",
    BIND_TYPE.UIPARTICLE
  },
  v_fx_ui_card_06_1 = {
    "Fx_UI_Card_06_1",
    BIND_TYPE.UIPARTICLE
  },
  v_guide_key_card_icon = {
    "Guide_KeyCardIcon",
    BIND_TYPE.OBJECT
  },
  v_guide_key_card_obj = {
    "Guide_KeyCardObj",
    BIND_TYPE.OBJECT
  },
  v_guide_ring_num_obj = {
    "Guide_RingNumObj",
    BIND_TYPE.OBJECT
  },
  v_guide_talent_obj = {
    "Guide_TalentObj",
    BIND_TYPE.OBJECT
  },
  v_guide_choose2 = {
    "Guide_choose2",
    BIND_TYPE.OBJECT
  },
  v_guide_choose = {
    "Guide_choose",
    BIND_TYPE.OBJECT
  },
  v_hero1 = {
    "Hero1",
    BIND_TYPE.TOGGLE
  },
  v_hero2 = {
    "Hero2",
    BIND_TYPE.TOGGLE
  },
  v_hero3 = {
    "Hero3",
    BIND_TYPE.TOGGLE
  },
  v_key_card_bg = {
    "KeyCardBg",
    BIND_TYPE.IMAGE
  },
  v_key_card_icon = {
    "KeyCardIcon",
    BIND_TYPE.IMAGE
  },
  v_key_card_obj = {
    "KeyCardObj",
    BIND_TYPE.OBJECT
  },
  v_key_card_sign_item = {
    "KeyCardSignItem",
    BIND_TYPE.OBJECT
  },
  v_key_card_sign_list = {
    "KeyCardSignList",
    BIND_TYPE.OBJECT
  },
  v_key_card_sign_num = {
    "KeyCardSignNum",
    BIND_TYPE.OBJECT
  },
  v_key_card_tips = {
    "KeyCardTips",
    BIND_TYPE.TEXT
  },
  v_mask_obj = {
    "MaskObj",
    BIND_TYPE.OBJECT
  },
  v_quit_obj = {
    "QuitObj",
    BIND_TYPE.BUTTON
  },
  v_ring_num_obj = {
    "RingNumObj",
    BIND_TYPE.OBJECT
  },
  v_ring_num = {
    "RingNum",
    BIND_TYPE.TEXT
  },
  v_ring_round_obj = {
    "RingRoundObj",
    BIND_TYPE.OBJECT
  },
  v_round_desc = {
    "RoundDesc",
    BIND_TYPE.TEXT
  },
  v_round_num = {
    "RoundNum",
    BIND_TYPE.TEXT
  },
  v_setting_obj = {
    "SettingObj",
    BIND_TYPE.BUTTON
  },
  v_talent_data_item = {
    "TalentDataItem",
    BIND_TYPE.OBJECT
  },
  v_talent_data_list = {
    "TalentDataList",
    BIND_TYPE.OBJECT
  },
  v_talent_obj = {
    "TalentObj",
    BIND_TYPE.OBJECT
  },
  v_talent_title = {
    "TalentTitle",
    BIND_TYPE.TEXT
  },
  v_uicr_answer_tip = {
    "UICRAnswerTip",
    BIND_TYPE.OBJECT
  },
  v_uicr_pause = {
    "UICRPause",
    BIND_TYPE.OBJECT
  }
}
local TEMP_NOT_SHOW_ATTR = {
  [102] = true,
  [103] = true,
  [104] = true
}

local function card_type_sort(card_a, card_b)
  local a_cfg = card_a.cfg
  local b_cfg = card_b.cfg
  local a_card_show_priority = a_cfg.ShowPriority
  local b_card_show_priority = b_cfg.ShowPriority
  return a_card_show_priority > b_card_show_priority
end

local function talent_sort(talent_a, talent_b)
  local a_attr_idx = talent_a.attr_idx
  local b_attr_idx = talent_b.attr_idx
  return a_attr_idx < b_attr_idx
end

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("QuitObj", function()
    self:open_pause_ui()
  end)
  self:set_button("BagObj", function()
    self:open_bag()
  end)
  self:set_button("BtnRet", function()
    self:close_pause_ui()
  end)
  self:set_button("BackObj", function()
    self:_restart_game()
    self:ui_hide()
  end)
  self:set_button("SettingObj", function()
    UIMgr:get_ui("battle_setting"):ui_show()
  end)
  self:set_button("CheckItemBuff", function()
    self:click_check_item_buff()
  end)
  self:set_button("BtnRetX", function()
    self:change_item_buff_ui(false)
  end)
  self:set_button("BtnBuffDetail", function()
    UIMgr:get_ui("ui_rune_buff_tip"):ui_show()
  end)
  self:set_button("Button_rune", function()
    UIMgr:get_ui("battle_bag4"):ui_show()
  end)
  self:init_template()
  self.v_hero_view = {}
  for i = 1, 3 do
    local obj = self.v_uiobjects["Hero" .. i]
    self.v_hero_view[i] = HeroItemClass:ui_wrap(self, obj, false)
  end
  self.v_ani_type_list = {}
  self.v_money_show_obj = SHOW_OBJ_QUEUE:ui_wrap_ex(nil, self.v_uiobjects.ShowItemList, true)
  self:register_effect(ENTER_BAG_EFFECT)
  self:register_effect(TALENT_INFO_EFFECT)
  self.v_bag_red_point = self:get_child_gameobj("RedPoint", self.v_bag_obj.gameObject)
  RedPointMgr:bind_redpoint(self, self.v_bag_red_point, CHALLGENGT_BAG_POINT)
end

function ui:init_template()
  self:register_exist_auto_template(CR_KEY_CARD_KEY, self.v_key_card_sign_item, self.v_key_card_sign_list)
  self:register_exist_auto_template(CR_CARD_TYPE_KEY, self.v_card_type_item, self.v_card_type_list)
  self:register_exist_auto_template(CR_TALENT_KEY, self.v_talent_data_item, self.v_talent_data_list)
  self:register_exist_auto_template(CR_CR_ITEM_BUFF_KEY, self.v_uiobjects.ItemTem, self.v_uiobjects.itemBuffContent)
end

function ui:ui_on_show()
  self:clear_effect()
  self:_pasue_game()
  self:change_mask_state(true)
  self:refresh_key_card_ui()
  self:refresh_hero()
  self:refresh_card_type_ui()
  self:register_event()
  self:refresh_ring_num_ui()
  self:refresh_ring_round_ui()
  self:refresh_currency_info_ui()
  self:refresh_buff_show_ui()
  self:refresh_team_level()
  self:enable_card_deck()
  self:close_all_panel()
  self:show_back_ui()
  self:show_door_card_ui()
  self:refresh_money_show_queue()
end

function ui:ui_on_hide()
  self:clear_effect()
  self.v_card_type_show_list = nil
  self.v_talent_show_list = nil
  if self.v_card_type_seq then
    self:clear_ani_seq(self.v_card_type_seq)
    self.v_card_type_seq = nil
  end
  self.v_emblem_fly_obj = nil
  if self.v_emblem_list then
    for _, data in pairs(self.v_emblem_list) do
      self:remove_wrap_ui(data)
    end
  end
  self:remove_ui_buff_list()
  self.v_emblem_list = nil
  self:change_item_buff_ui(false)
  self.v_money_show_obj:ui_hide(true)
end

function ui:ui_on_destroy()
  self.v_hero_view = nil
  self.v_ani_type_list = nil
  self.v_money_show_obj:ui_destroy()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_CR_SELECT_CARD, self.select_cr_card, self)
  self:bind_auto_mq(Const.MSG_ON_CR_SELECT_CARD_ANI_END, self.response_select_ani_end, self)
  self:bind_auto_mq(Const.MSG_ON_CR_REFRESH_EMBLEM_NUM, self.refresh_key_card_ui, self)
  self:bind_auto_mq(Const.MSG_ON_UPDATE_CR_TOWER_INFO, self.response_tower_info_update, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self._refresh_currency, self)
  self:bind_auto_mq(Const.MSG_ON_HEAL_CARD_REFRESH, self.heal_card_refresh, self)
  self:bind_auto_mq(Const.MSG_ON_REWARD_CARD_REFRESH, self.reward_card_refresh, self)
  self:bind_auto_mq(Const.MSG_HERO_ATTR_CHANGE, self.response_talent_info_ui, self)
  self:bind_auto_mq(Const.MSG_GOD_ATTR_CHANGE, self.response_talent_info_ui, self)
  self:bind_auto_mq(Const.MSG_ON_DRAW_CARD_END, self.response_draw_card_end, self)
  self:bind_auto_mq(Const.MSG_ON_CR_STAY_LAYER, self.response_stay_layer, self)
  self:bind_auto_mq(Const.MSG_ON_CR_GO_NEXT_LAYER, self.response_next_layer, self)
  self:bind_auto_mq(Const.MSG_ON_CR_PASS_TOWER, self.response_pass_tower, self)
  self:bind_auto_mq(Const.MSG_ON_CR_ANI_BEGIN, self.response_cr_ani_begin, self)
  self:bind_auto_mq(Const.MSG_ON_CR_ANI_END, self.response_cr_ani_end, self)
  self:bind_auto_mq(Const.MSG_ON_CR_DRAW_CARD, self.response_draw_card_start, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_CARD_DECK, self.response_card_deck_hide, self)
  self:bind_auto_mq(Const.MSG_ON_CREATE_DOOR_CARD, self.response_door_card_create, self)
  self:bind_auto_mq(Const.MSG_ON_CR_VIEW_CAN_OPERATE, self.response_view_can_operate, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_BAG_UPDATE, self.response_bag_update, self)
end

function ui:show_back_ui()
  local tower = TowerMgr:get_tower()
  if tower then
    local room = tower:get_room()
    self.v_uiobjects.BackObj:SetActive(true)
    local scene_item_mgr = SceneMgr:get_scene_item_mgr()
    if room:is_fight_end() and room:is_get_all_drop_item() then
      self.v_uiobjects.BackObj:SetActive(false)
    end
  end
end

function ui:heal_card_refresh()
  self:refresh_key_card_ui()
  self:refresh_hero()
  self:refresh_card_type_ui()
end

function ui:reward_card_refresh()
  self:refresh_key_card_ui()
  self:refresh_hero()
  self:refresh_card_type_ui()
end

function ui:refresh_key_card_ui()
  local is_show_key_card = ChallengeRingMgr:is_show_key_card()
  local all_emblem_num = ChallengeRingMgr:get_all_emblem_num()
  local now_emblem_num = ChallengeRingMgr:get_cur_show_emblem()
  if ChallengeRingMgr:is_key_card_delete() then
    self.v_key_card_obj:SetActive(false)
    return
  else
    self.v_key_card_obj:SetActive(true)
  end
  if self.v_emblem_list then
    for _, data in pairs(self.v_emblem_list) do
      self:remove_wrap_ui(data)
    end
  end
  self.v_emblem_list = {}
  self:give_back_auto_cache(CR_KEY_CARD_KEY)
  if not is_show_key_card then
    self.v_key_card_sign_list:SetActive(true)
    self.v_key_card_sign_num:SetActive(false)
    for i = 1, all_emblem_num do
      local item = self:get_auto_cache(CR_KEY_CARD_KEY)
      local item_lua = EmblemClass:ui_wrap_ex(self, item, true)
      item_lua.go = item
      _insert(self.v_emblem_list, item_lua)
      item_lua:init_ui()
      if now_emblem_num >= i then
        item_lua:set_emblem_active()
      end
    end
    self.v_key_card_tips.text = Util.get_i18n("收集徽记后首领出现")
  else
    local emblem_obj = self.v_uiobjects.KeyCardSignNum
    local item_lua = EmblemClass:ui_wrap_ex(self, emblem_obj, true)
    _insert(self.v_emblem_list, item_lua)
    item_lua.go = emblem_obj
    item_lua:init_ui()
    item_lua:set_emblem_active()
    self.v_emblem_fly_obj = item_lua
    self.v_key_card_sign_list:SetActive(false)
    self.v_key_card_sign_num:SetActive(true)
    local pro_value = ChallengeRingMgr:get_key_card_probability()
    self.v_key_card_tips.text = Util.format_str("出现概率提升{1}%", pro_value)
    local show_num = _max(0, now_emblem_num - all_emblem_num)
    item_lua:refresh_num(show_num)
  end
end

function ui:refresh_ring_num_ui()
  local ring_num = ChallengeRingMgr:get_cur_ring_num() or 1
  self.v_ring_num.text = Util.format_str("第 <color=#c0b299>{1}</color> 环", ring_num)
end

function ui:refresh_card_type_ui()
  local total_card_type = ShareRes.create("activity.challenge_ring_card_type")
  local card_type_list = ChallengeRingMgr:get_card_type_list()
  if not card_type_list or next(card_type_list) == nil then
    return
  end
  self.v_card_type_show_list = {}
  for card_type_idx, num in pairs(card_type_list) do
    local type_cfg = total_card_type[card_type_idx]
    if type_cfg then
      local card_type_info = {
        card_type_idx = card_type_idx,
        num = num,
        cfg = type_cfg
      }
      _insert(self.v_card_type_show_list, card_type_info)
    end
  end
  _tsort(self.v_card_type_show_list, card_type_sort)
  self:give_back_auto_cache(CR_CARD_TYPE_KEY)
  for _, data in ipairs(self.v_card_type_show_list) do
    local item = self:get_auto_cache(CR_CARD_TYPE_KEY)
    local num_txt = Util.get_text("CardTypeNum", item)
    local type_img = Util.get_image("CardTypeIcon", item)
    local num = data.num
    local type_cfg = data.cfg
    local type = type_cfg.Type
    local type_name = type_cfg.Icon
    data.go = item
    local icon_path = string.format(CARD_TYPE_PATH, type_name)
    ResMgr:load_set_icon(type_img, icon_path)
    if type ~= RING_CARD_TYPE.DOOR then
      self:_refresh_card_type_num(num_txt, num)
    end
  end
end

function ui:_refresh_card_type_show_list(card_show_type)
  for _, data in ipairs(self.v_card_type_show_list) do
    local card_type_idx = data.card_type_idx
    local go = data.go
    local num = data.num
    if card_show_type == card_type_idx then
      num = num - 1
      local num_txt = Util.get_text("CardTypeNum", go)
      self:_refresh_card_type_num(num_txt, num)
      self:refresh_card_type_ani(go, data)
      break
    end
  end
end

function ui:refresh_card_type_ani(card_type_go)
  if self.v_card_type_seq then
    self:clear_ani_seq(self.v_card_type_seq)
  end
  self.v_card_type_seq = {}
  local icon_go = Util.get_child_gameobj("CardTypeIcon", card_type_go)
  local seq = Util.create_sequence()
  _insert(self.v_card_type_seq, seq)
  seq:Append(icon_go.transform:DOShakePosition(0.2, 10, 40, 50, true))
end

function ui:_refresh_card_type_num(num_txt, num)
  num_txt.text = "X" .. num
  if num > 0 then
    num_txt.color = active_card_type_col
  else
    num_txt.color = unactive_card_type_col
  end
end

function ui:_refresh_talent_num(num_txt, num)
  num_txt.text = num
  if num > 0 then
    num_txt.color = active_card_type_col
  else
    num_txt.color = unactive_card_type_col
  end
end

function ui:refresh_currency_info_ui()
  self:_refresh_currency()
end

function ui:refresh_card_deck_ui()
  local card_list = ChallengeRingMgr:get_cur_circle_card_list()
end

function ui:refresh_ring_round_ui()
  local round_num = ChallengeRingMgr:get_cur_round()
  self.v_round_num.text = Util.format_str("第{1}回合", round_num)
end

function ui:refresh_hero()
  for _, hero_ui in pairs(self.v_hero_view) do
    hero_ui:set_enable(false)
  end
  local list = SceneMgr:get_hero_list()
  self.v_hero_num = UtilTable.hash_lenth(list)
  local _, team_list = FormationMgr:get_formation_info_by_id(CommonDef.FORMATION_TYPE.CHAL_RING_TEAM)
  for _, hero in pairs(list) do
    for _, team in pairs(team_list) do
      if team.buddy_id == hero.buddy_cfg.ModelId and self.v_hero_view[team.pos] ~= nil then
        self.v_hero_view[team.pos]:set_enable(true, hero)
      end
    end
  end
end

function ui:open_bag()
  local open_ui = UIMgr:get_ui("battle_bag")
  if open_ui then
    open_ui:ui_show()
  end
end

function ui:close_all_panel()
  self.v_panels.answer_view:set_enable(false)
  self.v_panels.pause_view:set_enable(false)
  self:show_round_obj()
  self:common_hide_panel_logic()
end

function ui:show_round_obj()
  self.v_uiobjects.RingRoundObj:SetActive(true)
  self:refresh_key_card_ui()
end

function ui:hide_round_obj()
  self.v_uiobjects.RingRoundObj:SetActive(false)
  self.v_uiobjects.KeyCardObj:SetActive(false)
end

function ui:open_door_card_ui()
  self:close_all_panel()
  self.v_panels.answer_view:set_enable(true)
  self:common_show_panel_logic()
  self.v_uiobjects.BtnRet:SetActive(false)
  self.v_show_door_card_ui = true
  local card_deck_ui = self:get_card_deck_ui()
  if card_deck_ui then
    card_deck_ui:ui_hide()
  end
end

function ui:close_door_card_ui()
  self:close_door_card_common_logic()
  local card_deck_ui = UIMgr:get_ui("ui_cr_card_deck")
  if card_deck_ui then
    card_deck_ui:ui_show()
  end
end

function ui:close_door_card_common_logic()
  self.v_panels.answer_view:set_enable(false)
  self.v_show_door_card_ui = false
  self:common_hide_panel_logic()
end

function ui:common_show_panel_logic()
  self.v_uiobjects.QuitObj:SetActive(false)
  self:set_bg_show_state(true)
  self:hide_round_obj()
  self:close_back_ui()
end

function ui:set_bg_show_state(enable)
  self.v_uiobjects.FullScreenBackground3:SetActive(enable)
end

function ui:common_hide_panel_logic()
  self.v_uiobjects.BtnRet:SetActive(false)
  self.v_uiobjects.QuitObj:SetActive(true)
  self:set_bg_show_state(false)
  self:show_round_obj()
  self:show_back_ui()
end

function ui:open_pause_ui()
  self:close_all_panel()
  self.v_panels.pause_view:set_enable(true)
  self:common_show_panel_logic()
  self.v_uiobjects.BtnRet:SetActive(true)
  local card_deck_ui = self:get_card_deck_ui()
  if card_deck_ui then
    card_deck_ui:ui_hide()
  end
end

function ui:close_pause_ui()
  self.v_panels.pause_view:set_enable(false)
  self:common_hide_panel_logic()
  local card_deck_ui = UIMgr:get_ui("ui_cr_card_deck")
  if card_deck_ui then
    card_deck_ui:ui_show()
  end
end

function ui:close_back_ui()
  self.v_uiobjects.BackObj:SetActive(false)
end

local CRAD_TYPE_FUN = {
  [CommonDef.CHL_RING_CARD_TYPE.MONSTER] = "select_battle_card",
  [CommonDef.CHL_RING_CARD_TYPE.MOBS] = "select_battle_card",
  [CommonDef.CHL_RING_CARD_TYPE.BOSS] = "select_battle_card",
  [CommonDef.CHL_RING_CARD_TYPE.CHALLENGE] = "select_battle_card",
  [CommonDef.CHL_RING_CARD_TYPE.TREASURE] = "select_treasure_card",
  [CommonDef.CHL_RING_CARD_TYPE.HEAL] = "select_heal_card",
  [CommonDef.CHL_RING_CARD_TYPE.SHOP] = "select_shop_card",
  [CommonDef.CHL_RING_CARD_TYPE.RECEIVE] = "select_reward_card",
  [CommonDef.CHL_RING_CARD_TYPE.DOOR] = "select_door_card",
  [CommonDef.CHL_RING_CARD_TYPE.CAST] = "select_cast_card"
}

function ui:select_cr_card(msg)
  if nil == msg then
    return
  end
  local select_card_info = msg.mm_obj
  local card_list_idx = select_card_info.card_list_idx
  ChallengeRingMgr:set_select_card_info(select_card_info)
  ChallengeRingMgr:on_select_card(card_list_idx)
end

function ui:select_treasure_card()
  BattleTreasureMgr:open_battle_treasure()
end

function ui:select_heal_card(card_cfg)
  ChallengeRingMgr:on_receive_heal_card(false, card_cfg)
end

function ui:select_shop_card()
  BattleShopMgr:open_battle_shop()
end

function ui:select_reward_card()
  ChallengeRingMgr:on_receive_reward_card(false)
end

function ui:select_cast_card(card_cfg)
  local cast_id = card_cfg.Arg[1]
  Rune2Mgr:open_cast_ui(cast_id)
end

function ui:select_battle_card(_, card_data)
  local card_uuid = card_data.uuid
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    local room_num = ChallengeRingMgr:get_battle_room_idx(card_uuid)
    scene_logic:cr_tp_room(room_num)
    self:ui_hide()
  end
end

function ui:select_door_card()
  self:open_door_card_ui()
end

function ui:create_card_deck()
  local open_ui = self:get_card_deck_ui()
  local card_num = ChallengeRingMgr:get_remain_card_num()
  if open_ui and card_num then
    open_ui:ui_show(card_num)
  end
end

function ui:shuffle_card()
  local open_ui = self:get_card_deck_ui()
  if open_ui then
    open_ui:rotate_round()
  end
end

function ui:draw_card()
  local open_ui = self:get_card_deck_ui()
  local draw_card_list = ChallengeRingMgr:get_random_select_card()
  if open_ui then
    open_ui:draw_card(draw_card_list)
  end
end

function ui:reverse_card()
  local open_ui = self:get_card_deck_ui()
  if open_ui then
    open_ui:reverse_card()
  end
end

function ui:card_fly_to_bag(card_go, card_select_idx)
  local open_ui = self:get_card_deck_ui()
  if open_ui then
    open_ui:card_fly_to_bag(card_go, self.v_uiobjects.BagBg.transform, card_select_idx)
  end
end

function ui:get_card_deck_ui()
  return UIMgr:try_get_visible_ui("ui_cr_card_deck")
end

function ui:enable_card_deck()
  local open_ui = UIMgr:get_ui("ui_cr_card_deck")
  if open_ui then
    open_ui:ui_show()
  end
end

function ui:response_tower_info_update()
  self:refresh_ring_round_ui()
  self:refresh_ring_num_ui()
end

function ui:cache_ui()
  return true
end

function ui:_refresh_currency()
  local moneyId = bagConfig.SHOW_CURRENCY[1]
  local cfg = FightBagMgr:get_cfg_by_id(moneyId)
  local moneyIcon = Util.get_image("CurrencyIcon", self.v_currency_obj)
  ResMgr:load_set_icon(moneyIcon, string.format(ITEM_ICON_PATH, cfg.Icon))
  local moneyTxt = Util.get_text("CurrencyVal", self.v_currency_obj)
  moneyTxt.text = CharacterMgr:get_res_val(moneyId)
end

function ui:response_click_hero_event(msg)
  if msg.mm_x == true then
    return
  end
  UIMgr:get_ui("ring_skill"):ui_show(self.v_formation_type, msg.mm_obj)
end

function ui:_pasue_game()
  SceneMgr:set_game_pause(true)
end

function ui:_restart_game()
  SceneMgr:set_game_pause(false)
end

function ui:clear_enter_bag_effect()
  if self.v_enter_bag_effect and not self.v_enter_bag_effect:IsNull() then
    ResMgr:destroy_gameobj(self.v_enter_bag_effect)
  end
end

function ui:play_enter_bag_effect(card_select_idx)
  self:play_effect(ENTER_BAG_EFFECT)
  self:select_reward_card(card_select_idx)
end

function ui:response_draw_card_end()
  self:refresh_card_type_ui()
end

function ui:response_talent_info_ui()
  if not self.v_talent_show_list then
    return
  end
  local temp_talent_show = {}
  local talent_type_cfg = CR_RING_CFG_PATH.TalentInfo
  local list = SceneMgr:get_hero_list()
  self.v_hero_num = UtilTable.hash_lenth(list)
  local cal_num = {}
  for _, hero in pairs(list) do
    for _, attr_idx in pairs(talent_type_cfg) do
      local attrs = hero.attr_mgr:get_attr(attr_idx)
      cal_num[attr_idx] = cal_num[attr_idx] or 0
      cal_num[attr_idx] = cal_num[attr_idx] + attrs
    end
  end
  local god_npc = SceneMgr:get_god_npc()
  if not god_npc then
    return
  end
  for _, attr_idx in pairs(talent_type_cfg) do
    local attrs = god_npc.attr_mgr:get_attr(attr_idx)
    cal_num[attr_idx] = cal_num[attr_idx] or 0
    cal_num[attr_idx] = cal_num[attr_idx] + attrs
  end
  for attr_idx, num in pairs(cal_num) do
    local talent_data = {attr_idx = attr_idx, num = num}
    temp_talent_show[attr_idx] = talent_data
  end
  for _, data in pairs(self.v_talent_show_list) do
    local attr_idx = data.attr_idx
    if TEMP_NOT_SHOW_ATTR[attr_idx] then
    else
      local new_num = temp_talent_show[attr_idx].num
      local old_num = data.num
      local go = data.go
      local num_txt = Util.get_text("TalentNum", go)
      if new_num ~= old_num then
        self:play_talent_info_effect(go)
        data.num = new_num
        self:_refresh_talent_num(num_txt, new_num)
      end
    end
  end
end

function ui:response_draw_card_start()
  GuideMgr:check_sys_guide(self)
end

function ui:clear_talent_info_effect()
  if self.v_talent_info_effect and not self.v_talent_info_effect:IsNull() then
    ResMgr:destroy_gameobj(self.v_talent_info_effect)
  end
end

function ui:play_talent_info_effect(go)
  self:clear_talent_info_effect()
  self.v_talent_info_effect = ResMgr:load_gameobj(Path.get_res_path(TALENT_INFO_EFFECT), nil, true)
  self.v_talent_info_effect.transform:SetParent(go.transform, false)
  self.v_talent_info_effect.transform:SetLocalPositionA(0, 0, 0)
end

function ui:clear_effect()
  self:clear_talent_info_effect()
  self:clear_enter_bag_effect()
end

function ui:clear_ani_seq(seq_list)
  if not seq_list then
    return
  end
  for _, seq in pairs(seq_list) do
    seq:Kill()
  end
end

function ui:response_stay_layer()
  self:close_door_card_ui()
end

function ui:response_next_layer()
  self:close_door_card_common_logic()
  self:ui_hide()
end

function ui:response_pass_tower()
  self:close_door_card_ui()
end

function ui:response_cr_ani_begin(msg)
  if not msg then
    return
  end
  local ani_type = msg.mm_x
  self.v_ani_type_list[ani_type] = true
  self:change_mask_state(true)
end

function ui:response_cr_ani_end(msg)
  if not msg then
    return
  end
  local ani_type = msg.mm_x
  self.v_ani_type_list[ani_type] = nil
  if self.v_ani_type_list and nil == next(self.v_ani_type_list) then
    self:change_mask_state(false)
  end
end

function ui:response_card_deck_hide()
  self.v_ani_type_list = {}
  self:change_mask_state(false)
end

function ui:response_door_card_create()
  self.v_key_card_obj:SetActive(false)
end

function ui:response_view_can_operate()
  self:change_mask_state(false)
end

function ui:change_mask_state(is_open)
  self.v_uiobjects.MaskObj:SetActive(is_open)
end

function ui:show_door_card_ui()
  local is_select_door_card = ChallengeRingMgr:is_selecting_door_card()
  if self.v_show_door_card_ui or is_select_door_card then
    self:open_door_card_ui()
  end
end

function ui:get_emblem_fly_obj()
  if not self.v_emblem_fly_obj then
    self:refresh_key_card_ui()
  end
  return self.v_emblem_fly_obj
end

function ui:get_emblem_list()
  return self.v_emblem_list
end

function ui:response_select_ani_end()
  local select_card_info = ChallengeRingMgr:get_select_card_info()
  local card_list_idx = select_card_info.card_list_idx
  local card_go = select_card_info.go
  local card_id = select_card_info.card_id
  local card_cfg = ShareRes.get_ring_card(card_id)
  local card_show_type = card_cfg.ShowType
  local card_data = ChallengeRingMgr:get_selecting_card()
  if card_show_type ~= RING_CARD_TYPE.DOOR then
    self:_refresh_card_type_show_list(card_show_type)
  end
  if card_show_type == RING_CARD_TYPE.RECEIVE then
    self:card_fly_to_bag(card_go, card_list_idx)
    return
  end
  for check_type, fun in pairs(CRAD_TYPE_FUN) do
    if card_show_type == check_type then
      self[fun](self, card_cfg, card_data)
      break
    end
  end
end

function ui:click_check_item_buff()
  self:change_item_buff_ui(true)
end

function ui:change_item_buff_ui(is_on)
  self.v_uiobjects.ItemBuffMask:SetActive(is_on)
  if not is_on then
    return
  end
  self:give_back_auto_cache(CR_CR_ITEM_BUFF_KEY)
  self:remove_ui_buff_list()
  self.v_ui_buff_obj = {}
  self.v_uiobjects.NoneItemTips:SetActive(false)
  self.v_uiobjects.itemBuffContent:SetActive(true)
  local cr_item_list = CR_HELPER.get_cr_item()
  if cr_item_list and next(cr_item_list) then
    for _, data in pairs(cr_item_list) do
      local item_cfg = data.Cfg
      local is_show = item_cfg.SpecialShow
      if is_show then
        local item_obj = self:get_auto_cache(CR_CR_ITEM_BUFF_KEY)
        local buff_text = Util.get_text("ItemBuff", item_obj)
        local battle_item_go = Util.get_child_gameobj("ItemObj", item_obj)
        local battle_item_obj = GoodsItemClass:ui_wrap_ex(self, battle_item_go, false)
        local item_id = item_cfg.Id
        local item_name = data.Name
        local item_desc = item_cfg.Desc
        local item_param = {
          show_num = data.count
        }
        local desc_txt = Util.format_str(item_desc, Item_Helper.get_item_effect(item_id, item_cfg))
        battle_item_obj:set_enable(true, item_id, item_param)
        buff_text.text = Util.format_str("{1} : {2}", item_name, desc_txt)
        _insert(self.v_ui_buff_obj, battle_item_obj)
      end
    end
  else
    self.v_uiobjects.itemBuffContent:SetActive(false)
    self.v_uiobjects.NoneItemTips:SetActive(true)
  end
end

function ui:remove_ui_buff_list()
  if self.v_ui_buff_obj then
    self:remove_wrap_ui_list(self.v_ui_buff_obj)
  end
end

function ui:refresh_money_show_queue()
  local add_list = FightBagMgr:get_currency_add_list()
  self.v_money_show_obj:set_data(add_list, 3)
end

function ui:refresh_buff_show_ui()
  local buff_obj = self.v_uiobjects.CheckItemBuff
  local buff_text = Util.get_text("Text", buff_obj)
  local cr_item_list = CR_HELPER.get_cr_item()
  local num = 0
  for _, data in pairs(cr_item_list) do
    local item_cfg = data.Cfg
    local is_show = item_cfg.SpecialShow
    if is_show then
      num = num + 1
    end
  end
  buff_text.text = Util.format_str("增益效果：{1}", num)
end

function ui:response_bag_update()
  self:refresh_buff_show_ui()
end

function ui:refresh_team_level()
  local lv = Rune2Mgr:get_rune_team_level()
  self.v_uicompents.TeaMBallLV_txt.text = lv
end

return ui
