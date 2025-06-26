-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/fragment/fragmentmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local CUpdateUISortType = require("protocols.def.protocol.login.cupdateuisorttype")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local CFragmentLevelCfg = (BeanManager.GetTableByName)("dungeonselect.cfragmentlevelcfg")
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
local CMonsterBookCfg = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CFragmentImageState = (BeanManager.GetTableByName)("dungeonselect.cfragmentimagestate")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local CElementEffect = (BeanManager.GetTableByName)("role.celementeffect")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local LineUpStation = (BattleClientProtocolManager.GetBeanDef)("data.lineupstation")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local MaxColumnNums = 4
local FragmentMainDialog = class("FragmentMainDialog", Dialog)
FragmentMainDialog.AssetBundleName = "ui/layouts.fragment"
FragmentMainDialog.AssetName = "FragmentMain"
local rotateOnceTime = 0.5
local MillisecondToDay = 86400000
local limit = nil
FragmentMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FragmentMainDialog
  ((FragmentMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._tilePostion = {}
  self._tileData = {}
  self._currentTileIndex = 1
  self._target = {}
  self._tileCount = 0
  self._currentTeamData = {-1, -1, -1}
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

FragmentMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : limit, _ENV, TableFrame, GridFrame, CUpdateUISortType
  limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  self._tileGroupPanel = self:GetChild("TileGroup")
  self._tileGroup = {
{tile = self:GetChild("TileGroup/Tile_02"), ImgFinish = self:GetChild("TileGroup/Tile_02/ImgFinish"), ImgNormal = self:GetChild("TileGroup/Tile_02/ImgNormal"), ImgNormal_icon = self:GetChild("TileGroup/Tile_02/ImgNormal/Image"), ImgNormal_Lv_title = self:GetChild("TileGroup/Tile_02/ImgNormal/Level"), ImgNormal_Lv = self:GetChild("TileGroup/Tile_02/ImgNormal/LevelNum"), 
Model = {self:GetChild("TileGroup/Tile_02/Model1"), self:GetChild("TileGroup/Tile_02/Model2"), self:GetChild("TileGroup/Tile_02/Model3")}
, 
ModelHandle = {nil, nil, nil}
}
, 
{tile = self:GetChild("TileGroup/Tile_03"), ImgFinish = self:GetChild("TileGroup/Tile_03/ImgFinish"), ImgNormal = self:GetChild("TileGroup/Tile_03/ImgNormal"), ImgNormal_icon = self:GetChild("TileGroup/Tile_03/ImgNormal/Image"), ImgNormal_Lv_title = self:GetChild("TileGroup/Tile_03/ImgNormal/Level"), ImgNormal_Lv = self:GetChild("TileGroup/Tile_03/ImgNormal/LevelNum"), 
Model = {self:GetChild("TileGroup/Tile_03/Model1"), self:GetChild("TileGroup/Tile_03/Model2"), self:GetChild("TileGroup/Tile_03/Model3")}
, 
ModelHandle = {nil, nil, nil}
}
, 
{tile = self:GetChild("TileGroup/Tile_04"), ImgFinish = self:GetChild("TileGroup/Tile_04/ImgFinish"), ImgNormal = self:GetChild("TileGroup/Tile_04/ImgNormal"), ImgNormal_icon = self:GetChild("TileGroup/Tile_04/ImgNormal/Image"), ImgNormal_Lv_title = self:GetChild("TileGroup/Tile_04/ImgNormal/Level"), ImgNormal_Lv = self:GetChild("TileGroup/Tile_04/ImgNormal/LevelNum"), 
Model = {self:GetChild("TileGroup/Tile_04/Model1"), self:GetChild("TileGroup/Tile_04/Model2"), self:GetChild("TileGroup/Tile_04/Model3")}
, 
ModelHandle = {nil, nil, nil}
}
, 
{tile = self:GetChild("TileGroup/Tile_01"), ImgFinish = self:GetChild("TileGroup/Tile_01/ImgFinish"), ImgNormal = self:GetChild("TileGroup/Tile_01/ImgNormal"), ImgNormal_icon = self:GetChild("TileGroup/Tile_01/ImgNormal/Image"), ImgNormal_Lv_title = self:GetChild("TileGroup/Tile_01/ImgNormal/Level"), ImgNormal_Lv = self:GetChild("TileGroup/Tile_01/ImgNormal/LevelNum"), 
Model = {self:GetChild("TileGroup/Tile_01/Model1"), self:GetChild("TileGroup/Tile_01/Model2"), self:GetChild("TileGroup/Tile_01/Model3")}
, 
ModelHandle = {nil, nil, nil}
}
}
  self._stonImage = self:GetChild("TileGroup/StoneImg")
  self._tileCount = #self._tileGroup
  for i,v in ipairs(self._tileGroup) do
    do
      (v.tile):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnTileClick(i)
  end
)
    end
  end
  for i,v in ipairs(self._tileGroup) do
    local x, y = (v.tile):GetAnchoredPosition()
    local position = {X = x, Y = y}
    ;
    (table.insert)(self._tilePostion, position)
  end
  self._levelPanel = self:GetChild("LevelPanel")
  self._levelTitle = self:GetChild("LevelPanel/Title")
  self._resetTime = self:GetChild("LevelPanel/Time/Text")
  self._done = self:GetChild("LevelPanel/Done")
  self._tipsBtn = self:GetChild("LevelPanel/Tips/Ibtn")
  self._passAllRewardPanel = self:GetChild("LevelPanel/ItemFrame")
  self._rewardTitle = self:GetChild("LevelPanel/RewardTitle")
  self._passCurrentRewardPanel = self:GetChild("LevelPanel/RewardFrame")
  self._width = (self._passCurrentRewardPanel):GetRectSize()
  self._anchorX = (self._passCurrentRewardPanel):GetXPosition()
  self._rewardDone = self:GetChild("LevelPanel/RewardDone")
  self._startBtn = self:GetChild("LevelPanel/StartBtn")
  self._startBtnTxt = self:GetChild("LevelPanel/StartBtn/_Text")
  self._passAllRewardFrame = (TableFrame.Create)(self._passAllRewardPanel, self, false, false, false)
  self._passCurrentRewardFrame = (TableFrame.Create)(self._passCurrentRewardPanel, self, false, false, false)
  ;
  (self._startBtn):Subscribe_PointerClickEvent(self.OnStartBtnClick, self)
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
  self._charFrame = (GridFrame.Create)(self._charPanel, self, true, 4)
  ;
  (self._infoBtn):Subscribe_PointerClickEvent(self.OnInfoBtnClick, self)
  ;
  (self._recordBtn):Subscribe_PointerClickEvent(self.OnRecordBtnClick, self)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClick, self)
  self._filterBtn = self:GetChild("TeamPanel/FliterBtn")
  self._levelBtn = self:GetChild("TeamPanel/LevelBtn")
  self._levelBtnTxt = self:GetChild("TeamPanel/LevelBtn/_Text")
  self._sortBtn = self:GetChild("TeamPanel/SortBtn")
  self._sortUpBtnImg = self:GetChild("TeamPanel/SortBtn/Up")
  ;
  (self._sortUpBtnImg):SetActive(self._isAscendingOrder)
  self._sortDownBtnImg = self:GetChild("TeamPanel/SortBtn/Down")
  ;
  (self._sortDownBtnImg):SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt = self:GetChild("TeamPanel/SortBtn/_TextUp")
  ;
  (self._sortUpBtnTxt):SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt = self:GetChild("TeamPanel/SortBtn/_TextDown")
  ;
  (self._sortDownBtnTxt):SetActive(not self._isAscendingOrder)
  self._elementImg = self:GetChild("TeamPanel/Element")
  ;
  (self._filterBtn):Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  ;
  (self._levelBtn):Subscribe_PointerClickEvent(self.OnLevelBtnClick, self)
  ;
  (self._sortBtn):Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  ;
  (self._elementImg):Subscribe_PointerClickEvent(self.OnElementBtnClick, self)
  self._filterPanel = self:GetChild("TeamPanel/BaseCharacterListFliterNew")
  self._filterDlg = ((require("logic.dialog.common.filterdialog")).Create)(self._filterPanel)
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._spiritIcon = self:GetChild("TopGroup/Num0/Icon")
  self._spiritNum = self:GetChild("TopGroup/Num0/Text")
  self._spiritAddBtn = self:GetChild("TopGroup/Num0/Add")
  self._spiritRedDot = self:GetChild("TopGroup/Num0/RedDot")
  ;
  (self._spiritAddBtn):Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_EnterMianCity, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
  self:RefreshTeamElementInfo()
  local uiSortInfo = ((NekoData.BehaviorManager).BM_Game):GetUISortType(CUpdateUISortType.QUICKSET_LINEUP)
  if uiSortInfo then
    if not uiSortInfo.nameTxtId then
      self._sortCriteriaNameId = self._sortCriteriaNameId
      if not uiSortInfo.isAscending then
        self._isAscendingOrder = self._isAscendingOrder
        ;
        (self._sortUpBtnImg):SetActive(self._isAscendingOrder)
        ;
        (self._sortDownBtnImg):SetActive(not self._isAscendingOrder)
        ;
        (self._sortUpBtnTxt):SetActive(self._isAscendingOrder)
        ;
        (self._sortDownBtnTxt):SetActive(not self._isAscendingOrder)
      end
    end
  end
