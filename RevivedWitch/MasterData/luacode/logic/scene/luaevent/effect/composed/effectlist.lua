-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/composed/effectlist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectList = class("EffectList")
EffectList.Ctor = function(self, ...)
  -- function num : 0_0
  self._effects = {...}
  self._finished = -1
  self._params = {}
  self._total = 0
end

EffectList.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._callback then
    (self._callback)()
    self._callback = nil
  end
  self._finished = -1
  self._total = 0
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
end

EffectList.Run = function(self, args)
  -- function num : 0_2 , upvalues : _ENV
  self._finished = -1
  if self._callback then
    self:Destroy()
  end
  if not args then
    args = {}
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEffectFinish, Common.n_SceneEffectEnd, nil)
  for _,v in ipairs(self._effects) do
    do
      do
        if args.init and v:GetParam("runoninit") then
          local alternative = v:GetParam("alternative")
          if alternative then
            alternative:Run(args)
            alternative:Then(function()
    -- function num : 0_2_0
  end
)
          else
            v:Run(args)
            v:Then(function()
    -- function num : 0_2_1
  end
)
          end
          self._total = self._total + 1
        end
        v:Run(args)
        v:Then(function()
    -- function num : 0_2_2
  end
)
        self._total = self._total + 1
        -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self:OnEffectFinish({})
end

EffectList.AddEffect = function(self, effect)
  -- function num : 0_3 , upvalues : _ENV
  (table.insert)(self._effects, effect)
end

EffectList.GetEffects = function(self)
  -- function num : 0_4
  return self._effects
end

EffectList.Bind = function(self, object)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in pairs(self._effects) do
    v:Bind(object)
  end
end

EffectList.BindOnDemand = function(self, object)
  -- function num : 0_6 , upvalues : _ENV
  for _,v in pairs(self._effects) do
    v:BindOnDemand(object)
  end
end

EffectList.Then = function(self, callback)
  -- function num : 0_7
  self._callback = callback
  if self._finished == self._total or #self._effects == 0 then
    self:Destroy()
  end
end

EffectList.OnEffectFinish = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV
  for _,v in pairs(self._effects) do
    if v == notification.userInfo then
      self._finished = (math.max)(0, self._finished) + 1
      break
    end
  end
  do
    if (self._finished == self._total or #self._effects == 0) and self._callback then
      self:Destroy()
    end
  end
end

EffectList.GetParam = function(self, name)
  -- function num : 0_9
  do return (name == "runoninit" or self._params) and (self._params)[name] end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

EffectList.SetParam = function(self, name, value)
  -- function num : 0_10
  if value == nil then
    value = true
  end
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._params)[name] = value
end

return EffectList

