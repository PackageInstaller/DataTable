local Base = require("ui.uibase")
local SkillIndicator = require("uimodule.fight.skill_indicator")
local SwitchHeroHelper = require("gamelogic.switch_hero.swtich_hero")
local CommonDefine = require("cs_share.common_define")
local Setting_Cfg = require("uimodule.battle_setting.battle_setting_cfg")
local ui = Util.create_child_mt(Base)
local FightCfg = require("uimodule.fight.fight_config")
local ETCJoystick = CS.ETCJoystick
local LowUpdateImage = require("uimodule.fight.in_game.low_update_image")
local LowUpdateSlider = require("uimodule.fight.in_game.low_update_slider")
local Fight_Layout_Cfg = require("uimodule.fight.custom_button.fight_layout_cfg")
local LowUpdateText = require("uimodule.fight.in_game.low_update_text")
local QuantumView = require("uimodule.fight.fight_quantum_view")
local ImgLowUpdateInterval = 2
local TxtLowUpdateInterval = 5
local LowUpdateInterval = 0.04
local _insert = table.insert
local MAX_TARGET_COUNT = 2
local EMPTY_STR = ""
local INFINITY = "∞"
local SEN_STR = "%.1fS"
local CANCLE_STATE_IMAGE_PATH = {
  [true] = "Common_an_fight01_",
  [false] = "Common_an_fight03_"
}
local CANVAS_VISIBLE_STATE = {VISIBLE = 1, INVISIBLE = 2}
local CONSUME_TEMPLETE_KEY = "CONSUME_TEMPLETE_KEY"
local CHARGSLD_TEMPLETE_KEY = "CHARGSLD_TEMPLETE_KEY"
local joystick_init_posx, joystick_init_posy, joystick_init_posz
local BTN_NAME_2_SKILL_INDEX = Config.BTN_NAME_2_SKILL_INDEX
local BEHIT_INTERRUPT_TYPE = Config.BEHIT_INTERRUPT_TYPE
local BIND_TYPE = Config.BIND_TYPE
local INPUT_CODE = Config.INPUT_CODE
local NORMAL_ATK = 1
local SKILL_NORMAL_END = 8
local DO_ANIMA_LOWER_LIMIT = 0.05
local ANIMA_MILT = 5
local AIM_JOYSTICK_CODE = INPUT_CODE.AIM_JOYSTICK
local TOWER_SKILL_BTN = 8
local FightDefine = require("cs_share.fight_define")
local SceneDef = require("cs_share.scene_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local AREA_TYPE = SceneDef.AREA_TYPE
local SKILL_ATTACK_TYPE = Config.SKILL_ATTACK_TYPE
local TOWER_SKILL_KEY = 8
local INFINITE_EFFECT_TYPE = CommonDefine.INFINITE_EFFECT_TYPE
local BATTLE_SKILL_TYPE = {normal = 1, mastery = 2}
local RESTORE_MAGIC_ID = 4010006
local QTE_SHOW_SKILL_IDX = 7
local SKILL_INPUT_COUDE = {
  [1] = INPUT_CODE.INPUT_COMMON,
  [2] = INPUT_CODE.INPUT_SPECAIL_SKILL,
  [3] = INPUT_CODE.INPUT_SKILL1,
  [4] = INPUT_CODE.INPUT_SKILL2,
  [5] = INPUT_CODE.INPUT_SKILL3,
  [6] = INPUT_CODE.TPS_SKILL,
  [7] = INPUT_CODE.TPS_ATK_SKILL,
  [TOWER_SKILL_KEY] = INPUT_CODE.TOWER_SKILL
}
local INPUT_COUDE_SKILL_INDEX = {
  [INPUT_CODE.INPUT_COMMON] = 1,
  [INPUT_CODE.INPUT_SPECAIL_SKILL] = 2,
  [INPUT_CODE.INPUT_SKILL1] = 3,
  [INPUT_CODE.INPUT_SKILL2] = 4,
  [INPUT_CODE.INPUT_SKILL3] = 5,
  [INPUT_CODE.TPS_SKILL] = 6,
  [INPUT_CODE.TPS_ATK_SKILL] = 7,
  [INPUT_CODE.TOWER_SKILL] = TOWER_SKILL_KEY
}
local ENERGY_TIME_NAME = {
  [BTN_NAME_2_SKILL_INDEX.Btn_skill1] = "EnergyTime1",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill2] = "EnergyTime2",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill3] = "EnergyTime3",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill4] = "EnergyTime4",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill5] = "EnergyTime5",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill7] = "EnergyTime7",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill8] = "EnergyTime8"
}
local SKILL_CD_NOT_ENOUGH_NAME = {
  [BTN_NAME_2_SKILL_INDEX.Btn_skill3] = "FxSkillCdNotEnough3",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill4] = "FxSkillCdNotEnough4",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill5] = "FxSkillCdNotEnough5",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill8] = "FxSkillCdNotEnough8"
}
local CHARGE_SKILL_NAME = {
  [BTN_NAME_2_SKILL_INDEX.Btn_skill1] = "Charge_skill_1",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill2] = "Charge_skill_2",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill3] = "Charge_skill_3",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill4] = "Charge_skill_4",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill5] = "Charge_skill_5",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill6] = "Charge_skill_6",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill7] = "Charge_skill_7",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill8] = "Charge_skill_8"
}
local DOWN_SKILL_NAME = {
  [BTN_NAME_2_SKILL_INDEX.Btn_skill1] = "Down_skill_1",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill2] = "Down_skill_2",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill3] = "Down_skill_3",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill4] = "Down_skill_4",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill5] = "Down_skill_5",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill6] = "Down_skill_6",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill7] = "Down_skill_7",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill8] = "Down_skill_8"
}
local BTN_SKILL_NAME = {
  [BTN_NAME_2_SKILL_INDEX.Btn_skill1] = "Btn_skill1",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill2] = "Btn_skill2",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill3] = "Btn_skill3",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill4] = "Btn_skill4",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill5] = "Btn_skill5",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill6] = "Btn_skill6",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill7] = "Btn_skill7",
  [BTN_NAME_2_SKILL_INDEX.Btn_skill8] = "Btn_skill8"
}
local ATTACK_SKILL_LIST = {
  [INPUT_CODE.INPUT_COMMON] = true,
  [INPUT_CODE.INPUT_SKILL2] = true,
  [INPUT_CODE.INPUT_SKILL3] = true
}
local NEED_UPDATE_EXPEND_BTN = {
  [BTN_NAME_2_SKILL_INDEX.Btn_skill4] = true,
  [BTN_NAME_2_SKILL_INDEX.Btn_skill5] = true
}
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local SKILL_BUTTON_INDEX = {
  [BTN_NAME_2_SKILL_INDEX.Btn_skill3] = BTN_SKILL_NAME[BTN_NAME_2_SKILL_INDEX.Btn_skill3],
  [BTN_NAME_2_SKILL_INDEX.Btn_skill4] = BTN_SKILL_NAME[BTN_NAME_2_SKILL_INDEX.Btn_skill4],
  [BTN_NAME_2_SKILL_INDEX.Btn_skill5] = BTN_SKILL_NAME[BTN_NAME_2_SKILL_INDEX.Btn_skill5]
}
local OBJ_VISIBLE_TYPE = Config.FIGHT_OBJ_VISIBLE_TYPE
local OBJ_VISIBLE_STATE = Config.OBJ_VISIBLE_STATE
local CHARGED_TYPE = {CIRCULAR_CHARGED = 1, SLIDER_CHARGED = 2}
local SKILL_BTN_PARAM_TYPE = {
  ATTR = 1,
  TIME = 2,
  MAGIC_TIME = 3
}
local DYNAMIC_LOAD_EFFECT_NAME = {
  TeamSkill_Guid = "Skill_Guid",
  Strengthen_skill_ = "Strengthen_skill_",
  Down_skill_ = "Down_skill_",
  Charge_skill_ = "Charge_skill_",
  Skill_Guid = "Skill_Guid",
  PickBallEffect = "PickBallEffect",
  FightSkill = "FightSkill"
}
local CUSTOM_KEY_MAP = {
  PCTouch3 = Setting_Cfg.BTNNAME_INFO.ButtonDodge.key,
  PCTouch1 = Setting_Cfg.BTNNAME_INFO.ButtonBasicAttack.key,
  PCTouch2 = Setting_Cfg.BTNNAME_INFO.ButtonComboBurst.key,
  PCTouch4 = Setting_Cfg.BTNNAME_INFO.ButtonSkill1.key,
  PCTouch5 = Setting_Cfg.BTNNAME_INFO.ButtonSkill2.key,
  PCTouch7 = Setting_Cfg.BTNNAME_INFO.ButtonUltSkill.key,
  PCTouch8 = Setting_Cfg.BTNNAME_INFO.ButtonStageSkill.key,
  PCTouchInteract = Setting_Cfg.BTNNAME_INFO.ButtonInteract.key
}
local CUSTOM_KEY_MAP_1 = {
  ["ChangHero1_/PCTouchHero"] = Setting_Cfg.BTNNAME_INFO.ButtonSwitchChar1.key,
  ["ChangHero2_/PCTouchHero"] = Setting_Cfg.BTNNAME_INFO.ButtonSwitchChar2.key
}
local ARROW_KEY_MAP = {
  PCTouchUp = Setting_Cfg.BTNNAME_INFO.ButtonForward.key,
  PCTouchDown = Setting_Cfg.BTNNAME_INFO.ButtonBackward.key,
  PCTouchLeft = Setting_Cfg.BTNNAME_INFO.ButtonLeft.key,
  PCTouchRight = Setting_Cfg.BTNNAME_INFO.ButtonRight.key
}
local inputcode_to_uiwidget = {
  [INPUT_CODE.INPUT_COMMON] = "Btn_skill1",
  [INPUT_CODE.INPUT_SPECAIL_SKILL] = "Btn_skill2",
  [INPUT_CODE.INPUT_SKILL1] = "Btn_skill3",
  [INPUT_CODE.INPUT_SKILL2] = "Btn_skill4",
  [INPUT_CODE.INPUT_SKILL3] = "Btn_skill5",
  [INPUT_CODE.QTE1] = "ChangHero1",
  [INPUT_CODE.QTE_UltSkill_1] = "ChangHero1",
  [INPUT_CODE.QTE2] = "ChangHero2",
  [INPUT_CODE.QTE_UltSkill_2] = "ChangHero2",
  [INPUT_CODE.TOWER_SKILL] = "Btn_skill8",
  [INPUT_CODE.TPS_ATK_SKILL] = "Btn_skill7",
  [INPUT_CODE.INPUT_INTERACT] = "Btn_Interact"
}
local special_inputcode = {
  [INPUT_CODE.INPUT_NAVIGATION] = true
}
local MULIT_DYNAMIC_LOAD_EFFECT = {
  [DYNAMIC_LOAD_EFFECT_NAME.Strengthen_skill_] = {
    start = "Fx_UI_strengthen_Show",
    loop = "Fx_UI_strengthen"
  }
}
local DYNAMIC_LOAD_EFFECT = {
  [DYNAMIC_LOAD_EFFECT_NAME.Down_skill_] = FightCfg.FIGHT_UI_EFFECT.Fx_UI_FightSkill02,
  [DYNAMIC_LOAD_EFFECT_NAME.Charge_skill_] = FightCfg.FIGHT_UI_EFFECT.Fx_UiFightSkill01,
  [DYNAMIC_LOAD_EFFECT_NAME.Skill_Guid] = FightCfg.FIGHT_UI_EFFECT.Fx_Skill_Guid,
  [DYNAMIC_LOAD_EFFECT_NAME.PickBallEffect] = FightCfg.FIGHT_UI_EFFECT.FX_ultimate_obtain_flash,
  [DYNAMIC_LOAD_EFFECT_NAME.FightSkill] = FightCfg.FIGHT_UI_EFFECT.Fx_UI_FightSkill02_Loop
}
local FIGHT_TASK_VIEW = require("uimodule.fight.fight_task")
local FIGHT_LOCATION_VIEW = require("uimodule.fight.fight_location")
local BATTLE_TASK_CFG = require("uimodule.fight_task.battle_task_config")
local TASK_STATE = BATTLE_TASK_CFG.TASK_STATE
local NOTICE_TYPE = BATTLE_TASK_CFG.NOTICE_TYPE
local TASK_TYPE = BATTLE_TASK_CFG.TASK_TYPE
local ButtonStateCd = ShareRes.get_comm_value("ButtonStateCd") or 0.1
ui.touch_index = -1

function ui:ui_finish_load()
  self.v_last_updated_time = Global.time
  self.v_qte_skill_fill_offset_param = {
    fill = {
      max = 0.4,
      min = -0.4,
      offset = 0,
      is_add = true
    },
    rote = {
      max = 0.6,
      min = -0.6,
      offset = 0,
      is_add = true
    }
  }
  self.v_uiobjects.PanelJoystick:TryAddComponent(typeof(CS.BnH.JoystickEventReveiver))
  local canvas_scaler = self:get_component(nil, nil, UnityEngine.UI.CanvasScaler)
  if nil ~= canvas_scaler then
    canvas_scaler.matchWidthOrHeight = ScreenMgr:get_fight_ui_match()
  end
  self.v_uifight_rect = Util.get_rect_transform(nil, self.v_object_transform)
  self:set_button("Clickpoint", function()
    self:try_show_navigation()
  end)
  self:set_button("TaskMainBtn", function()
    UIMgr:get_ui("battle_task_main"):ui_show()
  end)
  self:set_button("Button_Pause", function()
    self:open_battle_bag()
  end)
  self:set_button("Button_Tp", function()
    self:open_tp_view()
  end)
  self:register_exist_auto_template(CONSUME_TEMPLETE_KEY, self.v_uiobjects.ConsumeTem, self.v_uiobjects.TempleteRoot)
  self:register_exist_auto_template(CHARGSLD_TEMPLETE_KEY, self.v_uiobjects.ChargSldTemple, self.v_uiobjects.TempleteRoot)
  self:init_data()
  self:init_ui()
  if Global.camera then
    Global.camera:check_change_switch_sp_bg_on_init()
  end
  self.v_is_interact = false
  self.v_heads_view = self.v_panels.hero_head_view
end

function ui:ui_all_finish_load()
  self:load_setting_layout()
  self:preload()
end

function ui:preload()
  local room = TowerMgr and TowerMgr:get_cur_room()
  if not room or not room:get_room_preload_cfg() then
    return
  end
  for _, panel in pairs(self.v_panels) do
    if panel.preload then
      panel:preload()
    end
  end
end

function ui:on_scene_reload_end()
  self:init_data(true)
  SkillIndicator.init(self)
  for i = NORMAL_ATK, SKILL_NORMAL_END do
    local btn = self.v_uicompents["Btn_skill" .. i .. "_btn"]
    SkillIndicator.init_uikey(SKILL_INPUT_COUDE[i], btn.transform, i)
  end
  SkillIndicator.init_cancle_ui(self:get_uiobject("CancleSkill", BIND_TYPE.OBJECT))
end

function ui:init_data(reload)
  self.v_attr_change_chche = {}
  self.v_target_uuid_map = {}
  self.v_object_canvas_group_map = {}
  if not reload then
    self:clear_ui_effect()
  end
  self.v_ui_effect = {}
  self.v_button_element_effect = {}
  self.v_obejct_canvas_visivle_state = {}
  self.v_panels.enemy_bar:set_target_uuid_map(self.v_target_uuid_map)
  self:update_fight_skill_list()
  self:update_fight_data()
end

function ui:init_ui()
  self.v_low_update_comps = {}
  self.v_low_update_comp_map = {}
  self.v_hero_have_skill = {}
  self.v_btn_charging_params = {}
  self.v_skill_image = {}
  self.v_skill_time_text = {}
  self.v_skill_charging_img = {}
  self.v_skill_charge_list = {}
  self.v_skill_charge_text = {}
  self.v_skill_mask_list = {}
  self.v_skill_cd_not_enough_fx_list = {}
  self.v_skill_pointer_list = {}
  self.v_skill_line_list = {}
  self.v_skill_cd_fx_is_showing = {}
  self.v_button_state_list = {}
  self.v_cur_input_index = nil
  self.v_button_state_cd_list = {}
  self.v_key_down = {}
  self.v_ui_node_visible_state = {}
  self.v_tower_energy = {}
  self.v_magic_num_content = {}
  self.v_magic_num_text = {}
  self.v_expend_count_root = {}
  self.v_expend_obj_list = {}
  self.v_eff_release_timer_map = {}
  self.v_mgr_effect_to_root = {}
  self.v_skill_btn_root = self:get_uiobject("SkillBtnRoot", BIND_TYPE.OBJECT)
  self.v_uicompents.QteSlider_sld.value = 0
  for i = NORMAL_ATK, SKILL_NORMAL_END do
    self:init_ui_obj(i)
    self.v_magic_num_content[i] = self:get_uiobject("MagicNum" .. i, BIND_TYPE.OBJECT)
    self.v_magic_num_text[i] = self:get_uiobject("NumText" .. i, BIND_TYPE.TEXT)
    self.v_magic_num_content[i].gameObject:SetActive(false)
    self.v_expend_count_root[i] = self:get_uiobject("Consume" .. i, BIND_TYPE.TRANSFORM)
    if NEED_UPDATE_EXPEND_BTN[i] then
      self.v_expend_obj_list[i] = {}
    end
  end
  self.v_uiobjects.Button_Tp:SetActive(not Util.is_client_only() and self:need_show_button_tp())
  if TowerMgr then
    local tower_type = TowerMgr:get_tower_type()
    local tower = TowerMgr:get_tower()
    if tower_type == CommonDefine.CHALLENGE_TYPE.CHAPTER or tower_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
      local can_tp = tower and tower:can_archieve()
      self.v_uiobjects.Button_Tp:SetActive(can_tp)
      self.v_uicompents.Button_Tp_Text_txt.text = Util.format_str("传送")
      self.v_uiobjects.Button_Tp:SetActive(false)
    elseif tower_type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
      self.v_uicompents.Button_Tp_Text_txt.text = Util.format_str("命运之书")
    else
      self.v_uiobjects.Button_Tp:SetActive(false)
    end
  end
  self.v_charge_sld_effec_list = {}
  self.v_fight_task = FIGHT_TASK_VIEW:new(self)
  self.v_canvas = self.v_object.gameObject:GetComponent(typeof(UnityEngine.Canvas))
  SkillIndicator.init(self)
  self.v_uiobjects.EXSkillEffect7:SetActive(false)
  self.v_uiobjects.QteSlider:SetActive(false)
  self.v_uiobjects.Btn_skill2:SetActive(false)
  self.v_btn_skill2_dot = self.v_uicompents.Btn_skill2_cg:DOFade(1, 0.5)
  self.v_btn_skill2_dot:Pause()
  self.v_btn_skill2_dot:ChangeStartValue(0)
  self.v_btn_skill2_dot:SetAutoKill(false)
  self.v_btn_skill2_dot:OnRewind(function()
    if self:has_inited() then
      self:update_ui_visible(self.v_uiobjects.Btn_skill2, false)
      self:release_ui_effect(FightCfg.FIGHT_UI_EFFECT.Fx_Btn_skill2_Loop)
    end
  end)
  self.v_uicompents.Btn_skill2_cg.alpha = 1
end

function ui:need_show_button_tp()
  local fight_info = TowerMgr:get_fight_info()
  if fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.LINEAR then
    return false
  end
  return true
end

function ui:update_hero_info(msg)
  self.v_heads_view:force_reset_head_info()
  local uuid = msg.mm_x
  local not_refresh_parent = msg.mm_y
  if not_refresh_parent then
    return
  end
  self:update_fight_skill_list(uuid)
end

