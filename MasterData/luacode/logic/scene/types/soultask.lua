local BattleSceneHelper = CS.PixelNeko.P1.Scene.Battle.BattleSceneHelper
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local SoulTask = class("SoulTask")

function SoulTask:Ctor()
  self._gameObject1 = nil
  self._gameObject2 = nil
  self._destroyEventHandler1 = 0
  self._destroyEventHandler2 = 0
  self._gameObject2 = nil
  self._rootGameObject = nil
  self._effectGameObject = nil
  self._destroyEventHandlerEffect = 0
  self._pos1 = {
    x = 0,
    y = 0,
    z = 0
  }
  self._pos2 = {
    x = 0,
    y = 0,
    z = 0
  }
  self._delay = 0
  self._time = 0
  self._playEnd = false
end

function SoulTask:Destroy()
  if self._gameObject1 and self._destroyEventHandler1 > 0 then
    BattleSceneHelper.RemoveDestroyEventListener(self._gameObject1, self._destroyEventHandler1)
    self._gameObject1 = nil
    self._destroyEventHandler1 = 0
  end
  if self._gameObject2 and 0 < self._destroyEventHandler2 then
    BattleSceneHelper.RemoveDestroyEventListener(self._gameObject2, self._destroyEventHandler2)
    self._gameObject2 = nil
    self._destroyEventHandler2 = 0
  end
  if self._effectGameObject then
    BattleSceneHelper.RemoveDestroyEventListener(self._effectGameObject, self._destroyEventHandlerEffect)
    CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._effectGameObject)
    self._effectGameObject = nil
    self._destroyEventHandlerEffect = 0
  end
end

function SoulTask:Init(gameObject1, gameObject2, rootGameObject, delay)
  self._gameObject1 = gameObject1
  self._gameObject2 = gameObject2
  self._rootGameObject = rootGameObject
  self._delay = delay
  BattleSceneHelper.AddDestroyEventListener(gameObject1, self.OnGameObject1Destroy, self)
  BattleSceneHelper.AddDestroyEventListener(gameObject2, self.OnGameObject2Destroy, self)
  self._pos1.x, self._pos1.y, self._pos1.z = self:GetSlotPosition(self._gameObject1, "HitPoint")
  self._pos2.x, self._pos2.y, self._pos2.z = self:GetSlotPosition(self._gameObject2, "HitPoint")
end

function SoulTask:Update(deltaTime)
  if self._gameObject1 then
    self._pos1.x, self._pos1.y, self._pos1.z = self:GetSlotPosition(self._gameObject1, "HitPoint")
  end
  if self._gameObject2 then
    self._pos2.x, self._pos2.y, self._pos2.z = self:GetSlotPosition(self._gameObject2, "HitPoint")
  end
  if self._delay > 0 then
    self._delay = self._delay - deltaTime
  elseif not self._playEnd then
    if not self._effectGameObject then
      local name, asset = EffectUtil.GetAssetBundleNameAndAssetName(1060)
      self._effectGameObject = BattleSceneHelper.CreateEffect(name, asset, self._rootGameObject, self._pos1.x, self._pos1.y, self._pos1.z)
      self._destroyEventHandlerEffect = BattleSceneHelper.AddDestroyEventListener(self._effectGameObject, self.OnEffectDestroy, self)
    end
    self._time = self._time + deltaTime
    local start = {
      x = self._pos1.x,
      y = self._pos1.y,
      z = self._pos1.z
    }
    local task = Tween.new(2, start, self._pos2, "linear")
    task:set(self._time)
    TransformStaticFunctions.SetPosition(self._effectGameObject, task.subject.x, task.subject.y, task.subject.z)
    if self._time >= 2 then
      self._playEnd = true
    end
  end
end

function SoulTask:IsPlayEnd()
  return self._playEnd
end

function SoulTask:GetSlotPosition(gameObject, slotName)
  local x, y, z = TransformStaticFunctions.GetPosition(gameObject)
  if slotName then
    local slotGameObject = TransformStaticFunctions.GetChild(gameObject, slotName)
    if slotGameObject then
      x, y, z = TransformStaticFunctions.GetPosition(slotGameObject)
    end
  end
  return x, y, z
end

function SoulTask:OnGameObject1Destroy()
  self._gameObject1 = nil
  self._destroyEventHandler1 = 0
end

function SoulTask:OnGameObject2Destroy()
  self._gameObject2 = nil
  self._destroyEventHandler2 = 0
end

function SoulTask:OnEffectDestroy()
  self._effectGameObject = nil
  self._destroyEventHandlerEffect = 0
  self._playEnd = true
end

return SoulTask
