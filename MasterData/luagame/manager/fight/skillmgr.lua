local Base = require("obj.base_component")
local Skill = require("manager.fight.skill")
local SkillDefine = require("manager.fight.skill_define")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local Vec3 = require("base.vec3")
local tinsert = table.insert
local _tremove = table.remove
local _time = os.time
local SET_TYPE = Config.ATTR_SET_TYPE
local SKILL_MOVE_TYPE = SkillDefine.SKILL_MOVE_TYPE
local SKILL_ABORT_TYPE = Config.SKILL_ABORT_TYPE
local VALUE_TYPE = {
  FIXED = 1,
  MAX_RATIO = 2,
  RATIO = 3
}
local KEYFRAME_STATUS = {
  CAN_USE = 0,
  CAN_USE_ONCE = 1,
  CANT_USE = 2,
  CANT_USE_ONCE = 3
}
local KEYFRAME_JUMP = {
  [KEYFRAME_STATUS.CAN_USE] = KEYFRAME_STATUS.CAN_USE,
  [KEYFRAME_STATUS.CAN_USE_ONCE] = KEYFRAME_STATUS.CANT_USE,
  [KEYFRAME_STATUS.CANT_USE] = KEYFRAME_STATUS.CANT_USE,
  [KEYFRAME_STATUS.CANT_USE_ONCE] = KEYFRAME_STATUS.CAN_USE
}
local M = Util.create_child_mt(Base)
local MissileTask = Util.create_class()

function MissileTask:_init(missile_id, uuid, target, target_pos, missile_level, skill_id, lookat_pos, born_pos, skill_action_info, not_report_skill, frame_ignore_time_scale)
  self.missile_id = missile_id
  self.target = target
  self.target_pos = target_pos
  self.missile_level = missile_level
  self.skill_id = skill_id
  self.lookat_pos = lookat_pos
  self.born_pos = born_pos
  self.skill_action_info = skill_action_info
  self.not_report_skill = not_report_skill
  self.frame_ignore_time_scale = frame_ignore_time_scale
  self.uuid = uuid
end

function MissileTask:on_destroy()
  self.missile_id = nil
  self.target = nil
  self.target_pos = nil
  self.missile_level = nil
  self.skill_id = nil
  self.lookat_pos = nil
  self.born_pos = nil
  self.skill_action_info = nil
  self.not_report_skill = nil
  self.frame_ignore_time_scale = nil
  self.uuid = nil
end

function M:_init(char)
  Base._init(self)
  self.v_char = char
  self.v_cur_skill = nil
  self.missile_task_pool = LuaObjPoolMgr.get_pool("mssile_task_pool") or LuaObjPoolMgr.register("mssile_task_pool", 50, MissileTask)
  self.v_missile_cache = {}
  self.v_magic_level = {}
  self.v_char_is_hero = char:is_hero()
  self.v_skill_tag2keyframe = {
    [0] = {}
  }
  self:load_skill()
  self.v_change_effect_energy_id = {}
  self.v_add_library_skill_list = {}
  self.v_skill_correct_data = {}
  self.v_correct_skill = {}
  self.v_effect_skill_magic = {}
  self.v_keyframe_status = {}
  self.v_magic_armor_atk_lv = 0
  self.v_magic_armor_def_lv = 0
end

function M:on_before_destroy()
  self.v_char = nil
  for _, skill in pairs(self.v_skill_tbl) do
    skill:on_destroy()
  end
  self.v_skill_tbl = nil
  self.v_cur_skill = nil
  self.v_missile_cache = nil
  self.v_magic_level = nil
  self.v_change_effect_energy_id = nil
  self.v_add_library_skill_list = nil
  self.v_correct_skill = nil
  self.v_skill_correct_data = nil
  self.v_effect_skill_magic = nil
  self.v_keyframe_status = nil
  self.v_skill_tag2keyframe = nil
end

