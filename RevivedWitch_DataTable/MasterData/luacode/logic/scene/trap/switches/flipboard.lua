-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/flipboard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local Flipboard = class("Flipboard", Switch)
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local ctrapwhconfig = (BeanManager.GetTableByName)("trap.ctrapwhconfig")
local _cache = {}
Flipboard.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Flipboard, _ENV, FixedPos, _cache, ctrapwhconfig
  ((Flipboard.super).Ctor)(self, ...)
  local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(self._object)
  self._effectAreas = {
{x = (math.floor)(x / 0.4 + 0.5), y = (math.floor)(z / -0.56 + 0.5)}
}
  self._builder = (FixedPos.Create)(self, self:GetEffectArea())
  local name = (self._object).name
  local prefab, cfg = (table.first)(_cache, function(k, v)
    -- function num : 0_0_0 , upvalues : name
    return name:find(k)
  end
)
  if cfg then
    self._blockcfg = cfg
  else
    for _,i in pairs(ctrapwhconfig:GetAllIds()) do
      local recorder = ctrapwhconfig:GetRecorder(i)
      if name:find(recorder.prefabName) then
        self._blockcfg = {w = tonumber(recorder.width), h = tonumber(recorder.height)}
        _cache[recorder.prefabName] = self._blockcfg
        break
      end
    end
  end
end

Flipboard.Destroy = function(self)
  -- function num : 0_1 , upvalues : Flipboard
  ((Flipboard.super).Destroy)(self)
  if self._builder then
    (self._builder):Destroy()
  end
end

Flipboard.OnEnterArea = function(self, builder)
  -- function num : 0_2 , upvalues : _ENV
  for _,v in ipairs((self._effectArgs).switches) do
    local flipboard = (SwitchManager.GetSwitch)(v.instance, v.id)
    ;
    (flipboard:ToNextState()):Run()
  end
end

Flipboard.Activate = function(self)
  -- function num : 0_3 , upvalues : Flipboard, _ENV
  ((Flipboard.super).Activate)(self)
  local event = (self._builder):BuildFixedEvent()
  ;
  (EventManager.AddEvent)(event)
end

Flipboard.BuildStateEffects = function(self)
  -- function num : 0_4 , upvalues : Flipboard, _ENV
  ((Flipboard.super).BuildStateEffects)(self)
  local w, h = nil, nil
  if self._blockcfg then
    w = (self._blockcfg).w
  end
  local root = (EffectFactory.CreateComposedEffect)()
  root:AddEffect((self._stateEffects)[0])
  do
    local effect = (EffectFactory.CreateBlockChangeEffect)(((self._effectAreas)[1]).x, ((self._effectAreas)[1]).y, 1, 1, false, w, h)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._stateEffects)[0] = root
    local root = (EffectFactory.CreateComposedEffect)()
    root:AddEffect((self._stateEffects)[1])
    local effect = (EffectFactory.CreateBlockChangeEffect)(((self._effectAreas)[1]).x, ((self._effectAreas)[1]).y, 1, 1, true, w, h)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._stateEffects)[1] = root
  end
end

return Flipboard

