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
    TripleShot = {
      2010560101,
      10,
      2,
      2,
      6,
      -60,
      60,
      8
    },
    StoneShot = {
      2010560102,
      20,
      15,
      1,
      5,
      -45,
      45
    },
    DashShot = {
      2010560103,
      10,
      2,
      0,
      2,
      -45,
      45
    },
    Sniping = {
      2010560104,
      30,
      20,
      2,
      8,
      -60,
      60
    },
    Fly_aim = {
      2010560105,
      18,
      10,
      3,
      10,
      -45,
      45,
      5
    },
    Fly_hit = {2010560107},
    Gravity = {
      2010560108,
      10,
      5,
      0,
      6,
      -60,
      60
    },
    evade_dash = {
      2010560103,
      10,
      2,
      0,
      2,
      -45,
      45
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.Fly_hit, _ENV.DashShot)
    _ENV.meleeAtk(_ENV.Gravity, _ENV.TripleShot)
    _ENV.rangedAtk(_ENV.Fly_aim, _ENV.Sniping, _ENV.StoneShot)
    _ENV.freeCounter(_ENV.evade_dash)
  end
  do
    local DashShot = monster.states.DashShot
    local TripleShot = monster.states.TripleShot
    
    function TripleShot.tick(TripleShot)
      if check_magic(monster.npc, 201056010104) and check_npc_distance(monster.npc, monster.target, 2, true) then
        monster:transState(monster.states.DashShot, true)
      end
    end
    
    function DashShot.start(DashShot)
      lookat_npc(monster.npc, monster.target, true)
      DashShot.base.start(DashShot)
    end
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
    local Gravit = monster.states.Gravity
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
    
    function Gravit.tickTrans(Gravit)
      local Fly_hit = Gravit.monster.states.Fly_hit
      if Fly_hit.isReady(Fly_hit) then
        return Fly_hit
      end
    end
  end
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  monster.base.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201056010201 then
    monster.StonMis = missile
    monster.StonMis_cfg = missile_cfg
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
  if 201056011001 == magic_id then
    if monster.states.StoneShot:isRunning() then
      monster.states.StoneShot.hit_target = monster.target
      cast_magic(monster.npc, monster.npc, 201056011002, 1)
      local StonPos = monster.StonMis.v_position
      local Length = monster.StonMis_cfg.SizeX
      local Hero_pos = get_npc_pos(get_come_on_hero())
      local FlashPos = get_position_offset_position(StonPos, Hero_pos, 180, Length)
      flash_to_pos(monster.npc, FlashPos.x, FlashPos.z)
      lookat_npc(monster.npc, monster.target, true)
    elseif monster.states.Fly_hit:isRunning() then
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
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile, is_break)
  local missile_map = {
    [201056010509] = 201056010512,
    [201056010510] = 201056010513,
    [201056010511] = 201056010514
  }
  local key = missile_map[missile_cfg.Id]
  if key then
    remove_missile_by_id(key, monster.npc)
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function monster.after_damage_target(monster, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local valid_skill_ids = {
    [2010560105] = true,
    [2010560108] = true
  }
  local valid_missile_ids = {
    [201056010508] = true,
    [201056010805] = true
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
  if 201056010401 == kfId then
    local BornPos = get_npc_pos(monster.npc, "muzzle")
    cast_missile3(monster.npc, monster.target, nil, nil, 201056010402, 1, nil, nil, nil, nil, BornPos.x, BornPos.z, BornPos.y)
  end
  if 201056010701 == kfId then
    local BornPos = get_npc_pos(monster.npc, "muzzle")
    local pos = monster.states.Fly_hit.pos
    cast_missile3(monster.npc, nil, pos.x, pos.z, 201056010702, 1, nil, nil, nil, pos.y, BornPos.x, BornPos.z, BornPos.y)
  end
  if 201056010505 == kfId and monster.target then
    local posA = get_npc_offset_position(monster.target, get_npc_pos(monster.npc), 0 + 120 * math.random(), 2.5 + 2 * math.random())
    local posB = get_npc_offset_position(monster.target, get_npc_pos(monster.npc), 120 + 120 * math.random(), 2.5 + 2 * math.random())
    local posC = get_npc_offset_position(monster.target, get_npc_pos(monster.npc), 240 + 120 * math.random(), 2.5 + 2 * math.random())
    cast_missile3(monster.npc, nil, posA.x, posA.z, 201056010509, 1)
    cast_missile3(monster.npc, nil, posB.x, posB.z, 201056010510, 1)
    cast_missile3(monster.npc, nil, posC.x, posC.z, 201056010511, 1)
    cast_missile3(monster.npc, nil, posA.x, posA.z, 201056010512, 1)
    cast_missile3(monster.npc, nil, posB.x, posB.z, 201056010513, 1)
    cast_missile3(monster.npc, nil, posC.x, posC.z, 201056010514, 1)
  end
end

function monster.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  monster.base.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if monster.doOnce then
    return
  end
  local curr_hp = get_npc_attr(monster.npc, 1)
  local max_hp = get_npc_attr(monster.npc, 4)
  local hp_per = curr_hp / max_hp
  if hp_per <= 0.5 and 0 ~= curr_hp then
    cast_magic(monster.npc, monster.npc, 20105501012)
    cast_magic(monster.npc, monster.npc, 201056011013)
    cast_magic(monster.npc, monster.npc, 20105501014)
    cast_magic(monster.npc, monster.npc, 20105501308)
    cast_magic(monster.npc, monster.npc, 20105501311)
    monster.doOnce = true
  end
end

return monster
