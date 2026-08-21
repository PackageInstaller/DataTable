local Base = require("ui.uibase")
local HERO_CLASS = require("uimodule.stage_activity.online_battle.team_member")
local POINT_INFO_CLASS = require("uimodule.chapter.point_info_common")
local ModelRtView = require("ui.model_rt_view.signboard_rt_view_new")
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local CommonDef = require("cs_share.common_define")
local OnlineConfig = require("gamelogic.activity.online_config")
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local OnlineHelper = require("uimodule.stage_activity.online_battle.online_battle_helper")
local ui = Util.create_child_mt(Base)
local MODEL_PARAM = MODEL_CONFIG.UI_TEAM_MODEL_PARAM
local Act_ID = CommonDef.ACTY_TYPE.ONLINE_BATTLE
local TRIGGER_SOUND_TYPE = CHARACTER_CONFIG.TRIGGER_SOUND_TYPE
local UnityPlayerPrefs = UnityEngine.PlayerPrefs
local ROOM_CHANGE_TYPE = CommonDef.ROOM_CHANGE_TYPE
local ROOM_ABOUT_MAP = CommonDef.ROOM_ABOUT_MAP
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_count_down = {
    " CountDown",
    BIND_TYPE.OBJECT
  },
  v_auto_toggle = {
    "AutoToggle",
    BIND_TYPE.TOGGLE
  },
  v_btn_ready = {
    "BtnReady",
    BIND_TYPE.BUTTON
  },
  v_btn_start_fight = {
    "BtnStartFight",
    BIND_TYPE.BUTTON
  },
  v_btn_strength = {
    "BtnStrength",
    BIND_TYPE.BUTTON
  },
  v_button_return = {
    "Button_return",
    BIND_TYPE.BUTTON
  },
  v_cant_ready = {
    "CantReady",
    BIND_TYPE.BUTTON
  },
  v_captain_btn_group = {
    "CaptainBtnGroup",
    BIND_TYPE.OBJECT
  },
  v_count_num = {
    "CountNum",
    BIND_TYPE.TEXT
  },
  v_drag_img = {
    "DragImg",
    BIND_TYPE.IMAGE
  },
  v_fight_cost_icon = {
    "FightCostIcon",
    BIND_TYPE.IMAGE
  },
  v_fight_cost = {
    "FightCost",
    BIND_TYPE.TEXT
  },
  v_force_amount = {
    "ForceAmount",
    BIND_TYPE.TEXT
  },
  v_force_max = {
    "ForceMax",
    BIND_TYPE.TEXT
  },
  v_get_ready = {
    "GetReady",
    BIND_TYPE.BUTTON
  },
  v_hero_pos1 = {
    "HeroPos1",
    BIND_TYPE.BUTTON
  },
  v_hero_pos2 = {
    "HeroPos2",
    BIND_TYPE.BUTTON
  },
  v_hero_pos3 = {
    "HeroPos3",
    BIND_TYPE.BUTTON
  },
  v_hero = {
    "Hero",
    BIND_TYPE.OBJECT
  },
  v_info_parent = {
    "InfoParent",
    BIND_TYPE.OBJECT
  },
  v_main = {
    "Main",
    BIND_TYPE.OBJECT
  },
  v_member_btn_group = {
    "MemberBtnGroup",
    BIND_TYPE.OBJECT
  },
  v_ready_cost_icon = {
    "ReadyCostIcon",
    BIND_TYPE.IMAGE
  },
  v_ready_cost = {
    "ReadyCost",
    BIND_TYPE.TEXT
  },
  v_right = {
    "Right",
    BIND_TYPE.OBJECT
  },
  v_select = {
    "Select",
    BIND_TYPE.IMAGE
  },
  v_un_select = {
    "UnSelect",
    BIND_TYPE.IMAGE
  },
  v_up = {
    "Up",
    BIND_TYPE.OBJECT
  },
  v_wait_ready = {
    "WaitReady",
    BIND_TYPE.IMAGE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReady", function()
    self:_onlick_ready_btn()
  end)
  self:set_button("BtnStartFight", function()
    self:_onclick_fight_btn()
  end)
  self:set_button("BtnStrength", function()
    UIMgr:get_ui("uiforcerecharg"):ui_show()
  end)
  self:set_button("Button_return", function()
    self:_onclick_close_btn()
  end)
  self:set_button("CantReady", function()
  end)
  self:set_button("GetReady", function()
    self:_onlick_get_ready_btn()
  end)
  self:set_toggle_listener(self.v_auto_toggle, function(isOn)
    self:_onclick_auto_toggle(isOn)
  end)
  self.v_hero_list = {}
  for i = 1, 3 do
    self.v_hero_list[i] = HERO_CLASS:ui_wrap_ex(self, self["v_hero_pos" .. i], false)
  end