end

FragmentMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._charFrame):Destroy()
  ;
  (self._passAllRewardFrame):Destroy()
  ;
  (self._passCurrentRewardFrame):Destroy()
  if self._filterDlg then
    (self._filterDlg):Destroy()
    self._filterDlg = nil
  end
  self._task = (ServerGameTimer.AddTask)(0, 60, function()
    -- function num : 0_2_0 , upvalues : self
    self:ReloadTask()
  end
, nil)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  self:SendCUpdateUISortType()
end

FragmentMainDialog.SetData = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, CFragmentImageState, CImagePathTable, limit
  if ((NekoData.BehaviorManager).BM_Game):IsFragmentPanelShowRed() then
    ((NekoData.DataManager).DM_Game):CheckFragmentPanelRed()
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshFragmentPanelRed, nil)
  end
  self._teamData = {}
  self._lockRoleMap = {}
  self._unfrozenRoleMap = {}
  self._passAllRewardData = {}
  self._currentTeamData = {-1, -1, -1}
  self.isInTeam = false
  self._tileData = protocol.zones
  self._zonesClearReward = protocol.zonesClearReward
  self._reloadInfoTime = protocol.reloadInfoTime
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  self._task = (ServerGameTimer.AddTask)(0, 60, function()
    -- function num : 0_3_0 , upvalues : self
    self:ReloadTask()
  end
, nil)
  local done = true
  local defultSelectTileIndex = nil
  local passZoneCount = 0
  for i,v in ipairs(self._tileData) do
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
    (self._passAllRewardPanel):SetActive(false)
    ;
    (self._rewardTitle):SetActive(false)
    ;
    (self._done):SetActive(true)
    ;
    (self._startBtn):SetActive(false)
    self._allClearReward = ((NekoData.BehaviorManager).BM_Activity):GetShatteredZonesClearReward()
    if self._allClearReward then
      (self:GetRootWindow()):PlayAnimation("FragmentClear")
    else
      ;
      (self._stonImage):SetActive(false)
    end
  else
    local record = CFragmentImageState:GetRecorder(passZoneCount + 1)
    if not CImagePathTable:GetRecorder(record.imgID) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._stonImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self:OnTileClick(defultSelectTileIndex)
    ;
    (self._startBtn):SetActive(true)
  end
  do
    for k,v in pairs(protocol.zonesClearReward) do
      (table.insert)(self._passAllRewardData, {id = k, count = v})
    end
    ;
    (self._passAllRewardFrame):ReloadAllCell()
    self:RefreshCurrentTileInfo()
    self:SetTileModel()
    self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID)
    ;
    (self._spiritNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
    ;
    (self._spiritRedDot):SetActive(self:HaveSpiritItemSoonExpire())
    self:HandleSpriteEvidence()
  end
end

FragmentMainDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self._rootWindow):SetAnimatorInteger("state", -1)
  ;
  (self:GetRootWindow()):PlayAnimation("FragmentClearHold")
  self:RecoveryTile(self._currentTileIndex)
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cgetshatteredzonesinfo")
  csend:Send()
