local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local UIManager = CS.PixelNeko.UI.UIManager
local Time = CS.UnityEngine.Time
local CSpirit = BeanManager.GetTableByName("dungeonselect.cdungeonselectstrength")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CPlayerLevel = BeanManager.GetTableByName("role.cplayerlevel")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CHexagonScene = BeanManager.GetTableByName("activity.chexagonscene")
local CChrisTimeConfig = BeanManager.GetTableByName("dungeonselect.cchristimeconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local timeutils = require("logic.utils.timeutils")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local ChannelType = require("protocols.bean.protocol.chat.channeltype")
local MillisecondToDay = 86400000
local DM_RedDot = NekoData.DataManager.DM_RedDot
local BaseMainUI = class("BaseMainUI", Dialog)
BaseMainUI.AssetBundleName = "ui/layouts.basemainhud"
BaseMainUI.AssetName = "BaseMainHUD"
local Limit

local function RefreshWelfareButton(self)
  if NekoData.BehaviorManager.BM_Welfare:ShowWelfareEntrance() then
    self._welfareButton:SetActive(true)
    self._welfareRedIcon:SetActive(NekoData.BehaviorManager.BM_Welfare:ShowWelfareRedDot())
  else
    self._welfareButton:SetActive(false)
  end
end

function BaseMainUI:RefreshHalloweenBtn()
  local open = NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(41)
  if open then
    local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.HalloweenActivityID)
    self._halloweenBtn:SetActive(bm:GetIsOpen())
    if bm:GetIsOpen() then
      self._halloweenRedDot:SetActive(bm:ShowRedDot())
      if self._halloweenRemainTimeTsak then
        GameTimer.RemoveTask(self._halloweenRemainTimeTsak)
      end
      self._halloweenRemainTimeTsak = GameTimer.AddTask(0, 60, function()
        self._halloweenTimeTxt:SetText(self:GetRemainTimeStr(bm:GetRemainTime()))
      end, nil)
    end
  else
    self._halloweenBtn:SetActive(false)
  end
end

local function RefreshReturnWelfareBtn(self)
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.OverseasReturnWelfareActivityId) then
    self._returnWelfareBtn:SetActive(true)
    self._returnWelfareBtnRedDot:SetActive(false)
  elseif NekoData.BehaviorManager.BM_ReturnWelfare:ShowReturnWelfareEntrance() then
    self._returnWelfareBtn:SetActive(true)
    local taskRedDot = NekoData.BehaviorManager.BM_ActivityTasks:ReturnWelfareTaskRedDot()
    local enterKeyRedDot = NekoData.BehaviorManager.BM_Activity:GetBackGiftRedPoint()
    local taskRewardRedDot = NekoData.BehaviorManager.BM_Activity:GetBackTaskRedPoint()
    local returnBattlePassRedDot = NekoData.BehaviorManager.BM_ReturnWelfare:ShowReturnBattlePassRedDot()
    local showRedDot = taskRedDot or enterKeyRedDot or taskRewardRedDot or returnBattlePassRedDot
    self._returnWelfareBtnRedDot:SetActive(showRedDot)
  else
    self._returnWelfareBtn:SetActive(false)
  end
end

local function RefreshPopUpGiftBtn(self)
  self._popUpGiftBtn:SetActive(NekoData.BehaviorManager.BM_Activity:GetPopUpGift() or NekoData.BehaviorManager.BM_Activity:GetPopUpGift7Day())
  if NekoData.BehaviorManager.BM_Activity:GetPopUpGift7Day() and NekoData.BehaviorManager.BM_Activity:ShowPopUpGift7DayRedDot() then
    self._popUpGiftBtn_RedDot:SetActive(true)
  else
    self._popUpGiftBtn_RedDot:SetActive(false)
  end
end

function BaseMainUI:Ctor(...)
  BaseMainUI.super.Ctor(self, ...)
  self._groupName = "Default"
  self._dragBack = nil
  self._baseSceneController = nil
  self._repairingRoleList = {}
  self._roleList = nil
  self._spirit = nil
end

