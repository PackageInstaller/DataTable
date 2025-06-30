-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/towercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local SceneInfoTable = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local CTowerDungeonType = (BeanManager.GetTableByName)("dungeonselect.ctowerdungeontype")
local CTowerDungeonStage = (BeanManager.GetTableByName)("dungeonselect.ctowerdungeonstage")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local TowerController = class("TowerController", SceneController)
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local TileCount = 7
local bm_tower = (NekoData.BehaviorManager).BM_Tower
TowerController.Init = function(self)
  -- function num : 0_0 , upvalues : TowerController, _ENV, CVarconfig
  ((TowerController.super).Init)(self)
  self._tiles = {}
  self._walkingSpeed = tonumber((CVarconfig:GetRecorder(48)).Value)
  self:PlaySceneBGM()
  self._dialog = (DialogManager.CreateSingletonDialog)("tower.scene.towerscenedialog")
  ;
  (self._dialog):Init(self)
  self:BuildScene()
  self:SetCameraBorder()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnCharacterMove, Common.n_TowerMove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReturnFromBattle, Common.n_ReturnFromBattle, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTileFinish, Common.n_TowerShrineActivated, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTileFinish, Common.n_TowerEventResponse, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTileFinish, Common.n_TowerChestOpen, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
end

TowerController.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("tower.scene.towerscenedialog")
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (EventManager.Clear)()
end

TowerController.PlaySceneBGM = function(self)
  -- function num : 0_2 , upvalues : SceneInfoTable, _ENV
  local v = SceneInfoTable:GetRecorder(self:GetSceneID())
  if self._isDay or v.bgmNight == 0 then
    (LuaAudioManager.PlayBGM)(v.bgm)
  else
    ;
    (LuaAudioManager.PlayBGM)(v.bgmNight)
  end
end

TowerController.SetCameraBorder = function(self)
  -- function num : 0_3 , upvalues : bm_tower, CTowerDungeonType, _ENV, CTowerDungeonStage
  local cameraType = {Little = 3, Middle = 5, Big = 7}
  self._cameraAnimatorParam = nil
  local currentTowerId = bm_tower:GetCurrentTowerID()
  local currentFloorId = bm_tower:GetCurrentFloor() + 1
  local currentTowerSections = (CTowerDungeonType:GetRecorder(currentTowerId)).sectionid
  local currentSectionId = tonumber(currentTowerSections[currentFloorId])
  if currentSectionId then
    self._cameraAnimatorParam = (CTowerDungeonStage:GetRecorder(currentSectionId)).mapRange
  else
    LogErrorFormat("TowerController", "currentTowerId %s currentFloorId %s no sectionid in ctowerdungeontype", currentTowerId, currentFloorId)
  end
  if self._cameraAnimatorParam then
    if self._cameraAnimatorParam == cameraType.Middle then
      self._cameraFollowPoint = (self._sceneRef).cameraFollowPoint2
    else
      if self._cameraAnimatorParam == cameraType.Big then
        self._cameraFollowPoint = (self._sceneRef).cameraFollowPoint3
      else
        self._cameraFollowPoint = nil
      end
    end
    ;
    ((self._sceneRef)._stateDrivenCameraAnimator):SetInteger("state", self._cameraAnimatorParam)
  else
    LogWarningFormat("TowerController", "currentTowerId %s currentFloorId %s sectionid %s no mapRange in ctowerdungeonstage", currentTowerId, currentFloorId, currentSectionId)
  end
end

TowerController.GetMainCamera = function(self)
  -- function num : 0_4
  return (self._sceneRef).mainCamera
end

local set_link = function(root, dir, state)
  -- function num : 0_5 , upvalues : TransformStaticFunctions
  local link = (TransformStaticFunctions.GetChild)(root, "Link/" .. dir)
  ;
  (TransformStaticFunctions.SetActive)(link, state)
end

