local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local BaseMainMenuDialog = class("BaseMainMenuDialog", Dialog)
BaseMainMenuDialog.AssetBundleName = "ui/layouts.basemainhud"
BaseMainMenuDialog.AssetName = "BaseMainMenu"

function BaseMainMenuDialog:Ctor(...)
  BaseMainMenuDialog.super.Ctor(self, ...)
  self._groupName = "Default"
  self._baseSceneController = nil
  self._isOpen = false
  self._buttonClick = false
  self._menuClick = true
  self._menuGuideEffectHandler = nil
  self._characterGuideEffectHandler = nil
  self._soulRefineGuideEffectHandler = nil
end

function BaseMainMenuDialog:OnCreate()
  self._menuBtn = self:GetChild("MainMenuBtn")
  self._charInfoBtn = self:GetChild("CharInfo")
  self._charNewIcon = self:GetChild("CharInfo/New")
  self._charRedIcon = self:GetChild("CharInfo/EvolveRedDot")
  self._teamPresetBtn = self:GetChild("Edit")
  self._tuJianBtn = self:GetChild("TuJian")
  self._tuJianRedIcon = self:GetChild("TuJian/RedDot")
  self._workShopBtn = self:GetChild("WorkShop")
  self._soulRefineGuideEffect = self:GetChild("WorkShop/Effect")
  self._workShopBtn_RedDot = self:GetChild("WorkShop/RedDot")
  self._guildBtn = self:GetChild("GuildBtn")
  self._guildRedIcon = self:GetChild("GuildBtn/RedDot")
  self._guildUnreadMessageRedIcon = self:GetChild("GuildBtn/TalkDot")
  self._guildUnreadMessageCount = self:GetChild("GuildBtn/TalkDot/Talk")
  self._menuGuideEffect = self:GetChild("MainMenuBtn/Effect")
  self._characterGuideEffect = self:GetChild("CharInfo/Effect")
  self._menuGuideBack = self:GetChild("GuideBack")
  self._menuGuideTipText = self:GetChild("GuideBack/GuideTxt")
  self._dungeonBtn = self:GetChild("Adventure")
  self._dungeonRedDot = self:GetChild("Adventure/RedDot")
  self._gachaBtn = self:GetChild("Gacha")
  self._taskBtn = self:GetChild("Task")
  self._taskRedIcon = self:GetChild("Task/RedDot")
  self._courtyardBtn = self:GetChild("Yard")
  self._yardGuideBtn = self:GetChild("Yard/Guide")
  self._yardRedDot = self:GetChild("Yard/RedDot")
  self._yardRedDotNum = self:GetChild("Yard/RedDot/Num")
  self._friendsButton = self:GetChild("Friends")
  self._friendsRedIcon = self:GetChild("Friends/RedDot")
  self._charInfoBtn:Subscribe_PointerClickEvent(self.OnCharInfoBtnClick, self)
  self._teamPresetBtn:Subscribe_PointerClickEvent(self.OnTeamPresetBtnClick, self)
  self._workShopBtn:Subscribe_PointerClickEvent(self.OnWorkShopClick, self)
  self._guildBtn:Subscribe_PointerClickEvent(self.OnGuildClick, self)
  self._dungeonBtn:Subscribe_PointerClickEvent(self.OnDungeonBtnClicked, self)
  self._gachaBtn:Subscribe_PointerClickEvent(self.OnGachaBtnClicked, self)
  self._taskBtn:Subscribe_PointerClickEvent(self.OnTaskBtnClicked, self)
  self._courtyardBtn:Subscribe_PointerClickEvent(self.OnCourtyardBtnClicked, self)
  self._tuJianBtn:Subscribe_PointerClickEvent(self.OnHandBookClicked, self)
  self._friendsButton:Subscribe_PointerClickEvent(self.OnFriendsClick, self)
  self._charNewIcon:SetActive(false)
  self._charRedIcon:SetActive(false)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnRedPointNumChanged, Common.n_RedPointNumChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCharNewIcon, Common.n_RefreshNewRole, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTaskRedData, Common.n_TaskRedChange, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshHandBookRedData, Common.n_RefreshRoleFavorRedData, nil)
  LuaNotificationCenter.AddObserver(self, self.OnReceiveDungeonList, Common.n_ReceiveDungeonList, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDungeonRedDot, Common.n_ReceiveDungeonPointAward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDungeonRedDot, Common.n_ReceiveDungeonWorldAward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDungeonRedDot, Common.n_RefreshBossPanelRed, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDungeonRedDot, Common.n_RefreshFragmentPanelRed, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDungeonRedDot, Common.n_RefreshUndecidedRoadRedDot, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDungeonRedDot, Common.n_SReceiveWeekAward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDungeonRedDot, Common.n_SWeekBossRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDungeonRedDot, Common.n_WeekBossTaskRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDungeonRedDot, Common.n_SOpenWeekBossPanel, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDungeonRedDot, Common.n_WeekBossChallengeRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDungeonRedDot, Common.n_SeasonPvpAward, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshYardRedDot, Common.n_BuildingGetNumChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshYardRedDot, Common.n_BuildingPauseTaskNumChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshFriendRedIcon, Common.n_FriendsRedChange, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshGuildRedIcon, Common.n_OnSLightPartyRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshGuildRedIcon, Common.n_ClientSetGuildRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshGuildRedIcon, Common.n_OnAddNewMsg, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshWorkShopRedIcon, Common.n_GuideStatusChanged, nil)
  self:OnRedPointNumChanged()
  self:RefreshCharNewIcon()
  self:RefreshTaskRedData()
  self:RefreshHandBookRedData()
  self:RefreshDungeonRedDot()
  self:RefreshYardRedDot()
  self:RefreshFriendRedIcon()
  self:RefreshGuildRedIcon()
  self._courtyardBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.CourtYard))
  self._tuJianBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Handbook))
  self._gachaBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Gacha))
  self._taskBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_MainLine))
  self._friendsButton:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Friend))
  self._guildBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Guild))
  NekoData.BehaviorManager.BM_Game:SetGMHideUIByDialog(DataCommon.GMHideUI.MainCity, self)
  DialogManager.CreateSingletonDialog("guide.blockclickdefaultdialog")
  self._workShopBtn_RedDot:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.RoleReset) and not NekoData.BehaviorManager.BM_Guide:HasFinished(65))
