local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local CUpdateUISortType = require("protocols.def.protocol.login.cupdateuisorttype")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local CFragmentLevelCfg = BeanManager.GetTableByName("dungeonselect.cfragmentlevelcfg")
local CSpirit = BeanManager.GetTableByName("dungeonselect.cdungeonselectstrength")
local CMonsterBookCfg = BeanManager.GetTableByName("handbook.cmonster_handbook")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local CFragmentImageState = BeanManager.GetTableByName("dungeonselect.cfragmentimagestate")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local CElementEffect = BeanManager.GetTableByName("role.celementeffect")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local LineUpStation = BattleClientProtocolManager.GetBeanDef("data.lineupstation")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local MaxColumnNums = 4
local FragmentMainDialog = class("FragmentMainDialog", Dialog)
FragmentMainDialog.AssetBundleName = "ui/layouts.fragment"
FragmentMainDialog.AssetName = "FragmentMain"
local rotateOnceTime = 0.5
local MillisecondToDay = 86400000
local limit

function FragmentMainDialog:Ctor(...)
  FragmentMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._tilePostion = {}
  self._tileData = {}
  self._currentTileIndex = 1
  self._target = {}
  self._tileCount = 0
  self._currentTeamData = {
    -1,
    -1,
    -1
  }
  self._teamData = {}
  self._zonesClearReward = {}
  self._lockRoleMap = {}
  self._unfrozenRoleMap = {}
  self._passAllRewardData = {}
  self._passCurrentRewardData = {}
  self._screeningConditions = {}
  self._sortCriteriaNameId = 501827
  self._isAscendingOrder = false
  self._listByConditions = {}
  self._taskList = {}
end