TowerController.BuildScene = function(self)
  -- function num : 0_6 , upvalues : _ENV, TileCount, TransformStaticFunctions, bm_tower, PrefabLoader
  local list = ((NekoData.BehaviorManager).BM_Tower):GetTileInfo()
  for index,info in pairs(list) do
    local anchor = ((self._sceneRef).pos)[(info.pos).y * TileCount + (info.pos).x + 1]
    local tile = (((((CS.PixelNeko).P1).Scene).TrapHelper).CreateObject)((info.cfg).assetBundleName, (info.cfg).assetName, anchor)
    local icon_anchor = ((TransformStaticFunctions.GetChild)(tile, "point"))
    local icon = nil
    if (info.cfg).imgassetBundleName ~= "" and info.state ~= 1 then
      icon = (((((CS.PixelNeko).P1).Scene).TrapHelper).CreateObject)((info.cfg).imgassetBundleName, (info.cfg).imgassetName, icon_anchor)
    else
      if info.state == 1 and info.type == 7 then
        local assetBundleName, assetName = bm_tower:GetExitIcon()
        icon = (((((CS.PixelNeko).P1).Scene).TrapHelper).CreateObject)(assetBundleName, assetName, icon_anchor)
      end
    end
    do
      do
        -- DECOMPILER ERROR at PC85: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self._tiles)[index] = {tile = tile, anchor = anchor, info = info, icon = icon, icon_anchor = icon_anchor}
        self:RefreshTile(index)
        -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self._background = (PrefabLoader.LoadAndInstantiatePrefab)(((NekoData.BehaviorManager).BM_Tower):GetBackground())
  ;
  (TransformStaticFunctions.SetParent)((self._background).transform, ((self._sceneRef).backgroundAnchor).transform, false)
  self:RefreshCurrent()
end

TowerController.Freeze = function(self)
  -- function num : 0_7
  if self._dialog then
    (self._dialog):Freeze()
  end
end

TowerController.Thaw = function(self)
  -- function num : 0_8
  if self._dialog then
    (self._dialog):Thaw()
  end
end

local get_index_by_tile = function(self, anchor)
  -- function num : 0_9 , upvalues : _ENV
  for i,v in pairs(self._tiles) do
    if v.tile == anchor then
      return i
    end
  end
end

local movingOnPath = function(current, next)
  -- function num : 0_10 , upvalues : bm_tower
  local lhsState = bm_tower:GetTileState(current)
  local lhsType = bm_tower:GetTileType(current)
  local rhsState = bm_tower:GetTileState(next)
  local rhsType = bm_tower:GetTileType(next)
  local canMove = false
  if lhsType ~= 99 and rhsState ~= 1 and rhsType ~= 99 then
    canMove = lhsState ~= 0
    if lhsState == 1 then
      canMove = true
    elseif rhsState ~= 1 and rhsType ~= 99 then
      canMove = lhsState ~= 2
      if canMove then
        bm_tower:MoveTo(next)
      end
      do return canMove end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
end

TowerController.OnTileClick = function(self, tile)
  -- function num : 0_11 , upvalues : get_index_by_tile, _ENV, bm_tower, movingOnPath
  if self._xTask or self._yTask or self._zTask or self._movePath and #self._movePath ~= 0 then
    return 
  end
  local index = get_index_by_tile(self, tile)
  if not index then
    print("tile not found", tile)
    return 
  end
  local current = bm_tower:GetCurrentPos()
  if index == current or bm_tower:CanMoveTo(current, index) then
    bm_tower:MoveTo(index)
  else
    self._movePath = bm_tower:GetMovePath(current, index)
    if self._movePath then
      local canMove = movingOnPath(current, (self._movePath)[1])
      if canMove then
        (table.remove)(self._movePath, 1)
      else
        self._movePath = nil
        self:Thaw()
        self._movingState = false
      end
    end
  end
end

TowerController.OnCurrentTileClick = function(self)
  -- function num : 0_12 , upvalues : bm_tower
  if self._xTask or self._yTask or self._zTask or self._movePath and #self._movePath ~= 0 then
    return 
  end
  self._resume = true
  bm_tower:MoveTo(bm_tower:GetCurrentPos())
end

