local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local cargo_manager = import("character.trap.3001090_1")

function monster:_init(npc)
  self.npc = npc
  self.search = {}
  self.cargo_weight = 1
  self.cargo_value = 3
  local actSkills = {
    wait = {300109401},
    drop = {300109402}
  }
  local actMoves = {"out"}
  local nodes = {}
  monstBase._init(self, actSkills, actMoves, nodes)
  local states = self.states
  do
    local _ENV = states
    _ENV.root(_ENV.wait, _ENV.drop, _ENV.out, _ENV.decisionFailed)
  end
  
  function states.wait.start(wait)
    wait.base.start(wait)
  end
  
  states.drop.out = states.out
  
  function states.drop.finTrans(drop)
    return drop.out
  end
  
  function states.out.isReady()
    return true
  end
  
  function states.out.start(out)
    remove_npc(self.npc)
  end
end

function monster:on_self_skill_hit(skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  if 1 ~= get_role_kind(hit_target) then
    return
  end
  if cargo_manager.cargo_weight <= 5 - self.cargo_weight then
    cargo_manager:add_cargo(self.npc.id, self.cargo_weight, self.cargo_value)
    remove_npc(self.npc)
  else
    call_scene_logic_custom_event("OWtips")
  end
end

return monster
