local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local shiyanzhiqiang = 61711910405
local shiyanzhiqiang_magic = 61711012
local caijuezhiqiang = 61711910406

function M:on_start()
  self:update_fangcheng_jindu()
end

function M:on_room_change(npc)
  self:update_fangcheng_jindu()
end

function M:after_damage_default(npc, target, magic_id, damage_sign)
  local hero = get_come_on_hero()
  if target ~= hero then
    return
  end
  if get_npc_time(self.npc) > self.init_time + self.cd then
    local curr_hp = get_npc_attr(hero, 1)
    local max_hp = get_npc_attr(hero, 4)
    if curr_hp / max_hp < 0.3 then
      cast_missile3(hero, npc, nil, nil, shiyanzhiqiang)
      self.init_time = get_npc_time(self.npc)
      self.cd = 40
    end
  end
  if npc == hero then
    return
  end
  if check_magic(target, shiyanzhiqiang_magic) then
    cast_missile3(hero, npc, nil, nil, caijuezhiqiang)
  end
end

function M:after_damage_A1(npc, target, magic_id, damage_sign)
  self.after_damage_default(self, npc, target, magic_id, damage_sign)
  if 61711013 == magic_id and (check_element_ab_state(target, 5) or check_element_ab_state(target, 6)) then
    local hero = get_come_on_hero()
    cast_missile3(hero, npc, nil, nil, 61711910407)
  end
end

function M:_init(npc)
  self.npc = get_god_npc()
  self.init_time = get_npc_time(self.npc)
  self.cd = 0
  self.A2_init_time = get_npc_time(self.npc)
  self.A2_cd = 0
end

function M:on_missile_end_pos_A2(owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == shiyanzhiqiang and get_magic_num(get_come_on_hero(), rogueMgr.shoushi) >= 20 then
    self.cd = 0
  end
end

function M:on_magic_begin_A2(npc, target, magic_id, magic_level, magic_kind, magic_type)
  if target ~= get_come_on_hero() then
    return
  end
  if get_npc_time(self.npc) > self.A2_init_time + self.A2_cd and magic_id == shiyanzhiqiang_magic then
    local bool, num = tool:checkMagicToTeam(61711015)
    if 0 == num then
      cast_magic(target, target, 61711015)
      self.A2_init_time = get_npc_time(self.npc)
      self.A2_cd = 5
    end
  end
end

function M:after_shield_B1(npc, target, magic_id, shield_value)
  local hero = get_come_on_hero()
  local hero1 = get_scene_hero_by_poskey(21)
  local hero2 = get_scene_hero_by_poskey(22)
  if (target == hero1 or target == hero or target == hero2) and get_magic_num(target, 61710011) < 4 then
    cast_magic(target, target, 61710011)
  end
end

function M:on_magic_begin_B1(npc, target, magic_id, magic_level, magic_kind, magic_type)
  if npc ~= get_come_on_hero() then
    return
  end
  if magic_id == rogueMgr.fanji and check_magic(npc, shiyanzhiqiang_magic) and get_magic_kind_num(npc, 61710) > 0 and math.random(0, 1) < 0.15 and get_magic_num(target, 61710011) < 4 then
    cast_magic(target, target, 61710011)
  end
end

function M:on_magic_begin_B2(npc, target, magic_id, magic_level, magic_kind, magic_type)
  self:on_magic_begin_B1(npc, target, magic_id, magic_level, magic_kind, magic_type)
  if magic_id == rogueMgr.fanji then
    cast_magic(npc, target, 61711016)
  end
end

function M:on_toughness_change_B2(npc, camp, change_level, enter_stun)
  if enter_stun then
    local hero = get_come_on_hero()
    if get_magic_kind_num(hero, 61710) > 0 then
      for i = 1, 2 do
        if get_magic_num(hero, 61710011) < 4 then
          cast_magic(hero, hero, 61710011)
        end
      end
    else
      cast_magic(hero, hero, 61710022)
    end
  end
end

function M:update_fangcheng_jindu()
  self.after_damage = self.after_damage_default
  local branch_id, branch_level = get_equation_branch_info(16)
  if branch_id and branch_level then
    if 1601 == branch_id and 1 == branch_level then
      self.after_damage = self.after_damage_A1
    elseif 1601 == branch_id and 2 == branch_level then
      self.after_damage = self.after_damage_A1
      self.on_missile_end_pos = self.on_missile_end_pos_A2
      self.on_magic_begin = self.on_magic_begin_A2
    elseif 1602 == branch_id and 1 == branch_level then
      self.after_shield = self.after_shield_B1
      self.on_magic_begin = self.on_magic_begin_B1
    elseif 1602 == branch_id and 2 == branch_level then
      self.on_magic_begin = self.on_magic_begin_B2
      self.on_toughness_change = self.on_toughness_change_B2
    end
  end
end

function M:on_magic_end(npc, target, magic_id, magic_kind, magic_type, magic_type, is_break)
  if magic_id == rogueMgr.shengguang and get_npc_time(self.npc) > self.init_time + self.cd then
    local hero = get_come_on_hero()
    cast_missile3(hero, hero, nil, nil, shiyanzhiqiang)
    self.init_time = get_npc_time(self.npc)
    self.cd = 40
  end
end

return M