TowerController.RefreshTile = function(self, index)
  -- function num : 0_13 , upvalues : set_link, TransformStaticFunctions, bm_tower
  local info = ((self._tiles)[index]).info
  local visible = true
  local upTitleState = false
  local downTitleState = false
  local leftTitleState = false
  local rightTitleState = false
  if (self._tiles)[(info.neighborID).north] and not ((((self._tiles)[(info.neighborID).north]).info).titleShowState).south then
    if (info.neighborID).north ~= 0 then
      upTitleState = visible
    else
      upTitleState = false
    end
  end
  if (info.neighborID).north ~= 0 then
    upTitleState = visible
  else
    upTitleState = false
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((((self._tiles)[index]).info).titleShowState).north = upTitleState
  if (self._tiles)[(info.neighborID).south] and not ((((self._tiles)[(info.neighborID).south]).info).titleShowState).north then
    if (info.neighborID).south ~= 0 then
      downTitleState = visible
    else
      downTitleState = false
    end
  end
  if (info.neighborID).south ~= 0 then
    downTitleState = visible
  else
    downTitleState = false
  end
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((((self._tiles)[index]).info).titleShowState).south = downTitleState
  if (self._tiles)[(info.neighborID).west] and not ((((self._tiles)[(info.neighborID).west]).info).titleShowState).east then
    if (info.neighborID).west ~= 0 then
      leftTitleState = visible
    else
      leftTitleState = false
    end
  end
  if (info.neighborID).west ~= 0 then
    leftTitleState = visible
  else
    leftTitleState = false
  end
  -- DECOMPILER ERROR at PC118: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((((self._tiles)[index]).info).titleShowState).west = leftTitleState
  if (self._tiles)[(info.neighborID).east] and not ((((self._tiles)[(info.neighborID).east]).info).titleShowState).west then
    if (info.neighborID).east ~= 0 then
      rightTitleState = visible
    else
      rightTitleState = false
    end
  end
  if (info.neighborID).east ~= 0 then
    rightTitleState = visible
  else
    rightTitleState = false
  end
  -- DECOMPILER ERROR at PC155: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((((self._tiles)[index]).info).titleShowState).east = rightTitleState
  set_link(((self._tiles)[index]).tile, "Up", upTitleState)
  set_link(((self._tiles)[index]).tile, "Down", downTitleState)
  set_link(((self._tiles)[index]).tile, "Left", leftTitleState)
  set_link(((self._tiles)[index]).tile, "Right", rightTitleState)
  ;
  (TransformStaticFunctions.SetActive)(((self._tiles)[index]).icon_anchor, bm_tower:ShouldTileIconShow(index))
end

TowerController.OnBattleTile = function(self)
  -- function num : 0_14 , upvalues : _ENV, bm_tower
  local dialog = (DialogManager.CreateSingletonDialog)("tower.towerbattledialog")
  local info = bm_tower:GetEnemy(bm_tower:GetCurrentPos())
  dialog:SetData(bm_tower:GetCurrentPos(), info)
end

TowerController.OnChestTile = function(self)
  -- function num : 0_15 , upvalues : _ENV, bm_tower
  local dialog = (DialogManager.CreateSingletonDialog)("tower.towerchestdialog")
  dialog:SetData(bm_tower:GetCurrentPos(), 3)
end

TowerController.OnGoblinChestTile = function(self)
  -- function num : 0_16 , upvalues : _ENV, bm_tower
  local dialog = (DialogManager.CreateSingletonDialog)("tower.towerchestdialog")
  local info = ((self._tiles)[bm_tower:GetCurrentPos()]).info
  local choice = (string.split)(info.param, "@")
  for k,v in pairs(choice) do
    choice[k] = tonumber(v)
  end
  dialog:SetData(bm_tower:GetCurrentPos(), 4, choice)
end

TowerController.OnBestQualityChestTile = function(self)
  -- function num : 0_17 , upvalues : _ENV, bm_tower
  local dialog = (DialogManager.CreateSingletonDialog)("tower.towerchestdialog")
  dialog:SetData(bm_tower:GetCurrentPos(), 5)
end

TowerController.OnEventTile = function(self)
  -- function num : 0_18 , upvalues : bm_tower, _ENV
  local info = ((self._tiles)[bm_tower:GetCurrentPos()]).info
  local dialog = (DialogManager.CreateSingletonDialog)("tower.towereventdialog")
  dialog:SetData(bm_tower:GetCurrentPos(), tonumber(info.param))
