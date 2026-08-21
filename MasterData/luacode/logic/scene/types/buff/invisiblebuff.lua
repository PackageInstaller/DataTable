-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/buff/invisiblebuff.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Buff = require("logic.scene.types.buff.scenebuff")
local InvisibleBuff = class("InvisibleBuff", Buff)
local PathResolver = require("logic.scene.pathresolver")
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local ImageStaticFunctions = (((CS.PixelNeko).Lua).UI).ImageStaticFunctions
local cdungeonbufftype = (BeanManager.GetTableByName)("sceneinteractive.cdungeonbufftype")
InvisibleBuff.Ctor = function(self, id)
  -- function num : 0_0 , upvalues : InvisibleBuff, cdungeonbufftype, _ENV
  ((InvisibleBuff.super).Ctor)(self, id)
  self._typecfg = cdungeonbufftype:GetRecorder((self._cfg).typeID)
  self._speed = tonumber(((self._typecfg).paramList)[1])
end

InvisibleBuff.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._builder then
    (self._builder):Destroy()
    self._builder = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)((self._typecfg).pathUI)
end

InvisibleBuff.BuildSceneObject = function(self, parent)
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

InvisibleBuff.GetDurationTime = function(self)
  -- function num : 0_3
  return (self._cfg).lifeTime
end

InvisibleBuff.GetRespawnTime = function(self)
  -- function num : 0_4
  return (self._cfg).respawnTime
end

InvisibleBuff.GetDurationTime = function(self)
  -- function num : 0_5
  return (self._cfg).lifeTime
end

InvisibleBuff.GetRespawnTime = function(self)
  -- function num : 0_6
  return (self._cfg).respawnTime
end

InvisibleBuff.ShowEffect = function(self)
  -- function num : 0_7 , upvalues : PathResolver, PrefabLoader, _ENV, TransformStaticFunctions
  local actor = (PathResolver.Resolve)("[actor]")
  if not self._effect then
    self._effect = (PrefabLoader.LoadAndInstantiatePrefab)((EffectUtil.GetAssetBundleNameAndAssetName)((self._typecfg).effectID))
    ;
    (TransformStaticFunctions.SetParent)((self._effect).transform, actor.transform)
  end
  ;
  (self._effect):SetActive(true)
end

InvisibleBuff.HideEffect = function(self)
  -- function num : 0_8
  if self._effect then
    (self._effect):SetActive(false)
  end
end

InvisibleBuff.Activate = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  self:BuildSceneObject((controller._sceneRef):GetRootGameObject())
end

InvisibleBuff.OnActive = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if controller and controller.GetMonsters then
    for _,v in pairs(controller:GetMonsters()) do
      if v:CanChase() then
        v:PauseChase()
      end
    end
  end
  do
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
end

InvisibleBuff.OnInactivate = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self._state ~= 2 then
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller and controller.GetMonsters then
      for _,v in pairs(controller:GetMonsters()) do
        if v:CanChase() then
          v:ResumeChase()
        end
      end
    end
    do
      self:HideEffect()
      if self._countDown then
        (DialogManager.DestroySingletonDialog)((self._typecfg).pathUI)
        self._countDown = nil
      end
      do
        local req = (LuaNetManager.CreateProtocol)("protocol.battle.cchangebuffstate")
        req.id = self._id
        req.status = req.LOSEBUFF
        req:Send()
        self:ToState(2)
      end
    end
  end
end

InvisibleBuff.OnRespawn = function(self)
  -- function num : 0_12 , upvalues : _ENV, FixedPos
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

InvisibleBuff.OnEnterArea = function(self, builder)
  -- function num : 0_13 , upvalues : _ENV
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

InvisibleBuff.OnUpdate = function(self, delta)
  -- function num : 0_14 , upvalues : _ENV
  self._time = self._time + delta
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SceneBuffProgress, self, {id = self._id, current = self._time, total = (self._cfg).lifeTime})
end

return InvisibleBuff

