local Buff = require("logic.scene.types.buff.scenebuff")
local InvisibleBuff = class("InvisibleBuff", Buff)
local PathResolver = require("logic.scene.pathresolver")
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local ImageStaticFunctions = CS.PixelNeko.Lua.UI.ImageStaticFunctions
local cdungeonbufftype = BeanManager.GetTableByName("sceneinteractive.cdungeonbufftype")

function InvisibleBuff:Ctor(id)
  InvisibleBuff.super.Ctor(self, id)
  self._typecfg = cdungeonbufftype:GetRecorder(self._cfg.typeID)
  self._speed = tonumber(self._typecfg.paramList[1])
end

function InvisibleBuff:Destroy()
  if self._builder then
    self._builder:Destroy()
    self._builder = nil
  end
  DialogManager.DestroySingletonDialog(self._typecfg.pathUI)
end

function InvisibleBuff:BuildSceneObject(parent)
  self._object = PrefabLoader.LoadAndInstantiatePrefab(self._typecfg.assetBundle, self._typecfg.assetName)
  local pos = string.split(self._cfg.position, ",")
  TransformStaticFunctions.SetParent(self._object.transform, parent.transform)
  TransformStaticFunctions.SetPosition(self._object, tonumber(pos[1]) * 0.4, 0, tonumber(pos[2]) * -0.56)
  self._builder = FixedPos.Create(self, {
    {
      x = tonumber(pos[1]),
      y = tonumber(pos[2])
    }
  })
  EventManager.AddEvent(self._builder:BuildFixedEvent())
end

function InvisibleBuff:GetDurationTime()
  return self._cfg.lifeTime
end

function InvisibleBuff:GetRespawnTime()
  return self._cfg.respawnTime
end

function InvisibleBuff:GetDurationTime()
  return self._cfg.lifeTime
end

function InvisibleBuff:GetRespawnTime()
  return self._cfg.respawnTime
end

function InvisibleBuff:ShowEffect()
  local actor = PathResolver.Resolve("[actor]")
  if not self._effect then
    self._effect = PrefabLoader.LoadAndInstantiatePrefab(EffectUtil.GetAssetBundleNameAndAssetName(self._typecfg.effectID))
    TransformStaticFunctions.SetParent(self._effect.transform, actor.transform)
  end
  self._effect:SetActive(true)
end

function InvisibleBuff:HideEffect()
  if self._effect then
    self._effect:SetActive(false)
  end
end

function InvisibleBuff:Activate()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  self:BuildSceneObject(controller._sceneRef:GetRootGameObject())
end

function InvisibleBuff:OnActive()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller and controller.GetMonsters then
    for _, v in pairs(controller:GetMonsters()) do
      if v:CanChase() then
        v:PauseChase()
      end
    end
  end
  if self._builder then
    self._builder:Destroy()
  end
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 0)
  effect:Bind(self._object)
  effect:Run()
  self:ShowEffect()
  if not self._countDown then
    self._countDown = DialogManager.CreateSingletonDialog(self._typecfg.pathUI)
  end
  self._time = 0
  local req = LuaNetManager.CreateProtocol("protocol.battle.cchangebuffstate")
  req.id = self._id
  req.status = req.GETBUFF
  req:Send()
  self:ToState(1)
end

function InvisibleBuff:OnInactivate()
  if self._state ~= 2 then
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if controller and controller.GetMonsters then
      for _, v in pairs(controller:GetMonsters()) do
        if v:CanChase() then
          v:ResumeChase()
        end
      end
    end
    self:HideEffect()
    if self._countDown then
      DialogManager.DestroySingletonDialog(self._typecfg.pathUI)
      self._countDown = nil
    end
    local req = LuaNetManager.CreateProtocol("protocol.battle.cchangebuffstate")
    req.id = self._id
    req.status = req.LOSEBUFF
    req:Send()
  end
  self:ToState(2)
end

function InvisibleBuff:OnRespawn()
  if not self._builder then
    local pos = string.split(self._cfg.position, ",")
    self._builder = FixedPos.Create(self, {
      {
        x = tonumber(pos[1]),
        y = tonumber(pos[2])
      }
    })
  end
  EventManager.AddEvent(self._builder:BuildFixedEvent())
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 1)
  effect:Bind(self._object)
  effect:Run()
  if self._state ~= 0 then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cchangebuffstate")
    req.id = self._id
    req.status = req.PRODUCEBUFF
    req:Send()
  end
  self:ToState(0)
end

function InvisibleBuff:OnEnterArea(builder)
  if self._state == 0 then
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    controller:GetBuffManager():Activate(self:GetID())
  elseif self._state == 1 then
  elseif self._state == 2 then
  end
end

function InvisibleBuff:OnUpdate(delta)
  self._time = self._time + delta
  LuaNotificationCenter.PostNotification(Common.n_SceneBuffProgress, self, {
    id = self._id,
    current = self._time,
    total = self._cfg.lifeTime
  })
end

return InvisibleBuff