function ui:init_ui_obj(index)
  local low_update_image, low_update_text
  self.v_skill_image[index] = self.v_uicompents["InnerC" .. index .. "_img"]
  low_update_text = LowUpdateText:new(self.v_uicompents["Time" .. index .. "_txt"], 1, TxtLowUpdateInterval)
  self.v_skill_time_text[index] = low_update_text
  self:set_skill_time_text(index, EMPTY_STR)
  _insert(self.v_low_update_comps, low_update_text)
  local enengy_img = self.v_uicompents["enengyC" .. index .. "_img"]
  low_update_image = LowUpdateImage:new(enengy_img, 0, ImgLowUpdateInterval)
  self.v_skill_charging_img[index] = low_update_image
  _insert(self.v_low_update_comps, low_update_image)
  self.v_skill_charge_list[index] = self.v_uiobjects["Charge" .. index]
  if self.v_skill_charge_list[index] then
    local skill_charge_text = self:get_text("Text", self.v_skill_charge_list[index]).component
    low_update_text = LowUpdateText:new(skill_charge_text, 1, TxtLowUpdateInterval)
    self.v_skill_charge_text[index] = low_update_text
    _insert(self.v_low_update_comps, low_update_text)
  end
  local skill_mask_iamge = self.v_uicompents["SkillMask" .. index .. "_img"]
  low_update_image = LowUpdateImage:new(skill_mask_iamge, 1, ImgLowUpdateInterval)
  self.v_skill_mask_list[index] = low_update_image
  _insert(self.v_low_update_comps, low_update_image)
  self.v_skill_cd_not_enough_fx_list[index] = self.v_uiobjects[SKILL_CD_NOT_ENOUGH_NAME[index]]
  self.v_skill_pointer_list[index] = self.v_uiobjects["PointerNode" .. index].transform
  self.v_skill_line_list[index] = self.v_uiobjects["Line" .. index]
  self.v_skill_cd_fx_is_showing[index] = false
  if self.v_skill_cd_not_enough_fx_list[index] then
    self.v_skill_cd_not_enough_fx_list[index]:SetActive(false)
    self:register_effect_status(SKILL_CD_NOT_ENOUGH_NAME[index])
  end
  self.v_cur_scene_skill_lv = 0
  self.v_last_scene_skill_lv = 0
end

function ui:ui_on_show()
  self.v_skill_update = {}
  self.v_ui_effect = self.v_ui_effect or {}
  self:check_joystick_canvasgroup()
  self:check_game_play_logic()
  self.v_uicompents.Btn_Interact_btn.gameObject:SetActive(false)
  self.v_slider_charged = {}
  self.v_fight_task:init_view()
  self.v_fight_location = FIGHT_LOCATION_VIEW:new(self)
  self:on_up_all_code()
  if not Util.is_client_only() then
    self:update_skill_list()
  end
  self:init_event()
  self:update_tower_skill()
  if not Util.is_client_only() then
    self:update_btn_state()
  end
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_ACTIVE_ROOM)
  self.v_panels.fight_npc:set_enable(true, self)
  self.v_delta_time = 0
  self:on_track_task_id()
  for i = NORMAL_ATK, SKILL_NORMAL_END do
    self:_update_skill(i)
  end
  self:change_button(false)
  if self.v_god_skill then
    self:_update_skill(TOWER_SKILL_KEY)
  end
  if TowerMgr then
    local fight_info = TowerMgr:get_fight_info()
    if fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
      UIMgr:get_ui("skill_teach_main"):ui_show()
    end
  end
  self:_set_team_skill_view()
  self:update_sp_sld_val()
  self:check_is_need_show_tips_obj()
  self:auto_adapt_joystick()
  self:check_function_btn_visible()
  self:update_team_skill_energy()
  self:init_ult_skill_enabled()
  self:reset_active_button_effect()
  if SDKManager:is_google_play_games() or UNITY_EDITOR or UNITY_STANDALONE_WIN then
    self:update_input_setting_view()
  end
end

function ui:auto_adapt_joystick()
  local obj_rt = self.v_object.transform:GetComponent(TypeUnityRectTransform)
  if nil == obj_rt then
    Log.Error("战斗UI 未找到组件RectTransform ")
    return
  end
  local joystick_obj = self.v_uiobjects.JoystickContent
  local safe_area_rect = Util.get_rect_transform("SafeArea", self.v_object)
  if nil == safe_area_rect then
    Log.Error("战斗UI 未找到SafeArea对象 ")
    return
  end
  local ax, ay = safe_area_rect:GetAnchoredMinMax()
  local w, h = safe_area_rect:GetRectWH()
  local offsetX = w * ax
  local offsetY = h * ay
  local joystick_rt = joystick_obj.transform:GetComponent(TypeUnityRectTransform)
  if Util.is_nil(safe_area_rect) then
    Log.Error("JoystickContent_ 未找到组件RectTransform")
    return
  end
  joystick_rt:SetOffsetMinMax(-1 * offsetX, -1 * offsetY, offsetX, offsetY)
  if nil == joystick_init_posx then
    joystick_init_posx, joystick_init_posy, joystick_init_posz = joystick_obj.transform:GetLocalPositionA3()
  end
  joystick_obj.transform:SetLocalPositionA(joystick_init_posx + offsetX, joystick_init_posy, joystick_init_posz)
end

function ui:check_is_need_show_tips_obj()
  local is_show_tips_obj = false
  if TowerMgr and TowerMgr:get_tower_progress() and next(TowerMgr:get_tower_progress().award_list) ~= nil and TowerMgr:get_tower_progress().challenge_type == CommonDefine.CHALLENGE_TYPE.CUT_GRASS then
    is_show_tips_obj = true
    self.v_panels.drop_tips:set_data()
  end
  self.v_panels.drop_tips:set_enable(is_show_tips_obj)
end

function ui:check_joystick_canvasgroup()
  local canvas_group = self.v_uicompents.JoystickContent_cg
  if canvas_group and not canvas_group:IsNull() then
    canvas_group.alpha = 1
  end
end

function ui:check_joystick_move()
  local is_main_visible = self.v_uiobjects.Main.activeSelf
  if not is_main_visible then
    return
  end
  local canvas_group = self.v_uicompents.JoystickContent_cg
  if canvas_group.alpha <= 0 then
    return
  end
  if Util.is_client_only() then
    return true
  end
  if FunctionalNpcMgr and FunctionalNpcMgr.v_show_battle_award_show_panel then
    UIMgr:try_hide_ui("battle_award_show_panel")
    FunctionalNpcMgr.v_show_battle_award_show_panel = false
  end
  if StoryMgr:is_playing_full_screen_story() then
    return
  end
  return true
end

function ui:refresh()
  self.v_uicompents.Btn_Interact_btn.gameObject:SetActive(false)
  for i = NORMAL_ATK, SKILL_NORMAL_END do
    self:_update_skill(i)
    self:update_skill_cd_on_change(i)
  end
  self:on_up_all_code()
  self.v_panels.hero_bar:refresh()
  self.v_heads_view:force_update_head()
  self:update_sp_sld_val()
  self:change_button(self.v_is_interact)
  self:update_tower_skill()
  if self.v_god_skill then
    self:_update_skill(TOWER_SKILL_KEY)
  end
  if not Util.is_client_only() then
    self:update_skill_list()
  end
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_ACTIVE_ROOM)
  self:refresh_charge_cur_cd()
  self:update_team_skill_energy()
  self:check_all_skill_mask()
  self:set_ult_skill_enabled(Global.hero_uuid)
end

function ui:on_up_all_code(cancel, force)
  Joystick.on_joystick("end")
  if not force and self.v_enable then
    return
  end
  for index = NORMAL_ATK, SKILL_NORMAL_END do
    self:on_up_skill(index, cancel, Config.TOUCH_UP_TYPE.ON_UP_ALL_CODE)
  end
end

function ui:ui_on_hide()
  self:on_up_all_code()
  if self.v_fight_task then
    self.v_fight_task:on_hide()
  end
  if self.v_notice_seqence then
    self.v_notice_seqence:Kill()
    self.v_notice_seqence = nil
  end
  if self.v_timer_index then
    Timer:remove_timer(self.v_timer_index)
    self.v_timer_index = nil
  end
  if self.v_lvup_task_time_index then
    Timer:remove_timer(self.v_lvup_task_time_index)
    self.v_lvup_task_time_index = nil
  end
  if self.v_charge_sequence then
    self.v_charge_sequence:Kill(false)
    self.v_charge_sequence = nil
  end
  if self.v_screen_sequence then
    self.v_screen_sequence:Kill(false)
    self.v_screen_sequence = nil
  end
  if self.v_shake_sequence then
    for index, seq in pairs(self.v_shake_sequence) do
      seq:Kill(false)
    end
    self.v_shake_sequence = nil
  end
  for _, data in pairs(self.v_skill_charged_data) do
    self:clear_charging_data(data, true)
  end
  for _, data in pairs(self.v_time_charged_data) do
    self:clear_charging_data(data, true)
  end
  self.v_battle_skill_list = nil
  self.v_is_play_effect = false
  if Global.BloodHelper then
    Global.BloodHelper.clear_tween_handler()
  end
  SwitchHeroHelper.clear_switch_flag()
  self.v_def_atk_skill_id = nil
  for index, effect in ipairs(self.v_charge_sld_effec_list) do
    ResMgr:destroy_gameobj(effect)
  end
  self.v_charge_sld_effec_list = {}
  self.v_timeline_end_cb = nil
  if self.v_scene_lv_up_timer then
    Timer:remove_timer(self.v_scene_lv_up_timer)
    self.v_scene_lv_up_timer = nil
  end
  self:clear_loop_tween()
  if self.v_btn_skill2_dot then
    self.v_btn_skill2_dot:Kill(false)
    self.v_btn_skill2_dot = nil
    self.v_uicompents.Btn_skill2_cg.alpha = 1
  end
end

function ui:ui_on_destroy()
  SkillIndicator.on_uifight_delete()
  self.v_hero_uuid2skill_list = nil
  self.v_is_interact = nil
  self.v_object_canvas_group_map = nil
  self.v_skill_charged_data = nil
  if self.v_fight_task then
    self.v_fight_task:on_destroy()
    self.v_fight_task = nil
  end
  self:clear_ui_effect()
  self:destroy_all_low_update_comps()
end

function ui:clear_ui_effect()
  if not self.v_ui_effect then
    return
  end
  for key, obj in pairs(self.v_ui_effect) do
    ResPoolMgr:release(obj)
    self.v_ui_effect[key] = nil
    if self.v_eff_release_timer_map[key] then
      Timer:remove_timer(self.v_eff_release_timer_map[key])
      self.v_eff_release_timer_map[key] = nil
    end
  end
end

function ui:force_switch_hero(keycode, force)
  self.v_heads_view:force_switch_hero(keycode, force)
end

function ui:reset_btn_update_state()
  for i = NORMAL_ATK, SKILL_NORMAL_END do
    self.v_skill_update[i] = {}
    self.v_skill_update[i].is_update = true
  end
  self.v_skill_update[TOWER_SKILL_KEY] = {}
  self.v_skill_update[TOWER_SKILL_KEY].is_update = true
end

function ui:init_event()
  for i = NORMAL_ATK, SKILL_NORMAL_END do
    self.v_button_state_list[SKILL_INPUT_COUDE[i]] = Config.BUTTON_INPUT_STATE_NAME.NO_INPUT
    local btn = self.v_uicompents["Btn_skill" .. i .. "_btn"]
    SkillIndicator.init_uikey(SKILL_INPUT_COUDE[i], btn.transform, i)
    self:set_button_ex_listener(btn, function()
      self:on_down_skill(i)
    end, function()
      self:on_up_skill(i, false, Config.TOUCH_UP_TYPE.BUTTON_LISTENER)
    end, nil, function()
      self:on_up_skill(i, false, Config.TOUCH_UP_TYPE.BUTTON_LISTENER)
    end)
  end
  SkillIndicator.init_cancle_ui(self:get_uiobject("CancleSkill", BIND_TYPE.OBJECT))
  self:bind_auto_mq(Const.MSG_UI_FIGHT_ENERGY, self.on_update_skill_energy, self)
  self:bind_auto_mq(Const.MSG_HERO_ATTR_CHANGE, self.on_update_hero_attr, self)
  self:bind_auto_mq(Const.MSG_GOD_ATTR_CHANGE, self.on_update_hero_attr, self)
  self:bind_auto_mq(Const.MSG_ON_ROLE_SHIELD_CHANGE, self.update_hero_hp, self)
  self:bind_auto_mq(Const.MSG_UI_FIGHT_INPUT_CODE, self.on_input_code, self)
  self:bind_auto_mq(Const.MSG_UI_FIGHT_INPUT_KEY_UP_CODE, self.on_input_key_up_code, self)
  self:bind_auto_mq(Const.MSG_SCENE_RELOAD_END, self.on_scene_reload_end, self)
  self:bind_auto_mq(Const.MSG_UI_FIGHT_BUTTON_EFFECT, self.on_play_button_effect, self)
  self:bind_auto_mq(Const.MSG_UI_FIGHT_STOP_EFFECT, self.on_stop_button_effect, self)
  self:bind_auto_mq(Const.MSG_UI_FIGHT_CAST_SKILL, self.on_play_skill_effect, self)
  self:bind_auto_mq(Const.MSG_SET_UIOBJECT_VISIBLE, self.on_set_uiobject_visible, self)
  self:bind_auto_mq(Const.MSG_ON_ENTER_ROOM, self.response_enter_room_event, self)
  self:bind_auto_mq(Const.MSG_ON_PASS_ROOM, self.response_pass_room_event, self)
  self:bind_auto_mq(Const.MSG_TOG_SPECIAL_AREA, self.on_togge_special_area, self)
  self:bind_auto_mq(Const.MSG_CLEAR_INPUT_KEY, self.on_clear_key, self)
  self:bind_auto_mq(Const.MSG_PRE_TP_ROOM, self.on_pre_tp_room, self)
  self:bind_auto_mq(Const.MSG_TP_ROOM_FINISH, self.on_tp_toom_finish, self)
  self:bind_auto_mq(Const.MSG_ON_UPDATE_FIGHT_SKILL_LIST, self.update_skill_list, self)
  self:bind_auto_mq(Const.MSG_ON_SELECTED_UI_FIGHT_SKILL_ITEM, self.select_ui_skill_list, self)
  self:bind_auto_mq(Const.MSG_CHANGE_SCENE_SKILL, self.update_tower_skill, self)
  self:bind_auto_mq(Const.MSG_CREATE_SCENE_SKILL, self.update_tower_skill, self)
  self:bind_auto_mq(Const.MSG_CREATE_SCENE_SKILL, self._set_team_skill_view, self)
  self:bind_auto_mq(Const.MSG_ON_ENTER_ROOM, self.on_enter_room, self)
  self:bind_auto_mq(Const.MSG_ON_UPDATE_FIGHT_SKILL_LIST, self.update_btn_state, self)
  self:bind_auto_mq(Const.MSG_ON_SETTING_CHANGE, self.update_btn_state, self)
  self:bind_auto_mq(Const.MSG_ON_SPECIAL_SCREEN_CHANGE, self.auto_adapt_joystick, self)
  self:bind_auto_mq(Const.MSG_SCENE_LOAD_FINISH, self.response_secen_load_finish_event, self)
  self:bind_auto_mq(Const.MSG_OB_EXIT_BTN_LAYOUT_SETTING, self.load_setting_layout, self)
  self:bind_auto_mq(Const.MSG_SHOW_ATTR_CHANGE_TIPS, self._on_show_attr_change_tips, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_DBM, self.response_dbm_show, self)
  self:bind_auto_mq(Const.MSG_ON_CLOSE_DBM, self.response_dbm_close, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_BAG_UPDATE, self.response_fight_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_CR_OPEN_PAUSE_BTN, self.open_prepare_btn, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_END, self.update_skill_list, self)
  self:bind_auto_mq(Const.MSG_ON_CR_GET_RING_INFO_SUCCESS, self.check_game_play_logic, self)
  self:bind_auto_mq(Const.MSG_CG_TIMELINE_START, self.on_timeline_start, self)
  self:bind_auto_mq(Const.MSG_CG_TIMELINE_END, self.timeline_play_end, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_TRACK_BATTLE_TASK_ID, self.on_track_task_id, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_TRACK_BATTLE_TASK_PRO, self.on_track_task_pro_change, self)
  self:bind_auto_mq(Const.MSG_ON_BATTLE_TASK_RECEIVE_OR_COMPLETE, self.on_battle_task_receive_or_complete, self)
  self:bind_auto_mq(Const.MSG_ON_UPDATE_INDICATOR_CONFIG, self.response_update_indicator_config, self)
  self:bind_auto_mq(Const.MSG_ON_BAN_SKILL_USE, self._response_ban_skill, self)
  self:bind_auto_mq(Const.MSG_FIGHT_CNT_TIPS_FINISH, self._response_time_finish, self)
  self:bind_auto_mq(Const.MSG_ON_REPLACE_TEAM_POS_CHAR, self.update_hero_info, self)
  self:bind_auto_mq(Const.MSG_DO_SWITCH_OPERATE_CHAR, self.inner_switch_operate_char, self)
  self:bind_auto_mq(Const.MSG_ON_UP_SKILL, self.on_skill_up, self)
  self:bind_auto_mq(Const.MSG_ON_SYNC_FIGHT_PROGRESS, self.on_update_tower_progress, self)
  self:bind_auto_mq(Const.MSG_ON_CLOSE_DROP_UI, self.on_close_drop_ui, self)
  self:bind_auto_mq(Const.MSG_ON_ENTER_ROOM, self.reset_task_guid_time, self)
  self:bind_auto_mq(Const.MSG_ON_STORY_START, self.reset_task_guid_time, self)
  self:bind_auto_mq(Const.MSG_ENERGY_BALL_HAS_BEEN_PICKED, self.play_pick_ball_effect, self)
  self:bind_auto_mq(Const.MSG_QUANTUM_CAPTURE_SYSTEM, self._response_quantum_capture_system, self)
  self:bind_auto_mq(Const.MSG_CAMERA_CAPTURE_SYSTEM, self._response_camera_capture_system, self)
  if SDKManager:is_google_play_games() or UNITY_EDITOR or UNITY_STANDALONE_WIN then
    self:bind_auto_mq(Const.MSG_UPDATE_INPUT_SETTING, self.update_input_setting_view, self)
  end
end

function ui:on_pre_tp_room()
  self:on_up_all_code()
  self:pre_show_joystick()
  self:set_safe_panel_hidden()
  local msg = {
    mm_x = "fight",
    mm_y = "Main",
    mm_obj = false
  }
  self:on_set_uiobject_visible(msg, true)
  if Global.hero then
    Global.hero.skill_mgr:abort(Config.SKILL_ABORT_TYPE.FOECE)
  end
end

function ui:on_timeline_start()
  self:on_up_all_code(true, true)
  if Global.hero then
    Global.hero.skill_mgr:abort(Config.SKILL_ABORT_TYPE.FOECE)
  end
  self:reset_task_guid_time()
end

function ui:on_tp_toom_finish()
  self:set_safe_panel_visible()
  local msg = {
    mm_x = "fight",
    mm_y = "Main",
    mm_obj = true
  }
  if Global.hero and not Global.hero:is_playing_time_line() then
    if not StoryMgr:is_playing_full_screen_story() then
      self:on_set_uiobject_visible(msg, true)
    end
    self.v_timeline_end_cb = nil
    self.v_fight_location:set_location()
  else
    function self.v_timeline_end_cb()
      if not StoryMgr:is_playing_full_screen_story() then
        self:on_set_uiobject_visible(msg, true)
      end
    end
  end
  self:on_up_all_code()
  self:check_game_play_logic()
  self.v_object:SetActiveEx(true)
end

function ui:timeline_play_end()
  if self.v_timeline_end_cb then
    self.v_timeline_end_cb()
    self.v_timeline_end_cb = nil
  end
end

