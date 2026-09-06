local CGuideCommentTable = BeanManager.GetTableByName("mail.cguidecommentcontent")
local ComplaintsDialog = class("ComplaintsDialog", Dialog)
ComplaintsDialog.AssetBundleName = "ui/layouts.guide"
ComplaintsDialog.AssetName = "CommentsGuide2"
local MulTextNewLine = 2

function ComplaintsDialog:Ctor(...)
  ComplaintsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._commentType = nil
end

function ComplaintsDialog:OnCreate()
  self._inputField = self:GetChild("Back/IntroductionInputField")
  self._inputField:SetGenerateOutOfBounds(true)
  self._inputField:SetLineType(MulTextNewLine)
  self._txtNumLimit = self:GetChild("Back/Txt4")
  self._txtNum = self:GetChild("Back/Txt1")
  self._txtNumRed = self:GetChild("Back/Txt2")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._closeBtn = self:GetChild("Back/CancelBtn")
  self._inputField:Subscribe_ValueChangedEvent(self.OnInputText, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:SetInteractable(false)
  self:SetData()
end

function ComplaintsDialog:SetData(commentType)
  self._commentType = commentType
  local guideCommentCfg = CGuideCommentTable:GetRecorder(1)
  self._limit = guideCommentCfg.wordLimit
  self._txtNumRed:SetActive(false)
end

function ComplaintsDialog:OnDestroy()
end

function ComplaintsDialog:OnInputText()
  local num = #self._inputField:GetText()
  if 0 < num and num < self._limit then
    self._confirmBtn:SetInteractable(true)
  else
    self._confirmBtn:SetInteractable(false)
  end
  if num <= self._limit then
    self._txtNum:SetText(num)
    self._txtNumRed:SetActive(false)
    self._txtNum:SetActive(true)
  else
    self._txtNumRed:SetText(num)
    self._txtNumRed:SetActive(true)
    self._txtNum:SetActive(false)
  end
end

function ComplaintsDialog:OnConfirmBtnClick()
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.ccompletecomment")
  if protocol then
    protocol.logResult = 1
    protocol.logType = self._commentType or NekoData.BehaviorManager.BM_Chat:GetGuideCommentType()
    protocol.content = self._inputField:GetText()
    protocol:Send()
  end
  local dialog = DialogManager.GetDialog("chat.guidecommentdialog")
  if dialog then
    dialog:Destroy()
  end
  self:Destroy()
end

function ComplaintsDialog:OnBackBtnClicked()
  self:Destroy()
end

return ComplaintsDialog
