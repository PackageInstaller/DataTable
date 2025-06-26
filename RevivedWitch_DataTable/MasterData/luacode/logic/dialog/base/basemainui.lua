-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/base/basemainui.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local UIManager = ((CS.PixelNeko).UI).UIManager
local Time = (CS.UnityEngine).Time
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CPlayerLevel = (BeanManager.GetTableByName)("role.cplayerlevel")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CHexagonScene = (BeanManager.GetTableByName)("activity.chexagonscene")
local CChrisTimeConfig = (BeanManager.GetTableByName)("dungeonselect.cchristimeconfig")
local LoopTableFrame = require("framework.ui.frame.looptable.looptableframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local timeutils = require("logic.utils.timeutils")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local MillisecondToDay = 86400000
local DM_RedDot = (NekoData.DataManager).DM_RedDot
local BaseMainUI = class("BaseMainUI", Dialog)
BaseMainUI.AssetBundleName = "ui/layouts.basemainhud"
BaseMainUI.AssetName = "BaseMainHUD"
local Limit = nil
local RefreshWelfareButton = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Welfare):ShowWelfareEntrance() then
    (self._welfareButton):SetActive(true)
    ;
    (self._welfareRedIcon):SetActive(((NekoData.BehaviorManager).BM_Welfare):ShowWelfareRedDot())
  else
    ;
    (self._welfareButton):SetActive(false)
  end
end

local RefreshStarmirageBtn = function(self, notification)
  -- function num : 0_1 , upvalues : _ENV
  if (notification.userInfo).activityId == (DataCommon.Activities).StarMirage then
    local open = ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(1)
    if open then
      (self._starmirageBtn):SetActive(true)
      local bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.StarMirageManagerID)
      if not bm:ShowRedDot() then
        do
          (self._starmirageBtn_redDot):SetActive(bm:IsPlayGuideClickEffect())
          ;
          (self._starmirageBtn):SetActive(false)
        end
      end
    end
  end
end

local RefreshSwimSuitBtn = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local open = ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(21)
  if open then
    (self._swimSuitBtn):SetActive(true)
    local bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)
    ;
    (self._swimSuitBtn_redDot):SetActive(bm:ShowRedDot())
    if self._swimSuitRemainTimeTsak then
      (GameTimer.RemoveTask)(self._swimSuitRemainTimeTsak)
    end
    self._swimSuitRemainTimeTsak = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_2_0 , upvalues : self
    self:SwimSuitRemainTimeTask()
  end
, nil)
  else
    do
      ;
      (self._swimSuitBtn):SetActive(false)
    end
  end
end

local RefreshChristmasActivityBtn = function(self)
  -- function num : 0_3 , upvalues : _ENV, CChrisTimeConfig, timeutils
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(48) then
    (self._christmasActivityBtn):SetActive(true)
    local bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)
    ;
    (self._christmasActivityBtn_redDot):SetActive(bm:ShowRedDot())
    local CChrisTimeConfig = CChrisTimeConfig:GetRecorder(18001)
    if self._christmasActivityRemainTimeTsak then
      (GameTimer.RemoveTask)(self._christmasActivityRemainTimeTsak)
    end
    self._christmasActivityRemainTimeTsak = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_3_0 , upvalues : self
    self:ChristmasActivityRemainTimeTask()
  end
, nil)
  else
    do
      local open = false
      local time = (ServerGameTimer.GetServerTime)()
      local christmasActivityRecord = CGenActCfg:GetRecorder(1)
      local openTime = (timeutils.GetConfigFormatTimeStamp)(christmasActivityRecord.beforetime)
      local endTime = (timeutils.GetConfigFormatTimeStamp)(christmasActivityRecord.time)
      if openTime <= time and time < endTime then
        open = true
      end
      ;
      (self._christmasActivityBtn_redDot):SetActive(false)
      if open then
        (self._christmasActivityBtn):SetActive(true)
        if self._christmasActivityRemainTimeTsak then
          (GameTimer.RemoveTask)(self._christmasActivityRemainTimeTsak)
        end
        self._christmasActivityRemainTimeTsak = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_3_1 , upvalues : self
    self:ChristmasActivityRemainTimeTask()
  end
, nil)
      else
        ;
        (self._christmasActivityBtn):SetActive(false)
      end
    end
  end
end

BaseMainUI.RefreshHalloweenBtn = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local open = ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(41)
  if open then
    local bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.HalloweenActivityID)
    do
      (self._halloweenBtn):SetActive(bm:GetIsOpen())
      if bm:GetIsOpen() then
        (self._halloweenRedDot):SetActive(bm:ShowRedDot())
        if self._halloweenRemainTimeTsak then
          (GameTimer.RemoveTask)(self._halloweenRemainTimeTsak)
        end
        self._halloweenRemainTimeTsak = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_4_0 , upvalues : self, bm
    (self._halloweenTimeTxt):SetText(self:GetRemainTimeStr(bm:GetRemainTime()))
  end
, nil)
      end
    end
  else
    do
      ;
      (self._halloweenBtn):SetActive(false)
    end
  end
end

local RefreshReturnWelfareBtn = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).OverseasReturnWelfareActivityId) then
    (self._returnWelfareBtn):SetActive(true)
    ;
    (self._returnWelfareBtnRedDot):SetActive(false)
  else
    if ((NekoData.BehaviorManager).BM_ReturnWelfare):ShowReturnWelfareEntrance() then
      (self._returnWelfareBtn):SetActive(true)
      local taskRedDot = ((NekoData.BehaviorManager).BM_ActivityTasks):ReturnWelfareTaskRedDot()
      local enterKeyRedDot = ((NekoData.BehaviorManager).BM_Activity):GetBackGiftRedPoint()
      local taskRewardRedDot = ((NekoData.BehaviorManager).BM_Activity):GetBackTaskRedPoint()
      local returnBattlePassRedDot = ((NekoData.BehaviorManager).BM_ReturnWelfare):ShowReturnBattlePassRedDot()
      local showRedDot = taskRedDot or enterKeyRedDot or taskRewardRedDot or returnBattlePassRedDot
      ;
      (self._returnWelfareBtnRedDot):SetActive(showRedDot)
    else
      do
        ;
        (self._returnWelfareBtn):SetActive(false)
      end
    end
  end
