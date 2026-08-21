local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Timer = Global.timer
local INPUT_FIELD = UnityEngine.UI.InputField
local TypeMeshRenderer = typeof(UnityEngine.MeshRenderer)
local UTIL_FUN = require("utils.util_fun")
local CICLE_FUN_TYPE = UTIL_FUN.CICLE_FUN_TYPE
local _tinsert = table.insert
local MODEL = {}
local DEBUG_SKILL_KEY = "DEBUG_SKILL_KEY"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("CastBtn", function()
    self:click_cast_btn(true)
  end)
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self:set_button("SelectSkillBtn", function()
    self:click_select_skill_btn(true)
  end)
  self:set_button("SkillList", function()
    self:click_select_skill_btn()
  end)
  self:set_button("SkillStopBtn", function()
    self:click_stop_skill_btn(true)
  end)
  self:set_button("NpcCastBtn", function()
    self:click_cast_btn(false)
  end)
  self:set_button("NpcCloseBtn", function()
    self:ui_hide()
  end)
  self:set_button("NpcSelectSkillBtn", function()
    self:click_select_skill_btn(false)
  end)
  self:set_button("NpcSelectNpcBtn", function()
    self:click_select_npc_btn()
  end)
  self:set_button("NpcSkillStopBtn", function()
    self:click_stop_skill_btn()
  end)
  self:set_toggle("SkillToggle", function(isOn)
    self:clear_data()
    self.v_uicompents.ActionToggle_tog.isOn = not isOn
    self:_click_skill_toggle(isOn)
  end, true)
  self:set_toggle("ActionToggle", function(isOn)
    self:clear_data()
    self.v_uicompents.SkillToggle_tog.isOn = not isOn
    self:_click_action_toggle(isOn)
  end, false)
  self:set_button("CastActionBtn", function()
    self:click_cast_action_btn()
  end)
  self:set_button("StopActionBtn", function()
    self:click_stop_action_btn()
  end)
  self:set_button("CloseActionBtn", function()
    self:ui_hide()
  end)
  self:set_button("SelectActionBtn", function()
    self:click_select_action_btn()
  end)
  self:set_button("SelectNpcBtn", function()
    self:click_select_npc_btn2()
  end)
  self:set_button("CastActionBtn2", function()
    self:click_cast_action_btn(true)
  end)
  self:set_button("CloseActionBtn2", function()
    self:ui_hide()
  end)
  self:set_button("SelectActionBtn2", function()
    self:click_select_action_btn(true)
  end)
  self:set_button("SelectNpcBtn2", function()
    self:click_select_npc_btn2(true)
  end)
  self.v_npc_name_input = Util.get_component(nil, self.v_uiobjects.NpcNameInput, INPUT_FIELD)
  self.v_npc_skill_input = Util.get_component(nil, self.v_uiobjects.NpcSkillInput, INPUT_FIELD)
  self.v_action_npc_input = Util.get_component(nil, self.v_uiobjects.NpcInput, INPUT_FIELD)
  self.v_action_input = Util.get_component(nil, self.v_uiobjects.ActionInput, INPUT_FIELD)
  self.v_action_npc_input2 = Util.get_component(nil, self.v_uiobjects.NpcInput2, INPUT_FIELD)
  self.v_action_input2 = Util.get_component(nil, self.v_uiobjects.ActionInput2, INPUT_FIELD)
  self:register_exist_auto_template(DEBUG_SKILL_KEY, self.v_uiobjects.SkillData, self.v_uiobjects.SkillContent)
end

function ui:click_cast_btn(is_hero)
  local cast_npc
  if is_hero then
    if not Global.hero then
      return
    end
    cast_npc = Global.hero
  else
    if Util.is_destroy(self.v_select_npc) then
      Log.Error("当前选择怪物不存在，请重新选择")
      return
    end
    cast_npc = self.v_select_npc
  end
  local input
  if is_hero then
    input = Util.get_component(nil, self.v_uiobjects.SkillInput, INPUT_FIELD)
  else
    input = self.v_npc_skill_input
  end
  local skill_id = tonumber(input.text)
  if not skill_id then
    Log.Error("填写正确的技能id")
    return
  end
  
  local function callback()
    local SKILL_ABORT_TYPE = Config.SKILL_ABORT_TYPE
    local abort_type = SKILL_ABORT_TYPE.FOECE | SKILL_ABORT_TYPE.BEHIT_ABORT | SKILL_ABORT_TYPE.BREAK_ABORT
    cast_npc.skill_mgr:abort(abort_type)
    cast_npc.skill_mgr:cast_skill(skill_id)
  end
  
  return Global.util_fun:call_event_fun(CICLE_FUN_TYPE.CAST_SKILL, callback)