end

function BaseMainMenuDialog:OnDestroy()
  DialogManager.DestroySingletonDialog("guide.blockclickdefaultdialog")
  LuaNotificationCenter.RemoveObserver(self)
end

function BaseMainMenuDialog:Init(baseSceneController)
  self._baseSceneController = baseSceneController
end

function BaseMainMenuDialog:LoadLocalData()
end

function BaseMainMenuDialog:OnDialogDestroy(notification)
  if notification.userInfo._dialogName == "task.taskmaindialog" then
    LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, BaseMainMenuDialog, nil)
  end
end

function BaseMainMenuDialog:OnMenuBtnClick()
  if self._menuClick then
    if self._isOpen then
      self._buttonClick = false
      self:GetRootWindow():PlayAnimation("HUDMenuHide")
    else
      self._charInfoBtn:SetActive(true)
      self._tuJianBtn:SetActive(true)
      self._workShopBtn:SetActive(true)
      self._guildBtn:SetActive(true)
      self._teamPresetBtn:SetActive(true)
      self:GetRootWindow():PlayAnimation("HUDMenuShow")
    end
  end
  self._menuClick = false
end

function BaseMainMenuDialog:OnAnimationStateExit(handler, stateName, normalizedTime)
  if stateName == "HUDMenuHide" then
    self._charInfoBtn:SetActive(false)
    self._tuJianBtn:SetActive(false)
    self._workShopBtn:SetActive(false)
    self._guildBtn:SetActive(false)
    self._teamPresetBtn:SetActive(false)
    self._isOpen = false
  elseif stateName == "HUDMenuShow" then
    self._buttonClick = true
    self._isOpen = true
  end
  self._menuClick = true
end

function BaseMainMenuDialog:OnCharInfoBtnClick()
  self._baseSceneController:SetStateNotShowUI()
  self._baseSceneController:SetCameraAnimatorState(9)
end

function BaseMainMenuDialog:OnTeamPresetBtnClick()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teampresetmaindialog")
  dialog:Init(self._baseSceneController)
end

function BaseMainMenuDialog:OnWorkShopClick()
  self._baseSceneController:SetStateNotShowUI()
  self._baseSceneController:SetCameraAnimatorState(8)
end

function BaseMainMenuDialog:OnGuildClick()
  self._baseSceneController:SetCameraAnimatorState(5)
end

function BaseMainMenuDialog:OnDungeonBtnClicked()
  self._baseSceneController:SetCameraAnimatorState(1)
end

function BaseMainMenuDialog:OnGachaBtnClicked()
  self._baseSceneController:SetCameraAnimatorState(2)
end

function BaseMainMenuDialog:OnTaskBtnClicked()
  self._baseSceneController:SetCameraAnimatorState(3)
end

function BaseMainMenuDialog:OnCourtyardBtnClicked()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(21) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(21)
  end
  local csend = LuaNetManager.CreateProtocol("protocol.yard.copenyard")
  csend:Send()
end

function BaseMainMenuDialog:OnFriendsClick()
  if NekoData.BehaviorManager.BM_Game:IsGuest() and CVarConfig:GetRecorder(94).Value == "0" then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100338)
    return
  end
  DialogManager.CreateSingletonDialog("friend.friendsmaindialog")