end

local RefreshPopUpGiftBtn = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Activity):GetPopUpGift() then
    (self._popUpGiftBtn):SetActive(((NekoData.BehaviorManager).BM_Activity):GetPopUpGift7Day())
    if ((NekoData.BehaviorManager).BM_Activity):GetPopUpGift7Day() and ((NekoData.BehaviorManager).BM_Activity):ShowPopUpGift7DayRedDot() then
      (self._popUpGiftBtn_RedDot):SetActive(true)
    else
      ;
      (self._popUpGiftBtn_RedDot):SetActive(false)
    end
  end
end

BaseMainUI.Ctor = function(self, ...)
  -- function num : 0_7 , upvalues : BaseMainUI
  ((BaseMainUI.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._dragBack = nil
  self._baseSceneController = nil
  self._repairingRoleList = {}
  self._roleList = nil
  self._spirit = nil
end

BaseMainUI.OnCreate = function(self)
  -- function num : 0_8 , upvalues : Limit, _ENV, RefreshWelfareButton, RefreshPopUpGiftBtn, RefreshReturnWelfareBtn, DM_RedDot
  Limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
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
  ;
  (self._num0Btn):Subscribe_PointerClickEvent(self.OnNum0BtnClick, self)
  ;
  (self._num1Btn):Subscribe_PointerClickEvent(self.OnNum1BtnClick, self)
  ;
  (self._num2Btn):Subscribe_PointerClickEvent(self.OnNum2BtnClick, self)
  ;
  (self._num2AddBtn):Subscribe_PointerClickEvent(self.OnNum2AddBtnClick, self)
  ;
  (self._num3Btn):Subscribe_PointerClickEvent(self.OnNum3BtnClick, self)
  self._chatBtn = self:GetChild("Chat")
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
  self._dragBack = self:GetChild("Panel")
  self._welfareButton = self:GetChild("Welfare")
  self._welfareRedIcon = self:GetChild("Welfare/RedDot")
  ;
  (self._welfareRedIcon):SetActive(false)
  self._returnWelfareBtn = self:GetChild("HuiguiWelfare")
  self._returnWelfareBtnRedDot = self:GetChild("HuiguiWelfare/RedDot")
  self._bannerButton = self:GetChild("RightGroup2/Activity")
  self._repairEffect = self:GetChild("Repair/Effect")
  self._menuBtn = self:GetChild("MenuBtn")
  self._msgPopBack = self:GetChild("ChatCellBack")
  self._noticeBtn = self:GetChild("Active/ActiveBtn")
  self._kefuBtn = self:GetChild("Kefu/KefuBtn")
  self._noticeRedPoint = self:GetChild("Active/ActiveBtn/RedDot")
  ;
  (self._noticeRedPoint):SetActive(false)
  self._popUpGiftBtn = self:GetChild("Promotions")
  self._popUpGiftBtn_RedDot = self:GetChild("Promotions/RedDot")
  ;
  (self:GetChild("Promotions/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2104))
  ;
  (self._chatBtn):Subscribe_PointerClickEvent(self.OnChatBtnClick, self)
  ;
  (self._gmChatBtn):Subscribe_PointerClickEvent(self.OnGMChatBtnClick, self)
  ;
  (self._repairBtn):Subscribe_PointerClickEvent(self.OnRepairBtnClick, self)
  ;
  (self._mailButton):Subscribe_PointerClickEvent(self.HandleMailButtonPointerClick, self)
  ;
  (self._welfareButton):Subscribe_PointerClickEvent(self.OnWelfareClick, self)
  ;
  (self._returnWelfareBtn):Subscribe_PointerClickEvent(self.OnReturnWelfareClick, self)
  ;
  (self._bannerButton):Subscribe_PointerClickEvent(self.OnBannerClick, self)
  ;
  (self._headPhoto):Subscribe_PointerClickEvent(self.OnHeadPhotoClick, self)
  ;
  (self._shopBtn):Subscribe_PointerClickEvent(self.OnShopClick, self)
  ;
  (self._shopBoxIbtn):Subscribe_PointerClickEvent(self.OnShopBoxIbtnClick, self)
  ;
  (self._orderBtn):Subscribe_PointerClickEvent(self.OnOrderClick, self)
  ;
  (self._firstRecharge):Subscribe_PointerClickEvent(self.OnFirstRechargeClick, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClick, self)
  ;
  (self._noticeBtn):Subscribe_PointerClickEvent(self.OnNoticeClick, self)
  ;
  (self._kefuBtn):Subscribe_PointerClickEvent(self.OnKefuClick, self)
  ;
  (self._popUpGiftBtn):Subscribe_PointerClickEvent(self.OnPopUpGiftBtn, self)
  self._starmirageBtn = self:GetChild("ActivityStar")
  self._starmirageBtn_redDot = self:GetChild("ActivityStar/RedDot")
  ;
  (self._starmirageBtn):Subscribe_PointerClickEvent(self.OnStarMirageBtnClick, self)
  self._swimSuitBtn = self:GetChild("ActivitySwimSuit")
  self._swimSuitBtn_redDot = self:GetChild("ActivitySwimSuit/RedDot")
  ;
  (self._swimSuitBtn):Subscribe_PointerClickEvent(self.OnSwimSuitBtnClick, self)
  self._swimSuitBtn_Time = self:GetChild("ActivitySwimSuit/Time")
  self._swimSuitBtn_Effect = self:GetChild("ActivitySwimSuit/UILogin")
  self._halloweenBtn = self:GetChild("ActivityHalloween")
  ;
  (self._halloweenBtn):SetActive(false)
  self._birthDayActivityBtn = self:GetChild("ActivityLogin")
  ;
  (self._birthDayActivityBtn):SetActive(false)
  self._christmasActivityBtn = self:GetChild("ActivityChristmas")
  ;
  (self._christmasActivityBtn):SetActive(false)
  ;
  (self._christmasActivityBtn):SetActive(false)
  self._activityPanel = self:GetChild("Activity")
  ;
  (DialogManager.CreateSingletonChildDialog)("activity.baseactivity", "base.basemainui", self._activityPanel)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshActivityPanel, Common.n_RefreshActivities, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshActivityRewards, Common.n_RefreshActivityRewards, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshActivityRewards, Common.n_LocalTipsStateChanged, nil)
  LogInfoFormat("BaseMainUI", "###############")
  ;
  (self._time):SetActive(false)
  ;
  (self._timeTxt):SetActive(false)
  ;
  (self._gmChatBtn):SetActive(((NekoData.BehaviorManager).BM_Game):IsGM())
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritRedPoint, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritRedPoint, Common.n_ItemAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritRedPoint, Common.n_ItemNumModify, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserName, Common.n_UserNameChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_RoleInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserHeadPhoto, Common.n_ChangeUserHeadPhoto, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserHeadFrame, Common.n_ChangeUserHeadFrame, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshGift, Common.n_RefreshGrowGift, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnShopRedPoint, Common.n_ShopRedPoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnPlayerExpChanged, Common.n_PlayerExpChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnStrengthLimitChanged, Common.n_StrengthLimitChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnShopRedPoint, Common.n_ChargeAccumulationAddPoints, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnShopRedPoint, Common.n_ChargeAccumulationReceiveReward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnShopRedPoint, Common.n_RefreshSkinCollectAwardStatus, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNoticeRedPoint, Common.n_NewInGameAnnouncement, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshFitstRechargeRedot, Common.n_FitstRechargeGiftRedPoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshFitstRechargeGift, Common.n_FirstRechargeGiftState, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSActivityTasksUpdate, Common.n_OnSActivityTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSActivityTasksUpdate, Common.n_OnSRefreshActivityTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshDreamSprialRedDot, Common.n_DreamSpiralRefresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshDreamSprialRedDot, Common.n_TriggerGuide, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSFreeLevelGiftIcon, Common.n_SFreeLevelGiftIcon, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnOthersActivitysTimeOver, Common.n_OthersActivitysTimeOver, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshReturnWelfareRedDot, Common.n_RefreshReturnWelfareRedDot, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshForesight, Common.n_OnSGeneralForesightAct, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshAnniversaryShare, Common.n_OnSAnniversaryShareInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMinDiscountRedDot, Common.n_OnRefreshMinDiscount, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, RefreshWelfareButton, Common.n_RefreshLimitedInvestment, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, RefreshWelfareButton, Common.n_RefreshMonthSign, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, RefreshWelfareButton, Common.n_RefreshAccumulateCost, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, RefreshWelfareButton, Common.n_OnRefreshOldPlayerBenefits, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, RefreshPopUpGiftBtn, Common.n_RefreshPopUpGift, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, RefreshPopUpGiftBtn, Common.n_RefreshPopUpGift7Day, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, RefreshReturnWelfareBtn, Common.n_RefreshReturnBattlePass, nil)
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Shop) then
    (self._shopBtnRedPoint):SetActive((DM_RedDot.GetNodeResult)(DM_RedDot.nodeShop))
    ;
    (self._shopBtn):SetActive(true)
    ;
    (self._shopBoxIbtn):SetActive(((NekoData.BehaviorManager).BM_Shop):GetShowBoxIcon())
  else
    ;
    (self._shopBtnRedPoint):SetActive(false)
    ;
    (self._shopBtn):SetActive(false)
    ;
    (self._shopBoxIbtn):SetActive(false)
  end
  RefreshWelfareButton(self)
  RefreshReturnWelfareBtn(self)
  local tag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Mail)
  ;
  (self._mailButton):SetActive(tag)
  if tag then
    self:OnRefreshMailRedDot()
    ;
    (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMailRedDot, Common.n_MailInfoChange, nil)
  end
  ;
  (self._chatBtn):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Chat))
  ;
  (self._noticeBtn):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Notice))
  RefreshPopUpGiftBtn(self)
  self:OnRefreshFitstRechargeGift()
  self:OnRefreshFitstRechargeRedot()
  self:RefreshOrderBtn()
  self:OnShopRedPoint()
  self:RefreshActivityPanel()
  self:RefreshActivityRewards()
  ;
  ((NekoData.BehaviorManager).BM_Game):SetGMHideUIByDialog((DataCommon.GMHideUI).MainCity, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshOfflineSweepActive, Common.n_RefreshOfflineSweepActive, nil)
  self:RefreshOfflineSweepActive()
