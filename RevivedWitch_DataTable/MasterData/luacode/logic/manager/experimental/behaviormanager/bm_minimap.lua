-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_minimap.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cSceneJump = (BeanManager.GetTableByName)("scene.cscenejump")
local BM_MiniMap = class("BM_MiniMap")
local MiniMap = ((((CS.PixelNeko).P1).Scene).MiniMap).MiniMap
local Vector2 = (CS.UnityEngine).Vector2
local InitMiniMap = function(self)
  -- function num : 0_0 , upvalues : _ENV, MiniMap
  self._miniMapDialog = (DialogManager.CreateSingletonDialog)("minimap.minimapdialog")
  self._miniMap = (MiniMap.GetMiniMap)((self._miniMapDialog):GetMiniMapGameObject())
  ;
  (self._miniMap):Init(self._assetBundle, self._assetName, nil)
  ;
  (self._miniMap):InitPrefab(-1, "ui/layouts.minimap.assetbundle", "MiniMapTile")
  ;
  (self._miniMap):InitPrefab(-2, "ui/layouts.minimap.assetbundle", "HorizontalMiniMapBorder")
  ;
  (self._miniMap):InitPrefab(-3, "ui/layouts.minimap.assetbundle", "VerticalMiniMapBorder")
  local recorder = (BeanManager.GetTableByName)("scene.cscenemapcutlinecfg")
  local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
  for _,i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    local imagepath = cimagepath:GetRecorder(record.imgID)
    ;
    (self._miniMap):InitSprite(i, imagepath.assetBundle, imagepath.assetName)
  end
  local specialPoints = (self._dm):GetSpecialPoints()
  for k,v in pairs(specialPoints) do
    self:AddObject(3, v[1], v[2], true)
  end
  local rowColCount = (self._miniMap).GroundRowColCount
  self._rowColCount = {x = rowColCount.x, y = rowColCount.y}
  ;
  (self._dm):InitMap(rowColCount.x, rowColCount.y)
  if (self._dm):IsMapOpened() == false then
    (self._miniMap):InitDynamicGround((self._dm):GetVisibleAreas(), (self._dm):GetOutVisibleAreas())
  end
  ;
  (self._miniMap):GenerateMiniMap()
end

local OnBattleStateEnter = function(self)
  -- function num : 0_1
  self._isInBattle = true
end

local OnBattleStateExit = function(self)
  -- function num : 0_2
  self._isInBattle = false
end

BM_MiniMap.Ctor = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._dm = (NekoData.DataManager).DM_MiniMap
  self._miniMapDialog = nil
  self._miniMap = nil
  self._assetBundle = nil
  self._assetName = nil
  self._timer = 0
  self._sceneID = nil
  self._exitList = nil
  self._rowColCount = nil
  self._tempDynamicGroundInfo = nil
  self._tempOutDynamicGroundInfo = nil
  self._isInBattle = false
  self._lastRow = nil
  self._lastCol = nil
  self._miniMap = nil
  self._halfVisibleRowCount = nil
  self._halfVisibleColCount = nil
  self._tmepCount = 0
  self._tempTable = {}
end

