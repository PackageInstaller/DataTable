-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/instancetrapcontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TrapController = require("logic.scene.scenecontrollers.trapcontroller")
local InstanceTrapController = class("InstanceTrapController", TrapController)
local Chest = require("logic.scene.types.chest")
local TrapHelper = (((CS.PixelNeko).P1).Scene).TrapHelper
InstanceTrapController.Init = function(self, ...)
  -- function num : 0_0 , upvalues : InstanceTrapController
  ((InstanceTrapController.super).Init)(self, ...)
  self._enemies = {}
  self._chests = {}
end

InstanceTrapController.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : InstanceTrapController, _ENV
  ((InstanceTrapController.super).OnDestroy)(self)
  for _,v in pairs(self._enemies) do
    ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(v.object)
  end
  self._enemies = {}
  for _,v in pairs(self._chests) do
    v:Destroy()
  end
  self._chests = {}
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

InstanceTrapController.OnNavMeshBuildFinish = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self._navMeshReady = true
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerMove, Common.n_RockerMove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
  self:LoadEvents()
  self:AddTrap()
  if not self:GetData("randomItems") then
    self:AddRandomItems({})
    if not self:GetData("sceneObjects") then
      local sceneobjects = {}
    end
    local enemies = {}
    local chests = {}
    local info = (((NekoData.BehaviorManager).BM_SEnterDungeon):GetCurBattleInfo())
    local id = nil
    if info then
      id = info.id
    end
    for i,v in pairs(sceneobjects) do
      if v.objType == 1 and v.status == 0 and v.objId ~= id then
        enemies[i] = {id = v.objId, x = v.x * 0.4 * 1000, z = v.y * -0.56 * 1000, index = v.id}
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
      if not info.switches then
        (SwitchManager.RestoreState)({})
        if not info.traps then
          (TrapManager.RestoreState)({})
          self:RestoreSceneObjects()
          self._init = true
          if self._moveType == "clickMobileMode" then
            self:SetActorRunning(true)
          end
        end
      end
    end
  end
end

InstanceTrapController.InitTreasure = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, TrapHelper, Chest
  local cinteractiveconfig = (BeanManager.GetTableByName)("sceneinteractive.cinteractiveconfig")
  for i,v in pairs(data) do
    local recorder = cinteractiveconfig:GetRecorder(v.objId)
    assert(recorder.SceneID == self:GetSceneID())
    local object = (TrapHelper.CreateObject)(recorder.assetBundle, recorder.assetName, v.x * 0.4, 0, v.y * -0.56, (self._sceneRef):GetRootGameObject())
    local chest = (Chest.Create)(i, object)
    if v.status == 0 then
      chest:Activate()
    else
      chest:RestoreState()
    end
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R11 in 'UnsetPending'

    if not (self._sceneRef).sceneobjects then
      do
        (self._sceneRef).sceneobjects = {}
        ;
        (table.insert)((self._sceneRef).sceneobjects, {object = chest:GetSceneObejct()})
        -- DECOMPILER ERROR at PC64: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self._chests)[#self._chests + 1] = chest
        -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

InstanceTrapController.OnTeamHPIsLow = function(self)
  -- function num : 0_4
end

return InstanceTrapController

