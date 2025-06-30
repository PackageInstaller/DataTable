-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/chat/guidecommentdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGuideCommentTable = (BeanManager.GetTableByName)("mail.cguidecommentcontent")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local GuideCommentDialog = class("GuideCommentDialog", Dialog)
GuideCommentDialog.AssetBundleName = "ui/layouts.guide"
GuideCommentDialog.AssetName = "CommentsGuide"
GuideCommentDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuideCommentDialog
  ((GuideCommentDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._commentType = nil
end

GuideCommentDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._itemImage = self:GetChild("BackImage/ItemCell/_BackGround/Icon")
  self._itemBack = self:GetChild("BackImage/ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("BackImage/ItemCell/_Count")
  self._rolePhoto = self:GetChild("Role/Photo")
  self._tiele = self:GetChild("BackImage/Text1")
  self._btnComplaints = self:GetChild("BackImage/Btn1")
  self._btnAward = self:GetChild("BackImage/Btn2")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  ;
  (self._btnComplaints):Subscribe_PointerClickEvent(self.OnComplaintsBtnClick, self)
  ;
  (self._btnAward):Subscribe_PointerClickEvent(self.OnAwardBtnClick, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  if (DialogManager.GetDialog)("guide.guidedialog") then
    self._guideTag = true
    ;
    ((DialogManager.GetGroup)("Guide")):SetObjectActive(false)
  end
end

GuideCommentDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._guideTag then
    self._guideTag = false
    ;
    ((DialogManager.GetGroup)("Guide")):SetObjectActive(true)
  end
end

GuideCommentDialog.SetData = function(self, commentType)
  -- function num : 0_3 , upvalues : CGuideCommentTable, _ENV, CImagePathTable, Item
  self._commentType = commentType
  local guideCommentCfg = CGuideCommentTable:GetRecorder(1)
  ;
  (self._tiele):SetText((TextManager.GetText)(guideCommentCfg.guideDocumentTextID))
  if not CImagePathTable:GetRecorder(guideCommentCfg.imageID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._rolePhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local item = (Item.Create)(guideCommentCfg.itemID)
  imageRecord = item:GetIcon()
  ;
  (self._itemImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  ;
  (self._itemBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemCount):SetText((NumberManager.GetShowNumber)(guideCommentCfg.itemNum))
end

GuideCommentDialog.OnComplaintsBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("chat.complaintsdialog")):SetData(self._commentType)
end

GuideCommentDialog.OnAwardBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.ccompletecomment")
  if protocol then
    protocol.logResult = 2
    if not self._commentType then
      protocol.logType = ((NekoData.BehaviorManager).BM_Chat):GetGuideCommentType()
      protocol:Send()
      ;
      ((NekoData.BehaviorManager).BM_Game):JumpToTheStore(1)
      self:Destroy()
    end
  end
end

GuideCommentDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.ccompletecomment")
  if protocol then
    protocol.logResult = 3
    if not self._commentType then
      protocol.logType = ((NekoData.BehaviorManager).BM_Chat):GetGuideCommentType()
      protocol:Send()
      self:Destroy()
    end
  end
end

return GuideCommentDialog