function FragmentMainDialog:OnCreate()
  limit = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
  self._tileGroupPanel = self:GetChild("TileGroup")
  self._tileGroup = {
    {
      tile = self:GetChild("TileGroup/Tile_02"),
      ImgFinish = self:GetChild("TileGroup/Tile_02/ImgFinish"),
      ImgNormal = self:GetChild("TileGroup/Tile_02/ImgNormal"),
      ImgNormal_icon = self:GetChild("TileGroup/Tile_02/ImgNormal/Image"),
      ImgNormal_Lv_title = self:GetChild("TileGroup/Tile_02/ImgNormal/Level"),
      ImgNormal_Lv = self:GetChild("TileGroup/Tile_02/ImgNormal/LevelNum"),
      Model = {
        self:GetChild("TileGroup/Tile_02/Model1"),
        self:GetChild("TileGroup/Tile_02/Model2"),
        self:GetChild("TileGroup/Tile_02/Model3")
      },
      ModelHandle = {
        nil,
        nil,
        nil
      }
    },
    {
      tile = self:GetChild("TileGroup/Tile_03"),
      ImgFinish = self:GetChild("TileGroup/Tile_03/ImgFinish"),
      ImgNormal = self:GetChild("TileGroup/Tile_03/ImgNormal"),
      ImgNormal_icon = self:GetChild("TileGroup/Tile_03/ImgNormal/Image"),
      ImgNormal_Lv_title = self:GetChild("TileGroup/Tile_03/ImgNormal/Level"),
      ImgNormal_Lv = self:GetChild("TileGroup/Tile_03/ImgNormal/LevelNum"),
      Model = {
        self:GetChild("TileGroup/Tile_03/Model1"),
        self:GetChild("TileGroup/Tile_03/Model2"),
        self:GetChild("TileGroup/Tile_03/Model3")
      },
      ModelHandle = {
        nil,
        nil,
        nil
      }
    },
    {
      tile = self:GetChild("TileGroup/Tile_04"),
      ImgFinish = self:GetChild("TileGroup/Tile_04/ImgFinish"),
      ImgNormal = self:GetChild("TileGroup/Tile_04/ImgNormal"),
      ImgNormal_icon = self:GetChild("TileGroup/Tile_04/ImgNormal/Image"),
      ImgNormal_Lv_title = self:GetChild("TileGroup/Tile_04/ImgNormal/Level"),
      ImgNormal_Lv = self:GetChild("TileGroup/Tile_04/ImgNormal/LevelNum"),
      Model = {
        self:GetChild("TileGroup/Tile_04/Model1"),
        self:GetChild("TileGroup/Tile_04/Model2"),
        self:GetChild("TileGroup/Tile_04/Model3")
      },
      ModelHandle = {
        nil,
        nil,
        nil
      }
    },
    {
      tile = self:GetChild("TileGroup/Tile_01"),
      ImgFinish = self:GetChild("TileGroup/Tile_01/ImgFinish"),
      ImgNormal = self:GetChild("TileGroup/Tile_01/ImgNormal"),
      ImgNormal_icon = self:GetChild("TileGroup/Tile_01/ImgNormal/Image"),
      ImgNormal_Lv_title = self:GetChild("TileGroup/Tile_01/ImgNormal/Level"),
      ImgNormal_Lv = self:GetChild("TileGroup/Tile_01/ImgNormal/LevelNum"),
      Model = {
        self:GetChild("TileGroup/Tile_01/Model1"),
        self:GetChild("TileGroup/Tile_01/Model2"),
        self:GetChild("TileGroup/Tile_01/Model3")
      },
      ModelHandle = {
        nil,
        nil,
        nil
      }
    }
  }
  self._stonImage = self:GetChild("TileGroup/StoneImg")
  self._tileCount = #self._tileGroup
  for i, v in ipairs(self._tileGroup) do
    v.tile:Subscribe_PointerClickEvent(function()
      self:OnTileClick(i)
    end)
  end
  for i, v in ipairs(self._tileGroup) do
    local x, y = v.tile:GetAnchoredPosition()
    local position = {X = x, Y = y}
    table.insert(self._tilePostion, position)
  end
  self._levelPanel = self:GetChild("LevelPanel")
  self._levelTitle = self:GetChild("LevelPanel/Title")
  self._resetTime = self:GetChild("LevelPanel/Time/Text")
  self._done = self:GetChild("LevelPanel/Done")
  self._tipsBtn = self:GetChild("LevelPanel/Tips/Ibtn")
  self._passAllRewardPanel = self:GetChild("LevelPanel/ItemFrame")
  self._rewardTitle = self:GetChild("LevelPanel/RewardTitle")
  self._passCurrentRewardPanel = self:GetChild("LevelPanel/RewardFrame")
  self._width, self._height = self._passCurrentRewardPanel:GetRectSize()
  self._anchorX, self._offsetX = self._passCurrentRewardPanel:GetXPosition()
  self._rewardDone = self:GetChild("LevelPanel/RewardDone")
  self._startBtn = self:GetChild("LevelPanel/StartBtn")
  self._startBtnTxt = self:GetChild("LevelPanel/StartBtn/_Text")
  self._passAllRewardFrame = TableFrame.Create(self._passAllRewardPanel, self, false, false, false)
  self._passCurrentRewardFrame = TableFrame.Create(self._passCurrentRewardPanel, self, false, false, false)
  self._startBtn:Subscribe_PointerClickEvent(self.OnStartBtnClick, self)
  self._teamPanel = self:GetChild("TeamPanel")
  self._levelInfoTitle = self:GetChild("TeamPanel/LevelInfo/Title")
  self._recommendLevel = self:GetChild("TeamPanel/LevelInfo/Lv")
  self._breakNumTxt = self:GetChild("TeamPanel/LevelInfo/BreakNumTxt")
  self._infoBtn = self:GetChild("TeamPanel/LevelInfo/InfoBtn")
  self._recordBtn = self:GetChild("TeamPanel/LevelInfo/RecordBtn")
  self._charNum = self:GetChild("TeamPanel/Char/CharNum")
  self._costText = self:GetChild("TeamPanel/Char/CostBack/Txt2")
  self._costTextRed = self:GetChild("TeamPanel/Char/CostBack/Txt2Red")
  self._goBtn = self:GetChild("TeamPanel/Char/GoBtn")
  self._scrollBar = self:GetChild("TeamPanel/Char/Scrollbar")
  self._charPanel = self:GetChild("TeamPanel/Char/CellFrame")
  self._charFrame = GridFrame.Create(self._charPanel, self, true, 4)
  self._infoBtn:Subscribe_PointerClickEvent(self.OnInfoBtnClick, self)
  self._recordBtn:Subscribe_PointerClickEvent(self.OnRecordBtnClick, self)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClick, self)
  self._filterBtn = self:GetChild("TeamPanel/FliterBtn")
  self._levelBtn = self:GetChild("TeamPanel/LevelBtn")
  self._levelBtnTxt = self:GetChild("TeamPanel/LevelBtn/_Text")
  self._sortBtn = self:GetChild("TeamPanel/SortBtn")
  self._sortUpBtnImg = self:GetChild("TeamPanel/SortBtn/Up")
  self._sortUpBtnImg:SetActive(self._isAscendingOrder)
  self._sortDownBtnImg = self:GetChild("TeamPanel/SortBtn/Down")
  self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt = self:GetChild("TeamPanel/SortBtn/_TextUp")
  self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt = self:GetChild("TeamPanel/SortBtn/_TextDown")
  self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  self._elementImg = self:GetChild("TeamPanel/Element")
  self._filterBtn:Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self._levelBtn:Subscribe_PointerClickEvent(self.OnLevelBtnClick, self)
  self._sortBtn:Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  self._elementImg:Subscribe_PointerClickEvent(self.OnElementBtnClick, self)
  self._filterPanel = self:GetChild("TeamPanel/BaseCharacterListFliterNew")
  self._filterDlg = require("logic.dialog.common.filterdialog").Create(self._filterPanel)
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._spiritIcon = self:GetChild("TopGroup/Num0/Icon")
  self._spiritNum = self:GetChild("TopGroup/Num0/Text")
  self._spiritAddBtn = self:GetChild("TopGroup/Num0/Add")
  self._spiritRedDot = self:GetChild("TopGroup/Num0/RedDot")
  self._spiritAddBtn:Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_EnterMianCity, nil)
  LuaNotificationCenter.AddObserver(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
  self:RefreshTeamElementInfo()
  local uiSortInfo = NekoData.BehaviorManager.BM_Game:GetUISortType(CUpdateUISortType.QUICKSET_LINEUP)
  if uiSortInfo then
    self._sortCriteriaNameId = uiSortInfo.nameTxtId or self._sortCriteriaNameId
    self._isAscendingOrder = uiSortInfo.isAscending or self._isAscendingOrder
    self._sortUpBtnImg:SetActive(self._isAscendingOrder)
    self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
    self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
    self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  end
end

function FragmentMainDialog:OnDestroy()
  self._charFrame:Destroy()
  self._passAllRewardFrame:Destroy()
  self._passCurrentRewardFrame:Destroy()
  if self._filterDlg then
    self._filterDlg:Destroy()
    self._filterDlg = nil
  end
  self._task = ServerGameTimer.AddTask(0, 60, function()
    self:ReloadTask()
  end, nil)
  LuaNotificationCenter.RemoveObserver(self)
  self:SendCUpdateUISortType()
end

function FragmentMainDialog:SetData(protocol)
  if NekoData.BehaviorManager.BM_Game:IsFragmentPanelShowRed() then
    NekoData.DataManager.DM_Game:CheckFragmentPanelRed()
    LuaNotificationCenter.PostNotification(Common.n_RefreshFragmentPanelRed, nil)
  end
  self._teamData = {}
  self._lockRoleMap = {}
  self._unfrozenRoleMap = {}
  self._passAllRewardData = {}
  self._currentTeamData = {
    -1,
    -1,
    -1
  }
  self.isInTeam = false
  self._tileData = protocol.zones
  self._zonesClearReward = protocol.zonesClearReward
  self._reloadInfoTime = protocol.reloadInfoTime
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  self._task = ServerGameTimer.AddTask(0, 60, function()
    self:ReloadTask()
  end, nil)
  local done = true
  local defultSelectTileIndex
  local passZoneCount = 0
  for i, v in ipairs(self._tileData) do
    if v.thisWeekState == 0 then
      done = false
      if not defultSelectTileIndex then
        defultSelectTileIndex = i
      end
    else
      passZoneCount = passZoneCount + 1
    end
  end
  if done then
    self._passAllRewardPanel:SetActive(false)
    self._rewardTitle:SetActive(false)
    self._done:SetActive(true)
    self._startBtn:SetActive(false)
    self._allClearReward = NekoData.BehaviorManager.BM_Activity:GetShatteredZonesClearReward()
    if self._allClearReward then
      self:GetRootWindow():PlayAnimation("FragmentClear")
    else
      self._stonImage:SetActive(false)
    end
  else
    local record = CFragmentImageState:GetRecorder(passZoneCount + 1)
    local imageRecord = CImagePathTable:GetRecorder(record.imgID) or DataCommon.DefaultImageAsset
    self._stonImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self:OnTileClick(defultSelectTileIndex)
    self._startBtn:SetActive(true)
  end
  for k, v in pairs(protocol.zonesClearReward) do
    table.insert(self._passAllRewardData, {id = k, count = v})
  end
  self._passAllRewardFrame:ReloadAllCell()
  self:RefreshCurrentTileInfo()
  self:SetTileModel()
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID)
  self._spiritNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(limit))
  self._spiritRedDot:SetActive(self:HaveSpiritItemSoonExpire())
  self:HandleSpriteEvidence()