function BaseMainUI:OnCreate()
  Limit = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
  self._num0Icon = self:GetChild("TopGroup/Num0/Icon")
  self._num0Btn = self:GetChild("TopGroup/Num0")
  self._num0Text = self:GetChild("TopGroup/Num0/Text")
  self._num0RedDot = self:GetChild("TopGroup/Num0/RedDot")
  self._spiritOverdueReminder = self:GetChild("TopGroup/Txt2")
  self._num1Btn = self:GetChild("TopGroup/Num1")
  self._num1Text = self:GetChild("TopGroup/Num1/Text")
  self._num2Btn = self:GetChild("TopGroup/Num2")
  self._num2Text = self:GetChild("TopGroup/Num2/Text")
  self._num2AddBtn = self:GetChild("TopGroup/Num2/Add")
  self._num3Btn = self:GetChild("TopGroup/Num3")
  self._num3Text = self:GetChild("TopGroup/Num3/Text")
  self._time = self:GetChild("TopGroup/Time")
  self._timeTxt = self:GetChild("TopGroup/Txt")
  self._num0Btn:Subscribe_PointerClickEvent(self.OnNum0BtnClick, self)
  self._num1Btn:Subscribe_PointerClickEvent(self.OnNum1BtnClick, self)
  self._num2Btn:Subscribe_PointerClickEvent(self.OnNum2BtnClick, self)
  self._num2AddBtn:Subscribe_PointerClickEvent(self.OnNum2AddBtnClick, self)
  self._num3Btn:Subscribe_PointerClickEvent(self.OnNum3BtnClick, self)
  self._gmChatBtn = self:GetChild("GM")
  self._repairBtn = self:GetChild("Repair")
  self._mailButton = self:GetChild("Mail")
  self._mailRedDot = self:GetChild("Mail/RedDot")
  self._name = self:GetChild("PlayerInfo/NameBack/Name")
  self._nameLight = self:GetChild("PlayerInfo/NameBack/NameLight")
  self._headPhotoPanel = self:GetChild("PlayerInfo")
  self._headPhoto = self:GetChild("PlayerInfo/HeadPhoto")
  self._photo = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._headFrame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._redDot = self:GetChild("PlayerInfo/HeadPhoto/RedDot")
  self._levelPanel = self:GetChild("PlayerInfo/Level")
  self._levelNum = self:GetChild("PlayerInfo/Level/LevelNum")
  self._expNum = self:GetChild("PlayerInfo/Level/EXPNum")
  self._levelMaxText = self:GetChild("PlayerInfo/Level/Max")
  self._levelProgress = self:GetChild("PlayerInfo/Level/ProgressLevel/BackGround/Progress")
  self._shopBtn = self:GetChild("Shop")
  self._shopBoxIbtn = self:GetChild("Shop/Gift")
  self._shopBtnRedPoint = self:GetChild("Shop/RedDot")
  self._orderBtn = self:GetChild("Order")
  self._firstRecharge = self:GetChild("FirstRecharge")
  self._firstRechargeRedDot = self:GetChild("FirstRecharge/RedDot")
  self._communityWelfare = self:GetChild("CommunityWelfare")
  self._communityWelfareRedDot = self:GetChild("CommunityWelfare/RedDot")
  self._dragBack = self:GetChild("Panel")
  self._welfareButton = self:GetChild("Welfare")
  self._welfareRedIcon = self:GetChild("Welfare/RedDot")
  self._welfareRedIcon:SetActive(false)
  self._returnWelfareBtn = self:GetChild("HuiguiWelfare")
  self._returnWelfareBtnRedDot = self:GetChild("HuiguiWelfare/RedDot")
  self._bannerButton = self:GetChild("RightGroup2/Activity")
  self._repairEffect = self:GetChild("Repair/Effect")
  self._menuBtn = self:GetChild("MenuBtn")
  self._msgPopBack = self:GetChild("ChatCellBack")
  self._noticeBtn = self:GetChild("Active/ActiveBtn")
  self._kefuBtn = self:GetChild("Kefu/KefuBtn")
  self._noticeRedPoint = self:GetChild("Active/ActiveBtn/RedDot")
  self._noticeRedPoint:SetActive(false)
  self._popUpGiftBtn = self:GetChild("Promotions")
  self._popUpGiftBtn_RedDot = self:GetChild("Promotions/RedDot")
  self._chatpannel = self:GetChild("ChatArea")
  self._chatframe = self:GetChild("ChatArea/ChatFrame")
  self:GetChild("Promotions/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2104))
  self._chatpannel:Subscribe_PointerClickEvent(self.OnChatBtnClick, self)
  self._gmChatBtn:Subscribe_PointerClickEvent(self.OnGMChatBtnClick, self)
  self._repairBtn:Subscribe_PointerClickEvent(self.OnRepairBtnClick, self)
  self._mailButton:Subscribe_PointerClickEvent(self.HandleMailButtonPointerClick, self)
  self._welfareButton:Subscribe_PointerClickEvent(self.OnWelfareClick, self)
  self._returnWelfareBtn:Subscribe_PointerClickEvent(self.OnReturnWelfareClick, self)
  self._bannerButton:Subscribe_PointerClickEvent(self.OnBannerClick, self)
  self._headPhoto:Subscribe_PointerClickEvent(self.OnHeadPhotoClick, self)
  self._shopBtn:Subscribe_PointerClickEvent(self.OnShopClick, self)
  self._shopBoxIbtn:Subscribe_PointerClickEvent(self.OnShopBoxIbtnClick, self)
  self._orderBtn:Subscribe_PointerClickEvent(self.OnOrderClick, self)
  self._firstRecharge:Subscribe_PointerClickEvent(self.OnFirstRechargeClick, self)
  self._communityWelfare:Subscribe_PointerClickEvent(self.OnCommunityWelfareClick, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClick, self)
  self._noticeBtn:Subscribe_PointerClickEvent(self.OnNoticeClick, self)
  self._kefuBtn:Subscribe_PointerClickEvent(self.OnKefuClick, self)
  self._popUpGiftBtn:Subscribe_PointerClickEvent(self.OnPopUpGiftBtn, self)
  self._chatoutFrame = TableFrame.Create(self._chatframe, self, true, true, true)
  self._chatoutFrame:SetMargin(40, 0)
  self._starmirageBtn = self:GetChild("ActivityStar")
  self._starmirageBtn_redDot = self:GetChild("ActivityStar/RedDot")
  self._starmirageBtn:Subscribe_PointerClickEvent(self.OnStarMirageBtnClick, self)
  self._swimSuitBtn = self:GetChild("ActivitySwimSuit")
  self._swimSuitBtn_redDot = self:GetChild("ActivitySwimSuit/RedDot")
  self._swimSuitBtn:Subscribe_PointerClickEvent(self.OnSwimSuitBtnClick, self)
  self._swimSuitBtn_Time = self:GetChild("ActivitySwimSuit/Time")
  self._swimSuitBtn_Effect = self:GetChild("ActivitySwimSuit/UILogin")
  self._halloweenBtn = self:GetChild("ActivityHalloween")
  self._halloweenBtn:SetActive(false)
  self._birthDayActivityBtn = self:GetChild("ActivityLogin")
  self._birthDayActivityBtn:SetActive(false)
  self._christmasActivityBtn = self:GetChild("ActivityChristmas")
  self._christmasActivityBtn:SetActive(false)
  self._christmasActivityBtn:SetActive(false)
  self._activityPanel = self:GetChild("Activity")
  DialogManager.CreateSingletonChildDialog("activity.baseactivity", "base.basemainui", self._activityPanel)
  LuaNotificationCenter.AddObserver(self, self.RefreshActivityPanel, Common.n_RefreshActivities, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshActivityRewards, Common.n_RefreshActivityRewards, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshActivityRewards, Common.n_LocalTipsStateChanged, nil)
  LogInfoFormat("BaseMainUI", "###############")
  self._time:SetActive(false)
  self._timeTxt:SetActive(false)
  self._gmChatBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsGM())
  LuaNotificationCenter.AddObserver(self, self.RefreshSpiritRedPoint, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpiritRedPoint, Common.n_ItemAdd, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpiritRedPoint, Common.n_ItemNumModify, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserName, Common.n_UserNameChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserHeadPhoto, Common.n_ChangeUserHeadPhoto, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserHeadFrame, Common.n_ChangeUserHeadFrame, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshGift, Common.n_RefreshGrowGift, nil)
  LuaNotificationCenter.AddObserver(self, self.OnShopRedPoint, Common.n_ShopRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.OnPlayerExpChanged, Common.n_PlayerExpChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnStrengthLimitChanged, Common.n_StrengthLimitChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnShopRedPoint, Common.n_ChargeAccumulationAddPoints, nil)
  LuaNotificationCenter.AddObserver(self, self.OnShopRedPoint, Common.n_ChargeAccumulationReceiveReward, nil)
  LuaNotificationCenter.AddObserver(self, self.OnShopRedPoint, Common.n_RefreshSkinCollectAwardStatus, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNoticeRedPoint, Common.n_NewInGameAnnouncement, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshFitstRechargeRedot, Common.n_FitstRechargeGiftRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCommunityWelfareRedot, Common.n_CommunityWelfareRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshFitstRechargeGift, Common.n_FirstRechargeGiftState, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSActivityTasksUpdate, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSActivityTasksUpdate, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDreamSprialRedDot, Common.n_DreamSpiralRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDreamSprialRedDot, Common.n_TriggerGuide, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSFreeLevelGiftIcon, Common.n_SFreeLevelGiftIcon, nil)
  LuaNotificationCenter.AddObserver(self, self.OnOthersActivitysTimeOver, Common.n_OthersActivitysTimeOver, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshReturnWelfareRedDot, Common.n_RefreshReturnWelfareRedDot, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshForesight, Common.n_OnSGeneralForesightAct, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshAnniversaryShare, Common.n_OnSAnniversaryShareInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMinDiscountRedDot, Common.n_OnRefreshMinDiscount, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshChatPanel, Common.n_ChatInfoReceive, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChatStateSwitch, Common.n_ChatStateSwitch, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChatBlockWorldMsg, Common.n_ChatBlockWorldMsg, nil)
  LuaNotificationCenter.AddObserver(self, RefreshWelfareButton, Common.n_RefreshLimitedInvestment, nil)
  LuaNotificationCenter.AddObserver(self, RefreshWelfareButton, Common.n_RefreshMonthSign, nil)
  LuaNotificationCenter.AddObserver(self, RefreshWelfareButton, Common.n_RefreshAccumulateCost, nil)
  LuaNotificationCenter.AddObserver(self, RefreshWelfareButton, Common.n_OnRefreshOldPlayerBenefits, nil)
  LuaNotificationCenter.AddObserver(self, RefreshPopUpGiftBtn, Common.n_RefreshPopUpGift, nil)
  LuaNotificationCenter.AddObserver(self, RefreshPopUpGiftBtn, Common.n_RefreshPopUpGift7Day, nil)
  LuaNotificationCenter.AddObserver(self, RefreshReturnWelfareBtn, Common.n_RefreshReturnBattlePass, nil)
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Shop) then
    self._shopBtnRedPoint:SetActive(DM_RedDot.GetNodeResult(DM_RedDot.nodeShop))
    self._shopBtn:SetActive(true)
    self._shopBoxIbtn:SetActive(NekoData.BehaviorManager.BM_Shop:GetShowBoxIcon())
  else
    self._shopBtnRedPoint:SetActive(false)
    self._shopBtn:SetActive(false)
    self._shopBoxIbtn:SetActive(false)
  end
  RefreshWelfareButton(self)
  RefreshReturnWelfareBtn(self)
  local tag = NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Mail)
  self._mailButton:SetActive(tag)
  if tag then
    self:OnRefreshMailRedDot()
    LuaNotificationCenter.AddObserver(self, self.OnRefreshMailRedDot, Common.n_MailInfoChange, nil)
  end
  self._chatpannel:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Chat))
  self._noticeBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Notice))
  RefreshPopUpGiftBtn(self)
  local channel = SdkManager.GetChannel()
  if channel == "none" or channel == "qian" or channel == "mqan" then
    if NekoData.BehaviorManager.BM_Welfare:GetCommunityShareInfo() then
      self._communityWelfare:SetActive(true)
    else
      self._communityWelfare:SetActive(false)
    end
  else
    self._communityWelfare:SetActive(false)
  end
  self:OnRefreshFitstRechargeGift()
  self:OnRefreshFitstRechargeRedot()
  self:OnRefreshCommunityWelfareRedot()
  self:RefreshOrderBtn()
  self:OnShopRedPoint()
  self:RefreshActivityPanel()
  self:RefreshActivityRewards()
  self:ShowHideKefuBtn()
  self:OnRefreshChatPanel()
  NekoData.BehaviorManager.BM_Game:SetGMHideUIByDialog(DataCommon.GMHideUI.MainCity, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshOfflineSweepActive, Common.n_RefreshOfflineSweepActive, nil)
  self:RefreshOfflineSweepActive()
  LuaNotificationCenter.AddObserver(self, self.OnNewOverlayFSMounted, Common.n_NewOverlayFSMounted, nil)