function M:set_keyframe_by_tag(skill_id, tag, enable, force)
  skill_id = skill_id or 0
  local tar_skill_actions = self.v_skill_tag2keyframe[skill_id]
  if not tar_skill_actions then
    return
  end
  local tar_actions = tar_skill_actions[tag]
  if not tar_actions then
    return
  end
  for _, action in pairs(tar_actions) do
    self:set_keyframe_enable(action[0], enable, force)
  end
end

function M:set_keyframe_enable(keyframe_id, enable, force)
  local ret
  ret = enable and KEYFRAME_STATUS.CAN_USE or KEYFRAME_STATUS.CANT_USE
  ret = not force and ret + 1 or ret
  self.v_keyframe_status[keyframe_id] = ret
end

function M:try_do_keyframe(keyframe_id)
  local status = self.v_keyframe_status[keyframe_id] or KEYFRAME_STATUS.CAN_USE
  local ret = status
  self.v_keyframe_status[keyframe_id] = KEYFRAME_JUMP[status]
  return ret == KEYFRAME_STATUS.CAN_USE or ret == KEYFRAME_STATUS.CAN_USE_ONCE
end

function M:load_skill()
  self.v_skill_tbl = {}
  local character_cfg = self.v_char.character_cfg
  self.v_default_armor_atk_lv = character_cfg.DefaultSAAtkLevel or 1
  self.v_default_armor_def_lv = character_cfg.DefaultSADefLevel or 1
  local skill_id_list = ShareRes.get_skill_list(character_cfg.NpcId)
  if self.v_char_is_hero and not skill_id_list then
    Log.Error("没有技能列表: ", character_cfg.NpcId)
    return
  end
  local def_skill_cfg = ShareRes.get_default_skill_list(character_cfg.NpcId)
  if skill_id_list and def_skill_cfg then
    for _, skill_id in ipairs(skill_id_list) do
      self:create_skill(skill_id, true)
    end
    self.v_fight_end_skill_id = def_skill_cfg[8]
    self:set_skill_level()
  end
  if TowerMgr then
    if self.v_char:is_god() then
      local skill_id_list = ShareRes.get_skill_list(character_cfg.NpcId)
      for _, skill_id in ipairs(skill_id_list) do
        self.v_skill_tbl[skill_id] = Skill:new(skill_id, self.v_char)
      end
    end
    local battle_talent_skill_list = BattleTalentMgr:get_skill_list()
    for _, skill_id in pairs(battle_talent_skill_list) do
      self:create_skill(skill_id)
    end
  end
  if self.v_char_is_hero then
    local RoleSharedSkill = ShareRes.get_comm_string_value("RoleSharedSkill")
    if RoleSharedSkill then
      for _, skill_id in pairs(RoleSharedSkill) do
        if Util.is_more_than_zero(skill_id) then
          self:create_skill(skill_id)
        end
      end
    end
  end
end

function M:hero_set_skill_level()
  local equip_info, buddy_data
  buddy_data = self.v_char:get_buddy_data()
  if not buddy_data then
    return
  end
  equip_info = buddy_data.equip_data
  if equip_info then
    local advance_lv = equip_info.advance
    local advance_cfg = ShareRes.get_equip_advance_cfg(equip_info.id, advance_lv)
    if advance_cfg and advance_cfg.ActionMagics then
      for key, magic_id in pairs(advance_cfg.ActionMagics) do
        if magic_id > 0 then
          self.v_magic_level[magic_id] = advance_lv
        end
      end
    end
  end
  if (Global.is_open_timer or JournalMgr:get_oepn_record_jiournal_info()) and self.v_lskill_list and next(self.v_lskill_list) then
    UtilTable.clear_map(self.v_lskill_list)
  end
  local skill_list = buddy_data.skill_data or buddy_data.lSkill
  if not skill_list then
    return
  end
  for _, v in pairs(skill_list) do
    local id = v.id
    local lv = v.lv
    if Global.is_open_timer or JournalMgr:get_oepn_record_jiournal_info() then
      if not self.v_lskill_list then
        self.v_lskill_list = {}
      end
      self.v_lskill_list[_] = lv
    end
    local skill_cfg = ShareRes.create("buddy.buddy_skill_effect", id)
    if skill_cfg then
      for __, magic_id in pairs(skill_cfg.SubMagic) do
        if magic_id > 0 then
          self.v_magic_level[magic_id] = lv
        end
      end
      for __, skill_id in pairs(skill_cfg.Subskill) do
        if 0 ~= skill_id then
          local skill = self.v_skill_tbl[skill_id]
          if skill then
            skill:set_level(lv)
          else
            Log.Info("skill lv not set " .. skill_id)
          end
        end
      end
    end
  end
