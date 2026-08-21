local M = Util.create_class()
local rogueMgr = import("common.rogueManager")
local tool = import("common.tool")
local cd = 10

function M:_init(npc)
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  local hero = get_come_on_hero()
  if missile_cfg.Id == 61709920201 then
    local fxmis = get_missile_skill_action_info(missile)
    fxmis.dotmis = missile
  end
  if missile_cfg.Id == 61709910101 then
    cast_missile3(hero, nil, pos_x, pos_z, 61709920201, 1, nil, nil, missile)
    if rogueMgr.dot_friend then
      cast_missile3(hero, nil, pos_x, pos_z, 61709920202)
    end
    if rogueMgr.defence_decrease then
      cast_missile3(hero, nil, pos_x, pos_z, 61709920203)
    end
    if rogueMgr.water_level_skill then
      cast_missile3(hero, nil, pos_x, pos_z, 61709920204)
    end
  end
  if missile_cfg.Id == 61709910301 then
    cast_missile3(hero, hero, nil, nil, 61709920401)
    if rogueMgr.dot_friend then
      cast_missile3(hero, hero, nil, nil, 61709920402)
    end
    if rogueMgr.defence_decrease then
      cast_missile3(hero, hero, nil, nil, 61709920403)
    end
    if rogueMgr.water_level_skill then
      cast_missile3(hero, hero, nil, nil, 61709920404)
    end
  end
end

function M:on_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  if rogueMgr.dead_add_water then
    if not self.curr_time_dead_add_water then
      self.curr_time_dead_add_water = 0
    end
    if get_npc_time(self.npc) > self.curr_time_dead_add_water + cd and (2 == get_role_kind(npc) or 3 == get_role_kind(npc)) then
      local pos = {}
      pos = get_npc_pos(npc)
      self.curr_time_dead_add_water = get_npc_time(self.npc)
      cast_missile3(get_come_on_hero(), nil, pos.x, pos.z, 61709910101)
    end
  end
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if rogueMgr.element_add_water then
    self.curr_time_element_add_water = self.curr_time_element_add_water or 0
    if get_npc_time(self.npc) > self.curr_time_element_add_water + cd then
      local pos = {}
      pos = get_npc_pos(npc)
      cast_missile3(get_come_on_hero(), nil, pos.x, pos.z, 61709910101)
      self.curr_time_element_add_water = get_npc_time(self.npc)
    end
  end
end

return M