end

BaseMainUI.OnDestroy = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("chat.msgpopdialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("base.basemainmenudialog")
  ;
  (DialogManager.DestroySingletonDialog)("fastmenu.fastmenudialog")
  ;
  (DialogManager.DestroySingletonDialog)("chat.chatmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("mail.maildialog")
  ;
  (DialogManager.DestroySingletonDialog)("friend.friendsmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("welfare.welfaremaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("guild.guildmaindetail")
  ;
  (DialogManager.DestroySingletonDialog)("banner.bannerdialog")
  if self._halloweenRemainTimeTsak then
    (GameTimer.RemoveTask)(self._halloweenRemainTimeTsak)
  end
  if self._birthDayRemainTimeTsak then
    (GameTimer.RemoveTask)(self._birthDayRemainTimeTsak)
  end
  if self._offlinesweepDialog then
    (self._offlinesweepDialog):Destroy()
    self._offlinesweepDialog = nil
  end
end

BaseMainUI.Init = function(self, sceneController)
  -- function num : 0_10 , upvalues : _ENV, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable, CPlayerLevel, CStringRes, Limit
  self._baseSceneController = sceneController
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  ;
  (self._name):SetText(userInfo.username)
  ;
  (self._nameLight):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2090, {userInfo.username}))
  local imageRecord = nil
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  if headPhotoRecord then
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("BaseMainUI", "userInfo.avatarId %s is wrong", userInfo.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if headPhotoFrameRecord then
    if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("BaseMainUI", "userInfo.frameId %s is wrong", userInfo.frameId)
  end
  local recorder = CPlayerLevel:GetRecorder(userInfo.userlevel)
  local currentLevelExpNum = userInfo.userexp
  local currentLevelExpMax = recorder.exp
  local allIds = CPlayerLevel:GetAllIds()
  local maxLevel = (CPlayerLevel:GetRecorder(#allIds)).id
  local maxLevelMaxExp = (CPlayerLevel:GetRecorder(#allIds)).exp
  local isMax = userInfo.userlevel == maxLevel
  ;
  (self._levelMaxText):SetActive(isMax)
  ;
  (self._expNum):SetActive(not isMax)
  if isMax then
    currentLevelExpNum = maxLevelMaxExp
  end
  ;
  (self._levelProgress):SetFillAmount(currentLevelExpNum / currentLevelExpMax)
  ;
  (self._levelNum):SetText(userInfo.userlevel)
  do
    if currentLevelExpNum ~= currentLevelExpMax then
      local str = (TextManager.GetText)((CStringRes:GetRecorder(1203)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", tostring(currentLevelExpNum))
      str = (string.gsub)(str, "%$parameter2%$", tostring(currentLevelExpMax))
      ;
      (self._expNum):SetText(str)
    end
    self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID)
    ;
    (self._num0Text):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(Limit))
    self:SetSpiritItemOverdueReminder()
    self:HandleSpriteEvidence()
    ;
    (self._num1Text):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SoulDropID))
    ;
    (self._num2Text):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.DiamodID))
    ;
    (self._num3Text):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID))
    self._roleList = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
    while (self._repairingRoleList)[#self._repairingRoleList] do
      (table.remove)(self._repairingRoleList, #self._repairingRoleList)
    end
    for index,role in ipairs(self._roleList) do
      if role:GetHurtExtent() ~= 0 then
        (table.insert)(self._repairingRoleList, role)
      end
    end
    self:SetRepairBtn()
    ;
    ((DialogManager.CreateSingletonDialog)("base.basemainmenudialog")):Init(sceneController)
    ;
    (self._swimSuitBtn_redDot):SetActive(((NekoData.BehaviorManager).BM_Activity):GetActivityRedPointID() == (DataCommon.Activities).SwimSuit)
    -- DECOMPILER ERROR: 7 unprocessed JMP targets
  end
end

BaseMainUI.SetSpiritItemOverdueReminder = function(self)
  -- function num : 0_11 , upvalues : _ENV, MillisecondToDay
  self._spiritItem = ((NekoData.BehaviorManager).BM_BagInfo):GetDeleteSpiritItem()
  self._spiritItemDelTime = nil
  self._spiritItemDelName = nil
  if self._spiritItem then
    self._spiritItemDelTime = (self._spiritItem):GetDelTime()
    self._spiritItemDelName = (self._spiritItem):GetName()
  end
  ;
  (self._num0RedDot):SetActive(not self._spiritItemDelTime or self._spiritItemDelTime - (ServerGameTimer.GetServerTime)() < MillisecondToDay)
  ;
  (self._spiritOverdueReminder):SetActive(not self._spiritItemDelTime or self._spiritItemDelTime - (ServerGameTimer.GetServerTime)() < MillisecondToDay)
  if self._spiritItemDelTime then
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
    self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_11_0 , upvalues : self
    self:SpiritTask()
  end
, nil)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60
local GetDelTimeStr = function(ms, name)
  -- function num : 0_12 , upvalues : SecToDay, SecToHour, _ENV, SecToMin
  local sec = ms // 1000
  local str = nil
  if SecToDay < sec then
    return 
  end
  if SecToHour < sec then
    str = (TextManager.GetText)(701156)
  else
    if SecToMin < sec then
      str = (TextManager.GetText)(701169)
      str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", sec))
    else
      str = (TextManager.GetText)(701158)
    end
  end
  str = (string.gsub)(str, "%$parameter1%$", name)
  return str
end

BaseMainUI.RefreshOfflineSweepActive = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local status = ((NekoData.BehaviorManager).BM_OfflineSweep):GetStatus()
  -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

  if status ~= 0 and self._offlinesweepDialog == nil then
    self._offlinesweepDialog = (DialogManager.CreateDialog)("mainline.offlinesweep.offlinesweepshowbtndialog", (self._rootWindow)._uiObject)
  end
  if self._offlinesweepDialog then
    (self._offlinesweepDialog):Destroy()
    self._offlinesweepDialog = nil
  end
end

BaseMainUI.SpiritTask = function(self)
  -- function num : 0_14 , upvalues : _ENV, MillisecondToDay, GetDelTimeStr
  if self._spiritItemDelTime == nil then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
    return 
  end
  local time = self._spiritItemDelTime - (ServerGameTimer.GetServerTime)()
  ;
  (self._num0RedDot):SetActive(time < MillisecondToDay)
  ;
  (self._spiritOverdueReminder):SetActive(time < MillisecondToDay)
  if time > 0 then
    (self._spiritOverdueReminder):SetText(GetDelTimeStr(time, self._spiritItemDelName))
  else
    local CUpdateLimitedItems = (LuaNetManager.CreateProtocol)("protocol.item.cupdatelimiteditems")
    if CUpdateLimitedItems then
      CUpdateLimitedItems.itemKey = (self._spiritItem):GetKey()
      CUpdateLimitedItems.itemId = (self._spiritItem):GetID()
      CUpdateLimitedItems:Send()
    end
    ;
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

BaseMainUI.OnPlayerExpChanged = function(self)
  -- function num : 0_15 , upvalues : _ENV, CPlayerLevel, CStringRes
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  local recorder = CPlayerLevel:GetRecorder(userInfo.userlevel)
  local currentLevelExpNum = userInfo.userexp
  local currentLevelExpMax = recorder.exp
  local allIds = CPlayerLevel:GetAllIds()
  local maxLevel = (CPlayerLevel:GetRecorder(#allIds)).id
  local maxLevelMaxExp = (CPlayerLevel:GetRecorder(#allIds)).exp
  local isMax = userInfo.userlevel == maxLevel
  if isMax then
    currentLevelExpNum = maxLevelMaxExp
  end
  ;
  (self._levelMaxText):SetActive(isMax)
  ;
  (self._expNum):SetActive(not isMax)
  ;
  (self._levelProgress):SetFillAmount(currentLevelExpNum / currentLevelExpMax)
  ;
  (self._levelNum):SetText(userInfo.userlevel)
  do
    if currentLevelExpNum ~= currentLevelExpMax then
      local str = (TextManager.GetText)((CStringRes:GetRecorder(1203)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", tostring(currentLevelExpNum))
      str = (string.gsub)(str, "%$parameter2%$", tostring(currentLevelExpMax))
      ;
      (self._expNum):SetText(str)
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

BaseMainUI.OnStrengthLimitChanged = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (self._num0Text):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit))
end

BaseMainUI.OnRefreshMailRedDot = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local tag = false
  for type,mailList in pairs((((NekoData.BehaviorManager).BM_Mail):GetMail()).list) do
    for i,mail in ipairs(mailList) do
      if mail.status == 0 then
        tag = true
        break
      end
    end
  end
  ;
  (self._mailRedDot):SetActive(tag)
end

BaseMainUI.SetRepairBtn = function(self)
  -- function num : 0_18
  if #self._repairingRoleList > 0 then
    (self._repairBtn):SetActive(true)
  else
    ;
    (self._repairBtn):SetActive(false)
  end
end

BaseMainUI.OnShopRedPoint = function(self, notification)
  -- function num : 0_19 , upvalues : DM_RedDot
  (self._shopBtnRedPoint):SetActive((DM_RedDot.GetNodeResult)(DM_RedDot.nodeShop))
end

BaseMainUI.OnSFreeLevelGiftIcon = function(self, notification)
  -- function num : 0_20 , upvalues : _ENV
  (self._shopBoxIbtn):SetActive(((NekoData.BehaviorManager).BM_Shop):GetShowBoxIcon())
end

BaseMainUI.HideShopGiftIcon = function(self)
  -- function num : 0_21
  (self._shopBoxIbtn):SetActive(false)
end

local AddActivityGameTimer = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  if not self._gameTimerID then
    self._gameTimerID = (GameTimer.AddTask)(5, 5, function()
    -- function num : 0_22_0 , upvalues : self
    local leftIndex = (self._activityPanel_bannerFrame):GetLeftIndex()
    if leftIndex then
      if leftIndex == #self._bannerList then
        leftIndex = 0
      end
      ;
      (self._activityPanel_bannerFrame):MoveLeftToIndex(leftIndex + 1, true)
    end
  end
)
  end
end

BaseMainUI.RefreshActivityPanel = function(self)
  -- function num : 0_23
end

BaseMainUI.RefreshActivityRewards = function(self)
  -- function num : 0_24 , upvalues : RefreshWelfareButton
  RefreshWelfareButton(self)
end

BaseMainUI.OnNoticeRedPoint = function(self, notification)
  -- function num : 0_25 , upvalues : _ENV
  (self._noticeRedPoint):SetActive((NoticeManager.GetInGameRedPoint)())
end

BaseMainUI.OnChangeUserHeadPhoto = function(self, notification)
  -- function num : 0_26 , upvalues : HeadPhotoTable, CImagePathTable, _ENV
  local headPhotoRecord = HeadPhotoTable:GetRecorder((notification.userInfo).avatarId)
  if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

BaseMainUI.OnChangeUserHeadFrame = function(self, notification)
  -- function num : 0_27 , upvalues : HeadPhotoFrameTable, CImagePathTable, _ENV
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((notification.userInfo).frameId)
  if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

BaseMainUI.OnChangeUserName = function(self, notification)
  -- function num : 0_28 , upvalues : _ENV
  (self._name):SetText((notification.userInfo).name)
  ;
  (self._nameLight):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2090, {(notification.userInfo).name}))
end

BaseMainUI.OnRefreshCurrency = function(self)
  -- function num : 0_29 , upvalues : _ENV
  (self._num1Text):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetSoulDropCoin())
  ;
  (self._num2Text):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetDiamond())
  ;
  (self._num3Text):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetMoney())