end

function M:summons_set_skill_level()
  local hero_map = {}
  local hero_list = SceneMgr:get_hero_list()
  if hero_list then
    for _, hero in pairs(hero_list) do
      hero_map[hero:get_npc_id()] = hero
    end
  end
  local hero
  for _, skill in pairs(self.v_skill_tbl) do
    local inheritCharacterSkillLevel = skill.skill_cfg.InheritCharacterSkillLevel
    if #inheritCharacterSkillLevel > 0 then
      hero = hero_map[inheritCharacterSkillLevel[1]]
      if hero then
        local buddy_data = hero:get_buddy_data()
        local skill_list = buddy_data and (buddy_data.skill_data or buddy_data.lSkill)
        if buddy_data and buddy_data then
          local skill_lv_map = {}
          for _, v in pairs(skill_list) do
            skill_lv_map[v.id] = v.lv
          end
          local skill_level = skill_lv_map[inheritCharacterSkillLevel[2]]
          if skill_level then
            skill:set_level(skill_level)
          end
        end
      end
    end
  end
end

function M:set_skill_level()
  if self.v_char:is_hero() then
    self:hero_set_skill_level()
  elseif self.v_char:is_summons() then
    self:summons_set_skill_level()
  end
end

function M:get_magic_level(magic_id)
  return self.v_magic_level[magic_id]
end

function M:create_missile(missile_id, uuid, target, target_pos, missile_level, skill_id, lookat_pos, born_pos, skill_action_info, not_report_skill)
  local ext_args
  if lookat_pos or skill_action_info or not_report_skill then
    ext_args = {
      lookat_pos = lookat_pos,
      skill_action_info = skill_action_info,
      not_report_skill = not_report_skill
    }
  end
  SceneMgr:create_missile(self.v_char, uuid, missile_id, target, nil, missile_level, skill_id, target_pos, born_pos, ext_args)
end

function M:add_missile_task(missile_id, target, target_pos, missile_level, lookat_pos, born_pos, ignore_frame, skill_action_info, not_report_skill, frame_ignore_time_scale)
  if self.v_char:is_die() then
    return
  end
  if SceneMgr:be_cleaning_up_missile() then
    return
  end
  if not skill_action_info then
    local behavior = self.v_char:get_behavior()
    skill_action_info = behavior and behavior.missile_skill_action_info and behavior:missile_skill_action_info(missile_id)
  end
  local skill_id = math.floor(missile_id / 100)
  local skill = self:get_skill(skill_id)
  if not missile_level or missile_level <= 0 then
    if skill then
      missile_level = skill.v_level
    else
      missile_level = 1
    end
  end
  local uuid = SceneMgr:get_uuid()
  local task = self.missile_task_pool:new_obj(missile_id, uuid, target, target_pos, missile_level, math.floor(missile_id / 100), lookat_pos, born_pos, skill_action_info, not_report_skill, frame_ignore_time_scale)
  local missile_cfg = ShareRes.create("skill.missile", missile_id)
  Util.assert(missile_cfg, "can't find missile config: ", missile_id)
  local delay = ignore_frame and 0 or missile_cfg.frame * Config.LOGIC_FRAME
  self.v_missile_cache[task] = delay
  return uuid
end