end

FragmentMainDialog.ReloadTask = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local sec = self._reloadInfoTime - (ServerGameTimer.GetServerTime)()
  sec = (math.floor)(sec / 1000)
  local str = (TextManager.GetText)(700770)
  str = (string.gsub)(str, "%$parameter1%$", (math.floor)((os.date)("!%d", sec) - 1))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%H", sec))
  ;
  (self._resetTime):SetText(str)
end

FragmentMainDialog.RefreshCurrentTileInfo = function(self)
  -- function num : 0_6 , upvalues : CFragmentLevelCfg, _ENV
  self._passCurrentRewardData = {}
  local currentTile = (self._tileData)[self._currentTileIndex]
  local currentTileId = currentTile.zoneIndex
  local record = CFragmentLevelCfg:GetRecorder(currentTileId)
  ;
  (self._levelTitle):SetText((TextManager.GetText)(record.nameID))
  if currentTile.firstPassRewards and (table.nums)(currentTile.firstPassRewards) > 0 then
    for k,v in pairs(currentTile.firstPassRewards) do
      (table.insert)(self._passCurrentRewardData, {id = k, count = v, first = true, get = currentTile.thisWeekState == 1})
    end
  end
  for k,v in pairs(currentTile.normalRewards) do
    (table.insert)(self._passCurrentRewardData, {id = k, count = v, get = currentTile.thisWeekState == 1})
  end
  ;
  (self._passCurrentRewardFrame):ReloadAllCell()
  self:ChangeCellPosition()
  local str = nil
  if currentTile.thisWeekState == 1 then
    str = (TextManager.GetText)(700748)
    ;
    (self._startBtnTxt):SetText(str)
  else
    str = (TextManager.GetText)(700747)
    ;
    (self._startBtnTxt):SetText(str)
  end
  self:RefreshTeamElementInfo()
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

FragmentMainDialog.SetTileModel = function(self)
  -- function num : 0_7 , upvalues : _ENV, CFragmentLevelCfg
  for i,v in ipairs(self._tileData) do
    if v.thisWeekState == 1 then
      for key,value in pairs(((v.LineupsRecords)[1]).roles) do
        -- DECOMPILER ERROR at PC16: Confused about usage of register: R11 in 'UnsetPending'

        if key <= 3 then
          (self._lockRoleMap)[value] = i
          local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(value)
          local record = role:GetModelRecord()
          if (((self._tileGroup)[i]).ModelHandle)[key] then
            ((((self._tileGroup)[i]).Model)[key]):ReleaseModel((((self._tileGroup)[i]).ModelHandle)[key])
            -- DECOMPILER ERROR at PC44: Confused about usage of register: R13 in 'UnsetPending'

            ;
            (((self._tileGroup)[i]).ModelHandle)[key] = nil
          end
          -- DECOMPILER ERROR at PC56: Confused about usage of register: R13 in 'UnsetPending'

          ;
          (((self._tileGroup)[i]).ModelHandle)[key] = ((((self._tileGroup)[i]).Model)[key]):AddModelSync(record.assetBundle, record.assetName)
        end
      end
      ;
      (((self._tileGroup)[i]).ImgFinish):SetActive(true)
      ;
      (((self._tileGroup)[i]).ImgNormal):SetActive(false)
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._teamData)[i] = ((v.LineupsRecords)[1]).roles
    else
      local tileId = ((self._tileData)[i]).zoneIndex
      local tileRecord = CFragmentLevelCfg:GetRecorder(tileId)
      ;
      (((self._tileGroup)[i]).ImgFinish):SetActive(false)
      ;
      (((self._tileGroup)[i]).ImgNormal):SetActive(true)
      local lv = tileRecord.monsterlv
      ;
      (((self._tileGroup)[i]).ImgNormal_Lv):SetText(lv)
      -- DECOMPILER ERROR at PC105: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self._teamData)[i] = {}
    end
  end
