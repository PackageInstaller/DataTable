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

local miaosha = 10001001
local jianshang = 4032905
local shuaxin = 40321621
local jianengliang = 40321021
local jiannengliang = 40321022

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
  self.hero = get_come_on_hero()
  local teammate1 = get_scene_hero_by_poskey(21)
  cast_magic(teammate1, teammate1, 10001007, 1)
  cast_magic(self.hero, self.hero, 10001007, 1)
  set_ui_object_visible("fight", "Btn_skill7", false)
  clear_fight_ui_objs()
  self.init_guide = false
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "M7", 0, -1, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, jianshang, 1)
    self.monster1_pos = get_npc_pos(self.monster1)
    self.hero_pos = get_npc_pos(self.hero)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    cast_magic(self.hero, self.hero, 10001008, 1)
    enter_guide(100101001)
    start_skill_teach(101003)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101041 == skill_id or 100101042 == skill_id then
      set_skill_state(1, true)
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101009)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101031 == skill_id then
      set_ui_object_visible("fight", "Btn_skill5", false)
      set_skill_state(2, true)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    enter_guide(100101007)
    self:to_next_step(1.5)
  end)
  g:add_step(function()
    force_finish_cur_guide(100101007)
    self:to_next_step()
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(100101003)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    self:to_next_step()
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", false)
    self:to_next_guide("guide2", 0)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function(back_form)
    if back_form then
      set_scene_tips(61014, true, {})
      set_ui_object_visible("fight", "Btn_skill5", true)
      set_ui_object_visible("fight", "Btn_skill4", true)
      cast_magic(self.hero, self.hero, 10001008, 1)
      cast_magic(self.hero, self.hero, 10001007, 1)
      restart_skill_teach(101003)
    else
      set_scene_tips(61014, true, {})
      set_ui_object_visible("fight", "Btn_skill5", true)
      set_ui_object_visible("fight", "Btn_skill4", true)
      cast_magic(self.hero, self.hero, 10001008, 1)
      cast_magic(self.hero, self.hero, 10001007, 1)
      start_skill_teach(101003)
    end
    flash_to_pos(self.hero, self.hero_pos.x, self.hero_pos.z)
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z)
    cast_magic(self.hero, self.hero, jiannengliang)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101041 == skill_id or 100101042 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    else
      set_skill_state(1, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101031 == skill_id then
      set_skill_state(2, true)
      self:to_next_step(1.5)
    else
      set_skill_state(2, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(61014, false, {})
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    cast_magic(self.hero, self.monster1, 10001001, 1)
    self:to_next_guide("guide3", 1.5)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 2, 3, "tp3", 0, 0, 4, 99)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", -2, 3, "tp3", 0, 0, 4, 99)
    cast_magic(self.hero, self.hero, 10001007, 1)
    start_skill_teach(101001)
    self.monster1_pos = get_npc_pos(self.monster1)
    flash_to_pos(self.hero, self.monster1_pos.x - 2, self.monster1_pos.z - 5)
    self:to_next_step(1)
  end)
  g:add_step(function()
    enter_guide(100101004)
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101041 == skill_id or 100101042 == skill_id then
      cast_magic(self.hero, self.monster1, Const.LOCK_MASK, 1)
      set_skill_state(1, true)
      set_ui_object_visible("fight", "Btn_skill4", false)
      cast_magic(self.hero, self.hero, 10001008, 1)
      cast_magic(self.hero, self.hero, shuaxin)
      print("114514")
      lookat_npc(self.hero, self.monster1)
      self:to_next_step(2)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100101005)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101041 == skill_id or 100101042 == skill_id then
      set_skill_state(2, true)
      set_ui_object_visible("fight", "Btn_skill4", false)
      cast_magic(self.hero, self.hero, jianengliang)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101010)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101032 == skill_id then
      set_skill_state(3, true)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    enter_guide(100101008)
    self:to_next_step(1.5)
  end)
  g:add_step(function()
    force_finish_cur_guide(100101008)
    cast_magic(self.hero, self.monster1, 10001001, 1)
    cast_magic(self.hero, self.monster2, 10001001, 1)
    self:to_next_guide("guide4", 1)
  end)
  g:start()
end

function M:teach_guide4()
  local g = self:create_guide("guide4")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 2, 3, "tp3", 0, 0, 4, 99)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", -2, 3, "tp3", 0, 0, 4, 99)
    cast_magic(self.hero, self.hero, 10001007, 1)
    start_skill_teach(101001)
    self.monster1_pos = get_npc_pos(self.monster1)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      set_scene_tips(61015, true, {})
      cast_magic(self.hero, self.hero, 10001007, 1)
      set_ui_object_visible("fight", "Btn_skill4", true)
      cast_magic(self.hero, self.hero, 10001008, 1)
      restart_skill_teach(101001)
    else
      set_scene_tips(61015, true, {})
      cast_magic(self.hero, self.hero, 10001007, 1)
      set_ui_object_visible("fight", "Btn_skill4", true)
      cast_magic(self.hero, self.hero, 10001008, 1)
      start_skill_teach(101001)
    end
    flash_to_pos(self.hero, self.monster1_pos.x - 2, self.monster1_pos.z - 5)
    remove_missile_by_id(10010109522)
    remove_missile_by_id(10010109520)
    cast_magic(self.hero, self.hero, jianengliang)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101041 == skill_id or 100101042 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    else
      set_skill_state(1, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101041 == skill_id or 100101042 == skill_id then
      set_skill_state(2, true)
      self:to_next_step()
    else
      set_skill_state(2, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101032 == skill_id then
      set_skill_state(3, true)
      set_scene_tips(61015, false, {})
      self:to_next_step()
    else
      set_skill_state(3, false)
      set_scene_tips(61015, false, {})
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:to_next_guide("guide5", 2)
  end)
  g:start()
end

function M:teach_guide5()
  local g = self:create_guide("guide5")
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill8", false)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    show_skill_combo_tips({10}, true)
    cast_magic(self.npc, self.npc, 1999217, 0)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    flash_to_pos(self.hero, self.monster1_pos.x - 2, self.monster1_pos.z - 5)
    create_navigator_effect("end", true, true)
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

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.hero, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.hero, 2)
  if characeter_energy <= 100 then
    cast_magic(self.hero, self.hero, 4032991, 1)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 101002 == tips_id then
  end
end

function M:search_target()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_finish_guide(guide_id)
  self:call_guide_listen_func("on_finish_guide", guide_id)
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