end

function BaseMainUI:OnDestroy()
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
  end
  self._chatoutFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("chat.msgpopdialog")
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("base.basemainmenudialog")
  DialogManager.DestroySingletonDialog("fastmenu.fastmenudialog")
  DialogManager.DestroySingletonDialog("chat.chatmaindialog")
  DialogManager.DestroySingletonDialog("mail.maildialog")
  DialogManager.DestroySingletonDialog("friend.friendsmaindialog")
  DialogManager.DestroySingletonDialog("welfare.welfaremaindialog")
  DialogManager.DestroySingletonDialog("guild.guildmaindetail")
  DialogManager.DestroySingletonDialog("banner.bannerdialog")
  if self._halloweenRemainTimeTsak then
    GameTimer.RemoveTask(self._halloweenRemainTimeTsak)
  end
  if self._birthDayRemainTimeTsak then
    GameTimer.RemoveTask(self._birthDayRemainTimeTsak)
  end
  if self._offlinesweepDialog then
    self._offlinesweepDialog:Destroy()
    self._offlinesweepDialog = nil
  end
end

function BaseMainUI:Init(sceneController)
  self._baseSceneController = sceneController
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  self._name:SetText(userInfo.username)
  self._nameLight:SetText(NekoData.BehaviorManager.BM_Message:GetString(2090, {
    userInfo.username
  }))
  local imageRecord
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  if headPhotoRecord then
    imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("BaseMainUI", "userInfo.avatarId %s is wrong", userInfo.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if headPhotoFrameRecord then
    imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("BaseMainUI", "userInfo.frameId %s is wrong", userInfo.frameId)
  end
  self:UpdateLive2dRedDot()
  local recorder = CPlayerLevel:GetRecorder(userInfo.userlevel)
  local currentLevelExpNum = userInfo.userexp
  local currentLevelExpMax = recorder.exp
  local allIds = CPlayerLevel:GetAllIds()
  local maxLevel = CPlayerLevel:GetRecorder(#allIds).id
  local maxLevelMaxExp = CPlayerLevel:GetRecorder(#allIds).exp
  local isMax = userInfo.userlevel == maxLevel
  self._levelMaxText:SetActive(isMax)
  self._expNum:SetActive(not isMax)
  if isMax then
    currentLevelExpNum = maxLevelMaxExp
  end
  self._levelProgress:SetFillAmount(currentLevelExpNum / currentLevelExpMax)
  self._levelNum:SetText(userInfo.userlevel)
  if currentLevelExpNum ~= currentLevelExpMax then
    local str = TextManager.GetText(CStringRes:GetRecorder(1203).msgTextID)
    str = string.gsub(str, "%$parameter1%$", tostring(currentLevelExpNum))
    str = string.gsub(str, "%$parameter2%$", tostring(currentLevelExpMax))
    self._expNum:SetText(str)
  end
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID)
  self._num0Text:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(Limit))
  self:SetSpiritItemOverdueReminder()
  self:HandleSpriteEvidence()
  self._num1Text:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SoulDropID))
  self._num2Text:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
  self._num3Text:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID))
  self._roleList = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
  while self._repairingRoleList[#self._repairingRoleList] do
    table.remove(self._repairingRoleList, #self._repairingRoleList)
  end
  for index, role in ipairs(self._roleList) do
    if role:GetHurtExtent() ~= 0 then
      table.insert(self._repairingRoleList, role)
    end
  end
  self:SetRepairBtn()
  DialogManager.CreateSingletonDialog("base.basemainmenudialog"):Init(sceneController)
  self._swimSuitBtn_redDot:SetActive(NekoData.BehaviorManager.BM_Activity:GetActivityRedPointID() == DataCommon.Activities.SwimSuit)
end

function BaseMainUI:UpdateLive2dRedDot()
  local islive2d_downloaded = Live2DManager.IsDownloaded()
  local isaudio_downloaded = LuaAudioManager.IsDownloaded()
  if islive2d_downloaded == true and isaudio_downloaded == true then
    self._redDot:SetActive(false)
  else
    self._redDot:SetActive(true)
  end
end

function BaseMainUI:OnNewOverlayFSMounted(args)
  self:UpdateLive2dRedDot()
end

function BaseMainUI:SetSpiritItemOverdueReminder()
  self._spiritItem = NekoData.BehaviorManager.BM_BagInfo:GetDeleteSpiritItem()
  self._spiritItemDelTime = nil
  self._spiritItemDelName = nil
  if self._spiritItem then
    self._spiritItemDelTime = self._spiritItem:GetDelTime()
    self._spiritItemDelName = self._spiritItem:GetName()
  end
  self._num0RedDot:SetActive(self._spiritItemDelTime and self._spiritItemDelTime - ServerGameTimer.GetServerTime() < MillisecondToDay)
  self._spiritOverdueReminder:SetActive(self._spiritItemDelTime and self._spiritItemDelTime - ServerGameTimer.GetServerTime() < MillisecondToDay)
  if self._spiritItemDelTime then
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
    self._task = ServerGameTimer.AddTask(0, 1, function()
      self:SpiritTask()
    end, nil)
  end
end

local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60

local function GetDelTimeStr(ms, name)
  local sec = ms // 1000
  local str
  if sec > SecToDay then
    return
  end
  if sec > SecToHour then
    str = TextManager.GetText(701156)
  elseif sec > SecToMin then
    str = TextManager.GetText(701169)
    str = string.gsub(str, "%$parameter2%$", os.date("!%M", sec))
  else
    str = TextManager.GetText(701158)
  end
  str = string.gsub(str, "%$parameter1%$", name)
  return str
end

function BaseMainUI:RefreshOfflineSweepActive()
  local status = NekoData.BehaviorManager.BM_OfflineSweep:GetStatus()
  if status ~= 0 then
    if self._offlinesweepDialog == nil then
      self._offlinesweepDialog = DialogManager.CreateDialog("mainline.offlinesweep.offlinesweepshowbtndialog", self._rootWindow._uiObject)
    end
  elseif self._offlinesweepDialog then
    self._offlinesweepDialog:Destroy()
    self._offlinesweepDialog = nil
  end
end

function BaseMainUI:SpiritTask()
  if self._spiritItemDelTime == nil then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
    return
  end
  local time = self._spiritItemDelTime - ServerGameTimer.GetServerTime()
  self._num0RedDot:SetActive(time < MillisecondToDay)
  self._spiritOverdueReminder:SetActive(time < MillisecondToDay)
  if 0 < time then
    self._spiritOverdueReminder:SetText(GetDelTimeStr(time, self._spiritItemDelName))
  else
    local CUpdateLimitedItems = LuaNetManager.CreateProtocol("protocol.item.cupdatelimiteditems")
    if CUpdateLimitedItems then
      CUpdateLimitedItems.itemKey = self._spiritItem:GetKey()
      CUpdateLimitedItems.itemId = self._spiritItem:GetID()
      CUpdateLimitedItems:Send()
    end
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function BaseMainUI:OnPlayerExpChanged()
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local recorder = CPlayerLevel:GetRecorder(userInfo.userlevel)
  local currentLevelExpNum = userInfo.userexp
  local currentLevelExpMax = recorder.exp
  local allIds = CPlayerLevel:GetAllIds()
  local maxLevel = CPlayerLevel:GetRecorder(#allIds).id
  local maxLevelMaxExp = CPlayerLevel:GetRecorder(#allIds).exp
  local isMax = userInfo.userlevel == maxLevel
  if isMax then
    currentLevelExpNum = maxLevelMaxExp
  end
  self._levelMaxText:SetActive(isMax)
  self._expNum:SetActive(not isMax)
  self._levelProgress:SetFillAmount(currentLevelExpNum / currentLevelExpMax)
  self._levelNum:SetText(userInfo.userlevel)
  if currentLevelExpNum ~= currentLevelExpMax then
    local str = TextManager.GetText(CStringRes:GetRecorder(1203).msgTextID)
    str = string.gsub(str, "%$parameter1%$", tostring(currentLevelExpNum))
    str = string.gsub(str, "%$parameter2%$", tostring(currentLevelExpMax))
    self._expNum:SetText(str)
  end
end

function BaseMainUI:OnStrengthLimitChanged()
  self._num0Text:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit))
end

function BaseMainUI:OnRefreshMailRedDot()
  local tag = false
  for type, mailList in pairs(NekoData.BehaviorManager.BM_Mail:GetMail().list) do
    for i, mail in ipairs(mailList) do
      if mail.status == 0 then
        tag = true
        break
      end
    end
  end
  self._mailRedDot:SetActive(tag)
end

function BaseMainUI:SetRepairBtn()
  if #self._repairingRoleList > 0 then
    self._repairBtn:SetActive(true)
  else
    self._repairBtn:SetActive(false)
  end
end

function BaseMainUI:OnShopRedPoint(notification)
  self._shopBtnRedPoint:SetActive(DM_RedDot.GetNodeResult(DM_RedDot.nodeShop))
end

function BaseMainUI:OnSFreeLevelGiftIcon(notification)
  self._shopBoxIbtn:SetActive(NekoData.BehaviorManager.BM_Shop:GetShowBoxIcon())
end

function BaseMainUI:HideShopGiftIcon()
  self._shopBoxIbtn:SetActive(false)
end

local function AddActivityGameTimer(self)
end

function BaseMainUI:RefreshActivityPanel()
end

function BaseMainUI:RefreshActivityRewards()
  RefreshWelfareButton(self)
end

function BaseMainUI:OnRefreshChatPanel()
  self._chatData = {}
  local chatTable = NekoData.BehaviorManager.BM_Chat:GetChannelChatDataOut(ChannelType.CHANNEL_WORLD)
  for i = 1, #chatTable do
    self._chatData[i] = chatTable[i]
  end
  self._chatoutFrame:ReloadAllCell()
end

function BaseMainUI:OnChatStateSwitch()
  self:OnRefreshChatPanel()
end

function BaseMainUI:OnChatBlockWorldMsg()
  self:OnRefreshChatPanel()
end

function BaseMainUI:OnNoticeRedPoint(notification)
  self._noticeRedPoint:SetActive(NoticeManager.GetInGameRedPoint())
end

function BaseMainUI:OnChangeUserHeadPhoto(notification)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(notification.userInfo.avatarId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function BaseMainUI:OnChangeUserHeadFrame(notification)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(notification.userInfo.frameId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function BaseMainUI:OnChangeUserName(notification)
  self._name:SetText(notification.userInfo.name)
  self._nameLight:SetText(NekoData.BehaviorManager.BM_Message:GetString(2090, {
    notification.userInfo.name
  }))
end

function BaseMainUI:OnRefreshCurrency()
  self._num1Text:SetNumber(NekoData.BehaviorManager.BM_Currency:GetSoulDropCoin())
  self._num2Text:SetNumber(NekoData.BehaviorManager.BM_Currency:GetDiamond())
  self._num3Text:SetNumber(NekoData.BehaviorManager.BM_Currency:GetMoney())
end

function BaseMainUI:OnRefreshSpirit(notification)
  self._num0Text:SetText(NumberManager.GetShowNumber(notification.userInfo.spirit) .. "/" .. NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit))
  self._spirit = notification.userInfo.spirit
end

function BaseMainUI:OnRefresh()
  self._roleList = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
  while self._repairingRoleList[#self._repairingRoleList] do
    table.remove(self._repairingRoleList, #self._repairingRoleList)
  end
  for index, role in ipairs(self._roleList) do
    if role:GetHurtExtent() ~= 0 then
      table.insert(self._repairingRoleList, role)
    end
  end
  self:SetRepairBtn()
end

function BaseMainUI:OnHeadPhotoClick()
  DialogManager.CreateSingletonDialog("systemsetting.systemsettingdialog")
end

function BaseMainUI:OnShopClick()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Shop) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100192)
    return
  end
  self._baseSceneController:SetCameraAnimatorState(0)
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
  if protocol then
    DM_RedDot.SetNodeRead(DM_RedDot.nodeShop, true)
    protocol:Send()
  end
  do
    local jsonStr = JSON.encode({eventName = "event", id = "9"})
    ThinkingAnalyticsInterface.UploadEvent_TA(jsonStr)
  end
  do
    local jsonStr = JSON.encode({eventName = "17"})
    ThinkingAnalyticsInterface.TimeEvent_TA(jsonStr)
  end
end

function BaseMainUI:OnShopBoxIbtnClick()
  NekoData.DataManager.DM_Shop:ClientSetOpenShopID(5)
  NekoData.DataManager.DM_Shop:DisableShowBoxIcon()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
  if protocol then
    DM_RedDot.SetNodeRead(DM_RedDot.nodeShop, true)
    protocol:Send()
  end
  self._shopBoxIbtn:SetActive(false)
end

function BaseMainUI:OnOrderClick()
  local orderdialog = DialogManager.CreateSingletonDialog("order.orderdialog")
  if orderdialog then
    orderdialog:SetDelegate(self)
  end
end

function BaseMainUI:OnFirstRechargeClick()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cfirstchargeopenpanel")
  csend:Send()
end

function BaseMainUI:OnCommunityWelfareClick()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.ccommunityshareinfo")
  csend:Send()
end

function BaseMainUI:OnRefreshFitstRechargeGift()
  local shopFirstRecharge = NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.FirstReCharge) and not NekoData.BehaviorManager.BM_Welfare:IsFitstRechargeGiftAllGet()
  self._firstRecharge:SetActive(shopFirstRecharge)
  if not shopFirstRecharge then
    self:RefreshOrderBtn()
    self:OnRefreshCommunityWelfareRedot()
  end
end

function BaseMainUI:OnRefreshFitstRechargeRedot()
  local showRedDot = NekoData.BehaviorManager.BM_Welfare:GetFitstRechargeGiftRedPoint() or CS.UnityEngine.PlayerPrefs.HasKey("FirstReChargeRedPoint")
  self._firstRechargeRedDot:SetActive(showRedDot)
end

function BaseMainUI:OnRefreshCommunityWelfareRedot()
  local channel = SdkManager.GetChannel()
  if channel == "none" or channel == "qian" or channel == "mqan" then
    if NekoData.BehaviorManager.BM_Welfare:GetCommunityShareInfo() then
      self._communityWelfare:SetActive(true)
    else
      self._communityWelfare:SetActive(false)
    end
    local showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowCommunityShareInfoRedDot()
    self._communityWelfareRedDot:SetActive(showRedDot)
    if not self._firstRecharge:IsActive() then
      self._communityWelfare:SetAnchoredPosition(self._firstRecharge:GetAnchoredPosition())
    end
  else
    self._communityWelfare:SetActive(false)
  end
end

function BaseMainUI:OnOrderGainClick()
  NekoData.DataManager.DM_Game:CloseBookActivity()
  self:RefreshOrderBtn()
end

function BaseMainUI:RefreshOrderBtn()
  local bookActivity = NekoData.BehaviorManager.BM_Game:GetBookActivity()
  self._orderBtn:SetActive(bookActivity ~= nil and bookActivity.isOpen == 1)
  if not self._firstRecharge:IsActive() then
    self._orderBtn:SetAnchoredPosition(self._firstRecharge:GetAnchoredPosition())
  end
end

function BaseMainUI:OnMenuBtnClick()
  local dialog = DialogManager.GetDialog("fastmenu.fastmenudialog")
  if dialog then
    DialogManager.DestroySingletonDialog("fastmenu.fastmenudialog")
  else
    DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
  end
end

function BaseMainUI:OnNoticeClick()
  DialogManager.CreateSingletonDialog("notice.noticedialog")
end

function BaseMainUI:ShowHideKefuBtn()
  if SdkManager.GetChannel() == "quka" or SdkManager.GetChannel() == "qukb" then
    self._kefuBtn:SetActive(false)
  else
    self._kefuBtn:SetActive(true)
  end
end

function BaseMainUI:OnKefuClick()
  CS.PixelNeko.Tools.ShareHelper.OpenURL("https://wpa1.qq.com/QIdteBQ2?_type=wpa&qidian=true")
end

function BaseMainUI:OnPopUpGiftBtn()
  if NekoData.BehaviorManager.BM_Activity:GetPopUpGift() then
    DialogManager.CreateSingletonDialog("welfare.popupgiftdialog")
  elseif NekoData.BehaviorManager.BM_Activity:GetPopUpGift7Day() then
    DialogManager.CreateSingletonDialog("welfare.popupgift7daydialog")
  end
end

function BaseMainUI:OnNum0BtnClick()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

function BaseMainUI:OnNum1BtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.SoulDropID)
    })
    local width, height = self._num1Btn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._num1Btn:GetLocalPointInUiRootPanel())
  end
