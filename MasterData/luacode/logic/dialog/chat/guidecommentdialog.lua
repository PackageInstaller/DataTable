local CGuideCommentTable = BeanManager.GetTableByName("mail.cguidecommentcontent")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local GuideCommentDialog = class("GuideCommentDialog", Dialog)
GuideCommentDialog.AssetBundleName = "ui/layouts.guide"
GuideCommentDialog.AssetName = "CommentsGuide"

function GuideCommentDialog:Ctor(...)
  GuideCommentDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._commentType = nil
end

function GuideCommentDialog:OnCreate()
  self._itemImage = self:GetChild("BackImage/ItemCell/_BackGround/Icon")
  self._itemBack = self:GetChild("BackImage/ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("BackImage/ItemCell/_Count")
  self._rolePhoto = self:GetChild("Role/Photo")
  self._tiele = self:GetChild("BackImage/Text1")
  self._btnComplaints = self:GetChild("BackImage/Btn1")
  self._btnAward = self:GetChild("BackImage/Btn2")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._btnComplaints:Subscribe_PointerClickEvent(self.OnComplaintsBtnClick, self)
  self._btnAward:Subscribe_PointerClickEvent(self.OnAwardBtnClick, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  if DialogManager.GetDialog("guide.guidedialog") then
    self._guideTag = true
    DialogManager.GetGroup("Guide"):SetObjectActive(false)
  end
end

function GuideCommentDialog:OnDestroy()
  if self._guideTag then
    self._guideTag = false
    DialogManager.GetGroup("Guide"):SetObjectActive(true)
  end
end

function GuideCommentDialog:SetData(commentType)
  self._commentType = commentType
  local guideCommentCfg = CGuideCommentTable:GetRecorder(1)
  self._tiele:SetText(TextManager.GetText(guideCommentCfg.guideDocumentTextID))
  local imageRecord = CImagePathTable:GetRecorder(guideCommentCfg.imageID) or DataCommon.DefaultImageAsset
  self._rolePhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local item = Item.Create(guideCommentCfg.itemID)
  imageRecord = item:GetIcon()
  self._itemImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  self._itemBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemCount:SetText(NumberManager.GetShowNumber(guideCommentCfg.itemNum))
end

function GuideCommentDialog:OnComplaintsBtnClick()
  DialogManager.CreateSingletonDialog("chat.complaintsdialog"):SetData(self._commentType)
end

function GuideCommentDialog:OnAwardBtnClick()
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.ccompletecomment")
  if protocol then
    protocol.logResult = 2
    protocol.logType = self._commentType or NekoData.BehaviorManager.BM_Chat:GetGuideCommentType()
    protocol:Send()
  end
  NekoData.BehaviorManager.BM_Game:JumpToTheStore(1)
  self:Destroy()
end

function GuideCommentDialog:OnBackBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.ccompletecomment")
  if protocol then
    protocol.logResult = 3
    protocol.logType = self._commentType or NekoData.BehaviorManager.BM_Chat:GetGuideCommentType()
    protocol:Send()
  end
  self:Destroy()
end

return GuideCommentDialog
