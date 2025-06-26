-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversary/dailytaskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TaskStatus = (LuaNetManager.GetBeanDef)("protocol.task.taskstatus")
local CActivityTasks = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local CAnniversarylevel = (BeanManager.GetTableByName)("dungeonselect.canniversarylevel")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local DailyTaskCell = class("DailyTaskCell", Dialog)
DailyTaskCell.AssetBundleName = "ui/layouts.activity1yearanniversary"
DailyTaskCell.AssetName = "Activity1YearAnniversaryAccountTaskCell"
DailyTaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DailyTaskCell
  ((DailyTaskCell.super).Ctor)(self, ...)
end

DailyTaskCell.OnCreate = function(self)
  -- function num : 0_1
  self._gotPanel = self:GetChild("Grey")
  self._getPanel = self:GetChild("GetBack")
  self._getPanel_btn = self:GetChild("GetBack/GetBtn")
  self._levelIcon = self:GetChild("Item")
  self._detailTxt = self:GetChild("ItemTxt")
  self._progress = self:GetChild("Loading/Num")
  self._progress_notFull = self:GetChild("Loading/RedNum")
  self._itemCell = self:GetChild("ItemFrame/Activity1YearAnniversaryAccountItemCell/ItemCell")
  self._itemCell_frame = self:GetChild("ItemFrame/Activity1YearAnniversaryAccountItemCell/ItemCell/_BackGround/Frame")
  self._itemCell_icon = self:GetChild("ItemFrame/Activity1YearAnniversaryAccountItemCell/ItemCell/_BackGround/Icon")
  self._itemCell_count = self:GetChild("ItemFrame/Activity1YearAnniversaryAccountItemCell/ItemCell/_Count")
  ;
  (self._getPanel_btn):Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
end

DailyTaskCell.OnDestroy = function(self)
  -- function num : 0_2
end

DailyTaskCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAnniversarylevel, CImagePathTable, _ENV, Item, TaskStatus
  local levelRecord = CAnniversarylevel:GetRecorder((data.record).levelid)
  if not CImagePathTable:GetRecorder(levelRecord.levelpicselect) then
    local image = DataCommon.DefaultImageAsset
  end
  ;
  (self._levelIcon):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._detailTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2009, {(TextManager.GetText)(levelRecord.levelname)}))
  self._item = (Item.Create)((data.record).itemid)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._itemCell_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetPinJiImage()
  ;
  (self._itemCell_frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemCell_count):SetText((data.record).itemnum)
  if data.taskStatus == TaskStatus.COMMITED then
    (self._gotPanel):SetActive(true)
    ;
    (self._getPanel):SetActive(false)
  else
    ;
    (self._gotPanel):SetActive(false)
    ;
    (self._getPanel):SetActive(true)
    if data.taskStatus == TaskStatus.FINISHED then
      (self._getPanel_btn):SetInteractable(true)
    else
      ;
      (self._getPanel_btn):SetInteractable(false)
    end
  end
  if data.taskStatus == TaskStatus.COMMITED or data.taskStatus == TaskStatus.FINISHED then
    (self._progress):SetActive(true)
    ;
    (self._progress_notFull):SetActive(false)
    ;
    (self._progress):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2011, {(data.record).battlecount, (data.record).battlecount}))
  else
    ;
    (self._progress):SetActive(false)
    ;
    (self._progress_notFull):SetActive(true)
    ;
    (self._progress_notFull):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2010, {data.taskCurProgress, (data.record).battlecount}))
  end
end

DailyTaskCell.OnGetBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, CActivityTasks
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommitactivitytask")
  protocol.activityID = CActivityTasks.ANNIVERSARY
  protocol.taskID = (self._cellData).taskId
  protocol:Send()
end

DailyTaskCell.OnItemCellClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self._itemCell):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
  end
end

return DailyTaskCell