end

function BaseMainUI:OnNum2BtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.DiamodID)
    })
    local width, height = self._num2Btn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._num2Btn:GetLocalPointInUiRootPanel())
  end
end

function BaseMainUI:OnNum2AddBtnClick()
  NekoData.DataManager.DM_Shop:ClientSetOpenShopID(4)
  self:OnShopClick()
end

function BaseMainUI:OnNum3BtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.ManaID)
    })
    local width, height = self._num3Btn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._num3Btn:GetLocalPointInUiRootPanel())
  end
end

function BaseMainUI:HandleCharacterButtonPointerClick()
  self._baseSceneController:SetStateNotShowUI()
  self._baseSceneController:SetCameraAnimatorState(9)
end

function BaseMainUI:OnUpdate()
end

function BaseMainUI:OnChatBtnClick()
  DialogManager.CreateSingletonDialog("chat.chatmaindialog"):Toggle()
end

function BaseMainUI:OnGMChatBtnClick()
  LogInfo("MainDialog", "跳转GM指令界面")
  DialogManager.CreateSingletonDialog("debug.gmorderdialog"):Toggle()
end

function BaseMainUI:OnRepairBtnClick()
end

function BaseMainUI:HandleMailButtonPointerClick()
  local dialog = DialogManager.CreateSingletonDialog("mail.maildialog")
