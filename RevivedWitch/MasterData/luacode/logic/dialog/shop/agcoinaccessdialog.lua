-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/agcoinaccessdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local AgCoinAccessDialog = class("AgCoinAccessDialog", Dialog)
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
AgCoinAccessDialog.AssetBundleName = "ui/layouts.baseshop"
AgCoinAccessDialog.AssetName = "CoinGet"
AgCoinAccessDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AgCoinAccessDialog
  ((AgCoinAccessDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

AgCoinAccessDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._dailyTaskRefreshTime = self:GetChild("Frame/Time1")
  self._timeLimitTaskendTime = self:GetChild("Frame/Time2")
  self._dailyTaskAccessAg = self:GetChild("Frame/Txt1/Num")
  self._dailyTaskAccessTotalAg = self:GetChild("Frame/Txt1/TotalNum")
  self._coinIcon = self:GetChild("Frame/Txt1/Image")
  self._frame = self:GetChild("Frame/Frame")
  self._helperFrame = (TableFrame.Create)(self._frame, self, true, true, true)
  self._scrollBar = self:GetChild("Scrollbar")
  self._closeBtn = self:GetChild("CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
end

AgCoinAccessDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._helperFrame):Destroy()
end

AgCoinAccessDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CItemAttrTable, CImagePathTable
  local manager = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  ;
  (self._dailyTaskAccessAg):SetText(manager:GetDailyTaskAccessCoin())
  ;
  (self._dailyTaskAccessTotalAg):SetText(manager:GetDailyTaskTotalAccessCoin())
  local itemcfg = CItemAttrTable:GetRecorder(DataCommon.AgCoinID)
  if not CImagePathTable:GetRecorder(itemcfg.icon) then
    local iconinfo = DataCommon.DefaultImageAsset
  end
  ;
  (self._coinIcon):SetSprite(iconinfo.assetBundle, iconinfo.assetName)
  self._limitTasks = {}
  local tasks = manager:GetLimtTimeTasks()
  for _,info in pairs(tasks) do
    local temp = {}
    temp.taskid = info.taskid
    temp.curValue = ((info.conditions)[1]).value
    temp.destValue = ((info.conditions)[1]).destValue
    ;
    (table.insert)(self._limitTasks, temp)
  end
  do
    if #self._limitTasks == 0 then
      local temp = {}
      temp.taskid = 50001
      temp.curValue = 150
      temp.destValue = 500
      ;
      (table.insert)(self._limitTasks, temp)
      temp = {}
      temp.taskid = 50002
      temp.curValue = 200
      temp.destValue = 500
      ;
      (table.insert)(self._limitTasks, temp)
      temp = {}
      temp.taskid = 50003
      temp.curValue = 200
      temp.destValue = 500
      ;
      (table.insert)(self._limitTasks, temp)
    end
    ;
    (self._helperFrame):ReloadAllCell()
    ;
    (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_3_0 , upvalues : self
    self:RefreshTaskLeftTime()
  end
, nil)
  end
end

AgCoinAccessDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if frame == self._helperFrame then
    return #self._limitTasks
  end
end

AgCoinAccessDialog.CellAtIndex = function(self, frame)
  -- function num : 0_5
  if frame == self._helperFrame then
    return "shop.agcoinaccesstaskcell"
  end
end

AgCoinAccessDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._helperFrame then
    return (self._limitTasks)[index]
  end
end

local GetLeftTimeStr = function(lefttime)
  -- function num : 0_7 , upvalues : _ENV
  local strId = 1158
  local par = 0
  lefttime = lefttime // 1000
  if lefttime < 60 then
    strId = 1159
    par = lefttime
  else
    if lefttime < 3600 then
      strId = 1160
      par = lefttime // 60
    else
      if lefttime < 86400 then
        strId = 1159
        par = lefttime // 3600
      else
        strId = 1158
        par = lefttime // 86400
      end
    end
  end
  local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(strId)).msgTextID
  str = (TextManager.GetText)(str)
  str = (string.gsub)(str, "%$parameter1%$", par)
  return str
end

AgCoinAccessDialog.RefreshTaskLeftTime = function(self)
  -- function num : 0_8 , upvalues : _ENV, GetLeftTimeStr, CStringRes
  local curTime = (ServerGameTimer.GetServerTimeForecast)()
  local manager = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  local dailyTaskRefreshTime = manager:GetDailyTaskRefreshTime()
  local deltatime = dailyTaskRefreshTime - curTime
  ;
  (self._dailyTaskRefreshTime):SetText(GetLeftTimeStr(deltatime))
  local limiteTaskEndtime = ((NekoData.BehaviorManager).BM_Activity):GetEndTime(DataCommon.AgCoinActivityID)
  deltatime = limiteTaskEndtime - curTime
  do
    if deltatime <= 0 then
      local str = (TextManager.GetText)((CStringRes:GetRecorder(1036)).msgTextID)
      ;
      (self._timeLimitTaskendTime):SetText(str)
      return 
    end
    ;
    (self._timeLimitTaskendTime):SetText(GetLeftTimeStr(deltatime))
  end
end

AgCoinAccessDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_9
  local width, height = (self._frame):GetRectSize()
  local total = (self._helperFrame):GetTotalLength()
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

AgCoinAccessDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

return AgCoinAccessDialog

