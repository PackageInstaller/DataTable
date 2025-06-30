-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingaccounttabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local SShieldFunctionDef = (LuaNetManager.GetProtocolDef)("protocol.notify.sshieldfunction")
local SettingAccountTabCell = class("SettingAccountTabCell", Dialog)
SettingAccountTabCell.AssetBundleName = "ui/layouts.setting"
SettingAccountTabCell.AssetName = "SettingAccount"
SettingAccountTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingAccountTabCell
  ((SettingAccountTabCell.super).Ctor)(self, ...)
end

SettingAccountTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
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
  ;
  (self._toLoginBtn):Subscribe_PointerClickEvent(self.OnToLoginBtnClicked, self)
  ;
  (self._quitGameBtn):Subscribe_PointerClickEvent(self.OnQuitGameBtnClicked, self)
  ;
  (self._copyIdBtn):Subscribe_PointerClickEvent(self.OnCopyIDBtnClicked, self)
  ;
  (self._changeBtn1):Subscribe_PointerClickEvent(self.OnChangeBtn1Clicked, self)
  ;
  (self._refresh):Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  ;
  (self._photoFrame):Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  ;
  (self._changeBtn3):Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  ;
  (self._changeBtn4):Subscribe_PointerClickEvent(self.OnChangeBtn4Clicked, self)
  ;
  (self._uploadLogButton):Subscribe_PointerClickEvent(self.OnUploadLogButtonClicked, self)
  ;
  (self._userCenterBtn):Subscribe_PointerClickEvent(self.OnUserCenterBtnClicked, self)
  ;
  (self._serviceButton):Subscribe_PointerClickEvent(self.OnServiceBtnClick, self)
  ;
  (self._privacyPolicy):Subscribe_PointerClickEvent(self.OnPrivacyPolicyClick, self)
  ;
  (self._userPolicy):Subscribe_PointerClickEvent(self.OnUserPolicyClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserName, Common.n_UserNameChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserIntroduce, Common.n_ChangeUserIntroduce, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserHeadPhoto, Common.n_ChangeUserHeadPhoto, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserHeadFrame, Common.n_ChangeUserHeadFrame, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnShieldFunction, Common.n_ShieldFunction, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
  self:OnShieldFunction()
  self:RefreshTabCell()
end

SettingAccountTabCell.OnDestroy = function(self)
  -- function num : 0_2
end

SettingAccountTabCell.RefreshTabCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  ;
  (self._id):SetText(tostring(userInfo.userid))
  ;
  (self._name):SetText(tostring(userInfo.username))
  ;
  (self._nameLight):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2090, {userInfo.username}))
  ;
  (self._playerLv):SetText(userInfo.userlevel)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._introduction):SetText(userInfo.introduce)
  if (SdkManager.GetChannel)() == "none" then
    (self._toLoginBtn):SetActive(true)
    ;
    (self._privacyPolicy):SetActive(false)
    ;
    (self._userPolicy):SetActive(false)
    ;
    (self._userCenterBtn):SetActive(false)
    ;
    (self._serviceButton):SetActive(false)
  else
    ;
    (self._userCenterBtn):SetActive(false)
    ;
    (self._serviceButton):SetActive(false)
    ;
    (self._toLoginBtn):SetActive(true)
    ;
    (self._privacyPolicy):SetActive(true)
    ;
    (self._userPolicy):SetActive(true)
  end
  self:HandleSpriteEvidence()
end

SettingAccountTabCell.OnToLoginBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Login):ClientLogout()
end

SettingAccountTabCell.OnQuitGameBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (SdkManager.Quit)()
end

SettingAccountTabCell.OnUploadLogButtonClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("confirmbox.sendlogconfirmdialog")
end

SettingAccountTabCell.OnCopyIDBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (self:GetRootWindow()):CopyToClipBoard(tostring((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid))
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100079)
end

SettingAccountTabCell.OnChangeBtn1Clicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("systemsetting.changenamedialog")
end

SettingAccountTabCell.OnHeadPhotoClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("systemsetting.editheaddialog")
end

SettingAccountTabCell.OnChangeBtn4Clicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("systemsetting.introductiondialog")
end

SettingAccountTabCell.OnChangeUserName = function(self, notification)
  -- function num : 0_11
  (self._name):SetText((notification.userInfo).name)
end

SettingAccountTabCell.OnChangeUserIntroduce = function(self, notification)
  -- function num : 0_12
  (self._introduction):SetText((notification.userInfo).introduce)
end

SettingAccountTabCell.OnChangeUserHeadPhoto = function(self, notification)
  -- function num : 0_13 , upvalues : HeadPhotoTable, CImagePathTable, _ENV
  local headPhotoRecord = HeadPhotoTable:GetRecorder((notification.userInfo).avatarId)
  if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

SettingAccountTabCell.OnChangeUserHeadFrame = function(self, notification)
  -- function num : 0_14 , upvalues : HeadPhotoFrameTable, CImagePathTable, _ENV
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((notification.userInfo).frameId)
  if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

SettingAccountTabCell.OnShieldFunction = function(self)
  -- function num : 0_15 , upvalues : _ENV, SShieldFunctionDef
  (self._changeBtn1):SetActive(not ((NekoData.BehaviorManager).BM_Game):IsShieldFunction(SShieldFunctionDef.CHANGENAME))
  ;
  (self._changeBtn4):SetActive(not ((NekoData.BehaviorManager).BM_Game):IsShieldFunction(SShieldFunctionDef.CHANGEINTRODUCE))
end

SettingAccountTabCell.OnUserCenterBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (SdkManager.OpenAccountCenter)()
end

SettingAccountTabCell.OnServiceBtnClick = function(self)
  -- function num : 0_17 , upvalues : _ENV
  ((SdkManager.GetAgent)()):ShowCustomerService("")
end

SettingAccountTabCell.HandleSpriteEvidence = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local haveSpriteEvidence = (((NekoData.BehaviorManager).BM_Currency):GetSpiritRecoverTimes())[DataCommon.SpriteEvidence]
  ;
  (self._name):SetActive(not haveSpriteEvidence)
  ;
  (self._nameLight):SetActive(haveSpriteEvidence)
end

SettingAccountTabCell.OnPrivacyPolicyClick = function(self)
  -- function num : 0_19 , upvalues : _ENV
  ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)("http://www.szjasmine.com/yszc/fushudmn_moli_yszc.html")
end

SettingAccountTabCell.OnUserPolicyClick = function(self)
  -- function num : 0_20 , upvalues : _ENV
  ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)("http://www.szjasmine.com/yszc/molv_szmoli_yhxy.html")
end

return SettingAccountTabCell