end

function BaseMainUI:OnTaskClick()
  self._baseSceneController:SetCameraAnimatorState(3)
end

function BaseMainUI:OnRefreshForesight()
  RefreshWelfareButton(self)
end

function BaseMainUI:OnRefreshAnniversaryShare()
  RefreshWelfareButton(self)
end

function BaseMainUI:OnRefreshGift()
  RefreshWelfareButton(self)
end

function BaseMainUI:OnRefreshMinDiscountRedDot()
  RefreshWelfareButton(self)
end

function BaseMainUI:OnSActivityTasksUpdate()
  RefreshWelfareButton(self)
  RefreshReturnWelfareBtn(self)
end

function BaseMainUI:OnOthersActivitysTimeOver()
  RefreshReturnWelfareBtn(self)
end

function BaseMainUI:OnRefreshReturnWelfareRedDot()
  RefreshReturnWelfareBtn(self)
end

function BaseMainUI:RefreshDreamSprialRedDot()
  RefreshWelfareButton(self)
end

function BaseMainUI:OnWelfareClick()
  local dialog = DialogManager.CreateSingletonDialog("welfare.welfaremaindialog")
  if dialog then
    dialog:SetData(true)
  end
end

function BaseMainUI:OnReturnWelfareClick()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.OverseasReturnWelfareActivityId) then
    NekoData.DataManager.DM_Shop:ClientSetOpenShopID(DataCommon.Shop.OverseasReturnWelfare)
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  else
    local dialog = DialogManager.CreateSingletonDialog("welfare.returnwelfare.returnwelfaremaindialog")
    if dialog then
      dialog:SetData()
    end
  end