end

function ui:ui_on_show(point_id, ...)
  self.v_point_id = point_id
  self.v_point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  self.v_show_stage_info = true
  self.v_is_inint = true
  self.v_pos_data = {}
  self.v_lie_cfg_list = {}
  self.v_lie_timer_list = {}
  self:_refresh_background()
  self:_init_point_info()
  self:_refresh_cost_info()
  self:_refresh_team_info()
  self:_regist_client_event()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_UI_APPEAR, self._response_show_ui_event, self)
  self:bind_auto_mq(Const.MSG_ROLE_RES_CHANGE, self._refresh_cost_info, self)
  self:bind_auto_mq(Const.MSG_ON_MATCH_ROOM_UPDATE, self._refresh_team_info, self)
  self:bind_auto_mq(Const.MSG_ON_MATCH_ROOM_MEMBER_CHANGE, self._refresh_team_info, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_CUT_DOWN_UPDATE, self._refresh_fight_cut_down_event, self)
  self:bind_auto_mq(Const.MSG_ON_PLAYER_STATE_UPDATE, self._refresh_player_state_update, self)
end

function ui:_response_show_ui_event(msg)
  if nil == msg then
    return
  end
  local show_ui_name = msg.mm_obj
  if show_ui_name == self.v_ui_name then
    self:set_model_enable()
  end
  self:_refresh_team_info()
end

function ui:_refresh_fight_cut_down_event(msg)
  self.v_count_down:SetActive(msg.mm_x)
  self.v_fight_cut_time = msg.mm_y
end

function ui:_refresh_player_state_update(msg)
  if Global.player_uuid ~= msg.mm_x then
    return
  end
  self:_refresh_operate_view()
end

function ui:ui_on_hide()
  self.v_is_inint = true
  self:_release_point_info_obj()
  self.v_pos_data = nil
  self.v_lie_cfg_list = nil
  self.v_lie_timer_list = nil
  if self.v_model_view then
    self.v_model_view:on_destroy()
    self.v_model_view = nil
  end
  self.v_model_idx_list = nil
end

function ui:_release_point_info_obj()
  if self.v_point_info_obj then
    ResMgr:destroy_gameobj(self.v_point_info_obj)
    self.v_point_info_obj = nil
  end
  if self.v_point_info_lua_obj then
    self.v_point_info_lua_obj:set_enable(false)
    self:remove_wrap_ui(self.v_point_info_lua_obj)
  end
end

