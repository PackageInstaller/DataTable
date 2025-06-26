-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/buff/acceleratebuff.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Buff = require("logic.scene.types.buff.scenebuff")
local AccelerateBuff = class("AccelerateBuff", Buff)
local PathResolver = require("logic.scene.pathresolver")
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local ImageStaticFunctions = (((CS.PixelNeko).Lua).UI).ImageStaticFunctions
local cdungeonbufftype = (BeanManager.GetTableByName)("sceneinteractive.cdungeonbufftype")
AccelerateBuff.Ctor = function(self, id)
  -- function num : 0_0 , upvalues : AccelerateBuff, cdungeonbufftype, _ENV
  ((AccelerateBuff.super).Ctor)(self, id)
  self._typecfg = cdungeonbufftype:GetRecorder((self._cfg).typeID)
  self._speed = tonumber(((self._typecfg).paramList)[1])
end

AccelerateBuff.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._builder then
    (self._builder):Destroy()
    self._builder = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)((self._typecfg).pathUI)
end

AccelerateBuff.BuildSceneObject = function(self, parent)
  -- function num : 0_2 , upvalues : PrefabLoader, _ENV, TransformStaticFunctions, FixedPos
  self._object = (PrefabLoader.LoadAndInstantiatePrefab)((self._typecfg).assetBundle, (self._typecfg).assetName)
  local pos = (string.split)((self._cfg).position, ",")
  ;
  (TransformStaticFunctions.SetParent)((self._object).transform, parent.transform)
  ;
  (TransformStaticFunctions.SetPosition)(self._object, tonumber(pos[1]) * 0.4, 0, tonumber(pos[2]) * -0.56)
  self._builder = (FixedPos.Create)(self, {
{x = tonumber(pos[1]), y = tonumber(pos[2])}
})
  ;
  (EventManager.AddEvent)((self._builder):BuildFixedEvent())
end

AccelerateBuff.GetDurationTime = function(self)
  -- function num : 0_3
  return (self._cfg).lifeTime
end

AccelerateBuff.GetRespawnTime = function(self)
  -- function num : 0_4
  return (self._cfg).respawnTime
end

AccelerateBuff.GetDurationTime = function(self)
  -- function num : 0_5
  return (self._cfg).lifeTime
end

AccelerateBuff.GetRespawnTime = function(self)
  -- function num : 0_6
  return (self._cfg).respawnTime
end

AccelerateBuff.ShowEffect = function(self)
  -- function num : 0_7 , upvalues : PrefabLoader, _ENV, TransformStaticFunctions
  if not self._effect then
    self._effect = (PrefabLoader.LoadAndInstantiatePrefab)((EffectUtil.GetAssetBundleNameAndAssetName)((self._typecfg).effectID))
    ;
    (TransformStaticFunctions.SetParent)((self._effect).transform, (self._actor).transform)
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnActorDirChange, Common.n_ActorDirChanged, nil)
  self:OnActorDirChange()
  ;
  (self._effect):SetActive(true)
end

AccelerateBuff.HideEffect = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self._effect then
    (self._effect):SetActive(false)
    ;
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_ActorDirChanged)
  end
end

local DirectionState = ((CS.PixelNeko).Lua).DirectionState
local angle = {[DirectionState.Up] = 0, [DirectionState.UpRight] = 45, [DirectionState.Right] = 90, [DirectionState.DownRight] = 135, [DirectionState.Down] = 180, [DirectionState.DownLeft] = 225, [DirectionState.Left] = 270, [DirectionState.UpLeft] = 315}
AccelerateBuff.OnActorDirChange = function(self, notification)
  -- function num : 0_9 , upvalues : _ENV, angle
  if self._effect then
    local dir = ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).GetActorDirection)(self._actor)
    ;
    ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetLocalEuler)(self._effect, 0, angle[dir], 0)
  end
end

AccelerateBuff.Activate = function(self)
  -- function num : 0_10 , upvalues : _ENV, PathResolver
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  self:BuildSceneObject((controller._sceneRef):GetRootGameObject())
  self._actor = (PathResolver.Resolve)("[actor]")
end

AccelerateBuff.OnActive = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local current_speed = ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).GetSpeed)(self._actor)
  ;
  ((EffectFactory.CreateSpeedChangeEffect)("[actor]", current_speed + self._speed)):Run()
  if self._builder then
    (self._builder):Destroy()
  end
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 0)
  effect:Bind(self._object)
  effect:Run()
  self:ShowEffect()
  if not self._countDown then
    self._countDown = (DialogManager.CreateSingletonDialog)((self._typecfg).pathUI)
  end
  self._time = 0
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cchangebuffstate")
  req.id = self._id
  req.status = req.GETBUFF
  req:Send()
  self:ToState(1)
end

AccelerateBuff.OnInactivate = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if self._state == 1 then
    local current_speed = ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).GetSpeed)(self._actor)
    ;
    ((EffectFactory.CreateSpeedChangeEffect)("[actor]", current_speed - self._speed)):Run()
    self:HideEffect()
    if self._countDown then
      (DialogManager.DestroySingletonDialog)((self._typecfg).pathUI)
      self._countDown = nil
    end
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.cchangebuffstate")
    req.id = self._id
    req.status = req.LOSEBUFF
    req:Send()
  end
  do
    self:ToState(2)
  end
end

AccelerateBuff.OnRespawn = function(self)
  -- function num : 0_13 , upvalues : _ENV, FixedPos
  do
    if not self._builder then
      local pos = (string.split)((self._cfg).position, ",")
      self._builder = (FixedPos.Create)(self, {
{x = tonumber(pos[1]), y = tonumber(pos[2])}
})
    end
    ;
    (EventManager.AddEvent)((self._builder):BuildFixedEvent())
    local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 1)
    effect:Bind(self._object)
    effect:Run()
    do
      if self._state ~= 0 then
        local req = (LuaNetManager.CreateProtocol)("protocol.battle.cchangebuffstate")
        req.id = self._id
        req.status = req.PRODUCEBUFF
        req:Send()
      end
      self:ToState(0)
    end
  end
end

AccelerateBuff.OnEnterArea = function(self, builder)
  -- function num : 0_14 , upvalues : _ENV
  do
    if self._state == 0 then
      local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
      ;
      (controller:GetBuffManager()):Activate(self:GetID())
    else
    end
    if (self._state ~= 1 or self._state == 2) then
    end
  end
end

AccelerateBuff.OnUpdate = function(self, delta)
  -- function num : 0_15 , upvalues : _ENV
  self._time = self._time + delta
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SceneBuffProgress, self, {id = self._id, current = self._time, total = (self._cfg).lifeTime})
end

return AccelerateBuff

