local M = Util.create_class()
local CommonMonster = import("common.monster")
local tool = import("common.monster_tool")
local DEAD_ADD_MAGIC_LIST = {
  399931,
  399932,
  399933
}
local SUPERARMOR_BREAK_MAGIC_LIST = {20101101034, 20101101029}
local PALSY_HURT_ATK_MAGIC_LIST = {
  Const.MONSTER_BE_HIT.FX,
  20101201014,
  20101101026,
  20101101027
}
M.roleBase = import("character.base.role_base")

function M.xRay(monster)
  cast_magic(monster.npc, monster.npc, 1999215)
  monster.roleBase:xRay()
end

function M:_init()
  self.tool = tool
  self.h1001004_f1_damage_time = 0
  self.h1001004 = nil
  self.born_tag = false
  self.born_skill = nil
  self.cnt_1001007 = 0
  self.remove_switch = false
  self.remove_timer = 0
  self.dead_fx_timer = nil
  self.hurt_check = 0
  self.hurt_check_timer = 0
  self.hurt_cnt_timer = 0
  self.level_stun_set = false
  self.pos = {}
  self.random_wander_time = 0
  self.control = 0
  self.random_type = 0
  self.hit_wall_timer = 0
  self.wander_timer = 0
  self.wander_state = 0
  self.monster_type = nil
  self.counter_val_interval = 6
  self.counter_val_interval_timer = -1
  self.counter_val_decay_timer = -1
  self.counter_atk_val = 0
  self.stun_info = {set = false, time = 0}
  self.counter_reatk_skill = self.skill01
  self.counter_reatk_skill_lv = 10019002
  self.game_time = 0
  self.relaxation_time = 0
  self.relaxation_switch = 0
  self.monster_scene_state = true
  self.now_time = 0
  self.camp_skill_list = {}
  self.camp = 0
  self.camp_switch = 0
  self.camp_switch_time = 0
  self.camp_distance = {
    ["近攻"] = {2.5, 4},
    ["远攻"] = {6, 8},
    ["围观"] = {5, 6},
    ["机会"] = {3, 4.5}
  }
  self.camp_distance_switch = nil
  self.camp_angle_switch = nil
  self.camp_distance_random = {
    0,
    0,
    0,
    0,
    nil
  }
  self.camp_distance_random_melee = {
    0,
    0,
    0
  }
  self.camp_attack_nums = 0
  self.start_time = math.random(10, 40) / 10
  self.skill_set = 0
  self.skill_set_time = 0
  self.skill_set_random = 0
  self.hurt_system = 0
  self.hurt_atk_state = false
  self.hurt_value = 80
  self.hurt_value_add_time = 0
  self.hurt_value_time = 0
  self.hurt_attack = 0
  self.hurt_attack_time = 0
  self.hurt_type = 0
  self.hitwall_pos = {}
  self.hitwall = false
  self.camera_time = 0
  self.stun_type = 0
  self.stun = false
  self.break_time = 0
  self.break_time1 = 2.8
  self.break_time2 = 5
  self.mojotime_set = false
  self.majotime_timer = 0
  self.block = 0
  self.block_hit = 0
  self.block_hit1 = 2
  self.block_hit2 = 4
  self.block_time = 0
end

function M:on_born_behavior()
  CommonMonster.born_animation(self, self.born_skill)
  cast_magic(self.npc, self.npc, 399929, 1)
end

function M:on_hero_showup_or_back(npc, is_show_up)
  if not is_show_up and npc == self.target then
    self.target = nil
    CommonMonster.search_target(self, 30, 8)
  end
end

function M:on_magic_begin(npc, target, magic_id)
  if npc == self.target and magic_id == Const.COMMON.OWN_MAJO_TIME and get_armor_def_level(self.npc) > 1 then
    cast_magic(self.npc, self.npc, Const.STATE_MARK.PALSY_MARK, 1)
  end
  if npc == self.npc and magic_id == Const.LOCK_MASK then
    set_can_searched(self.npc, false)
  end
end

function M:on_magic_end(npc, target, magic_id)
  if magic_id == Const.COMMON.MAJO_TIME_EFFECT then
    self.mojotime_set = false
    if check_magic(self.npc, Const.COMMON.MAJO_TIME) then
      abort_magic_by_id(self.npc, Const.COMMON.MAJO_TIME)
    end
  end
  if npc == self.npc and magic_id == Const.LOCK_MASK then
    set_can_searched(self.npc, true)
  end
end