end

FragmentMainDialog.OnTileClick = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  if index == self._currentTileIndex or self._tween or self.isInTeam or #self._taskList ~= 0 then
    return 
  end
  local moveTimes = index - self._currentTileIndex
  local moveTimesAbs = (math.abs)(moveTimes)
  local maxMoveTimes = self._tileCount / 2
  -- DECOMPILER ERROR at PC29: Unhandled construct in 'MakeBoolean' P1

  if self._currentTileIndex == self._tileCount and maxMoveTimes < moveTimesAbs then
    moveTimes = moveTimes + self._tileCount
  end
  if maxMoveTimes < moveTimesAbs then
    moveTimes = moveTimes - self._tileCount
  end
  self:MoveTileGroup(moveTimes)
end

FragmentMainDialog.MoveTileGroup = function(self, moveTimes)
  -- function num : 0_9 , upvalues : _ENV
  if moveTimes > 0 then
    self._currentTileIndex = self._currentTileIndex + moveTimes
    if self._tileCount < self._currentTileIndex then
      self._currentTileIndex = self._currentTileIndex - self._tileCount
    end
    moveTimes = (math.abs)(moveTimes)
    for i = 1, (math.abs)(moveTimes) do
      (table.insert)(self._taskList, function()
    -- function num : 0_9_0 , upvalues : _ENV, self
    (GameTimer.AddTask)(0, 0, function()
      -- function num : 0_9_0_0 , upvalues : self
      self:RotateOnceClockwise()
    end
)
  end
)
    end
  else
    do
      if moveTimes < 0 then
        self._currentTileIndex = self._currentTileIndex + moveTimes
        if self._currentTileIndex < 1 then
          self._currentTileIndex = self._currentTileIndex + self._tileCount
        end
        moveTimes = (math.abs)(moveTimes)
        for i = 1, (math.abs)(moveTimes) do
          (table.insert)(self._taskList, function()
    -- function num : 0_9_1 , upvalues : _ENV, self
    (GameTimer.AddTask)(0, 0, function()
      -- function num : 0_9_1_0 , upvalues : self
      self:RotateOnceAntiClockwise()
    end
)
  end
)
        end
      end
      do
        self:RefreshCurrentTileInfo()
      end
    end
  end
end

FragmentMainDialog.RotateOnceAntiClockwise = function(self)
  -- function num : 0_10 , upvalues : _ENV, rotateOnceTime
  self._target = {}
  for i = 2, #self._tilePostion do
    (table.insert)(self._target, {X = ((self._tilePostion)[i]).X, Y = ((self._tilePostion)[i]).Y})
  end
  ;
  (table.insert)(self._target, {X = ((self._tilePostion)[1]).X, Y = ((self._tilePostion)[1]).Y})
  self._tween = (Tween.new)(rotateOnceTime, self._tilePostion, self._target, "linear")
end

