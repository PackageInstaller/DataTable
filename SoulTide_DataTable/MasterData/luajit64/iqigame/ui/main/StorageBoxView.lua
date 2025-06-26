-- chunkname: @IQIGame\\UI\\Main\\StorageBoxView.lua

local m = {
	delayDurationHundredDay = 0,
	btnNames = {}
}

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.Root = root

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.StorageBoxTitle, MainUIApi:GetString("StorageBoxTitle"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateUpdateSignInEvent()
		self:OnUpdateSignRedPoint()
	end

	function self.delegateOnUpdateTask(cid)
		self:OnUpdateTask(cid)
	end

	function self.delegateOnRefreshMainUIUnlockBtn()
		self:OnRefreshMainUIUnlockBtn()
	end

	function self.delegateOnUpdateFriend()
		self:OnUpdateFriend()
	end

	function self.delegateUpgradeBigBattle()
		self:OnUpgradeBigBattle()
	end

	function self.delegatePlayerInfoChanged()
		self:OnPlayerInfoChange()
	end

	function self.delegateOperationsEvent()
		self:OnOperationsEvent()
	end

	function self.delegateUpdateWelcomeBackEvent()
		self:OnWelcomeBackEvent()
	end

	function self.delegateUpdateCommandChallengeRed()
		self:OnUpdateCommandChallengeRed()
	end

	self:InitBtns()
	self:AddListener()
end

function m:InitBtns()
	self.btnNames = {
		"SignBtn",
		"FriendBtn",
		"ActiveRookieBtn",
		"ActiveWeekBtn",
		"PreviewBtn",
		"ActiveUpgradeBtn",
		"ActivityHundredDayBtn",
		"ActiveWelcomeNewBtn",
		"ActiveWelcomeBackBtn",
		"CardGameBtn",
		"CameraBtn",
		"CommandChallengeBtn"
	}
	self.handlers = {}
	self.RedPoints = {}

	for k, v in ipairs(self.btnNames) do
		local func = self["OnClick" .. v]

		self.handlers[v] = function(...)
			func(self, ...)
		end

		local redPointTrans = self[v].transform:Find("Image_RedPoint")

		if redPointTrans ~= nil then
			self.RedPoints[v] = redPointTrans.gameObject

			self.RedPoints[v]:SetActive(false)
		end

		for i = 0, self[v].transform.childCount - 1 do
			local child = self[v].transform:GetChild(i)

			if string.find(child.name, "Text_1") then
				child:GetComponent("Text").text = MainUIApi:GetString(v .. "Text", 1)
			end

			if string.find(child.name, "Text_2") then
				child:GetComponent("Text").text = MainUIApi:GetString(v .. "Text", 2)

				break
			end
		end
	end
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)

	for k, v in pairs(self.handlers) do
		local button = self[k]:GetComponent("Button")

		if button == nil then
			logError("Can not find button named : " .. k)
		end

		button.onClick:AddListener(v)
	end

	EventDispatcher.AddEventListener(EventID.UpdateSignInEvent, self.delegateUpdateSignInEvent)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.delegateOnUpdateTask)
	EventDispatcher.AddEventListener(EventID.RefreshMainUIUnlockBtn, self.delegateOnRefreshMainUIUnlockBtn)
	EventDispatcher.AddEventListener(EventID.UpdateFriend, self.delegateOnUpdateFriend)
	EventDispatcher.AddEventListener(EventID.UpdateUpgradeBigBattle, self.delegateUpgradeBigBattle)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateOperationsEvent)
	EventDispatcher.AddEventListener(EventID.UpdateWelcomeBackEvent, self.delegateUpdateWelcomeBackEvent)
	EventDispatcher.AddEventListener(EventID.UpdateCommandChallengeRedPointEvent, self.delegateUpdateCommandChallengeRed)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)

	for k, v in pairs(self.handlers) do
		self[k]:GetComponent("Button").onClick:RemoveListener(v)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateSignInEvent, self.delegateUpdateSignInEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.delegateOnUpdateTask)
	EventDispatcher.RemoveEventListener(EventID.RefreshMainUIUnlockBtn, self.delegateOnRefreshMainUIUnlockBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateFriend, self.delegateOnUpdateFriend)
	EventDispatcher.RemoveEventListener(EventID.UpdateUpgradeBigBattle, self.delegateUpgradeBigBattle)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateOperationsEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateWelcomeBackEvent, self.delegateUpdateWelcomeBackEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateCommandChallengeRedPointEvent, self.delegateUpdateCommandChallengeRed)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	local now = PlayerModule.GetServerTime()

	if now - self.delayDurationHundredDay >= 1 then
		self.delayDurationHundredDay = now

		self:CheckHundredDay()
	end
end

function m:Refresh()
	self:RefreshUnlockBtn()
	self:RefreshRedPoint()
end