end

function BaseMainUI:OnTuJianClick()
  self._baseSceneController:SetStateNotShowUI()
  self._baseSceneController:SetCameraAnimatorState(10)
end

function BaseMainUI:OnWorkShopClick()
  self._baseSceneController:SetStateNotShowUI()
  self._baseSceneController:SetCameraAnimatorState(8)
end

function BaseMainUI:OnDungeonClick()
  self._baseSceneController:SetStateNotShowUI()
  self._baseSceneController:SetCameraAnimatorState(1)
end

function BaseMainUI:OnGachaClick()
  self._baseSceneController:SetStateNotShowUI()
  self._baseSceneController:SetCameraAnimatorState(2)
end

function BaseMainUI:OnGuildClick()
  self._baseSceneController:SetCameraAnimatorState(0)
  DialogManager.CreateSingletonDialog("guild.guildmaindetail")
end

function BaseMainUI:OnBannerClick()
  DialogManager.CreateSingletonDialog("banner.bannerdialog")
end

function BaseMainUI:OnActivityEntranceClick()
  NekoData.BehaviorManager.BM_Activity:EnterActivity()
end

function BaseMainUI:OnStarMirageBtnClick()
  if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.StarMirageUnlock) then
    DialogManager.CreateSingletonDialog("activity.starmirageunlockdialog")
  else
    NekoData.BehaviorManager.BM_Activity:EnterActivityById(1)
  end