end

TowerController.OnShrineTile = function(self)
  -- function num : 0_19 , upvalues : bm_tower, _ENV
  local info = ((self._tiles)[bm_tower:GetCurrentPos()]).info
  local dialog = (DialogManager.CreateSingletonDialog)("tower.towershrinedialog")
  dialog:SetData(bm_tower:GetCurrentPos(), tonumber(info.param))
end

local handler = {[1] = TowerController.OnBattleTile, [2] = TowerController.OnBattleTile, [3] = TowerController.OnChestTile, [4] = TowerController.OnGoblinChestTile, [5] = TowerController.OnBestQualityChestTile, [6] = TowerController.OnEventTile, [7] = TowerController.OnBattleTile, [8] = TowerController.OnShrineTile}
TowerController.RefreshCurrent = function(self)
  -- function num : 0_20 , upvalues : bm_tower, TransformStaticFunctions, _ENV
  local index = bm_tower:GetCurrentPos()
  local x, y, z = (TransformStaticFunctions.GetPosition)(((self._tiles)[index]).anchor)
  if self._resume == false then
    self._desX = x
    local preX, preY, preZ = (TransformStaticFunctions.GetPosition)(((self._sceneRef).actor).object)
    if preX < x and preY < y then
      (((self._sceneRef).actor).animator):SetFloat((self._sceneRef)._dirX, 1)
      ;
      (((self._sceneRef).actor).animator):SetFloat((self._sceneRef)._dirY, 1)
      self._desDirX = 0.5
    else
      if preX < x and y < preY then
        (((self._sceneRef).actor).animator):SetFloat((self._sceneRef)._dirX, 1)
        ;
        (((self._sceneRef).actor).animator):SetFloat((self._sceneRef)._dirY, -1)
        self._desDirX = 0.5
      else
        if x < preX and y < preY then
          (((self._sceneRef).actor).animator):SetFloat((self._sceneRef)._dirX, -1)
          ;
          (((self._sceneRef).actor).animator):SetFloat((self._sceneRef)._dirY, -1)
          self._desDirX = -0.5
        else
          if x < preX and preY < y then
            (((self._sceneRef).actor).animator):SetFloat((self._sceneRef)._dirX, -1)
            ;
            (((self._sceneRef).actor).animator):SetFloat((self._sceneRef)._dirY, 1)
            self._desDirX = -0.5
          end
        end
      end
    end
    local first = {pos = preX}
    local last = {pos = x}
    self._xTask = (Tween.new)(self._walkingSpeed, first, last, "linear")
    first = {pos = preY}
    last = {pos = y}
    self._yTask = (Tween.new)(self._walkingSpeed, first, last, "linear")
    first = {pos = preZ}
    last = {pos = z}
    self._zTask = (Tween.new)(self._walkingSpeed, first, last, "linear")
    self._needUpdate = true
  else
    do
      self._resume = false
      ;
      (TransformStaticFunctions.SetPosition)(((self._sceneRef).actor).object, x, y, z)
      for i,_ in pairs(self._tiles) do
        self:RefreshTile(i)
      end
    end
  end
end

TowerController.MoveCamera = function(self, xScreenOffset, yScreenOffset)
  -- function num : 0_21 , upvalues : _ENV
  do
    if self._cameraFollowPoint then
      local transform = (self._cameraFollowPoint).transform
      transform:Translate(xScreenOffset, yScreenOffset, 0, ((CS.UnityEngine).Space).World)
      return true
    end
    return false
  end
end

TowerController.OnCharacterMove = function(self)
  -- function num : 0_22 , upvalues : bm_tower, handler
  self:RefreshCurrent()
  local index = bm_tower:GetCurrentPos()
  if bm_tower:GetTileState(index) ~= 1 then
    local type = bm_tower:GetTileType(index)
    do
      if type ~= 99 then
        self._effect = function(c)
    -- function num : 0_22_0 , upvalues : handler, type
    (handler[type])(c)
  end

      end
    end
  else
    do
      if bm_tower:GetTileType(index) == 7 then
        self._effect = function(s)
    -- function num : 0_22_1
    s:TryFinishFloor()
  end

      end
      if self._effect and not self._needUpdate then
        (self._effect)(self)
        self._effect = nil
      end
    end
  end
