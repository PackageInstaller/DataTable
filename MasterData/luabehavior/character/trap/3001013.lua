local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")
local misle = 0
local s_delay = 2.2
local m_delay = 2.2
local fall_pos, summon_pos_1, summon_pos_2, summon_pos_3, summon_pos_4
local monster_nmb = 0
local Aten

function M:_init(npc)
  Base._init(self)
  self.skill01 = {
    300101301,
    5,
    0,
    0,
    0,
    get_skill_cfg(300101301).CastTime,
    get_skill_cfg(300101301).AfterTime
  }
  self.sum_nub_max = 2
  self.max_misle = 2
  self.skill_interval = 4
  self.splash_timer = 0
  self.skill_midu = 15
  self.x_xiuzheng = 11
  self.z_xiuzheng = 10
  self.chu10 = self.z_xiuzheng
  self.control = 4
  self.sum_nub = 0
  self.target = nil
  self.cast_s_skill = 0
  self.cast_s_skill2 = 0
  self.cast_s_skill3 = 0
  self.cast_s_skill4 = 0
  self.summon_skill_time = 0
  self.summon_skill_time2 = 0
  self.summon_skill_time3 = 0
  self.summon_skill_time4 = 0
  self.summon_msl_time = 0
  self.summon_msl_time2 = 0
  self.summon_msl_time3 = 0
  self.summon_msl_time4 = 0
  self.cast_ml = 0
  self.cast_m2 = 0
  self.cast_m3 = 0
  self.cast_m4 = 0
  self.die_control = false
  set_can_searched(npc, false)
  CommonMonster.set_value("召唤总数", 3001013, self.sum_nub_max * self.max_misle)
  CommonMonster.set_value("怪物数量", 0, 0)
  summon_pos_1 = {
    0,
    0,
    0
  }
  summon_pos_2 = {
    0,
    0,
    0
  }
  summon_pos_3 = {
    0,
    0,
    0
  }
  summon_pos_4 = {
    0,
    0,
    0
  }
end

function M:cast_skill(skill_instant_ID)
  if self.sum_nub >= self.sum_nub_max then
    return
  end
  if self.target then
    fall_pos = get_npc_pos(self.target)
  end
  if 300101301 == skill_instant_ID[1] and 0 == misle and self.target and 0 == misle then
    local xx, zz = get_scene_map_pos_postion("center")
    local npc_time = get_npc_time(self.npc)
    if xx and zz and Aten then
      summon_pos_1.x = fall_pos.x + math.random(-self.skill_midu, self.skill_midu) / self.chu10
      summon_pos_1.z = fall_pos.z + math.random(-self.skill_midu, self.skill_midu) / self.chu10
      if summon_pos_1.x - xx > self.x_xiuzheng then
        summon_pos_1.x = xx + self.x_xiuzheng
      end
      if summon_pos_1.x - xx < -self.x_xiuzheng then
        summon_pos_1.x = xx - self.x_xiuzheng
      end
      if summon_pos_1.z - zz > self.z_xiuzheng then
        summon_pos_1.z = zz + self.z_xiuzheng
      end
      if summon_pos_1.z - zz < -self.z_xiuzheng then
        summon_pos_1.z = zz - self.z_xiuzheng
      end
    else
      summon_pos_1.x = fall_pos.x + math.random(-self.skill_midu, self.skill_midu) / self.chu10
      summon_pos_1.z = fall_pos.z + math.random(-self.skill_midu, self.skill_midu) / self.chu10
    end
    cast_skill(self.npc, nil, 300101301, summon_pos_1.x, summon_pos_1.z)
    self.summon_skill_time = npc_time + s_delay
    self.summon_msl_time = npc_time + m_delay
    self.cast_s_skill = 1
    self.cast_m1 = 1
    misle = misle + 1
    self.sum_nub = self.sum_nub + 1
  end
end