end

BaseMainUI.OnRefreshSpirit = function(self, notification)
  -- function num : 0_30 , upvalues : _ENV
  (self._num0Text):SetText((NumberManager.GetShowNumber)((notification.userInfo).spirit) .. "/" .. (NumberManager.GetShowNumber)((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit))
  self._spirit = (notification.userInfo).spirit
end

BaseMainUI.OnRefresh = function(self)
  -- function num : 0_31 , upvalues : _ENV
  self._roleList = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
  while (self._repairingRoleList)[#self._repairingRoleList] do
    (table.remove)(self._repairingRoleList, #self._repairingRoleList)
  end
  for index,role in ipairs(self._roleList) do
    if role:GetHurtExtent() ~= 0 then
      (table.insert)(self._repairingRoleList, role)
    end
  end
  self:SetRepairBtn()
end

BaseMainUI.OnHeadPhotoClick = function(self)
  -- function num : 0_32 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("systemsetting.systemsettingdialog")
end

BaseMainUI.OnShopClick = function(self)
  -- function num : 0_33 , upvalues : _ENV, DM_RedDot
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Shop) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100192)
    return 
  end
  ;
  (self._baseSceneController):SetCameraAnimatorState(0)
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
  if protocol then
    (DM_RedDot.SetNodeRead)(DM_RedDot.nodeShop, true)
    protocol:Send()
  end
  do
    local jsonStr = (JSON.encode)({eventName = "event", id = "9"})
    ;
    (ThinkingAnalyticsInterface.UploadEvent_TA)(jsonStr)
    local jsonStr = (JSON.encode)({eventName = "17"})
    ;
    (ThinkingAnalyticsInterface.TimeEvent_TA)(jsonStr)
  end
end

BaseMainUI.OnShopBoxIbtnClick = function(self)
  -- function num : 0_34 , upvalues : _ENV, DM_RedDot
  ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(5)
  ;
  ((NekoData.DataManager).DM_Shop):DisableShowBoxIcon()
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
  if protocol then
    (DM_RedDot.SetNodeRead)(DM_RedDot.nodeShop, true)
    protocol:Send()
  end
  ;
  (self._shopBoxIbtn):SetActive(false)
end

BaseMainUI.OnOrderClick = function(self)
  -- function num : 0_35 , upvalues : _ENV
  local orderdialog = (DialogManager.CreateSingletonDialog)("order.orderdialog")
  if orderdialog then
    orderdialog:SetDelegate(self)
  end
end

BaseMainUI.OnFirstRechargeClick = function(self)
  -- function num : 0_36 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("welfare.fitstrechargedialog")
  if dialog then
    if (((CS.UnityEngine).PlayerPrefs).HasKey)("FirstReChargeRedPoint") then
      (((CS.UnityEngine).PlayerPrefs).DeleteKey)("FirstReChargeRedPoint")
      self:OnRefreshFitstRechargeRedot()
    end
    dialog:Init()
  end
end

BaseMainUI.OnRefreshFitstRechargeGift = function(self)
  -- function num : 0_37 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).FirstReCharge) then
    local shopFirstRecharge = not ((NekoData.BehaviorManager).BM_Welfare):IsFitstRechargeGiftAllGet()
  end
  ;
  (self._firstRecharge):SetActive(shopFirstRecharge)
  if not shopFirstRecharge then
    self:RefreshOrderBtn()
  end