function ui:open_tp_view()
  if Util.is_client_only() then
    UIMgr:get_ui("battle_setting"):ui_show()
    return
  end
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE and ChallengeRingPlusMgr:is_in_back_ring_timer() then
    return
  end
  if DebugSetting:is_enter_chapter() and TowerMgr then
    TowerMgr:open_fight_bag_panel()
  else
    TowerMgr:on_exit_tower()
    Global.scene_mgr:on_enter_main_scene()
    self:ui_hide()
    UIMgr:revert_cache_ui()
  end
end

function ui:open_battle_bag()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE and ChallengeRingPlusMgr:is_in_back_ring_timer() then
    return
  end
  local _ui = UIMgr:get_ui("battle_bag4")
  _ui:set_skip_sort_order(true)
  _ui:ui_show()
end

function ui:update_fight_skill_list(uuid)
  self.v_hero_uuid2skill_list, self.v_hero_uuid2qteid_list = BattleSkillBookMgr:get_hero_btn_skill_map()
  local select_uuid = uuid or Global.hero_uuid
  if not select_uuid then
    return
  end
  self.v_skill_list = BattleSkillBookMgr:get_hero_btn_skill_map_list(select_uuid)
  self.v_qte_skill_id = self.v_hero_uuid2qteid_list[select_uuid]
  self:update_skill_expend_count(select_uuid)
end

function ui:set_skill_icon(index, skill_id)
  local skill_cfg = ShareRes.create("skill.skill", skill_id)
  if not skill_cfg.Icon then
    Log.Error("index", index, "skill_id", skill_id, debug.traceback())
    return
  end
  self:load_skill_icon(index, skill_cfg.Icon)
end

function ui:get_skill_indi_backtime(KeyCode)
  local index = INPUT_COUDE_SKILL_INDEX[KeyCode]
  if index then
    local skill_info = self:get_cur_skill_info(index)
    if not skill_info then
      return nil
    end
    local skill_id = skill_info.skill_id
    local skill_cfg = ShareRes.create("skill.skill", skill_id) or {}
    return skill_cfg.IndicatorBackTime
  else
    return nil
  end
end

function ui:set_skill_charge_list(index, skill_info)
  if Config.ABANDON_BTN_IDX[index] then
    return
  end
  skill_info = skill_info or self:get_cur_skill_info(index)
  if self.v_skill_charge_list[index] then
    if skill_info.cost_energy < skill_info.max_energy then
      local num = 0
      if 0 ~= skill_info.cost_energy then
        num = skill_info.energy_section
      end
      if num > 1 and self.v_skill_charge_text[index] then
        self:update_ui_visible(self.v_skill_charge_list[index], true)
        self.v_skill_charge_text[index]:set_value(math.floor(num))
      else
        self:update_ui_visible(self.v_skill_charge_list[index], false)
      end
    else
      self:update_ui_visible(self.v_skill_charge_list[index], false)
    end
  end
end

function ui:get_rect_sizedelta()
  return self.v_uifight_rect:GetSizeDeltaA()
end

function ui:update_skill_charge_list(index, skill_info)
  if 0 ~= skill_info.cost_energy then
    local num = skill_info.energy_section
    if self.v_skill_charge_list[index] then
      if num > 1 and self.v_skill_charge_text[index] then
        self:update_ui_visible(self.v_skill_charge_list[index], true)
        self.v_skill_charge_text[index]:set_value(math.floor(num))
      else
        self:update_ui_visible(self.v_skill_charge_list[index], false)
      end
    end
  end
  if not self.v_btn_charging_params[skill_info.skill_id] then
    self:update_ui_visible(self.v_uiobjects[ENERGY_TIME_NAME[index]], false)
    if 0 == skill_info.cost_energy or skill_info.cur_energy >= skill_info.max_energy then
      if self.v_skill_pointer_list[index] and self.v_skill_mask_list[index] then
        self:update_ui_visible(self.v_skill_pointer_list[index], false)
        self:update_ui_visible(self.v_skill_mask_list[index]:get_go(), false)
      end
      if self.v_skill_line_list[index] then
        self:update_ui_visible(self.v_skill_line_list[index], false)
      end
      if self.v_skill_cd_fx_is_showing[index] and self.v_skill_cd_not_enough_fx_list[index] then
        self.v_skill_cd_not_enough_fx_list[index]:SetActive(false)
        self:stop_effect(SKILL_CD_NOT_ENOUGH_NAME[index])
        self.v_skill_cd_fx_is_showing[index] = false
      end
      return
    end
    if 0 ~= skill_info.cost_energy then
      local num = skill_info.energy_section
      local pro = (skill_info.cur_energy - skill_info.cost_energy * num) / skill_info.cost_energy
      if self.v_skill_pointer_list[index] then
        if num > 0 then
          local rot_z = 360 * (1 - pro)
          self:update_ui_visible(self.v_skill_pointer_list[index], pro > 0 and pro < 1)
          self.v_skill_pointer_list[index]:SetEuler(0, 0, rot_z)
        else
          self:update_ui_visible(self.v_skill_pointer_list[index], false)
        end
      end
      if self.v_skill_line_list[index] then
        if num > 0 then
          self:update_ui_visible(self.v_skill_line_list[index], pro > 0 and pro < 1)
        else
          self:update_ui_visible(self.v_skill_line_list[index], false)
        end
      end
      if self.v_skill_mask_list[index] then
        self:update_ui_visible(self.v_skill_mask_list[index]:get_go(), num < 1)
        self.v_skill_mask_list[index]:set_value(1 - pro)
      end
      if num > 0 or 0 == skill_info.cost_energy then
        self.v_skill_cd_fx_is_showing[index] = false
      elseif not self.v_skill_cd_fx_is_showing[index] and self.v_skill_cd_not_enough_fx_list[index] then
        self:play_effect(SKILL_CD_NOT_ENOUGH_NAME[index])
        self.v_skill_cd_fx_is_showing[index] = true
      end
    end
  end
end

function ui:on_update_tower_progress(msg)
  local tower_progress = TowerMgr:get_tower_progress()
  if next(tower_progress.award_list) ~= nil and tower_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.CUT_GRASS then
    self.v_panels.drop_tips:set_data()
    self.v_panels.drop_tips:set_enable(true)
    UIMgr:get_ui("battle_drop_tips"):ui_show(false)
  end
end

function ui:on_close_drop_ui()
  if SceneMgr and SceneMgr:get_scene_item_mgr() then
    local item_infos = SceneMgr:get_scene_item_mgr():get_test_item_info()
    if next(item_infos) == nil then
      self.v_is_near_item = false
    end
  end
  if not self.v_is_near_item then
    self:reset_toggle_near_item_ui()
  end
end

function ui:api_set_icon(key_code, skill_icon)
  local index = INPUT_COUDE_SKILL_INDEX[key_code]
  assert(index, "btn code error " .. key_code)
  self:load_skill_icon(index, skill_icon)
end

function ui:load_skill_icon(index, skill_icon)
  if not self.v_skill_image[index] or index == BTN_NAME_2_SKILL_INDEX.Btn_skill2 then
    return
  end
  local image = self.v_skill_image[index]
  ResMgr:load_set_icon(image, "skill/" .. skill_icon)
end

function ui:get_cur_skill_info(idx)
  if idx == TOWER_SKILL_KEY then
    return self.v_god_skill
  end
  if not self.v_skill_list then
    self:update_fight_skill_list()
    Util.assert(self.v_skill_list ~= nil, "技能列表为空", "塔是否存在", tostring(TowerMgr and nil ~= TowerMgr:get_tower()), "Global.hero_uuid", Global.hero_uuid, "Global.hero.id", Global.hero and Global.hero.id)
  end
  return self.v_skill_list[idx]
end

function ui:get_skill_by_uuid(uuid, idx)
  local skill_list = self.v_hero_uuid2skill_list[uuid]
  return skill_list and skill_list[idx]
end

function ui:get_skill_index_by_id(skill_id)
  for k, v in pairs(self.v_skill_list) do
    if v.skill_id == skill_id then
      return k, v
    end
  end
end

function ui:on_down_skill(index, is_src_key)
  if not self.v_skill_list then
    return
  end
  self.v_button_state_list[SKILL_INPUT_COUDE[index]] = Config.BUTTON_INPUT_STATE_NAME.ON_INPUT
  local force_effect = false
  if index == QTE_SHOW_SKILL_IDX then
    local attr_mgr = Global.hero.attr_mgr
    local cur = attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY) or 0
    local max = attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY_MAX) or 0
    if cur / max >= 1 then
      force_effect = true
    end
  end
  if self.v_cur_input_index then
    local cur_input_index = self.v_cur_input_index
    self:on_up_skill(cur_input_index, true, Config.TOUCH_UP_TYPE.ON_DOWN_SKILL_FORCE_UP)
  end
  self.v_cur_input_index = index
  self.v_input_skill_index = index
  self.touch_index = UnityEngine.Input.touchCount - 1
  if not is_src_key and self.v_uiobjects["Down" .. index] then
    self.v_uiobjects["Down" .. index]:SetActive(true)
  end
  self.v_show_down_fx_index = index
  self.v_is_click_down = true
  local skill_info = self:get_cur_skill_info(index)
  if skill_info and skill_info.skill_type == SKILL_ATTACK_TYPE.NORMAL or force_effect then
    self:play_down_skill_effect(index)
  end
  local input_code = SKILL_INPUT_COUDE[index]
  self.v_key_down[input_code] = true
  local hero = Global.hero
  self.v_start_down_timer = Global.time
  if not Util.is_destroy(hero) then
    local is_attack_skill = ATTACK_SKILL_LIST[input_code]
    local can_interrupt = false
    if is_attack_skill then
      can_interrupt = hero:can_hurt_interrupt(BEHIT_INTERRUPT_TYPE.SKILL)
    end
    if not can_interrupt and input_code == INPUT_CODE.INPUT_SKILL1 then
      can_interrupt = hero:can_hurt_interrupt(BEHIT_INTERRUPT_TYPE.COUNTER)
    end
    if not SceneMgr:check_is_switching_hero() then
      BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_INPUT, input_code)
    end
    if can_interrupt then
      hero:on_input(input_code)
    end
  end
end

function ui:on_play_skill_effect()
  for index, v in pairs(self.v_skill_list) do
    local obj_name = DOWN_SKILL_NAME[index]
    local down_skill = self.v_uiobjects[obj_name]
    if self.v_show_down_fx_index and self.v_show_down_fx_index == index and not v.qte_type and down_skill and self.v_is_click_down then
      self:play_down_skill_effect(index)
      self.v_is_click_down = false
    end
  end
end

function ui:after_set_main_visible(visible)
  self:set_hp_visible(visible)
  self:set_enemy_bar_visible(visible)
end

function ui:on_set_uiobject_visible(msg, self_call)
  if msg.mm_x ~= "fight" then
    return
  end
  if msg.mm_y == "SpecialBar" then
    self.v_panels.hero_bar:on_set_uiobject_visible(msg.mm_y, msg.mm_obj)
    return
  end
  if msg.mm_y == "Main" then
    if self_call then
      self:on_set_safe_panel_alpha(msg.mm_obj)
    elseif not msg.mm_obj then
      SceneMgr:hide_npc_hp_obj()
    else
      SceneMgr:show_npc_hp_obj()
    end
    if not msg.mm_obj and self.v_input_skill_index then
      self:on_up_skill(self.v_input_skill_index, true, Config.TOUCH_UP_TYPE.UIOBJECT_INVISIBLE)
    end
  end
  local object_name = msg.mm_y
  local is_visible = msg.mm_obj
  local object = self:get_uiobject(object_name)
  if msg.mm_y == "Right" then
    self:set_ui_node_visible("TeamHeads", OBJ_VISIBLE_TYPE.BUDDY, is_visible)
    self:set_uiobject_visible("Right")
  end
  if TowerMgr then
    local tower = TowerMgr:get_tower()
    if tower and tower:check_play_pass_anim() and is_visible then
      return
    end
  end
  if "Main" == object_name then
    self:update_joystick_alpha(is_visible)
  end
  if not object then
    for _, obj in pairs(self.v_panels) do
      object = obj:get_uiobject(object_name)
      if object then
        break
      end
    end
  end
  self:set_ui_node_visible(object_name, OBJ_VISIBLE_TYPE.BUDDY, is_visible)
  is_visible = self:check_show_ui_obj(object_name)
  if object then
    local active_changed = object.activeSelf ~= is_visible
    if object_name == BTN_SKILL_NAME[QTE_SHOW_SKILL_IDX] then
      self.is_need_special_handling_skill7 = false
    end
    if active_changed then
      if not is_visible then
        local btn_index = BTN_NAME_2_SKILL_INDEX[object_name]
        if btn_index and self.v_input_skill_index and self.v_input_skill_index == btn_index then
          self:on_up_skill(btn_index, true, Config.TOUCH_UP_TYPE.UIOBJECT_INVISIBLE)
        end
      end
      object:SetActive(is_visible)
    end
    if "Main" == object_name and active_changed then
      local msg
      if is_visible then
        msg = MsgGame:mq_publish2(Const.MSG_ON_SHOW_UI)
        self.v_fight_location:set_location()
      else
        msg = MsgGame:mq_publish2(Const.MSG_ON_HIDE_UI)
      end
      msg.mm_obj = "fight"
    end
  end
  for i = NORMAL_ATK, SKILL_NORMAL_END do
    local effect_name = DOWN_SKILL_NAME[i]
    self.v_uiobjects[effect_name]:SetActive(false)
    self.v_uiobjects["Down" .. i]:SetActive(false)
    self:stop_dynamic_load_effect(effect_name)
  end
  if is_visible and self.v_obejct_canvas_visivle_state[object_name] == CANVAS_VISIBLE_STATE.INVISIBLE then
    local visible = self.v_obejct_canvas_visivle_state[object_name] == CANVAS_VISIBLE_STATE.VISIBLE
    self:set_object_visible(object_name, visible, true)
  end
  if "Main" == object_name then
    self:after_set_main_visible(msg.mm_obj)
  end
end

function ui:update_joystick_alpha(is_visible)
  local target_alpha = is_visible and 1 or 0
  local canvas_group = self.v_uicompents.JoystickContent_cg
  canvas_group.alpha = target_alpha
end

function ui:check_show_ui_obj(object_name)
  local node_visible_data = self.v_ui_node_visible_state[object_name]
  if not node_visible_data then
    return true
  end
  if object_name == BTN_SKILL_NAME[BTN_NAME_2_SKILL_INDEX.Btn_skill8] and TowerMgr and TowerMgr:get_fight_type() ~= CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE and TowerMgr:check_enable_god_skill() then
    return true
  end
  for _, state in pairs(node_visible_data) do
    if state == OBJ_VISIBLE_STATE.HIDE then
      return false
    end
  end
  return true
end

function ui:get_ui_obj_visible(object_name)
  if self:is_destroy() then
    return false
  end
  local obj = self.v_uiobjects[object_name]
  if not obj then
    for _, child_ui in pairs(self.v_panels) do
      obj = child_ui:get_uiobject(object_name)
      if obj then
        break
      end
    end
  end
  return obj and obj.activeInHierarchy or false
end

function ui:set_uiobject_visible(object_name, visible)
  local is_visible = self:check_show_ui_obj(object_name)
  self:uiobject_visible(object_name, is_visible)
end

function ui:set_fight_obj_ui_visible(object_name, visible)
  self:uiobject_visible(object_name, visible)
end

function ui:uiobject_visible(object_name, visible)
  local object = self:get_uiobject(object_name)
  local is_active = true
  for key, name in pairs(SKILL_BUTTON_INDEX) do
    if name == object_name then
      is_active = false
      break
    end
  end
  local hero_skill_btn = BattleSkillBookMgr:get_hero_skill_btn()
  local hero = Global.hero
  if not hero then
    return
  end
  local hero_id = hero.buddy_cfg.Id
  local skill_type_list = hero_skill_btn[hero_id]
  if skill_type_list then
    for btn_idx in pairs(skill_type_list) do
      local name = SKILL_BUTTON_INDEX[btn_idx]
      if name then
        is_active = true
        break
      end
    end
  end
  if object then
    object:SetActive(visible)
  end
  if not is_active and not Util.is_client_only() then
    object:SetActive(false)
  end
end

function ui:on_clear_key(msg)
  local except_key = msg.mm_x
  local force = msg.mm_y
  for keycode, key_idx in pairs(INPUT_COUDE_SKILL_INDEX) do
    if keycode ~= except_key and (force or keycode ~= SKILL_INPUT_COUDE[self.v_cur_input_index]) then
      self:on_up_skill(key_idx, true, Config.TOUCH_UP_TYPE.ON_CLEAR_KEY)
    end
  end
end

function ui:get_down_skill_index()
  return SKILL_INPUT_COUDE[self.v_input_skill_index]
end

function ui:on_skill_up(msg)
  local key = msg.mm_x
  local cancle = msg.mm_y
  for keycode, key_idx in pairs(INPUT_COUDE_SKILL_INDEX) do
    if keycode == key then
      self:on_up_skill(key_idx, cancle, Config.TOUCH_UP_TYPE.ON_SKILL_UP)
    end
  end
end

function ui:on_up_skill(select_index, cancle, source_type)
  local index = select_index or self.v_input_skill_index
  if not index then
    return
  end
  local out_code = SKILL_INPUT_COUDE[index]
  if not self.v_key_down or not self.v_key_down[out_code] then
    return
  end
  if self.v_uiobjects["Down" .. index] then
    self.v_uiobjects["Down" .. index]:SetActive(false)
  end
  self.v_key_down[out_code] = nil
  local input_time = self.v_start_down_timer and Global.time - self.v_start_down_timer or 0
  input_time = tonumber(string.format("%.2f", input_time))
  if not SceneMgr:check_is_switching_hero() then
    if not SkillIndicator.cancle and not cancle then
      BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_TOUCH_UP, out_code, false, input_time, source_type)
      self.v_button_state_list[SKILL_INPUT_COUDE[index]] = Config.BUTTON_INPUT_STATE_NAME.ON_TOUCH_UP
      self.v_button_state_cd_list[SKILL_INPUT_COUDE[index]] = ButtonStateCd
      self.v_cur_input_index = nil
      self.touch_index = -1
    else
      BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_TOUCH_UP, out_code, true, input_time, source_type)
      self.v_button_state_list[SKILL_INPUT_COUDE[index]] = Config.BUTTON_INPUT_STATE_NAME.CANCLE
      self.v_button_state_cd_list[SKILL_INPUT_COUDE[index]] = ButtonStateCd
      self.v_cur_input_index = nil
      self.touch_index = -1
    end
  end
  SkillIndicator.set_indicator_enable(out_code, false)
  local ui_guid = UIMgr:try_get_visible_ui("ui_guide")
  if ui_guid then
    local long_guid_ui = ui_guid:get_long_guide()
    if long_guid_ui and long_guid_ui:check_joystick_guid() and long_guid_ui:can_break_guide() then
      ui_guid:ui_hide()
    end
  end
end

function ui:get_skill_index_in_default_list_by_id(skill_id)
  local hero = Global.hero
  if hero then
    local skill_cfg = ShareRes.get_default_skill_list(hero.id)
    if skill_cfg then
      for index, id in ipairs(skill_cfg) do
        if skill_id == id then
          return index
        end
      end
    end
  end
end

function ui:check_cur_hero_skill_update()
  if SceneMgr:global_hero_is_destroyed() then
    return
  end
  for index, skill_id in pairs(self.v_skill_list) do
    self:check_skill_update(index, skill_id)
  end
end

function ui:on_update_skill_energy(msg)
  local index = self:get_skill_index_by_id(msg.mm_x)
  local cur_skill_info = self:get_cur_skill_info(index)
  local skill_id = msg.mm_x
  if cur_skill_info and skill_id == cur_skill_info.skill_id then
    self:set_skill_charge_list(index)
  end
  local skill_cfg = ShareRes.create("skill.skill", msg.mm_x)
  if 6 == skill_cfg.SkillType then
    index = TOWER_SKILL_KEY
  end
  index = index or self:get_skill_index_in_default_list_by_id(msg.mm_x)
  skill_id = skill_id or cur_skill_info.skill_id
  if index then
    self:update_skill_btn(index)
    self:check_skill_update(index, skill_id)
  end
