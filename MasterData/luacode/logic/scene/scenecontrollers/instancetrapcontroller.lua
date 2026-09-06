local TrapController = require("logic.scene.scenecontrollers.trapcontroller")
local InstanceTrapController = class("InstanceTrapController", TrapController)
local Chest = require("logic.scene.types.chest")
local TrapHelper = CS.PixelNeko.P1.Scene.TrapHelper

function InstanceTrapController:Init(...)
  InstanceTrapController.super.Init(self, ...)
  self._enemies = {}
  self._chests = {}
end

function InstanceTrapController:OnDestroy()
  InstanceTrapController.super.OnDestroy(self)
  for _, v in pairs(self._enemies) do
    CS.PixelNeko.Common.GameObjectHelper.DestroyObject(v.object)
  end
  self._enemies = {}
  for _, v in pairs(self._chests) do
    v:Destroy()
  end
  self._chests = {}
  LuaNotificationCenter.RemoveObserver(self)
end

function InstanceTrapController:OnNavMeshBuildFinish()
  self._navMeshReady = true
  LuaNotificationCenter.AddObserver(self, self.OnRockerMove, Common.n_RockerMove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
  self:LoadEvents()
  self:AddTrap()
  self:AddRandomItems(self:GetData("randomItems") or {})
  local sceneobjects = self:GetData("sceneObjects") or {}
  local enemies = {}
  local chests = {}
  local info = NekoData.BehaviorManager.BM_SEnterDungeon:GetCurBattleInfo()
  local id
  if info then
    id = info.id
  end
  for i, v in pairs(sceneobjects) do
    if v.objType == 1 and v.status == 0 and v.objId ~= id then
      enemies[i] = {
        id = v.objId,
        x = v.x * 0.4 * 1000,
        z = v.y * -0.56 * 1000,
        index = v.id
      }
    end
    if v.objType == 2 then
      chests[i] = v
    end
  end
  self:InitEnemies(enemies, true)
  self:InitTreasure(chests)
  self:SetBornPosition()
  self:AddMapIcon()
  info = self:GetData("trapStates")
  if info then
    SwitchManager.RestoreState(info.switches or {})
    TrapManager.RestoreState(info.traps or {})
  end
  self:RestoreSceneObjects()
  self._init = true
  if self._moveType == "clickMobileMode" then
    self:SetActorRunning(true)
  end
end

function InstanceTrapController:InitTreasure(data)
  local cinteractiveconfig = BeanManager.GetTableByName("sceneinteractive.cinteractiveconfig")
  for i, v in pairs(data) do
    local recorder = cinteractiveconfig:GetRecorder(v.objId)
    assert(recorder.SceneID == self:GetSceneID())
    local object = TrapHelper.CreateObject(recorder.assetBundle, recorder.assetName, v.x * 0.4, 0, v.y * -0.56, self._sceneRef:GetRootGameObject())
    local chest = Chest.Create(i, object)
    if v.status == 0 then
      chest:Activate()
    else
      chest:RestoreState()
    end
    self._sceneRef.sceneobjects = self._sceneRef.sceneobjects or {}
    table.insert(self._sceneRef.sceneobjects, {
      object = chest:GetSceneObejct()
    })
    self._chests[#self._chests + 1] = chest
  end
end

function InstanceTrapController:OnTeamHPIsLow()
end

return InstanceTrapController
