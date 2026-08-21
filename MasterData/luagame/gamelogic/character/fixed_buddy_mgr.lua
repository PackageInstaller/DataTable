local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
  self:reset_data()
end

function M:on_reconnect()
  self:reset_data()
end

function M:reset_data()
  self.v_fake_buddy_map = {}
  self.v_fake_equip_map = {}
  self.v_cache_fixed_id = {}
  self.v_cache_fight_val = {}
end

function M:set_cache_fixed_data(buddy_id, fixed_id)
  self.v_cache_fixed_id[buddy_id] = fixed_id
end

function M:get_cache_fixed_data(buddy_id)
  return self.v_cache_fixed_id[buddy_id]
end

function M:clear_cache_data()
  self.v_cache_fixed_id = {}
end

function M:get_fixed_buddy_info(fixed_id)
  local fixed_buddy_cfg = ShareRes.get_fixed_buddy_config(fixed_id)
  if not fixed_buddy_cfg then
    Log.Error("ERROR FIXED BUDDY CFG = ", fixed_id, debug.traceback())
    return
  end
  self:creat_fake_buddy_data(fixed_buddy_cfg)
  local buddy_id = fixed_buddy_cfg.BuddyId
  return self.v_fake_buddy_map[fixed_id][buddy_id]
end

function M:get_buddy_equip_id_by_fixed_id(fixed_id)
  local buddy_info = self:get_fixed_buddy_info(fixed_id)
  if not buddy_info then
    return
  end
  return buddy_info.weapon
end

function M:get_equip_id_by_buddy_id(buddy_id)
  local fixed_id = self:get_cache_fixed_data(buddy_id)
  if not fixed_id then
    return
  end
  local weapon_id = self:get_buddy_equip_id_by_fixed_id(fixed_id)
  return weapon_id
end

function M:get_fashion_id(fixed_id)
  local buddy_info = self:get_fixed_buddy_info(fixed_id)
  if buddy_info then
    return buddy_info.fashion
  end
end

function M:get_fashion_model_id(fixed_id)
  local buddy_info = self:get_fixed_buddy_info(fixed_id)
  if not buddy_info then
    return
  end
  return FashionMgr:get_fashion_model_id_by_fashion_id(buddy_info.fashion)
end

function M:get_fixed_equip_info(fixed_id)
  local fixed_buddy_cfg = ShareRes.get_fixed_buddy_config(fixed_id)
  if not fixed_buddy_cfg then
    Log.Error("ERROR FIXED BUDDY CFG = ", fixed_id, debug.traceback())
    return
  end
  self:creat_fake_equip_data(fixed_buddy_cfg)
  local equip_id = fixed_buddy_cfg.EquipId
  return self.v_fake_equip_map[fixed_id][equip_id]
end

function M:creat_fake_buddy_data(fake_cfg)
  self.v_fake_buddy_map[fake_cfg.Id] = self.v_fake_buddy_map[fake_cfg.Id] or {}
  local buddy_id = fake_cfg.BuddyId
  if self.v_fake_buddy_map[fake_cfg.Id][buddy_id] then
    return
  end
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local buddy_data = {
    id = buddy_id,
    lv = fake_cfg.Lv,
    break_lv = fake_cfg.BreakLv,
    talent_lv = fake_cfg.TalentLv,
    advance = fake_cfg.AdvanceLv,
    fashion = fake_cfg.FashionId or buddy_cfg.FashionInitId,
    weapon = fake_cfg.EquipId,
    power = fake_cfg.Power,
    equip_fashion = fake_cfg.WeaponFashionId,
    lSkill = {},
    equip_data = self:get_fixed_equip_info(fake_cfg.Id),
    puzzle_graph = {}
  }
  local out_skill_list = {}
  for key, out_id in pairs(fake_cfg.OutSkillMask) do
    out_skill_list[out_id] = true
  end
  local skill_list = {}
  local skill_cfg = ShareRes.get_buddy_skill_list_cfg(buddy_id)
  self:finishing_skill(true, skill_cfg, skill_list, fake_cfg.OutSkillLv, out_skill_list)
  buddy_data.lSkill = skill_list
  self:finishing_puzzle(buddy_data.puzzle_graph, fake_cfg)
  self.v_fake_buddy_map[fake_cfg.Id][buddy_id] = buddy_data
