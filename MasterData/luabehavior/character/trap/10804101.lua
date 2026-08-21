local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local monster = Util.create_class()

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 399931, 1)
  cast_magic(npc, npc, 399932, 1)
  set_npc_status(npc, 4, true)
  cast_magic(npc, npc, 1080420101, 1)
  monster.MID = 0
  if get_npc_id(monster.npc) == 10804101 then
    monster.MID = 108041010101
  end
  if get_npc_id(monster.npc) == 10804102 then
    monster.MID = 108042010101
  end
  monster.eMID = 0
  if get_npc_id(monster.npc) == 10804101 then
    monster.eMID = 108041010102
  end
  if get_npc_id(monster.npc) == 10804102 then
    monster.eMID = 108042010102
  end
  cast_missile_new(monster.npc, monster.npc, nil, nil, monster.MID, 1)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, monster.MID, monster.playerHiding, monster)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, monster.npc, monster.MID, monster.playerLeft, monster)
end

function monster.playerHiding(monster, owner, target_npc, missile_cfg, missile)
  if owner == monster.npc and target_npc == get_come_on_hero() then
    print("玩家进入圈子")
    cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410801, 1, 1)
    cast_magic(monster.npc, monster.npc, monster.eMID, 1, 1)
    abort_magic_by_id(get_come_on_hero(), 1080410201, 5)
    if 1 == get_magic_num(get_come_on_hero(), 1080410801) then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 1080402, 1, 1)
      abort_magic_by_id(get_come_on_hero(), 1080410202, 1)
      cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410501, 1)
      print("进入安全区")
    end
  end
end

function monster.playerLeft(monster, owner, target_npc, missile_cfg, missile)
  if owner == monster.npc and target_npc == get_come_on_hero() then
    print("玩家走出圈子")
    abort_magic_by_id(get_come_on_hero(), 1080410801, 1)
    abort_magic_by_id(monster.npc, monster.eMID)
    if get_magic_num(get_come_on_hero(), 1080410801) < 1 then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410301, 1)
      abort_magic_by_id(get_come_on_hero(), 1080410501, 1)
      abort_magic_by_id(get_come_on_hero(), 1080402, 1)
      print("离开安全区")
    end
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 1 == get_role_kind(hit_target) and missile_cfg.Id == monster.MID then
    cast_magic(monster.npc, get_come_on_hero(), 1080410101, 1, 2)
  end
end

function monster.on_frame(monster)
  if get_sync_var("gameOver") then
    cast_magic(monster.npc, monster.npc, 1080410701, 1, 1)
  else
    abort_magic_by_id(monster.npc, 1080410701, 1)
  end
end

function monster.on_self_magic_begin(target, magic_id, magic_level, magic_kind, magic_type)
  if 1080410701 == magic_id then
    remove_missile_by_id(monster.MID, monster.npc, false)
    abort_magic_by_id(monster.npc, monster.eMID)
  end
end

function monster.on_self_magic_end(target, magic_id, magic_level, magic_kind, magic_type)
  if 1080410701 == magic_id then
    cast_missile_new(monster.npc, monster.npc, nil, nil, monster.MID, 1)
  end
end

function monster.on_self_npc_removed(monster)
  remove_missile_by_id(monster.MID, monster.npc, false)
  abort_magic_by_id(monster.npc, monster.eMID)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, monster.MID, monster.npc)
end

return monster