end

BaseMainUI.OnRefreshFitstRechargeRedot = function(self)
  -- function num : 0_38 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Welfare):GetFitstRechargeGiftRedPoint() then
    local showRedDot = (((CS.UnityEngine).PlayerPrefs).HasKey)("FirstReChargeRedPoint")
  end
  ;
  (self._firstRechargeRedDot):SetActive(showRedDot)
end

BaseMainUI.OnOrderGainClick = function(self)
  -- function num : 0_39 , upvalues : _ENV
  ((NekoData.DataManager).DM_Game):CloseBookActivity()
  self:RefreshOrderBtn()
end

BaseMainUI.RefreshOrderBtn = function(self)
  -- function num : 0_40 , upvalues : _ENV
  local bookActivity = ((NekoData.BehaviorManager).BM_Game):GetBookActivity()
  ;
  (self._orderBtn):SetActive(bookActivity ~= nil and bookActivity.isOpen == 1)
  if not (self._firstRecharge):IsActive() then
    (self._orderBtn):SetAnchoredPosition((self._firstRecharge):GetAnchoredPosition())
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BaseMainUI.OnMenuBtnClick = function(self)
  -- function num : 0_41 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("fastmenu.fastmenudialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("fastmenu.fastmenudialog")
  else
    ;
    (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
  end
end

BaseMainUI.OnNoticeClick = function(self)
  -- function num : 0_42 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("notice.noticedialog")
end

BaseMainUI.OnKefuClick = function(self)
  -- function num : 0_43 , upvalues : _ENV
  ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)("https://tb.53kf.com/code/client/d55b2d4b490809148862362dcd8b233b6/3")
end

BaseMainUI.OnPopUpGiftBtn = function(self)
  -- function num : 0_44 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Activity):GetPopUpGift() then
    (DialogManager.CreateSingletonDialog)("welfare.popupgiftdialog")
  else
    if ((NekoData.BehaviorManager).BM_Activity):GetPopUpGift7Day() then
      (DialogManager.CreateSingletonDialog)("welfare.popupgift7daydialog")
    end
  end