BM_MiniMap.Init = function(self, sceneID, assetBundle, assetName, isSmall)
  -- function num : 0_4 , upvalues : InitMiniMap, _ENV, cSceneJump, OnBattleStateEnter, OnBattleStateExit
  self._assetBundle = assetBundle
  self._assetName = assetName
  self._sceneID = sceneID
  InitMiniMap(self)
  self._lastRow = -999
  self._lastCol = -999
  local rowColCountInSmall = (self._miniMap).RowColCountInSmall
  self._halfVisibleRowCount = (math.floor)(rowColCountInSmall.x / 2) + 1
  self._halfVisibleColCount = (math.floor)(rowColCountInSmall.y / 2) + 1
  if isSmall == true then
    self:SetSmall()
  else
    self:SetFullScreen()
  end
  local record = cSceneJump:GetRecorder(self._sceneID)
  self._exitList = {}
  local exitSituation = record.exitSituation
  local isShowInMap = record.isShowInMap
  for k,v in pairs(exitSituation) do
    if isShowInMap[k] == 1 then
      local exitInfo = (string.split)(v, ",")
      ;
      (table.insert)(self._exitList, {[1] = tonumber(exitInfo[2]), [2] = tonumber(exitInfo[1])})
    end
  end
  ;
  (self._miniMap):InitNavImage(#self._exitList)
  ;
  (self._miniMapDialog):Init(self._miniMap, #self._exitList)
  ;
  (LuaNotificationCenter.AddObserver)(self, OnBattleStateEnter, Common.n_BattleStateEnter, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, OnBattleStateExit, Common.n_BattleStateExit, nil)
end

BM_MiniMap.GetCurrentAssetBundleInfo = function(self)
  -- function num : 0_5
  return self._sceneID, self._assetBundle, self._assetName
end

BM_MiniMap.IsValidCoord = function(self, row, col)
  -- function num : 0_6
  return (self._dm):IsValidCoord(row, col)
end

BM_MiniMap.AddObject = function(self, type, row, col, isInFog)
  -- function num : 0_7
  if self:IsValidCoord(row, col) == false then
    return -1
  end
  local id = (self._dm):AddObject()
  if (self._dm):IsMapOpened() then
    isInFog = false
  end
  ;
  (self._miniMap):AddObject(id, type, row, col, isInFog)
  return id
end

BM_MiniMap.RemoveObject = function(self, id)
  -- function num : 0_8
  (self._miniMap):RemoveObject(id)
end

BM_MiniMap.MoveObject = function(self, id, row, col)
  -- function num : 0_9
  (self._miniMap):MoveObject(id, row, col)
end

BM_MiniMap.SetObjectInOrOutFog = function(self, id, isInFog)
  -- function num : 0_10
  (self._miniMap):SetObjectInOrOutFog(id, isInFog)
end

BM_MiniMap.SetCenter = function(self, row, col)
  -- function num : 0_11
  (self._miniMap):SetCenter(row, col)
end

BM_MiniMap.SetActorAsCenter = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local freeCol, freeRow = ((NekoData.BehaviorManager).BM_Dungeon):GetFreeActorGridPosition()
  self:SetCenter(freeRow, freeCol)
  ;
  (self._miniMap):MoveActor(freeRow, freeCol)
  for k,v in ipairs(self._exitList) do
    (self._miniMapDialog):SetNavImage(k, freeRow, freeCol, v[1], v[2])
  end
  local col, row = ((NekoData.BehaviorManager).BM_Dungeon):GetActorGridPosition()
  if self._lastRow == row and self._lastCol == col then
    return 
  end
  self._tempDynamicGroundInfo = {}
  self._tempOutDynamicGroundInfo = {}
  local rowOffset = row - self._lastRow
  local colOffset = col - self._lastCol
  if rowOffset * colOffset == 0 and rowOffset >= -1 and rowOffset <= 1 and colOffset >= -1 and colOffset <= 1 then
    if colOffset == 0 then
      local rowIndex = row + rowOffset * self._halfVisibleRowCount
      for colShift = -self._halfVisibleColCount, self._halfVisibleColCount do
        self:SetVisible(rowIndex, col + colShift, 0)
      end
      rowIndex = rowIndex - rowOffset
      for colShift = -self._halfVisibleColCount, self._halfVisibleColCount do
        self:SetVisible(rowIndex, col + colShift, 1)
      end
    else
      do
        local colIndex = col + colOffset * self._halfVisibleColCount
        for rowShift = -self._halfVisibleRowCount, self._halfVisibleRowCount do
          self:SetVisible(row + rowShift, colIndex, 0)
        end
        colIndex = colIndex - colOffset
        for rowShift = -self._halfVisibleRowCount, self._halfVisibleRowCount do
          self:SetVisible(row + rowShift, colIndex, 1)
        end
        do
          for rowShift = -self._halfVisibleRowCount, self._halfVisibleRowCount do
            for colShift = -self._halfVisibleColCount, self._halfVisibleColCount do
              if rowShift == -self._halfVisibleRowCount or rowShift == self._halfVisibleRowCount or colShift == -self._halfVisibleColCount or colShift == self._halfVisibleColCount then
                self:SetVisible(row + rowShift, col + colShift, 0)
              else
                self:SetVisible(row + rowShift, col + colShift, 1)
              end
            end
          end
          do
            if #self._tempDynamicGroundInfo ~= 0 or #self._tempOutDynamicGroundInfo ~= 0 then
              (self._miniMap):SetDynamicGround(self._tempDynamicGroundInfo, self._tempOutDynamicGroundInfo)
            end
            self._tempDynamicGroundInfo = nil
            self._tempOutDynamicGroundInfo = nil
            self._lastRow = row
            self._lastCol = col
          end
        end
      end
    end
  end
end

BM_MiniMap.SetVisible = function(self, row, col, state)
  -- function num : 0_13 , upvalues : _ENV
  if (self._dm):IsMapOpened() == true then
    return 
  end
  if self:IsValidCoord(row, col) == false then
    return 
  end
  -- DECOMPILER ERROR at PC33: Unhandled construct in 'MakeBoolean' P1

  if state == 0 and (self._dm):IsOutAreaVisible(row, col) ~= true and (self._dm):IsAreaVisible(row, col) ~= true then
    (self._dm):SetOutVisibleArea(row, col)
    ;
    (self._dm):CacheOutVisibleArea(row, col)
    ;
    (table.insert)(self._tempOutDynamicGroundInfo, {[1] = row, [2] = col})
  end
  if (self._dm):IsOutAreaVisible(row, col) == true then
    (self._dm):SetOutVisibleToVisible(row, col)
    ;
    (self._dm):CacheOutVisibleToVisible(row, col)
    ;
    (table.insert)(self._tempDynamicGroundInfo, {[1] = row, [2] = col})
  else
    if (self._dm):IsAreaVisible(row, col) ~= true then
      (self._dm):SetVisibleArea(row, col)
      ;
      (self._dm):CacheVisibleArea(row, col)
      ;
      (table.insert)(self._tempDynamicGroundInfo, {[1] = row, [2] = col})
    end
  end
end

BM_MiniMap.SetSmall = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self._miniMapDialog == nil then
    return 
  end
  local dungeonHUD = (DialogManager.GetDialog)("dungeon.dungeonhud")
  if dungeonHUD == nil then
    return 
  end
  ;
  (DialogManager.ReplaceParentNode)("minimap.minimapdialog", "dungeon.dungeonhud", dungeonHUD:GetMiniMapOrigin())
  ;
  (self._miniMap):SetSmall()
  ;
  (self._miniMap):SetMiniMapRT(true)
  ;
  (self._miniMapDialog):ShowNavImage(true)
  ;
  (self._miniMapDialog):CanDrag(false)
  ;
  (self._miniMapDialog):CanZoom(false)
end

BM_MiniMap.SetFullScreen = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self._miniMapDialog == nil then
    return 
  end
  local dungeonMenuDialog = (DialogManager.GetDialog)("dungeon.dungeonmenudialog")
  if dungeonMenuDialog == nil then
    return 
  end
  ;
  (DialogManager.ReplaceParentNode)("minimap.minimapdialog", "dungeon.dungeonmenudialog", dungeonMenuDialog:GetMiniMapOrigin())
  ;
  (self._miniMap):SetFullScreen()
  if (self._dm):IsMapOpened() then
    (self._miniMap):SetMiniMapRT(true)
  else
    ;
    (self._miniMap):SetMiniMapRT(false)
  end
  ;
  (self._miniMapDialog):SetFullScreen()
  ;
  (self._miniMapDialog):ShowNavImage(false)
  ;
  (self._miniMapDialog):CanDrag(true)
  ;
  (self._miniMapDialog):CanZoom(true)
end

BM_MiniMap.SetActive = function(self, isActive)
  -- function num : 0_16
  if self._miniMapDialog then
    (self._miniMapDialog):SetActive(isActive)
  end
end

BM_MiniMap.OnDestroy = function(self)
  -- function num : 0_17
  self:SendVisibleArea()
  if self._miniMap then
    self._miniMap = nil
  end
  if self._miniMapDialog then
    (self._miniMapDialog):Destroy()
    self._miniMapDialog = nil
  end
end

BM_MiniMap.OnUpdate = function(self, deltaTime, unscaledDeltaTime)
  -- function num : 0_18
  if self._isInBattle then
    return 
  end
  if (self._dm):IsSwitching() then
    return 
  end
  self:SetActorAsCenter()
  if (self._dm):IsMapOpened() == true then
    return 
  end
  if self._timer > 5 then
    self._timer = 0
    self:SendVisibleArea()
    return 
  end
  self._timer = self._timer + deltaTime
end

BM_MiniMap.SendVisibleArea = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local cachedVisibleArea = (self._dm):GetCachedVisibleArea()
  local cachedOutVisibleArea = (self._dm):GetCachedOutVisibleArea()
  do
    if #cachedVisibleArea ~= 0 or #cachedOutVisibleArea ~= 0 then
      local cUpdateFogAreal = (LuaNetManager.CreateProtocol)("protocol.battle.cupdatefogareal")
      if cUpdateFogAreal then
        cUpdateFogAreal.points = cachedVisibleArea
        cUpdateFogAreal.prePoints = cachedOutVisibleArea
        cUpdateFogAreal.sceneId = self._sceneID
        cUpdateFogAreal:Send()
      end
    end
    ;
    (self._dm):ClearCachedVisibleArea()
    ;
    (self._dm):ClearCachedOutVisibleArea()
  end
end

return BM_MiniMap