end

function ui:check_skill_update(index, skill_id)
  if index and not Config.ABANDON_BTN_IDX[index] and index ~= BTN_NAME_2_SKILL_INDEX.Btn_skill1 then
    if self.v_skill_update[index] then
      if not self.v_skill_update[index].skill_id then
        self.v_skill_update[index].skill_id = skill_id
      end
    else
      self.v_skill_update[index] = {}
      self.v_skill_update[index].skill_id = skill_id
    end
    self.v_skill_update[index].is_update = true
  end
end

local ATTR_CHANGE_FUNCS_BY_FIGHT = {
  [ATTR_TYPE.CHAR_SP] = function(self, msg)
    self:update_sp_sld_val()
  end,
  [ATTR_TYPE.CHAR_SP_MAX] = function(self, msg)
    self:update_sp_sld_val()
  end,
  [ATTR_TYPE.TEAM_SKILL_ENERGY] = function(self, msg)
    self:update_team_skill_energy()
  end,
  [ATTR_TYPE.TEAM_SKILL_ENERGY_MAX] = function(self, msg)
    self:update_team_skill_energy()
  end
}
local hero_bar_ATTR_ID = {
  [ATTR_TYPE.CHAR_HP] = true,
  [ATTR_TYPE.CHAR_HP_MAX] = true,
  [ATTR_TYPE.CHAR_SP] = true,
  [ATTR_TYPE.CHAR_FIGHT_LINE_BAR] = true,
  [ATTR_TYPE.CHAR_FIGHT_LINE_BAR_MAX] = true
}
local ATTR_CHANGE_EXTRA_UNCS = {}
local ATTR_CHANGE_INTERVAL = 0.1

function ui:on_update_hero_attr(msg)
  if msg.mm_x == ATTR_TYPE.CHAR_SP then
    self:on_hero_sp_change(msg)
  else
    self.v_attr_change_chche[msg.mm_x] = msg.mm_x
  end
end

function ui:_do_update_hero_attr()
  self.v_heads_view:update_hero_head_hp()
  for _, attr_id in pairs(self.v_attr_change_chche) do
    if hero_bar_ATTR_ID[attr_id] then
      self.v_panels.hero_bar:change_attr(attr_id)
    end
    local extra_funcs = ATTR_CHANGE_EXTRA_UNCS[attr_id]
    if extra_funcs then
      for key, func in pairs(extra_funcs) do
        func(self)
      end
    end
    local cur_ui_func = ATTR_CHANGE_FUNCS_BY_FIGHT[attr_id]
    if cur_ui_func then
      cur_ui_func(self)
    end
  end
end

function ui:replace_hero_skill(index, skill_id)
  if SceneMgr:global_hero_is_destroyed() then
    return
  end
  if Config.ABANDON_BTN_IDX[index] or index < NORMAL_ATK or index > SKILL_NORMAL_END then
    return
  end
  local skill
  if index == TOWER_SKILL_BTN then
    local god_npc = SceneMgr:get_god_npc()
    if not god_npc then
      return
    end
    skill = god_npc.skill_mgr:get_skill(skill_id)
  else
    skill = Global.hero.skill_mgr:get_skill(skill_id)
  end
  if not skill then
    return
  end
  local ui_skill_info = self:get_cur_skill_info(index)
  if ui_skill_info and ui_skill_info.skill_id == skill_id then
    return
  end
  local info = skill:get_energy_info()
  if index == TOWER_SKILL_BTN then
    self.v_god_skill = info
  else
    self.v_skill_list[index] = info
  end
  if self.v_skill_update[index] then
    self.v_skill_update[index].skill_id = skill_id
    self.v_skill_update[index].is_update = true
  end
  self:_update_skill(index)
  if info then
    self:check_skill_mask(index, info)
  end
  self:refresh_single_charge_cur_cd(skill_id)
  self:update_skill_cd_on_change(index)
end

function ui:on_input_code(msg)
  local input_code = msg.mm_x
  local index = INPUT_COUDE_SKILL_INDEX[input_code]
  if index then
    if not Util.is_client_only() and not SceneMgr:global_hero_is_destroyed() then
      local hero = Global.hero
      local hero_id = hero.buddy_cfg.Id
      if SKILL_BUTTON_INDEX[index] and (not self.v_hero_have_skill[hero_id] or not self.v_hero_have_skill[hero_id][index]) then
        return
      end
    end
    self:on_down_skill(index, true)
    return
  end
  if input_code == INPUT_CODE.INPUT_NAVIGATION then
    self:try_show_navigation()
  end
end

function ui:on_input_key_up_code(msg)
  local index = INPUT_COUDE_SKILL_INDEX[msg.mm_x]
  if index then
    if not Util.is_client_only() then
      local hero = Global.hero
      local hero_id = hero.buddy_cfg.Id
      if SKILL_BUTTON_INDEX[index] and (not self.v_hero_have_skill[hero_id] or not self.v_hero_have_skill[hero_id][index]) then
        return
      end
    end
    if self.v_cur_input_index == index then
      self.v_cur_input_index = nil
      self.touch_index = -1
    end
    local key_code = msg.mm_x
    local input_time = self.v_start_down_timer and Global.time - self.v_start_down_timer or 0
    input_time = tonumber(string.format("%.2f", input_time))
    if not SceneMgr:check_is_switching_hero() then
      BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_TOUCH_UP, key_code, false, input_time)
    end
    self.v_button_state_list[SKILL_INPUT_COUDE[index]] = Config.BUTTON_INPUT_STATE_NAME.ON_TOUCH_UP
    self.v_button_state_cd_list[SKILL_INPUT_COUDE[index]] = ButtonStateCd
  end
end

function ui:change_button_element_effect(is_show, effect_name, button_index)
  local effect_key
  effect_key = effect_name .. button_index
  local root = self.v_uiobjects["EXSkillEffect" .. button_index]
  if is_show then
    if not self.v_button_element_effect[effect_key] then
      local effect = self:get_button_effect(effect_name, effect_key, root)
      effect.gameObject:SetActive(true)
      self.v_button_element_effect[effect_key] = effect
    end
  elseif self.v_button_element_effect[effect_key] then
    self:release_ui_effect(effect_key)
    self.v_button_element_effect[effect_key] = nil
  end
end

function ui:update_element_effect(element_id)
  local effect_name, button_index
  if self.v_last_button_element_id ~= element_id then
    if self.v_last_button_element_id then
      effect_name = FightCfg.SKL_BTN_7_ELEMENT_EFFECT[self.v_last_button_element_id]
      button_index = BTN_NAME_2_SKILL_INDEX.Btn_skill7
      self:change_button_element_effect(false, effect_name, button_index)
    end
    if element_id then
      effect_name = FightCfg.SKL_BTN_7_ELEMENT_EFFECT[element_id]
      button_index = BTN_NAME_2_SKILL_INDEX.Btn_skill7
      self:change_button_element_effect(true, effect_name, button_index)
    end
  end
  self.v_last_button_element_id = element_id
end

function ui:_update_skill(index)
  if Config.ABANDON_BTN_IDX[index] then
    return
  end
  local skill_info = self:get_cur_skill_info(index)
  if index == QTE_SHOW_SKILL_IDX and not SceneMgr:global_hero_is_destroyed() then
    self:set_skill_icon(index, self.v_qte_skill_id)
    local cur = Global.hero.attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY)
    local max = Global.hero.attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY_MAX)
    local alpha = Util.almost_zero(max - cur) and 1 or 0.1
    local buddy_id = Global.hero:get_buddy_id()
    local element_id = ShareRes.get_char_element_id(buddy_id)
    self:set_qte_fill_color(element_id, index, alpha)
    self:update_element_effect(element_id)
  end
  if not skill_info then
    return
  end
  self:set_skill_icon(index, skill_info.skill_id)
  self:update_skill_progress(index, true)
  self:update_skill_btn(index)
  self:set_skill_charge_list(index, skill_info)
  if NEED_UPDATE_EXPEND_BTN[index] then
    self:set_skill_expend_point(index)
  end
end

function ui:ui_on_update(delta_time)
  SkillIndicator.on_update()
  self.v_panels.enemy_bar:update_elite_enemy_hp_bar()
  self:update_time_charged_pro()
  self:update_magic_charged_data()
  self.v_delta_time = self.v_delta_time or 0
  self.v_delta_time = self.v_delta_time + delta_time
  if self.v_delta_time > ATTR_CHANGE_INTERVAL then
    self.v_delta_time = self.v_delta_time - ATTR_CHANGE_INTERVAL
    if next(self.v_attr_change_chche) ~= nil then
      self:_do_update_hero_attr()
      UtilTable.clear_map(self.v_attr_change_chche)
    end
  end
  self:update_button_state(delta_time)
  self:update_task_navigator_state()
  self:update_low_update_comps()
  local low_delta_time = Global.time - self.v_last_updated_time
  if low_delta_time >= LowUpdateInterval then
    self:ui_on_low_update(low_delta_time)
    self.v_last_updated_time = Global.time
  end
  self.v_panels.enemy_bar:update_main_enemy_bar()
end

function ui:ui_on_low_update(low_delta_time)
  self:update_skill(low_delta_time)
  if self.v_fight_task then
    self.v_fight_task:update()
  end
  self:update_lock_target()
  self.v_panels.enemy_bar:ui_on_low_update(low_delta_time)
  self.v_panels.hero_bar:ui_on_low_update(low_delta_time)
  self.v_panels.hero_head_view:ui_on_low_update(low_delta_time)
  self:update_sp_sld_val(low_delta_time)
  self:update_all_btn_cd(low_delta_time)
  self:do_qte_skill_anima(low_delta_time)
end

function ui:update_low_update_comps()
  if self.v_low_update_comps then
    local length = #self.v_low_update_comps
    for index = 1, length do
      self.v_low_update_comps[index]:update()
    end
  end
  if self.v_low_update_comp_map then
    for comp in pairs(self.v_low_update_comp_map) do
      comp:update()
    end
  end
end

function ui:remove_low_update_comps(comp)
  if nil == comp then
    return
  end
  for key, value in ipairs(self.v_low_update_comps) do
    if value == comp then
      comp:on_destroy()
      self.v_low_update_comps[key] = nil
    end
  end
end

function ui:remove_low_update_comp_map(comp)
  if self.v_low_update_comp_map and self.v_low_update_comp_map[comp] then
    self.v_low_update_comp_map[comp] = nil
  end
end

function ui:destroy_all_low_update_comps()
  if self.v_low_update_comps == nil then
    return
  end
  for key, value in ipairs(self.v_low_update_comps) do
    value:on_destroy()
  end
  self.v_low_update_comps = nil
end

function ui:update_lock_target()
  self:get_bar_target()
  if Util.is_more_than_zero(self.v_target_count) then
    self.v_panels.enemy_bar:begin_update_enemy_bar(self.v_target_count)
  else
    self.v_panels.enemy_bar:end_update_enemy_bar()
  end
end

function ui:update_button_state(delta_time)
  for keycode, cd in pairs(self.v_button_state_cd_list) do
    self.v_button_state_cd_list[keycode] = self.v_button_state_cd_list[keycode] - delta_time
    if cd <= 0 then
      self.v_button_state_cd_list[keycode] = nil
      self.v_button_state_list[keycode] = Config.BUTTON_INPUT_STATE_NAME.NO_INPUT
    end
  end
end

function ui:update_skill(delta_time)
  if SceneMgr:global_hero_is_destroyed() then
    return
  end
  self:_update_normal_skill()
  self:_update_tower_skill()
end

function ui:_update_normal_skill()
  local skill_info
  for i = NORMAL_ATK, SKILL_NORMAL_END do
    if not Config.ABANDON_BTN_IDX[i] then
      skill_info = i ~= TOWER_SKILL_BTN and self:get_skill_by_uuid(Global.hero_uuid, i) or self.v_god_skill
      if skill_info then
        self:update_skill_progress(i, false, skill_info)
      end
    end
  end
end

function ui:_update_tower_skill()
  if self.v_god_skill then
    self:update_skill_progress(TOWER_SKILL_KEY, false, self.v_god_skill)
  end
end

function ui:update_skill_progress(index, force, skill_info)
  if self.v_skill_update == nil then
    return
  end
  if not (index ~= NORMAL_ATK and self.v_skill_update[index]) or not self.v_skill_update[index].is_update then
    return
  end
  if self.v_uiobjects.UpBg.activeSelf then
    self.v_uiobjects[CHARGE_SKILL_NAME[index]]:SetActive(false)
  end
  if index == TOWER_SKILL_KEY then
    skill_info = self:get_cur_skill_info(index)
  else
    skill_info = skill_info or self:get_cur_skill_info(index)
  end
  if not skill_info then
    return
  end
  if self.v_btn_charging_params[skill_info.skill_id] then
    return
  end
  local skill_update = self.v_skill_update[index]
  if (not skill_update.skill_id or skill_update.skill_id == skill_info.skill_id) and skill_info.cur_energy == skill_info.max_energy then
    skill_update.is_update = false
    skill_update.skill_id = nil
  end
  local energy_section = skill_info.energy_section
  self:update_skill_charge_list(index, skill_info)
  local time_text = self.v_skill_time_text[index]
  local hero = Global.hero
  local skill = hero.skill_mgr:get_skill(skill_info.skill_id)
  local charge_param = self.v_btn_charging_params[skill_info.skill_id]
  if not skill or skill:can_cast_next() then
    if skill_info.cur_energy < skill_info.max_energy and energy_section <= 0 then
      local num = energy_section
      local cd_time
      if 0 == skill_info.real_recover_energy then
        cd_time = INFINITY
      else
        cd_time = math.floor((skill_info.cost_energy + skill_info.cost_energy * num - skill_info.cur_energy) / skill_info.real_recover_energy * 10) / 10
        cd_time = string.format(SEN_STR, cd_time)
      end
      self:set_skill_time_text(index, cd_time)
    elseif not Util.is_empty(time_text:get_cache_value()) then
      if charge_param and not charge_param.is_sp then
        self:update_ui_visible(self.v_uiobjects[ENERGY_TIME_NAME[index]], false)
      end
      self:set_skill_time_text(index, EMPTY_STR)
    end
  elseif not Util.is_empty(time_text:get_cache_value()) then
    if charge_param and not charge_param.is_sp then
      self:update_ui_visible(self.v_uiobjects[ENERGY_TIME_NAME[index]], false)
    end
    self:set_skill_time_text(index, EMPTY_STR)
  end
  if skill_info.old_energy_section and skill_info.old_energy_section ~= energy_section then
    self:update_skill_btn(index)
  end
  if skill_info.cur_energy == skill_info.max_energy and not force then
    if skill_info.old_energy and skill_info.old_energy ~= skill_info.cur_energy then
      skill_info.old_energy = skill_info.cur_energy
      self:set_skill_time_text(index, EMPTY_STR)
      self:update_skill_btn(index)
    end
    return
  end
  skill_info.old_energy = skill_info.cur_energy
  skill_info.old_energy_section = energy_section
end

function ui:check_use_skill(index)
  local skill_info = self:get_cur_skill_info(index)
  if not skill_info then
    return false
  end
  if self.v_btn_charging_params[skill_info.skill_id] and self.v_btn_charging_params[skill_info.skill_id].is_on then
    return false
  end
  if skill_info.cur_energy < skill_info.cost_energy then
    return false
  end
  return true
end

function ui:get_hero_by_poskey(key)
  return self.v_heads_view:get_hero_by_poskey(key)
end

function ui:get_keycode_by_uuid(uuid)
  return self.v_heads_view:get_keycode_by_uuid(uuid)
end

function ui:change_button_ring_alpha(img, a)
  local color = img.color
  color.a = a
  img.color = color
end

function ui:update_skill_btn(index, effect)
  if not self.v_skill_image[index] then
    return
  end
  local skill_info = self:get_cur_skill_info(index)
  local gray_params, charging_params
  if skill_info then
    gray_params = self.v_skill_id_gray_params[skill_info.skill_id]
    charging_params = self.v_btn_charging_params[skill_info.skill_id]
  end
  if self:check_use_skill(index) and (not gray_params or not gray_params.btn_gray) then
    self.v_skill_image[index]:SetGraphicColor(1, 1, 1)
  else
    self.v_skill_image[index]:SetGraphicColor(1, 1, 1, 0.3)
  end
end

function ui:on_play_button_effect(msg)
  local index = msg.mm_y
  local effect_name = msg.mm_x
  if "shake" == effect_name then
    self:on_button_shake(index, msg.mm_obj)
    return
  elseif "gray" == effect_name then
    self:on_button_gray(index, msg.mm_obj)
    return
  end
  self:try_play_button_effect(effect_name, index)
end

function ui:_on_stop_button_effect(index, effect_name, retain_record)
  if Util.is_empty(effect_name) then
    return
  end
  local new_effect_name
  if index then
    new_effect_name = effect_name .. index
  else
    new_effect_name = effect_name
  end
  if not retain_record then
    self:on_playing_effect_remove(new_effect_name)
  end
  if DYNAMIC_LOAD_EFFECT_NAME[effect_name] then
    self:stop_dynamic_load_effect(new_effect_name)
  else
    self:stop_effect(new_effect_name)
  end
end

function ui:on_stop_button_effect(msg)
  local index = msg.mm_y
  local effect_name = msg.mm_x
  self:_on_stop_button_effect(index, effect_name)
end

function ui:revert_btn_pos()
  self.v_shake_sequence = self.v_shake_sequence or {}
  for index = NORMAL_ATK, SKILL_NORMAL_END do
    if self.v_shake_sequence[index] then
      self.v_shake_sequence[index]:Kill(false)
      self.v_shake_sequence[index] = nil
    end
    local btn = self.v_uiobjects[BTN_SKILL_NAME[index]]
    if btn and self.v_skill_btn_pos and self.v_skill_btn_pos[index] then
      local rect = Util.get_rect_transform(nil, btn).component
      rect:SetAnchoredPositionA(self.v_skill_btn_pos[index].x, self.v_skill_btn_pos[index].y)
    end
  end
end

function ui:on_button_shake(index, params)
  if not params then
    return
  end
  local skill_btn = self.v_uiobjects[BTN_SKILL_NAME[index]]
  self.v_shake_sequence = self.v_shake_sequence or {}
  local rect = self.v_uicompents[BTN_SKILL_NAME[index] .. "_rect"]
  local pos_data = self.v_skill_btn_pos and self.v_skill_btn_pos[index]
  if self.v_shake_sequence[index] then
    if pos_data then
      rect:SetAnchoredPositionA(pos_data.x, pos_data.y)
    end
    self.v_shake_sequence[index]:Kill(false)
    self.v_shake_sequence[index] = nil
  end
  local time = params[3]
  local force = params[4]
  local shake_times = params[5]
  local random = params[6]
  local fade = false
  if 1 == params[7] then
    fade = true
  end
  self.v_shake_sequence[index] = skill_btn.transform:DOShakeAnchorPos(time, force, shake_times, random, fade)
  self.v_shake_sequence[index]:OnComplete(function()
    if pos_data then
      rect:SetAnchoredPositionA(pos_data.x, pos_data.y)
    end
    self.v_shake_sequence[index] = nil
  end)
end

function ui:on_button_gray(index, params)
  local skill_id = params[3]
  if not self.v_skill_id_gray_params[skill_id] then
    self.v_skill_id_gray_params[skill_id] = {}
  end
  if 1 == params[4] then
    self.v_skill_id_gray_params[skill_id].btn_gray = true
    self.v_skill_id_gray_params[skill_id].show_icon = 1 == params[5]
  else
    self.v_skill_id_gray_params[skill_id].btn_gray = false
    self.v_skill_id_gray_params[skill_id].show_icon = false
  end
  for i, v in pairs(self.v_skill_list) do
    if not Config.ABANDON_BTN_IDX[index] and v.skill_id == skill_id then
      self:update_skill_btn(i, "gray")
    end
  end