end

BaseMainUI.OnNum0BtnClick = function(self)
  -- function num : 0_45 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

BaseMainUI.OnNum1BtnClick = function(self)
  -- function num : 0_46 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.SoulDropID)})
    local width, height = (self._num1Btn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._num1Btn):GetLocalPointInUiRootPanel())
  end
end

BaseMainUI.OnNum2BtnClick = function(self)
  -- function num : 0_47 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.DiamodID)})
    local width, height = (self._num2Btn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._num2Btn):GetLocalPointInUiRootPanel())
  end
end

BaseMainUI.OnNum2AddBtnClick = function(self)
  -- function num : 0_48 , upvalues : _ENV
  ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(4)
  self:OnShopClick()
end

BaseMainUI.OnNum3BtnClick = function(self)
  -- function num : 0_49 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.ManaID)})
    local width, height = (self._num3Btn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._num3Btn):GetLocalPointInUiRootPanel())
  end
end

BaseMainUI.HandleCharacterButtonPointerClick = function(self)
  -- function num : 0_50
  (self._baseSceneController):SetStateNotShowUI()
  ;
  (self._baseSceneController):SetCameraAnimatorState(9)
end

BaseMainUI.OnUpdate = function(self)
  -- function num : 0_51
end

BaseMainUI.OnChatBtnClick = function(self)
  -- function num : 0_52 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("chat.chatmaindialog")):Toggle()
end

BaseMainUI.OnGMChatBtnClick = function(self)
  -- function num : 0_53 , upvalues : _ENV
  LogInfo("MainDialog", "跳转GM指令界面")
  ;
  ((DialogManager.CreateSingletonDialog)("debug.gmorderdialog")):Toggle()