function ui:ui_on_update(delta_time)
  if self.v_count_down.activeSelf and self.v_fight_cut_time then
    self.v_fight_cut_time = self.v_fight_cut_time - delta_time
    self.v_count_num.text = math.ceil(self.v_fight_cut_time)
  end
  if not self.v_model_view then
    return
  end
  self.v_model_view:update()
  for pos = 1, 3 do
    if not (self.v_lie_cfg_list and self.v_lie_cfg_list[pos]) or not self.v_model_idx_list[pos] then
    else
      if not self.v_lie_timer_list[pos].is_playing then
        self.v_lie_timer_list[pos].cd = self.v_lie_timer_list[pos].cd + GlobalTimeMgr:get_dt_time()
      end
      if self.v_lie_timer_list[pos].cd > self.v_lie_cfg_list[pos].LieCd and not self.v_lie_timer_list[pos].is_playing then
        local random_act = self.v_lie_cfg_list[pos].Act[math.random(#self.v_lie_cfg_list[pos].Act)]
        local model_index = self.v_model_idx_list[pos]
        self.v_model_view:play_anim(random_act, model_index, function()
          self.v_lie_timer_list[pos].cd = 0
          self.v_lie_timer_list[pos].is_playing = false
        end)
        self.v_lie_timer_list[pos].is_playing = true
      end
    end
  end
end

function ui:_refresh_background()
  self:_change_bg_state(true)
  if not self.v_model_view then
    self.v_model_view = ModelRtView:new(MODEL_PARAM.BG_NAME, nil, function()
      self:_change_bg_state(false)
    end)
  end
end

function ui:_init_point_info()
  self:_release_point_info_obj()
  if self.v_point_cfg.PointDesc ~= nil then
    return
  end
  local path = Path.get_language_full_prefab_path(CHAPTER_CONFIG.POINT_INFO_RES_PATH)
  local point_info_obj = ResMgr:load_gameobj(path)
  point_info_obj.transform:SetParent(self.v_uiobjects.InfoParent.transform, false)
  self.v_point_info_obj = point_info_obj
  self.v_point_info_lua_obj = POINT_INFO_CLASS:ui_wrap_ex(self, point_info_obj, false)
  self.v_point_info_lua_obj:set_enable(true, nil, self.v_point_id)
  self.v_point_info_lua_obj:update_info_btn_visible(true)
end

function ui:check_fight()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  local cost_val = point_cfg.FightCost[2]
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.CHAPTER then
    local first_fight = ChapterMgr:check_no_first_suc_by_point_id(self.v_chapter_id, self.v_point_id)
    if first_fight then
      cost_val = point_cfg.FightCost[1]
    end
    local point_data = ChapterMgr:get_point_data_by_id(self.v_chapter_id, self.v_point_id)
    if not point_data then
      Util.show_message_tip(2043)
      return
    end
    local daily_fight_Num = point_cfg.FightNum
    local cur_fight_num = point_data.buy_challenge_cnt + daily_fight_Num
    if cur_fight_num <= point_data.daily_challenge_cnt then
      Util.show_message_tip(1058)
      self:buy_challenge_num()
      return
    end
  end
  local cur_val = BagMgr:get_item_num(Config.PLAYER_SP_ITEMID)
  if cost_val > cur_val then
    Util.show_message_tip(2216)
    return
  end
  local min_fight_num = point_cfg.MinFightCount
  local is_meet = true
  if not self.is_fixed_point then
    local main_num = FormationMgr:get_common_num_by_id(self.v_formation_type, self.v_fight_type)
    if min_fight_num > main_num then
      is_meet = false
    end
  else
    local cur_num = UtilTable.hash_lenth(self.v_pos_data)
    if min_fight_num > cur_num then
      is_meet = false
    end
  end
  if not is_meet then
    Util.show_message_tip(2318, min_fight_num)
  end
  if not self.v_model_idx_list[self.v_cur_starting_pos] then
    Util.show_message_tip(2217)
    return
  end
  return true
end

function ui:buy_challenge_num()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  local cost_id = point_cfg.BuyFightNumCost[1]
  local cost_num = point_cfg.BuyFightNumCost[2]
  local item_cfg = ShareRes.get_item_cfg(cost_id)
  
  local function sure_callback()
    local item_num = BagMgr:get_item_num(cost_id)
    if item_num < cost_num then
      Util.show_message_tip(2115)
      return
    end
    ChapterMgr:buy_challenge_num(self.v_chapter_id, self.v_point_id)
  end
  
  local tip = string.format("是否使用%s增加1次挑战次数", item_cfg.Name .. "：" .. cost_num)
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip)
end

function ui:_refresh_cost_info()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  local has_pass = ActivityMgr:invoke(Act_ID, "get_point_has_passed", self.v_point_id)
  local cost_val = has_pass and point_cfg.FightCost[2] or point_cfg.FightCost[1]
  local cur_val = BagMgr:get_item_num(Config.PLAYER_SP_ITEMID)
  self.v_uicompents.ForceAmount_txt.text = cur_val
  local item_cfg = ShareRes.get_item_cfg(Config.PLAYER_SP_ITEMID)
  local item_maxnum = CharacterMgr:get_res_force_max_val()
  self.v_uicompents.ForceMax_txt.text = item_maxnum
  self.v_ready_cost.text = cost_val
  self.v_fight_cost.text = cost_val
end

function ui:_refresh_team_info()
  self:_refresh_model_view()
  self:_refresh_operate_view()
end

function ui:_refresh_model_view()
  local team_role_list = ActivityMgr:invoke(Act_ID, "get_hero_list")
  local buddy_list = CharacterMgr:get_buddy_list_show()
  for _, v in pairs(buddy_list) do
    v.team = 0
    for _, member in ipairs(team_role_list) do
      if member.buddy_info.id == v.id then
        v.team = 1
      end
    end
  end
  self:_clear_model_list()
  for i = 1, 3 do
    local uiobj = self.v_hero_list[i]
    uiobj:set_enable(false)
    uiobj:set_enable(true, i, team_role_list)
  end
end

function ui:_refresh_operate_view()
  local role_list = ActivityMgr:invoke(Act_ID, "get_hero_list")
  self.v_is_leader = false
  for _, v in ipairs(role_list) do
    if v.uuid == Global.player_uuid and v.pos == OnlineConfig.MEMBER_TITLE.LEADER then
      self.v_is_leader = true
      break
    end
  end
  self.v_auto_toggle:SetActive(self.v_is_leader)
  self.v_captain_btn_group:SetActive(self.v_is_leader)
  self.v_member_btn_group:SetActive(not self.v_is_leader)
  self.v_count_down:SetActive(false)
  if self.v_is_leader then
    self:_refresh_leader_operate()
  else
    self:_refresh_member_operate()
  end
end

function ui:_refresh_leader_operate()
  local match_info = ActivityMgr:invoke(Act_ID, "get_match_room_info")
  self.v_auto_toggle.isOn = 1 == match_info.match
  local is_all_ready = true
  local role_list = ActivityMgr:invoke(Act_ID, "get_hero_list")
  local team_num = #role_list
  for _, v in ipairs(role_list) do
    if v.state ~= ROOM_ABOUT_MAP.STATE_MAP.READY then
      is_all_ready = false
      break
    end
  end
  self.v_wait_ready:SetActive(not is_all_ready or team_num < 3)
  self.v_btn_start_fight:SetActive(is_all_ready)
end

function ui:_refresh_member_operate()
  local my_info
  local role_list = ActivityMgr:invoke(Act_ID, "get_hero_list")
  for _, v in ipairs(role_list) do
    if v.uuid == Global.player_uuid then
      my_info = v
      break
    end
  end
  if not my_info then
    self.v_member_btn_group:SetActive(false)
    return
  end
  local same_with_other = false
  local my_role_id = role_list[1].buddy_info.id
  for i = 2, 3 do
    if role_list[i] and my_role_id == role_list[i].buddy_info.id then
      same_with_other = true
      break
    end
  end
  self.v_cant_ready:SetActive(my_info.state == ROOM_ABOUT_MAP.STATE_MAP.NOT_READY and same_with_other)
  local can_ready = my_info.state == ROOM_ABOUT_MAP.STATE_MAP.CHOICE_ROLE or my_info.state == ROOM_ABOUT_MAP.STATE_MAP.NOT_READY and not same_with_other
  self.v_btn_ready:SetActive(can_ready)
  self.v_get_ready:SetActive(my_info.state == ROOM_ABOUT_MAP.STATE_MAP.READY)
end

function ui:_onclick_auto_toggle(isOn)
  local key = ROOM_CHANGE_TYPE.ROOM_AUTOMATCH
  local value = isOn and ROOM_ABOUT_MAP.MATCH_MAP.AUTO_MATCH or ROOM_ABOUT_MAP.MATCH_MAP.NOT_MATCH
  ActivityMgr:invoke(Act_ID, "request_change_roomstate", key, value)
  local auto = isOn and 1 or 0
  UnityPlayerPrefs.SetInt("auto_match_remmber", auto)
end

function ui:_onclick_close_btn()
  local in_matching = ActivityMgr:invoke(Act_ID, "get_in_matching")
  if in_matching then
    OnlineHelper.quit_match(self)
    return
  end
  local in_room = ActivityMgr:invoke(Act_ID, "get_match_room_info") ~= nil
  if in_room then
    OnlineHelper.quit_room(self)
    return
  end
  self:ui_hide()
end

function ui:_onlick_ready_btn()
  self:_set_ready(true)
end

function ui:_onlick_get_ready_btn()
  self:_set_ready(false)
end

function ui:_set_ready(is_ready)
  local role_list = ActivityMgr:invoke(Act_ID, "get_hero_list")
  local my_role_id = role_list[1].buddy_info.id
  for i = 2, 3 do
    if role_list[i] and my_role_id == role_list[i].buddy_info.id then
      Util.show_message_tip(2044)
      return
    end
  end
  
  local function cb()
    self.v_btn_ready:SetActive(false)
    self.v_get_ready:SetActive(true)
  end
  
  local key = ROOM_CHANGE_TYPE.PLAYER_STATE
  local value = is_ready and ROOM_ABOUT_MAP.STATE_MAP.READY or ROOM_ABOUT_MAP.STATE_MAP.NOT_READY
  ActivityMgr:invoke(Act_ID, "request_change_roomstate", key, value, cb)
end

function ui:_onclick_fight_btn()
  ActivityMgr:invoke(Act_ID, "request_joinwar_room", function()
    self:ui_hide()
  end)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_point_id
end

function ui:_clear_model_list()
  if self.v_model_idx_list then
    for _, idx in pairs(self.v_model_idx_list) do
      self.v_model_view:remove_npc_by_index(idx)
    end
  end
  self.v_model_idx_list = {}
  local init_camera_param = MODEL_PARAM.INIT_CAMERA_PARAM
  self.v_model_view:set_camera_param(init_camera_param)
end

function ui:set_model(pos_id, buddy_id, fashion_id)
  local NPC_PARAM_LIST = MODEL_PARAM.MUL_NPC_PARAM
  if buddy_id and 0 ~= buddy_id then
    local buddy_cfg = ShareRes.create("buddy.buddy", buddy_id)
    if 0 == fashion_id then
      fashion_id = ShareRes.create("buddy.buddy", buddy_id).FashionInitId
    end
    local model_id = ShareRes.create("buddy.buddy_fashion", fashion_id).ModelId
    if not model_id then
      Log.Error("get hero model id failure, buddy_id=", buddy_id, buddy_cfg.ModelId)
      return
    end
    local npc_param = {
      pos_x = NPC_PARAM_LIST[pos_id].pos_x,
      pos_y = NPC_PARAM_LIST[pos_id].pos_y,
      pos_z = NPC_PARAM_LIST[pos_id].pos_z
    }
    local params = {
      model_id = model_id,
      npc_id = buddy_cfg.ModelId,
      npc_param = npc_param,
      team_pos = pos_id
    }
    local model_idx = self.v_model_view:load_npc(params)
    self.v_model_idx_list[pos_id] = model_idx
    self.v_model_view:load_signboard_npc_param(NPC_PARAM_LIST[pos_id], model_idx)
    self.v_pos_data[pos_id] = buddy_id
  else
    self.v_pos_data[pos_id] = 0
    if self.v_model_idx_list[pos_id] then
      self.v_model_view:remove_npc_by_index(self.v_model_idx_list[pos_id])
      self.v_model_idx_list[pos_id] = nil
    end
  end
  self:_set_lie_cfg_list(pos_id, self.v_pos_data[pos_id])
end

function ui:_set_lie_cfg_list(pos, buddy_id)
  if 0 ~= buddy_id then
    self.v_lie_cfg_list[pos] = ShareRes.get_buddy_lie_cfg(buddy_id)
  else
    self.v_lie_cfg_list[pos] = nil
  end
  for index = 1, 3 do
    local data = {}
    data.cd = 0
    data.is_playing = false
    self.v_lie_timer_list[index] = data
  end
end

function ui:_random_play_buddy_sound()
  local buddy_list = {}
  for _, data in pairs(self.v_pos_data) do
    if 0 ~= data.buddy_id then
      table.insert(buddy_list, data.buddy_id)
    end
  end
  if #buddy_list <= 0 then
    return
  end
  local buddy_id = buddy_list[math.random(1, #buddy_list)]
  CharacterMgr:trigger_buddy_sound(TRIGGER_SOUND_TYPE.GOTO_TEAM, buddy_id)
end

function ui:set_model_enable()
  if self.v_model_view then
    self.v_model_view:set_visible(true)
    self:_change_bg_state(false)
  end
end

function ui:set_model_disable()
  if self.v_model_view then
    self.v_model_view:set_visible(false)
  end
end

function ui:_change_bg_state(is_on)
  self.v_uiobjects.FullScreenBackground:SetActive(is_on)
end

return ui
