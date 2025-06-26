-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/composed/changetrapstateeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local ChangeTrapStateEffect = class("ChangeTrapStateEffect", EffectBase)
local Future = require("logic.scene.luaevent.effect.future")
local PathResolver = require("logic.scene.pathresolver")
ChangeTrapStateEffect.Ctor = function(self, root)
  -- function num : 0_0
  self._root = root
end

ChangeTrapStateEffect.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._finished = false
  if self._callback then
    (self._callback)()
    self._callback = nil
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  self._futures = {}
end

ChangeTrapStateEffect.Add = function(self, root)
  -- function num : 0_2
  self._root = root
end

ChangeTrapStateEffect.Run = function(self)
  -- function num : 0_3
  (self._root):Run()
  ;
  (self._root):Then(function()
    -- function num : 0_3_0 , upvalues : self
    if self._callback then
      self._finished = false
      self:Destroy()
    else
      self._finished = true
    end
  end
)
end

ChangeTrapStateEffect.Then = function(self, callback)
  -- function num : 0_4
  self._callback = callback
  if self._finished then
    self:Destroy()
  end
end

ChangeTrapStateEffect.Sequence = class("ChangeTrapStateSequence")
-- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

;
(ChangeTrapStateEffect.Sequence).Ctor = function(self, ...)
  -- function num : 0_5
  self._names = {...}
  self._futures = {}
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

;
(ChangeTrapStateEffect.Sequence).Destroy = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  self._futures = {}
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

;
(ChangeTrapStateEffect.Sequence).Add = function(self, element)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (self._names)[#self._names + 1] = element
end

local change_next_state = function(self, next)
  -- function num : 0_8 , upvalues : change_next_state
  return function()
    -- function num : 0_8_0 , upvalues : next, self, change_next_state
    if #self._futures < next then
      if self._callback then
        (self._callback)()
        self._callback = nil
      else
        self._finished = true
      end
      self:Destroy()
      return 
    end
    ;
    ((self._futures)[next]):Run()
    ;
    ((self._futures)[next]):Then(change_next_state(self, next + 1))
  end

end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

;
(ChangeTrapStateEffect.Sequence).Run = function(self)
  -- function num : 0_9 , upvalues : _ENV, PathResolver, change_next_state
  self._finished = false
  for i = 1, #self._names do
    if type((self._names)[i]) == "string" then
      local object = (PathResolver.ResolveObject)((self._names)[i])
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._futures)[i] = object:ToNextState()
    else
      do
        do
          -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (self._futures)[i] = ((self._names)[i]):ToNextState()
          -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (change_next_state(self, 1))()
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

;
(ChangeTrapStateEffect.Sequence).ToNextState = function(self)
  -- function num : 0_10 , upvalues : Future
  return (Future.Create)(self)
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

;
(ChangeTrapStateEffect.Sequence).Then = function(self, callback)
  -- function num : 0_11
  if self._finished then
    self._finished = false
    callback()
    self._callback = nil
  else
    self._callback = callback
  end
end

ChangeTrapStateEffect.Parallel = class("ChangeTrapStateParallel")
-- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

;
(ChangeTrapStateEffect.Parallel).Ctor = function(self, ...)
  -- function num : 0_12
  self._names = {...}
  self._futures = {}
  self._finished = 0
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

;
(ChangeTrapStateEffect.Parallel).Destroy = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if self._callback then
    (self._callback)()
    self._callback = nil
  end
  self._futures = {}
  self._finished = -1
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R5 in 'UnsetPending'

;
(ChangeTrapStateEffect.Parallel).Add = function(self, element)
  -- function num : 0_14
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (self._names)[#self._names + 1] = element
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'

;
(ChangeTrapStateEffect.Parallel).Run = function(self)
  -- function num : 0_15 , upvalues : _ENV, PathResolver
  self._finished = 0
  for i = 1, #self._names do
    if type((self._names)[i]) == "string" then
      local object = (PathResolver.ResolveObject)((self._names)[i])
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._futures)[i] = object:ToNextState()
    else
      do
        do
          -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (self._futures)[i] = ((self._names)[i]):ToNextState()
          ;
          ((self._futures)[i]):Then(function()
    -- function num : 0_15_0 , upvalues : self
    self:OnEffectFinish()
  end
)
          ;
          ((self._futures)[i]):Run()
          -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

;
(ChangeTrapStateEffect.Parallel).ToNextState = function(self)
  -- function num : 0_16 , upvalues : Future
  return (Future.Create)(self)
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R5 in 'UnsetPending'

;
(ChangeTrapStateEffect.Parallel).Then = function(self, callback)
  -- function num : 0_17
  if self._finished == #self._names or self._finished == -1 then
    callback()
    self._callback = nil
    self._finished = 0
  else
    self._callback = callback
  end
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

;
(ChangeTrapStateEffect.Parallel).OnEffectFinish = function(self)
  -- function num : 0_18
  self._finished = self._finished + 1
  if self._finished == #self._names then
    self:Destroy()
  end
end

return ChangeTrapStateEffect

