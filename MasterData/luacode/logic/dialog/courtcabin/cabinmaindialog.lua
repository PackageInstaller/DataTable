local CDormComfortLv = BeanManager.GetTableByName("courtyard.cdormcomfortlv")
local CabinMainDialog = class("CabinMainDialog", Dialog)
CabinMainDialog.AssetBundleName = "ui/layouts.yard"
CabinMainDialog.AssetName = "HouseMain"

local function FinishGuide(self)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(28, 3) then
    LuaNotificationCenter.RemoveObserver(self, Common.n_GuideResponseClick)
    NekoData.BehaviorManager.BM_Guide:FinishGuide(28)
  end
end

local function HandleGuideStatusChanged(self, notification)
  local guideId = notification.userInfo.guideID
  if (guideId == 36 or guideId == 37) and notification.userInfo.guideStatus == "Start" and not self._gameTimerID then
    self._cabinSceneController._inGuide = NekoData.BehaviorManager.BM_Cabin:GetLevel()
    self._cabinSceneController._interactDialog:SetResponseMouse(false)
    NekoData.BehaviorManager.BM_Guide:FinishGuide(guideId)
    self:GetRootWindow():SetAnimatorInteger("isHide", 1)
    self._gameTimerID = GameTimer.AddTask(0.5, 0, function()
      self._cabinSceneController._interactDialog:RefreshRoom(NekoData.BehaviorManager.BM_Cabin:GetLevel(), true)
    end)
  end
end

function CabinMainDialog:Ctor(...)
  CabinMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._cabinSceneController = nil
  self._show = true
end

function CabinMainDialog:OnCreate()
  self._iBtn = self:GetChild("Ibtn")
  self._backBtn = self:GetChild("Panel/BackBtn")
  self._menuBtn = self:GetChild("Panel/MenuBtn")
  self._levelTxt = self:GetChild("Panel/Top/LVNum")
  self._cabinNameTxt = self:GetChild("Panel/Top/Name")
  self._changeNameBtn = self:GetChild("Panel/Top/ChangeBtn")
  self._floorNumTxt = self:GetChild("Panel/Down/FloorNum")
  self._comfortIcon = self:GetChild("Panel/Down/Comfortable/Image")
  self._comfortTxt = self:GetChild("Panel/Down/Comfortable/Num")
  self._comfortShowBtn = self:GetChild("Panel/Down/Comfortable/Ibtn")
  self._energyIcon = self:GetChild("Panel/Down/Mood/Mood")
  self._energySpeedTxt = self:GetChild("Panel/Down/Mood/Num")
  self._addRelationTxt = self:GetChild("Panel/Down/Relation/Num")
  self._dressUpBtn = self:GetChild("Panel/Down/Btn1")
  self._addRoleBtn = self:GetChild("Panel/Down/Btn2")
  self._storeBtn = self:GetChild("Panel/Down/Btn3")
  self._viewBtn = self:GetChild("HideBtn")
  self._viewBtn:SetSelected(false)
  self._showFurnitureInfoBtn = self:GetChild("OutBtn")
  self._showFurnitureInfoBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsGM())
  self._panel = self:GetChild("Panel")
  self._iBtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClick, self)
  self._changeNameBtn:Subscribe_PointerClickEvent(self.OnChangeNameBtnClick, self)
  self._comfortShowBtn:Subscribe_PointerClickEvent(self.OnComfortShowBtnClick, self)
  self._dressUpBtn:Subscribe_PointerClickEvent(self.OnDressUpBtnClick, self)
  self._addRoleBtn:Subscribe_PointerClickEvent(self.OnAddRoleBtnClick, self)
  self._storeBtn:Subscribe_PointerClickEvent(self.OnStoreBtnClick, self)
  self._viewBtn:Subscribe_PointerClickEvent(self.OnViewBtnClick, self)
  self._showFurnitureInfoBtn:Subscribe_PointerClickEvent(self.OnShowFurnitureInfo, self)
  LuaNotificationCenter.AddObserver(self, self.OnSelectRoomIdChanged, Common.n_SelectRoomIdChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoom, Common.n_RefreshRoom, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoomFromFurnituresChanged, Common.n_RefreshRoomFurnitures, nil)
  LuaNotificationCenter.AddObserver(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
end

function CabinMainDialog:OnDestroy()
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("fastmenu.fastmenudialog")
  DialogManager.DestroySingletonDialog("courtcabin.changecabinnamedialog")
  DialogManager.DestroySingletonDialog("courtcabin.comfortshowdialog")
  DialogManager.DestroySingletonDialog("courtcabin.dressupcabindialog")
  DialogManager.DestroySingletonDialog("courtcabin.rolejoindialog")
  DialogManager.DestroySingletonDialog("courtcabin.shop.furniturestoredialog")
end

function CabinMainDialog:Init(sceneController)
  LuaNotificationCenter.PostNotification(Common.n_HideUI, self, self._show)
  self._cabinSceneController = sceneController
  self:Refresh(self._cabinSceneController._interactDialog:GetSelectRoomId())
  if NekoData.BehaviorManager.BM_Guide:CanPlayGuide(28) then
    LuaNotificationCenter.AddObserver(self, FinishGuide, Common.n_GuideResponseClick, nil)
  end
end

function CabinMainDialog:OnSelectRoomIdChanged(notification)
  self:Refresh(notification.userInfo)
end

function CabinMainDialog:OnRefreshRoom()
  self._roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(self._roomId)
  self:RefreshEnergyAndRelation()
end

function CabinMainDialog:OnRefreshRoomFromFurnituresChanged()
  self._roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(self._roomId)
  self._comfortTxt:SetText(self._roomInfo.comfort)
  local imgRecord = NekoData.BehaviorManager.BM_Cabin:GetComfortImageRecord()
  if imgRecord then
    self._comfortIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
  self:RefreshEnergyAndRelation()
end

function CabinMainDialog:Refresh(roomId)
  self._roomId = roomId
  self._levelTxt:SetText(NekoData.BehaviorManager.BM_Cabin:GetLevel())
  self:OnRefreshName()
  self._floorNumTxt:SetText(self._roomId)
  self._roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(roomId)
  self._comfortTxt:SetText(self._roomInfo.comfort)
  local imgRecord = NekoData.BehaviorManager.BM_Cabin:GetComfortImageRecord()
  if imgRecord then
    self._comfortIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
  self:RefreshEnergyAndRelation()
end

function CabinMainDialog:RefreshEnergyAndRelation()
  local comfortRecord = NekoData.BehaviorManager.BM_Cabin:GetRecordByComfortLv(self._roomInfo.comfortLv)
  local energyBaseRecoverySpeed = comfortRecord.emotion / DataCommon.RoleEnergyRatio * (60 / NekoData.BehaviorManager.BM_Cabin:GetRate())
  local recoveryEnergy = self._roomInfo.recoverySpeed
  local integer, decimal = math.modf(energyBaseRecoverySpeed)
  local roleAddRecoveryEnergy = recoveryEnergy - energyBaseRecoverySpeed
  if decimal <= 0.0 then
    energyBaseRecoverySpeed = integer
  end
  integer, decimal = math.modf(roleAddRecoveryEnergy)
  if decimal <= 0.0 then
    roleAddRecoveryEnergy = integer
  end
  if 0 < roleAddRecoveryEnergy then
    self._energySpeedTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1212, {
      energyBaseRecoverySpeed,
      "+" .. roleAddRecoveryEnergy
    }))
  elseif roleAddRecoveryEnergy < 0 then
    self._energySpeedTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1212, {energyBaseRecoverySpeed, roleAddRecoveryEnergy}))
  else
    self._energySpeedTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1212, {energyBaseRecoverySpeed, ""}))
  end
  integer, decimal = math.modf(self._roomInfo.addRelation)
  if decimal <= 0.0 then
    self._addRelationTxt:SetText(integer .. "/h")
  else
    self._addRelationTxt:SetText(self._roomInfo.addRelation .. "/h")
  end
