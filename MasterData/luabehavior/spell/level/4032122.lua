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
  self.init_guide = false
  self.exercise_rec = false
  clear_fight_ui_objs()
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  local step = 8
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step(1.5)
  end)
  g:add_step(function()
    self.exatk_state = false
    stop_ui_fight_button_effect({
      "Strengthen_skill_",
      1
    })
    cast_magic(self.npc, self.npc, 4032125, 0)
    cast_magic(self.npc, self.npc, 4032129, 0)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    enter_guide(100101201)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101208 == skill_id then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100101202)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101209 == skill_id then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100101203)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    self:to_next_step(2)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(101203)
      abort_magic_by_id(self.npc, 1012001)
    else
      start_skill_teach(101203)
      set_scene_tips(61221, true, {})
    end
    self.exatk_state = false
    stop_ui_fight_button_effect({
      "Strengthen_skill_1",
      1
    })
    cast_magic(self.npc, self.npc, 4032125, 0)
    cast_magic(self.npc, self.npc, 4032129, 0)
    cast_magic(self.npc, self.npc, 1012401, 0)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  
  local function create_step_hit(target_skill_id)
    local function func_skill(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
      if npc == self.npc then
        if skill_id == target_skill_id then
          set_skill_state(g:step_index() - step, true)
          
          self:to_next_step()
        else
          set_skill_state(g:step_index() - step, false)
          set_ui_object_visible("fight", "Btn_skill1", false)
          set_ui_object_visible("fight", "Btn_skill4", false)
          cast_magic(self.npc, self.npc, 4032130, 0)
          self:back_to_step(step, 1)
        end
      end
    end
    
    g:add_step():listen("on_skill_hit", func_skill)
  end
  
  local function create_step_dis(target_skill_id)
    local function func_skill(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
      if npc == self.npc then
        local dis = get_npc_distance(npc, 1, hit_target, false)
        
        if skill_id == target_skill_id and not self.exatk_state then
          if dis <= 100 then
            set_skill_state(g:step_index() - step, true)
            self:cancel_guide_timeout()
            self:to_next_step()
          elseif g:step_elapse() > 0.2 then
            set_skill_state(g:step_index() - step, false)
            self:cancel_guide_timeout()
            set_ui_object_visible("fight", "Btn_skill1", false)
            set_ui_object_visible("fight", "Btn_skill4", false)
            abort_magic_by_id(self.npc, Const.INDICATOR.SLOMO)
            abort_magic_by_id(self.npc, Const.INDICATOR.DARKEN)
            self:back_to_step(step, 1)
          end
        end
      end
    end
    
    g:add_step(function()
      self:guide_timeout(5, function()
        self:back_to_step(step)
      end)
    end):listen("on_skill_hit", func_skill):listen("on_input", function(input_id)
      if 19 == input_id then
      end
    end):listen("on_skill_begin", function(npc, skill_id, skill_type)
      if npc == self.npc and skill_id ~= target_skill_id then
        set_skill_state(g:step_index() - 5, false)
        self:cancel_guide_timeout()
        set_ui_object_visible("fight", "Btn_skill1", false)
        set_ui_object_visible("fight", "Btn_skill4", false)
        cast_magic(self.npc, self.npc, 4032130, 0)
        self:back_to_step(step, 1)
      end
    end):listen("on_skill_end", function(npc, skill_id)
      if npc == self.npc and skill_id == target_skill_id then
        set_skill_state(g:step_index() - step, false)
        self:cancel_guide_timeout()
        set_ui_object_visible("fight", "Btn_skill1", false)
        set_ui_object_visible("fight", "Btn_skill4", false)
        cast_magic(self.npc, self.npc, 4032130, 0)
        self:back_to_step(step, 1)
      end
    end)
  end
  
  local function create_step_begin(target_skill_id)
    local function func_skill(npc, skill_id, skill_type)
      if npc == self.npc then
        if skill_id == target_skill_id then
          set_skill_state(g:step_index() - step, true)
          
          self:to_next_step(1)
        else
          set_skill_state(g:step_index() - step, false)
          set_ui_object_visible("fight", "Btn_skill1", false)
          cast_magic(self.npc, self.npc, 4032130, 0)
          self:back_to_step(step, 1)
        end
      end
    end
    
    g:add_step(function()
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(0.5)
    end)
    g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
      if 100101213 == skill_id then
        set_skill_state(3, true)
        cast_magic(self.npc, hit_target, 10001001, 0)
        self:to_next_step(2)
      else
        set_skill_state(3, false)
        set_ui_object_visible("fight", "Btn_skill1", false)
        set_ui_object_visible("fight", "Btn_skill4", false)
        cast_magic(self.npc, self.npc, 4032130, 0)
        self:back_to_step(step, 1)
      end
    end)
  end
  
  create_step_hit(100101208)
  create_step_dis(100101209)
  create_step_begin(100101213)
  g:add_step(function()
    set_scene_tips(61221, false, {})
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    abort_magic_by_id(self.npc, Const.INDICATOR.SLOMO)
    abort_magic_by_id(self.npc, Const.INDICATOR.DARKEN)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z)
    self:to_next_guide("guide2", 0.5)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  local step = 7
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self:to_next_step(1.5)
  end)
  g:add_step(function()
    self.exatk_state = false
    stop_ui_fight_button_effect({
      "Strengthen_skill_1",
      1
    })
    cast_magic(self.npc, self.npc, 4032125, 0)
    cast_magic(self.npc, self.npc, 4032129, 0)
    cast_magic(self.npc, self.npc, 1012402, 0)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    enter_guide(100101204)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101210 == skill_id then
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(1.3)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101205)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101211 == skill_id then
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(1.3)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100101206)
    self:to_next_step(1.3)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(101204)
      abort_magic_by_id(self.npc, 1012002)
    else
      start_skill_teach(101204)
      set_scene_tips(61222, true, {})
    end
    self.exatk_state = false
    stop_ui_fight_button_effect({
      "Strengthen_skill_1",
      1
    })
    cast_magic(self.npc, self.npc, 4032125, 0)
    cast_magic(self.npc, self.npc, 4032129, 0)
    cast_magic(self.npc, self.npc, 1012402, 0)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  
  local function create_step_hit(target_skill_id)
    local function func_skill(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
      if npc == self.npc then
        if skill_id == target_skill_id then
          set_skill_state(g:step_index() - step, true)
          
          self:to_next_step()
        else
          set_skill_state(g:step_index() - step, false)
          set_ui_object_visible("fight", "Btn_skill1", false)
          set_ui_object_visible("fight", "Btn_skill5", false)
          cast_magic(self.npc, self.npc, 4032130, 0)
          self:back_to_step(step, 1)
        end
      end
    end
    
    g:add_step():listen("on_skill_hit", func_skill)
  end
  
  local function create_step_dis(target_skill_id)
    local function func_skill(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
      if npc == self.npc then
        local dis = get_npc_distance(npc, 1, hit_target, false)
        
        if skill_id == target_skill_id and not self.exatk_state then
          if dis >= 0 then
            set_skill_state(g:step_index() - step, true)
            self:cancel_guide_timeout()
            self:to_next_step()
          elseif g:step_elapse() > 0.2 then
            set_skill_state(g:step_index() - step, false)
            self:cancel_guide_timeout()
            set_ui_object_visible("fight", "Btn_skill1", false)
            set_ui_object_visible("fight", "Btn_skill5", false)
            abort_magic_by_id(self.npc, Const.INDICATOR.SLOMO)
            abort_magic_by_id(self.npc, Const.INDICATOR.DARKEN)
            self:back_to_step(step, 1)
          end
        end
      end
    end
    
    g:add_step(function()
      self:guide_timeout(5, function()
        self:back_to_step(4)
      end)
    end):listen("on_skill_hit", func_skill):listen("on_input", function(input_id)
      if 20 == input_id then
      end
    end):listen("on_skill_begin", function(npc, skill_id, skill_type)
      if npc == self.npc and skill_id ~= target_skill_id then
        set_skill_state(g:step_index() - step, false)
        self:cancel_guide_timeout()
        set_ui_object_visible("fight", "Btn_skill1", false)
        set_ui_object_visible("fight", "Btn_skill4", false)
        cast_magic(self.npc, self.npc, 4032130, 0)
        self:back_to_step(step, 1)
      end
    end):listen("on_skill_end", function(npc, skill_id)
      if npc == self.npc and skill_id == target_skill_id then
        set_skill_state(g:step_index() - step, false)
        self:cancel_guide_timeout()
        set_ui_object_visible("fight", "Btn_skill1", false)
        set_ui_object_visible("fight", "Btn_skill4", false)
        cast_magic(self.npc, self.npc, 4032130, 0)
        self:back_to_step(step, 1)
      end
    end)
  end
  
  local function create_step_begin(target_skill_id)
    local function func_skill(npc, skill_id, skill_type)
      if npc == self.npc then
        if skill_id == target_skill_id then
          set_skill_state(g:step_index() - step, true)
        else
          set_skill_state(g:step_index() - step, false)
          set_ui_object_visible("fight", "Btn_skill1", false)
          set_ui_object_visible("fight", "Btn_skill5", false)
          cast_magic(self.npc, self.npc, 4032130, 0)
          self:back_to_step(step, 1)
        end
      end
    end
    
    g:add_step(function()
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step()
    end)
    g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
      if 100101213 == skill_id then
        set_skill_state(3, true)
        cast_magic(self.npc, hit_target, 10001001, 0)
        self:to_next_step(2)
      else
        set_skill_state(3, false)
        set_ui_object_visible("fight", "Btn_skill1", false)
        set_ui_object_visible("fight", "Btn_skill5", false)
        cast_magic(self.npc, self.npc, 4032130, 0)
        self:back_to_step(step, 1)
      end
    end)
  end
  
  create_step_hit(100101210)
  create_step_dis(100101211)
  create_step_begin(100101213)
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    show_skill_combo_tips({12, 1202}, true)
    set_scene_tips(801019, true, {})
    set_scene_tips(61223, true, {})
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    create_navigator_effect("end", true, true)
    self.finished_teach_guide = true
    self.exercise_rec = true
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_frame()
  Base.on_frame(self)
  self:teach_guide10()
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
  if self.exercise_rec and get_npc_attr(self.npc, 2) < 90 then
    cast_magic(self.npc, self.npc, 4032125, 0)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 101202 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(61223, true, {})
  end
end

function M:on_finish_guide(guide_id)
  self:call_guide_listen_func("on_finish_guide", guide_id)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_skill_end(npc, skill_id)
  self:call_guide_listen_func("on_skill_end", npc, skill_id)
end

function M:on_input(input_id)
  self:call_guide_listen_func("on_input", input_id)
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
