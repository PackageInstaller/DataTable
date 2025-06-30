-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/soultask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleSceneHelper = ((((CS.PixelNeko).P1).Scene).Battle).BattleSceneHelper
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local SoulTask = class("SoulTask")
SoulTask.Ctor = function(self)
  -- function num : 0_0
  self._gameObject1 = nil
  self._gameObject2 = nil
  self._destroyEventHandler1 = 0
  self._destroyEventHandler2 = 0
  self._gameObject2 = nil
  self._rootGameObject = nil
  self._effectGameObject = nil
  self._destroyEventHandlerEffect = 0
  self._pos1 = {x = 0, y = 0, z = 0}
  self._pos2 = {x = 0, y = 0, z = 0}
  self._delay = 0
  self._time = 0
  self._playEnd = false
end

SoulTask.Destroy = function(self)
  -- function num : 0_1 , upvalues : BattleSceneHelper, _ENV
  if self._gameObject1 and self._destroyEventHandler1 > 0 then
    (BattleSceneHelper.RemoveDestroyEventListener)(self._gameObject1, self._destroyEventHandler1)
    self._gameObject1 = nil
    self._destroyEventHandler1 = 0
  end
  if self._gameObject2 and self._destroyEventHandler2 > 0 then
    (BattleSceneHelper.RemoveDestroyEventListener)(self._gameObject2, self._destroyEventHandler2)
    self._gameObject2 = nil
    self._destroyEventHandler2 = 0
  end
  if self._effectGameObject then
    (BattleSceneHelper.RemoveDestroyEventListener)(self._effectGameObject, self._destroyEventHandlerEffect)
    ;
    ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._effectGameObject)
    self._effectGameObject = nil
    self._destroyEventHandlerEffect = 0
  end
end

SoulTask.Init = function(self, gameObject1, gameObject2, rootGameObject, delay)
  -- function num : 0_2 , upvalues : BattleSceneHelper
  self._gameObject1 = gameObject1
  self._gameObject2 = gameObject2
  self._rootGameObject = rootGameObject
  self._delay = delay
  ;
  (BattleSceneHelper.AddDestroyEventListener)(gameObject1, self.OnGameObject1Destroy, self)
  ;
  (BattleSceneHelper.AddDestroyEventListener)(gameObject2, self.OnGameObject2Destroy, self)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

  -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

  -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._pos1).x = self:GetSlotPosition(self._gameObject1, "HitPoint")
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

  -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

  -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._pos2).x = self:GetSlotPosition(self._gameObject2, "HitPoint")
end

SoulTask.Update = function(self, deltaTime)
  -- function num : 0_3 , upvalues : _ENV, BattleSceneHelper, TransformStaticFunctions
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  if self._gameObject1 then
    (self._pos1).x = self:GetSlotPosition(self._gameObject1, "HitPoint")
  end
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  if self._gameObject2 then
    (self._pos2).x = self:GetSlotPosition(self._gameObject2, "HitPoint")
  end
  if self._delay > 0 then
    self._delay = self._delay - deltaTime
  else
    if not self._playEnd then
      do
        if not self._effectGameObject then
          local name, asset = (EffectUtil.GetAssetBundleNameAndAssetName)(1060)
          self._effectGameObject = (BattleSceneHelper.CreateEffect)(name, asset, self._rootGameObject, (self._pos1).x, (self._pos1).y, (self._pos1).z)
          self._destroyEventHandlerEffect = (BattleSceneHelper.AddDestroyEventListener)(self._effectGameObject, self.OnEffectDestroy, self)
        end
        self._time = self._time + deltaTime
        local start = {x = (self._pos1).x, y = (self._pos1).y, z = (self._pos1).z}
        local task = (Tween.new)(2, start, self._pos2, "linear")
        task:set(self._time)
        ;
        (TransformStaticFunctions.SetPosition)(self._effectGameObject, (task.subject).x, (task.subject).y, (task.subject).z)
        if self._time >= 2 then
          self._playEnd = true
        end
      end
    end
  end
end

SoulTask.IsPlayEnd = function(self)
  -- function num : 0_4
  return self._playEnd
end

SoulTask.GetSlotPosition = function(self, gameObject, slotName)
  -- function num : 0_5 , upvalues : TransformStaticFunctions
  local x, y, z = (TransformStaticFunctions.GetPosition)(gameObject)
  do
    if slotName then
      local slotGameObject = (TransformStaticFunctions.GetChild)(gameObject, slotName)
      if slotGameObject then
        x = (TransformStaticFunctions.GetPosition)(slotGameObject)
      end
    end
    return x, y, z
  end
end

SoulTask.OnGameObject1Destroy = function(self)
  -- function num : 0_6
  self._gameObject1 = nil
  self._destroyEventHandler1 = 0
end

SoulTask.OnGameObject2Destroy = function(self)
  -- function num : 0_7
  self._gameObject2 = nil
  self._destroyEventHandler2 = 0
end

SoulTask.OnEffectDestroy = function(self)
  -- function num : 0_8
  self._effectGameObject = nil
  self._destroyEventHandlerEffect = 0
  self._playEnd = true
end

return SoulTask