end

function CabinMainDialog:OnRefreshName()
  self._cabinNameTxt:SetText(NekoData.BehaviorManager.BM_Cabin:GetName())
end

function CabinMainDialog:OnChangeNameBtnClick()
  DialogManager.CreateSingletonDialog("courtcabin.changecabinnamedialog")
end

function CabinMainDialog:OnComfortShowBtnClick()
  DialogManager.CreateSingletonDialog("courtcabin.comfortshowdialog"):Init(self._roomId)
end

function CabinMainDialog:OnDressUpBtnClick()
  DialogManager.CreateSingletonDialog("courtcabin.dressupcabindialog"):Init(self._cabinSceneController)
  LuaNotificationCenter.PostNotification(Common.n_EnterDressUpMode, self, nil)
end

function CabinMainDialog:OnAddRoleBtnClick()
  DialogManager.CreateSingletonDialog("courtcabin.rolejoindialog"):Init(self._roomId)
end

function CabinMainDialog:OnStoreBtnClick()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = DataCommon.FurnitureShopId
    protocol:Send()
  end
end

function CabinMainDialog:OnViewBtnClick()
  self._show = not self._show
  self._panel:SetActive(self._show)
  self._viewBtn:SetSelected(not self._show)
  LuaNotificationCenter.PostNotification(Common.n_HideUI, self, self._show)
end

function CabinMainDialog:OnShowFurnitureInfo()
  local str = ""
  for k, v in pairs(self._roomInfo.furnitures) do
    str = str .. v.itemId .. "@(" .. v.point.x .. "," .. v.point.y .. ");"
  end
  LogInfo("CabinMainDialog", str)
end

function CabinMainDialog:OnIBtnClicked()
  DialogManager.CreateSingletonDialog("newbattle.battleteachguidedialog"):Init(DataCommon.LocalTips.GuideOpenInstructionDialog_Cabin.guideId)
end

function CabinMainDialog:OnBackBtnClicked()
  local yardController = SceneManager.GetSceneControllerByID(30004)
  yardController._yardFSM:SetNumber("sceneId", 0)
end

function CabinMainDialog:OnMenuBtnClick()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function CabinMainDialog:AddNewModal(dialog)
  if dialog._dialogName == "courtcabin.rolejoindialog" or dialog._dialogName == "magictree.chooseroledialog" then
    self:GetRootWindow():SetActive(true)
  else
    self:GetRootWindow():SetActive(false)
  end
end

return CabinMainDialog
