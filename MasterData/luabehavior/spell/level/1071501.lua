local monster = Util.create_class()

function monster._init(monster, npc)
end

function monster.on_npc_born(monster, npc)
  if npc ~= monster.npc then
    return
  end
  local monster = monster.npc:get_behavior()
  if not monster then
    Util.debug_output("monster is lost")
    return
  end
  monster.search.minDis = 2
  monster.search.maxDis = 2
end

return monster