function m:RefreshUnlockBtn()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.SIGN)

	self.SignBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.FRIEND)

	self.FriendBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.ACTIVE_ROOKIE) and ActiveModule.CheckExistRookieTask()

	self.ActiveRookieBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.ACTIVITY_WEEK) and not NoticeModule.IsInQueue(Constant.UnlockType.ACTIVITY_WEEK) and ActiveWeekendModule.CheckExistWeekendTask()

	self.ActiveWeekBtn:SetActive(result)
	self.PreviewBtn:SetActive(not PlayerModule.IsMazeFinished(CfgDiscreteDataTable[6520074].Data[1]))

	result = PlayerModule.PlayerInfo.baseInfo.pLv < CfgDiscreteDataTable[6520062].Data[1]

	local isHaveReward = false

	if ActiveModule.idsList then
		isHaveReward = #ActiveModule.idsList > 0
	end

	self.ActiveUpgradeBtn:SetActive(result or isHaveReward)
	self.CameraBtn:SetActive(UnlockFunctionModule.IsUnlock(Constant.UnlockType.ACTIVE_VIRTUAL_PHOTO))

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.COMMAND_CHALLENGE)

	self.CommandChallengeBtn:SetActive(result)
	self:CheckHundredDay()
	self:UpdateActiveWelcomeNew()
	self:UpdateActiveWelcomeBack()

	local isShow = false

	for k, v in ipairs(self.btnNames) do
		if self[v].activeSelf then
			isShow = true

			break
		end
	end

	self.Root.StorageBoxBtn:SetActive(isShow)
end

function m:CheckHundredDay()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.ACTIVITY_HUNDRED_DAY)
	local timeSecond = PlayerModule.GetServerTime()
	local startTimeSec = cfgDateTimeToTimeStamp(MainUIApi:GetString("ActivityHundredDayOpenTime"), PlayerModule.TimeZone)
	local endTime = cfgDateTimeToTimeStamp(MainUIApi:GetString("ActivityHundredDayEndTime"), PlayerModule.TimeZone)
	local isShowH5 = SDKLoginModule.isShowH5()

	if result and startTimeSec <= timeSecond and timeSecond <= endTime and isShowH5 or GmListModule.IsSpeTestFunctionEnabled() then
		self.ActivityHundredDayBtn:SetActive(true)
	else
		self.ActivityHundredDayBtn:SetActive(false)
	end
end

function m:UpdateActiveWelcomeBack()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.ACTIVITY_WELCOME_BACK)
	local open = ActiveWelcomeBackModule.ActiveWelcomeBackIsOpen()
	local haveTaskReward = ActiveWelcomeBackModule.HaveTaskGetReward()

	if result and open and not haveTaskReward then
		self.ActiveWelcomeBackBtn:SetActive(true)
		self:RefreshRedPoint()
	else
		self.ActiveWelcomeBackBtn:SetActive(false)
	end
end

function m:UpdateActiveWelcomeNew()
	local openEventID = ActiveWelcomeNewModule.GetOpenWelcomeNewActive()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.ACTIVITY_WELCOME_NEW)

	if openEventID ~= nil and result then
		self.ActiveWelcomeNewBtn:SetActive(true)
		self:RefreshRedPoint()
	else
		self.ActiveWelcomeNewBtn:SetActive(false)
	end
end

function m:CheckRootBtnActive()
	return
end

function m:ShowRedPoint(btnName, visible)
	local redPoint = self.RedPoints[btnName]

	if redPoint ~= nil then
		redPoint:SetActive(visible)
	end
end

function m:OnWelcomeBackEvent()
	self:RefreshUnlockBtn()
end

function m:OnOperationsEvent()
	self:RefreshUnlockBtn()
end

function m:OnPlayerInfoChange()
	self:RefreshUnlockBtn()
end

function m:OnUpgradeBigBattle()
	self:RefreshUnlockBtn()
	self:RefreshRedPoint()
end

function m:OnUpdateFriend()
	self:RefreshRedPoint()
end

function m:OnRefreshMainUIUnlockBtn()
	self:RefreshUnlockBtn()
end

function m:OnUpdateSignRedPoint()
	self:RefreshRedPoint()
end

function m:OnUpdateCommandChallengeRed()
	self:RefreshRedPoint()
end

function m:OnUpdateTask(cid)
	self:Refresh()
end