end

function ui:on_update_target(cur_target)
  if cur_target and not cur_target:is_destroy() then
    local hp = cur_target.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
    local hp_max = cur_target.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX)
    local percent = hp / hp_max
    self.v_uicompents.Blood_Dong_img.fillAmount = percent
  end
end

function ui:get_bar_target()
  if SceneMgr:global_hero_is_destroyed() then
    return
  end
  local target
  self.v_target_count = 0
  for uuid, _ in pairs(self.v_target_uuid_map) do
    target = SceneMgr:get_npc_by_id(uuid)
    if Util.is_destroy(target) or not self:check_show_targetd_hp(target) then
      self.v_target_uuid_map[uuid] = nil
    else
      self.v_target_count = self.v_target_count + 1
    end
  end
  if self.v_target_count >= MAX_TARGET_COUNT then
    return
  end
  target = Global.hero:get_target()
  if not Util.is_destroy(target) and target:is_npc() and self:check_show_targetd_hp(target) and not self.v_target_uuid_map[target.uuid] and self.v_target_count < MAX_TARGET_COUNT then
    self.v_target_count = self.v_target_count + 1
    self.v_target_uuid_map[target.uuid] = true
  end
  local betargets_map = Global.hero:get_betargetd_map()
  for uuid, _ in pairs(betargets_map) do
    target = SceneMgr:get_npc_by_id(uuid)
    if not Util.is_destroy(target) and self:check_show_targetd_hp(target) and not self.v_target_uuid_map[target.uuid] and self.v_target_count < MAX_TARGET_COUNT then
      self.v_target_count = self.v_target_count + 1
      self.v_target_uuid_map[target.uuid] = true
      if self.v_target_count >= MAX_TARGET_COUNT then
        break
      end
    end
  end
end

function ui:check_show_targetd_hp(target)
  local hp_bar_type = target:get_hp_bar_type()
  local _, _, show_big_bar = Util.check_show_hp_bar_type(hp_bar_type)
  return show_big_bar
end

function ui:update_hero_hp(msg)
  local is_hero = msg and msg.mm_x
  if false == is_hero then
    return
  end
  self.v_panels.hero_bar:update_hero_hp()
end

function ui:update_skill_indicator(key_code, area_cfg, indi_cfg, sensitivity)
  SkillIndicator.update_skill_indicator(key_code, area_cfg, indi_cfg, sensitivity)
end

function ui:set_indicator_inverse(is_inverse)
  SkillIndicator.set_indicator_inverse(is_inverse)
end

function ui:update_aim_mode_cfg(area_cfg, indicator_cfg, sensitivity, lock_cfg)
  indicator_cfg.lock_cfg = lock_cfg
  local key_code = AIM_JOYSTICK_CODE
  SkillIndicator.update_skill_indicator(key_code, area_cfg, indicator_cfg, sensitivity)
end

function ui:set_indicator_active(keycode, param, lock_tar, extra_pos_x, extra_pos_z, force_red, reset_to_last_drag)
  SkillIndicator.set_indicator_enable(keycode, param, lock_tar, extra_pos_x, extra_pos_z, force_red, reset_to_last_drag)
end

function ui:set_aim_mode_active(param, lock_tar)
end

function ui:set_indicator_pos(keycode, x, y)
  SkillIndicator.set_cur_pos(keycode, x, y)
end

function ui:get_indicator_pos(keycode)
  return SkillIndicator.get_cur_pos(keycode)
end

function ui:set_attach_target_enable(enable)
  return SkillIndicator.set_attach_target_enable(enable)
end

function ui:get_indicator_key_pos(keycode)
  return SkillIndicator.get_indicator_key_pos(keycode)
end

function ui:set_is_force_red(key_code, is_force_red)
  SkillIndicator.set_is_force_red(key_code, is_force_red)
end

function ui:touch_up_btn(index)
  local effect_name = DOWN_SKILL_NAME[index]
  self:stop_dynamic_load_effect(effect_name)
  self.v_uiobjects[effect_name]:SetActive(false)
  self.v_uiobjects["Down" .. index]:SetActive(false)
end

function ui:change_button(show_interact, ignore_btn_skill1, is_show_long_press)
  if not self.v_visible then
    return
  end
  self.v_is_interact = show_interact
  if show_interact then
  elseif not Util.is_client_only() then
    self:update_btn_state(ignore_btn_skill1)
  end
  if self.v_uiobjects.LongPressText then
    self.v_uiobjects.LongPressText:SetActive(is_show_long_press)
  end
  self.v_uiobjects.Btn_Interact:SetActive(show_interact)
end

function ui:refresh_interact_btn_icon(icon)
  ResMgr:load_set_icon(self.v_uicompents.BtnInteractIcon_img, "UIFight/20240227/" .. icon)
end

function ui:_set_small_map_view()
  if Util.is_client_only() then
    return
  end
  self:update_pass_room()
end

function ui:update_pass_room(roomId)
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  roomId = roomId or tower:get_room_num()
  local is_pass = tower:is_pass_room(roomId)
  self.v_is_show_map = is_pass
  self.v_cur_room_id = roomId
  self:update_battle_task_visible(is_pass)
  local tips_fight_pnl = self:get_panel("fight_tips")
  if tips_fight_pnl then
    tips_fight_pnl:update_counttips_rect_pos()
  end
  self.v_pass_tower = is_pass
end

function ui:response_enter_room_event(msg)
  self:revert_btn_pos()
  if Util.is_client_only() then
    return
  end
  if GuideMgr then
    GuideMgr:check_sys_guide(self)
  end
  if nil == msg or nil == msg.mm_obj then
    Log.Info("response_enter_room_event, no param!")
    return
  end
  local roomId = msg.mm_obj
  self.v_force_map_visible = false
  self:update_pass_room(roomId)
  self:reset_toggle_near_item_ui()
end

local NOT_OPNE_BATTLE = {
  "ui_rune_set_suc"
}

function ui:toggle_near_item(msg)
  local is_in = msg.mm_y
  local item = msg.mm_obj
  UIMgr:get_ui("ui_battle_item"):ui_hide()
  if not is_in then
    self:reset_toggle_near_item_ui()
  end
  for _, pnl_name in pairs(NOT_OPNE_BATTLE) do
    if UIMgr:try_get_visible_ui(pnl_name) then
      return
    end
  end
  if StoryMgr:is_playing_full_screen_story() then
    return
  end
  if is_in then
    if item.is_auto_pick_item then
      SceneMgr:get_scene_item_mgr():pick_item(item)
    elseif not UIMgr:try_get_visible_ui("battle_drop_tips") then
      self:change_button(true)
      self:set_ui_node_visible("Right", OBJ_VISIBLE_TYPE.SETTING, false)
      self:set_uiobject_visible("Right")
      self:set_ui_node_visible("FunctionBtn", OBJ_VISIBLE_TYPE.SETTING, false)
      self:set_uiobject_visible("FunctionBtn")
      UIMgr:get_ui("ui_battle_item"):ui_show(item)
      self.v_is_near_item = true
    end
  else
    self.v_is_near_item = false
    self:reset_toggle_near_item_ui()
  end
end

function ui:check_function_btn_visible()
end

function ui:reset_toggle_near_item_ui()
  self:set_ui_node_visible("Right", OBJ_VISIBLE_TYPE.SETTING, true)
  self:set_uiobject_visible("Right")
  self:set_ui_node_visible("FunctionBtn", OBJ_VISIBLE_TYPE.SETTING, true)
  self:set_uiobject_visible("FunctionBtn")
  self:change_button(false)
end

function ui:toggle_restore_hp_room_mode(msg)
  local is_in = msg.mm_y
  local btn_interact = self.v_uicompents.Btn_Interact_btn
  local tower = TowerMgr:get_tower()
  local room = tower:get_room()
  if not room:is_restore_hp_room() then
    return
  end
  local is_restore = room:is_restore()
  if is_in and not is_restore then
    self:change_button(true)
    self:set_button_ex_listener(btn_interact, function()
      Joystick.on_joystick("end")
      local hero = Global.hero
      local effect_param = self.act_effect_ctrl.create_effect_param()
      effect_param.prefab_name = "Fx_cure_start"
      effect_param.parent = hero.transform
      local effect_id = hero.act_effect_ctrl:play_effect(effect_param)
      self:set_uiobject_visible("Main", false)
      hero.magic_mgr:remove_magic_by_id(RESTORE_MAGIC_ID)
      hero.magic_mgr:add_magic(hero, RESTORE_MAGIC_ID, nil, nil, 0, nil, {room_restore_hp = true})
      SceneMgr:c2gs_call_scene("set_room_restore_hp")
      tower:update_room_status(Config.ROOM_TYPE.REST, true)
      MsgGame:mq_publish2(Const.MSG_ON_UPDATE_RESTORE_HP_OBJ)
      Timer:add_timer("restore_finish", 1, function()
        self:set_uiobject_visible("Main", true)
      end)
      self:change_button(false)
      self:click_interact_btn()
    end)
  else
    self:change_button(false)
  end
end

function ui:toggle_treasure_room_mode(msg)
  local is_in = msg.mm_y
  local btn_interact = self.v_uicompents.Btn_Interact_btn
  if is_in then
    self:change_button(true)
    self:set_button_ex_listener(btn_interact, function()
      Joystick.on_joystick("end")
      Global.hero:play_interact_anim()
      MsgGame:mq_publish2(Const.MSG_ON_OPEN_TREASURE)
      self:change_button(false)
      self:click_interact_btn()
    end)
  else
    self:change_button(false)
  end
end

function ui:toggle_cast_shop_room_mode(msg)
  local is_in = msg.mm_y
  local btn_interact = self.v_uicompents.Btn_Interact_btn
  if is_in then
    self:change_button(true)
    self:set_button_ex_listener(btn_interact, function()
      Joystick.on_joystick("end")
      BattleShopMgr:open_battle_shop()
      self:click_interact_btn()
    end)
  else
    self:change_button(false)
  end
end

local AREA_TYPE_FUNCS = {
  [AREA_TYPE.shop] = ui.toggle_cast_shop_room_mode,
  [AREA_TYPE.treasure] = ui.toggle_treasure_room_mode,
  [AREA_TYPE.restore_hp] = ui.toggle_restore_hp_room_mode,
  [AREA_TYPE.near_item] = ui.toggle_near_item
}

function ui:on_togge_special_area(msg)
  local func = AREA_TYPE_FUNCS[msg.mm_x]
  if func then
    func(self, msg)
  end
end

function ui:response_pass_room_event(msg)
  if Util.is_client_only() then
    return
  end
  if nil == msg or nil == msg.mm_obj then
    Log.Info("response_pass_room_event, no param!")
    return
  end
  if GuideMgr then
    GuideMgr:check_sys_guide(self)
  end
  local roomId = msg.mm_obj
  if self.v_cur_room_id == roomId and self.v_force_map_visible then
    return
  end
  self:update_pass_room(roomId)
  self:update_skill_list()
end

function ui:update_skill_list()
  if not Global.hero then
    return
  end
  self.v_battle_skill_list = BattleSkillBookMgr:get_skill_list()
  local hero = Global.hero
  local all_skill_cfg = ShareRes.create("battle.battle_skill")
  local temp = {}
  local skill_group = {}
  for idx, skill_id in pairs(self.v_battle_skill_list) do
    local skill_cfg = all_skill_cfg[skill_id]
    local group_num = skill_cfg.SkillGroup
    local now_level = skill_cfg.SkillLevel
    local buddy_id = skill_cfg.BuddyId
    if group_num then
      skill_group[buddy_id] = skill_group[buddy_id] or {}
      local group = skill_group[buddy_id][group_num]
      if not group then
        skill_group[buddy_id][group_num] = {
          skill_id = skill_id,
          idx = idx,
          level = now_level
        }
      elseif now_level > group.level then
        group.skill_id = skill_id
        group.idx = idx
        group.level = now_level
      end
    end
  end
  for _, group in pairs(skill_group) do
    for _, skill_point in pairs(group) do
      local skill_id = skill_point.skill_id
      local skill_cfg = all_skill_cfg[skill_id]
      local skill_type = skill_cfg.SkillType
      local buddy_id = skill_cfg.BuddyId
      skill_cfg.is_pass = self:_get_is_finish_fight()
      if skill_type == BATTLE_SKILL_TYPE.mastery and hero.buddy_cfg.Id == buddy_id then
        table.insert(temp, skill_cfg)
      end
    end
  end
end

