local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local EditHeadDialog = class("EditHeadDialog", Dialog)
EditHeadDialog.AssetBundleName = "ui/layouts.setting"
EditHeadDialog.AssetName = "SettingPhoto"

function EditHeadDialog:Ctor(...)
  EditHeadDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._selectedHeadPhoto = {id = nil, lock = true}
  self._headPhotoId = nil
  self._selectedHeadFrame = {id = nil, lock = true}
  self._headFrameId = nil
  self._headPhotoList = {}
  self._headFrameList = {}
  self._tag = nil
end

function EditHeadDialog:OnCreate()
  self._cancleBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._headPhoto = self:GetChild("Back/HeadPhoto/Photo")
  self._headFrame = self:GetChild("Back/HeadPhoto/Frame")
  self._headGrey = self:GetChild("Back/HeadPhoto/Grey")
  self._headLock = self:GetChild("Back/HeadPhoto/Lock")
  self._framePanel = self:GetChild("Back/Frame")
  self._photoName = self:GetChild("Back/PhotoName/Name")
  self._photoSource = self:GetChild("Back/PhotoGet/Txt")
  self._headPhotoBtn = self:GetChild("Back/Group/GroupBtn1")
  self._headFrameBtn = self:GetChild("Back/Group/GroupBtn2")
  self._frame = GridFrame.Create(self._framePanel, self, true, 5)
  self._cancleBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._headPhotoBtn:Subscribe_PointerClickEvent(self.OnHeadPhotoBtnClicked, self)
  self._headFrameBtn:Subscribe_PointerClickEvent(self.OnHeadFrameBtnClicked, self)
  self:Init()
end

function EditHeadDialog:OnDestroy()
  self._frame:Destroy()
end

function EditHeadDialog:Init()
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  for k, v in pairs(userInfo.avatarIds) do
    local list = {}
    list.id = k
    list.lock = v == 0
    table.insert(self._headPhotoList, list)
  end
  table.sort(self._headPhotoList, function(a, b)
    local aRecord = HeadPhotoTable:GetRecorder(a.id)
    local bRecord = HeadPhotoTable:GetRecorder(b.id)
    if aRecord.order < bRecord.order then
      return true
    else
      return false
    end
  end)
  for k, v in pairs(userInfo.frameIds) do
    local list = {}
    list.id = k
    list.lock = v == 0
    list.unlockButVisible = HeadPhotoFrameTable:GetRecorder(k).unlockvisibleornot == 1
    if not list.lock or list.unlockButVisible then
      table.insert(self._headFrameList, list)
    end
  end
  table.sort(self._headFrameList, function(a, b)
    local aRecord = HeadPhotoFrameTable:GetRecorder(a.id)
    local bRecord = HeadPhotoFrameTable:GetRecorder(b.id)
    if aRecord.order < bRecord.order then
      return true
    else
      return false
    end
  end)
  self._headPhotoId = userInfo.avatarId
  self._selectedHeadPhoto.id = self._headPhotoId
  self._selectedHeadPhoto.lock = false
  self._headFrameId = userInfo.frameId
  self._selectedHeadFrame.id = self._headFrameId
  self._selectedHeadFrame.lock = false
  self:OnHeadPhotoBtnClicked()
  local headPhotoRecord = HeadPhotoTable:GetRecorder(self._headPhotoId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(self._headFrameId)
  imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function EditHeadDialog:OnBackBtnClicked()
  self:Destroy()
end

function EditHeadDialog:OnConfirmBtnClicked()
  if self._headPhotoId == self._selectedHeadPhoto.id and self._headFrameId == self._selectedHeadFrame.id then
    self:Destroy()
  else
    if self._headPhotoId ~= self._selectedHeadPhoto.id then
      local cchangeuseravatar = LuaNetManager.CreateProtocol("protocol.user.cchangeuseravatar")
      if cchangeuseravatar then
        cchangeuseravatar.avatarId = self._selectedHeadPhoto.id
        cchangeuseravatar:Send()
      end
    end
    if self._headFrameId ~= self._selectedHeadFrame.id then
      local cchangeuserframe = LuaNetManager.CreateProtocol("protocol.user.cchangeuserframe")
      if cchangeuserframe then
        cchangeuserframe.frameId = self._selectedHeadFrame.id
        cchangeuserframe:Send()
      end
    end
  end
end

function EditHeadDialog:OnHeadPhotoBtnClicked()
  self._headPhotoBtn:SetSelected(true)
  self._headFrameBtn:SetSelected(false)
  self._headGrey:SetActive(false)
  self._headLock:SetActive(false)
  self._confirmBtn:SetInteractable(not self._selectedHeadPhoto.lock)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(self._selectedHeadPhoto.id)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(self._selectedHeadFrame.id)
  self._photoName:SetText(TextManager.GetText(headPhotoRecord.nameTextID))
  self._photoSource:SetText(TextManager.GetText(headPhotoRecord.descriptionTextID))
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._tag = "HeadPhoto"
  self._frame:ReloadAllCell()
end

function EditHeadDialog:OnHeadFrameBtnClicked()
  self._headPhotoBtn:SetSelected(false)
  self._headFrameBtn:SetSelected(true)
  self._headGrey:SetActive(false)
  self._headLock:SetActive(false)
  self._confirmBtn:SetInteractable(not self._selectedHeadFrame.lock)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(self._selectedHeadPhoto.id)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(self._selectedHeadFrame.id)
  self._photoName:SetText(TextManager.GetText(headPhotoFrameRecord.nameTextID))
  self._photoSource:SetText(TextManager.GetText(headPhotoFrameRecord.descriptionTextID))
  self._tag = "HeadFrame"
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._frame:ReloadAllCell()
end

function EditHeadDialog:SetSelectedId(data)
  self._headGrey:SetActive(true)
  self._headLock:SetActive(true)
  if self._tag == "HeadPhoto" then
    local headPhotoRecord = HeadPhotoTable:GetRecorder(data.id)
    if not data.lock then
      self._selectedHeadPhoto = data
      self._headGrey:SetActive(false)
      self._headLock:SetActive(false)
    end
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._photoName:SetText(TextManager.GetText(headPhotoRecord.nameTextID))
    self._photoSource:SetText(TextManager.GetText(headPhotoRecord.descriptionTextID))
  end
  if self._tag == "HeadFrame" then
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.id)
    if not data.lock then
      self._selectedHeadFrame = data
      self._headGrey:SetActive(false)
      self._headLock:SetActive(false)
    end
    imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._photoName:SetText(TextManager.GetText(headPhotoFrameRecord.nameTextID))
    self._photoSource:SetText(TextManager.GetText(headPhotoFrameRecord.descriptionTextID))
  end
  self._confirmBtn:SetInteractable(not data.lock)
  self._frame:FireEvent("ChangedSelected", data)
end

function EditHeadDialog:NumberOfCell(frame)
  if self._tag == "HeadPhoto" then
    return #self._headPhotoList
  end
  if self._tag == "HeadFrame" then
    return #self._headFrameList
  end
end

function EditHeadDialog:CellAtIndex(frame)
  return "systemsetting.headphotocell"
end

function EditHeadDialog:DataAtIndex(frame, index)
  if self._tag == "HeadPhoto" then
    return self._headPhotoList[index]
  end
  if self._tag == "HeadFrame" then
    return self._headFrameList[index]
  end
end

return EditHeadDialog