end

function ui:click_cast_action_btn(is_tow)
  local cast_npc = is_tow and self.v_select_npc2 or self.v_select_npc
  if Util.is_destroy(cast_npc) then
    Log.Error("当前选择npc不存在，请重新选择")
    return
  end
  local input = is_tow and self.v_action_input2 or self.v_action_input
  
  local function callback()
    local behavior = cast_npc:get_behavior()
    behavior:gm_cast_skill_action(input.text)
  end
  
  return Global.util_fun:call_event_fun(CICLE_FUN_TYPE.CAST_SKILL, callback)
end

function ui:click_stop_action_btn(is_tow)
  local cast_npc = self.v_select_npc
  if Util.is_destroy(cast_npc) then
    Log.Error("当前选择npc不存在，请重新选择")
    return
  end
  
  local function callback()
    local behavior = cast_npc:get_behavior()
    behavior:gm_cast_skill_action("gm_stopAction")
  end
  
  return Global.util_fun:call_event_fun(CICLE_FUN_TYPE.CAST_SKILL, callback)
end

function ui:clear_data()
  self.v_select_npc = nil
  self.v_select_npc2 = nil
  self.v_npc_name_input.text = ""
  self.v_npc_skill_input.text = ""
  self.v_action_npc_input.text = ""
  self.v_action_input.text = ""
end

function ui:ui_on_show()
  self.v_uiobjects.SkillList:SetActive(false)
  self:clear_data()
  self.v_uicompents.SkillToggle_tog.isOn = true
  self:_click_skill_toggle(true)
  self.v_uicompents.ActionToggle_tog.isOn = false
  self:_click_action_toggle(false)
end

function ui:ui_on_hide()
  self.v_select_npc = nil
end

function ui:change_skill_list_visible_state()
  local active_self = self.v_uiobjects.SkillList.activeSelf
  self.v_uiobjects.SkillList:SetActive(not active_self)
end

function ui:click_select_skill_btn(is_hero)
  self:change_skill_list_visible_state()
  if self.v_uiobjects.SkillList.activeSelf then
    if is_hero then
      self:update_hero_skill_list()
    else
      self:update_npc_skill_list()
    end
  end
end

function ui:click_select_action_btn(is_tow)
  self:change_skill_list_visible_state()
  if self.v_uiobjects.SkillList.activeSelf then
    self:update_npc_action_list(is_tow)
  end
end

function ui:click_select_npc_btn()
  self:change_skill_list_visible_state()
  if self.v_uiobjects.SkillList.activeSelf then
    self:give_back_auto_cache(DEBUG_SKILL_KEY)
    local npc_list = SceneMgr:get_all_npc()
    for key, npc in pairs(npc_list) do
      if not Util.is_destroy(npc) then
        self:create_btn(npc)
      end
    end
  end
end

function ui:click_select_npc_btn2(is_tow)
  self:change_skill_list_visible_state()
  if self.v_uiobjects.SkillList.activeSelf then
    self:give_back_auto_cache(DEBUG_SKILL_KEY)
    local npc_list = SceneMgr:get_all_npc()
    for key, npc in pairs(npc_list) do
      if not Util.is_destroy(npc) then
        self:create_btn(npc, true, is_tow)
      end
    end
    self:create_btn(Global.hero, true, is_tow)
  end
end