function M:_update_missile_task()
  local cache = self.v_missile_cache
  local missile_low_dt = self.v_char:get_missile_low_dt()
  local dt
  for missile_task, time in pairs(cache) do
    if missile_task.frame_ignore_time_scale then
      dt = Global.low_delta_time
    else
      dt = missile_low_dt
    end
    cache[missile_task] = time - dt
    if cache[missile_task] <= 0 then
      self:create_missile(missile_task.missile_id, missile_task.uuid, missile_task.target, missile_task.target_pos, missile_task.missile_level, missile_task.skill_id, missile_task.lookat_pos, missile_task.born_pos, missile_task.skill_action_info, missile_task.not_report_skill)
      self.missile_task_pool:destroy_obj(missile_task)
      cache[missile_task] = nil
    end
  end
end

function M:update(dt)
  if self.v_cur_skill then
    self.v_cur_skill:update(dt)
    if self.v_cur_skill and self.v_cur_skill:get_elapse() >= self.v_cur_skill_count_duration then
      local char = self.v_cur_skill.v_char
      local skill_id = self.v_cur_skill.skill_id
      BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_BEFORE_SKILL_END, char, skill_id, true, false)
      BehaviorMgr:call_behavior_fun(char, "on_self_before_skill_end", skill_id, true, false)
      self.v_cur_skill:stop()
      self.v_cur_skill = nil
      BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_SKILL_END, char, skill_id, true, false)
      BehaviorMgr:call_behavior_fun(char, "on_self_skill_end", skill_id, true, false)
    end
  end
end

function M:low_update()
  self:_update_missile_task()
  if self.v_char:is_hero() or self.v_char:is_god() then
    for _, v in pairs(self.v_skill_tbl) do
      v:update_energy()
    end
  end
  if self.v_cur_skill then
    self.v_cur_skill:low_update()
  end
end

function M:cast_skill(skill_id, target, targetx, targety, targetz, skill_action_info, start_frame)
  if not self:_can_cast_skill(skill_id) or self.v_char:is_die() then
    return
  end
  if self.v_cur_skill then
    local char = self.v_cur_skill.v_char
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_BEFORE_SKILL_END, char, skill_id, true, false)
    BehaviorMgr:call_behavior_fun(char, "on_self_before_skill_end", skill_id, true, false)
    self.v_cur_skill:stop(true)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_SKILL_END, char, skill_id, false, true)
    BehaviorMgr:call_behavior_fun(char, "on_self_skill_end", skill_id, false, true)
  end
  local skill = self.v_skill_tbl[skill_id]
  if not skill then
    Log.Error("找不到技能：", skill_id)
    return false
  end
  local energy = skill:get_energy_info()
  local is_ignore = skill:is_ignore_consume_detect()
  if energy and energy.cur_energy < energy.cost_energy and not is_ignore then
    return
  end
  local pos
  if targetx and targetz then
    if not targety then
      local _, height = Util.raycast_by_role(self.v_char, targetx, targetz)
      targety = height
    end
    pos = Vec3.New(targetx, targety, targetz)
  elseif target then
    pos = target:get_pos_vec3()
  else
    pos = self:_get_default_target_pos(skill)
  end
  if self.v_char:is_hero() then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_HERO_PRE_CAST_SKILL)
    msg.mm_x = skill_id
  end
  skill:cast(pos, target, skill_action_info, start_frame)
  self:add_skill(skill)
  return true
end

function M:try_create_skill(skill_id, force)
  local skill = self:get_skill(skill_id)
  if not skill and force then
    skill = self:create_skill(skill_id, force)
  end
  return skill
end

function M:create_skill(skill_id, force)
  local skill = Skill:new(skill_id, self.v_char)
  self.v_skill_tbl[skill_id] = skill
  if self.v_char:is_hero() or self.v_char:is_npc() and self.v_char:get_role_kind() == Config.CommonDefine.NPC_KIND.BOSS or force then
    self.v_skill_tag2keyframe[skill_id] = skill:get_tag2actions(self.v_skill_tag2keyframe[0])
  end
  return skill
end

