local Switch = require("logic.scene.trap.switch")
local Flipboard = class("Flipboard", Switch)
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local ctrapwhconfig = BeanManager.GetTableByName("trap.ctrapwhconfig")
local _cache = {}

function Flipboard:Ctor(...)
  Flipboard.super.Ctor(self, ...)
  local x, y, z = CS.PixelNeko.Lua.TransformStaticFunctions.GetPosition(self._object)
  self._effectAreas = {
    {
      x = math.floor(x / 0.4 + 0.5),
      y = math.floor(z / -0.56 + 0.5)
    }
  }
  self._builder = FixedPos.Create(self, self:GetEffectArea())
  local name = self._object.name
  local prefab, cfg = table.first(_cache, function(k, v)
    return name:find(k)
  end)
  if cfg then
    self._blockcfg = cfg
  else
    for _, i in pairs(ctrapwhconfig:GetAllIds()) do
      local recorder = ctrapwhconfig:GetRecorder(i)
      if name:find(recorder.prefabName) then
        self._blockcfg = {
          w = tonumber(recorder.width),
          h = tonumber(recorder.height)
        }
        _cache[recorder.prefabName] = self._blockcfg
        break
      end
    end
  end
end

function Flipboard:Destroy()
  Flipboard.super.Destroy(self)
  if self._builder then
    self._builder:Destroy()
  end
end

function Flipboard:OnEnterArea(builder)
  for _, v in ipairs(self._effectArgs.switches) do
    local flipboard = SwitchManager.GetSwitch(v.instance, v.id)
    flipboard:ToNextState():Run()
  end
end

function Flipboard:Activate()
  Flipboard.super.Activate(self)
  local event = self._builder:BuildFixedEvent()
  EventManager.AddEvent(event)
end

function Flipboard:BuildStateEffects()
  Flipboard.super.BuildStateEffects(self)
  local w, h
  if self._blockcfg then
    w, h = self._blockcfg.w, self._blockcfg.h
  end
  do
    local root = EffectFactory.CreateComposedEffect()
    root:AddEffect(self._stateEffects[0])
    local effect = EffectFactory.CreateBlockChangeEffect(self._effectAreas[1].x, self._effectAreas[1].y, 1, 1, false, w, h)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    self._stateEffects[0] = root
  end
  do
    local root = EffectFactory.CreateComposedEffect()
    root:AddEffect(self._stateEffects[1])
    local effect = EffectFactory.CreateBlockChangeEffect(self._effectAreas[1].x, self._effectAreas[1].y, 1, 1, true, w, h)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    self._stateEffects[1] = root
  end
end

return Flipboard
