-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1/leveldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local TypeEnum = (DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local CStarryMirrorDiffculty = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrordiffculty")
local CEventBoostRole = (BeanManager.GetTableByName)("activity.ceventboostrole")
local CStarryMirrorEnemyBoost = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorenemyboost")
local ColumnNum = 2
local SpecialBossLevelMap = {[10047] = 10039}
local ShopIdMap = {[(TypeEnum.Type).Easy] = (TypeEnum.Shop).Easy, [(TypeEnum.Type).Hard] = (TypeEnum.Shop).Hard}
local CopyBaseLevelDialog = require("logic.dialog.activity.starmirage1.copybase.leveldialog")
local LevelDialog = class("LevelDialog", CopyBaseLevelDialog)
LevelDialog.AssetBundleName = "ui/layouts.activitystar2"
LevelDialog.AssetName = "ActivityStar2MainLevel2"
LevelDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TypeEnum, _ENV, SpecialBossLevelMap, CStarrymirrorlevel, CStarryMirrorDiffculty, LevelDialog, CEventBoostRole, CStarryMirrorEnemyBoost
  local args = {...}
  args.TypeEnum = TypeEnum
  args.bm = (NekoData.BehaviorManager).BM_StarMirageCopy
  args.ActivityId = (DataCommon.Activities).StarMirageCopy
  args.SpecialBossLevelMap = SpecialBossLevelMap
  args.BossLevelDetailDialogName = "activity.starmirage1.bossleveldetaildialog"
  args.LevelCellName = "activity.starmirage1.levelcell"
  args.LevelBossCellName = "activity.starmirage1.levelbosscell"
  args.LevelRecords = {}
  local allIds = CStarrymirrorlevel:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CStarrymirrorlevel:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R9 in 'UnsetPending'

    if record.eventid == args.ActivityId then
      (args.LevelRecords)[record.id] = record
    end
  end
  args.DiffcultyRecords = {}
  allIds = CStarryMirrorDiffculty:GetAllIds()
  for i = 1, #allIds do
    local record = CStarryMirrorDiffculty:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R9 in 'UnsetPending'

    if record.eventid == args.ActivityId then
      (args.DiffcultyRecords)[record.diffculty] = record
    end
  end
  ;
  ((LevelDialog.super).Ctor)(self, args)
  self._entryList = {}
  self._roleAddRecordList = {}
  local allIds = CEventBoostRole:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CEventBoostRole:GetRecorder(allIds[i])
    if record.eventid == self._ActivityId then
      (table.insert)(self._roleAddRecordList, record)
    end
  end
  ;
  (table.sort)(self._roleAddRecordList, function(a, b)
    -- function num : 0_0_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self._entryRecords = {}
  allIds = CStarryMirrorEnemyBoost:GetAllIds()
  len = #allIds
  for i = 1, len do
    local record = CStarryMirrorEnemyBoost:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC115: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self._entryRecords)[record.id] = record
  end
end

LevelDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : LevelDialog, GridFrame, ColumnNum, _ENV, TableFrame, CopyBaseLevelDialog
  ((LevelDialog.super).OnCreate)(self)
  self._hardTips = self:GetChild("Level2Tips")
  self._levelDetailPanel_entryPanel = self:GetChild("Detail/Level2/BossBuff")
  self._levelDetailPanel_entryPanel_iBtn = self:GetChild("Detail/Level2/BossBuff/Ibtn")
  self._levelDetailPanel_entryPanel_cellPanel = self:GetChild("Detail/Level2/BossBuff/Frame")
  self._levelDetailPanel_entryPanel_cellFrame = (GridFrame.Create)(self._levelDetailPanel_entryPanel_cellPanel, self, true, ColumnNum)
  ;
  (self._levelDetailPanel_entryPanel_iBtn):Subscribe_PointerClickEvent(self.OnEntryIBtnClicked, self)
  self._levelDetailPanel_dispatchBtn = self:GetChild("Detail/Level2/DispatchBtn")
  self._levelDetailPanel_dispatchBtn_tips = self:GetChild("Detail/Level2/DispatchBtn/Tips")
  ;
  (self._levelDetailPanel_dispatchBtn):Subscribe_PointerClickEvent(self.OnDispatchBtnClicked, self)
  ;
  (self._levelDetailPanel_dispatchBtn_tips):Subscribe_PointerClickEvent(self.OnDispatchBtnClickAreaClicked, self)
  ;
  (self._levelDetailPanel_dispatchBtn):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).OffLineSweep))
  self._dailySupplyBtn = self:GetChild("PowerBtn")
  self._dailySupplyBtn_redDot = self:GetChild("PowerBtn/RedDot")
  self._accumulateRewardBtn = self:GetChild("AccountBtn")
  self._accumulateRewardBtn_redDot = self:GetChild("AccountBtn/RedDot")
  self._shopBtn = self:GetChild("ShopBtn")
  self._rankBtn = self:GetChild("RankBtn")
  self._roleAddPanel = self:GetChild("TitleBack")
  self._roleAddPanel_framePanel = self:GetChild("TitleBack/CharFrame")
  self._roleAddPanel_frame = (TableFrame.Create)(self._roleAddPanel_framePanel, self, false, true)
  ;
  (self._dailySupplyBtn):Subscribe_PointerClickEvent(self.OnDailySupplyBtnClicked, self)
  ;
  (self._accumulateRewardBtn):Subscribe_PointerClickEvent(self.OnAccumulateRewardBtnClicked, self)
  ;
  (self._shopBtn):Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  ;
  (self._rankBtn):Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFunctionBtnShow, Common.n_RefreshActivityDailySupply, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFunctionBtnShow, Common.n_RefreshActivityRewards, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshDetailPanel, (CopyBaseLevelDialog.NotificationName).RefreshDetailPanel, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFunctionBtnShow, (CopyBaseLevelDialog.NotificationName).RefreshFunctionBtnShow, nil)
  ;
  (self:GetChild("PowerBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2109))
  ;
  (self:GetChild("AccountBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2110))
  ;
  (self:GetChild("ShopBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2111))
  ;
  (self:GetChild("RankBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2001))
  ;
  (self:GetChild("TitleBack/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2114))
  ;
  (self:GetChild("Detail/Level2/DispatchBtn/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1854))
end

LevelDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : LevelDialog, _ENV
  ((LevelDialog.super).OnDestroy)(self)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._levelDetailPanel_entryPanel_cellFrame):Destroy()
  ;
  (self._roleAddPanel_frame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("activity.starmirage.entrydetaildialog")
end

LevelDialog.RefreshFunctionBtnShow = function(self)
  -- function num : 0_3
  local unlock = (self._bm):IsUnlockFunctionById(((self._TypeEnum).Function).DailySupply)
  ;
  (self._dailySupplyBtn):SetActive(unlock)
  if unlock then
    (self._dailySupplyBtn_redDot):SetActive((self._bm):ShowDailySupplyRedDot())
  end
  local unlock = (self._bm):IsUnlockFunctionById(((self._TypeEnum).Function).AccumulateRewards)
  ;
  (self._accumulateRewardBtn):SetActive(unlock)
  if unlock then
    (self._accumulateRewardBtn_redDot):SetActive((self._bm):ShowAccumulateRewardRedDot())
  end
  ;
  (self._shopBtn):SetActive((self._bm):IsUnlockFunctionById(((self._TypeEnum).Function).Shop))
  ;
  (self._rankBtn):SetActive((self._bm):IsUnlockFunctionById(((self._TypeEnum).Function).Rank))
  local value = (self._bm):IsUnlockFunctionById(((self._TypeEnum).Function).RoleAdd)
  if value then
    (self._roleAddPanel):SetActive(true)
    ;
    (self._roleAddPanel_frame):ReloadAllCell()
  else
    ;
    (self._roleAddPanel):SetActive(false)
  end
  local levelInfo = (self._bm):GetLevelInfoById(self._selectLevelId)
  if levelInfo then
    (self._levelDetailPanel_dispatchBtn):SetInteractable(levelInfo.firstGet)
    ;
    (self._hardTips):SetActive(self._type == ((self._TypeEnum).Type).Hard)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

LevelDialog.RefreshDetailPanel = function(self)
  -- function num : 0_4 , upvalues : _ENV
  while (self._entryList)[#self._entryList] do
    (table.remove)(self._entryList, #self._entryList)
  end
  local record = (self._entryRecords)[self._selectLevelId]
  if not record then
    (self._levelDetailPanel_entryPanel):SetActive(false)
  else
    ;
    (self._levelDetailPanel_entryPanel):SetActive(true)
    for i,v in ipairs(record.boostnameid) do
      (table.insert)(self._entryList, {nameId = v, effectId = (record.boosteffectid)[i], img = (record.boosteffectpicid)[i]})
    end
  end
  do
    ;
    (self._levelDetailPanel_entryPanel_cellFrame):ReloadAllCell()
    ;
    (self._levelDetailPanel_entryPanel):SetActive(false)
    local levelInfo = (self._bm):GetLevelInfoById(self._selectLevelId)
    if levelInfo then
      (self._levelDetailPanel_dispatchBtn):SetInteractable(levelInfo.firstGet)
    end
  end
end

LevelDialog.OnDispatchBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, CStarrymirrorlevel
  if ((NekoData.BehaviorManager).BM_OfflineSweep):GetTodayLeftNum() <= 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100471)
    return 
  end
  if ((NekoData.BehaviorManager).BM_OfflineSweep):GetStatus() ~= 0 then
    if ((NekoData.BehaviorManager).BM_OfflineSweep):GetStatus() == 1 then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100474)
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100475)
    end
    return 
  end
  local levelInfo = (self._bm):GetLevelInfoById(self._selectLevelId)
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID) < levelInfo.costSpirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    local record = CStarrymirrorlevel:GetRecorder(self._selectLevelId)
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.offlinesweepcontinuedialog")
    if dialog and record then
      local data = {}
      data.copyType = "DispatchStarryMirror"
      data.id = record.id
      data.name = (TextManager.GetText)(record.leveltitle) .. " " .. (TextManager.GetText)(record.levelname)
      data.spirit = record.spirit
      data.timelength = record.mopupTime
      data.littleImgID = nil
      dialog:SetInfo(data)
    else
      do
        LogErrorFormat("DispatchStarryMirror", "CStarrymirrorlevel Not Exist %s", self._selectLevelId)
      end
    end
  end
end

LevelDialog.OnDispatchBtnClickAreaClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100473)
end

LevelDialog.OnEntryIBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.starmirage.entrydetaildialog")):Init(self._entryList)
end

LevelDialog.OnDailySupplyBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("activity.starmirage1.dailysupplydialog")
end

LevelDialog.OnAccumulateRewardBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("activity.starmirage1.accumulaterewarddialog")
end

LevelDialog.OnShopBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV, ShopIdMap
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  protocol.shopId = ShopIdMap[self._type]
  protocol:Send()
end

LevelDialog.OnRankBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.starmirage.rankmaindialog")):SetType(self._ActivityId, ((self._TypeEnum).Type).Easy)
end

LevelDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_12 , upvalues : LevelDialog
  if frame == self._roleAddPanel_frame then
    return #self._roleAddRecordList
  else
    if frame == self._levelDetailPanel_entryPanel_cellFrame then
      return #self._entryList
    else
      return ((LevelDialog.super).NumberOfCell)(self, frame, index)
    end
  end
end

LevelDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_13 , upvalues : LevelDialog
  if frame == self._roleAddPanel_frame then
    return "activity.starmirage.roleaddcell"
  else
    if frame == self._levelDetailPanel_entryPanel_cellFrame then
      return "activity.starmirage.entrycell"
    else
      return ((LevelDialog.super).CellAtIndex)(self, frame, index)
    end
  end
end

LevelDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_14 , upvalues : LevelDialog
  if frame == self._roleAddPanel_frame then
    return (self._roleAddRecordList)[index]
  else
    if frame == self._levelDetailPanel_entryPanel_cellFrame then
      return (self._entryList)[index]
    else
      return ((LevelDialog.super).DataAtIndex)(self, frame, index)
    end
  end
end

return LevelDialog

