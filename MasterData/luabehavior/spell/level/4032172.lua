local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)
local tip = Util.format_str("是否退出关卡")
local sure_btn = Util.format_str("是")
local cancel_btn = Util.format_str("否")

local function sure_callback()
  set_scene_tips(801019, false, {})
  remove_scene_effect("jiaohu")
  set_ui_object_visible("fight", "Main", false)
  request_end_teach_level(true)
end

local function cancel_callback()
  set_ui_object_visible("fight", "Btn_skill5", true)
  set_ui_object_visible("fight", "JoystickContent", true)
  set_ui_object_visible("fight", "Btn_skill4", true)
  set_ui_object_visible("fight", "Btn_skill1", true)
  set_ui_object_visible("fight", "Btn_skill3", true)
  set_ui_object_visible("fight", "Btn_skill7", true)
end

function M:_init()
  Base._init(self)
  local god = get_god_npc()
  cast_magic(god, god, 4032226)
  clear_fight_ui_objs()
  self.init_guide = false
  self.monster_pos = {}
  self.teach_step = 1
  self.teach_tips = {
    [1] = {
      101706,
      101707,
      101708,
      101709
    },
    [2] = {101704}
  }
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  local step = 9
  g:add_step(function()
    local nanna = self.npc:get_behavior()
    if nanna then
      nanna:ignore_stab_angle_threshold(360)
    end
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    cast_magic(self.npc, self.monster1, 4032119, 1)
    cast_magic(self.npc, self.npc, 1017300, 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(0.75)
    self.monster_pos = get_npc_pos(self.monster1)
  end)
  g:add_step(function()
    change_follow_target(1, self.monster1, {
      9999,
      0,
      {
        x = 0,
        y = 0,
        z = 0
      },
      1,
      10,
      0.1
    })
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101701)
    self:to_next_step(0.01)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    enter_guide(100101702)
    self:to_next_step(0.75)
  end)
  g:add_step(function()
    enter_guide(100101703)
    self:to_next_step(0.125)
  end)
  g:add_step(function()
    enter_guide(100101704)
    self:to_next_step(0.4)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "JoystickContent", true)
    enter_guide(100101705)
    self:to_next_step(0.05)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(1.4)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101706)
    self:to_next_step(0.35)
  end)
  g:add_step(function()
    enter_guide(100101707)
    self:to_next_step(1.1)
  end)
  g:add_step(function()
    enter_guide(100101708)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    local nanna = self.npc:get_behavior()
    if nanna then
      nanna:recover_stab_angle_threshold()
    end
    if back_form then
      cast_magic(self.npc, self.npc, 4032175, 1)
      cast_magic(self.npc, self.npc, 4032176, 1)
      restart_skill_teach(101704)
      set_scene_tips(61706, true, {})
    else
      cast_magic(self.npc, self.npc, 4032175, 1)
      cast_magic(self.npc, self.npc, 4032176, 1)
      start_skill_teach(101704)
      set_scene_tips(61706, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if missile_cfg.Id == 10010172122 then
      set_skill_state(1, true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    set_scene_tips(61707, true, {})
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100101726 == skill_id then
      set_skill_state(2, true)
      self:to_next_step(0.1)
    elseif 100101741 == skill_id then
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      set_skill_state(2, false)
      self:back_to_step(11, 0.7)
    end
  end):listen("on_missile_end_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010174202 then
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      set_skill_state(2, false)
      self:back_to_step(11, 0.7)
    end
  end)
  g:add_step(function()
    set_scene_tips(61708, true, {})
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101741 == skill_id then
      set_skill_state(3, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    end
  end):listen("on_missile_end_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010174202 then
      self:guide_timeout(0.2, function()
        set_ui_object_visible("fight", "Btn_skill1", false)
        set_ui_object_visible("fight", "Btn_skill4", false)
        set_ui_object_visible("fight", "Btn_skill5", false)
        set_skill_state(3, false)
        self:back_to_step(11, 0.7)
      end)
    end
  end)
  g:add_step(function()
    set_scene_tips(61709, true, {})
    self:guide_timeout(3, function()
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      set_skill_state(4, false)
      set_scene_tips(61708, false, {})
      self:back_to_step(11, 0.5)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101732 == skill_id then
      set_skill_state(4, true)
      self:cancel_guide_timeout()
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    self:to_next_step(1.5)
  end)
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(1.5)
  end)
  g:add_step(function()
    set_scene_tips(61708, false, {})
    set_ui_object_visible("fight", "Btn_skill7", true)
    cast_magic(self.monster1, self.monster1, 4032177, 1)
    flash_to_pos(self.npc, self.monster_pos.x, self.monster_pos.z)
    create_navigator_effect("end", true, true)
    show_skill_combo_tips({17}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.finished_teach_guide = true
    set_scene_tips(801019, true, {})
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if self.finished_teach_guide == true then
    create_navigator_effect("end", true, true)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 101702 == tips_id then
    set_scene_tips(61710, true, {})
  end
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.npc, 2)
  if characeter_energy <= 200 then
    cast_magic(self.npc, self.npc, 4032991, 1)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:search_target()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:on_skill_end(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_end", npc, skill_id, skill_type)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  self:call_guide_listen_func("on_missile_end_pos", owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_magic_begin(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_begin", npc, target, magic_id)
end

function M:on_magic_end(npc, target, magic_id)
  self:call_guide_listen_func("on_on_magic_end", npc, target, magic_id)
end

function M:on_enter_area(npc, area)
  if self.finished_teach_guide == true and area.Key == "end" then
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip, sure_btn, cancel_btn)
  end
end

function M:on_enter_area(npc, area)
  if self.finished_teach_guide == true and area.Key == "end" then
    joystick_end()
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "JoystickContent", false, true)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, cancel_callback, tip, sure_btn, cancel_btn)
  end
end

return M
