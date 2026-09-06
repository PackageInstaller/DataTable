local SwitchManager = {}
local _switches = {}
local _restore = false
local SwitchType = {
  [1] = require("logic.scene.trap.switches.stick"),
  [2] = require("logic.scene.trap.switch"),
  [3] = require("logic.scene.trap.switches.lightsource"),
  [4] = require("logic.scene.trap.switches.mirror"),
  [5] = require("logic.scene.trap.switches.jailbreaker"),
  [6] = require("logic.scene.trap.switches.dualstick"),
  [7] = require("logic.scene.trap.switches.skate"),
  [8] = require("logic.scene.trap.switches.ice"),
  [9] = require("logic.scene.trap.switches.unorderedcollection"),
  [10] = require("logic.scene.trap.switches.orderedcollection"),
  [11] = require("logic.scene.trap.switches.collector"),
  [12] = require("logic.scene.trap.switches.onewaystick"),
  [13] = require("logic.scene.trap.switches.catapult"),
  [14] = require("logic.scene.trap.switches.impactpoint"),
  [15] = require("logic.scene.trap.switches.wayout"),
  [16] = require("logic.scene.trap.switches.flipboard")
}
local _cached_finder

function SwitchManager.CreateSwitch(type, instanceid, id, path, initialstate, preservestate)
  assert(SwitchType[type], string.format("unknown switch type %d at (%d, %d)", type, instanceid, id))
  assert(_cached_finder, "controller not init")
  local switch = SwitchType[type].Create(instanceid, id, _cached_finder(path), initialstate, path, preservestate)
  switch:SetType(type)
  return switch
end

function SwitchManager.AddSwitch(switch)
  _switches[switch:GetInstanceID()] = _switches[switch:GetInstanceID()] or {}
  _switches[switch:GetInstanceID()][switch:GetID()] = switch
end

function SwitchManager.RemoveSwitch(instanceid, id)
  _switches[instanceid][id]:Destroy()
  _switches[instanceid][id] = nil
end

function SwitchManager.DestroySwitch()
  for _, i in pairs(_switches) do
    for _, v in pairs(i) do
      v:Destroy()
    end
  end
  _switches = {}
end

function SwitchManager.GetSwitch(instanceid, id)
  if not _switches[instanceid] then
    return
  end
  return _switches[instanceid][id]
end

function SwitchManager.GetSwitchByObject(object)
  for _, v in pairs(_switches) do
    for _, s in pairs(v) do
      if s:GetObject() == object then
        return s
      end
    end
  end
end

function SwitchManager.ToNextState(instanceid, id)
  return _switches[instanceid][id]:ToNextState()
end

function SwitchManager.CheckState(instanceid, id)
  return _switches[instanceid][id]:CheckState()
end

function SwitchManager.OnSceneLoaded(sceneid)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  local switches = controller:GetObjects()
  
  function _cached_finder(path)
    if path == "-1" then
      return
    end
    if not switches[tonumber(path)] then
      LogError("trap", "switch " .. path .. " not found")
    end
    return switches[tonumber(path)].object
  end
end

local function build_switch_hint_range(switch, zone)
  local object = switch:GetObject()
  local x, y, z = CS.PixelNeko.Lua.TransformStaticFunctions.GetPosition(object)
  local radius = math.floor(zone / 2)
  return {
    x = math.floor(x / 0.4 + 0.5) - radius,
    y = math.floor(z / -0.56 + 0.5) - radius,
    w = zone,
    h = zone
  }
end

function SwitchManager.RestoreState(states)
  local root = EffectFactory.CreateComposedEffect()
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    _restore = true
  end))
  local list = EffectFactory.CreateEffectList()
  for instanceid, inst in pairs(_switches) do
    local keys = table.keys(inst)
    table.sort(keys)
    local seq
    local sequenced = table.any(keys, function(k, v)
      local typeid = SwitchManager.GetSwitch(instanceid, v):GetType()
      return typeid == 9 or typeid == 10 or typeid == 3
    end)
    if sequenced then
      seq = EffectFactory.CreateComposedEffect()
      list:AddEffect(seq)
    end
    for _, id in ipairs(keys) do
      local switch = inst[id]
      local state
      if states[instanceid] and states[instanceid][id] and switch:ShouldSaveState() then
        state = states[instanceid][id].state
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
  root:AddEffect(list)
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    _restore = false
  end))
  return root
end

function SwitchManager.BuildHintEvent(states)
  local events = {}
  local ctraptipconfig = BeanManager.GetTableByName("trap.ctraptipconfig")
  for instanceid, inst in pairs(_switches) do
    local record = ctraptipconfig:GetRecorder(instanceid)
    if record and states[instanceid] and states[instanceid][record.Trapid] and states[instanceid][record.Trapid].touched == false then
      local switch = inst[record.Trapid]
      local event = EventManager.Builder.BuildHintEvent(build_switch_hint_range(switch, record.Zone), 1, true, 1)
      events[#events + 1] = event
    end
  end
  return events
end

function SwitchManager.IsRestoreMode()
  return _restore
end

return SwitchManager