end

function BaseMainMenuDialog:OnHandBookClicked()
  DialogManager.CreateSingletonDialog("handbook.handbookdialog")
end

function BaseMainMenuDialog:OnRedPointNumChanged(notification)
  local showRedPoint
  if not notification or notification and notification.userInfo.redPointID == 100001 then
    showRedPoint = NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(100001) > 0
  end
  self._charRedIcon:SetActive(showRedPoint)
end

function BaseMainMenuDialog:RefreshCharNewIcon()
  self._charNewIcon:SetActive(NekoData.BehaviorManager.BM_AllRoles:IsHasNewRole())
end

function BaseMainMenuDialog:RefreshTaskRedData()
  local redData = NekoData.BehaviorManager.BM_Task:GetRedData()
  self._taskRedIcon:SetActive(redData:IsTrue())
end

function BaseMainMenuDialog:RefreshHandBookRedData()
  self._tuJianRedIcon:SetActive(NekoData.BehaviorManager.BM_HandBook:IsShowRoleFavorAwardRed())
end

function BaseMainMenuDialog:RefreshDungeonRedDot()
  local dungeonAllReceive = NekoData.BehaviorManager.BM_Game:GetIfAllDungeonWorldAndZoneAwardReceive()
  local bossRushRed = NekoData.BehaviorManager.BM_Game:IsBossPanelShowRed()
  local fragmentRed = NekoData.BehaviorManager.BM_Game:IsFragmentPanelShowRed()
  local undecidedRoadRed = NekoData.BehaviorManager.BM_Game:IsUndecidedRoadShowRed()
  local weekBossRed = NekoData.BehaviorManager.BM_WeekBoss:IfShowRedDotInMainlinePanel()
  local seasonRed = false
  if NekoData.BehaviorManager.BM_Battle:GetSeasonNotify() and NekoData.BehaviorManager.BM_Battle:GetSeasonNotify().award and NekoData.BehaviorManager.BM_Battle:GetSeasonNotify().award > 0 then
    seasonRed = true
  end
  if not dungeonAllReceive or bossRushRed or fragmentRed or undecidedRoadRed or weekBossRed or seasonRed then
    self._dungeonRedDot:SetActive(true)
  else
    self._dungeonRedDot:SetActive(false)
  end
end

function BaseMainMenuDialog:OnReceiveDungeonList()
  self:RefreshDungeonRedDot()
end

function BaseMainMenuDialog:RefreshYardRedDot()
  local pauseTaskNum = NekoData.BehaviorManager.BM_Explore:GetPauseTaskNum() + NekoData.BehaviorManager.BM_Firefly:GetPauseTaskNum() + NekoData.BehaviorManager.BM_Cabin:GetPauseTaskNum()
  local getNum = NekoData.BehaviorManager.BM_MagicTree:GetGetNum() + NekoData.BehaviorManager.BM_Explore:GetGetNum() + NekoData.BehaviorManager.BM_YardMusic:GetGetNum()
  if 0 < pauseTaskNum + getNum then
    self._yardRedDot:SetActive(true)
    self._yardRedDotNum:SetText(pauseTaskNum + getNum)
  else
    self._yardRedDot:SetActive(false)
  end
end

function BaseMainMenuDialog:RefreshFriendRedIcon()
  local redData = NekoData.BehaviorManager.BM_Friends:GetRedData()
  self._friendsRedIcon:SetActive(redData:IsTrue())
end

function BaseMainMenuDialog:RefreshWorkShopRedIcon(notification)
  local guideId = notification.userInfo.guideID
  if guideId == 65 and notification.userInfo.guideStatus == "Finish" then
    self._workShopBtn_RedDot:SetActive(false)
  elseif guideId == 67 and notification.userInfo.guideStatus == "Finish" then
    self:OnRedPointNumChanged()
  end
end

function BaseMainMenuDialog:RefreshGuildRedIcon()
  local isRedpoistOn = NekoData.BehaviorManager.BM_Guild:IsRedPointOn()
  if NekoData.BehaviorManager.BM_Guild:GetGuildBossRed().flag and NekoData.BehaviorManager.BM_Guild:GetGuildBossRed().flag > 0 then
    isRedpoistOn = true
  end
  self._guildRedIcon:SetActive(isRedpoistOn)
  if not isRedpoistOn then
    local unReadMessageCount = NekoData.BehaviorManager.BM_Guild:GetUnReadMessageCount()
    if 0 < unReadMessageCount then
      self._guildUnreadMessageRedIcon:SetActive(true)
      self._guildUnreadMessageCount:SetText(unReadMessageCount)
    else
      self._guildUnreadMessageRedIcon:SetActive(false)
    end
  else
    self._guildUnreadMessageRedIcon:SetActive(false)
  end
end

return BaseMainMenuDialog