function ui:select_ui_skill_list(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  self.select_item_data = msg.mm_obj
  local idx = msg.mm_obj.idx
end

function ui:update_tower_skill_on_client_only()
  local btn_name = BTN_SKILL_NAME[BTN_NAME_2_SKILL_INDEX.Btn_skill8]
  self:set_ui_node_visible(btn_name, OBJ_VISIBLE_TYPE.SETTING, false)
  local god_npc = SceneMgr:get_god_npc()
  if not god_npc then
    return
  end
  local effect_skill_id = god_npc:get_effect_skill_id()
  local skill = god_npc.skill_mgr:get_skill(effect_skill_id)
  if skill then
    local info = skill:get_energy_info()
    self.v_god_skill = info
    self:_update_skill(TOWER_SKILL_KEY)
    if self.v_skill_update[TOWER_SKILL_BTN] and info then
      self.v_skill_update[TOWER_SKILL_BTN].is_update = info.cur_energy < info.max_energy
    end
    self:set_ui_node_visible(btn_name, OBJ_VISIBLE_TYPE.SETTING, true)
  end
end

function ui:update_tower_skill(force_show)
  local btn_name = BTN_SKILL_NAME[BTN_NAME_2_SKILL_INDEX.Btn_skill8]
  if Util.is_client_only() then
    self:update_tower_skill_on_client_only()
    self:set_uiobject_visible(btn_name)
    return
  end
  if not TowerMgr or not TowerMgr:get_tower() then
    return
  end
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == CommonDefine.CHALLENGE_TYPE.INFINITE then
    self:infinite_chapter_to_set_god_skill()
  end
  if not TowerMgr:check_enable_god_skill() then
    self:set_ui_node_visible(btn_name, OBJ_VISIBLE_TYPE.BUDDY, false)
    self:set_uiobject_visible(btn_name)
    return
  end
  local god_npc = SceneMgr:get_god_npc()
  if not god_npc then
    return
  end
  local char_id = SceneMgr:get_god_npc_id()
  if not char_id then
    local tower = TowerMgr:get_tower()
    local tower_id = tower:get_tower_id()
    local tower_cfg = ShareRes.create("tower.tower", tower_id)
    char_id = tower_cfg.TowerCharId
  end
  if not char_id or 0 == char_id then
    return
  end
  local scene_skill_data = TowerMgr:get_scene_skill_data()
  if not scene_skill_data then
    return
  end
  self.v_last_scene_skill_lv = self.v_cur_scene_skill_lv
  local skill_lv = scene_skill_data.lv
  self.v_cur_scene_skill_lv = skill_lv
  if self.v_last_scene_skill_lv < self.v_cur_scene_skill_lv then
    self:on_scene_skill_lv_up()
  end
  if TowerMgr:get_fight_type() ~= CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE or force_show then
    self:set_ui_node_visible(btn_name, OBJ_VISIBLE_TYPE.BUDDY, true)
  end
  self:set_uiobject_visible(btn_name)
  local effect_skill_id = god_npc:get_effect_skill_id()
  local skill = god_npc.skill_mgr:get_skill(effect_skill_id)
  if skill then
    local info = skill:get_energy_info()
    self.v_god_skill = info
    self:_update_skill(TOWER_SKILL_KEY)
    if self.v_skill_update[TOWER_SKILL_BTN] and info then
      self.v_skill_update[TOWER_SKILL_BTN].is_update = info.cur_energy < info.max_energy
    end
  end
end

function ui:on_scene_skill_lv_up()
  local function cb()
    self.v_scene_lv_up_timer = nil
  end
  
  if self.v_scene_lv_up_timer then
    Timer:remove_timer(self.v_scene_lv_up_timer)
    self.v_scene_lv_up_timer = nil
  end
  self.v_scene_lv_up_timer = Timer:add_timer("scene_lv_up", 0.3, cb)
  MsgGame:mq_publish2(Const.MSG_SCENE_SKILL_LV_UP)
  self.v_last_scene_skill_lv = self.v_cur_scene_skill_lv
end

function ui:update_joystick_move_type()
  local etc_obj = self.v_uiobjects.PanelJoystick
  local etc_joystick_com = Util.get_component(nil, etc_obj, typeof(ETCJoystick)).component
  local joy_stick_move_type
  if not Util.is_client_only() then
    joy_stick_move_type = BattleSettingMgr:get_joy_move_type()
  else
    joy_stick_move_type = Config.SETTING.JOYSTICK_MOVE_TYPE.DYNAMIC
  end
  etc_joystick_com.joystickType = joy_stick_move_type
end

function ui:on_enter_room()
  self:update_btn_state()
end

function ui:update_btn_state(ignore_btn_skill1)
  self:update_joystick_move_type()
  if self.v_is_interact or SceneMgr:global_hero_is_destroyed() then
    return
  end
  self.v_hero_have_skill = {}
  local hero_skill_btn = BattleSkillBookMgr:get_hero_skill_btn()
  local hero = Global.hero
  local hero_id = hero.buddy_cfg.Id
  if not ignore_btn_skill1 then
    self.v_uiobjects.Btn_skill1:SetActive(true)
    self:clear_ui_node_visible_record(BTN_SKILL_NAME[BTN_NAME_2_SKILL_INDEX.Btn_skill1])
  end
  local skill_type_list = hero_skill_btn[hero_id]
  if not skill_type_list then
    for _, name in pairs(SKILL_BUTTON_INDEX) do
      self.v_uiobjects[name]:SetActive(false)
      self:set_ui_node_visible(name, OBJ_VISIBLE_TYPE.TALENT, false)
    end
    return
  end
  self.v_hero_have_skill[hero_id] = self.v_hero_have_skill[hero_id] or {}
  for btn_idx, name in pairs(SKILL_BUTTON_INDEX) do
    local btn_active = self.v_uiobjects[name].activeSelf
    if skill_type_list[btn_idx] then
      self.v_hero_have_skill[hero_id][btn_idx] = true
      self:set_ui_node_visible(name, OBJ_VISIBLE_TYPE.TALENT, true)
    else
      self:set_ui_node_visible(name, OBJ_VISIBLE_TYPE.TALENT, false)
    end
    local new_btn_active = self:check_show_ui_obj(name)
    if new_btn_active ~= btn_active then
      self.v_uiobjects[name]:SetActive(new_btn_active)
    end
  end
  SkillIndicator.reset_start_drag_ratio()
end

function ui:set_ui_node_visible(obj_name, type, is_visible)
  self.v_ui_node_visible_state[obj_name] = self.v_ui_node_visible_state[obj_name] or {}
  self.v_ui_node_visible_state[obj_name][type] = is_visible and OBJ_VISIBLE_STATE.SHOW or OBJ_VISIBLE_STATE.HIDE
end

function ui:clear_ui_node_visible_record(obj_name)
  if self.v_ui_node_visible_state then
    self.v_ui_node_visible_state[obj_name] = nil
  end
end

function ui:_get_is_finish_fight()
  if not TowerMgr then
    return true
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return true
  end
  local is_pass = tower:is_pass_room(tower:get_room_num())
  return is_pass
end

function ui:init_skill_btn_charging()
  if not TowerMgr then
    return
  end
  local skill_btn_charging_data = TowerMgr:get_fight_skill_btn_data()
  if not skill_btn_charging_data then
    return
  end
  for key, data in pairs(skill_btn_charging_data) do
    self:set_skill_btn_charging(key, data.charged_type, data.param_cfg)
  end
end

function ui:set_skill_btn_charging(key_code, charged_type, param_cfg)
  local index = INPUT_COUDE_SKILL_INDEX[key_code]
  if not self.v_skill_charged_data then
    self.v_skill_charged_data = {}
  end
  local last_time
  if self.v_skill_charged_data[index] then
    if param_cfg.param4 then
      last_time = self.v_time_charged_data[index].last_time
    end
    self:clear_charging_data(self.v_skill_charged_data[index])
  end
  if self.v_skill_charging_img[index] then
    self.v_skill_charging_img[index]:force_set_value(0)
    self:update_ui_visible(self.v_skill_charging_img[index]:get_go(), false)
  end
  self.v_skill_charged_data[index] = {
    index = index,
    charged_type = charged_type,
    param_cfg = param_cfg
  }
  local param_type = param_cfg.param_type
  local param1 = param_cfg.param1
  local param2 = param_cfg.param2
  local param3 = param_cfg.param3
  local param4 = param_cfg.param4
  if param_type == SKILL_BTN_PARAM_TYPE.ATTR then
    if not ATTR_CHANGE_EXTRA_UNCS[param1] then
      ATTR_CHANGE_EXTRA_UNCS[param1] = {}
    end
    ATTR_CHANGE_EXTRA_UNCS[param1][index] = function(self, msg)
      self:update_attr_charging_progress(index)
    end
    if not ATTR_CHANGE_EXTRA_UNCS[param2] then
      ATTR_CHANGE_EXTRA_UNCS[param2] = {}
    end
    ATTR_CHANGE_EXTRA_UNCS[param2][index] = function(self, msg)
      self:update_attr_charging_progress(index)
    end
    self:update_attr_charging_progress(index)
  elseif param_type == SKILL_BTN_PARAM_TYPE.TIME then
    local charged_data = self:get_time_charged_data(index, charged_type, param4)
    charged_data.start_time = param1
    charged_data.end_time = param2
    charged_data.diff_val = param2 - param1
    charged_data.last_time = last_time or 0
    charged_data.index = index
    self:update_time_charged_pro()
  elseif param_type == SKILL_BTN_PARAM_TYPE.MAGIC_TIME then
    local charged_ui
    if self.v_magic_charged_data[index] then
      charged_ui = self.v_magic_charged_data[index].obj
    else
      charged_ui = self:get_low_charged_comp(index)
    end
    self.v_magic_charged_data[index] = {
      npc = param1,
      magic_id = param2,
      is_negative_pro = param3,
      index = index,
      obj = charged_ui,
      charged_type = charged_type
    }
    self:update_magic_charged_data()
  end
end

function ui:update_magic_charged_data()
  if self:is_destroy() then
    return
  end
  local low_sld, low_img
  for _, charged_data in pairs(self.v_magic_charged_data) do
    if not Util.is_destroy(charged_data.npc) and charged_data.npc.magic_mgr then
      local npc = charged_data.npc
      local check_magic_id = charged_data.magic_id
      local is_negative_pro = charged_data.is_negative_pro
      local magic_mgr = npc.magic_mgr
      local magic = magic_mgr:get_magic_by_id(check_magic_id)
      local index = charged_data.index
      if magic then
        local life_time = magic.duration
        local left_time = magic.left_duration
        local pro_val = left_time / life_time
        if not is_negative_pro then
          pro_val = 1 - pro_val
        end
        if charged_data.charged_type == CHARGED_TYPE.CIRCULAR_CHARGED then
          low_img = self.v_skill_charging_img[index]
          self:update_ui_visible(low_img:get_go(), true)
          low_img:set_value(pro_val)
        elseif charged_data.charged_type == CHARGED_TYPE.SLIDER_CHARGED then
          low_sld = charged_data.obj
          low_sld:set_value(pro_val)
          self:update_ui_visible(low_sld:get_go(), true)
        end
      elseif charged_data.charged_type == CHARGED_TYPE.CIRCULAR_CHARGED then
        low_img = self.v_skill_charging_img[index]
        self:update_ui_visible(low_img:get_go(), false)
      elseif charged_data.charged_type == CHARGED_TYPE.SLIDER_CHARGED then
        low_sld = charged_data.obj
        self:update_ui_visible(low_sld:get_go(), false)
      end
    end
  end
end

function ui:get_time_charged_data(index, charged_type)
  if charged_type == CHARGED_TYPE.CIRCULAR_CHARGED then
    self.v_time_charged_data[index] = {}
    return self.v_time_charged_data[index]
  end
  local time_charged_data = self.v_time_charged_data[index]
  if not time_charged_data then
    local sld = self:get_low_charged_comp(index)
    self.v_time_charged_data[index] = {obj = sld}
  end
  return self.v_time_charged_data[index]
end

function ui:get_charged_ui(index)
  local new_sld = self:get_auto_cache(CHARGSLD_TEMPLETE_KEY)
  new_sld.transform:SetParent(self.v_uiobjects[BTN_SKILL_NAME[index]].transform, false)
  new_sld.transform:ResetAttr()
  return new_sld
end

function ui:get_low_charged_comp(index)
  local new_sld = self:get_charged_ui(index)
  local slider = self:get_slider(nil, new_sld).component
  local low_sld = LowUpdateSlider:new(slider, 0, ImgLowUpdateInterval, new_sld)
  self.v_low_update_comp_map[low_sld] = low_sld
  self:update_ui_visible(low_sld:get_go(), true)
  return low_sld
end

function ui:update_time_charged_pro()
  local low_sld, low_img
  for _, data in pairs(self.v_time_charged_data) do
    local index = data.index
    local charged_data = self.v_skill_charged_data[index]
    data.start_time = data.start_time or 0
    data.last_time = data.last_time + Global.delta_time
    local is_full = data.last_time < data.diff_val
    if charged_data.charged_type == CHARGED_TYPE.CIRCULAR_CHARGED then
      low_img = self.v_skill_charging_img[index]
      self:update_ui_visible(low_img:get_go(), is_full)
      low_img:set_value(data.last_time / data.diff_val)
    elseif charged_data.charged_type == CHARGED_TYPE.SLIDER_CHARGED then
      low_sld = data.obj
      low_sld:set_value(data.last_time / data.diff_val)
      self:update_ui_visible(low_sld:get_go(), is_full)
    end
  end
end

function ui:behavior_clear_charing(key_code)
  local index = INPUT_COUDE_SKILL_INDEX[key_code]
  if not self.v_skill_charged_data or not self.v_skill_charged_data[index] then
    return
  end
  self:clear_charging_data(self.v_skill_charged_data[index])
end

function ui:clear_charging_data(data, is_hide)
  local index = data.index
  if self.v_skill_charging_img[index] then
    self.v_skill_charging_img[index]:force_set_value(0)
    self:update_ui_visible(self.v_skill_charging_img[index]:get_go(), false)
  end
  local param_cfg = data.param_cfg
  local param_type = param_cfg.param_type
  if param_type == SKILL_BTN_PARAM_TYPE.ATTR then
    local param1 = param_cfg.param1
    local param2 = param_cfg.param2
    if ATTR_CHANGE_EXTRA_UNCS[param1] and ATTR_CHANGE_EXTRA_UNCS[param1][index] then
      ATTR_CHANGE_EXTRA_UNCS[param1][index] = nil
    end
    if ATTR_CHANGE_EXTRA_UNCS[param2] and ATTR_CHANGE_EXTRA_UNCS[param2][index] then
      ATTR_CHANGE_EXTRA_UNCS[param2][index] = nil
    end
    local low_sld = self.v_slider_charged[index]
    if low_sld then
      local obj = low_sld:get_lua_obj()
      if not is_hide then
        self:give_back_cache_obj(CHARGSLD_TEMPLETE_KEY, obj)
      end
      low_sld:on_destroy()
      self:remove_low_update_comp_map(low_sld)
    end
    self.v_slider_charged[index] = nil
  elseif param_type == SKILL_BTN_PARAM_TYPE.TIME then
    local charged_data = self.v_time_charged_data[index]
    if charged_data and charged_data.obj then
      local obj = charged_data.obj:get_lua_obj()
      if not is_hide then
        self:give_back_cache_obj(CHARGSLD_TEMPLETE_KEY, obj)
      end
      charged_data.obj:on_destroy()
      self:remove_low_update_comp_map(charged_data.obj)
    end
    self.v_time_charged_data[index] = nil
  elseif param_type == SKILL_BTN_PARAM_TYPE.MAGIC_TIME then
    local charged_data = self.v_magic_charged_data[index]
    if charged_data and charged_data.obj then
      local obj = charged_data.obj:get_lua_obj()
      if not is_hide then
        self:give_back_cache_obj(CHARGSLD_TEMPLETE_KEY, obj)
      end
      charged_data.obj:on_destroy()
      self:remove_low_update_comp_map(charged_data.obj)
    end
    self.v_magic_charged_data[index] = nil
  end
end

function ui:update_attr_charging_progress(index)
  if not self.v_skill_charged_data[index] then
    return
  end
  if SceneMgr:global_hero_is_destroyed() then
    return
  end
  local attr_mgr = Global.hero.attr_mgr
  local god_npc = SceneMgr:get_god_npc()
  if index == TOWER_SKILL_KEY and god_npc then
    attr_mgr = god_npc.attr_mgr
  end
  local skill_charging_data = self.v_skill_charged_data[index]
  local charged_type = skill_charging_data.charged_type
  local param_cfg = skill_charging_data.param_cfg
  local cur_val = attr_mgr:get_attr(param_cfg.param1) or 0
  local max_val = attr_mgr:get_attr(param_cfg.param2) or 0
  if charged_type == CHARGED_TYPE.CIRCULAR_CHARGED then
    local low_img = self.v_skill_charging_img[index]
    self:update_ui_visible(low_img:get_go(), true)
    low_img:set_value(cur_val / max_val)
  elseif charged_type == CHARGED_TYPE.SLIDER_CHARGED then
    local low_sld = self.v_slider_charged[index]
    if not low_sld then
      low_sld = self:get_low_charged_comp(index)
      self.v_slider_charged[index] = low_sld
    end
    low_sld:set_value(cur_val / max_val)
  end
end

function ui:show_magic_num(key_code, value)
  local index = INPUT_COUDE_SKILL_INDEX[key_code]
  if not self.v_magic_num_content[index] then
    return
  end
  if not value or value <= 0 then
    self.v_magic_num_content[index].gameObject:SetActive(false)
    return
  end
  self.v_magic_num_content[index].gameObject:SetActive(true)
  self.v_magic_num_text[index].text = value
end

function ui:screen_fade(start_alpha, end_alpha, time, wait_time, stay_time, callback)
  if self.v_screen_sequence then
    self.v_screen_sequence:Kill(false)
  end
  self.v_uiobjects.UpBg:SetActive(true)
  local alpha_target = self.v_uiobjects.UpBg:GetComponent("CanvasGroup")
  alpha_target.alpha = start_alpha
  self.v_screen_sequence = Util.create_sequence()
  if wait_time then
    self.v_screen_sequence:AppendInterval(wait_time)
  end
  self.v_screen_sequence:Append(alpha_target:DOFade(end_alpha, time))
  if stay_time then
    self.v_screen_sequence:AppendInterval(stay_time)
  end
  self.v_screen_sequence:OnComplete(function()
    if 0 == end_alpha then
      self.v_uiobjects.UpBg:SetActive(false)
    end
    self.v_screen_sequence:Kill(false)
    self.v_screen_sequence = nil
    if callback then
      callback()
    end
  end)
end

function ui:response_secen_load_finish_event(msg)
  self.v_heads_view:reset_head_cd()
  self:reset_btn_update_state()
  if Util.is_client_only() then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local fight_info = TowerMgr:get_fight_info()
  if fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.BEST_CONF or fight_info.type == CommonDefine.CHALLENGE_TYPE.CUT_GRASS then
    return
  end
  local cur_room_num = tower:get_room_num()
  if not tower:is_pass_room(cur_room_num) then
    return
  end
  if not tower:check_pass_all_room(true) then
    return
  end
  if DropShowMgr:is_have_drop_item_show() or DropShowMgr:is_showing_ui_list() then
    return
  end
  local fight_info = TowerMgr:get_fight_info()
  tower:set_is_settle(true)
  if fight_info.type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
  else
    UIMgr:get_ui("fight_settlement"):ui_show(CHAPTER_CONFIG.POINTSTATE.quit)
  end
end

function ui:cache_ui()
  return true
end

function ui:load_setting_layout()
  if Util.is_client_only() then
    self:init_skill_pos_data()
    return
  end
  local layout_list = BattleSettingMgr:get_btn_layout_list()
  local use_save_layout = false
  for _, layout_info in ipairs(layout_list) do
    if layout_info.is_use == Fight_Layout_Cfg.layout_is_use.using then
      local ui_list = layout_info.ui_list
      BattleSettingMgr:check_btn_layout_list(layout_info)
      self:refresh_layout(ui_list)
      use_save_layout = true
      break
    end
  end
  if not use_save_layout and layout_list[1] then
    self:refresh_layout(layout_list[1].ui_list)
  end
  self:init_skill_pos_data()
end

function ui:init_skill_pos_data()
  local rect, anchoredPosition
  self.v_skill_btn_pos = self.v_skill_btn_pos or {}
  for index = NORMAL_ATK, SKILL_NORMAL_END do
    if not Config.ABANDON_BTN_IDX[index] then
      rect = self.v_uicompents[BTN_SKILL_NAME[index] .. "_rect"]
      anchoredPosition = rect.anchoredPosition
      self.v_skill_btn_pos[index] = self.v_skill_btn_pos[index] or {}
      self.v_skill_btn_pos[index].x = anchoredPosition.x
      self.v_skill_btn_pos[index].y = anchoredPosition.y
    end
  end
end

function ui:refresh_layout(ui_list)
  local group_name, root_name, child_name, ui_obj
  local paneljoystick_str = "PanelJoystick"
  for ui_name, data in pairs(ui_list) do
    group_name = Fight_Layout_Cfg.layout_group_map[ui_name]
    root_name = Fight_Layout_Cfg.layout_container_root[group_name]
    if not root_name then
      ui_obj = self.v_uiobjects[ui_name]
    else
      child_name = Fight_Layout_Cfg.layout_child_obj_name[root_name]
      local child_panel = self:get_panel(child_name)
      if child_panel then
        ui_obj = child_panel:get_uiobject(ui_name)
      end
    end
    if not ui_obj then
    else
      local rect = Util.get_rect_transform(nil, ui_obj)
      if rect then
        rect = rect.component
        rect:SetLocalScaleA(data.scale_x, data.scale_y, data.scale_z)
        rect:SetAnchoredMinMax(data.anchor_min_x, data.anchor_min_y, data.anchor_max_x, data.anchor_max_y)
        rect:SetAnchoredPositionA(data.x, data.y)
        if ui_name == paneljoystick_str then
          local etc_joystick = self.v_uiobjects.PanelJoystick:GetComponent(typeof(CS.ETCJoystick))
          if not Util.is_nil(etc_joystick) then
            etc_joystick:ResetOriginAnchoredPos()
          end
        end
      end
    end
  end
end

function ui:_on_show_attr_change_tips(msg)
  if not self.v_pass_tower then
    return
  end
end

function ui:is_show_map()
  return self.v_is_show_map
end

function ui:set_map_visible(is_visible, force_visible)
  self.v_is_show_map = is_visible
  self.v_pass_tower = is_visible
  self.v_force_map_visible = force_visible
  self:update_battle_task_visible(is_visible)
end

function ui:get_is_in_challenge()
  return self.v_pass_tower or false
end

function ui:response_dbm_show(msg)
  if nil == msg then
    return
  end
  local dbm_id = msg.mm_x
  self.v_panels.fight_DBM:set_enable(true)
  self.v_panels.fight_DBM:add_dbm_item(dbm_id)
end

function ui:response_dbm_close(msg)
  if nil == msg then
    return
  end
  local dbm_id = msg.mm_x
  local close_type = msg.mm_y
  self.v_panels.fight_DBM:remove_dbm_item(dbm_id, close_type)
end

function ui:show_dbm_with_banner(text, live_time, color)
  self.v_panels.fight_DBM:set_enable(true)
  self.v_panels.fight_DBM:add_dbm_item_with_banner(text, live_time, color)
end

function ui:show_dbm_by_id(id, need_fade)
  self.v_panels.fight_DBM:set_enable(true)
  self.v_panels.fight_DBM:add_dbm_item(id, need_fade)
end

function ui:hide_dbm_with_banner()
  self.v_panels.fight_DBM:remove_dbm_item_with_banner()
end

function ui:click_interact_btn()
  SceneMgr:c2gs_call_scene("on_click_operation", 1)
end

function ui:check_game_play_logic()
  if not TowerMgr then
    self.v_uiobjects.Button_Pause:SetActive(false)
    return
  end
  local fight_info = TowerMgr:get_fight_info()
  if fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    self.v_uiobjects.Button_Tp:SetActive(true)
    if ChallengeRingPlusMgr:is_in_start_room() then
      self.v_uiobjects.Button_Tp:SetActive(false)
    end
  end
end

function ui:response_fight_bag_update_event(msg)
  if GuideMgr then
    GuideMgr:check_sys_guide(self)
  end
end

function ui:open_prepare_btn()
  self.v_uiobjects.Button_Pause:SetActive(true)
end

function ui:on_joystick()
  local guide_ui = UIMgr:try_get_visible_ui("ui_guide")
  if not guide_ui then
    return
  end
  local msg = MsgGame:mq_publish2(Const.MSG_CLICK_TARGET_UI)
  msg.mm_x = "fight"
end

function ui:on_track_task_id()
  if not self.v_fight_task then
    return
  end
  self.v_fight_task:update_task_view()
  self:reset_task_guid_time()
end

function ui:update_battle_task_visible(is_visible)
  if not self.v_fight_task then
    return
  end
  if not is_visible then
    local tower = TowerMgr and TowerMgr:get_tower()
    if tower then
      local is_pass_room = tower:is_pass_room()
      is_visible = not is_pass_room and tower:is_show_battle_task()
    end
  end
  self.v_fight_task:update_visible(is_visible)
end

function ui:on_track_task_pro_change()
  if not self.v_fight_task then
    return
  end
  self.v_fight_task:update_task_pro()
end

function ui:reset_task_guid_time()
  if not self.v_fight_task then
    return
  end
  self.v_fight_task:reset_guid_cd_time()
end

function ui:on_battle_task_receive_or_complete(msg)
  local task_id = msg.mm_x
  if not self.v_fight_task then
    return
  end
  self.v_fight_task:battle_task_receive_or_complete(task_id)
  local task_state = msg.mm_y
  local banner_tip = UIMgr:try_get_visible_ui("banner_tip")
  if task_state == TASK_STATE.COMPLETE then
    if banner_tip then
      banner_tip:battle_task_receive_or_complete(NOTICE_TYPE.BATTLE_TASK_COMPLETE)
    else
      UIMgr:get_ui("banner_tip"):ui_show(NOTICE_TYPE.BATTLE_TASK_COMPLETE)
    end
  elseif task_state == TASK_STATE.RECEIVE then
    if banner_tip then
      local task_obj = BattleTaskMgr:get_task(task_id)
      local task_cfg = task_obj:get_task_cfg()
      local track_task_id = BattleTaskMgr:get_track_task_id()
      local track_task = BattleTaskMgr:get_task(track_task_id)
      if track_task then
        local track_task_cfg = track_task:get_task_cfg()
        if task_cfg.Group == track_task_cfg.Group and task_cfg.Type == TASK_TYPE.MAIN and track_task_cfg.Type == TASK_TYPE.MAIN then
          return
        end
      end
      banner_tip:battle_task_receive_or_complete(NOTICE_TYPE.BATTLE_TASK_RECEIVE)
    else
      UIMgr:get_ui("banner_tip"):ui_show(NOTICE_TYPE.BATTLE_TASK_RECEIVE)
    end
  end
end

function ui:response_update_indicator_config()
  SkillIndicator.update_skill_active_location()
end

function ui:_response_ban_skill(msg)
  local idx = msg.mm_x
  local visible = msg.mm_y
  self:set_ban_use_icon_visiable(idx, visible)
  local canvas_group = self:get_canvas_group(nil, self.v_uiobjects[BTN_SKILL_NAME[idx]])
  local component = canvas_group and canvas_group.component
  if component and 0 ~= component.alpha then
    component.alpha = visible and 0.2 or 1
  end
end

function ui:set_ban_use_icon_visiable(idx, visible)
  local banObj = self.v_uiobjects["BanUse" .. idx]
  if not banObj then
    return
  end
  banObj:SetActive(visible)
  local btn = self.v_uicompents[BTN_SKILL_NAME[idx] .. "_btn"]
  if not btn then
    return
  end
  btn.interactable = not visible
end

function ui:_response_time_finish(msg)
  local fight_info = TowerMgr:get_fight_info()
  if not fight_info then
    return
  end
  local tip_cfg = ShareRes.create("scene.scene_tips", msg.mm_x)
  local fight_tips_type = CommonDefine.FIGHT_TIPS_TYPE
  if tip_cfg.Type == fight_tips_type.TIMER then
    SceneMgr:c2gs_call_scene("time_counter_end", msg.mm_x)
  end
end

function ui:pre_show_joystick()
  self.v_uiobjects.JoystickContent:SetActive(true)
  local canvas_group = self.v_uicompents.JoystickContent_cg
  if canvas_group and not canvas_group:IsNull() then
    canvas_group.alpha = 0
  end
end

function ui:real_show_joystick()
  self.v_uiobjects.JoystickContent:SetActive(true)
  local canvas_group = self.v_uicompents.JoystickContent_cg
  if canvas_group and not canvas_group:IsNull() then
    canvas_group.alpha = 1
  end
end

function ui:_set_team_skill_view(msg)
  local god_npc = SceneMgr:get_god_npc()
  if not god_npc then
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  if nil == hero_list then
    return
  end
  local len = UtilTable.hash_lenth(hero_list)
  if len <= 1 then
    return
  end
end

function ui:get_team_skill_percent()
  return 0
end

function ui:update_qte_skill_state()
  self.v_switch_cd_flag = {
    [1] = true,
    [2] = true
  }
end

function ui:do_switch_robot_hero(keycode)
  if not SceneMgr:get_has_robot_hero() then
    Log.Info("没有可替换的操控单位！")
    return
  end
  local state_mgr = Global.hero.state_manager
  local die_state = state_mgr:get_die_state()
  if state_mgr:is_die_state() and die_state:in_animation() and not force then
    return
  end
  if Util.is_client_only() then
    MsgGame:mq_publish2(Const.MSG_DO_SWITCH_OPERATE_CHAR)
  else
    SwitchHeroHelper.do_switch_robot_hero()
  end
end

function ui:inner_switch_operate_char()
  local cur_hero = Global.hero
  cur_hero.skill_mgr:abort(Config.SKILL_ABORT_TYPE.FOECE | Config.SKILL_ABORT_TYPE.BREAK_ABORT)
  self.v_replaced_hero = Global.hero
  SceneMgr:switch_robot_hero(INPUT_CODE.OPERATE_CHAR1)
  if not SceneMgr:check_is_switching_hero() then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_INPUT, INPUT_CODE.OPERATE_CHAR1)
  end
