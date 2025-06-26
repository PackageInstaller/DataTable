-- chunkname: @IQIGame\\UI\\HomeLandRoomUI.lua

local HomeLandRoomUI = Base:Extend("HomeLandRoomUI", "IQIGame.Onigao.UI.HomeLandRoomUI", {
	isShowUI = true
})
local HomeLandRoomHelpView = require("IQIGame.UI.HomeLandVisit.HomeLandRoomHelpView")
local HomeLandRoomTipView = require("IQIGame.UI.HomeLand.HomeLandBuildingBubbleView")
local HomeLandRoomGuideView = require("IQIGame.UI.HomeLand.HomeLandRoomGuideView")
local HomeLandRoomRewardBoxCell = require("IQIGame.UI.HomeLand.HomeLandRoomRewardBoxCell")

function HomeLandRoomUI:OnInit()
	UGUIUtil.SetText(self.TextRightTopTitle, HomeLandRoomUIApi:GetString("TextRightTopTitle"))
	UGUIUtil.SetText(self.TextBtnEdit, HomeLandRoomUIApi:GetString("TextBtnEdit", false))
	UGUIUtil.SetText(self.TextBtnPurchase, HomeLandRoomUIApi:GetString("TextBtnPurchase", false))
	UGUIUtil.SetText(self.TextBtnIllustration, HomeLandRoomUIApi:GetString("TextBtnIllustration", false))
	UGUIUtil.SetText(self.TextBtnTheme, HomeLandRoomUIApi:GetString("TextBtnTheme", false))
	UGUIUtil.SetText(self.TextBtnThemeEng, HomeLandRoomUIApi:GetString("TextBtnTheme", true))
	UGUIUtil.SetText(self.TextBtnCall, HomeLandRoomUIApi:GetString("TextBtnCall"))
	UGUIUtil.SetText(self.TextBtnSetRoom, HomeLandRoomUIApi:GetString("TextBtnSetRoom"))

	self.btnBackComponent = self.BtnBack:GetComponent("Button")
	self.btnComfortDegreeComponent = self.BtnComfortDegree:GetComponent("Button")
	self.btnThemeComponent = self.BtnTheme:GetComponent("Button")
	self.btnHideUIComponent = self.BtnHideUI:GetComponent("Button")
	self.btnShowUIComponent = self.BtnShowUI:GetComponent("Button")
	self.btnEditComponent = self.BtnEdit:GetComponent("Button")
	self.btnPurchaseComponent = self.BtnPurchase:GetComponent("Button")
	self.btnIllustrationsComponent = self.BtnIllustrations:GetComponent("Button")
	self.btnSetRoomComponent = self.BtnSetRoom:GetComponent("Button")
	self.btnCallComponent = self.BtnCall:GetComponent("Button")
	self.rewardCell = HomeLandRoomRewardBoxCell.New(self.RewardBox, self)

	function self.rewardCell.clickCallBack(cell)
		self:OnClickRewardCell(cell)
	end

	function self.delegateOnBtnBack()
		self:OnClickBackBtn()
	end

	function self.delegateOnBtnComfortDegree()
		self:OnClickBtnComfortDegree()
	end

	function self.delegateOnBtnTheme()
		self:OnClickBtnTheme()
	end

	function self.delegateOnBtnEdit()
		self:OnClickBtnEdit()
	end

	function self.delegateOnBtnPurchase()
		self:OnClickBtnPurchase()
	end

	function self.delegateOnBtnIllustrations()
		self:OnClickBtnIllustrations()
	end

	function self.delegateOnBtnHideUI()
		self:OnClickBtnHideUI()
	end

	function self.delegateOnBtnShowUI()
		self:OnClickBtnShowUI()
	end

	function self.delegateOnBtnSetRoom()
		self:OnClickBtnSetRoom()
	end

	function self.delegateUpdateRoomEvent()
		self:OnUpdateRoomEvent()
	end

	function self.delegateOnUnlockNotify()
		self:OnUnlockNotify()
	end

	function self.delegateUpdateRolesEvent()
		self:OnUpdateRoles()
	end

	function self.delegateMoveCameraEndEventArgs(sender, args)
		self:OnMoveCameraEnd(sender, args)
	end

	function self.delegateHomelandUnlockRoomEvent(cid)
		self:OnUnlockRoomEvent(cid)
	end

	function self.delegateHomeLandGetRoomReward(cid)
		self:OnGetRoomReward(cid)
	end

	function self.delegateOnBtnCall()
		self:OnBtnCall()
	end

	self.visitHelpView = HomeLandRoomHelpView.__New(self.HelpView, self)
	self.roomTipView = HomeLandRoomTipView.__New(self.TipView, self)
	self.roomGuideView = HomeLandRoomGuideView.__New(self.GuideUIView, self)