end

function FragmentMainDialog:Refresh()
  self._rootWindow:SetAnimatorInteger("state", -1)
  self:GetRootWindow():PlayAnimation("FragmentClearHold")
  self:RecoveryTile(self._currentTileIndex)
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cgetshatteredzonesinfo")
  csend:Send()
end

function FragmentMainDialog:ReloadTask()
  local sec = self._reloadInfoTime - ServerGameTimer.GetServerTime()
  sec = math.floor(sec / 1000)
  local str = TextManager.GetText(700770)
  str = string.gsub(str, "%$parameter1%$", math.floor(os.date("!%d", sec) - 1))
  str = string.gsub(str, "%$parameter2%$", os.date("!%H", sec))
  self._resetTime:SetText(str)
end

function FragmentMainDialog:RefreshCurrentTileInfo()
  self._passCurrentRewardData = {}
  local currentTile = self._tileData[self._currentTileIndex]
  local currentTileId = currentTile.zoneIndex
  local record = CFragmentLevelCfg:GetRecorder(currentTileId)
  self._levelTitle:SetText(TextManager.GetText(record.nameID))
  if currentTile.firstPassRewards and table.nums(currentTile.firstPassRewards) > 0 then
    for k, v in pairs(currentTile.firstPassRewards) do
      table.insert(self._passCurrentRewardData, {
        id = k,
        count = v,
        first = true,
        get = currentTile.thisWeekState == 1
      })
    end
  end
  for k, v in pairs(currentTile.normalRewards) do
    table.insert(self._passCurrentRewardData, {
      id = k,
      count = v,
      get = currentTile.thisWeekState == 1
    })
  end
  self._passCurrentRewardFrame:ReloadAllCell()
  self:ChangeCellPosition()
  local str
  if currentTile.thisWeekState == 1 then
    str = TextManager.GetText(700748)
    self._startBtnTxt:SetText(str)
  else
    str = TextManager.GetText(700747)
    self._startBtnTxt:SetText(str)
  end
  self:RefreshTeamElementInfo()
