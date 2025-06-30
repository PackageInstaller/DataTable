-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/trapmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TrapManager = {}
local TrapTypes = {[1] = require("logic.scene.trap.traps.elevator"), [2] = require("logic.scene.trap.traps.groundthorn"), [3] = require("logic.scene.trap.traps.flamethrower"), [4] = require("logic.scene.trap.traps.raycast")}
local _traps = {}
TrapManager.Init = function()
  -- function num : 0_0 , upvalues : _traps
  _traps = {}
end

TrapManager.UnInit = function()
  -- function num : 0_1 , upvalues : _ENV, _traps
  for _,v in pairs(_traps) do
    for _,t in pairs(v) do
      t:Destroy()
    end
  end
  _traps = {}
end

TrapManager.OnUpdate = function(deltaTime)
  -- function num : 0_2 , upvalues : _ENV, _traps
  for _,i in pairs(_traps) do
    for _,v in pairs(i) do
      v:OnUpdate(deltaTime)
    end
  end
end

local _cached_finder = nil
TrapManager.CreateTrap = function(type, instanceid, id, path, initialstate, preservestate)
  -- function num : 0_3 , upvalues : _ENV, TrapTypes, _cached_finder
  assert(TrapTypes[type], (string.format)("unknown trap type %d at (%d, %d)", type, instanceid, id))
  assert(_cached_finder, "controller not init")
  local switch = ((TrapTypes[type]).Create)(instanceid, id, _cached_finder(path), initialstate, preservestate)
  return switch
end

TrapManager.AddTrap = function(trap)
  -- function num : 0_4 , upvalues : _traps
  if not _traps[trap:GetInstanceID()] then
    _traps[trap:GetInstanceID()] = {}
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (_traps[trap:GetInstanceID()])[trap:GetID()] = trap
  end
end

TrapManager.GetTrap = function(instanceid, id)
  -- function num : 0_5 , upvalues : _traps
  if not _traps[instanceid] then
    return 
  end
  return (_traps[instanceid])[id]
end

TrapManager.RemoveTrap = function(instanceid, id)
  -- function num : 0_6 , upvalues : _traps
  ((_traps[instanceid])[id]):Destroy()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_traps[instanceid])[id] = nil
end

TrapManager.OnSceneLoaded = function(sceneid)
  -- function num : 0_7 , upvalues : _ENV, _cached_finder
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if not sceneid then
    sceneid = controller:GetSceneID()
  end
  local traps = controller:GetObjects()
  _cached_finder = function(path)
    -- function num : 0_7_0 , upvalues : traps, _ENV
    if not traps[tonumber(path)] then
      LogError("trap", "trap " .. path .. " not found")
    end
    return (traps[tonumber(path)]).object
  end

end

TrapManager.ToNextState = function(instanceid, id)
  -- function num : 0_8 , upvalues : _traps
  return ((_traps[instanceid])[id]):ToNextState()
end

TrapManager.CheckState = function(id)
  -- function num : 0_9 , upvalues : _ENV, _traps
  for _,v in pairs(_traps) do
    if v:GetID() == id then
      return v:CheckState()
    end
  end
end

TrapManager.RestoreState = function(states)
  -- function num : 0_10 , upvalues : _ENV, _traps
  local list = (EffectFactory.CreateEffectList)()
  for instanceid,inst in pairs(_traps) do
    local keys = (table.keys)(inst)
    ;
    (table.sort)(keys)
    for _,id in ipairs(keys) do
      local trap = inst[id]
      local state = nil
      if states[instanceid] and (states[instanceid])[id] and trap:ShouldSaveState() then
        state = ((states[instanceid])[id]).state
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