end

function HomeLandRoomUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandRoomUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandRoomUI:OnOpen(userData)
	self.RootContent:SetActive(self.isShowUI)
	self.BtnShowUI:SetActive(not self.isShowUI)

	if HomeLandLuaModule.isVisitHome then
		self.visitHelpView:Open()
		self.roomTipView:Close()
		self.roomGuideView:Close()
		self.BtnSetRoom:SetActive(false)
		self.BtnHideUI:SetActive(false)
	else
		self.visitHelpView:Close()
		self.roomTipView:Open()
		self.roomGuideView:Open()
		self.BtnSetRoom:SetActive(true)
		self.BtnHideUI:SetActive(true)
	end

	self:UpDataView()
end

function HomeLandRoomUI:OnClose(userData)
	self.visitHelpView:Close()
	self.roomTipView:Close()
	self.roomGuideView:Close()
end

function HomeLandRoomUI:OnAddListeners()
	self.btnBackComponent.onClick:AddListener(self.delegateOnBtnBack)
	self.btnComfortDegreeComponent.onClick:AddListener(self.delegateOnBtnComfortDegree)
	self.btnThemeComponent.onClick:AddListener(self.delegateOnBtnTheme)
	self.btnHideUIComponent.onClick:AddListener(self.delegateOnBtnHideUI)
	self.btnShowUIComponent.onClick:AddListener(self.delegateOnBtnShowUI)
	self.btnEditComponent.onClick:AddListener(self.delegateOnBtnEdit)
	self.btnPurchaseComponent.onClick:AddListener(self.delegateOnBtnPurchase)
	self.btnIllustrationsComponent.onClick:AddListener(self.delegateOnBtnIllustrations)
	self.btnSetRoomComponent.onClick:AddListener(self.delegateOnBtnSetRoom)
	self.btnCallComponent.onClick:AddListener(self.delegateOnBtnCall)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdateRoom, self.delegateUpdateRoomEvent)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdateRolesEvent, self.delegateUpdateRolesEvent)
	EventDispatcher.AddEventListener(EventID.HomelandUnlockRoomEvent, self.delegateHomelandUnlockRoomEvent)
	EventDispatcher.AddEventListener(EventID.HomeLandGetRoomReward, self.delegateHomeLandGetRoomReward)
	GameEntry.LuaEvent:Subscribe(HomelandMoveCameraEndEventArgs.EventId, self.delegateMoveCameraEndEventArgs)
end

function HomeLandRoomUI:OnRemoveListeners()
	self.btnBackComponent.onClick:RemoveListener(self.delegateOnBtnBack)
	self.btnComfortDegreeComponent.onClick:RemoveListener(self.delegateOnBtnComfortDegree)
	self.btnThemeComponent.onClick:RemoveListener(self.delegateOnBtnTheme)
	self.btnHideUIComponent.onClick:RemoveListener(self.delegateOnBtnHideUI)
	self.btnShowUIComponent.onClick:RemoveListener(self.delegateOnBtnShowUI)
	self.btnEditComponent.onClick:RemoveListener(self.delegateOnBtnEdit)
	self.btnPurchaseComponent.onClick:RemoveListener(self.delegateOnBtnPurchase)
	self.btnIllustrationsComponent.onClick:RemoveListener(self.delegateOnBtnIllustrations)
	self.btnSetRoomComponent.onClick:RemoveListener(self.delegateOnBtnSetRoom)
	self.btnCallComponent.onClick:RemoveListener(self.delegateOnBtnCall)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdateRoom, self.delegateUpdateRoomEvent)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdateRolesEvent, self.delegateUpdateRolesEvent)
	EventDispatcher.RemoveEventListener(EventID.HomelandUnlockRoomEvent, self.delegateHomelandUnlockRoomEvent)
	EventDispatcher.RemoveEventListener(EventID.HomeLandGetRoomReward, self.delegateHomeLandGetRoomReward)
	GameEntry.LuaEvent:Unsubscribe(HomelandMoveCameraEndEventArgs.EventId, self.delegateMoveCameraEndEventArgs)