function M:_can_cast_skill(skill_id)
  local skill = self.v_skill_tbl[skill_id]
  if not skill and not self.v_char_is_hero then
    skill = self:create_skill(skill_id)
  end
  assert(skill, "npc has no such skill" .. skill_id)
  if self.v_cur_skill and self.v_cur_skill:get_elapse() < self.v_cur_skill_cast_duration or self.v_char.is_in_puppet_mode then
    return false
  end
  if self.v_char:is_die() then
    return false
  end
  return true
end

function M:abort(abort_type)
  local force, is_behit_abort, break_abort, behavior_abort, move_abort
  if abort_type then
    force = 0 ~= abort_type & SKILL_ABORT_TYPE.FOECE
    is_behit_abort = 0 ~= abort_type & SKILL_ABORT_TYPE.BEHIT_ABORT
    break_abort = 0 ~= abort_type & SKILL_ABORT_TYPE.BREAK_ABORT
    behavior_abort = 0 ~= abort_type & SKILL_ABORT_TYPE.BEHAVIOR_ABORT
    move_abort = 0 ~= abort_type & SKILL_ABORT_TYPE.MOVE_ABORT
  end
  local has_skill = false
  local dir_to_run = move_abort
  if self.v_cur_skill then
    local char = self.v_cur_skill.v_char
    local skill_id = self.v_cur_skill.skill_id
    dir_to_run = dir_to_run or self.v_cur_skill.skill_cfg.SkillToRun
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_BEFORE_SKILL_END, char, skill_id, false, true, behavior_abort)
    BehaviorMgr:call_behavior_fun(char, "on_self_before_skill_end", skill_id, false, true, behavior_abort)
    self.v_cur_skill:stop(true, is_behit_abort, break_abort)
    self.v_cur_skill = nil
    has_skill = true
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_SKILL_END, char, skill_id, false, true, behavior_abort)
    BehaviorMgr:call_behavior_fun(char, "on_self_skill_end", skill_id, false, true, behavior_abort)
  end
  if not self.v_char:is_die() and not dir_to_run and (not (not (has_skill and force and self.v_char.state_manager:is_skill_end_to_idle()) or is_behit_abort) or break_abort) then
    self.v_char.state_manager:to_idle_state()
  end
end

function M:add_skill(skill)
  local before_time = skill:get_before_time()
  self.v_cur_skill_cast_duration = skill:get_cast_time()
  local after_time = skill:get_after_time()
  self.v_cur_skill_count_duration = before_time + self.v_cur_skill_cast_duration + after_time
  self.v_cur_skill = skill
end

function M:get_action_length(action)
  local motion_cfg = self.v_char.motion_cfg
  if not motion_cfg then
    return
  end
  local cfg = motion_cfg[action]
  if not cfg then
    return
  end
  local anim_len = Util.frame2realtime(cfg.TotalFrame, cfg.TailLength)
  return anim_len
end

function M:get_skill(skill_id)
  return self.v_skill_tbl[skill_id]
end

function M:get_skill_lv(skill_id)
  local skill = self:get_skill(skill_id)
  if not skill then
    return
  end
  local lv = skill:get_level()
  return lv
end

function M:init_energy()
  for _, skill in pairs(self.v_skill_tbl) do
    skill:init_energy()
  end
end

function M:reset_energy()
  for _, skill in pairs(self.v_skill_tbl) do
    if skill then
      local skill_info = skill:get_energy_info()
      if skill_info then
        local max_energy = skill_info.max_energy
        if 0 ~= max_energy then
          skill:on_change_skill_energy(max_energy)
        end
      end
    end
  end
end

function M:check_skill_cast_time(skill_item)
  local skill = skill_item or self.v_cur_skill
  if not skill then
    return
  end
  local before_time = skill:get_before_time()
  local cast_time = skill:get_cast_time()
  local cur_time = skill:get_elapse()
  return cur_time < before_time + cast_time
end

function M:set_armor_atk_lv(level, is_forced)
  self.v_magic_armor_atk_lv = level
  self.v_is_forced_armor_atk_lv = is_forced
end

