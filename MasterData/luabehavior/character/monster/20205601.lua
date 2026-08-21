local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.8,
    maxDis = 5,
    minTime = 1.2,
    maxTime = 2.3,
    type = "walk"
  }
  monster.FlyTar = {}
  monster.doOnce = false
  local skills = {
    OneShot = {
      2020560101,
      5,
      2,
      2,
      6,
      -60,
      60,
      8
    },
    Fly_aim = {
      2020560102,
      18,
      10,
      3,
      10,
      -45,
      45,
      5
    },
    Fly_hit = {2020560103}
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.Fly_hit)
    _ENV.meleeAtk(_ENV.OneShot)
    _ENV.rangedAtk(_ENV.Fly_aim)
  end
  do
    local Fly_hit = monster.states.Fly_hit
    
    function Fly_hit.isReady(Fly_hit)
      if check_magic(monster.target, 201056011006) and monster.target.Fly_target == monster.npc then
        Fly_hit.hit_target = monster.target
        local pos = get_npc_pos(monster.target, "Bip001")
        if pos.y > 2.4 then
          return true
        end
      end
      return false
    end
    
    function Fly_hit.start(Fly_hit)
      local dis = get_npc_distance(monster.npc, 1, Fly_hit.hit_target, true)
      if dis > 4 or dis < 3.5 then
        cast_magic(monster.npc, monster.npc, 201056011001, 1)
        cast_magic(monster.npc, monster.npc, 201056011003, 1)
      end
      Fly_hit.pos = get_npc_pos(monster.target, "Bip001")
      Fly_hit.base.start(Fly_hit)
    end
  end
  do
    local wander = monster.states.wander
    
    function wander.tickTrans(wander)
      local monster = wander.monster
      local states = monster.states
      local Fly_hit = states.Fly_hit
      if not monster.target then
        return states.noTarget
      end
      if Fly_hit.isReady(Fly_hit) then
        return Fly_hit
      end
      if states.attack then
        return monster.tree:chooseChildAction(states.attack)
      end
    end
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  monster.base.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  if 201056010202 == magic_id then
    local Hero_angle = get_target_angel(monster.StonMis, monster.target, true)
    if Hero_angle > 55 or Hero_angle < -55 then
      cast_magic(monster.npc, monster.npc, 201056011001, 1)
      cast_magic(monster.npc, monster.npc, 201056011003, 1)
    end
  end
  if 201056010101 == magic_id or 201056010102 == magic_id or 201056010103 == magic_id then
    local num = magic_id - 201056010101
    local SelfPos = get_npc_pos(monster.npc)
    local BornPos = get_npc_pos(monster.npc, "muzzle")
    local AtkPos
    local ratio = 1
    if get_npc_distance(monster.npc, 1, monster.target, false) < 6 then
      ratio = get_npc_distance(monster.npc, 1, monster.target, false) / 2
    else
      ratio = 3
    end
    if 0 == num then
      AtkPos = get_npc_offset_position(monster.target, SelfPos, 60 / ratio, ratio)
      cast_missile3(monster.npc, monster.target, AtkPos.x, AtkPos.z, 201056010101, 1, nil, nil, nil, nil, BornPos.x, BornPos.z, BornPos.y)
    elseif 1 == num then
      AtkPos = get_npc_offset_position(monster.target, SelfPos, -60 / ratio, ratio)
      cast_missile3(monster.npc, monster.target, AtkPos.x, AtkPos.z, 201056010101, 1, nil, nil, nil, nil, BornPos.x, BornPos.z, BornPos.y)
    elseif 2 == num then
      AtkPos = get_npc_pos(monster.target)
      cast_missile3(monster.npc, monster.target, AtkPos.x, AtkPos.z, 201056010105, 1, nil, nil, nil, nil, BornPos.x, BornPos.z, BornPos.y)
    end
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  monster.base.on_self_magic_end(monster, target, magic_id)
  if 201056011001 == magic_id and monster.states.Fly_hit:isRunning() then
    local condition = false
    local pos
    if monster.states.Fly_hit.hit_target then
      while not condition do
        pos = get_npc_offset_position(monster.states.Fly_hit.hit_target, get_npc_pos(monster.npc), 360 * math.random(), 6)
        local Isflashpos = get_nearest_walkable_pos(get_npc_pos(monster.npc), pos, 1)
        if true == Isflashpos then
          condition = true
        end
      end
      flash_to_pos(monster.npc, pos.x, pos.z)
      lookat_npc(monster.npc, monster.states.Fly_hit.hit_target, true)
    end
  end
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile, is_break)
  local missile_map = {
    [202056010509] = 202056010512,
    [202056010510] = 202056010513,
    [202056010511] = 202056010514
  }
  local key = missile_map[missile_cfg.Id]
  if key then
    remove_missile_by_id(key, monster.npc)
  end
end

function monster.after_damage_target(monster, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local valid_skill_ids = {
    [2020560102] = true
  }
  local valid_missile_ids = {
    [202056010208] = true
  }
  if not valid_skill_ids[skill_id] then
    return
  end
  if missile.missile_cfg.Id and valid_missile_ids[missile.missile_cfg.Id] then
    monster:doAfter(function()
      if check_npc_status(target, 10) then
        cast_magic(monster.npc, target, 201056011006, 1)
        monster.target.Fly_target = monster.npc
      end
    end, 0.1)
  end
end

function monster.on_keyframe_action(monster, kfId, npcTag, comnTag)
  if 202056010301 == kfId then
    local BornPos = get_npc_pos(monster.npc, "muzzle")
    local pos = monster.states.Fly_hit.pos
    cast_missile3(monster.npc, nil, pos.x, pos.z, 202056010302, 1, nil, nil, nil, pos.y, BornPos.x, BornPos.z, BornPos.y)
  end
  if 202056010205 == kfId and monster.target then
    local posA = get_npc_offset_position(monster.target, get_npc_pos(monster.npc), 0 + 120 * math.random(), 0.5 + 2 * math.random())
    local posC = get_npc_offset_position(monster.target, get_npc_pos(monster.npc), 240 + 120 * math.random(), 0.5 + 2 * math.random())
    cast_missile3(monster.npc, nil, posA.x, posA.z, 202056010209, 1)
    cast_missile3(monster.npc, nil, posA.x, posA.z, 202056010212, 1)
  end
  if 202056010105 == kfId and monster.target then
    local BornPos = get_npc_pos(monster.npc, "muzzle")
    local AtkPos
    AtkPos = get_npc_pos(monster.target)
    cast_missile3(monster.npc, monster.target, AtkPos.x, AtkPos.z, 202056010101, 1, nil, nil, nil, nil, BornPos.x, BornPos.z, BornPos.y)
  end
end

return monster