end

function FragmentMainDialog:SetTileModel()
  for i, v in ipairs(self._tileData) do
    if v.thisWeekState == 1 then
      for key, value in pairs(v.LineupsRecords[1].roles) do
        if key <= 3 then
          self._lockRoleMap[value] = i
          local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(value)
          local record = role:GetModelRecord()
          if self._tileGroup[i].ModelHandle[key] then
            self._tileGroup[i].Model[key]:ReleaseModel(self._tileGroup[i].ModelHandle[key])
            self._tileGroup[i].ModelHandle[key] = nil
          end
          self._tileGroup[i].ModelHandle[key] = self._tileGroup[i].Model[key]:AddModelSync(record.assetBundle, record.assetName)
        end
      end
      self._tileGroup[i].ImgFinish:SetActive(true)
      self._tileGroup[i].ImgNormal:SetActive(false)
      self._teamData[i] = v.LineupsRecords[1].roles
    else
      local tileId = self._tileData[i].zoneIndex
      local tileRecord = CFragmentLevelCfg:GetRecorder(tileId)
      self._tileGroup[i].ImgFinish:SetActive(false)
      self._tileGroup[i].ImgNormal:SetActive(true)
      local lv = tileRecord.monsterlv
      self._tileGroup[i].ImgNormal_Lv:SetText(lv)
      self._teamData[i] = {}
    end
  end
end

function FragmentMainDialog:OnTileClick(index)
  if index == self._currentTileIndex or self._tween or self.isInTeam or #self._taskList ~= 0 then
    return
  end
  local moveTimes = index - self._currentTileIndex
  local moveTimesAbs = math.abs(moveTimes)
  local maxMoveTimes = self._tileCount / 2
  if self._currentTileIndex == self._tileCount then
    if moveTimesAbs > maxMoveTimes then
      moveTimes = moveTimes + self._tileCount
    end
  elseif moveTimesAbs > maxMoveTimes then
    moveTimes = moveTimes - self._tileCount
  end
  self:MoveTileGroup(moveTimes)
end

function FragmentMainDialog:MoveTileGroup(moveTimes)
  if 0 < moveTimes then
    self._currentTileIndex = self._currentTileIndex + moveTimes
    if self._currentTileIndex > self._tileCount then
      self._currentTileIndex = self._currentTileIndex - self._tileCount
    end
    moveTimes = math.abs(moveTimes)
    for i = 1, math.abs(moveTimes) do
      table.insert(self._taskList, function()
        GameTimer.AddTask(0, 0, function()
          self:RotateOnceClockwise()
        end)
      end)
    end
  elseif moveTimes < 0 then
    self._currentTileIndex = self._currentTileIndex + moveTimes
    if self._currentTileIndex < 1 then
      self._currentTileIndex = self._currentTileIndex + self._tileCount
    end
    moveTimes = math.abs(moveTimes)
    for i = 1, math.abs(moveTimes) do
      table.insert(self._taskList, function()
        GameTimer.AddTask(0, 0, function()
          self:RotateOnceAntiClockwise()
        end)
      end)
    end
  end
  self:RefreshCurrentTileInfo()
end

function FragmentMainDialog:RotateOnceAntiClockwise()
  self._target = {}
  for i = 2, #self._tilePostion do
    table.insert(self._target, {
      X = self._tilePostion[i].X,
      Y = self._tilePostion[i].Y
    })
  end
  table.insert(self._target, {
    X = self._tilePostion[1].X,
    Y = self._tilePostion[1].Y
  })
  self._tween = Tween.new(rotateOnceTime, self._tilePostion, self._target, "linear")
end