end

function M:creat_fake_equip_data(fake_cfg)
  self.v_fake_equip_map[fake_cfg.Id] = self.v_fake_equip_map[fake_cfg.Id] or {}
  local equip_id = fake_cfg.EquipId
  if self.v_fake_equip_map[fake_cfg.Id][equip_id] then
    return
  end
  local weapon_data = {
    id = equip_id,
    lv = fake_cfg.EquipLv,
    break_lv = fake_cfg.EquipBreakLv,
    advance = fake_cfg.EquipAdvanceLv,
    advance_lv = fake_cfg.EquipAdvanceLv,
    gemstone_list = fake_cfg.Gemstone
  }
  self.v_fake_equip_map[fake_cfg.Id][equip_id] = weapon_data
end

function M:finishing_puzzle(data, fake_cfg)
  if not fake_cfg then
    return
  end
  local puzzle_list = fake_cfg.PuzzleId
  if not puzzle_list or not next(puzzle_list) then
    return
  end
  data.puzzle_place_infos = {}
  for idx, puzzle_id in ipairs(puzzle_list) do
    if 0 ~= puzzle_id then
      local tab = {
        id = puzzle_id,
        quality = fake_cfg.PuzzleQuality[idx],
        attr_list = fake_cfg.AttrList and fake_cfg.AttrList[idx]
      }
      _tinsert(data.puzzle_place_infos, tab)
    end
  end
end

function M:finishing_skill(is_cfg, really_data, new_list, skill_lv, out_skill_list)
  if not is_cfg then
    for _, data in ipairs(really_data) do
      if not out_skill_list[data.id] then
        local insert_data = {
          id = data.id,
          lv = data.lv
        }
        _tinsert(new_list, insert_data)
      end
    end
  else
    for _, skill_id in ipairs(really_data.Skill) do
      if not out_skill_list[skill_id] then
        local insert_data = {
          id = skill_id,
          lv = skill_lv or 1
        }
        _tinsert(new_list, insert_data)
      end
    end
  end
end

function M:get_fixed_fight_val(fixed_id)
  local cache_val = self.v_cache_fight_val[fixed_id]
  if cache_val then
    return cache_val
  end
  local buddy_info = self:get_fixed_buddy_info(fixed_id)
  if not buddy_info then
    return
  end
  local buddy_id = buddy_info.id
  local fight_val = CharacterMgr:get_buddy_combat_effectiveness(buddy_id, true, fixed_id, true)
  self.v_cache_fight_val[fixed_id] = fight_val
  return fight_val
end

function M:set_temp_floor_buddy_list(buddy_list)
  self.v_temp_floor_buddy_list = buddy_list
end

function M:get_temp_floor_buddy_list()
  return self.v_temp_floor_buddy_list
end

function M:check_is_not_robat(hero_id)
  local battle_team_info = TowerMgr and TowerMgr:get_battle_team_info()
  if not battle_team_info or not battle_team_info.hero_list then
    return false
  end
  for key, hero_data in pairs(battle_team_info.hero_list) do
    if hero_data.data.id == hero_id and 0 == hero_data.type then
      return true
    end
  end
  return false
end

function M:get_gm_fight_or_client_only_buddy_info(buddy_id, use_default)
  local fixed_id = DebugSetting:get_fixed_buddy_by_role_id(buddy_id)
  if not fixed_id then
    if use_default then
      return self:get_simple_buddy_info(buddy_id)
    end
    return nil
  end
  local buddy_info = self:get_fixed_buddy_info(fixed_id)
  return buddy_info
end

function M:get_simple_buddy_info(buddy_id)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local weapon_data = {
    id = buddy_cfg.WeaponInitId,
    lv = 1,
    break_lv = 1,
    advance = 1,
    advance_lv = 1
  }
  local buddy_data = {
    id = buddy_id,
    lv = 1,
    break_lv = 1,
    talent_lv = 0,
    advance = 1,
    fashion = buddy_cfg.FashionInitId,
    weapon = buddy_cfg.WeaponInitId,
    lSkill = {},
    equip_data = weapon_data,
    puzzle_graph = {}
  }
  return buddy_data
end

return M