function M:sunmmon_skill()
  local npc_time = get_npc_time(self.npc)
  local monster_nmb = CommonMonster.get_value("怪物数量", 0)
  if npc_time > self.summon_skill_time and 1 == self.cast_s_skill and summon_pos_1 then
    if 0 == monster_nmb or 2 == monster_nmb or 4 == monster_nmb then
      add_npc2(2, 201002, summon_pos_1.x, summon_pos_1.z - 0.5, 0, 0, 2, 0)
    else
      add_npc2(2, 201003, summon_pos_1.x, summon_pos_1.z - 0.5, 0, 0, 2, 0)
    end
    self.cast_s_skill = 0
    CommonMonster.set_value("怪物数量", 0, monster_nmb + 1)
  end
  if npc_time > self.summon_msl_time and 1 == self.cast_m1 and summon_pos_1 then
    cast_missile(self.npc, nil, summon_pos_1.x, summon_pos_1.z, 2010011701, 0)
    cast_missile(self.npc, nil, summon_pos_1.x, summon_pos_1.z, 2010011702, 0)
    self.cast_m1 = 0
  end
  if npc_time > self.summon_skill_time2 and 1 == self.cast_s_skill2 and summon_pos_2 then
    if 0 == monster_nmb or 2 == monster_nmb or 4 == monster_nmb then
      add_npc2(2, 201002, summon_pos_2.x, summon_pos_2.z - 0.5, 0, 0, 2, 0)
    else
      add_npc2(2, 201003, summon_pos_2.x, summon_pos_2.z - 0.5, 0, 0, 2, 0)
    end
    self.cast_s_skill2 = 0
    CommonMonster.set_value("怪物数量", 0, monster_nmb + 1)
  end
  if npc_time > self.summon_msl_time2 and 1 == self.cast_m2 and summon_pos_1 then
    cast_missile(self.npc, nil, summon_pos_2.x, summon_pos_2.z, 2010011701, 0)
    cast_missile(self.npc, nil, summon_pos_2.x, summon_pos_2.z, 2010011702, 0)
    self.cast_m2 = 0
  end
  if npc_time > self.summon_skill_time3 and 1 == self.cast_s_skill3 and summon_pos_3 then
    if 0 == monster_nmb or 2 == monster_nmb or 4 == monster_nmb then
      add_npc2(2, 201002, summon_pos_3.x, summon_pos_3.z - 0.5, 0, 0, 2, 0)
    else
      add_npc2(2, 201003, summon_pos_3.x, summon_pos_3.z - 0.5, 0, 0, 2, 0)
    end
    self.cast_s_skill3 = 0
    CommonMonster.set_value("怪物数量", 0, monster_nmb + 1)
  end
  if npc_time > self.summon_msl_time3 and 1 == self.cast_m3 and summon_pos_1 then
    cast_missile(self.npc, nil, summon_pos_3.x, summon_pos_3.z, 2010011701, 0)
    cast_missile(self.npc, nil, summon_pos_3.x, summon_pos_3.z, 2010011702, 0)
    self.cast_m3 = 0
  end
  if npc_time > self.summon_skill_time4 and 1 == self.cast_s_skill4 and summon_pos_4 then
    if 0 == monster_nmb or 2 == monster_nmb or 4 == monster_nmb then
      add_npc2(2, 201002, summon_pos_4.x, summon_pos_4.z - 0.5, 0, 0, 2, 0)
    else
      add_npc2(2, 201003, summon_pos_4.x, summon_pos_4.z - 0.5, 0, 0, 2, 0)
    end
    self.cast_s_skill4 = 0
    CommonMonster.set_value("怪物数量", 0, monster_nmb + 1)
  end
  if npc_time > self.summon_msl_time4 and 1 == self.cast_m4 and summon_pos_1 then
    cast_missile(self.npc, nil, summon_pos_4.x, summon_pos_4.z, 2010011701, 0)
    cast_missile(self.npc, nil, summon_pos_4.x, summon_pos_4.z, 2010011702, 0)
    self.cast_m4 = 0
  end
end

function M:search_target()
  if not self.target then
    self.target = search_npc(self.npc, 4, 50, nil, 1)
    Aten = search_npc(self.npc, 2, 50, 2001038, 1)
  end
end

function M:control_set()
  if 0 == self.control then
    self:cast_skill(self.skill01)
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    self.npc:on_dead(nil, true)
    remove_npc(npc)
  end
end