FragmentMainDialog.RotateOnceClockwise = function(self)
  -- function num : 0_11 , upvalues : _ENV, rotateOnceTime
  self._target = {}
  ;
  (table.insert)(self._target, {X = ((self._tilePostion)[#self._tilePostion]).X, Y = ((self._tilePostion)[#self._tilePostion]).Y})
  for i = 1, #self._tilePostion - 1 do
    (table.insert)(self._target, {X = ((self._tilePostion)[i]).X, Y = ((self._tilePostion)[i]).Y})
  end
  self._tween = (Tween.new)(rotateOnceTime, self._tilePostion, self._target, "linear")
end

FragmentMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

FragmentMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13
  if self.isInTeam then
    (self._rootWindow):SetAnimatorInteger("state", 1)
    self.isInTeam = false
    self._currentTeamData = {-1, -1, -1}
    self:RecoveryTile(self._currentTileIndex)
    self._unfrozenRoleMap = {}
  else
    self:Destroy()
  end
end

FragmentMainDialog.OnInfoBtnClick = function(self)
  -- function num : 0_14 , upvalues : _ENV, CFragmentLevelCfg
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.fragment.fragmentlevelinfodialog")
  if dialog then
    local tileId = ((self._tileData)[self._currentTileIndex]).zoneIndex
    local tileRecord = CFragmentLevelCfg:GetRecorder(tileId)
    dialog:SetData(tileRecord.monsterInfoID, tileRecord.monsterlv)
  end
end

FragmentMainDialog.OnRecordBtnClick = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.fragment.fragmentteamrecorddialog")
  if dialog then
    local data = ((self._tileData)[self._currentTileIndex]).LineupsRecords
    dialog:SetData(data)
  end
end

FragmentMainDialog.OnGoBtnClick = function(self)
  -- function num : 0_16 , upvalues : _ENV
  self._go = true
  if not self._isSpiritEnough then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100013)
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.fragment.fragmentteamconfirmdialog")
  if dialog then
    dialog:SetData(self._currentTeamData, self._currentTileIndex, self)
  end
end

FragmentMainDialog.OnTipsBtnClick = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.fragment.fragmenttipsdialog")
end

FragmentMainDialog.ScreeningAndSorting = function(self)
  -- function num : 0_18 , upvalues : _ENV
  (self._levelBtnTxt):SetText((TextManager.GetText)(self._sortCriteriaNameId))
  while (self._listByConditions)[#self._listByConditions] do
    (table.remove)(self._listByConditions, #self._listByConditions)
  end
  for i,v in ipairs(self._roleList) do
    (table.insert)(self._listByConditions, v)
  end
  for k,v in pairs(self._screeningConditions) do
    local select = false
    local indexMap = {}
    for index,value in ipairs(v) do
      select = true
      for i,role in ipairs(self._listByConditions) do
        -- DECOMPILER ERROR at PC81: Unhandled construct in 'MakeBoolean' P3

        -- DECOMPILER ERROR at PC81: Unhandled construct in 'MakeBoolean' P3

        -- DECOMPILER ERROR at PC81: Unhandled construct in 'MakeBoolean' P3

        if (value.nameid == 501833 and role:GetRarityId() == 1) or value.nameid ~= 501832 or value.nameid ~= 501831 or value.nameid ~= 501834 or value.nameid == 502614 and role:GetRarityId() == 5 then
          indexMap[i] = i
        end
      end
    end
    for index,value in ipairs(v) do
      for i,role in ipairs(self._listByConditions) do
        if value.nameid == role:GetVocationNameId() then
          indexMap[i] = i
        end
      end
    end
    for index,value in ipairs(v) do
      for i,role in ipairs(self._listByConditions) do
        -- DECOMPILER ERROR at PC140: Unhandled construct in 'MakeBoolean' P3

        -- DECOMPILER ERROR at PC140: Unhandled construct in 'MakeBoolean' P3

        if (value.nameid == 502771 and role:GetElement() == 1) or value.nameid ~= 502772 or value.nameid ~= 502773 or value.nameid == 502774 and role:GetElement() == 4 then
          indexMap[i] = i
        end
      end
    end
    if select then
      local deleteList = {}
      for i = 1, #self._listByConditions do
        if not indexMap[i] then
          (table.insert)(deleteList, i)
        end
      end
      do
        do
          while deleteList[#deleteList] do
            (table.remove)(self._listByConditions, deleteList[#deleteList])
            ;
            (table.remove)(deleteList, #deleteList)
          end
          -- DECOMPILER ERROR at PC178: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC178: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC178: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (table.sort)(self._listByConditions, function(a, b)
    -- function num : 0_18_0 , upvalues : self
    local _a, _b = nil, nil
    if self._sortCriteriaNameId == 501827 then
      _a = a:GetLevel()
      _b = b:GetLevel()
    else
      if self._sortCriteriaNameId == 501828 then
        _a = a:GetRarityId()
        _b = b:GetRarityId()
      else
        if self._sortCriteriaNameId == 501829 then
          _a = a:GetBirthDay()
          _b = b:GetBirthDay()
        end
      end
    end
    if _a == _b and self._sortCriteriaNameId ~= 501829 then
      local aId, bId = nil, nil
      if self._sortCriteriaNameId == 501827 or self._sortCriteriaNameId == 501828 then
        aId = a:GetId()
      end
      if aId == bId then
        local aKey, bKey = nil, nil
        aKey = a:GetBirthDay()
        if bKey >= aKey then
          do
            do return not self._isAscendingOrder end
            do return aKey < bKey end
            if aId >= bId then
              do
                do return not self._isAscendingOrder end
                do return bId < aId end
                if _a >= _b then
                  do return not self._isAscendingOrder end
                  do return _b < _a end
                  -- DECOMPILER ERROR: 12 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
)
  if self._charFrame then
    (self._charFrame):ReloadAllCell()
  end
end

FragmentMainDialog.OnStartBtnClick = function(self)
  -- function num : 0_19
  self.isInTeam = true
  ;
  (self._rootWindow):SetAnimatorInteger("state", 2)
  ;
  (self._goBtn):SetInteractable(false)
  self:LoadTeamData()
end

FragmentMainDialog.LoadTeamData = function(self)
  -- function num : 0_20 , upvalues : CFragmentLevelCfg, _ENV, CRoleLevelCfgTable
  local tileId = ((self._tileData)[self._currentTileIndex]).zoneIndex
  local tileRecord = CFragmentLevelCfg:GetRecorder(tileId)
  ;
  (self._levelInfoTitle):SetText((TextManager.GetText)(tileRecord.nameID))
  ;
  (self._recommendLevel):SetText((CRoleLevelCfgTable:GetRecorder(tileRecord.recommendLv)).clientLevel)
  ;
  (self._breakNumTxt):SetText((CRoleLevelCfgTable:GetRecorder(tileRecord.recommendLv)).clientBreakLevel)
  if tileRecord.spirit <= self._spirit then
    (self._costText):SetText(tileRecord.spirit)
    ;
    (self._costText):SetActive(true)
    ;
    (self._costTextRed):SetActive(false)
    self._isSpiritEnough = true
  else
    ;
    (self._costTextRed):SetText(tileRecord.spirit)
    ;
    (self._costText):SetActive(false)
    ;
    (self._costTextRed):SetActive(true)
    self._isSpiritEnough = false
  end
  if ((self._tileData)[self._currentTileIndex]).thisWeekState == 0 then
    (((self._tileGroup)[self._currentTileIndex]).ImgNormal_icon):SetActive(false)
    ;
    (((self._tileGroup)[self._currentTileIndex]).ImgNormal_Lv):SetActive(false)
    ;
    (((self._tileGroup)[self._currentTileIndex]).ImgNormal_Lv_title):SetActive(false)
  end
  self:ClearnTile(self._currentTileIndex)
  ;
  (self._charNum):SetText(0)
  self._roleList = ((NekoData.BehaviorManager).BM_AllRoles):GetContainMaterialRoleList()
  for i,v in pairs((self._teamData)[self._currentTileIndex]) do
    -- DECOMPILER ERROR at PC109: Confused about usage of register: R8 in 'UnsetPending'

    (self._unfrozenRoleMap)[v] = true
  end
  self:ScreeningAndSorting()
end

FragmentMainDialog.OnFilterBtnClick = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 1, "Role", self._screeningConditions)
end

FragmentMainDialog.OnLevelBtnClick = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 2, "Role", self._sortCriteriaNameId)
end

FragmentMainDialog.OnSortBtnClick = function(self)
  -- function num : 0_23 , upvalues : _ENV, CUpdateUISortType
  self._isAscendingOrder = not self._isAscendingOrder
  ;
  (self._sortUpBtnImg):SetActive(self._isAscendingOrder)
  ;
  (self._sortDownBtnImg):SetActive(not self._isAscendingOrder)
  ;
  (self._sortUpBtnTxt):SetActive(self._isAscendingOrder)
  ;
  (self._sortDownBtnTxt):SetActive(not self._isAscendingOrder)
  self:ScreeningAndSorting()
  ;
  ((NekoData.DataManager).DM_Game):RecorderUISortType(CUpdateUISortType.QUICKSET_LINEUP, self._sortCriteriaNameId, self._isAscendingOrder)
end

FragmentMainDialog.RefreshTeamElementInfo = function(self)
  -- function num : 0_24 , upvalues : _ENV, LineUpStation, CElementEffect, CImagePathTable
  local stationElementTag = {}
  local etherStationList = {}
  local ElementType = {Ether = 4}
  local haveTeamInfo = false
  for station,roleId in pairs(self._currentTeamData) do
    if roleId ~= -1 then
      haveTeamInfo = true
      stationElementTag[station] = (((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(roleId)):GetElement()
      if stationElementTag[station] == ElementType.Ether then
        (table.insert)(etherStationList, station)
      end
    end
  end
  self._oneTotalElementValue = nil
  self._elementStage = nil
  if haveTeamInfo then
    if stationElementTag[LineUpStation.FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] ~= ElementType.Ether then
      for _,station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.FRONT_ROW]
      end
    else
      do
        if stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.MIDDLE_ROW] ~= ElementType.Ether then
          for _,station in ipairs(etherStationList) do
            stationElementTag[station] = stationElementTag[LineUpStation.MIDDLE_ROW]
          end
        else
          do
            if stationElementTag[LineUpStation.BACK_ROW] and stationElementTag[LineUpStation.BACK_ROW] ~= ElementType.Ether then
              for _,station in ipairs(etherStationList) do
                stationElementTag[station] = stationElementTag[LineUpStation.BACK_ROW]
              end
            else
              do
                if stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] ~= ElementType.Ether then
                  for _,station in ipairs(etherStationList) do
                    stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW]
                  end
                else
                  do
                    if stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] ~= ElementType.Ether then
                      for _,station in ipairs(etherStationList) do
                        stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW]
                      end
                    else
                      do
                        if stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] and stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] ~= ElementType.Ether then
                          for _,station in ipairs(etherStationList) do
                            stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_BACK_ROW]
                          end
                        end
                        do
                          if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.BACK_ROW] then
                            self._elementStage = 1
                            if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] then
                              self._elementStage = 2
                            end
                            self._oneTotalElementValue = stationElementTag[LineUpStation.FRONT_ROW]
                          end
                          local StageType = {NoStage = 0}
                          if self._elementStage then
                            local elementRecord = CElementEffect:GetRecorder(self._elementStage)
                            if not CImagePathTable:GetRecorder(elementRecord.image) then
                              local imgRecord = DataCommon.DefaultImageAsset
                            end
                            ;
                            (self._elementImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                          else
                            do
                              local elementRecord = CElementEffect:GetRecorder(StageType.NoStage)
                              if not CImagePathTable:GetRecorder(elementRecord.image) then
                                local imgRecord = DataCommon.DefaultImageAsset
                              end
                              ;
                              (self._elementImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

FragmentMainDialog.OnElementBtnClick = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teamelementinfodialog")
  dialog:SetData(self._oneTotalElementValue, self._elementStage)
  dialog:HideStage2()
end

FragmentMainDialog.SetSortCriteriaNameId = function(self, nameId)
  -- function num : 0_26 , upvalues : _ENV, CUpdateUISortType
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
    ;
    ((NekoData.DataManager).DM_Game):RecorderUISortType(CUpdateUISortType.QUICKSET_LINEUP, self._sortCriteriaNameId, self._isAscendingOrder)
  end
end

FragmentMainDialog.SetScreeningConditions = function(self, screeningConditions)
  -- function num : 0_27
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

FragmentMainDialog.OnUpdate = function(self, notification)
  -- function num : 0_28 , upvalues : _ENV
  if #self._taskList > 0 and self._tween == nil then
    ((self._taskList)[1])()
    ;
    (table.remove)(self._taskList, 1)
  end
  if self._tween then
    local finish = (self._tween):update((notification.userInfo).deltaTime)
    for i,v in ipairs(self._tileGroup) do
      (v.tile):SetAnchoredPosition((((self._tween).subject)[i]).X, (((self._tween).subject)[i]).Y)
    end
    if finish then
      self._tween = nil
    end
    local stonTransform = ((self._stonImage)._uiObject).transform
    local targetIndex = (((self._stonImage)._uiObject).transform):GetSiblingIndex()
    for i,v in ipairs(self._tileGroup) do
      local selfIndex = (((v.tile)._uiObject).transform):GetSiblingIndex()
      local selfPosY = ((((v.tile)._uiObject).transform).position).y
      if selfPosY > 0 and targetIndex < selfIndex then
        (((v.tile)._uiObject).transform):SetSiblingIndex(targetIndex)
      else
        if selfPosY < 0 and selfIndex < targetIndex then
          (((v.tile)._uiObject).transform):SetSiblingIndex(targetIndex)
        end
      end
    end
  end
end

FragmentMainDialog.ChangeCellPosition = function(self)
  -- function num : 0_29 , upvalues : MaxColumnNums
  local num = #self._passCurrentRewardData
  local cellPanelWidth = nil
  if num < MaxColumnNums then
    cellPanelWidth = self._width / MaxColumnNums * num
  else
    cellPanelWidth = self._width
  end
  ;
  (self._passCurrentRewardPanel):SetWidth(0, cellPanelWidth)
  ;
  (self._passCurrentRewardPanel):SetXPosition(self._anchorX, -cellPanelWidth / 2)
  ;
  (self._passCurrentRewardFrame):ReloadAllCell()
end

FragmentMainDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_30
  if frame == self._charFrame then
    return #self._listByConditions
  else
    if frame == self._passAllRewardFrame then
      return #self._passAllRewardData
    else
      if frame == self._passCurrentRewardFrame then
        return #self._passCurrentRewardData
      end
    end
  end
end

FragmentMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_31
  if frame == self._charFrame then
    return "mainline.fragment.fragmentteamcell"
  else
    if frame == self._passAllRewardFrame then
      return "mainline.fragment.fragmentitemcell"
    else
      if frame == self._passCurrentRewardFrame then
        return "mainline.fragment.fragmentitemcell"
      end
    end
  end
end

FragmentMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_32
  if frame == self._charFrame then
    return (self._listByConditions)[index]
  else
    if frame == self._passAllRewardFrame then
      return (self._passAllRewardData)[index]
    else
      if frame == self._passCurrentRewardFrame then
        return (self._passCurrentRewardData)[index]
      end
    end
  end
end

FragmentMainDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_33
  if frame == self._charFrame then
    local width, height = (self._charPanel):GetRectSize()
    local total = (self._charFrame):GetTotalLength()
    if height < total then
      (self._scrollBar):SetActive(true)
      ;
      (self._scrollBar):SetScrollSize(height / total)
      ;
      (self._scrollBar):SetScrollValue(proportion)
    else
      ;
      (self._scrollBar):SetActive(false)
    end
  end
end

FragmentMainDialog.ClearCharCellClick = function(self)
  -- function num : 0_34
  (self._charFrame):FireEvent("unselectAll")
  self._currentTeamData = {-1, -1, -1}
  ;
  (self._charNum):SetText(0)
  ;
  (self._goBtn):SetInteractable(false)
end

FragmentMainDialog.OnCharCellClick = function(self, id, index)
  -- function num : 0_35 , upvalues : _ENV
  if self:IsRoleLock(id) and not self:IsRoleUnfrozen(id) then
    return 
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  if index then
    (self._currentTeamData)[index] = -1
    ;
    (self._charFrame):FireEvent("unselect", {id = id})
  else
    for i,v in ipairs(self._currentTeamData) do
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

      if v == -1 then
        (self._currentTeamData)[i] = id
        ;
        (self._charFrame):FireEvent("select", {id = id, index = i})
        break
      end
    end
  end
  do
    self:RefreshCurrentTileModel()
    local count = 0
    for i,v in ipairs(self._currentTeamData) do
      if v ~= -1 then
        count = count + 1
      end
    end
    ;
    (self._charNum):SetText(count)
    if count >= 1 then
      (self._goBtn):SetInteractable(true)
    else
      ;
      (self._goBtn):SetInteractable(false)
    end
    self:RefreshTeamElementInfo()
  end
end

FragmentMainDialog.GetCurrentTeamData = function(self)
  -- function num : 0_36
  return self._currentTeamData
end

FragmentMainDialog.RefreshCurrentTileModel = function(self)
  -- function num : 0_37 , upvalues : _ENV, TransformStaticFunctions, AnimatorStaticFunctions
  for i,v in pairs(self._currentTeamData) do
    local handle = (((self._tileGroup)[self._currentTileIndex]).ModelHandle)[i]
    -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

    if v ~= -1 and handle == nil then
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v)
      local record = role:GetModelRecord()
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._tileGroup)[self._currentTileIndex]).ModelHandle)[i] = ((((self._tileGroup)[self._currentTileIndex]).Model)[i]):AddModelSync(record.assetBundle, record.assetName)
      local modelobj = (TransformStaticFunctions.GetChild)(((((self._tileGroup)[self._currentTileIndex]).Model)[i])._uiObject, "Model/" .. record.assetName .. "(Clone)")
      local modelAnimator = (AnimatorStaticFunctions.Get)(modelobj)
      modelAnimator:Play("Attack")
    end
    do
      do
        if v == -1 and handle then
          ((((self._tileGroup)[self._currentTileIndex]).Model)[i]):ReleaseModel(handle)
          -- DECOMPILER ERROR at PC70: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (((self._tileGroup)[self._currentTileIndex]).ModelHandle)[i] = nil
        end
        -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