end

function BaseMainUI:OnSwimSuitBtnClick()
  NekoData.BehaviorManager.BM_Activity:EnterActivityById(21)
end

function BaseMainUI:OnChristmasActivityBtn()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(48) then
    NekoData.BehaviorManager.BM_Activity:EnterActivityById(48)
  else
    local OpenType = {First = 0, Opened = 1}
    local openType = CS.UnityEngine.PlayerPrefs.GetInt("ChristmasActivityStartDialogOpened", OpenType.First)
    if openType == OpenType.First then
      local timelineId = CGenActCfg:GetRecorder(1).timelineID
      self._baseSceneController._baseMainFSM:SetNumber("storyId", timelineId)
    else
      local Christmas = 1
      DialogManager.CreateSingletonDialog("activity.activitystartdialog"):Init(Christmas)
    end
  end
end

function BaseMainUI:Show()
  self._rootWindow:SetAnimatorBool("IsShow", true)
end

function BaseMainUI:Hide()
  self._rootWindow:SetAnimatorBool("IsShow", false)
end

function BaseMainUI:GetMsgPopBack()
  return self._msgPopBack
end

function BaseMainUI:IsActive()
  return true
end

function BaseMainUI:RefreshSpiritRedPoint()
  self:SetSpiritItemOverdueReminder()