function M:on_npc_group_clear(group_id)
  if CommonMonster.get_value("正在攻击的近战怪物数量", group_id) then
    CommonMonster.set_value("正在攻击的近战怪物数量", group_id, nil, true)
  end
  if CommonMonster.get_value("正在攻击的远程怪物数量", group_id) then
    CommonMonster.set_value("正在攻击的远程怪物数量", group_id, nil, true)
  end
  if CommonMonster.get_value("群组攻击影响时间", group_id) then
    CommonMonster.set_value("群组攻击影响时间", group_id, nil, true)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and self.camp_skill_list then
    for _, v in pairs(self.camp_skill_list) do
      if v[1] == skill_id then
        local group_id = get_npc_group_id(self.npc)
        if not CommonMonster.get_value("正在攻击的近战怪物数量", group_id) and not CommonMonster.get_value("正在攻击的远程怪物数量", group_id) then
          return
        end
        if group_id then
          if 1 == self.monster_type then
            CommonMonster.set_value("正在攻击的近战怪物数量", group_id, CommonMonster.get_value("正在攻击的近战怪物数量", group_id) + 1)
          else
            CommonMonster.set_value("正在攻击的远程怪物数量", group_id, CommonMonster.get_value("正在攻击的远程怪物数量", group_id) + 1)
          end
        end
      end
    end
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc then
    if self.counter_reatk_skill then
      if not self.monster_scene_state then
        return
      end
      if check_npc_status(self.npc, 2) and self.counter_atk_val <= 100 then
        local type_diff
        if hit_type <= 2 then
          type_diff = 1
        elseif hit_type <= 4 then
          type_diff = 2
        else
          type_diff = 3
        end
        local val_increase = math.random() * 30 + 15 + 5 * type_diff
        self.counter_atk_val = self.counter_atk_val + val_increase
        self.counter_val_decay_timer = get_npc_time(self.npc)
      elseif self.counter_atk_val > 100 and not check_npc_status(self.npc, 10) and not check_npc_status(self.npc, 11) then
        if not CommonMonster.get_value("霸体反击怪物个数", 1) then
          CommonMonster.set_value("霸体反击怪物个数", 1, 0)
        end
        if not CommonMonster.get_value("群组霸体反击间隔时间", 1) then
          CommonMonster.set_value("群组霸体反击间隔时间", 1, 0)
        end
        local now_time = get_npc_time(self.npc)
        if now_time >= self.counter_val_interval_timer then
          if CommonMonster.get_value("霸体反击怪物个数", 1) >= 1 then
            self.counter_atk_val = math.random() * 10
          end
          
          local function recount_func()
            abort_skill(self.npc, 1)
            self.counter_atk_val = 0
            self.counter_val_interval_timer = get_npc_time(self.npc) + self.counter_val_interval
            self.counter_val_decay_timer = -1
            CommonMonster.set_value("群组霸体反击间隔时间", 1, now_time + math.random() * 2 + 3)
            if npc_is_destroy(self.npc) == false and false == npc_is_destroy(self.target) and check_npc_distance(self.npc, self.target, 4, false) then
              cast_magic(self.npc, self.target, 10019003, 1)
              cast_magic(self.npc, self.target, 10019004, 1)
              cast_missile(self.npc, self.target, nil, nil, 10019900102, 1)
            end
            cast_magic(self.npc, self.npc, 10019000, 1)
            cast_magic(self.npc, self.npc, self.counter_reatk_skill_lv, 1)
            CommonMonster.tiktok_timer_func(self, 0.05, function()
              if not is_cast_skill_time(self.npc, 1) then
                cast_skill(self.npc, self.target, self.counter_reatk_skill[1])
              end
            end)
            CommonMonster.set_value("霸体反击怪物个数", 1, CommonMonster.get_value("霸体反击怪物个数", 1) + 1)
          end
          
          local temp_list = search_npc(self.npc, 2, 100, nil, true, true)
          if temp_list[1] then
            if now_time >= CommonMonster.get_value("群组霸体反击间隔时间", 1) then
              recount_func()
            end
          else
            recount_func()
          end
        end
      end
    end
    if (check_npc_status(self.npc, 2) or check_npc_status(self.npc, 14)) and check_magic(self.npc, Const.COMMON.MAJO_TIME) then
      abort_magic_by_id(self.npc, Const.COMMON.MAJO_TIME)
      self.majotime_timer = get_time() + 0.6
      self.mojotime_set = true
    end
    if missile_cfg.Id == Const.MONSTER_BUFF.INSPIRE then
      cast_magic(self.npc, self.npc, 6040044, get_magic_num(self.npc, 6040045) + 1)
    end
  end
