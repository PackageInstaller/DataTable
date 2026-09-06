local CStringres = BeanManager.GetTableByName("message.cstringres")
local CCourtyardLvUpCfg = BeanManager.GetTableByName("courtyard.ccourtyardlvup")
local CCourtyardNameCfg = BeanManager.GetTableByName("courtyard.ccourtyardname")
local BuildingUnlockNoItemDialog = class("BuildingUnlockNoItemDialog", Dialog)
BuildingUnlockNoItemDialog.AssetBundleName = "ui/layouts.yard"
BuildingUnlockNoItemDialog.AssetName = "YardTreeUnLockNoItem"

local function HandleHandleStage(self, notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  if userInfo.guideID == 16 then
    if userInfo.stageRefCountTable[4] > 0 then
      self._guideTag = true
      local width, height = self._confirmBtn:GetRectSize()
      local screenPos = self._confirmBtn:GetLocalPointInUiRootPanel()
      local dialog = DialogManager.CreateSingletonDialog("guide.guidedialog")
      dialog:SetGuideId(userInfo.guideID)
      dialog:SetGuidePoint(width, height, screenPos.x, screenPos.y)
    elseif self._guideTag then
      self._guideTag = false
      DialogManager.DestroySingletonDialog("guide.guidedialog")
    end
  end
end

function BuildingUnlockNoItemDialog:Ctor(...)
  BuildingUnlockNoItemDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._taskId = nil
end

function BuildingUnlockNoItemDialog:OnCreate()
  self._name = self:GetChild("Title")
  self._time = self:GetChild("Time/Time")
  self._result = self:GetChild("Effect/Txt")
  self._cancelBtn = self:GetChild("CancelBtn")
  self._confirmBtn = self:GetChild("ConfirmBtn")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, HandleHandleStage, Common.n_HandleStage, nil)
end

function BuildingUnlockNoItemDialog:OnDestroy()
  DialogManager.DestroySingletonDialog("guide.guidedialog")
  LuaNotificationCenter.RemoveObserver(self)
end

function BuildingUnlockNoItemDialog:Init(taskId)
  self._taskId = taskId
  local record = CCourtyardLvUpCfg:GetRecorder(taskId)
  local str = ""
  str = TextManager.GetText(CCourtyardNameCfg:GetRecorder(record.functionID).nameTextID)
  self._name:SetText(str)
  local time = record.time * 60
  str = TextManager.GetText(CStringres:GetRecorder(1109).msgTextID)
  str = string.gsub(str, "%$parameter1%$", os.date("!%H", time))
  str = string.gsub(str, "%$parameter2%$", os.date("!%M", time))
  str = string.gsub(str, "%$parameter3%$", os.date("!%S", time))
  self._time:SetText(str)
  self._result:SetText(TextManager.GetText(record.unlockEffectTextID))
end

function BuildingUnlockNoItemDialog:OnBackBtnClicked()
  self:Destroy()
end

function BuildingUnlockNoItemDialog:OnConfirmBtnClicked()
  local record = CCourtyardLvUpCfg:GetRecorder(self._taskId)
  local cstartTreeTask = LuaNetManager.CreateProtocol("protocol.yard.cstarttreetask")
  cstartTreeTask.buildId = record.functionID
  cstartTreeTask:Send()
end

return BuildingUnlockNoItemDialog