FragmentMainDialog.ClearnCurrentTile = function(self)
  -- function num : 0_38 , upvalues : _ENV
  local index = self._currentTileIndex
  for i,v in pairs(((self._tileGroup)[index]).ModelHandle) do
    if v then
      ((((self._tileGroup)[index]).Model)[i]):ReleaseModel(v)
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (((self._tileGroup)[index]).ModelHandle)[i] = nil
    end
  end
end

FragmentMainDialog.ClearnTile = function(self, index)
  -- function num : 0_39 , upvalues : _ENV
  for i,v in pairs(((self._tileGroup)[index]).ModelHandle) do
    if v then
      ((((self._tileGroup)[index]).Model)[i]):ReleaseModel(v)
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (((self._tileGroup)[index]).ModelHandle)[i] = nil
    end
  end
end

FragmentMainDialog.RecoveryTile = function(self, index)
  -- function num : 0_40 , upvalues : _ENV
  self:ClearnTile(index)
  if ((self._tileData)[index]).thisWeekState == 0 then
    (((self._tileGroup)[index]).ImgNormal_icon):SetActive(true)
    ;
    (((self._tileGroup)[self._currentTileIndex]).ImgNormal_Lv):SetActive(true)
    ;
    (((self._tileGroup)[self._currentTileIndex]).ImgNormal_Lv_title):SetActive(true)
  end
  for i,v in pairs((self._teamData)[index]) do
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v)
    local record = role:GetModelRecord()
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self._tileGroup)[index]).ModelHandle)[i] = ((((self._tileGroup)[index]).Model)[i]):AddModelSync(record.assetBundle, record.assetName)
  end
