local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local SShieldFunctionDef = LuaNetManager.GetProtocolDef("protocol.notify.sshieldfunction")
local SettingAccountTabCell = class("SettingAccountTabCell", Dialog)
SettingAccountTabCell.AssetBundleName = "ui/layouts.setting"
SettingAccountTabCell.AssetName = "SettingAccount"

function SettingAccountTabCell:Ctor(...)
  SettingAccountTabCell.super.Ctor(self, ...)
end

function SettingAccountTabCell:OnCreate()
  self._toLoginBtn = self:GetChild("Frame/BackToLogin")
  self._quitGameBtn = self:GetChild("Frame/ExitBtn")
  self._id = self:GetChild("Frame/ID/IDNum")
  self._copyIdBtn = self:GetChild("Frame/CopyBtn")
  self._name = self:GetChild("Frame/NameBack/Name")
  self._nameLight = self:GetChild("Frame/NameBack/NameLight")
  self._playerLv = self:GetChild("Frame/PlayerLevel/Num")
  self._title = self:GetChild("Frame/Title/Name")
  self._headPhoto = self:GetChild("Frame/HeadPhoto")
  self._photo = self:GetChild("Frame/Photo")
  self._photoFrame = self:GetChild("Frame/Frame")
  self._refresh = self:GetChild("Frame/refresh")
  self._changeBtn1 = self:GetChild("Frame/ChangeBtn1")
  self._changeBtn3 = self:GetChild("Frame/ChangeBtn3")
  self._changeBtn4 = self:GetChild("Frame/ChangeBtn4")
  self._introduction = self:GetChild("Frame/IntroductionBack/Txt")
  self._uploadLogButton = self:GetChild("Frame/LogBtn")
  self._userCenterBtn = self:GetChild("Frame/UserCenterBtn")
  self._serviceButton = self:GetChild("Frame/ServiceBtn")
  self._privacyPolicy = self:GetChild("Frame/PrivacyBtn")
  self._userPolicy = self:GetChild("Frame/AgreementBtn")
  self._toLoginBtn:Subscribe_PointerClickEvent(self.OnToLoginBtnClicked, self)
  self._quitGameBtn:Subscribe_PointerClickEvent(self.OnQuitGameBtnClicked, self)
  self._copyIdBtn:Subscribe_PointerClickEvent(self.OnCopyIDBtnClicked, self)
  self._changeBtn1:Subscribe_PointerClickEvent(self.OnChangeBtn1Clicked, self)
  self._refresh:Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  self._photoFrame:Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  self._changeBtn3:Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  self._changeBtn4:Subscribe_PointerClickEvent(self.OnChangeBtn4Clicked, self)
  self._uploadLogButton:Subscribe_PointerClickEvent(self.OnUploadLogButtonClicked, self)
  self._userCenterBtn:Subscribe_PointerClickEvent(self.OnUserCenterBtnClicked, self)
  self._serviceButton:Subscribe_PointerClickEvent(self.OnServiceBtnClick, self)
  self._privacyPolicy:Subscribe_PointerClickEvent(self.OnPrivacyPolicyClick, self)
  self._userPolicy:Subscribe_PointerClickEvent(self.OnUserPolicyClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserName, Common.n_UserNameChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserIntroduce, Common.n_ChangeUserIntroduce, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserHeadPhoto, Common.n_ChangeUserHeadPhoto, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserHeadFrame, Common.n_ChangeUserHeadFrame, nil)
  LuaNotificationCenter.AddObserver(self, self.OnShieldFunction, Common.n_ShieldFunction, nil)
  LuaNotificationCenter.AddObserver(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
  self:OnShieldFunction()
  self:RefreshTabCell()
end

function SettingAccountTabCell:OnDestroy()
end

function SettingAccountTabCell:RefreshTabCell()
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  self._id:SetText(tostring(userInfo.userid))
  self._name:SetText(tostring(userInfo.username))
  self._nameLight:SetText(NekoData.BehaviorManager.BM_Message:GetString(2090, {
    userInfo.username
  }))
  self._playerLv:SetText(userInfo.userlevel)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._introduction:SetText(userInfo.introduce)
  if SdkManager.GetChannel() == "none" then
    self._toLoginBtn:SetActive(true)
    self._privacyPolicy:SetActive(false)
    self._userPolicy:SetActive(false)
    self._userCenterBtn:SetActive(false)
    self._serviceButton:SetActive(false)
  else
    self._userCenterBtn:SetActive(false)
    self._serviceButton:SetActive(false)
    self._toLoginBtn:SetActive(true)
    self._privacyPolicy:SetActive(true)
    self._userPolicy:SetActive(true)
  end
  self:HandleSpriteEvidence()
end

function SettingAccountTabCell:OnToLoginBtnClicked()
  NekoData.BehaviorManager.BM_Login:ClientLogout()
end

function SettingAccountTabCell:OnQuitGameBtnClicked()
  SdkManager.Quit()
end

function SettingAccountTabCell:OnUploadLogButtonClicked()
  DialogManager.CreateSingletonDialog("confirmbox.sendlogconfirmdialog")
end

function SettingAccountTabCell:OnCopyIDBtnClicked()
  self:GetRootWindow():CopyToClipBoard(tostring(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid))
  NekoData.BehaviorManager.BM_Message:SendMessageById(100079)
end

function SettingAccountTabCell:OnChangeBtn1Clicked()
  DialogManager.CreateSingletonDialog("systemsetting.changenamedialog")
end

function SettingAccountTabCell:OnHeadPhotoClicked()
  DialogManager.CreateSingletonDialog("systemsetting.editheaddialog")
end

function SettingAccountTabCell:OnChangeBtn4Clicked()
  DialogManager.CreateSingletonDialog("systemsetting.introductiondialog")
end

function SettingAccountTabCell:OnChangeUserName(notification)
  self._name:SetText(notification.userInfo.name)
end

function SettingAccountTabCell:OnChangeUserIntroduce(notification)
  self._introduction:SetText(notification.userInfo.introduce)
end

function SettingAccountTabCell:OnChangeUserHeadPhoto(notification)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(notification.userInfo.avatarId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function SettingAccountTabCell:OnChangeUserHeadFrame(notification)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(notification.userInfo.frameId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function SettingAccountTabCell:OnShieldFunction()
  self._changeBtn1:SetActive(not NekoData.BehaviorManager.BM_Game:IsShieldFunction(SShieldFunctionDef.CHANGENAME))
  self._changeBtn4:SetActive(not NekoData.BehaviorManager.BM_Game:IsShieldFunction(SShieldFunctionDef.CHANGEINTRODUCE))
end

function SettingAccountTabCell:OnUserCenterBtnClicked()
  SdkManager.OpenAccountCenter()
end

function SettingAccountTabCell:OnServiceBtnClick()
  SdkManager.GetAgent():ShowCustomerService("")
end

function SettingAccountTabCell:HandleSpriteEvidence()
  local haveSpriteEvidence = NekoData.BehaviorManager.BM_Currency:GetSpiritRecoverTimes()[DataCommon.SpriteEvidence]
  self._name:SetActive(not haveSpriteEvidence)
  self._nameLight:SetActive(haveSpriteEvidence)
end

function SettingAccountTabCell:OnPrivacyPolicyClick()
  CS.PixelNeko.Tools.ShareHelper.OpenURL("http://www.szjasmine.com/yszc/fushudmn_moli_yszc.html")
end

function SettingAccountTabCell:OnUserPolicyClick()
  CS.PixelNeko.Tools.ShareHelper.OpenURL("http://www.szjasmine.com/yszc/molv_szmoli_yhxy.html")
end

return SettingAccountTabCell