end

function ui:update_effect_obj_visible(is_visible)
  self.v_is_effect_visible = is_visible
end

function ui:set_curse_ring()
  UIMgr:try_hide_ui("curse_ring_view")
  if TowerMgr then
    local fight_info = TowerMgr:get_fight_info()
    if fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
      UIMgr:get_ui("curse_ring_view"):ui_show()
    end
  end
end

function ui:update_sp_sld_val(delta_time)
  if Global.hero == nil then
    return
  end
  self:update_hero_head_sld(delta_time)
end

function ui:update_hero_head_sld(delta_time)
  self.v_heads_view:update_normal_atk_energy(delta_time)
end

function ui:add_curse(add_val)
end

function ui:infinite_chapter_to_set_god_skill()
  local privilege_ids = ChapterMgr:get_cur_infinite_id_list()
  if privilege_ids and next(privilege_ids) ~= nil then
    local is_open = false
    for _, id in pairs(privilege_ids) do
      local infinite_privilege_cfg = ShareRes.create("chapter.infinite_privilege", id)
      if infinite_privilege_cfg.EffectType[1] == INFINITE_EFFECT_TYPE.SCENE_SKILL then
        is_open = true
        break
      end
    end
    TowerMgr:enable_god_skill(is_open, true)
  end
end

function ui:get_button_cur_state(keycode)
  return self.v_button_state_list[keycode]
end

function ui:set_main_interactable(is_interactable)
  local canvas_grp = self:get_canvas_group(nil, self.v_uiobjects.Main)
  if canvas_grp then
    canvas_grp.interactable = is_interactable
  end
end

function ui:update_task_navigator_state()
  if self.v_fight_task then
    self.v_fight_task:update_task_navigator_state()
  end
end

function ui:update_task_condition_progress()
  if self.v_fight_task then
    self.v_fight_task:update_task_condition_progress()
  end
end

function ui:set_enemy_bar_visible(visible)
  if visible then
    self.v_panels.enemy_bar:reset_flash_visible()
    self.v_panels.enemy_bar:reset_weakness()
  end
end

function ui:set_hp_visible(visible)
  if UIMgr:try_get_visible_ui("challenge_ring_plus") then
    return
  end
  self.v_panels.hero_bar:set_enable(visible)
  if visible then
    self.v_panels.hero_bar:reset_heal_effect()
    self.v_panels.hero_head_view:reset_heal_effect()
  end
end

function ui:on_set_safe_panel_alpha(is_visible)
  if not TimeLineSeqPlayer.IS_PLAY_TIMELINE and not UIMgr:try_get_visible_ui("challenge_ring_plus") and Global.ui_dynamic_canvas then
    Global.ui_dynamic_canvas:set_ui_alpha(is_visible and 1 or 0)
  end
end

function ui:update_offset_param(delta_time)
  if not self.v_qte_skill_fill_offset_param then
    return
  end
  for key, param in pairs(self.v_qte_skill_fill_offset_param) do
    if param.is_add then
      param.offset = param.offset + delta_time
      if param.offset >= param.max then
        param.offset = param.max
        param.is_add = false
      end
    else
      param.offset = param.offset - delta_time
      if param.offset <= param.min then
        param.offset = param.min
        param.is_add = true
      end
    end
  end
end

function ui:update_team_skill_energy()
  if SceneMgr:global_hero_is_destroyed() then
    return
  end
  if not self.v_skill_update or not self.v_uicompents.QteFill_img then
    return
  end
  local skill_update = self.v_skill_update
  if not skill_update[QTE_SHOW_SKILL_IDX] then
    skill_update[QTE_SHOW_SKILL_IDX] = {}
  end
  local cur = Global.hero.attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY)
  local max = Global.hero.attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY_MAX)
  local r, g, b, a = self.v_uicompents.QteFill_img:GetGraphicColor()
  local skill_info = self:get_cur_skill_info(QTE_SHOW_SKILL_IDX)
  if 0 == max then
    skill_update[QTE_SHOW_SKILL_IDX].is_update = skill_info.cur_energy < skill_info.max_energy
    a = 0.1
  elseif cur / max < 1 then
    skill_update[QTE_SHOW_SKILL_IDX].is_update = true
    a = 0.1
  elseif cur / max >= 1 then
    skill_update[QTE_SHOW_SKILL_IDX].is_update = skill_info.cur_energy < skill_info.max_energy
    a = 0.1
  end
  self.v_uicompents.QteFill_img:SetGraphicColor(r, g, b, a)
end

function ui:do_qte_skill_anima(delta_time)
  if SceneMgr.global_hero_is_destroyed() then
    return
  end
  local slider = self.v_uicompents.QteSlider_sld
  local per = Global.hero.attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY) / Global.hero.attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY_MAX)
  if per >= 0.98 then
    return
  end
  local fill_offset, rote_offset
  if delta_time and per > DO_ANIMA_LOWER_LIMIT then
    self:update_offset_param(delta_time)
    local param = self.v_qte_skill_fill_offset_param
    fill_offset, rote_offset = param.fill.offset, param.rote.offset
  elseif slider.value > 0 then
    fill_offset, rote_offset = 0, 0
  else
    return
  end
  local ax, ay, _ = self.v_uicompents.QteSlider_rect:GetEulerAnglesA3()
  slider.value = per + fill_offset * DO_ANIMA_LOWER_LIMIT
  self.v_uicompents.QteSlider_rect:SetEuler(ax, ay, rote_offset * ANIMA_MILT)
end

function ui:set_btn_charging_type(skill_id, charge_type, is_on, cur_cd, max_cd, cd_recove_per_second, attr_id)
  if charge_type == Config.CD_MASK_TYPE.ATTR and 0 == max_cd then
    return
  end
  self:refresh_single_charge_cur_cd(skill_id)
  local index, skill_info = self:get_skill_index_by_id(skill_id)
  if skill_info then
    self.v_btn_charging_params[skill_id] = self.v_btn_charging_params[skill_id] or {}
    local params = self.v_btn_charging_params[skill_id]
    params.charge_type = charge_type
    params.is_on = is_on
    if params.is_on then
      if params.charge_type == Config.CD_MASK_TYPE.ATTR then
        attr_id = attr_id or Config.CHAR_ATTR_TYPE.CHAR_SP
        params.is_sp = attr_id == Config.CHAR_ATTR_TYPE.CHAR_SP
        params.cur_cd = params.is_sp and Global.hero:get_fake_sp_value() or Global.hero.attr_mgr:get_attr(attr_id)
        params.attr_id = attr_id
        params.max_cd = max_cd
        params.cd_recove_per_second = cd_recove_per_second
        params.cur_value = params.cur_cd / params.max_cd
        params.need_charge_time = (params.max_cd - params.cur_cd) / params.cd_recove_per_second
      elseif params.charge_type == Config.CD_MASK_TYPE.TIME then
        params.cur_cd = 0
        params.max_cd = cur_cd
        params.cur_value = 0
        params.need_charge_time = params.max_cd
      end
    end
    params.total_charge_time = 0
    params.index = index
    if params.is_sp then
      self:update_ui_visible(self.v_uiobjects[ENERGY_TIME_NAME[index]], true)
    end
  end
end

function ui:update_all_btn_cd(delta_time)
  if SceneMgr:global_hero_is_destroyed() then
    return
  end
  for skill_id, btn_cd_param in pairs(self.v_btn_charging_params) do
    self:update_btn_cd(btn_cd_param, skill_id, delta_time)
  end
end

function ui:update_btn_cd(btn_cd_param, skill_id, delta_time)
  local skill_info = self:get_cur_skill_info(btn_cd_param.index)
  local is_show_skill = skill_info and skill_info.skill_id == skill_id
  local charge_done
  if btn_cd_param.is_on then
    local owner = skill_info and skill_info.owner_buddy_id and SceneMgr:get_hero_by_id(skill_info.owner_buddy_id)
    if Util.is_destroy(owner) then
      is_show_skill = false
    else
      delta_time = delta_time * owner.time_mgr:get_time_scale()
      if btn_cd_param.charge_type == Config.CD_MASK_TYPE.ATTR then
        local attr_value = owner.attr_mgr:get_attr(btn_cd_param.attr_id)
        if btn_cd_param.is_sp then
          btn_cd_param.cur_cd = owner:get_fake_sp_value()
          charge_done = attr_value >= btn_cd_param.max_cd
        else
          btn_cd_param.cur_cd = attr_value
          charge_done = btn_cd_param.cur_cd >= btn_cd_param.max_cd
        end
      else
        btn_cd_param.cur_cd = btn_cd_param.cur_cd + delta_time
        charge_done = btn_cd_param.cur_cd >= btn_cd_param.max_cd
      end
      btn_cd_param.total_charge_time = btn_cd_param.total_charge_time + delta_time
      if charge_done then
        btn_cd_param.cur_value = 1
        btn_cd_param.total_charge_time = btn_cd_param.need_charge_time
        self.v_btn_charging_params[skill_id] = nil
      else
        btn_cd_param.cur_value = btn_cd_param.cur_cd / btn_cd_param.max_cd
      end
    end
  else
    self.v_btn_charging_params[skill_id] = nil
  end
  if is_show_skill then
    self:update_btn_cd_ui(btn_cd_param, skill_id, charge_done)
  end
end

function ui:update_btn_cd_ui(btn_cd_param, skill_id, charge_done)
  local skill_mask = self.v_skill_mask_list[btn_cd_param.index]
  if btn_cd_param.is_on then
    if not charge_done and btn_cd_param.is_on ~= skill_mask:is_go_active() then
      self:_on_charge_start(btn_cd_param.index)
    end
    if charge_done then
      self:_on_charge_done(btn_cd_param, btn_cd_param.index)
      self:update_skill_btn(btn_cd_param.index)
    end
    self:_set_charge_info(btn_cd_param, btn_cd_param.index)
  else
    self:update_ui_visible(skill_mask:get_go(), false)
    self:update_ui_visible(self.v_uiobjects[ENERGY_TIME_NAME[btn_cd_param.index]], false)
    self:set_skill_time_text(btn_cd_param.index, EMPTY_STR)
  end
end

function ui:refresh_charge_cur_cd()
  local skill_mgr = Global.hero.skill_mgr
  if not skill_mgr then
    return
  end
  for skill_id, params in pairs(self.v_btn_charging_params) do
    self:refresh_single_charge_cur_cd(skill_id, params)
  end
end

function ui:refresh_single_charge_cur_cd(skill_id, cd_params)
  if not self.v_btn_charging_params[skill_id] then
    return
  end
  cd_params = cd_params or self.v_btn_charging_params[skill_id]
  local index = cd_params.index
  if not Global.hero.skill_mgr:get_skill(skill_id) then
    self:update_ui_visible(self.v_uiobjects[ENERGY_TIME_NAME[index]], false)
  end
  if cd_params.attr_id and cd_params.is_on and cd_params.charge_type == Config.CD_MASK_TYPE.ATTR then
    local skill_info = self:get_cur_skill_info(index)
    cd_params.cur_cd = cd_params.is_sp and Global.hero:get_fake_sp_value() or Global.hero.attr_mgr:get_attr(cd_params.attr_id)
    self:update_ui_visible(self.v_uiobjects[ENERGY_TIME_NAME[index]], cd_params.is_sp and skill_info.skill_id == skill_id)
  end
end

function ui:_set_charge_info(btn_cd_param, index)
  local percent, time_str, is_zero
  if btn_cd_param.charge_type == Config.CD_MASK_TYPE.ATTR then
    local recove_per
    if btn_cd_param.is_sp then
      recove_per = Global.hero:get_real_recover_value()
    else
      recove_per = btn_cd_param.cd_recove_per_second
    end
    if 0 == recove_per then
      is_zero = true
      percent = 0.5
    else
      percent = btn_cd_param.cur_cd / btn_cd_param.max_cd
      time_str = (btn_cd_param.max_cd - btn_cd_param.cur_cd) / recove_per
    end
  else
    percent = btn_cd_param.cur_value
    time_str = btn_cd_param.need_charge_time - btn_cd_param.total_charge_time
  end
  if percent <= 0 or percent >= 1 then
    self:set_skill_time_text(index, EMPTY_STR)
  elseif is_zero then
    self:set_skill_time_text(index, INFINITY)
  else
    self:set_skill_time_text(index, string.format(SEN_STR, time_str))
  end
  self.v_skill_mask_list[index]:set_value(1 - percent)
end

function ui:_on_charge_start(index)
  self:update_skill_btn(index)
  if not self.v_skill_cd_fx_is_showing[index] and self.v_skill_cd_not_enough_fx_list[index] then
    self:play_effect(SKILL_CD_NOT_ENOUGH_NAME[index])
    self.v_skill_cd_fx_is_showing[index] = true
  end
  self:update_ui_visible(self.v_skill_mask_list[index]:get_go(), true)
end

function ui:_on_charge_done(btn_cd_param, index, keycode)
  self:update_ui_visible(self.v_skill_mask_list[index]:get_go(), false)
  if self.v_skill_cd_fx_is_showing[index] and self.v_skill_cd_not_enough_fx_list[index] then
    self.v_skill_cd_not_enough_fx_list[index]:SetActive(false)
    self:stop_effect(SKILL_CD_NOT_ENOUGH_NAME[index])
    self.v_skill_cd_fx_is_showing[index] = false
  end
  if self.v_skill_charge_list[index] then
    self:update_ui_visible(self.v_skill_charge_list[index], false)
  end
  self:update_ui_visible(self.v_uiobjects[ENERGY_TIME_NAME[index]], false)
end

function ui:update_skill_expend_count(uuid)
  local map = BattleSkillBookMgr:get_skill_expend_count_map(uuid)
  self.v_skill_expend_count_list = map[uuid]
end

function ui:set_skill_expend_point(index)
  if SceneMgr:global_hero_is_destroyed() or Config.ABANDON_BTN_IDX[index] then
    return
  end
  local root = self.v_expend_count_root[index]
  local skill_info = self:get_cur_skill_info(index)
  if not root then
    Log.Error("按钮", index, "没有添加Consume")
    return
  elseif not skill_info then
    root:SetActive(false)
    return
  end
  local objs = self.v_expend_obj_list[index]
  local expend_count = self.v_skill_expend_count_list[skill_info.skill_id]
  if not expend_count then
    BattleSkillBookMgr:init_expend_count(Global.hero, skill_info.skill_id)
    expend_count = self.v_skill_expend_count_list[skill_info.skill_id]
  end
  if not expend_count or 0 == expend_count then
    root:SetActive(false)
  else
    local not_enough = expend_count > Global.hero:get_fake_sp_count()
    local cur_count = #objs
    local need_create_count = expend_count - cur_count
    local point
    if need_create_count > 0 then
      local point
      for i = 1, need_create_count do
        point = self:get_auto_cache(CONSUME_TEMPLETE_KEY)
        point.transform:SetParent(root.transform)
        point:ResetAttr()
        objs[#objs + 1] = point
      end
    elseif need_create_count < 0 then
      for i = cur_count, expend_count + 1, -1 do
        self:give_back_cache_obj(CONSUME_TEMPLETE_KEY, objs[i])
        objs[i] = nil
      end
    end
    for i = 1, expend_count do
      point = objs[i]
      self:_set_point_mask_visiable(point.gameObject, not_enough)
    end
    root:SetActive(true)
  end
end

function ui:_set_point_mask_visiable(point_go, not_enough)
  point_go:SetActive(true)
end

function ui:set_qte_fill_color(element_id)
  local color_tb1 = FightCfg.ELEMENT_COLOR_LIGHT1[element_id]
  local color_tb2 = FightCfg.ELEMENT_COLOR_LIGHT2[element_id]
  local color_tb3 = FightCfg.ELEMENT_COLOR_LIGHT3[element_id]
  if color_tb1 then
    self.v_uicompents.QteFill_img:SetGraphicColor(color_tb1.r, color_tb1.g, color_tb1.b)
    self.v_uicompents.UltLight7_1_img:SetGraphicColor(color_tb1.r, color_tb1.g, color_tb1.b, color_tb1.a)
  end
  if color_tb2 then
    self.v_uicompents.UltLight7_2_img:SetGraphicColor(color_tb2.r, color_tb2.g, color_tb2.b, color_tb2.a)
  end
  if color_tb3 then
    self.v_uicompents.UltLight7_3_img:SetGraphicColor(color_tb3.r, color_tb3.g, color_tb3.b, color_tb3.a)
  end
end

function ui:play_pick_ball_effect()
  if SceneMgr:global_hero_is_destroyed() then
    return
  end
  local hero = Global.hero
  local cur = hero.attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY) or 0
  local max = hero.attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY_MAX) or 0
  if cur >= max then
    return
  end
  local root_name = DYNAMIC_LOAD_EFFECT_NAME.PickBallEffect
  self:play_dynamic_load_effect(root_name, root_name, QTE_SHOW_SKILL_IDX)
end

