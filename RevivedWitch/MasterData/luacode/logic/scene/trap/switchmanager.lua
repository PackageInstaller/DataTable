-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switchmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SwitchManager = {}
local _switches = {}
local _restore = false
local SwitchType = {[1] = require("logic.scene.trap.switches.stick"), [2] = require("logic.scene.trap.switch"), [3] = require("logic.scene.trap.switches.lightsource"), [4] = require("logic.scene.trap.switches.mirror"), [5] = require("logic.scene.trap.switches.jailbreaker"), [6] = require("logic.scene.trap.switches.dualstick"), [7] = require("logic.scene.trap.switches.skate"), [8] = require("logic.scene.trap.switches.ice"), [9] = require("logic.scene.trap.switches.unorderedcollection"), [10] = require("logic.scene.trap.switches.orderedcollection"), [11] = require("logic.scene.trap.switches.collector"), [12] = require("logic.scene.trap.switches.onewaystick"), [13] = require("logic.scene.trap.switches.catapult"), [14] = require("logic.scene.trap.switches.impactpoint"), [15] = require("logic.scene.trap.switches.wayout"), [16] = require("logic.scene.trap.switches.flipboard")}
local _cached_finder = nil
SwitchManager.CreateSwitch = function(type, instanceid, id, path, initialstate, preservestate)
  -- function num : 0_0 , upvalues : _ENV, SwitchType, _cached_finder
  assert(SwitchType[type], (string.format)("unknown switch type %d at (%d, %d)", type, instanceid, id))
  assert(_cached_finder, "controller not init")
  local switch = ((SwitchType[type]).Create)(instanceid, id, _cached_finder(path), initialstate, path, preservestate)
  switch:SetType(type)
  return switch
end

SwitchManager.AddSwitch = function(switch)
  -- function num : 0_1 , upvalues : _switches
  if not _switches[switch:GetInstanceID()] then
    _switches[switch:GetInstanceID()] = {}
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (_switches[switch:GetInstanceID()])[switch:GetID()] = switch
  end
end

SwitchManager.RemoveSwitch = function(instanceid, id)
  -- function num : 0_2 , upvalues : _switches
  ((_switches[instanceid])[id]):Destroy()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_switches[instanceid])[id] = nil
end

SwitchManager.DestroySwitch = function()
  -- function num : 0_3 , upvalues : _ENV, _switches
  for _,i in pairs(_switches) do
    for _,v in pairs(i) do
      v:Destroy()
    end
  end
  _switches = {}
end

SwitchManager.GetSwitch = function(instanceid, id)
  -- function num : 0_4 , upvalues : _switches
  if not _switches[instanceid] then
    return 
  end
  return (_switches[instanceid])[id]
end

SwitchManager.GetSwitchByObject = function(object)
  -- function num : 0_5 , upvalues : _ENV, _switches
  for _,v in pairs(_switches) do
    for _,s in pairs(v) do
      if s:GetObject() == object then
        return s
      end
    end
  end
end

SwitchManager.ToNextState = function(instanceid, id)
  -- function num : 0_6 , upvalues : _switches
  return ((_switches[instanceid])[id]):ToNextState()
end

SwitchManager.CheckState = function(instanceid, id)
  -- function num : 0_7 , upvalues : _switches
  return ((_switches[instanceid])[id]):CheckState()
end

SwitchManager.OnSceneLoaded = function(sceneid)
  -- function num : 0_8 , upvalues : _ENV, _cached_finder
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  local switches = controller:GetObjects()
  _cached_finder = function(path)
    -- function num : 0_8_0 , upvalues : switches, _ENV
    if path == "-1" then
      return 
    end
    if not switches[tonumber(path)] then
      LogError("trap", "switch " .. path .. " not found")
    end
    return (switches[tonumber(path)]).object
  end

end

local build_switch_hint_range = function(switch, zone)
  -- function num : 0_9 , upvalues : _ENV
  local object = switch:GetObject()
  local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(object)
  local radius = (math.floor)(zone / 2)
  return {x = (math.floor)(x / 0.4 + 0.5) - radius, y = (math.floor)(z / -0.56 + 0.5) - radius, w = zone, h = zone}
end

SwitchManager.RestoreState = function(states)
  -- function num : 0_10 , upvalues : _ENV, _restore, _switches, SwitchManager
  local root = (EffectFactory.CreateComposedEffect)()
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_10_0 , upvalues : _restore
    _restore = true
  end
))
  local list = (EffectFactory.CreateEffectList)()
  for instanceid,inst in pairs(_switches) do
    do
      local keys = (table.keys)(inst)
      ;
      (table.sort)(keys)
      local seq = nil
      local sequenced = (table.any)(keys, function(k, v)
    -- function num : 0_10_1 , upvalues : SwitchManager, instanceid
    local typeid = ((SwitchManager.GetSwitch)(instanceid, v)):GetType()
    do return typeid == 9 or typeid == 10 or typeid == 3 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      if sequenced then
        seq = (EffectFactory.CreateComposedEffect)()
        list:AddEffect(seq)
      end
      for _,id in ipairs(keys) do
        local switch = inst[id]
        local state = nil
        if states[instanceid] and (states[instanceid])[id] and switch:ShouldSaveState() then
          state = ((states[instanceid])[id]).state
        else
          state = switch:GetState()
        end
        local future = switch:RestoreState(state)
        if future then
          future:SetParam("runoninit", true)
          if seq then
            seq:AddEffect(future)
          else
            list:AddEffect(future)
          end
        end
      end
    end
  end
  root:AddEffect(list)
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_10_2 , upvalues : _restore
    _restore = false
  end
))
  return root
end

SwitchManager.BuildHintEvent = function(states)
  -- function num : 0_11 , upvalues : _ENV, _switches, build_switch_hint_range
  local events = {}
  local ctraptipconfig = (BeanManager.GetTableByName)("trap.ctraptipconfig")
  for instanceid,inst in pairs(_switches) do
    local record = ctraptipconfig:GetRecorder(instanceid)
    if record and states[instanceid] and (states[instanceid])[record.Trapid] and ((states[instanceid])[record.Trapid]).touched == false then
      local switch = inst[record.Trapid]
      local event = ((EventManager.Builder).BuildHintEvent)(build_switch_hint_range(switch, record.Zone), 1, true, 1)
      events[#events + 1] = event
    end
  end
  return events
end

SwitchManager.IsRestoreMode = function()
  -- function num : 0_12 , upvalues : _restore
  return _restore
end

return SwitchManager

