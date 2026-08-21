local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local OPTION_TYPE = {
  EXIT = 1,
  THOUGHT_AWARD = 2,
  BATTLE = 3,
  EVENT_JUMP = 4
}
local OPTIONCONTENT_OPTIONTEM_TEMP_KEY = "OPTIONCONTENT_OPTIONTEM_TEMP_KEY"

function ui:on_click_option(option_id)
  if self.v_particle_timer then
    Timer:remove_timer(self.v_particle_timer)
    self.v_particle_timer = nil
  end
  local ponder_maze_mgr = NoviceMgr.ponder_maze_mgr
  self.v_select_option_id = option_id
  local option_cfg = ShareRes.get_ponder_maze_node_option_cfg(option_id)
  local is_comp = false
  local hide_on_comp = false
  if option_cfg.OptionType == OPTION_TYPE.EXIT then
    self:ui_hide()
  elseif option_cfg.OptionType == OPTION_TYPE.THOUGHT_AWARD then
    is_comp = true
    local thought_id = option_cfg.Param[1]
    local add_count = option_cfg.Param[2]
    ponder_maze_mgr:add_thought_count(thought_id, add_count)
    hide_on_comp = true
  elseif option_cfg.OptionType == OPTION_TYPE.BATTLE then
    self:on_battle_click(option_id)
  elseif option_cfg.OptionType == OPTION_TYPE.EVENT_JUMP then
    local event_id = option_cfg.Param[1]
    self:set_event(event_id)
  end
  if option_cfg.OptionType ~= OPTION_TYPE.BATTLE and is_comp and ponder_maze_mgr:try_comp_node(self.v_node_id) and hide_on_comp then
    self:ui_hide()
  end
end

function ui:on_battle_click(option_id)
  local ponder_maze_mgr = NoviceMgr.ponder_maze_mgr
  local is_can_skip = ponder_maze_mgr:is_game_stop()
  if not is_can_skip then
    local option_cfg = ShareRes.get_ponder_maze_node_option_cfg(option_id)
    local battle_point_id = option_cfg.Param[1]
    local battle_param = ponder_maze_mgr:get_battle_pass_id(battle_point_id, self.v_node_id)
    is_can_skip = NoviceMgr:get_ponder_maze_node_battle_pass(self.v_activity_id, battle_param)
  end
  if is_can_skip then
    local function sure_cb()
      if ponder_maze_mgr:try_comp_node(self.v_node_id) then
        self:ui_hide()
      end
    end
    
    local function cancel_cb()
      ponder_maze_mgr:enter_option_battle(self.v_node_id, self.v_event_id, option_id)
    end
    
    Util.show_conform_tip("当前选项可跳过", "取消", "确定", cancel_cb, sure_cb)
  else
    ponder_maze_mgr:enter_option_battle(self.v_node_id, self.v_event_id, option_id)
  end
end

function ui:ui_finish_load()
  self:register_exist_auto_template(OPTIONCONTENT_OPTIONTEM_TEMP_KEY, self.v_uiobjects.OptionTem, self.v_uiobjects.OptionContent)
end

function ui:ui_on_show(activity_id, point_id, node_id, event_id, option_id, battle_return)
  if battle_return and option_id then
    local option_cfg = ShareRes.get_ponder_maze_node_option_cfg(option_id)
    if NoviceMgr.ponder_maze_mgr:is_battle_pass() then
      event_id = option_cfg.Param[2]
    end
    NoviceMgr.ponder_maze_mgr:clear_battle_node_param()
  end
  if not event_id then
    self:ui_hide()
    return
  end
  self:refresh_view(activity_id, point_id, node_id, event_id, option_id)
end

function ui:ui_on_hide()
  if self.v_particle_timer then
    Timer:remove_timer(self.v_particle_timer)
    self.v_particle_timer = nil
  end
end

function ui:ui_on_destroy()
end

function ui:refresh_view(activity_id, point_id, node_id, event_id, option_id)
  self.v_node_id = node_id
  self.v_activity_id = activity_id
  self.v_point_id = point_id
  self.v_select_option_id = option_id
  self:set_event(event_id)
end

function ui:set_event(event_id)
  self.v_event_id = event_id
  self:refresh_event()
end

function ui:refresh_event()
  self:give_back_auto_cache(OPTIONCONTENT_OPTIONTEM_TEMP_KEY)
  local event_cfg = ShareRes.get_ponder_maze_node_event_cfg(self.v_event_id)
  if not event_cfg then
    Log.Error("获取事件配置失败 事件ID：", self.v_event_id)
    return
  end
  self.v_uicompents.EventDesc_txt.text = event_cfg.EventDesc
  for index, option_id in ipairs(event_cfg.Option) do
    self:create_option(option_id)
  end
end

function ui:create_option(option_id)
  local option_cfg = ShareRes.get_ponder_maze_node_option_cfg(option_id)
  local obj = self:get_auto_cache(OPTIONCONTENT_OPTIONTEM_TEMP_KEY)
  local desc_txt = self:get_text("Desc", obj)
  local tips_desc_txt = self:get_text("TipsDesc", obj)
  local bg1 = self:get_child_gameobj("Bg1", obj)
  local bg2 = self:get_child_gameobj("Bg2", obj)
  local select_effect = 0 == option_cfg.OptionDescType and self:get_child_gameobj("Fx_Bg1_Select_", bg1) or 1 == option_cfg.OptionDescType and self:get_child_gameobj("Fx_Bg2_Select_", bg2)
  select_effect:SetActive(false)
  bg1:SetActive(0 == option_cfg.OptionDescType)
  bg2:SetActive(1 == option_cfg.OptionDescType)
  desc_txt.text = option_cfg.OptionDescUp
  if Util.is_empty(option_cfg.OptionDescDown) then
    tips_desc_txt.gameObject:SetActive(false)
  else
    tips_desc_txt.gameObject:SetActive(true)
    tips_desc_txt.text = option_cfg.OptionDescDown
  end
  local color_str = 0 == option_cfg.OptionDescType and "c1d8e8" or 1 == option_cfg.OptionDescType and "ffe79f"
  Util.set_color(desc_txt, color_str)
  local btn = self:get_button(nil, obj)
  self:set_button_listener(btn, function()
    if self.v_particle_timer then
      return
    end
    if select_effect then
      select_effect:SetActive(false)
      select_effect:SetActive(true)
    end
    self.v_particle_timer = Timer:add_timer(nil, 0.7, self.on_click_option, self, option_id)
  end)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_activity_id, self.v_point_id, self.v_node_id, self.v_event_id, self.v_select_option_id
end

return ui