function ui:_response_quantum_capture_system(msg)
  local enable = msg.mm_x
  self.v_panels.fight_quantum:set_enable(enable, QuantumView.Type.Quantum)
end

function ui:_response_camera_capture_system(msg)
  local enable = msg.mm_x
  self.v_panels.fight_quantum:set_enable(enable, QuantumView.Type.Capture)
end

function ui:get_fight_canvas()
  return self.v_canvas
end

function ui:update_fight_data()
  FightDataMgr:init_fight_ui_data()
  local data = FightDataMgr:get_fight_ui_data()
  for key, name in pairs(FightDataMgr.FIGHT_UI_DATA_NAME) do
    self[key] = data[name]
  end
  for _, index in pairs(BTN_NAME_2_SKILL_INDEX) do
    self.v_button_drag_status[index] = false
  end
end

function ui:get_special_bar_data()
  return self.v_special_bar_data
end

function ui:on_hero_sp_change(msg)
  if not (not SceneMgr:global_hero_is_destroyed() and msg) or msg.mm_obj ~= Global.hero then
    return
  end
  self:check_all_skill_mask()
end

function ui:check_all_skill_mask()
  for index, skill_info in pairs(self.v_skill_list) do
    self:check_skill_mask(index, skill_info)
  end
end

function ui:check_skill_mask(index, skill_info)
  local record_speed = Global.hero:get_real_recover_value()
  local cur_value = Global.hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_SP)
  local cfg, battle_res_cost, energy_cd
  local skill_id = skill_info.skill_id
  if not self.v_btn_charging_params[skill_id] then
    cfg = ShareRes.get_skill_cfg(skill_id)
    battle_res_cost = cfg.BattleResCost or 0
    if 0 ~= skill_info.real_recover_energy then
      energy_cd = (skill_info.cost_energy - skill_info.cur_energy) / skill_info.real_recover_energy
    else
      energy_cd = 0
    end
    if cur_value < battle_res_cost and energy_cd < (battle_res_cost - cur_value) / record_speed then
      self:set_btn_charging_type(skill_id, Config.CD_MASK_TYPE.ATTR, true, cur_value, battle_res_cost, record_speed, ATTR_TYPE.CHAR_SP)
      if self.v_btn_charging_params[skill_id] then
        self:update_btn_cd(self.v_btn_charging_params[skill_id], skill_id, 0)
      end
    end
  end
  if not self.v_btn_charging_params[skill_id] then
    self:update_ui_visible(self.v_skill_mask_list[index]:get_go(), false)
    if self.v_skill_time_text[index] then
      self:update_ui_visible(self.v_skill_time_text[index]:get_go(), false)
    end
    self:update_ui_visible(self.v_uiobjects[ENERGY_TIME_NAME[index]], false)
  end
end

function ui:set_ult_skill_enabled(uuid, enabled)
  if nil == enabled then
    enabled = self:get_ult_skill_enabled(uuid)
  else
    self.v_ult_skill_data[uuid] = enabled
  end
  if Global.hero_uuid == uuid then
    self:set_qte_button_effect_enabled(enabled)
  else
    self.v_panels.hero_head_view:set_ult_skill_enabled(uuid, enabled)
  end
end

function ui:init_ult_skill_enabled()
  for uuid, enabled in pairs(self.v_ult_skill_data) do
    if Global.hero_uuid == uuid then
      self:set_qte_button_effect_enabled(enabled)
    else
      self.v_panels.hero_head_view:init_ult_skill_enabled(uuid, enabled)
    end
  end
end

function ui:get_ult_skill_enabled(uuid)
  return self.v_ult_skill_data ~= nil and self.v_ult_skill_data[uuid]
end

function ui:load_temp_sprite(is_texture, icon_path, callback)
  ResMgr:load_set_icon(self.v_uicompents.TempImg_img, icon_path, callback, is_texture, self)
end

function ui:on_playing_effect_remove(effect_name)
  if not self.v_active_button_effect or not self.v_active_button_effect[effect_name] then
    return
  end
  self.v_active_button_effect[effect_name] = nil
end

function ui:reset_active_button_effect()
  if not self.v_active_button_effect then
    return
  end
  local effect_name
  local str = "%d$"
  for new_effect_name, index in pairs(self.v_active_button_effect) do
    if string.match(new_effect_name, str) then
      effect_name = string.sub(new_effect_name, 1, -2)
    else
      effect_name = new_effect_name
    end
    if DYNAMIC_LOAD_EFFECT_NAME[effect_name] then
      self:play_dynamic_load_effect(new_effect_name, DYNAMIC_LOAD_EFFECT_NAME[effect_name], index)
    else
      self:play_effect(new_effect_name)
    end
  end
end

function ui:set_joystick_alpha(alpha)
  self.v_uicompents.JoystickContent_cg.alpha = alpha
end

function ui:update_skill_cd_on_change(index)
  local skill_info = self:get_cur_skill_info(index)
  if not skill_info or self.v_btn_charging_params[skill_info.skill_id] then
    return
  end
  if skill_info.cur_energy == skill_info.max_energy then
    self:set_skill_time_text(index, EMPTY_STR)
  end
end

function ui:get_ui_effect(effect_name, effect_key, just_check, auto_release)
  effect_key = effect_key or effect_name
  self.v_ui_effect = self.v_ui_effect or {}
  if not self.v_ui_effect[effect_key] and not just_check then
    local path
    if not Util.is_empty(effect_name) then
      self.v_ui_effect[effect_key] = ResPoolMgr:get_ui_effect(effect_name)
    end
  end
  if auto_release then
    local effect_go = self.v_ui_effect[effect_key]
    local component = self:get_effect_status(nil, effect_go)
    if not component then
      Log.Error("获取effectstatus组件失败，无法自动回收", effect_name, debug.traceback())
      return
    end
    local duration = component.LifeTime
    if duration and duration > 0 then
      local release_timer = self.v_eff_release_timer_map[effect_key]
      if self.v_eff_release_timer_map[effect_key] then
        Timer:remove_timer(release_timer)
        self.v_eff_release_timer_map[effect_key] = nil
      end
      release_timer = Timer:add_timer(nil, 0.5, self.release_ui_effect, self, effect_key)
      self.v_eff_release_timer_map[effect_key] = release_timer
    end
  end
  return self.v_ui_effect[effect_key]
end

function ui:release_ui_effect(effect_key)
  if not Util.is_nil(self.v_ui_effect[effect_key]) then
    ResPoolMgr:release(self.v_ui_effect[effect_key])
  end
  self.v_ui_effect[effect_key] = nil
  if self.v_eff_release_timer_map[effect_key] then
    Timer:remove_timer(self.v_eff_release_timer_map[effect_key])
    self.v_eff_release_timer_map[effect_key] = nil
  end
end

function ui:check_ui_effect_is_load(effect_key)
  return self.v_ui_effect[effect_key] ~= nil
end

function ui:clear_loop_tween()
  if self.v_loop_tween then
    self.v_loop_tween:Kill()
    self.v_loop_tween = nil
  end
end

function ui:get_button_effect(effect_name, effect_key, root)
  local ui_effect = self:get_ui_effect(effect_name, effect_key)
  if ui_effect then
    local parent = root.transform
    ui_effect.transform:SetParent(parent)
    ui_effect.gameObject.name = effect_name
    ui_effect.gameObject:ResetAttr()
    return ui_effect
  end
end

function ui:play_dynamic_load_effect(effect_root_name, effect_name, index)
  local effect_root = self.v_uiobjects[effect_root_name]
  local play_effect_obj = self
  if not effect_root then
    local hero_head_view = self.v_panels.hero_head_view
    if hero_head_view and hero_head_view.v_heads then
      for key, head in pairs(hero_head_view.v_heads) do
        effect_root = head:get_uiobject(effect_root_name)
        play_effect_obj = head
        if effect_root then
          break
        end
      end
    end
    if not effect_root then
      Log.Error("获取特效父节点失败", effect_root_name, debug.traceback())
      return
    end
  end
  local child = effect_name and MULIT_DYNAMIC_LOAD_EFFECT[effect_name]
  local is_loaded, effect_key
  if child then
    for key, res_name in pairs(child) do
      effect_key = res_name .. index
      is_loaded = self.v_effects and self.v_effects[effect_root_name] ~= nil
      if not is_loaded then
        self:get_button_effect(res_name, effect_key, effect_root)
      end
    end
    if not is_loaded then
      play_effect_obj:register_effect_status(effect_root_name, child.loop, child.start)
    end
  else
    local res_name = DYNAMIC_LOAD_EFFECT[effect_name]
    if not res_name then
      Log.Error("获取按钮特效资源名失败", effect_name, debug.traceback())
      return
    end
    effect_key = res_name .. index
    is_loaded = play_effect_obj.v_effects and play_effect_obj.v_effects[effect_root_name] ~= nil
    if not is_loaded then
      self:get_button_effect(res_name, effect_key, effect_root)
      play_effect_obj:register_effect_status(effect_root_name, res_name)
    end
  end
  play_effect_obj:play_effect(effect_root_name, true)
end

function ui:stop_dynamic_load_effect(effect_name)
  local effect_root = self.v_uiobjects[effect_name]
  local play_effect_obj = self
  if not effect_root then
    local hero_head_view = self.v_panels.hero_head_view
    if hero_head_view and hero_head_view.v_heads then
      for key, head in pairs(hero_head_view.v_heads) do
        effect_root = head:get_uiobject(effect_name)
        play_effect_obj = head
        if effect_root then
          break
        end
      end
    end
    if not effect_root then
      return
    end
  end
  if not play_effect_obj.v_playing_effects or not play_effect_obj.v_playing_effects[effect_name] then
    return
  end
  play_effect_obj:stop_effect(effect_name)
end

function ui:try_play_button_effect(effect_name, index)
  local new_effect_name
  if index then
    new_effect_name = effect_name .. index
  else
    new_effect_name = effect_name
  end
  if DYNAMIC_LOAD_EFFECT_NAME[effect_name] then
    self:play_dynamic_load_effect(new_effect_name, DYNAMIC_LOAD_EFFECT_NAME[effect_name], index)
  else
    self:play_effect(new_effect_name)
  end
  self.v_active_button_effect[new_effect_name] = index
end

function ui:set_team_head_object_visible(head_index, object_name, is_visible)
  local hero_head_view = self.v_panels.hero_head_view
  local head = hero_head_view and hero_head_view.v_heads[head_index]
  if head then
    local obj = head:get_uiobject(object_name)
    if not Util.is_nil(obj) then
      obj:SetActiveEx(is_visible)
    end
  else
    Log.Error("获取team_head对象失败，head_index", head_index, debug.traceback())
  end
end

function ui:set_button_drag_state(is_drag, joystick_index)
  if self.v_button_drag_status[joystick_index] ~= is_drag then
    self.v_button_drag_status[joystick_index] = is_drag
    BehaviorMgr:on_button_drag_state_change(is_drag, joystick_index)
  end
end

function ui:get_button_drag_state(joystick_index)
  return self.v_button_drag_status[joystick_index]
end

function ui:set_qte_button_effect_enabled(enabled)
  self:update_ui_visible(self.v_uiobjects.EXSkillEffect7, enabled)
  self:update_ui_visible(self.v_uiobjects.QteSlider, not enabled)
  self:update_ui_visible(self.v_uiobjects.Frame7, enabled)
  self:update_ui_visible(self.v_uiobjects.BgExskill7, enabled)
end

function ui:set_cancle_image(cancle_sate)
  local path = CANCLE_STATE_IMAGE_PATH[cancle_sate]
  ResMgr:load_set_icon(self.v_uicompents.CancleSkill_img, path)
end

function ui:change_ult_effect(uuid, state)
  self.v_panels.hero_head_view:change_ult_effect(uuid, state)
end

function ui:refresh_fight_task_ui(is_normal)
  if not self.v_fight_task then
    return
  end
  self.v_fight_task:refresh_fight_task_ui(is_normal)
end

function ui:give_back_cache_obj(temp_key, obj)
  if obj:IsNull() then
    return
  end
  obj.transform:SetParent(self.v_uiobjects.TempleteRoot.transform)
  self:give_back_auto_cache_obj(temp_key, obj)
end

function ui:set_object_visible(object_name, visible, skip_dot)
  self:set_ui_node_visible(object_name, OBJ_VISIBLE_TYPE.BUDDY, visible)
  local gamoebj = self.v_uiobjects[object_name]
  if not gamoebj then
    return
  end
  if visible then
    self.v_obejct_canvas_visivle_state[object_name] = CANVAS_VISIBLE_STATE.VISIBLE
  else
    self.v_obejct_canvas_visivle_state[object_name] = CANVAS_VISIBLE_STATE.INVISIBLE
  end
  if object_name == BTN_SKILL_NAME[BTN_NAME_2_SKILL_INDEX.Btn_skill2] then
    self:set_btn_skill2_effect(visible, skip_dot)
  else
    self:update_ui_visible(gamoebj, visible)
  end
end

function ui:get_object_visible(object_name)
  if self.v_obejct_canvas_visivle_state[object_name] then
    return self.v_obejct_canvas_visivle_state[object_name] == CANVAS_VISIBLE_STATE.VISIBLE
  end
  local gamoebj = self.v_uiobjects[object_name]
  if not gamoebj then
    return false
  end
  if self.v_visible_record[gamoebj] ~= nil then
    return self.v_visible_record[gamoebj] == true
  end
  return gamoebj.activeSelf
end

function ui:set_btn_skill2_effect(visible, skip_dot)
  local effect_name = FightCfg.FIGHT_UI_EFFECT.Fx_Btn_skill2_Loop
  if visible then
    if not skip_dot and self.v_btn_skill2_dot then
      self.v_btn_skill2_dot:Restart()
    end
    self:update_ui_visible(self.v_uiobjects.Btn_skill2, visible)
    if not self.v_ui_effect[effect_name] then
      self:play_down_skill_effect(BTN_NAME_2_SKILL_INDEX.Btn_skill2)
      local effect = self:get_ui_effect(effect_name, effect_name, false, false)
      effect.transform:SetParent(self.v_uicompents.Btn_skill2_rect)
      effect.transform:ResetAttr()
      effect.gameObject:SetActive(true)
    end
  elseif not skip_dot and self.v_btn_skill2_dot then
    self.v_btn_skill2_dot:Complete()
    self.v_btn_skill2_dot:PlayBackwards()
  else
    self:update_ui_visible(self.v_uiobjects.Btn_skill2, visible)
  end
end

function ui:play_down_skill_effect(index)
  if index ~= BTN_NAME_2_SKILL_INDEX.Btn_skill2 then
    self:play_dynamic_load_effect(DOWN_SKILL_NAME[index], DYNAMIC_LOAD_EFFECT_NAME.Down_skill_, index)
  end
end

function ui:play_button_2_down_skill_effect()
  self:play_effect_by_mgr(FightCfg.FIGHT_UI_EFFECT.Fx_Btn_skill2_Break, self.v_uicompents.Btn_skill2_rect)
  self.v_mgr_effect_to_root[FightCfg.FIGHT_UI_EFFECT.Fx_Btn_skill2_Break] = BTN_NAME_2_SKILL_INDEX.Btn_skill2
end

function ui:set_skill_time_text(index, text_value, is_force)
  local time_text = self.v_skill_time_text[index]
  if text_value == EMPTY_STR then
    time_text:force_set_value(text_value)
    self:update_ui_visible(time_text:get_go(), false)
    if self.v_uiobjects[ENERGY_TIME_NAME[index]] then
      self:update_ui_visible(self.v_uiobjects[ENERGY_TIME_NAME[index]], false)
    end
    if index == BTN_NAME_2_SKILL_INDEX.Btn_skill8 then
      self:play_effect_by_mgr(FightCfg.FIGHT_UI_EFFECT.Fx_Skill_Glow1, self.v_uicompents.Btn_skill8_rect)
      self.v_mgr_effect_to_root[FightCfg.FIGHT_UI_EFFECT.Fx_Skill_Glow1] = BTN_NAME_2_SKILL_INDEX.Btn_skill8
    end
    return
  end
  self:update_ui_visible(time_text:get_go(), true)
  if is_force then
    time_text:force_set_value(text_value)
  else
    time_text:set_value(text_value)
  end
  if index == BTN_NAME_2_SKILL_INDEX.Btn_skill8 then
    self:stop_effect_by_mgr(FightCfg.FIGHT_UI_EFFECT.Fx_Skill_Glow1)
    self.v_mgr_effect_to_root[FightCfg.FIGHT_UI_EFFECT.Fx_Skill_Glow1] = nil
  end
end

function ui:update_input_setting_view()
  local show = BattleSettingMgr:get_gpg_button_show()
  for btn_name, key in pairs(CUSTOM_KEY_MAP) do
    self.v_uiobjects[btn_name]:SetActiveEx(show)
    if show then
      local btn_obj = self.v_uiobjects[btn_name]
      self:set_up_pctouch(btn_obj, key)
    end
  end
  for btn_name, key in pairs(CUSTOM_KEY_MAP_1) do
    local btn_obj = Util.get_child_gameobj(btn_name, self.v_uiobjects.TeamHeads)
    btn_obj:SetActiveEx(show)
    if show then
      self:set_up_pctouch(btn_obj, key)
    end
  end
  self.v_uiobjects.PCTouchPanel:SetActiveEx(show)
  if show then
    for btn_name, key in pairs(ARROW_KEY_MAP) do
      local btn_obj = self.v_uiobjects[btn_name]
      self:set_up_pctouch(btn_obj, key)
    end
  end
end

function ui:is_inputcode_enable(inputcode)
  local uiwidget = inputcode_to_uiwidget[inputcode]
  if uiwidget then
    return self:get_ui_obj_visible(uiwidget)
  end
  if special_inputcode[inputcode] then
    return true
  end
  return false
end

function ui:set_up_pctouch(btn_obj, key)
  local key_code = BattleSettingMgr:get_gpg_custom_button(key)
  local touchicon_img = Util.get_image("TouchIcon", btn_obj)
  local touchtext_txt = Util.get_text("TouchBg/TouchText", btn_obj)
  local touchbg = Util.get_child_gameobj("TouchBg", btn_obj)
  if Setting_Cfg.MOUSE_KEYCODE[key_code] then
    touchicon_img.gameObject:SetActiveEx(true)
    touchbg:SetActiveEx(false)
    ResMgr:load_set_icon(touchicon_img, Setting_Cfg.MOUSE_KEYCODE[key_code])
  else
    touchbg:SetActiveEx(true)
    touchicon_img.gameObject:SetActiveEx(false)
  end
  touchtext_txt.text = 0 == key_code and "----" or BattleSettingMgr:keycode_to_string(key_code)
end

function ui:try_show_navigation()
  if self.v_fight_task and self.v_fight_task:get_click_point_status() and Global.hero:reset_navigator_time() then
    self:reset_task_guid_time()
  end
end

function ui:set_safe_panel_hidden()
  Base.set_safe_panel_hidden(self)
  for uuid, enabled in pairs(self.v_ult_skill_data) do
    if Global.hero_uuid == uuid then
      self:set_qte_button_effect_enabled(false)
    else
      self.v_panels.hero_head_view:init_ult_skill_enabled(uuid, false)
    end
  end
  if self.v_active_button_effect then
    local effect_name
    local str = "%d$"
    for new_effect_name, index in pairs(self.v_active_button_effect) do
      if string.match(new_effect_name, str) then
        effect_name = string.sub(new_effect_name, 1, -2)
      else
        effect_name = new_effect_name
      end
      self:_on_stop_button_effect(index, effect_name, true)
    end
  end
  self:stop_all_effect_by_mgr()
end

function ui:set_safe_panel_visible()
  Base.set_safe_panel_visible(self)
  self:init_ult_skill_enabled()
  self:reset_active_button_effect()
  for prefab_name, root_index in pairs(self.v_mgr_effect_to_root) do
    self:play_effect_by_mgr(prefab_name, self.v_uiobjects[BTN_SKILL_NAME[root_index]].transform)
  end
end

return ui