end

function M:on_skill_end(npc, skill_id)
  if npc == self.npc then
    if CommonMonster.get_value("霸体反击怪物个数", 1) and self.counter_reatk_skill and skill_id == self.counter_reatk_skill[1] and CommonMonster.get_value("霸体反击怪物个数", 1) >= 1 then
      CommonMonster.set_value("霸体反击怪物个数", 1, CommonMonster.get_value("霸体反击怪物个数", 1) - 1)
    end
    if self.camp_skill_list then
      if check_magic(self.npc, 10019000) then
        abort_magic_by_id(self.npc, 10019000)
      end
      for _, v in pairs(self.camp_skill_list) do
        if v[1] == skill_id then
          local group_id = get_npc_group_id(self.npc)
          if not CommonMonster.get_value("正在攻击的近战怪物数量", group_id) and not CommonMonster.get_value("正在攻击的远程怪物数量", group_id) then
            return
          end
          if group_id then
            if 1 == self.monster_type then
              CommonMonster.set_value("正在攻击的近战怪物数量", group_id, CommonMonster.get_value("正在攻击的近战怪物数量", group_id) - 1)
            else
              CommonMonster.set_value("正在攻击的远程怪物数量", group_id, CommonMonster.get_value("正在攻击的远程怪物数量", group_id) - 1)
            end
          end
        end
      end
    end
    if skill_id == self.counter_reatk_skill then
      abort_magic_by_id(self.npc, self.counter_reatk_skill_lv)
    end
  end
end

function M:on_toughness_change_by_magic(npc, camp, change_grading)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, camp, change_grading)
  if target == self.npc and (1 == change_grading or 2 == change_grading or 3 == change_grading or 4 == change_grading or 5 == change_grading) then
    for _, magic_id in pairs(SUPERARMOR_BREAK_MAGIC_LIST) do
      cast_magic(self.npc, self.npc, magic_id, 1)
    end
    if 1 == change_grading then
    end
  end
end

function M.on_element_aborn_start(monster, npc, element, skill_id)
  if monster.npc ~= npc then
    return
  end
  if 5 == element then
    CommonMonster.tiktok_timer_func(monster, 2.7, function()
      cast_magic(monster.npc, monster.npc, 1998058, 0)
    end)
  end
  local now = get_time()
  local tool = monster.tool
  if now < tool.elementAbornCamPullTimer then
    return
  end
  tool.elementAbornCamPullTimer = now + tool.elementAbornCamPullInterval
  local type = get_role_kind(npc)
  local role = get_come_on_hero()
  if 2 == type then
    cast_magic(role, role, Const.MONSTER_BE_HIT.CAM_SHAKE, 0)
  elseif 3 == type or 4 == type then
    cast_magic(role, role, Const.MONSTER_BE_HIT.CAM_PULL, 0)
    cast_magic(role, role, Const.MONSTER_BE_HIT.SLOMO_SELF, 0)
    cast_magic(role, role, Const.MONSTER_BE_HIT.SLOMO_OTHERS, 0)
    cast_magic(role, role, Const.MONSTER_BE_HIT.CAM_SHAKE, 0)
    cast_magic(monster.npc, monster.npc, Const.MONSTER_BE_HIT.FX, 0)
  end
end

function M:on_npc_hp_zero(npc)
  if npc.id == 201030 then
    return
  end
  local fx_time = 0
  local remove_time = 0.5
  if npc == self.npc then
    time_scale_immune(npc, true)
    if not check_magic(npc, 399931) then
      for _, magic_id in pairs(DEAD_ADD_MAGIC_LIST) do
        cast_magic(npc, npc, magic_id, 0)
      end
      enable_shadow(npc, false)
    end
    self.remove_switch = true
    abort_skill(npc, true)
    if self.die_skill and self.target then
      if self.target then
        lookat_npc(self.npc, self.target, true)
      end
      cast_skill(npc, self.target, self.die_skill)
      set_npc_dead(npc, nil, true)
    else
      set_npc_dead(npc, nil, true)
    end
    local get_time = get_time()
    self.dead_fx_timer = get_time + fx_time
    self.remove_timer = get_time + remove_time
  end
  if npc == self.target then
  end
end

function M.missile_skill_action_info(monster, missileId)
  return
end

return M