end

FragmentMainDialog.OnSpiritAddBtnClick = function(self)
  -- function num : 0_41 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

FragmentMainDialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_42 , upvalues : _ENV, MillisecondToDay
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < MillisecondToDay then
      return true
    end
  end
  return false
end

FragmentMainDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_43 , upvalues : _ENV, limit, CFragmentLevelCfg, CRoleLevelCfgTable
  self._spirit = (notification.userInfo).spirit
  ;
  (self._spiritNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
  local tileId = ((self._tileData)[self._currentTileIndex]).zoneIndex
  local tileRecord = CFragmentLevelCfg:GetRecorder(tileId)
  ;
  (self._levelInfoTitle):SetText((TextManager.GetText)(tileRecord.nameID))
  ;
  (self._recommendLevel):SetText((CRoleLevelCfgTable:GetRecorder(tileRecord.recommendLv)).clientLevel)
  ;
  (self._breakNumTxt):SetText((CRoleLevelCfgTable:GetRecorder(tileRecord.recommendLv)).clientBreakLevel)
  if tileRecord.spirit <= self._spirit then
    (self._costText):SetText(tileRecord.spirit)
    ;
    (self._costText):SetActive(true)
    ;
    (self._costTextRed):SetActive(false)
    self._isSpiritEnough = true
  else
    ;
    (self._costTextRed):SetText(tileRecord.spirit)
    ;
    (self._costText):SetActive(false)
    ;
    (self._costTextRed):SetActive(true)
    self._isSpiritEnough = false
  end
end

FragmentMainDialog.IsRoleLock = function(self, roleId)
  -- function num : 0_44
  return (self._lockRoleMap)[roleId]
end

FragmentMainDialog.IsRoleUnfrozen = function(self, roleId)
  -- function num : 0_45
  return (self._unfrozenRoleMap)[roleId]
end

FragmentMainDialog.OnAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_46 , upvalues : _ENV
  if stateName == "FragmentClear" then
    (self._rootWindow):SetAnimatorInteger("state", -1)
    ;
    (self._stonImage):SetActive(false)
    local _data = {items = self._allClearReward}
    ;
    ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).ItemAccount, data = _data})
    self._allClearReward = nil
    ;
    ((NekoData.DataManager).DM_Activity):ClearShatteredZonesClearReward()
  end
end

FragmentMainDialog.SendCUpdateUISortType = function(self)
  -- function num : 0_47 , upvalues : _ENV, CUpdateUISortType
  local OrderType = {Ascending = 1, Descending = 2}
  local csend = (LuaNetManager.CreateProtocol)("protocol.login.cupdateuisorttype")
  csend.key = CUpdateUISortType.QUICKSET_LINEUP
  local order = OrderType.Ascending
  if not self._isAscendingOrder then
    order = OrderType.Descending
  end
  csend.Showtype = self._sortCriteriaNameId * 10 + order
  csend:Send()
end

FragmentMainDialog.HandleSpriteEvidence = function(self)
  -- function num : 0_48 , upvalues : _ENV, CImagePathTable, CVarconfig, Item
  local haveSpriteEvidence = (((NekoData.BehaviorManager).BM_Currency):GetSpiritRecoverTimes())[DataCommon.SpriteEvidence]
  if haveSpriteEvidence then
    if not CImagePathTable:GetRecorder(tonumber((CVarconfig:GetRecorder(125)).Value)) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._spiritIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      local imageRecord = ((Item.Create)(DataCommon.SpiritID)):GetIcon()
      ;
      (self._spiritIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
end

return FragmentMainDialog

