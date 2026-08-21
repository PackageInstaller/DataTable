local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    TrebleHit = {
      2010550101,
      17,
      0,
      0,
      6,
      -60,
      60
    },
    Before_hack = {
      2010550102,
      13,
      20,
      0,
      5,
      -60,
      60
    },
    Before_stab = {
      2010550103,
      14,
      0,
      0,
      5,
      -90,
      90
    },
    FarAttack = {
      2010550104,
      12,
      0,
      6,
      10,
      -60,
      60
    },
    JumpAttack = {
      2010550105,
      12,
      10,
      3,
      8,
      -60,
      60
    },
    Gravity = {
      2010550106,
      30,
      20,
      0,
      5,
      -180,
      180
    },
    Stab = {
      2010550107,
      20,
      0,
      0,
      5,
      -60,
      60
    },
    SpinningSlash = {
      2010550108,
      20,
      0,
      0,
      5,
      -60,
      60,
      nil,
      12
    },
    Stab2 = {
      2010550107,
      20,
      0,
      0,
      8,
      -60,
      60
    },
    SpinningSlash2 = {
      2010550108,
      20,
      0,
      0,
      10,
      -180,
      180
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.Gravity, _ENV.TrebleHit, _ENV.JumpAttack(_ENV.Stab2, _ENV.SpinningSlash2), _ENV.Before_hack(_ENV.Stab), _ENV.Before_stab(_ENV.SpinningSlash))
    _ENV.rangedAtk(_ENV.FarAttack)
  end
  local states = monster.states
end

function monster.after_damage_self(monster, caster, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  monster.base.after_damage_self(monster, caster, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if monster.doOnce then
    return
  end
  local curr_hp = get_npc_attr(monster.npc, 1)
  local max_hp = get_npc_attr(monster.npc, 4)
  local hp_per = curr_hp / max_hp
  if hp_per <= 0.5 then
    cast_magic(monster.npc, monster.npc, 20105501307)
    cast_magic(monster.npc, monster.npc, 20105501012)
    cast_magic(monster.npc, monster.npc, 20105501013)
    cast_magic(monster.npc, monster.npc, 20105501014)
    cast_magic(monster.npc, monster.npc, 20105501308)
    cast_magic(monster.npc, monster.npc, 20105501311)
    monster.doOnce = true
  end
end

function monster.after_abnormal_damage(monster, caster, attacker, npc, magic_id)
  if monster.doOnce then
    return
  end
  if npc ~= monster.npc then
    return
  end
  local curr_hp = get_npc_attr(monster.npc, 1)
  local max_hp = get_npc_attr(monster.npc, 4)
  local hp_per = curr_hp / max_hp
  if hp_per <= 0.5 then
    cast_magic(monster.npc, monster.npc, 20105501307)
    cast_magic(monster.npc, monster.npc, 20105501012)
    cast_magic(monster.npc, monster.npc, 20105501013)
    cast_magic(monster.npc, monster.npc, 20105501014)
    cast_magic(monster.npc, monster.npc, 20105501308)
    cast_magic(monster.npc, monster.npc, 20105501311)
    monster.doOnce = true
  end
end

function monster.on_self_skill_end(monster, skill_id, is_time_out, is_break)
  monster.base.on_self_skill_end(monster, skill_id, is_time_out, is_break)
  if is_break then
    cast_magic(monster.npc, monster.npc, 20105501002)
    cast_magic(monster.npc, monster.npc, 20105501004)
    cast_magic(monster.npc, monster.npc, 20105501006)
    if check_magic(monster.npc, 20105501015) then
      cast_magic(monster.npc, monster.npc, 20105501018)
      cast_magic(monster.npc, monster.npc, 20105501019)
      print("114")
    end
    if check_magic(monster.npc, 20105501008) then
      local function weapon()
        cast_magic(monster.npc, monster.npc, 20105501009)
      end
      
      monster:doAfter(weapon, 0.2)
    end
  end
end

return monster
