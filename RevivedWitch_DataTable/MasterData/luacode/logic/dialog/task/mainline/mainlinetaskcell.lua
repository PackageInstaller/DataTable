-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/mainline/mainlinetaskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local MainLineTaskStatus = (LuaNetManager.CreateBean)("protocol.task.mainlinerewardstatus")
local WorldTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local MainLineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local MainLineTaskCell = class("MainLineTaskCell", Dialog)
MainLineTaskCell.AssetBundleName = "ui/layouts.basetasklist"
MainLineTaskCell.AssetName = "AdventureCell"
MainLineTaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainLineTaskCell
  ((MainLineTaskCell.super).Ctor)(self, ...)
  self._itemList = {}
end

MainLineTaskCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._title = self:GetChild("Back/Title1")
  self._detail = self:GetChild("Back/Detail")
  self._progress = self:GetChild("Back/ProgressBack/Progress")
  self._progress_cur = self:GetChild("Back/ProgressBack/Num/Num")
  self._progress_max = self:GetChild("Back/ProgressBack/Num/NumMax")
  self._itemPanel = self:GetChild("Back/ItemFrame")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false, false, false)
  self._lock = self:GetChild("Back/LockText")
  self._received = self:GetChild("Back/DownText")
  self._goBtn = self:GetChild("Back/GoBtn")
  self._getBtn = self:GetChild("Back/GetBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
end

MainLineTaskCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._itemFrame):Destroy()
end

MainLineTaskCell.RefreshState = function(self)
  -- function num : 0_3 , upvalues : MainLineTaskStatus
  local state = ((self._cellData).data).taskState
  if state == MainLineTaskStatus.AVAILABLE then
    (self._lock):SetActive(false)
    ;
    (self._goBtn):SetActive(false)
    ;
    (self._received):SetActive(false)
    ;
    (self._getBtn):SetActive(true)
  else
    if state == MainLineTaskStatus.RECEIVED then
      (self._lock):SetActive(false)
      ;
      (self._goBtn):SetActive(false)
      ;
      (self._received):SetActive(true)
      ;
      (self._getBtn):SetActive(false)
    else
      if self._chapterInfo and self._unlockLv <= (self._delegate)._userlevel then
        (self._lock):SetActive(false)
        ;
        (self._goBtn):SetActive(true)
        ;
        (self._received):SetActive(false)
        ;
        (self._getBtn):SetActive(false)
      else
        ;
        (self._lock):SetActive(true)
        ;
        (self._goBtn):SetActive(false)
        ;
        (self._received):SetActive(false)
        ;
        (self._getBtn):SetActive(false)
      end
    end
  end
  if self._chapterInfo then
    (self._progress):SetFillAmount((self._chapterInfo).clearZones / (self._chapterInfo).totalZones)
    ;
    (self._progress_cur):SetText((self._chapterInfo).clearZones)
    ;
    (self._progress_max):SetText((self._chapterInfo).totalZones)
  else
    ;
    (self._progress):SetFillAmount(0)
    ;
    (self._progress_cur):SetText(0)
    ;
    (self._progress_max):SetText(#(self._chapterRecord).floorlist)
  end
end

MainLineTaskCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, WorldTable, MainLineTable
  (self._title):SetText((TextManager.GetText)((data.record).Missiontitleid))
  ;
  (self._detail):SetText((TextManager.GetText)((data.record).Missiontextid))
  while (self._itemList)[#self._itemList] do
    (table.remove)(self._itemList, #self._itemList)
  end
  for i,v in ipairs((data.record).rewarditem) do
    (table.insert)(self._itemList, {itemid = v, itemnum = ((data.record).rewardquantity)[i]})
  end
  ;
  (self._itemFrame):ReloadAllCell()
  self._chapterId = (data.data).mainLineId
  self._chapterRecord = WorldTable:GetRecorder(self._chapterId)
  self._unlockLv = (MainLineTable:GetRecorder(((self._chapterRecord).floorlist)[1])).unlockLv
  self._chapterInfo = (self._delegate):GetChapterInfo(self._chapterId)
  self:RefreshState()
end

MainLineTaskCell.OnGoBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, MainLineTable
  local curFloorId = nil
  if self._chapterInfo then
    for _,floor in ipairs((self._chapterInfo).floorDetail) do
      if curFloorId then
        local tempRecord = MainLineTable:GetRecorder(curFloorId)
        local floorRecord = MainLineTable:GetRecorder(floor.floor)
        if tempRecord.sort < floorRecord.sort then
          curFloorId = floor.floor
        end
      else
        do
          do
            curFloorId = floor.floor
            -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  if not curFloorId then
    curFloorId = ((self._chapterRecord).floorlist)[1]
  end
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
  if dialog then
    local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
    dialog:Init(sceneController)
    dialog:ItemTipsJump({gainType = (DataCommon.GainTypeEnum).MainLine, worldId = self._chapterId, info = MainLineTable:GetRecorder(curFloorId)})
  end
end

MainLineTaskCell.OnGetBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.cmainlinereward")
  protocol.mainLineId = self._chapterId
  protocol:Send()
end

MainLineTaskCell.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._itemList
end

MainLineTaskCell.CellAtIndex = function(self, frame)
  -- function num : 0_8
  return "achievement.roleachievementdetailcellitemcell"
end

MainLineTaskCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._itemList)[index]
end

return MainLineTaskCell

