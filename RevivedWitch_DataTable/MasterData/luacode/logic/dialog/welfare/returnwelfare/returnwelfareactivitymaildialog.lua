-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/returnwelfareactivitymaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CReturnLoginReward = (BeanManager.GetTableByName)("welfare.creturnloginreward")
local ReturnWelfareActivityMailDialog = class("ReturnWelfareActivityMailDialog", Dialog)
ReturnWelfareActivityMailDialog.AssetBundleName = "ui/layouts.activityhud"
ReturnWelfareActivityMailDialog.AssetName = "ActivityMail"
ReturnWelfareActivityMailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReturnWelfareActivityMailDialog, CReturnLoginReward, _ENV
  ((ReturnWelfareActivityMailDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._sendProtocol = false
  self._returnWelfareSignAwardActivityId = nil
  local allIds = CReturnLoginReward:GetAllIds()
  for i = 1, #allIds do
    if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen(allIds[i]) then
      self._returnWelfareSignAwardActivityId = allIds[i]
      break
    end
  end
end

ReturnWelfareActivityMailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._letterTitle = self:GetChild("Name")
  self._itemPanel = self:GetChild("Frame")
  self._letterContent = self:GetChild("Text")
  self._backImg = self:GetChild("BackImage")
  self._goBtn = self:GetChild("BackImage/GetBtn")
  self._frame = (TableFrame.Create)(self._itemPanel, self, false, false, false)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReturnWelfareRefreshPopTips, Common.n_ReturnWelfareRefreshPopTips, nil)
  self:Init()
end

ReturnWelfareActivityMailDialog.Init = function(self)
  -- function num : 0_2 , upvalues : _ENV, CReturnLoginReward, Item
  (self._letterTitle):SetText((TextManager.GetText)(701605))
  local letterContent = (TextManager.GetText)(701606)
  letterContent = (string.gsub)(letterContent, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username or "")
  ;
  (self._letterContent):SetText(letterContent)
  self._itemList = {}
  local record = CReturnLoginReward:GetRecorder(self._returnWelfareSignAwardActivityId)
  if record then
    for _,str in ipairs(record.reward) do
      local rec = (string.split)(str, "@")
      local item = (Item.Create)(tonumber(rec[1]))
      ;
      (table.insert)(self._itemList, {item = item, num = tonumber(rec[2])})
    end
  else
    do
      LogErrorFormat("ReturnWelfareActivityMailDialog", "activity id %s dont have record in CReturnLoginReward", self._returnWelfareSignAwardActivityId)
      ;
      (self._frame):ReloadAllCell()
      local width, height = (self._itemPanel):GetRectSize()
      local anchorMinX, anchorMinY, anchorMaxX, anchorMaxY, offsetMinX, offsetMinY, offsetMaxX, offsetMaxY = (self._itemPanel):GetAnchorAndOffset()
      local totalLength = (self._frame):GetTotalLength()
      local delta = totalLength - width
      ;
      (self._itemPanel):SetAnchorAndOffset(anchorMinX, anchorMinY, anchorMaxX, anchorMaxY, offsetMinX, offsetMinY, offsetMaxX + delta, offsetMaxY)
      ;
      (self._frame):ReloadAllCell()
    end
  end
end

ReturnWelfareActivityMailDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._frame):Destroy()
  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  if sceneController then
    (sceneController._baseMainFSM):SetNumber("startDialogId", 1)
  end
end

ReturnWelfareActivityMailDialog.OnGoBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cgetpoptipsreward")
  if protocol and not self._sendProtocol then
    self._sendProtocol = true
    protocol.activityID = self._returnWelfareSignAwardActivityId
    protocol:Send()
  end
end

ReturnWelfareActivityMailDialog.OnReturnWelfareRefreshPopTips = function(self, notification)
  -- function num : 0_5
  local PopTipsStatusType = {NotGet = 1, Got = 0}
  if (notification.userInfo).activityID == self._returnWelfareSignAwardActivityId and (notification.userInfo).status == PopTipsStatusType.Got then
    self:Destroy()
  end
  self._sendProtocol = false
end

ReturnWelfareActivityMailDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._itemList
end

ReturnWelfareActivityMailDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "welfare.returnwelfare.returnwelfareactivitymailitemcell"
end

ReturnWelfareActivityMailDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._itemList)[index]
end

return ReturnWelfareActivityMailDialog