end

function BaseMainUI:visibleChangeDo(cellIndex)
end

function BaseMainUI:OnFrameBeginDrag(frame)
end

function BaseMainUI:OnFrameEndDrag(frame)
end

function BaseMainUI:ShouldLengthChange()
  return true
end

function BaseMainUI:NumberOfCell(frame)
  if frame == self._chatoutFrame then
    return #self._chatData
  end
end

function BaseMainUI:CellAtIndex(frame)
  if frame == self._chatoutFrame then
    return "chat.basemainchatcell"
  end
end

function BaseMainUI:DataAtIndex(frame, index)
  if frame == self._chatoutFrame then
    return self._chatData[index]
  end
end

function BaseMainUI:SwimSuitRemainTimeTask()
  local time = ServerGameTimer.GetServerTime()
  local endtime = timeutils.GetConfigFormatTimeStamp(CHexagonScene:GetRecorder(9001).functionEndTime)
  local limit = endtime - time
  if 0 < limit then
    self._swimSuitBtn_Time:SetActive(true)
    self._swimSuitBtn_Effect:SetActive(true)
    self._swimSuitBtn_Time:SetText(self:GetRemainTimeStr(limit))
  else
    self._swimSuitBtn_Time:SetActive(false)
    self._swimSuitBtn_Effect:SetActive(false)
    if self._swimSuitRemainTimeTsak then
      GameTimer.RemoveTask(self._swimSuitRemainTimeTsak)
    end
  end
end

function BaseMainUI:ChristmasActivityRemainTimeTask()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(48) then
    local time = ServerGameTimer.GetServerTime()
    local endtime = timeutils.GetConfigFormatTimeStamp(CChrisTimeConfig:GetRecorder(18001).rewardEnd)
    local limit = endtime - time
    if 0 < limit then
      self._christmasActivityBtn_Time:SetActive(true)
      self._christmasActivityBtn_Effect:SetActive(true)
      self._christmasActivityBtn_Time:SetText(self:GetRemainTimeStr(limit))
    else
      self._christmasActivityBtn_Time:SetActive(false)
      self._christmasActivityBtn_Effect:SetActive(false)
      if self._christmasActivityRemainTimeTsak then
        GameTimer.RemoveTask(self._christmasActivityRemainTimeTsak)
      end
    end
  else
    local time = ServerGameTimer.GetServerTime()
    local christmasActivityRecord = CGenActCfg:GetRecorder(1)
    local openTime = timeutils.GetConfigFormatTimeStamp(christmasActivityRecord.beforetime)
    local endTime = timeutils.GetConfigFormatTimeStamp(christmasActivityRecord.time)
    local limit = endTime - time
    if time >= openTime and time < endTime then
      self._christmasActivityBtn_Time:SetActive(true)
      self._christmasActivityBtn_Effect:SetActive(true)
      self._christmasActivityBtn_Time:SetText(self:GetRemainTimeStr(limit))
    else
      self._christmasActivityBtn_Time:SetActive(false)
      self._christmasActivityBtn_Effect:SetActive(false)
      if self._christmasActivityRemainTimeTsak then
        GameTimer.RemoveTask(self._christmasActivityRemainTimeTsak)
      end
    end
  end
end

function BaseMainUI:GetRemainTimeStr(endTime)
  local str = ""
  if endTime and 0 < endTime then
    local time = endTime // 1000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if 0 < day then
      str = TextManager.GetText(CStringRes:GetRecorder(1618).msgTextID)
      str = string.gsub(str, "%$parameter1%$", day)
    elseif 0 < hour then
      str = TextManager.GetText(CStringRes:GetRecorder(1619).msgTextID)
      str = string.gsub(str, "%$parameter1%$", hour)
    elseif 0 < min then
      str = TextManager.GetText(CStringRes:GetRecorder(1620).msgTextID)
      str = string.gsub(str, "%$parameter1%$", min)
    elseif 0 < sec then
      str = TextManager.GetText(CStringRes:GetRecorder(1620).msgTextID)
      str = string.gsub(str, "%$parameter1%$", 0)
    end
  end
  return str
end

function BaseMainUI:HandleSpriteEvidence()
  local haveSpriteEvidence = NekoData.BehaviorManager.BM_Currency:GetSpiritRecoverTimes()[DataCommon.SpriteEvidence]
  if haveSpriteEvidence then
    local imageRecord = CImagePathTable:GetRecorder(tonumber(CVarconfig:GetRecorder(125).Value)) or DataCommon.DefaultImageAsset
    self._num0Icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    local imageRecord = Item.Create(DataCommon.SpiritID):GetIcon()
    self._num0Icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self._name:SetActive(not haveSpriteEvidence)
  self._nameLight:SetActive(haveSpriteEvidence)
end

return BaseMainUI
