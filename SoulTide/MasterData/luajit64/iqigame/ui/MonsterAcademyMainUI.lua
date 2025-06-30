-- chunkname: @IQIGame\\UI\\MonsterAcademyMainUI.lua

local MonsterAcademyMainUI = {
	isShowButtonView = false,
	areaCellDic = {}
}

MonsterAcademyMainUI = Base:Extend("MonsterAcademyMainUI", "IQIGame.Onigao.UI.MonsterAcademyMainUI", MonsterAcademyMainUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local monsterAcademyAreaCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyAreaCell")
local MonsterAcademyPlayerHeadView = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyPlayerHeadView")

function MonsterAcademyMainUI:OnInit()
	UGUIUtil.SetTextInChildren(self.DateBtn, MonsterAcademyMainUIApi:GetString("DateBtnLabel"))
	UGUIUtil.SetTextInChildren(self.TaskBtn, MonsterAcademyMainUIApi:GetString("TaskBtnLabel"))
	UGUIUtil.SetTextInChildren(self.BagBtn, MonsterAcademyMainUIApi:GetString("BagBtnLabel"))
	UGUIUtil.SetTextInChildren(self.MobileBtn, MonsterAcademyMainUIApi:GetString("MobileBtnLabel"))
	UGUIUtil.SetTextInChildren(self.ReadProgressBtn, MonsterAcademyMainUIApi:GetString("ReadProgressBtnLabel"))
	UGUIUtil.SetTextInChildren(self.SaveProgressBtn, MonsterAcademyMainUIApi:GetString("SaveProgressBtnLabel"))

	function self.DelegateOnClickDateBtn()
		self:OnClickDateBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateCameraChangePosEvent()
		self:OnCameraChangePosEvent()
	end

	function self.DelegateOnClickTaskBtn()
		self:OnClickTaskBtn()
	end

	function self.DelegateOnClickBagBtn()
		self:OnClickBagBtn()
	end

	function self.DelegateOnClickMobileBtn()
		self:OnClickMobileBtn()
	end

	function self.DelegateOnClickReadProgressBtn()
		self:OnClickReadProgressBtn()
	end

	function self.DelegateOnClickSaveProgressBtn()
		self:OnClickSaveProgressBtn()
	end

	function self.DelegateUpdateBaseEvent()
		self:OnUpdateBaseEvent()
	end

	function self.DelegateBtnShow()
		self:OnBtnShow()
	end

	function self.DelegateBtnHide()
		self:OnBtnHide()
	end

	function self.delegateUpdateAreaEvent()
		self:OnUpdateAreaEvent()
	end

	function self.delegateUpdateScheduleEvent()
		self:OnUpdateScheduleEvent()
	end

	function self.delegateUpdateFinishedTaskOver(cid)
		self:OnUpdateFinishedTaskOver(cid)
	end

	function self.DelegateSendMessageResult()
		self:RefreshMobileRed()
	end

	function self.DelegateUpdateMessageEvent()
		self:RefreshMobileRed()
	end

	self.playerHeadView = MonsterAcademyPlayerHeadView.New(self.PlayerInformation)

	function self.playerHeadView.CallBack()
		self:OnClickPlayerHead()
	end

	self.AreaPrefab:SetActive(false)

	self.areaCellPool = UIObjectPool.New(20, function()
		local areaCell = monsterAcademyAreaCell.New(UnityEngine.Object.Instantiate(self.AreaPrefab))

		return areaCell
	end, function(cell)
		cell:Dispose()
	end)
end

function MonsterAcademyMainUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyMainUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyMainUI:GetBGM(userData)
	return nil
end

function MonsterAcademyMainUI:OnOpen(userData)
	self.isShowButtonView = true

	local haveDialog = MonsterAcademyModule.CheckResumeDialog()

	self.Effect:SetActive(haveDialog)
	self.Outer:SetActive(not haveDialog)
	self.Root:SetActive(not haveDialog)
	MonsterAcademyModule.monsterAcademyScene:ShowScene(not haveDialog)

	if haveDialog then
		local time = Timer.New(function()
			self:UpDateView()
			self.Effect:SetActive(false)
			self.Outer:SetActive(true)
			self.Root:SetActive(true)
			MonsterAcademyModule.monsterAcademyScene:ShowScene(true)
		end, 2)

		time:Start()
	else
		self:UpDateView()
	end
end

function MonsterAcademyMainUI:OnClose(userData)
	return
end

function MonsterAcademyMainUI:OnAddListeners()
	self.DateBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDateBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTaskBtn)
	self.BagBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBagBtn)
	self.MobileBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMobileBtn)
	self.ReadProgressBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReadProgressBtn)
	self.SaveProgressBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSaveProgressBtn)
	self.BtnShow:GetComponent("Button").onClick:AddListener(self.DelegateBtnShow)
	self.BtnHide:GetComponent("Button").onClick:AddListener(self.DelegateBtnHide)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyCameraChangePosEvent, self.DelegateCameraChangePosEvent)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateAreaEvent, self.delegateUpdateAreaEvent)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateScheduleEvent, self.delegateUpdateScheduleEvent)
	EventDispatcher.AddEventListener(EventID.UpdateFinishedTaskOver, self.delegateUpdateFinishedTaskOver)
	EventDispatcher.AddEventListener(EventID.MonsterAcademySendMessageResultEvent, self.DelegateSendMessageResult)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateMessageEvent, self.DelegateUpdateMessageEvent)
end

