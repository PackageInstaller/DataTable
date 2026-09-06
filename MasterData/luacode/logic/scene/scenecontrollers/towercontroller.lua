local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local SceneInfoTable = BeanManager.GetTableByName("scene.csceneinfostatic")
local CTowerDungeonType = BeanManager.GetTableByName("dungeonselect.ctowerdungeontype")
local CTowerDungeonStage = BeanManager.GetTableByName("dungeonselect.ctowerdungeonstage")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local TowerController = class("TowerController", SceneController)
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local TileCount = 7
local bm_tower = NekoData.BehaviorManager.BM_Tower

function TowerController:Init()
  TowerController.super.Init(self)
  self._tiles = {}
  self._walkingSpeed = tonumber(CVarconfig:GetRecorder(48).Value)
  self:PlaySceneBGM()
  self._dialog = DialogManager.CreateSingletonDialog("tower.scene.towerscenedialog")
  self._dialog:Init(self)
  self:BuildScene()
  self:SetCameraBorder()
  LuaNotificationCenter.AddObserver(self, self.OnCharacterMove, Common.n_TowerMove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnReturnFromBattle, Common.n_ReturnFromBattle, nil)
  LuaNotificationCenter.AddObserver(self, self.OnTileFinish, Common.n_TowerShrineActivated, nil)
  LuaNotificationCenter.AddObserver(self, self.OnTileFinish, Common.n_TowerEventResponse, nil)
  LuaNotificationCenter.AddObserver(self, self.OnTileFinish, Common.n_TowerChestOpen, nil)
  LuaNotificationCenter.AddObserver(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
end

function TowerController:OnDestroy()
  DialogManager.DestroySingletonDialog("tower.scene.towerscenedialog")
  LuaNotificationCenter.RemoveObserver(self)
  EventManager.Clear()
end

function TowerController:PlaySceneBGM()
  local v = SceneInfoTable:GetRecorder(self:GetSceneID())
  if self._isDay or v.bgmNight == 0 then
    LuaAudioManager.PlayBGM(v.bgm)
  else
    LuaAudioManager.PlayBGM(v.bgmNight)
  end
end

function TowerController:SetCameraBorder()
  local cameraType = {
    Little = 3,
    Middle = 5,
    Big = 7
  }
  self._cameraAnimatorParam = nil
  local currentTowerId = bm_tower:GetCurrentTowerID()
  local currentFloorId = bm_tower:GetCurrentFloor() + 1
  local currentTowerSections = CTowerDungeonType:GetRecorder(currentTowerId).sectionid
  local currentSectionId = tonumber(currentTowerSections[currentFloorId])
  if currentSectionId then
    self._cameraAnimatorParam = CTowerDungeonStage:GetRecorder(currentSectionId).mapRange
  else
    LogErrorFormat("TowerController", "currentTowerId %s currentFloorId %s no sectionid in ctowerdungeontype", currentTowerId, currentFloorId)
  end
  if self._cameraAnimatorParam then
    if self._cameraAnimatorParam == cameraType.Middle then
      self._cameraFollowPoint = self._sceneRef.cameraFollowPoint2
    elseif self._cameraAnimatorParam == cameraType.Big then
      self._cameraFollowPoint = self._sceneRef.cameraFollowPoint3
    else
      self._cameraFollowPoint = nil
    end
    self._sceneRef._stateDrivenCameraAnimator:SetInteger("state", self._cameraAnimatorParam)
  else
    LogWarningFormat("TowerController", "currentTowerId %s currentFloorId %s sectionid %s no mapRange in ctowerdungeonstage", currentTowerId, currentFloorId, currentSectionId)
  end
end

function TowerController:GetMainCamera()
  return self._sceneRef.mainCamera
end

local function set_link(root, dir, state)
  local link = TransformStaticFunctions.GetChild(root, "Link/" .. dir)
  TransformStaticFunctions.SetActive(link, state)
end

function TowerController:BuildScene()
  local list = NekoData.BehaviorManager.BM_Tower:GetTileInfo()
  for index, info in pairs(list) do
    local anchor = self._sceneRef.pos[info.pos.y * TileCount + info.pos.x + 1]
    local tile = CS.PixelNeko.P1.Scene.TrapHelper.CreateObject(info.cfg.assetBundleName, info.cfg.assetName, anchor)
    local icon_anchor = TransformStaticFunctions.GetChild(tile, "point")
    local icon
    if info.cfg.imgassetBundleName ~= "" and info.state ~= 1 then
      icon = CS.PixelNeko.P1.Scene.TrapHelper.CreateObject(info.cfg.imgassetBundleName, info.cfg.imgassetName, icon_anchor)
    elseif info.state == 1 and info.type == 7 then
      local assetBundleName, assetName = bm_tower:GetExitIcon()
      icon = CS.PixelNeko.P1.Scene.TrapHelper.CreateObject(assetBundleName, assetName, icon_anchor)
    end
    self._tiles[index] = {
      tile = tile,
      anchor = anchor,
      info = info,
      icon = icon,
      icon_anchor = icon_anchor
    }
    self:RefreshTile(index)
  end
  self._background = PrefabLoader.LoadAndInstantiatePrefab(NekoData.BehaviorManager.BM_Tower:GetBackground())
  TransformStaticFunctions.SetParent(self._background.transform, self._sceneRef.backgroundAnchor.transform, false)
  self:RefreshCurrent()
end

function TowerController:Freeze()
  if self._dialog then
    self._dialog:Freeze()
  end
end

function TowerController:Thaw()
  if self._dialog then
    self._dialog:Thaw()
  end
end

local function get_index_by_tile(self, anchor)
  for i, v in pairs(self._tiles) do
    if v.tile == anchor then
      return i
    end
  end
end

local function movingOnPath(current, next)
  local lhsState = bm_tower:GetTileState(current)
  local lhsType = bm_tower:GetTileType(current)
  local rhsState = bm_tower:GetTileState(next)
  local rhsType = bm_tower:GetTileType(next)
  local canMove = false
  if lhsState == 0 then
    canMove = lhsType == 99 or rhsState == 1 or rhsType == 99
  elseif lhsState == 1 then
    canMove = true
  elseif lhsState == 2 then
    canMove = rhsState == 1 or rhsType == 99
  end
  if canMove then
    bm_tower:MoveTo(next)
  end
  return canMove
end

function TowerController:OnTileClick(tile)
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
      local canMove = movingOnPath(current, self._movePath[1])
      if canMove then
        table.remove(self._movePath, 1)
      else
        self._movePath = nil
        self:Thaw()
        self._movingState = false
      end
    end
  end
end

function TowerController:OnCurrentTileClick()
  if self._xTask or self._yTask or self._zTask or self._movePath and #self._movePath ~= 0 then
    return
  end
  self._resume = true
  bm_tower:MoveTo(bm_tower:GetCurrentPos())
end

function TowerController:RefreshTile(index)
  local info = self._tiles[index].info
  local visible = true
  local upTitleState = false
  local downTitleState = false
  local leftTitleState = false
  local rightTitleState = false
  if self._tiles[info.neighborID.north] then
    if not self._tiles[info.neighborID.north].info.titleShowState.south then
      upTitleState = info.neighborID.north ~= 0 and visible
    end
  else
    upTitleState = info.neighborID.north ~= 0 and visible
  end
  self._tiles[index].info.titleShowState.north = upTitleState
  if self._tiles[info.neighborID.south] then
    if not self._tiles[info.neighborID.south].info.titleShowState.north then
      downTitleState = info.neighborID.south ~= 0 and visible
    end
  else
    downTitleState = info.neighborID.south ~= 0 and visible
  end
  self._tiles[index].info.titleShowState.south = downTitleState
  if self._tiles[info.neighborID.west] then
    if not self._tiles[info.neighborID.west].info.titleShowState.east then
      leftTitleState = info.neighborID.west ~= 0 and visible
    end
  else
    leftTitleState = info.neighborID.west ~= 0 and visible
  end
  self._tiles[index].info.titleShowState.west = leftTitleState
  if self._tiles[info.neighborID.east] then
    if not self._tiles[info.neighborID.east].info.titleShowState.west then
      rightTitleState = info.neighborID.east ~= 0 and visible
    end
  else
    rightTitleState = info.neighborID.east ~= 0 and visible
  end
  self._tiles[index].info.titleShowState.east = rightTitleState
  set_link(self._tiles[index].tile, "Up", upTitleState)
  set_link(self._tiles[index].tile, "Down", downTitleState)
  set_link(self._tiles[index].tile, "Left", leftTitleState)
  set_link(self._tiles[index].tile, "Right", rightTitleState)
  TransformStaticFunctions.SetActive(self._tiles[index].icon_anchor, bm_tower:ShouldTileIconShow(index))
end

function TowerController:OnBattleTile()
  local dialog = DialogManager.CreateSingletonDialog("tower.towerbattledialog")
  local info = bm_tower:GetEnemy(bm_tower:GetCurrentPos())
  dialog:SetData(bm_tower:GetCurrentPos(), info)
end

function TowerController:OnChestTile()
  local dialog = DialogManager.CreateSingletonDialog("tower.towerchestdialog")
  dialog:SetData(bm_tower:GetCurrentPos(), 3)
end

function TowerController:OnGoblinChestTile()
  local dialog = DialogManager.CreateSingletonDialog("tower.towerchestdialog")
  local info = self._tiles[bm_tower:GetCurrentPos()].info
  local choice = string.split(info.param, "@")
  for k, v in pairs(choice) do
    choice[k] = tonumber(v)
  end
  dialog:SetData(bm_tower:GetCurrentPos(), 4, choice)
end

function TowerController:OnBestQualityChestTile()
  local dialog = DialogManager.CreateSingletonDialog("tower.towerchestdialog")
  dialog:SetData(bm_tower:GetCurrentPos(), 5)
end

function TowerController:OnEventTile()
  local info = self._tiles[bm_tower:GetCurrentPos()].info
  local dialog = DialogManager.CreateSingletonDialog("tower.towereventdialog")
  dialog:SetData(bm_tower:GetCurrentPos(), tonumber(info.param))
end

function TowerController:OnShrineTile()
  local info = self._tiles[bm_tower:GetCurrentPos()].info
  local dialog = DialogManager.CreateSingletonDialog("tower.towershrinedialog")
  dialog:SetData(bm_tower:GetCurrentPos(), tonumber(info.param))
end

local handler = {
  [1] = TowerController.OnBattleTile,
  [2] = TowerController.OnBattleTile,
  [3] = TowerController.OnChestTile,
  [4] = TowerController.OnGoblinChestTile,
  [5] = TowerController.OnBestQualityChestTile,
  [6] = TowerController.OnEventTile,
  [7] = TowerController.OnBattleTile,
  [8] = TowerController.OnShrineTile
}

function TowerController:RefreshCurrent()
  local index = bm_tower:GetCurrentPos()
  local x, y, z = TransformStaticFunctions.GetPosition(self._tiles[index].anchor)
  if self._resume == false then
    self._desX, self._desY, self._desZ = x, y, z
    local preX, preY, preZ = TransformStaticFunctions.GetPosition(self._sceneRef.actor.object)
    if x > preX and y > preY then
      self._sceneRef.actor.animator:SetFloat(self._sceneRef._dirX, 1.0)
      self._sceneRef.actor.animator:SetFloat(self._sceneRef._dirY, 1.0)
      self._desDirX, self._desDirY = 0.5, 0.5
    elseif x > preX and y < preY then
      self._sceneRef.actor.animator:SetFloat(self._sceneRef._dirX, 1.0)
      self._sceneRef.actor.animator:SetFloat(self._sceneRef._dirY, -1.0)
      self._desDirX, self._desDirY = 0.5, -0.5
    elseif x < preX and y < preY then
      self._sceneRef.actor.animator:SetFloat(self._sceneRef._dirX, -1.0)
      self._sceneRef.actor.animator:SetFloat(self._sceneRef._dirY, -1.0)
      self._desDirX, self._desDirY = -0.5, -0.5
    elseif x < preX and y > preY then
      self._sceneRef.actor.animator:SetFloat(self._sceneRef._dirX, -1.0)
      self._sceneRef.actor.animator:SetFloat(self._sceneRef._dirY, 1.0)
      self._desDirX, self._desDirY = -0.5, 0.5
    end
    local first = {pos = preX}
    local last = {pos = x}
    self._xTask = Tween.new(self._walkingSpeed, first, last, "linear")
    first = {pos = preY}
    last = {pos = y}
    self._yTask = Tween.new(self._walkingSpeed, first, last, "linear")
    first = {pos = preZ}
    last = {pos = z}
    self._zTask = Tween.new(self._walkingSpeed, first, last, "linear")
    self._needUpdate = true
  else
    self._resume = false
    TransformStaticFunctions.SetPosition(self._sceneRef.actor.object, x, y, z)
  end
  for i, _ in pairs(self._tiles) do
    self:RefreshTile(i)
  end
end

function TowerController:MoveCamera(xScreenOffset, yScreenOffset)
  if self._cameraFollowPoint then
    local transform = self._cameraFollowPoint.transform
    transform:Translate(xScreenOffset, yScreenOffset, 0, CS.UnityEngine.Space.World)
    return true
  end
  return false
end

function TowerController:OnCharacterMove()
  self:RefreshCurrent()
  local index = bm_tower:GetCurrentPos()
  if bm_tower:GetTileState(index) ~= 1 then
    local type = bm_tower:GetTileType(index)
    if type ~= 99 then
      function self._effect(c)
        handler[type](c)
      end
    end
  elseif bm_tower:GetTileType(index) == 7 then
    function self._effect(s)
      s:TryFinishFloor()
    end
  end
  if self._effect and not self._needUpdate then
    self._effect(self)
    self._effect = nil
  end
end

function TowerController:OnReturnFromBattle(notification)
  if self._cameraAnimatorParam then
    self._sceneRef._stateDrivenCameraAnimator:SetInteger("state", self._cameraAnimatorParam)
  end
  if notification.userInfo.battleResult == 0 then
    return
  end
  local index = bm_tower:GetCurrentPos()
  CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._tiles[index].icon)
  self._tiles[index].icon = nil
  if bm_tower:GetTileType(index) == 7 then
    local assetBundleName, assetName = bm_tower:GetExitIcon()
    self._tiles[index].icon = CS.PixelNeko.P1.Scene.TrapHelper.CreateObject(assetBundleName, assetName, self._tiles[index].icon_anchor)
    self:TryFinishFloor()
  end
