-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/chat/complaintsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGuideCommentTable = (BeanManager.GetTableByName)("mail.cguidecommentcontent")
local ComplaintsDialog = class("ComplaintsDialog", Dialog)
ComplaintsDialog.AssetBundleName = "ui/layouts.guide"
ComplaintsDialog.AssetName = "CommentsGuide2"
local MulTextNewLine = 2
ComplaintsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ComplaintsDialog
  ((ComplaintsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._commentType = nil
end

ComplaintsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : MulTextNewLine
  self._inputField = self:GetChild("Back/IntroductionInputField")
  ;
  (self._inputField):SetGenerateOutOfBounds(true)
  ;
  (self._inputField):SetLineType(MulTextNewLine)
  self._txtNumLimit = self:GetChild("Back/Txt4")
  self._txtNum = self:GetChild("Back/Txt1")
  self._txtNumRed = self:GetChild("Back/Txt2")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._closeBtn = self:GetChild("Back/CancelBtn")
  ;
  (self._inputField):Subscribe_ValueChangedEvent(self.OnInputText, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):SetInteractable(false)
  self:SetData()
end

ComplaintsDialog.SetData = function(self, commentType)
  -- function num : 0_2 , upvalues : CGuideCommentTable
  self._commentType = commentType
  local guideCommentCfg = CGuideCommentTable:GetRecorder(1)
  self._limit = guideCommentCfg.wordLimit
  ;
  (self._txtNumRed):SetActive(false)
end

ComplaintsDialog.OnDestroy = function(self)
  -- function num : 0_3
end

ComplaintsDialog.OnInputText = function(self)
  -- function num : 0_4
  local num = #(self._inputField):GetText()
  if num > 0 and num < self._limit then
    (self._confirmBtn):SetInteractable(true)
  else
    ;
    (self._confirmBtn):SetInteractable(false)
  end
  if num <= self._limit then
    (self._txtNum):SetText(num)
    ;
    (self._txtNumRed):SetActive(false)
    ;
    (self._txtNum):SetActive(true)
  else
    ;
    (self._txtNumRed):SetText(num)
    ;
    (self._txtNumRed):SetActive(true)
    ;
    (self._txtNum):SetActive(false)
  end
end

ComplaintsDialog.OnConfirmBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.ccompletecomment")
  if protocol then
    protocol.logResult = 1
    if not self._commentType then
      protocol.logType = ((NekoData.BehaviorManager).BM_Chat):GetGuideCommentType()
      protocol.content = (self._inputField):GetText()
      protocol:Send()
      local dialog = (DialogManager.GetDialog)("chat.guidecommentdialog")
      if dialog then
        dialog:Destroy()
      end
      self:Destroy()
    end
  end
end

ComplaintsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

return ComplaintsDialog