end

function HomeLandRoomUI:OnPause()
	return
end

function HomeLandRoomUI:OnResume()
	return
end

function HomeLandRoomUI:OnCover()
	return
end

function HomeLandRoomUI:OnReveal()
	return
end

function HomeLandRoomUI:OnRefocus(userData)
	return
end

function HomeLandRoomUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.visitHelpView:OnUpdate(elapseSeconds, realElapseSeconds)
end

function HomeLandRoomUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandRoomUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandRoomUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandRoomUI:OnDestroy()
	self.roomTipView:Dispose()
	self.visitHelpView:Dispose()
	self.roomGuideView:Dispose()
	AssetUtil.UnloadAsset(self)
end

function HomeLandRoomUI:OnUnlockRoomEvent()
	self:UpDataView()
end

function HomeLandRoomUI:OnUpdateRoomEvent()
	self:UpDataView()
end

function HomeLandRoomUI:OnUpdateRoles()
	self:UpDataView()
end

function HomeLandRoomUI:OnUnlockNotify()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.FURNITURELOTTERY)

	self.BtnPurchase:SetActive(false)
end

function HomeLandRoomUI:UpDataView()
	self:OnUnlockNotify()

	local cfgRoom = CfgHomeLandRoomTable[HomeLandLuaModule.currentEnterRoomID]

	self.FunctionalRoom:SetActive(cfgRoom.CanChangeSuit and not HomeLandLuaModule.isVisitHome)
	self.DormitoryRoom:SetActive(cfgRoom.CanEdit and not HomeLandLuaModule.isVisitHome)
	self.BtnComfortDegree:SetActive(cfgRoom.CanEdit)

	self.roomPOD = HomeLandLuaModule.GetRoomDataByID(HomeLandLuaModule.currentEnterRoomID)

	local roomName = cfgRoom.Name

	if self.roomPOD ~= nil then
		if self.roomPOD.name ~= nil and self.roomPOD.name ~= "" then
			roomName = self.roomPOD.name
		end

		if #cfgRoom.UnlockBuilding > 0 then
			self.TextRoomName:GetComponent("Text").text = roomName
		else
			self.TextRoomName:GetComponent("Text").text = HomeLandRoomUIApi:GetString("TextRoomName", roomName)
		end

		self.TextComfort:GetComponent("Text").text = tostring(self.roomPOD.comfort)

		local roles = HomeLandLuaModule.GetDormRoles(HomeLandLuaModule.currentEnterRoomID)

		for i = 1, self.RolesHead.transform.childCount - 1 do
			local obj = self.RolesHead.transform:GetChild(1).gameObject

			UnityEngine.GameObject.DestroyImmediate(obj)
		end

		for i = 1, #roles do
			local roleObj = UnityEngine.Object.Instantiate(self.RoleHeadMould)

			roleObj.transform:SetParent(self.RolesHead.transform, false)
			roleObj:SetActive(true)

			local id = roles[i]
			local cfgHomeLandRole = CfgHomeLandRoleTable[id]
			local path

			if cfgHomeLandRole.SoulId > 0 then
				local soulData = SoulModule.GetSoulData(cfgHomeLandRole.SoulId)

				path = UIGlobalApi.GetImagePath(soulData:GetCfgSoulRes2D().HomelandHeadIcon)
			else
				path = UIGlobalApi.GetImagePath(cfgHomeLandRole.HeadIcon)
			end

			AssetUtil.LoadImage(self, path, roleObj.transform:Find("Image_01"):GetComponent("Image"))
		end

		if HomeLandLuaModule.isVisitHome then
			self.visitHelpView:UpDataView(self.roomPOD)
		else
			self.roomTipView:UpDataView(self.roomPOD)
			self.roomGuideView:UpDataView()
		end

		self:UpDateRewardBox()
	end
end

function HomeLandRoomUI:OnGetRoomReward(cid)
	if self.roomPOD and self.roomPOD.cid == cid then
		self:UpDateRewardBox()
	end
end

function HomeLandRoomUI:UpDateRewardBox()
	local state = HomeLandLuaModule.GetRoomRewardByID(self.roomPOD.cid)
	local isRed = state == 2

	self.rewardCell:RefreshState(state)
	self.rewardCell:RefreshRedPoint(isRed)