end

BaseMainUI.OnRepairBtnClick = function(self)
  -- function num : 0_54
end

BaseMainUI.HandleMailButtonPointerClick = function(self)
  -- function num : 0_55 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mail.maildialog")
end

BaseMainUI.OnTaskClick = function(self)
  -- function num : 0_56
  (self._baseSceneController):SetCameraAnimatorState(3)
end

BaseMainUI.OnRefreshForesight = function(self)
  -- function num : 0_57 , upvalues : RefreshWelfareButton
  RefreshWelfareButton(self)
end

BaseMainUI.OnRefreshAnniversaryShare = function(self)
  -- function num : 0_58 , upvalues : RefreshWelfareButton
  RefreshWelfareButton(self)
end

BaseMainUI.OnRefreshGift = function(self)
  -- function num : 0_59 , upvalues : RefreshWelfareButton
  RefreshWelfareButton(self)
end

BaseMainUI.OnRefreshMinDiscountRedDot = function(self)
  -- function num : 0_60 , upvalues : RefreshWelfareButton
  RefreshWelfareButton(self)
end

BaseMainUI.OnSActivityTasksUpdate = function(self)
  -- function num : 0_61 , upvalues : RefreshWelfareButton, RefreshReturnWelfareBtn
  RefreshWelfareButton(self)
  RefreshReturnWelfareBtn(self)
end

BaseMainUI.OnOthersActivitysTimeOver = function(self)
  -- function num : 0_62 , upvalues : RefreshReturnWelfareBtn
  RefreshReturnWelfareBtn(self)
end

BaseMainUI.OnRefreshReturnWelfareRedDot = function(self)
  -- function num : 0_63 , upvalues : RefreshReturnWelfareBtn
  RefreshReturnWelfareBtn(self)
end

BaseMainUI.RefreshDreamSprialRedDot = function(self)
  -- function num : 0_64 , upvalues : RefreshWelfareButton
  RefreshWelfareButton(self)
end

BaseMainUI.OnWelfareClick = function(self)
  -- function num : 0_65 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("welfare.welfaremaindialog")
  if dialog then
    dialog:SetData(true)
  end
end

BaseMainUI.OnReturnWelfareClick = function(self)
  -- function num : 0_66 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).OverseasReturnWelfareActivityId) then
    ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID((DataCommon.Shop).OverseasReturnWelfare)
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  else
    do
      local dialog = (DialogManager.CreateSingletonDialog)("welfare.returnwelfare.returnwelfaremaindialog")
      if dialog then
        dialog:SetData()
      end
    end
  end
end

BaseMainUI.OnTuJianClick = function(self)
  -- function num : 0_67
  (self._baseSceneController):SetStateNotShowUI()
  ;
  (self._baseSceneController):SetCameraAnimatorState(10)
end

BaseMainUI.OnWorkShopClick = function(self)
  -- function num : 0_68
  (self._baseSceneController):SetStateNotShowUI()
  ;
  (self._baseSceneController):SetCameraAnimatorState(8)
end

BaseMainUI.OnDungeonClick = function(self)
  -- function num : 0_69
  (self._baseSceneController):SetStateNotShowUI()
  ;
  (self._baseSceneController):SetCameraAnimatorState(1)
end

BaseMainUI.OnGachaClick = function(self)
  -- function num : 0_70
  (self._baseSceneController):SetStateNotShowUI()
  ;
  (self._baseSceneController):SetCameraAnimatorState(2)
end

BaseMainUI.OnGuildClick = function(self)
  -- function num : 0_71 , upvalues : _ENV
  (self._baseSceneController):SetCameraAnimatorState(0)
  ;
  (DialogManager.CreateSingletonDialog)("guild.guildmaindetail")
end

BaseMainUI.OnBannerClick = function(self)
  -- function num : 0_72 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("banner.bannerdialog")
end

BaseMainUI.OnActivityEntranceClick = function(self)
  -- function num : 0_73 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Activity):EnterActivity()
end

BaseMainUI.OnStarMirageBtnClick = function(self)
  -- function num : 0_74 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).StarMirageUnlock) then
    (DialogManager.CreateSingletonDialog)("activity.starmirageunlockdialog")
  else
    ;
    ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(1)
  end
end

BaseMainUI.OnSwimSuitBtnClick = function(self)
  -- function num : 0_75 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(21)
end

BaseMainUI.OnChristmasActivityBtn = function(self)
  -- function num : 0_76 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(48) then
    ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(48)
  else
    local OpenType = {First = 0, Opened = 1}
    local openType = (((CS.UnityEngine).PlayerPrefs).GetInt)("ChristmasActivityStartDialogOpened", OpenType.First)
    if openType == OpenType.First then
      local timelineId = (CGenActCfg:GetRecorder(1)).timelineID
      ;
      ((self._baseSceneController)._baseMainFSM):SetNumber("storyId", timelineId)
    else
      do
        local Christmas = 1
        ;
        ((DialogManager.CreateSingletonDialog)("activity.activitystartdialog")):Init(Christmas)
      end
    end
  end
end

BaseMainUI.Show = function(self)
  -- function num : 0_77
  (self._rootWindow):SetAnimatorBool("IsShow", true)
end

BaseMainUI.Hide = function(self)
  -- function num : 0_78
  (self._rootWindow):SetAnimatorBool("IsShow", false)
end

BaseMainUI.GetMsgPopBack = function(self)
  -- function num : 0_79
  return self._msgPopBack
end

BaseMainUI.IsActive = function(self)
  -- function num : 0_80
  return true
end

BaseMainUI.RefreshSpiritRedPoint = function(self)
  -- function num : 0_81
  self:SetSpiritItemOverdueReminder()
end

