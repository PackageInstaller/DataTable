local M = Util.create_class()

function M:_init(npc)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 30010640101 or missile_cfg.Id == 201049010404 or missile_cfg.Id == 201049010402 or missile_cfg.Id == 30010690101 then
    if 1 == get_role_kind(hit_target) then
      if not check_magic(hit_target, 3001064009) then
        cast_magic(hit_target, hit_target, 3001064009)
        cast_magic(hit_target, hit_target, 3001064008)
      end
      cast_magic(hit_target, hit_target, 3001064002)
      cast_magic(hit_target, hit_target, 3001064003)
    elseif get_role_kind(hit_target) < 4 then
      if not check_magic(hit_target, 3001064014) then
        cast_magic(hit_target, hit_target, 3001064014)
      end
      cast_magic(hit_target, hit_target, 3001064011)
      cast_magic(hit_target, hit_target, 3001064012)
      cast_magic(hit_target, hit_target, 3001064013)
    end
  end
end

function M:on_magic_end(npc, target, magic_id, magic_kind, magic_type, magic_type, is_break)
  if 3001064003 == magic_id and target == get_come_on_hero() and not check_magic(target, 3001064003) then
    abort_magic_by_id(target, 3001064009)
    abort_magic_by_id(target, 3001064008)
  end
  if 3001064013 == magic_id and not check_magic(target, 3001064013) then
    abort_magic_by_id(target, 3001064014)
  end
end

return M