end

function HomeLandRoomUI:OnMoveCameraEnd(sender, args)
	if args.IsEnterRoom then
		HomeLandLuaModule.currentEnterRoomID = args.RoomID
	else
		HomeLandLuaModule.currentEnterRoomID = 0
	end

	HomeLandLuaModule.cameraPosition = args.Position
	HomeLandLuaModule.cameraSize = args.Size

	local isInRoom = args.IsEnterRoom

	if isInRoom == true then
		self:UpDataView()
	end
end

function HomeLandRoomUI:OnClickBackBtn()
	if HomeLandLuaModule.currentEnterRoomID > 0 then
		GameEntry.LuaEvent:Fire(nil, HomelandQuitRoomEventArgs():Fill(HomeLandLuaModule.currentEnterRoomID))
	end

	UIModule.Close(Constant.UIControllerName.HomeLandRoomUI)
end

function HomeLandRoomUI:OnClickBtnComfortDegree()
	if not HomeLandLuaModule.isVisitHome then
		local cfgRoom = CfgHomeLandRoomTable[self.roomPOD.cid]

		if cfgRoom.CastleIndex == 2 then
			UIModule.Open(Constant.UIControllerName.HomeLandRoomComfortUI, Constant.UILayer.UI, self.roomPOD.cid)
		end
	end
end

function HomeLandRoomUI:OnClickBtnTheme()
	UIModule.Open(Constant.UIControllerName.HomeLandChangeThemeRoomUI, Constant.UILayer.UI, self.roomPOD)
end

function HomeLandRoomUI:OnClickBtnShowUI()
	self.isShowUI = true

	self.RootContent:SetActive(self.isShowUI)
	self.BtnShowUI:SetActive(not self.isShowUI)
end

function HomeLandRoomUI:OnClickBtnHideUI()
	self.isShowUI = false

	self.RootContent:SetActive(self.isShowUI)
	self.BtnShowUI:SetActive(not self.isShowUI)
end

function HomeLandRoomUI:OnClickBtnEdit()
	HomeLandLuaModule.isEditing = true

	GameEntry.LuaEvent:FireNow(nil, HomelandEditRoomEventArgs())
	GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, false))
	UIModule.Open(Constant.UIControllerName.HomeLandRoomEditUI, Constant.UILayer.UI, self.roomPOD.cid)
end

function HomeLandRoomUI:OnClickBtnPurchase()
	UIModule.Open(Constant.UIControllerName.FurnitureLotteryUI, Constant.UILayer.UI)
end

function HomeLandRoomUI:OnClickBtnIllustrations()
	UIModule.Open(Constant.UIControllerName.HomeLandChangeRoomUI, Constant.UILayer.UI)
end

function HomeLandRoomUI:OnClickBtnSetRoom()
	UIModule.Open(Constant.UIControllerName.HomeLandSoulCheckInUI, Constant.UILayer.UI, self.roomPOD.cid)
end

function HomeLandRoomUI:OnClickRewardCell(cell)
	if cell.state ~= 2 then
		local rewards = {}
		local cfgRoom = CfgHomeLandRoomTable[self.roomPOD.cid]
		local collectReward = cfgRoom.ComfortReward

		for i = 1, #collectReward, 2 do
			rewards[#rewards + 1] = {
				id = collectReward[i],
				num = collectReward[i + 1]
			}
		end

		local state = 1

		if cell.state == 1 then
			state = 3
		end

		UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
			Rewards = rewards,
			State = state
		})
	elseif cell.state == 2 then
		HomeLandLuaModule.ReceiveComfortAwards(self.roomPOD.cid)
	end
end

function HomeLandRoomUI:OnBtnCall()
	local roles = HomeLandLuaModule.GetDormRoles(HomeLandLuaModule.currentEnterRoomID)

	for i, v in pairs(roles) do
		local soulData = SoulModule.GetSoulData(v)

		if soulData.workStatus == Constant.Soul.WorkStatusWorking then
			NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, HomeLandRoomUIApi:GetString("ErrorCallMsg", soulData:GetCfgSoul().Name))
		end
	end

	HomeLandLuaModule.SummonSoul(HomeLandLuaModule.currentEnterRoomID)
end

return HomeLandRoomUI
