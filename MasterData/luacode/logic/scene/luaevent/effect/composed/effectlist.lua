local EffectList = class("EffectList")

function EffectList:Ctor(...)
  self._effects = {
    ...
  }
  self._finished = -1
  self._params = {}
  self._total = 0
end

function EffectList:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._callback then
    self._callback()
    self._callback = nil
  end
  self._finished = -1
  self._total = 0
  LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
end

function EffectList:Run(args)
  self._finished = -1
  if self._callback then
    self:Destroy()
  end
  args = args or {}
  LuaNotificationCenter.AddObserver(self, self.OnEffectFinish, Common.n_SceneEffectEnd, nil)
  for _, v in ipairs(self._effects) do
    if args.init then
      if v:GetParam("runoninit") then
        local alternative = v:GetParam("alternative")
        if alternative then
          alternative:Run(args)
          alternative:Then(function()
          end)
        else
          v:Run(args)
          v:Then(function()
          end)
        end
        self._total = self._total + 1
      end
    else
      v:Run(args)
      v:Then(function()
      end)
      self._total = self._total + 1
    end
  end
  self:OnEffectFinish({})
end

function EffectList:AddEffect(effect)
  table.insert(self._effects, effect)
end

function EffectList:GetEffects()
  return self._effects
end

function EffectList:Bind(object)
  for _, v in pairs(self._effects) do
    v:Bind(object)
  end
end

function EffectList:BindOnDemand(object)
  for _, v in pairs(self._effects) do
    v:BindOnDemand(object)
  end
end

function EffectList:Then(callback)
  self._callback = callback
  if self._finished == self._total or #self._effects == 0 then
    self:Destroy()
  end
end

function EffectList:OnEffectFinish(notification)
  for _, v in pairs(self._effects) do
    if v == notification.userInfo then
      self._finished = math.max(0, self._finished) + 1
      break
    end
  end
  if (self._finished == self._total or #self._effects == 0) and self._callback then
    self:Destroy()
  end
end

function EffectList:GetParam(name)
  return name == "runoninit" or self._params and self._params[name]
end

function EffectList:SetParam(name, value)
  if value == nil then
    value = true
  end
  self._params[name] = value
end

return EffectList