function MonsterAcademyMainUI:OnRemoveListeners()
	self.DateBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDateBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTaskBtn)
	self.BagBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBagBtn)
	self.MobileBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMobileBtn)
	self.ReadProgressBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReadProgressBtn)
	self.SaveProgressBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSaveProgressBtn)
	self.BtnShow:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnShow)
	self.BtnHide:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnHide)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyCameraChangePosEvent, self.DelegateCameraChangePosEvent)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateAreaEvent, self.delegateUpdateAreaEvent)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateScheduleEvent, self.delegateUpdateScheduleEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateFinishedTaskOver, self.delegateUpdateFinishedTaskOver)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademySendMessageResultEvent, self.DelegateSendMessageResult)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateMessageEvent, self.DelegateUpdateMessageEvent)
end

function MonsterAcademyMainUI:OnPause()
	return
end

function MonsterAcademyMainUI:OnResume()
	return
end

function MonsterAcademyMainUI:OnCover()
	return
end

function MonsterAcademyMainUI:OnReveal()
	return
end

function MonsterAcademyMainUI:OnRefocus(userData)
	return
end

function MonsterAcademyMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyMainUI:OnDestroy()
	for i, v in pairs(self.areaCellDic) do
		self.areaCellPool:Release(v)
	end

	self.areaCellDic = {}

	self.areaCellPool:Dispose()
	self.playerHeadView:Dispose()
end

function MonsterAcademyMainUI:OnUpdateAreaEvent()
	self:UpDateView()
end

function MonsterAcademyMainUI:OnUpdateScheduleEvent()
	self:UpDateView()
end

function MonsterAcademyMainUI:OnUpdateFinishedTaskOver(cid)
	local cfgMainQuest = CfgMainQuestTable[cid]

	if cfgMainQuest.Type ~= TaskModule.TaskType.MONSTER_ACADEMY_TASK then
		return
	end

	UIModule.Open(Constant.UIControllerName.MonsterAcademyAchievementTipUI, Constant.UILayer.UI, cid)
end

function MonsterAcademyMainUI:UpDateView()
	self:RefreshBtnView()
	self.playerHeadView:UpdateView()

	for i, v in pairs(self.areaCellDic) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.areaCellPool:Release(v)
	end

	self.areaCellDic = {}

	for k, v in pairs(MonsterAcademyModule.monsterAreaDic) do
		local areaCell = self.areaCellPool:Obtain()

		areaCell.View.transform:SetParent(self.AreaNode.transform, false)
		areaCell.View:SetActive(true)
		areaCell:SetData(v)
		areaCell:RefreshPos()
		table.insert(self.areaCellDic, areaCell)
	end

	self:RefreshDateBtnRed()
	self:RefreshMobileRed()
end

function MonsterAcademyMainUI:RefreshBtnView()
	self.ButtonView:SetActive(self.isShowButtonView)
	self.BtnShow:SetActive(self.isShowButtonView)
	self.BtnHide:SetActive(not self.isShowButtonView)
end

function MonsterAcademyMainUI:OnCameraChangePosEvent()
	for i, v in pairs(self.areaCellDic) do
		v:RefreshPos()
	end
end

function MonsterAcademyMainUI:RefreshDateBtnRed()
	local redNode = self.DateBtn.transform:Find("Point")

	if redNode then
		local top = MonsterAcademyModule.GetDateBtnRed()

		redNode.gameObject:SetActive(top)
	end
end

function MonsterAcademyMainUI:RefreshMobileRed()
	local red = false

	for i, v in pairs(MonsterAcademyModule.girlDic) do
		local funDataTable = v:GetGirlFunctionBySubType({
			MonsterAcademyConstant.FunctionSubType.FunctionSubType_Telephone,
			MonsterAcademyConstant.FunctionSubType.FunctionSubType_Notice
		})

		if #funDataTable == 1 and funDataTable[1].cfgFunction.FunctionSubType ~= 11 then
			red = true

			break
		end

		local showMessageRed = v:IsNextMessage()

		if showMessageRed then
			red = true

			break
		end
	end

	self.MobileRed:SetActive(red)
end

function MonsterAcademyMainUI:OnUpdateBaseEvent()
	self:UpDateView()
end

function MonsterAcademyMainUI:OnBtnShow()
	self.isShowButtonView = false

	self:RefreshBtnView()
end

function MonsterAcademyMainUI:OnBtnHide()
	self.isShowButtonView = true

	self:RefreshBtnView()
end

function MonsterAcademyMainUI:OnClickPlayerHead()
	UIModule.Open(Constant.UIControllerName.MonsterAcademyPlayerUI, Constant.UILayer.UI)
end

function MonsterAcademyMainUI:OnClickDateBtn()
	UIModule.Open(Constant.UIControllerName.MonsterAcademyCalendarUI, Constant.UILayer.UI)
end

function MonsterAcademyMainUI:OnClickTaskBtn()
	UIModule.Open(Constant.UIControllerName.MonsterAcademyMissionUI, Constant.UILayer.UI)
end

function MonsterAcademyMainUI:OnClickBagBtn()
	UIModule.Open(Constant.UIControllerName.MonsterAcademyBagUI, Constant.UILayer.UI)
end

function MonsterAcademyMainUI:OnClickMobileBtn()
	UIModule.Open(Constant.UIControllerName.MonsterAcademyMoodUI, Constant.UILayer.UI)
end

function MonsterAcademyMainUI:OnClickReadProgressBtn()
	UIModule.Open(Constant.UIControllerName.MonsterAcademySLDataUI, Constant.UILayer.UI, {
		OpenType = 1
	})
end

function MonsterAcademyMainUI:OnClickSaveProgressBtn()
	UIModule.Open(Constant.UIControllerName.MonsterAcademySLDataUI, Constant.UILayer.UI, {
		OpenType = 2
	})
end

function MonsterAcademyMainUI:OnClickCloseBtn()
	MonsterAcademyModule.ExitMonsterAcademyScene()
	UIModule.Close(Constant.UIControllerName.MonsterAcademyMainUI)
end

return MonsterAcademyMainUI