function FragmentMainDialog:RotateOnceClockwise()
  self._target = {}
  table.insert(self._target, {
    X = self._tilePostion[#self._tilePostion].X,
    Y = self._tilePostion[#self._tilePostion].Y
  })
  for i = 1, #self._tilePostion - 1 do
    table.insert(self._target, {
      X = self._tilePostion[i].X,
      Y = self._tilePostion[i].Y
    })
  end
  self._tween = Tween.new(rotateOnceTime, self._tilePostion, self._target, "linear")
end

function FragmentMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function FragmentMainDialog:OnBackBtnClicked()
  if self.isInTeam then
    self._rootWindow:SetAnimatorInteger("state", 1)
    self.isInTeam = false
    self._currentTeamData = {
      -1,
      -1,
      -1
    }
    self:RecoveryTile(self._currentTileIndex)
    self._unfrozenRoleMap = {}
  else
    self:Destroy()
  end
end

function FragmentMainDialog:OnInfoBtnClick()
  local dialog = DialogManager.CreateSingletonDialog("mainline.fragment.fragmentlevelinfodialog")
  if dialog then
    local tileId = self._tileData[self._currentTileIndex].zoneIndex
    local tileRecord = CFragmentLevelCfg:GetRecorder(tileId)
    dialog:SetData(tileRecord.monsterInfoID, tileRecord.monsterlv)
  end
end

function FragmentMainDialog:OnRecordBtnClick()
  local dialog = DialogManager.CreateSingletonDialog("mainline.fragment.fragmentteamrecorddialog")
  if dialog then
    local data = self._tileData[self._currentTileIndex].LineupsRecords
    dialog:SetData(data)
  end
end

function FragmentMainDialog:OnGoBtnClick()
  self._go = true
  if not self._isSpiritEnough then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100013)
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("mainline.fragment.fragmentteamconfirmdialog")
  if dialog then
    dialog:SetData(self._currentTeamData, self._currentTileIndex, self)
  end
end

function FragmentMainDialog:OnTipsBtnClick()
  local dialog = DialogManager.CreateSingletonDialog("mainline.fragment.fragmenttipsdialog")
end

function FragmentMainDialog:ScreeningAndSorting()
  self._levelBtnTxt:SetText(TextManager.GetText(self._sortCriteriaNameId))
  while self._listByConditions[#self._listByConditions] do
    table.remove(self._listByConditions, #self._listByConditions)
  end
  for i, v in ipairs(self._roleList) do
    table.insert(self._listByConditions, v)
  end
  for k, v in pairs(self._screeningConditions) do
    local select = false
    local indexMap = {}
    for index, value in ipairs(v) do
      select = true
      for i, role in ipairs(self._listByConditions) do
        if value.nameid == 501833 and role:GetRarityId() == 1 or value.nameid == 501832 and role:GetRarityId() == 2 or value.nameid == 501831 and role:GetRarityId() == 3 or value.nameid == 501834 and role:GetRarityId() == 4 or value.nameid == 502614 and role:GetRarityId() == 5 then
          indexMap[i] = i
        end
      end
    end
    for index, value in ipairs(v) do
      for i, role in ipairs(self._listByConditions) do
        if value.nameid == role:GetVocationNameId() then
          indexMap[i] = i
        end
      end
    end
    for index, value in ipairs(v) do
      for i, role in ipairs(self._listByConditions) do
        if value.nameid == 502771 and role:GetElement() == 1 or value.nameid == 502772 and role:GetElement() == 2 or value.nameid == 502773 and role:GetElement() == 3 or value.nameid == 502774 and role:GetElement() == 4 then
          indexMap[i] = i
        end
      end
    end
    if select then
      local deleteList = {}
      for i = 1, #self._listByConditions do
        if not indexMap[i] then
          table.insert(deleteList, i)
        end
      end
      while deleteList[#deleteList] do
        table.remove(self._listByConditions, deleteList[#deleteList])
        table.remove(deleteList, #deleteList)
      end
    end
  end
  table.sort(self._listByConditions, function(a, b)
    local _a, _b
    if self._sortCriteriaNameId == 501827 then
      _a = a:GetLevel()
      _b = b:GetLevel()
    elseif self._sortCriteriaNameId == 501828 then
      _a = a:GetRarityId()
      _b = b:GetRarityId()
    elseif self._sortCriteriaNameId == 501829 then
      _a = a:GetBirthDay()
      _b = b:GetBirthDay()
    end
    if _a == _b and self._sortCriteriaNameId ~= 501829 then
      local aId, bId
      if self._sortCriteriaNameId == 501827 or self._sortCriteriaNameId == 501828 then
        aId, bId = a:GetId(), b:GetId()
      end
      if aId == bId then
        local aKey, bKey
        aKey, bKey = a:GetBirthDay(), b:GetBirthDay()
        if self._isAscendingOrder then
          return aKey > bKey
        else
          return aKey < bKey
        end
      elseif self._isAscendingOrder then
        return aId < bId
      else
        return aId > bId
      end
    elseif self._isAscendingOrder then
      return _a < _b
    else
      return _a > _b
    end
  end)
  if self._charFrame then
    self._charFrame:ReloadAllCell()
  end
end

function FragmentMainDialog:OnStartBtnClick()
  self.isInTeam = true
  self._rootWindow:SetAnimatorInteger("state", 2)
  self._goBtn:SetInteractable(false)
  self:LoadTeamData()
end

function FragmentMainDialog:LoadTeamData()
  local tileId = self._tileData[self._currentTileIndex].zoneIndex
  local tileRecord = CFragmentLevelCfg:GetRecorder(tileId)
  self._levelInfoTitle:SetText(TextManager.GetText(tileRecord.nameID))
  self._recommendLevel:SetText(CRoleLevelCfgTable:GetRecorder(tileRecord.recommendLv).clientLevel)
  self._breakNumTxt:SetText(CRoleLevelCfgTable:GetRecorder(tileRecord.recommendLv).clientBreakLevel)
  if self._spirit >= tileRecord.spirit then
    self._costText:SetText(tileRecord.spirit)
    self._costText:SetActive(true)
    self._costTextRed:SetActive(false)
    self._isSpiritEnough = true
  else
    self._costTextRed:SetText(tileRecord.spirit)
    self._costText:SetActive(false)
    self._costTextRed:SetActive(true)
    self._isSpiritEnough = false
  end
  if self._tileData[self._currentTileIndex].thisWeekState == 0 then
    self._tileGroup[self._currentTileIndex].ImgNormal_icon:SetActive(false)
    self._tileGroup[self._currentTileIndex].ImgNormal_Lv:SetActive(false)
    self._tileGroup[self._currentTileIndex].ImgNormal_Lv_title:SetActive(false)
  end
  self:ClearnTile(self._currentTileIndex)
  self._charNum:SetText(0)
  self._roleList = NekoData.BehaviorManager.BM_AllRoles:GetContainMaterialRoleList()
  for i, v in pairs(self._teamData[self._currentTileIndex]) do
    self._unfrozenRoleMap[v] = true
  end
  self:ScreeningAndSorting()
end

function FragmentMainDialog:OnFilterBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 1, "Role", self._screeningConditions)
end

function FragmentMainDialog:OnLevelBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 2, "Role", self._sortCriteriaNameId)
end

function FragmentMainDialog:OnSortBtnClick()
  self._isAscendingOrder = not self._isAscendingOrder
  self._sortUpBtnImg:SetActive(self._isAscendingOrder)
  self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  self:ScreeningAndSorting()
  NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.QUICKSET_LINEUP, self._sortCriteriaNameId, self._isAscendingOrder)
end

function FragmentMainDialog:RefreshTeamElementInfo()
  local stationElementTag = {}
  local etherStationList = {}
  local ElementType = {Ether = 4}
  local haveTeamInfo = false
  for station, roleId in pairs(self._currentTeamData) do
    if roleId ~= -1 then
      haveTeamInfo = true
      stationElementTag[station] = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(roleId):GetElement()
      if stationElementTag[station] == ElementType.Ether then
        table.insert(etherStationList, station)
      end
    end
  end
  self._oneTotalElementValue = nil
  self._elementStage = nil
  if haveTeamInfo then
    if stationElementTag[LineUpStation.FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.FRONT_ROW]
      end
    elseif stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.MIDDLE_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.MIDDLE_ROW]
      end
    elseif stationElementTag[LineUpStation.BACK_ROW] and stationElementTag[LineUpStation.BACK_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.BACK_ROW]
      end
    elseif stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW]
      end
    elseif stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW]
      end
    elseif stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] and stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_BACK_ROW]
      end
    end
    if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.BACK_ROW] then
      self._elementStage = 1
      if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] then
        self._elementStage = 2
      end
      self._oneTotalElementValue = stationElementTag[LineUpStation.FRONT_ROW]
    end
  end
  local StageType = {NoStage = 0}
  if self._elementStage then
    local elementRecord = CElementEffect:GetRecorder(self._elementStage)
    local imgRecord = CImagePathTable:GetRecorder(elementRecord.image) or DataCommon.DefaultImageAsset
    self._elementImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    local elementRecord = CElementEffect:GetRecorder(StageType.NoStage)
    local imgRecord = CImagePathTable:GetRecorder(elementRecord.image) or DataCommon.DefaultImageAsset
    self._elementImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