end

TowerController.OnReturnFromBattle = function(self, notification)
  -- function num : 0_23 , upvalues : bm_tower, _ENV
  if self._cameraAnimatorParam then
    ((self._sceneRef)._stateDrivenCameraAnimator):SetInteger("state", self._cameraAnimatorParam)
  end
  if (notification.userInfo).battleResult == 0 then
    return 
  end
  local index = bm_tower:GetCurrentPos()
  ;
  ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(((self._tiles)[index]).icon)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._tiles)[index]).icon = nil
  if bm_tower:GetTileType(index) == 7 then
    local assetBundleName, assetName = bm_tower:GetExitIcon()
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._tiles)[index]).icon = (((((CS.PixelNeko).P1).Scene).TrapHelper).CreateObject)(assetBundleName, assetName, ((self._tiles)[index]).icon_anchor)
    self:TryFinishFloor()
  end
end

TowerController.TryFinishFloor = function(self)
  -- function num : 0_24 , upvalues : bm_tower, _ENV
  local msgid = nil
  local last_floor = bm_tower:GetTotalFloors() <= bm_tower:GetCurrentFloor() + 1
  local has_unfinished = bm_tower:HasUnfinishedTile()
  if last_floor then
    if has_unfinished then
      msgid = 61
    else
      msgid = 48
    end
  elseif has_unfinished then
    msgid = 60
  else
    msgid = 49
  end
  ;
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(msgid, nil, function()
    -- function num : 0_24_0 , upvalues : bm_tower
    bm_tower:FinishFloor()
  end
)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

TowerController.OnTileFinish = function(self)
  -- function num : 0_25 , upvalues : bm_tower, _ENV
  local index = bm_tower:GetCurrentPos()
  if ((self._tiles)[index]).icon then
    ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(((self._tiles)[index]).icon)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._tiles)[index]).icon = nil
  end
end

TowerController.OnLateUpdate = function(self, notification)
  -- function num : 0_26 , upvalues : TransformStaticFunctions, bm_tower, movingOnPath, _ENV
  if self._needUpdate then
    local deltaTime = (notification.userInfo).deltaTime
    local x, y, z = nil, nil, nil
    if self._xTask then
      if (self._xTask):update(deltaTime) then
        x = self._desX
        self._xTask = nil
      else
        x = ((self._xTask).subject).pos
      end
    end
    if self._yTask then
      if (self._yTask):update(deltaTime) then
        y = self._desY
        self._yTask = nil
      else
        y = ((self._yTask).subject).pos
      end
    end
    if self._zTask then
      if (self._zTask):update(deltaTime) then
        z = self._desZ
        self._zTask = nil
      else
        z = ((self._zTask).subject).pos
      end
    end
    if x and y and z then
      (TransformStaticFunctions.SetPosition)(((self._sceneRef).actor).object, x, y, z)
    end
    if not self._xTask and not self._yTask and not self._zTask then
      self._needUpdate = false
      if self._desDirX then
        (((self._sceneRef).actor).animator):SetFloat((self._sceneRef)._dirX, self._desDirX)
      end
      if self._desDirY then
        (((self._sceneRef).actor).animator):SetFloat((self._sceneRef)._dirY, self._desDirY)
      end
      local current = bm_tower:GetCurrentPos()
      if self._movePath and (self._movePath)[1] then
        local canMove = movingOnPath(current, (self._movePath)[1])
        if canMove then
          (table.remove)(self._movePath, 1)
        else
          self._movePath = nil
          self:Thaw()
          self._movingState = false
        end
      else
        do
          do
            self:Thaw()
            self._movingState = false
            if self._effect then
              (self._effect)(self)
              self._effect = nil
            end
            if not self._movingState then
              self:Freeze()
              self._movingState = true
            end
          end
        end
      end
    end
  end
end

return TowerController

