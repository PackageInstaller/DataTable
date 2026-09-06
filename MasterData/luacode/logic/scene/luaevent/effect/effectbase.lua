local EffectBase = class("EffectBase")

function EffectBase:Ctor()
  self._params = {}
end

function EffectBase:SetCfgID(id)
  self._cfgid = id
end

function EffectBase:GetCfgID()
  return self._cfgid
end

function EffectBase:Destroy()
end

function EffectBase:Run(args)
end

function EffectBase:Cancel()
end

function EffectBase:Then(callback)
  LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
  callback()
end

function EffectBase:Bind(object)
  self._object = object
  local alternative = self:GetParam("alternative")
  if alternative then
    alternative:Bind(object)
  end
end

function EffectBase:BindOnDemand(object)
  if not self._path or self._path == "" then
    self._object = object
    local alternative = self:GetParam("alternative")
    if alternative then
      alternative:BindOnDemand(object)
    end
  end
end

function EffectBase:OnUpdate(deltaTime)
end

function EffectBase:OnFixedUpdate()
end

function EffectBase:OnLateUpdate(deltaTime)
end

function EffectBase:GetParam(name)
  return self._params and self._params[name]
end

function EffectBase:SetParam(name, value)
  if value == nil then
    value = true
  end
  self._params = self._params or {}
  self._params[name] = value
end

return EffectBase