end

function FragmentMainDialog:OnElementBtnClick()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teamelementinfodialog")
  dialog:SetData(self._oneTotalElementValue, self._elementStage)
  dialog:HideStage2()
end

function FragmentMainDialog:SetSortCriteriaNameId(nameId)
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
    NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.QUICKSET_LINEUP, self._sortCriteriaNameId, self._isAscendingOrder)
  end
end

function FragmentMainDialog:SetScreeningConditions(screeningConditions)
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

function FragmentMainDialog:OnUpdate(notification)
  if #self._taskList > 0 and self._tween == nil then
    self._taskList[1]()
    table.remove(self._taskList, 1)
  end
  if self._tween then
    local finish = self._tween:update(notification.userInfo.deltaTime)
    for i, v in ipairs(self._tileGroup) do
      v.tile:SetAnchoredPosition(self._tween.subject[i].X, self._tween.subject[i].Y)
    end
    if finish then
      self._tween = nil
    end
    local stonTransform = self._stonImage._uiObject.transform
    local targetIndex = self._stonImage._uiObject.transform:GetSiblingIndex()
    for i, v in ipairs(self._tileGroup) do
      local selfIndex = v.tile._uiObject.transform:GetSiblingIndex()
      local selfPosY = v.tile._uiObject.transform.position.y
      if 0 < selfPosY and targetIndex < selfIndex then
        v.tile._uiObject.transform:SetSiblingIndex(targetIndex)
      elseif selfPosY < 0 and targetIndex > selfIndex then
        v.tile._uiObject.transform:SetSiblingIndex(targetIndex)
      end
    end
  end