function M:on_frame()
  if 0 == CommonMonster.get_value("召唤总数", 3001013) then
    cast_magic(self.npc, self.npc, 2001053, 0)
  end
  if is_pass_room() and not get_sync_var("trap_switch_on") then
    abort_skill(self.npc)
    self.control = 9
  end
  self:sunmmon_skill()
  self:control_set()
  CommonMonster.search_target(self, 100, 8)
  if self.target and self.control == nil then
    self.control = 0
  end
  if 4 == self.control and get_npc_time(self.npc) > self.splash_timer then
    self.control = nil
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 300101301 == skill_id and self.sum_nub >= self.sum_nub_max then
    self.die_control = true
  end
  if 300101301 == skill_id and misle < self.max_misle and self.target then
    fall_pos = get_npc_pos(self.target)
    local xx, zz = get_scene_map_pos_postion("center")
    local npc_time = get_npc_time(self.npc)
    if 1 == misle then
      if xx and zz and Aten then
        summon_pos_2.x = fall_pos.x + math.random(-self.skill_midu, self.skill_midu) / self.chu10
        summon_pos_2.z = fall_pos.z + math.random(-self.skill_midu, self.skill_midu) / self.chu10
        if summon_pos_2.x - xx > self.x_xiuzheng then
          summon_pos_2.x = xx + self.x_xiuzheng
        end
        if summon_pos_2.x - xx < -self.x_xiuzheng then
          summon_pos_2.x = xx - self.x_xiuzheng
        end
        if summon_pos_2.z - zz > self.z_xiuzheng then
          summon_pos_2.z = zz + self.z_xiuzheng
        end
        if summon_pos_2.z - zz < -self.z_xiuzheng then
          summon_pos_2.z = zz - self.z_xiuzheng
        end
      else
        summon_pos_2.x = fall_pos.x + math.random(-self.skill_midu, self.skill_midu) / self.chu10
        summon_pos_2.z = fall_pos.z + math.random(-self.skill_midu, self.skill_midu) / self.chu10
      end
      cast_skill(self.npc, nil, 300101301, summon_pos_2.x, summon_pos_2.z)
      self.summon_skill_time2 = npc_time + s_delay
      self.summon_msl_time2 = npc_time + m_delay
      self.cast_s_skill2 = 1
      self.cast_m2 = 1
    elseif 2 == misle then
      if xx and zz and Aten then
        summon_pos_3.x = fall_pos.x + math.random(-self.skill_midu, self.skill_midu) / self.chu10
        summon_pos_3.z = fall_pos.z + math.random(-self.skill_midu, self.skill_midu) / self.chu10
        if summon_pos_3.x - xx > self.x_xiuzheng then
          summon_pos_3.x = xx + self.x_xiuzheng
        end
        if summon_pos_3.x - xx < -self.x_xiuzheng then
          summon_pos_3.x = xx - self.x_xiuzheng
        end
        if summon_pos_3.z - zz > self.z_xiuzheng then
          summon_pos_3.z = zz + self.z_xiuzheng
        end
        if summon_pos_3.z - zz < -self.z_xiuzheng then
          summon_pos_3.z = zz - self.z_xiuzheng
        end
      else
        summon_pos_3.x = fall_pos.x + math.random(-self.skill_midu, self.skill_midu) / self.chu10
        summon_pos_3.z = fall_pos.z + math.random(-self.skill_midu, self.skill_midu) / self.chu10
      end
      cast_skill(self.npc, nil, 300101301, summon_pos_3.x, summon_pos_3.z)
      self.summon_skill_time3 = npc_time + s_delay
      self.summon_msl_time3 = npc_time + m_delay
      self.cast_s_skill3 = 1
      self.cast_m3 = 1
    elseif 3 == misle then
      if xx and zz and Aten then
        summon_pos_4.x = fall_pos.x + math.random(-self.skill_midu, self.skill_midu) / self.chu10
        summon_pos_4.z = fall_pos.z + math.random(-self.skill_midu, self.skill_midu) / self.chu10
        if summon_pos_4.x - xx > self.x_xiuzheng then
          summon_pos_4.x = xx + self.x_xiuzheng
        end
        if summon_pos_4.x - xx < -self.x_xiuzheng then
          summon_pos_4.x = xx - self.x_xiuzheng
        end
        if summon_pos_4.z - zz > self.z_xiuzheng then
          summon_pos_4.z = zz + self.z_xiuzheng
        end
        if summon_pos_4.z - zz < -self.z_xiuzheng then
          summon_pos_4.z = zz - self.z_xiuzheng
        end
      else
        summon_pos_4.x = fall_pos.x + math.random(-self.skill_midu, self.skill_midu) / self.chu10
        summon_pos_4.z = fall_pos.z + math.random(-self.skill_midu, self.skill_midu) / self.chu10
      end
      cast_skill(self.npc, nil, 300101301, summon_pos_4.x, summon_pos_4.z)
      self.summon_skill_time4 = npc_time + s_delay
      self.summon_msl_time4 = npc_time + m_delay
      self.cast_s_skill4 = 1
      self.cast_m4 = 1
    end
    misle = misle + 1
  else
    self.splash_timer = get_npc_time(self.npc) + self.skill_interval
    self.control = 4
    misle = 0
  end
end

return M
