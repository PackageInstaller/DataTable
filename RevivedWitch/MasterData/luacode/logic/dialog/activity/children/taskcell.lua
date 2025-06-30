-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/children/taskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local TasksProtocolDef = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local TaskCell = class("TaskCell", Dialog)
TaskCell.AssetBundleName = "ui/layouts.activitychildrensday"
TaskCell.AssetName = "ActivityChildrensDayTaskCell"
TaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TaskCell
  ((TaskCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
  self._itemId = 0
end

TaskCell.OnCreate = function(self)
  -- function num : 0_1
  self._itemInfo = {icon = self:GetChild("ActivityChildrensDayCellItem/Panel/ItemCell/_BackGround/Icon"), count = self:GetChild("ActivityChildrensDayCellItem/Panel/ItemCell/_Count"), frame = self:GetChild("ActivityChildrensDayCellItem/Panel/ItemCell/_BackGround/Frame")}
  self._taskInfo = {name = self:GetChild("TaskBack/Name"), descText = self:GetChild("TaskBack/Text"), tasklineBack = self:GetChild("TasklineBack"), progress = self:GetChild("TasklineBack/Taskline"), progressNum = self:GetChild("TasklineBack/Txt"), getBtn = self:GetChild("GetBtn"), goBtn = self:GetChild("GoBtn"), finish = self:GetChild("Finish")}
  ;
  ((self._itemInfo).icon):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  ;
  ((self._taskInfo).getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
  ;
  ((self._taskInfo).goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
end

TaskCell.OnDestroy = function(self)
  -- function num : 0_2
end

TaskCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, TaskStatus
  self._task = data
  ;
  ((self._taskInfo).name):SetText((self._task):GetName())
  ;
  ((self._taskInfo).descText):SetText((self._task):GetDesc())
  local progress = (self._task):GetProgress()
  if #progress == 0 then
    ((self._taskInfo).tasklineBack):SetActive(false)
  else
    ;
    ((self._taskInfo).tasklineBack):SetActive(true)
    local text = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1058)).msgTextID
    text = (TextManager.GetText)(text)
    text = text:gsub("%$parameter(%d)", {["1"] = (progress[1]).current, ["2"] = (progress[1]).total})
    ;
    ((self._taskInfo).progress):SetFillAmount((((self._task):GetProgress())[1]).current / (((self._task):GetProgress())[1]).total)
    ;
    ((self._taskInfo).progressNum):SetText(text)
  end
  do
    self._item = ((self._task):GetAwards())[1]
    ;
    ((self._itemInfo).count):SetText((NumberManager.GetShowNumber)((((self._task):GetAwards())[1]):GetCount()))
    ;
    ((self._itemInfo).icon):SetSprite(((self._item):GetIcon()).assetBundle, ((self._item):GetIcon()).assetName)
    ;
    ((self._itemInfo).frame):SetSprite(((self._item):GetPinJiImage()).assetBundle, ((self._item):GetPinJiImage()).assetName)
    if (self._task):GetStatus() == TaskStatus.PROCESSING then
      ((self._taskInfo).goBtn):SetActive(true)
      ;
      ((self._taskInfo).getBtn):SetActive(false)
      ;
      ((self._taskInfo).finish):SetActive(false)
    else
      if (self._task):GetStatus() == TaskStatus.FINISHED then
        ((self._taskInfo).goBtn):SetActive(false)
        ;
        ((self._taskInfo).getBtn):SetActive(true)
        ;
        ((self._taskInfo).finish):SetActive(false)
      else
        if (self._task):GetStatus() == TaskStatus.COMMITED then
          ((self._taskInfo).goBtn):SetActive(false)
          ;
          ((self._taskInfo).getBtn):SetActive(false)
          ;
          ((self._taskInfo).finish):SetActive(true)
        else
          ;
          ((self._taskInfo).goBtn):SetActive(false)
          ;
          ((self._taskInfo).getBtn):SetActive(false)
          ;
          ((self._taskInfo).finish):SetActive(true)
        end
      end
    end
  end
end

TaskCell.OnGoBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_ActivityTasks):HandleTask(self._task)
end

TaskCell.OnGetBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV, TasksProtocolDef
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommitactivitytask")
  if protocol then
    protocol.activityID = TasksProtocolDef.CHILDREN_DAY
    protocol.taskID = (self._task):GetID()
    protocol:Send()
  end
end

TaskCell.OnItemCellClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = ((self._task):GetAwards())[1]})
  end
end

return TaskCell