end

function FragmentMainDialog:ChangeCellPosition()
  local num = #self._passCurrentRewardData
  local cellPanelWidth
  if num < MaxColumnNums then
    cellPanelWidth = self._width / MaxColumnNums * num
  else
    cellPanelWidth = self._width
  end
  self._passCurrentRewardPanel:SetWidth(0, cellPanelWidth)
  self._passCurrentRewardPanel:SetXPosition(self._anchorX, -cellPanelWidth / 2)
  self._passCurrentRewardFrame:ReloadAllCell()
end

function FragmentMainDialog:NumberOfCell(frame, index)
  if frame == self._charFrame then
    return #self._listByConditions
  elseif frame == self._passAllRewardFrame then
    return #self._passAllRewardData
  elseif frame == self._passCurrentRewardFrame then
    return #self._passCurrentRewardData
  end
end

function FragmentMainDialog:CellAtIndex(frame, index)
  if frame == self._charFrame then
    return "mainline.fragment.fragmentteamcell"
  elseif frame == self._passAllRewardFrame then
    return "mainline.fragment.fragmentitemcell"
  elseif frame == self._passCurrentRewardFrame then
    return "mainline.fragment.fragmentitemcell"
  end
end

function FragmentMainDialog:DataAtIndex(frame, index)
  if frame == self._charFrame then
    return self._listByConditions[index]
  elseif frame == self._passAllRewardFrame then
    return self._passAllRewardData[index]
  elseif frame == self._passCurrentRewardFrame then
    return self._passCurrentRewardData[index]
  end
end

function FragmentMainDialog:OnCurPosChange(frame, proportion)
  if frame == self._charFrame then
    local width, height = self._charPanel:GetRectSize()
    local total = self._charFrame:GetTotalLength()
    if height < total then
      self._scrollBar:SetActive(true)
      self._scrollBar:SetScrollSize(height / total)
      self._scrollBar:SetScrollValue(proportion)
    else
      self._scrollBar:SetActive(false)
    end
  end
end

function FragmentMainDialog:ClearCharCellClick()
  self._charFrame:FireEvent("unselectAll")
  self._currentTeamData = {
    -1,
    -1,
    -1
  }
  self._charNum:SetText(0)
  self._goBtn:SetInteractable(false)
end

function FragmentMainDialog:OnCharCellClick(id, index)
  if self:IsRoleLock(id) and not self:IsRoleUnfrozen(id) then
    return
  end
  if index then
    self._currentTeamData[index] = -1
    self._charFrame:FireEvent("unselect", {id = id})
  else
    for i, v in ipairs(self._currentTeamData) do
      if v == -1 then
        self._currentTeamData[i] = id
        self._charFrame:FireEvent("select", {id = id, index = i})
        break
      end
    end
  end
  self:RefreshCurrentTileModel()
  local count = 0
  for i, v in ipairs(self._currentTeamData) do
    if v ~= -1 then
      count = count + 1
    end
  end
  self._charNum:SetText(count)
  if 1 <= count then
    self._goBtn:SetInteractable(true)
  else
    self._goBtn:SetInteractable(false)
  end
  self:RefreshTeamElementInfo()
end

function FragmentMainDialog:GetCurrentTeamData()
  return self._currentTeamData
end

function FragmentMainDialog:RefreshCurrentTileModel()
  for i, v in pairs(self._currentTeamData) do
    local handle = self._tileGroup[self._currentTileIndex].ModelHandle[i]
    if v ~= -1 then
      if handle == nil then
        local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v)
        local record = role:GetModelRecord()
        self._tileGroup[self._currentTileIndex].ModelHandle[i] = self._tileGroup[self._currentTileIndex].Model[i]:AddModelSync(record.assetBundle, record.assetName)
        local modelobj = TransformStaticFunctions.GetChild(self._tileGroup[self._currentTileIndex].Model[i]._uiObject, "Model/" .. record.assetName .. "(Clone)")
        local modelAnimator = AnimatorStaticFunctions.Get(modelobj)
        modelAnimator:Play("Attack")
      end
    elseif v == -1 and handle then
      self._tileGroup[self._currentTileIndex].Model[i]:ReleaseModel(handle)
      self._tileGroup[self._currentTileIndex].ModelHandle[i] = nil
    end
  end