function M:get_armor_atk_lv(skill_id)
  if self.v_is_forced_armor_atk_lv then
    return self.v_magic_armor_atk_lv
  end
  local cur_atk_lv
  local skill_item = skill_id and self.v_skill_tbl[skill_id] or self.v_cur_skill
  if skill_item and self:check_skill_cast_time(skill_item) then
    cur_atk_lv = skill_item:get_armor_atk_lv()
  else
    cur_atk_lv = self.v_default_armor_atk_lv
  end
  return cur_atk_lv + self.v_magic_armor_atk_lv
end

function M:set_armor_def_lv(level, is_forced_armor_def_lv)
  self.v_magic_armor_def_lv = level
  self.v_is_forced_armor_def_lv = is_forced_armor_def_lv
end

function M:get_armor_def_lv()
  if self.v_is_forced_armor_def_lv then
    return self.v_magic_armor_def_lv
  end
  local cur_def_lv
  if self:check_skill_cast_time() then
    cur_def_lv = self.v_cur_skill:get_armor_def_lv()
  else
    cur_def_lv = self.v_default_armor_def_lv
  end
  return cur_def_lv + self.v_magic_armor_def_lv
end

function M:set_change_effect_energy_id(id)
  self.v_change_effect_energy_id = self.v_change_effect_energy_id or {}
  tinsert(self.v_change_effect_energy_id, 1, id)
end

function M:get_change_effect_energy_id()
  return self.v_change_effect_energy_id[1]
end

function M:get_library_skill_list(key_val)
  return self.v_add_library_skill_list[key_val]
end

function M:add_library_skill_id(key_val, skill_id)
  self.v_add_library_skill_list[key_val] = self.v_add_library_skill_list[key_val] or {}
  tinsert(self.v_add_library_skill_list[key_val], skill_id)
end

function M:check_skill_id_existence(key_val, skill_id)
  if not self.v_add_library_skill_list[key_val] then
    return
  end
  for key, id in pairs(self.v_add_library_skill_list[key_val]) do
    if id == skill_id then
      return true
    end
  end
  return false
end

function M:remove_skill_library_by_id(key_val, skill_id)
  local library_list = self.v_add_library_skill_list[key_val]
  if not library_list then
    return
  end
  for i = #library_list, 1, -1 do
    local id = library_list[i]
    if id == skill_id then
      _tremove(library_list, i)
      break
    end
  end
end

function M:set_skill_correct_data(magic_id, skill_id, magic_val, value_type, set_type)
  self.v_skill_correct_data[skill_id] = self.v_skill_correct_data[skill_id] or {}
  local correct_data = self.v_skill_correct_data[skill_id]
  if correct_data[magic_id] then
    correct_data[magic_id].num = correct_data[magic_id].num + 1
    correct_data[magic_id].time = _time()
  else
    local new_data = {
      num = 1,
      value_type = value_type,
      magic_val = magic_val,
      set_type = set_type,
      time = _time()
    }
    correct_data[magic_id] = new_data
  end
  local skill = self:get_skill(skill_id)
  if not skill then
    return
  end
  local recover_energy = skill:get_skill_init_recover_energy()
  if set_type == SET_TYPE.REPLACE then
    correct_data[magic_id].recover_energy = recover_energy
    skill:on_set_skill_recover_energy(magic_val)
    return
  end
  local value = 0
  for _, data in pairs(correct_data) do
    if data.set_type ~= SET_TYPE.REPLACE and data.value_type == value_type then
      value = value + data.magic_val * data.num
    end
  end
  value = recover_energy * (value / 10000)
  skill:on_change_skill_recover_energy(value)
  self.v_effect_skill_magic[magic_id] = self.v_effect_skill_magic[magic_id] or {}
  self.v_effect_skill_magic[magic_id][skill_id] = true
end

function M:remove_effect_magic(magic_id)
  if not self.v_effect_skill_magic[magic_id] then
    return
  end
  local effect_skill = self.v_effect_skill_magic[magic_id]
  for skill_id, _ in pairs(effect_skill) do
    local correct_data = self.v_skill_correct_data[skill_id]
    if correct_data then
      self:set_skill_max_energy(correct_data, magic_id, skill_id)
    end
  end
