local monster = Util.create_class()

function monster:_init()
end

function monster:on_frame()
  if get_sync_var("trigger") then
    return
  end
  local player = get_come_on_hero()
  local role = player:get_behavior()
  if not role.target then
    return
  end
  monster.isInBattle = role:isInBattle()
  if monster.isInBattle and role.target ~= nil and 5 ~= role.target.v_kind and 6 ~= role.target.v_kind then
    set_sync_var("isInBattle", true)
  else
    set_sync_var("isInBattle", false)
  end
end

function monster:on_room_change(npc)
  set_sync_var("trigger", false)
end

return monster