end

function FragmentMainDialog:ClearnCurrentTile()
  local index = self._currentTileIndex
  for i, v in pairs(self._tileGroup[index].ModelHandle) do
    if v then
      self._tileGroup[index].Model[i]:ReleaseModel(v)
      self._tileGroup[index].ModelHandle[i] = nil
    end
  end
end

function FragmentMainDialog:ClearnTile(index)
  for i, v in pairs(self._tileGroup[index].ModelHandle) do
    if v then
      self._tileGroup[index].Model[i]:ReleaseModel(v)
      self._tileGroup[index].ModelHandle[i] = nil
    end
  end
end

function FragmentMainDialog:RecoveryTile(index)
  self:ClearnTile(index)
  if self._tileData[index].thisWeekState == 0 then
    self._tileGroup[index].ImgNormal_icon:SetActive(true)
    self._tileGroup[self._currentTileIndex].ImgNormal_Lv:SetActive(true)
    self._tileGroup[self._currentTileIndex].ImgNormal_Lv_title:SetActive(true)
  end
  for i, v in pairs(self._teamData[index]) do
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v)
    local record = role:GetModelRecord()
    self._tileGroup[index].ModelHandle[i] = self._tileGroup[index].Model[i]:AddModelSync(record.assetBundle, record.assetName)
  end
end

function FragmentMainDialog:OnSpiritAddBtnClick()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

function FragmentMainDialog:HaveSpiritItemSoonExpire()
  local spiritItems = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(DataCommon.SpiritItemType)
  for i, v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - ServerGameTimer.GetServerTime() < MillisecondToDay then
      return true
    end
  end
  return false
end

function FragmentMainDialog:RefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
  self._spiritNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(limit))
  local tileId = self._tileData[self._currentTileIndex].zoneIndex
  local tileRecord = CFragmentLevelCfg:GetRecorder(tileId)
  self._levelInfoTitle:SetText(TextManager.GetText(tileRecord.nameID))
  self._recommendLevel:SetText(CRoleLevelCfgTable:GetRecorder(tileRecord.recommendLv).clientLevel)
  self._breakNumTxt:SetText(CRoleLevelCfgTable:GetRecorder(tileRecord.recommendLv).clientBreakLevel)
  if self._spirit >= tileRecord.spirit then
    self._costText:SetText(tileRecord.spirit)
    self._costText:SetActive(true)
    self._costTextRed:SetActive(false)
    self._isSpiritEnough = true
  else
    self._costTextRed:SetText(tileRecord.spirit)
    self._costText:SetActive(false)
    self._costTextRed:SetActive(true)
    self._isSpiritEnough = false
  end
end

function FragmentMainDialog:IsRoleLock(roleId)
  return self._lockRoleMap[roleId]
end

function FragmentMainDialog:IsRoleUnfrozen(roleId)
  return self._unfrozenRoleMap[roleId]
end

function FragmentMainDialog:OnAnimationStateExit(handler, stateName, normalizedTime)
  if stateName == "FragmentClear" then
    self._rootWindow:SetAnimatorInteger("state", -1)
    self._stonImage:SetActive(false)
    local _data = {
      items = self._allClearReward
    }
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.ItemAccount,
      data = _data
    })
    self._allClearReward = nil
    NekoData.DataManager.DM_Activity:ClearShatteredZonesClearReward()
  end
end

function FragmentMainDialog:SendCUpdateUISortType()
  local OrderType = {Ascending = 1, Descending = 2}
  local csend = LuaNetManager.CreateProtocol("protocol.login.cupdateuisorttype")
  csend.key = CUpdateUISortType.QUICKSET_LINEUP
  local order = OrderType.Ascending
  if not self._isAscendingOrder then
    order = OrderType.Descending
  end
  csend.Showtype = self._sortCriteriaNameId * 10 + order
  csend:Send()
end

function FragmentMainDialog:HandleSpriteEvidence()
  local haveSpriteEvidence = NekoData.BehaviorManager.BM_Currency:GetSpiritRecoverTimes()[DataCommon.SpriteEvidence]
  if haveSpriteEvidence then
    local imageRecord = CImagePathTable:GetRecorder(tonumber(CVarconfig:GetRecorder(125).Value)) or DataCommon.DefaultImageAsset
    self._spiritIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    local imageRecord = Item.Create(DataCommon.SpiritID):GetIcon()
    self._spiritIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

return FragmentMainDialog