BaseMainUI.visibleChangeDo = function(self, cellIndex)
  -- function num : 0_82
  local tag = (not self._curActivityIndex and cellIndex) or not self._curActivityIndex or not cellIndex or cellIndex ~= self._curActivityIndex
  if tag then
    self._curActivityIndex = cellIndex
    ;
    (self._activityPanel_bannerDotFrame):FireEvent("SetPageDot")
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BaseMainUI.OnFrameBeginDrag = function(self, frame)
  -- function num : 0_83 , upvalues : _ENV
  if frame == self._activityPanel_bannerFrame and self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
end

BaseMainUI.OnFrameEndDrag = function(self, frame)
  -- function num : 0_84 , upvalues : AddActivityGameTimer
  if frame == self._activityPanel_bannerFrame then
    AddActivityGameTimer(self)
  end
end

BaseMainUI.NumberOfCell = function(self, frame)
  -- function num : 0_85
  return #self._bannerList
end

BaseMainUI.CellAtIndex = function(self, frame)
  -- function num : 0_86
  if frame == self._activityPanel_bannerFrame then
    return "activity.bannercell"
  else
    if frame == self._activityPanel_bannerDotFrame then
      return "activity.bannerdotcell"
    end
  end
end

BaseMainUI.DataAtIndex = function(self, frame, index)
  -- function num : 0_87
  if frame == self._activityPanel_bannerFrame then
    return (self._bannerList)[index]
  else
    if frame == self._activityPanel_bannerDotFrame then
      return (self._bannerList)[index]
    end
  end
end

BaseMainUI.SwimSuitRemainTimeTask = function(self)
  -- function num : 0_88 , upvalues : _ENV, timeutils, CHexagonScene
  local time = (ServerGameTimer.GetServerTime)()
  local endtime = (timeutils.GetConfigFormatTimeStamp)((CHexagonScene:GetRecorder(9001)).functionEndTime)
  local limit = endtime - time
  if limit > 0 then
    (self._swimSuitBtn_Time):SetActive(true)
    ;
    (self._swimSuitBtn_Effect):SetActive(true)
    ;
    (self._swimSuitBtn_Time):SetText(self:GetRemainTimeStr(limit))
  else
    ;
    (self._swimSuitBtn_Time):SetActive(false)
    ;
    (self._swimSuitBtn_Effect):SetActive(false)
    if self._swimSuitRemainTimeTsak then
      (GameTimer.RemoveTask)(self._swimSuitRemainTimeTsak)
    end
  end
end

BaseMainUI.ChristmasActivityRemainTimeTask = function(self)
  -- function num : 0_89 , upvalues : _ENV, timeutils, CChrisTimeConfig
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(48) then
    local time = (ServerGameTimer.GetServerTime)()
    local endtime = (timeutils.GetConfigFormatTimeStamp)((CChrisTimeConfig:GetRecorder(18001)).rewardEnd)
    local limit = endtime - time
    if limit > 0 then
      (self._christmasActivityBtn_Time):SetActive(true)
      ;
      (self._christmasActivityBtn_Effect):SetActive(true)
      ;
      (self._christmasActivityBtn_Time):SetText(self:GetRemainTimeStr(limit))
    else
      ;
      (self._christmasActivityBtn_Time):SetActive(false)
      ;
      (self._christmasActivityBtn_Effect):SetActive(false)
      if self._christmasActivityRemainTimeTsak then
        (GameTimer.RemoveTask)(self._christmasActivityRemainTimeTsak)
      end
    end
  else
    do
      local time = (ServerGameTimer.GetServerTime)()
      local christmasActivityRecord = CGenActCfg:GetRecorder(1)
      local openTime = (timeutils.GetConfigFormatTimeStamp)(christmasActivityRecord.beforetime)
      local endTime = (timeutils.GetConfigFormatTimeStamp)(christmasActivityRecord.time)
      local limit = endTime - time
      if openTime <= time and time < endTime then
        (self._christmasActivityBtn_Time):SetActive(true)
        ;
        (self._christmasActivityBtn_Effect):SetActive(true)
        ;
        (self._christmasActivityBtn_Time):SetText(self:GetRemainTimeStr(limit))
      else
        ;
        (self._christmasActivityBtn_Time):SetActive(false)
        ;
        (self._christmasActivityBtn_Effect):SetActive(false)
        if self._christmasActivityRemainTimeTsak then
          (GameTimer.RemoveTask)(self._christmasActivityRemainTimeTsak)
        end
      end
    end
  end
end

BaseMainUI.GetRemainTimeStr = function(self, endTime)
  -- function num : 0_90 , upvalues : _ENV, CStringRes
  local str = ""
  if endTime and endTime > 0 then
    local time = endTime // 1000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if day > 0 then
      str = (TextManager.GetText)((CStringRes:GetRecorder(1618)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", day)
    else
      if hour > 0 then
        str = (TextManager.GetText)((CStringRes:GetRecorder(1619)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", hour)
      else
        if min > 0 then
          str = (TextManager.GetText)((CStringRes:GetRecorder(1620)).msgTextID)
          str = (string.gsub)(str, "%$parameter1%$", min)
        else
          if sec > 0 then
            str = (TextManager.GetText)((CStringRes:GetRecorder(1620)).msgTextID)
            str = (string.gsub)(str, "%$parameter1%$", 0)
          end
        end
      end
    end
  end
  do
    return str
  end
end

BaseMainUI.HandleSpriteEvidence = function(self)
  -- function num : 0_91 , upvalues : _ENV, CImagePathTable, CVarconfig, Item
  local haveSpriteEvidence = (((NekoData.BehaviorManager).BM_Currency):GetSpiritRecoverTimes())[DataCommon.SpriteEvidence]
  if haveSpriteEvidence then
    if not CImagePathTable:GetRecorder(tonumber((CVarconfig:GetRecorder(125)).Value)) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._num0Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      do
        local imageRecord = ((Item.Create)(DataCommon.SpiritID)):GetIcon()
        ;
        (self._num0Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._name):SetActive(not haveSpriteEvidence)
        ;
        (self._nameLight):SetActive(haveSpriteEvidence)
      end
    end
  end
end

return BaseMainUI