end

function M:set_skill_max_energy(correct_data, magic_id, skill_id)
  local magic_data = correct_data[magic_id]
  local skill = self:get_skill(skill_id)
  if not skill then
    return
  end
  local recover_energy = skill:get_skill_init_recover_energy()
  local set_type = magic_data.set_type
  local value_type = magic_data.value_type
  if set_type == SET_TYPE.REPLACE then
    skill:on_set_skill_recover_energy(magic_data.recover_energy)
    return
  end
  local value = 0
  for id, data in pairs(correct_data) do
    if data.set_type ~= SET_TYPE.REPLACE and data.value_type == value_type and id ~= magic_id then
      value = value + data.magic_val
    end
  end
  value = recover_energy * (value / 10000)
  skill:on_change_skill_recover_energy(value)
  correct_data[magic_id] = nil
  self.v_effect_skill_magic[magic_id] = nil
end

function M:get_cur_skill_id()
  if not self.v_cur_skill then
    return
  end
  return self.v_cur_skill.skill_id
end

function M:get_cur_skill_elapse()
  if not self.v_cur_skill then
    return
  end
  return self.v_cur_skill:get_elapse()
end

function M:can_slipout()
  if not self.v_cur_skill then
    return false
  end
  return self.v_cur_skill.skill_cfg.SlipInStuck
end

function M:get_collide_move_coef()
  if not self.v_cur_skill then
    return
  end
  return self.v_cur_skill.skill_cfg.CollidedMoveCoef
end

function M:get_cur_skill()
  return self.v_cur_skill
end

function M:play_fight_end_skill()
  self.v_char:set_godmode(true, "play_fight_end_skill")
  self:abort(SKILL_ABORT_TYPE.FOECE | SKILL_ABORT_TYPE.BREAK_ABORT)
  self:cast_skill(self.v_fight_end_skill_id)
end

function M:get_fight_end_skill_finish_time()
  if self.v_fight_end_skill_id then
    local skill_cfg = ShareRes.create("skill.skill", self.v_fight_end_skill_id)
    if skill_cfg then
      return skill_cfg.CastTime
    end
  end
  return 10
end

function M:is_skill_move_default_now()
  if not self.v_cur_skill then
    return false
  end
  return self.v_cur_skill.skill_cfg.SkillMoveType == SKILL_MOVE_TYPE.DEFAULT
end

function M:get_lskill_list()
  return self.v_lskill_list
end

function M:is_in_fight_end_skill()
  return self.v_fight_end_skill_id ~= nil and nil ~= self.v_cur_skill and self.v_cur_skill.skill_id == self.v_fight_end_skill_id
end

function M:set_born_skill_id(skill_id)
  self.v_born_skill_id = skill_id
end

function M:is_in_born_skill()
  return self.v_born_skill_id ~= nil and nil ~= self.v_cur_skill and self.v_cur_skill.skill_id == self.v_born_skill_id
end

function M:on_skill_end(skill_id)
  if self.v_fight_end_skill_id == skill_id then
    self.v_char:set_godmode(false, "play_fight_end_skill")
  end
end

function M:clear_missile_cache()
  for missile_task in pairs(self.v_missile_cache) do
    self.missile_task_pool:destroy_obj(missile_task)
    self.v_missile_cache[missile_task] = nil
  end
end

function M:_get_default_target_pos(skill)
  local pos = self.v_char:get_pos_vec3():Clone()
  local df = self.v_char:get_dir_vec() * skill:get_dist_no_target()
  local _, height = Util.raycast_by_role(self.v_char, df.x, df.z)
  pos.x = pos.x + df.x
  pos.y = height
  pos.z = pos.z + df.z
  return pos
end

function M:set_skill_target(skill_id, target, target_pos)
  local skill = self.v_skill_tbl[skill_id]
  if not skill or skill:is_stoped() then
    return
  end
  if not target and not target_pos then
    target_pos = self:_get_default_target_pos(skill)
  end
  skill:set_target(target, target_pos)
end

return M
