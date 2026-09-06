local TrapManager = {}
local TrapTypes = {
  [1] = require("logic.scene.trap.traps.elevator"),
  [2] = require("logic.scene.trap.traps.groundthorn"),
  [3] = require("logic.scene.trap.traps.flamethrower"),
  [4] = require("logic.scene.trap.traps.raycast")
}
local _traps = {}

function TrapManager.Init()
  _traps = {}
end

function TrapManager.UnInit()
  for _, v in pairs(_traps) do
    for _, t in pairs(v) do
      t:Destroy()
    end
  end
  _traps = {}
end

function TrapManager.OnUpdate(deltaTime)
  for _, i in pairs(_traps) do
    for _, v in pairs(i) do
      v:OnUpdate(deltaTime)
    end
  end
end

local _cached_finder

function TrapManager.CreateTrap(type, instanceid, id, path, initialstate, preservestate)
  assert(TrapTypes[type], string.format("unknown trap type %d at (%d, %d)", type, instanceid, id))
  assert(_cached_finder, "controller not init")
  local switch = TrapTypes[type].Create(instanceid, id, _cached_finder(path), initialstate, preservestate)
  return switch
end

function TrapManager.AddTrap(trap)
  _traps[trap:GetInstanceID()] = _traps[trap:GetInstanceID()] or {}
  _traps[trap:GetInstanceID()][trap:GetID()] = trap
end

function TrapManager.GetTrap(instanceid, id)
  if not _traps[instanceid] then
    return
  end
  return _traps[instanceid][id]
end

function TrapManager.RemoveTrap(instanceid, id)
  _traps[instanceid][id]:Destroy()
  _traps[instanceid][id] = nil
end

function TrapManager.OnSceneLoaded(sceneid)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  sceneid = sceneid or controller:GetSceneID()
  local traps = controller:GetObjects()
  
  function _cached_finder(path)
    if not traps[tonumber(path)] then
      LogError("trap", "trap " .. path .. " not found")
    end
    return traps[tonumber(path)].object
  end
end

function TrapManager.ToNextState(instanceid, id)
  return _traps[instanceid][id]:ToNextState()
end

function TrapManager.CheckState(id)
  for _, v in pairs(_traps) do
    if v:GetID() == id then
      return v:CheckState()
    end
  end
end

function TrapManager.RestoreState(states)
  local list = EffectFactory.CreateEffectList()
  for instanceid, inst in pairs(_traps) do
    local keys = table.keys(inst)
    table.sort(keys)
    for _, id in ipairs(keys) do
      local trap = inst[id]
      local state
      if states[instanceid] and states[instanceid][id] and trap:ShouldSaveState() then
        state = states[instanceid][id].state
      else
        state = trap:GetState()
      end
      local future = trap:RestoreState(state)
      if future then
        future:SetParam("runoninit", true)
        list:AddEffect(future)
      end
    end
  end
  return list
end

return TrapManager
