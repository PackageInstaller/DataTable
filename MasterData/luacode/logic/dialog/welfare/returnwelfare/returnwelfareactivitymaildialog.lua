local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CReturnLoginReward = BeanManager.GetTableByName("welfare.creturnloginreward")
local ReturnWelfareActivityMailDialog = class("ReturnWelfareActivityMailDialog", Dialog)
ReturnWelfareActivityMailDialog.AssetBundleName = "ui/layouts.activityhud"
ReturnWelfareActivityMailDialog.AssetName = "ActivityMail"

function ReturnWelfareActivityMailDialog:Ctor(...)
  ReturnWelfareActivityMailDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._sendProtocol = false
  self._returnWelfareSignAwardActivityId = 0
  local allIds = CReturnLoginReward:GetAllIds()
  for i = 1, #allIds do
    if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(allIds[i]) then
      self._returnWelfareSignAwardActivityId = allIds[i]
      break
    end
  end
end

function ReturnWelfareActivityMailDialog:OnCreate()
  self._letterTitle = self:GetChild("Name")
  self._itemPanel = self:GetChild("Frame")
  self._letterContent = self:GetChild("Text")
  self._backImg = self:GetChild("BackImage")
  self._goBtn = self:GetChild("BackImage/GetBtn")
  self._frame = TableFrame.Create(self._itemPanel, self, false, false, false)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnReturnWelfareRefreshPopTips, Common.n_ReturnWelfareRefreshPopTips, nil)
  self:Init()
end

function ReturnWelfareActivityMailDialog:Init()
  self._letterTitle:SetText(TextManager.GetText(701605))
  local letterContent = TextManager.GetText(701606)
  letterContent = string.gsub(letterContent, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username or "")
  self._letterContent:SetText(letterContent)
  self._itemList = {}
  local record = CReturnLoginReward:GetRecorder(self._returnWelfareSignAwardActivityId)
  if record then
    for _, str in ipairs(record.reward) do
      local rec = string.split(str, "@")
      local item = Item.Create(tonumber(rec[1]))
      table.insert(self._itemList, {
        item = item,
        num = tonumber(rec[2])
      })
    end
  else
    LogErrorFormat("ReturnWelfareActivityMailDialog", "activity id %s dont have record in CReturnLoginReward", self._returnWelfareSignAwardActivityId)
  end
  self._frame:ReloadAllCell()
  local width, height = self._itemPanel:GetRectSize()
  local anchorMinX, anchorMinY, anchorMaxX, anchorMaxY, offsetMinX, offsetMinY, offsetMaxX, offsetMaxY = self._itemPanel:GetAnchorAndOffset()
  local totalLength = self._frame:GetTotalLength()
  local delta = totalLength - width
  self._itemPanel:SetAnchorAndOffset(anchorMinX, anchorMinY, anchorMaxX, anchorMaxY, offsetMinX, offsetMinY, offsetMaxX + delta, offsetMaxY)
  self._frame:ReloadAllCell()
end

function ReturnWelfareActivityMailDialog:OnDestroy()
  self._frame:Destroy()
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  if sceneController then
    sceneController._baseMainFSM:SetNumber("startDialogId", 1)
  end
end

function ReturnWelfareActivityMailDialog:OnGoBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetpoptipsreward")
  if protocol and not self._sendProtocol then
    self._sendProtocol = true
    protocol.activityID = self._returnWelfareSignAwardActivityId
    protocol:Send()
  end
end

function ReturnWelfareActivityMailDialog:OnReturnWelfareRefreshPopTips(notification)
  local PopTipsStatusType = {NotGet = 1, Got = 0}
  if notification.userInfo.activityID == self._returnWelfareSignAwardActivityId and notification.userInfo.status == PopTipsStatusType.Got then
    self:Destroy()
  end
  self._sendProtocol = false
end

function ReturnWelfareActivityMailDialog:NumberOfCell(frame)
  return #self._itemList
end

function ReturnWelfareActivityMailDialog:CellAtIndex(frame, index)
  return "welfare.returnwelfare.returnwelfareactivitymailitemcell"
end

function ReturnWelfareActivityMailDialog:DataAtIndex(frame, index)
  return self._itemList[index]
end

return ReturnWelfareActivityMailDialog