function ui:create_btn(npc, is_action, is_tow)
  local obj = self:get_auto_cache(DEBUG_SKILL_KEY)
  local text = Util.get_text("SkillInfo", obj)
  local desc = npc.character_cfg.AttribId .. "/" .. npc.character_cfg.name .. "/" .. npc.uuid
  text.text = desc
  local btn = Util.get_button(nil, obj)
  self:set_button_listener(btn, function()
    if is_action then
      if is_tow then
        self.v_select_npc2 = npc
        self.v_action_npc_input2.text = npc.uuid
      else
        self.v_select_npc = npc
        self.v_action_npc_input.text = npc.uuid
      end
    else
      self.v_select_npc = npc
      self.v_npc_name_input.text = npc.uuid
    end
    self.v_uiobjects.SkillList:SetActive(false)
  end)
end

function ui:click_stop_skill_btn(is_hero)
  local npc
  if is_hero then
    if not Global.hero then
      return
    end
    npc = Global.hero
  else
    if Util.is_destroy(self.v_select_npc) then
      Log.Error("当前选择怪物不存在，请重新选择")
      return
    end
    npc = self.v_select_npc
  end
  local input = Util.get_component(nil, self.v_uiobjects.SkillInput, INPUT_FIELD)
  local skill_id = tonumber(input.text)
  if not skill_id then
    return
  end
  npc.skill_mgr:abort(nil, nil, true)
  npc.magic_mgr:remove_all_magic()
end

function ui:update_hero_skill_list()
  self:give_back_auto_cache(DEBUG_SKILL_KEY)
  if not Global.hero then
    return
  end
  local skill_cfg = ShareRes.create("skill.skill")
  local char_id = Global.hero.character_cfg.AttribId
  local skill_list = {}
  for skill_id, data in pairs(skill_cfg) do
    if string.find(skill_id, char_id) then
      table.insert(skill_list, data)
    end
  end
  for _, data in ipairs(skill_list) do
    local obj = self:get_auto_cache(DEBUG_SKILL_KEY)
    local text = Util.get_text("SkillInfo", obj)
    local desc = data.Id .. "/" .. data.Name
    text.text = desc
    local btn = Util.get_button(nil, obj)
    self:set_button_listener(btn, function()
      local input = Util.get_component(nil, self.v_uiobjects.SkillInput, INPUT_FIELD)
      input.text = data.Id
      self.v_uiobjects.SkillList:SetActive(false)
    end)
  end
end

function ui:update_npc_skill_list()
  self:give_back_auto_cache(DEBUG_SKILL_KEY)
  if Util.is_destroy(self.v_select_npc) then
    Log.Error("当前选择怪物不存在，请重新选择")
    return
  end
  local skill_cfg = ShareRes.create("skill.skill")
  local char_id = self.v_select_npc.character_cfg.NpcId
  for skill_id, data in pairs(skill_cfg) do
    if string.find(skill_id, char_id) then
      local obj = self:get_auto_cache(DEBUG_SKILL_KEY)
      local text = Util.get_text("SkillInfo", obj)
      local desc = data.Id .. "/" .. data.Name
      text.text = desc
      local btn = Util.get_button(nil, obj)
      self:set_button_listener(btn, function()
        self.v_npc_skill_input.text = data.Id
        self.v_uiobjects.SkillList:SetActive(false)
      end)
    end
  end
end

function ui:update_npc_action_list(is_tow)
  local npc = is_tow and self.v_select_npc2 or self.v_select_npc
  self:give_back_auto_cache(DEBUG_SKILL_KEY)
  if Util.is_destroy(npc) then
    Log.Error("当前选择怪物不存在，请重新选择")
    return
  end
  local behavior = npc:get_behavior()
  local skill_list = behavior:gm_get_skill_actions()
  if not skill_list then
    Log.Error("獲取行為失敗， NpcId：", npc.id)
    return
  end
  for _, skill_name in pairs(skill_list) do
    local obj = self:get_auto_cache(DEBUG_SKILL_KEY)
    local text = Util.get_text("SkillInfo", obj)
    text.text = skill_name
    local btn = Util.get_button(nil, obj)
    self:set_button_listener(btn, function()
      if is_tow then
        self.v_action_input2.text = skill_name
      else
        self.v_action_input.text = skill_name
      end
      self.v_uiobjects.SkillList:SetActive(false)
    end)
  end
end

function ui:_click_skill_toggle(isOn)
  self.v_uiobjects.SkillPage:SetActive(isOn)
end

function ui:_click_action_toggle(isOn)
  self.v_uiobjects.ActionPage:SetActive(isOn)
end

return ui
