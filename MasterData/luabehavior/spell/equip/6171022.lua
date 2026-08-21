local M = Util.create_class()
local tool = import("common.tool")
local rolebase = import("character.base.role_base")
local skillAction = import("character.base.base_role_skillAction")
local rogueMgr = import("common.rogueManager")
local team_hero_list = {
  get_scene_hero_by_poskey(21),
  get_scene_hero_by_poskey(22),
  get_come_on_hero()
}
local hero = get_come_on_hero()
local lazer_mis = {
  61710910101,
  61710910201,
  61710910301,
  61710910401,
  61710910403
}
local fangcheng_jindu = "Default"

function M:_init(npc)
  self.atkCD = 3
  self.atkTime = 0
  self.atkNum = 0
  self.atkB1CD = 4
  self.atkB1Time = 0
  self.atkB2_ResetCD = 2
end

function M:on_start()
  if not check_magic(self.npc, 6171001) then
    for k, v in pairs(team_hero_list) do
      cast_magic(self.npc, v, 6171001, 0)
    end
  end
  self:update_fangcheng_jindu()
end

function M:on_room_change()
  self:update_fangcheng_jindu()
end

function M:update_fangcheng_jindu()
  local branch_id, branch_level = get_equation_branch_info(15)
  if 0 == branch_id then
    fangcheng_jindu = "Default"
    self.after_damage = self.after_damage_Default
  end
  if 1501 == branch_id and 1 == branch_level then
    fangcheng_jindu = "A1"
    self.after_damage = self.after_damage_A1
  end
  if 1501 == branch_id and 2 == branch_level then
    fangcheng_jindu = "A2"
    self.after_damage = self.after_damage_A1
  end
  if 1502 == branch_id and 1 == branch_level then
    fangcheng_jindu = "B1"
    self.after_damage = self.after_damage_B1
  end
  if 1502 == branch_id and 2 == branch_level then
    fangcheng_jindu = "B2"
    self.after_damage = self.after_damage_B2
  end
end

function M:castholyBlade()
  if check_magic(hero, 61710221) then
    return
  end
  local per1, per2 = tool:randByTime(0.1, 0.5)
  if per2 then
    cast_magic(hero, hero, 61710221, 0)
    self.atkTime = get_npc_time(hero)
  end
end

function M:holyBladeAtk()
  if "A1" == fangcheng_jindu then
    cast_missile3(hero, hero, nil, nil, 61710910409, 1)
    cast_missile3(hero, hero, nil, nil, 61710910410, 1)
    return
  end
  if "A2" == fangcheng_jindu then
    cast_missile3(hero, hero, nil, nil, 61710910411, 1)
    cast_missile3(hero, hero, nil, nil, 61710910412, 1)
    return
  end
  if self.atkTime > get_npc_time(hero) or not check_magic(hero, 61710221) then
    return
  end
  cast_missile3(hero, hero, nil, nil, 61710910409, 1)
  cast_missile3(hero, hero, nil, nil, 61710910410, 1)
  self.atkTime = get_npc_time(hero) + self.atkCD
end

function M:holyBladeB1Atk()
  if self.atkB1Time > get_npc_time(hero) or not check_magic(hero, 61710221) then
    return
  end
  if check_magic(hero, rogueMgr.baojun) and "B2" == fangcheng_jindu then
    cast_missile3(hero, hero, nil, nil, 61710910416, 1)
    self.atkB1Time = get_npc_time(hero) + self.atkB1CD - self.atkB2_ResetCD
  elseif not check_magic(hero, rogueMgr.baojun) then
    cast_missile3(hero, hero, nil, nil, 61710910415, 1)
    self.atkB1Time = get_npc_time(hero) + self.atkB1CD
  end
end

function M:after_damage_Default(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if target ~= hero and npc ~= hero then
    return
  end
  if target == hero then
    self:castholyBlade()
  end
  if npc == hero and is_crit and 61710222 ~= magic_id and 61710223 ~= magic_id and 61710224 ~= magic_id and 61710225 ~= magic_id then
    local hp_cur = get_npc_attr(hero, 1)
    local hp_max = get_npc_attr(hero, 4)
    local hp_per = math.ceil(hp_cur / hp_max * 100)
    if hp_per <= 20 then
      self:castholyBlade()
    end
  end
end

function M:after_damage_A1(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  self:after_damage_Default(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if npc ~= self.npc then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  local kind_num = get_magic_kind_num(self.npc, 61710)
  if kind_num > 0 and (61710222 == magic_id or 61710223 == magic_id) then
    local per1, per2 = tool:randByTime(0.1, 0.66)
    if per2 then
      cast_magic(hero, hero, 61710011, 0)
    end
  end
  if not skAct then
    return
  end
  if skAct:deemAtk() and check_magic(hero, 61710221) then
    self.atkNum = self.atkNum + 1
    if 5 == self.atkNum then
      self:holyBladeAtk()
      if kind_num > 0 and "A2" == fangcheng_jindu then
        self:holyBladeAtk()
      end
      self.atkNum = 0
    end
  end
end

function M:after_damage_B1(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  self:after_damage_Default(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if npc ~= self.npc then
    return
  end
  if is_crit and 61710222 ~= magic_id and 61710223 ~= magic_id and 61710224 ~= magic_id and 61710225 ~= magic_id then
    self:holyBladeB1Atk()
  end
end

function M:after_damage_B2(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  self:after_damage_B1(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if npc ~= self.npc then
    return
  end
  local target_hpMax = get_npc_attr(target, 4)
  local damage_per = math.abs(damage_val / target_hpMax)
  if damage_per >= 0.05 and 61710222 ~= magic_id and 61710224 ~= magic_id and 61710225 ~= magic_id then
    cast_magic(hero, hero, 61710221, 0)
    self.atkTime = get_npc_time(hero)
  end
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg)
  if "A2" ~= fangcheng_jindu then
    return
  end
  if missile_cfg.Id == lazer_mis[1] or missile_cfg.Id == lazer_mis[2] or missile_cfg.Id == lazer_mis[3] or missile_cfg.Id == lazer_mis[4] then
    cast_magic(hero, hero, 61710221, 0)
    self.atkTime = get_npc_time(hero)
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc ~= self.npc then
    return
  end
  if true == is_showup then
    hero = get_come_on_hero()
  end
end

function M:on_frame()
  if "A1" ~= fangcheng_jindu and "A2" ~= fangcheng_jindu then
    self:holyBladeAtk()
  end
end

return M