function m:RefreshRedPoint()
	local signRed = SignInModule.CheckRedPointOnSign()

	self:ShowRedPoint("SignBtn", signRed)

	local applications = FriendModule.GetFriends(Constant.FriendType.TYPE_APPLICATION)
	local friendRed = #applications > 0

	self:ShowRedPoint("FriendBtn", friendRed)

	local activeRookieRed = ActiveModule.CheckRedPointOnActiveRookie()

	self:ShowRedPoint("ActiveRookieBtn", activeRookieRed)

	local activeWeekRed = ActiveWeekendModule.CheckRedPoint()

	self:ShowRedPoint("ActiveWeekBtn", activeWeekRed)

	local WelcomeNewRed = ActiveWelcomeNewModule.CheckAllWelcomeNewRedPoint()

	self:ShowRedPoint("ActiveWelcomeNewBtn", WelcomeNewRed)

	local WelcomeBackRed = ActiveWelcomeBackModule.CheckWelcomeBackRedPoint()

	self:ShowRedPoint("ActiveWelcomeBackBtn", WelcomeBackRed)

	local activeUpgradeRed = false

	if ActiveModule.idsList then
		for i, v in pairs(ActiveModule.idsList) do
			local cfgUpgradeBigBattle = CfgUpgradeBigBattleTable[v]

			if PlayerModule.PlayerInfo.baseInfo.pLv >= cfgUpgradeBigBattle.TargetLevel then
				activeUpgradeRed = true

				break
			end
		end
	end

	self:ShowRedPoint("ActiveUpgradeBtn", activeUpgradeRed)

	local CommandChallengeRed = CommandChallengeModule.CheckCommandChallengeRed()

	self:ShowRedPoint("CommandChallengeBtn", CommandChallengeRed)

	local rootBtnRed = signRed or friendRed or activeRookieRed or activeWeekRed or WelcomeNewRed or WelcomeBackRed or activeUpgradeRed or CommandChallengeRed

	self.Root:ShowRedPoint("StorageBoxBtn", rootBtnRed)
end

function m:OnBtnClose()
	self:Close()
end

function m:OnClickSignBtn()
	UIModule.Open(Constant.UIControllerName.ActivitySignUI, Constant.UILayer.UI)
end

function m:OnClickFriendBtn()
	self:ShowRedPoint("FriendBtn", false)
	UIModule.Open(Constant.UIControllerName.FriendUI, Constant.UILayer.UI)
end

function m:OnClickActiveRookieBtn()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.ACTIVE_ROOKIE) then
		UIModule.Open(Constant.UIControllerName.ActiveRookieUI, Constant.UILayer.UI)
	else
		NoticeModule.ShowNoticeByType(1, UnlockFunctionModule.LockTitle(Constant.UnlockType.ACTIVE_ROOKIE))
	end
end

function m:OnClickActiveWeekBtn()
	UIModule.Open(Constant.UIControllerName.ActiveWeekendUI, Constant.UILayer.UI)
end

function m:OnClickPreviewBtn()
	UIModule.Open(Constant.UIControllerName.FunctionPreviewUI, Constant.UILayer.UI)
end

function m:OnClickActiveUpgradeBtn()
	UIModule.Open(Constant.UIControllerName.RewardLevelsUI, Constant.UILayer.UI)
end

function m:OnClickActivityHundredDayBtn()
	local urlType = MainUIApi:GetActivityHundredDayURLType()
	local url = MainUIApi:GetString("ActivityHundredDayURL")

	if urlType == 1 then
		UnityEngine.Application.OpenURL(url)
	elseif urlType == 2 then
		local md5 = require("IQIGame.Util.md5")
		local md5RoleId = md5.sumhexa(PlayerModule.PlayerInfo.baseInfo.guid .. "")
		local url1 = url .. "?roleName=" .. urlEncode(PlayerModule.PlayerInfo.baseInfo.pName) .. "&roleId=" .. PlayerModule.PlayerInfo.baseInfo.guid .. "&cuId=" .. SDKLoginModule.SDKUser.channelUid .. "&serverId=" .. PlayerModule.PlayerInfo.baseInfo.areaId .. "&token=" .. md5RoleId

		UnityEngine.Application.OpenURL(url1)
	end
end

function m:OnClickActiveWelcomeNewBtn()
	local helpNewbiesDataPOD = ActiveWelcomeNewModule.GetHelpNewbiesDataPOD()

	if helpNewbiesDataPOD then
		if helpNewbiesDataPOD.type == 1 then
			UIModule.Open(Constant.UIControllerName.WelcomeActivityInviteeUI, Constant.UILayer.UI)
		elseif helpNewbiesDataPOD.type == 2 then
			UIModule.Open(Constant.UIControllerName.WelcomeActivityInviterUI, Constant.UILayer.UI)
		end
	end
end

function m:OnClickActiveWelcomeBackBtn()
	UIModule.Open(Constant.UIControllerName.WelcomeBackUI, Constant.UILayer.UI)
end

function m:OnClickCardGameBtn()
	local CChatPOD = {}

	CChatPOD.channel = ChatModule.CHANNEL_WORLD
	CChatPOD.type = 1
	CChatPOD.target = ""
	CChatPOD.content = "/cmd cardgame 39000002"

	net_centerChat.sendChat(CChatPOD)
end

function m:OnClickCameraBtn()
	UIModule.Open(Constant.UIControllerName.VirtualPhotoStartUI, Constant.UILayer.UI)
end

function m:OnClickCommandChallengeBtn()
	UIModule.Open(Constant.UIControllerName.CommandChallengeUI, Constant.UILayer.UI)
end

function m:Open()
	self.View:SetActive(true)
	self:Refresh()
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