end

function TowerController:TryFinishFloor()
  local msgid
  local last_floor = bm_tower:GetCurrentFloor() + 1 >= bm_tower:GetTotalFloors()
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
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(msgid, nil, function()
    bm_tower:FinishFloor()
  end)
end

function TowerController:OnTileFinish()
  local index = bm_tower:GetCurrentPos()
  if self._tiles[index].icon then
    CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._tiles[index].icon)
    self._tiles[index].icon = nil
  end
end

function TowerController:OnLateUpdate(notification)
  if self._needUpdate then
    local deltaTime = notification.userInfo.deltaTime
    local x, y, z
    if self._xTask then
      if self._xTask:update(deltaTime) then
        x = self._desX
        self._xTask = nil
      else
        x = self._xTask.subject.pos
      end
    end
    if self._yTask then
      if self._yTask:update(deltaTime) then
        y = self._desY
        self._yTask = nil
      else
        y = self._yTask.subject.pos
      end
    end
    if self._zTask then
      if self._zTask:update(deltaTime) then
        z = self._desZ
        self._zTask = nil
      else
        z = self._zTask.subject.pos
      end
    end
    if x and y and z then
      TransformStaticFunctions.SetPosition(self._sceneRef.actor.object, x, y, z)
    end
    if not self._xTask and not self._yTask and not self._zTask then
      self._needUpdate = false
      if self._desDirX then
        self._sceneRef.actor.animator:SetFloat(self._sceneRef._dirX, self._desDirX)
      end
      if self._desDirY then
        self._sceneRef.actor.animator:SetFloat(self._sceneRef._dirY, self._desDirY)
      end
      local current = bm_tower:GetCurrentPos()
      if self._movePath and self._movePath[1] then
        local canMove = movingOnPath(current, self._movePath[1])
        if canMove then
          table.remove(self._movePath, 1)
        else
          self._movePath = nil
          self:Thaw()
          self._movingState = false
        end
      else
        self:Thaw()
        self._movingState = false
      end
      if self._effect then
        self._effect(self)
        self._effect = nil
      end
    elseif not self._movingState then
      self:Freeze()
      self._movingState = true
    end
  end
end

return TowerController
