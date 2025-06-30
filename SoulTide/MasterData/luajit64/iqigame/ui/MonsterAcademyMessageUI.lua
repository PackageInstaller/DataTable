-- chunkname: @IQIGame\\UI\\MonsterAcademyMessageUI.lua

local MonsterAcademyMessageUI = {}

MonsterAcademyMessageUI = Base:Extend("MonsterAcademyMessageUI", "IQIGame.Onigao.UI.MonsterAcademyMessageUI", MonsterAcademyMessageUI)

local MessageView = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyMessage.MessageView")

require("IQIGame.UIExternalApi.MonsterAcademyMessageUIApi")

function MonsterAcademyMessageUI:OnInit()
	UGUIUtil.SetTextInChildren(self.BtnBack, MonsterAcademyMessageUIApi:GetString("BtnBackLabel"))

	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateUpdateBaseEvent()
		self:OnUpdateBaseEvent()
	end

	function self.DelegateUpdateMessageEvent()
		self:OnUpdateMessageEvent()
	end

	function self.DelegateSendMessageResult(messageID, girlID)
		self:OnSendMessageResult(messageID, girlID)
	end

	self.messageView = MessageView.New(self.MessageView)

	function self.messageView.ChangeState(top)
		self:ShowTextCountState(top)
	end
end

function MonsterAcademyMessageUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyMessageUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyMessageUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyMessageUI:GetBGM(userData)
	return nil
end

function MonsterAcademyMessageUI:OnOpen(userData)
	self.girlID = userData.GirlID

	self.messageView:Open()
	self:UpdateView()
end

function MonsterAcademyMessageUI:OnClose(userData)
	self.messageView:Close()
end

function MonsterAcademyMessageUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateBaseEvent, self.DelegateUpdateBaseEvent)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateMessageEvent, self.DelegateUpdateMessageEvent)
	EventDispatcher.AddEventListener(EventID.MonsterAcademySendMessageResultEvent, self.DelegateSendMessageResult)
end

function MonsterAcademyMessageUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateBaseEvent, self.DelegateUpdateBaseEvent)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateMessageEvent, self.DelegateUpdateMessageEvent)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademySendMessageResultEvent, self.DelegateSendMessageResult)
end

function MonsterAcademyMessageUI:OnPause()
	return
end

function MonsterAcademyMessageUI:OnResume()
	return
end

function MonsterAcademyMessageUI:OnCover()
	return
end

function MonsterAcademyMessageUI:OnReveal()
	return
end

function MonsterAcademyMessageUI:OnRefocus(userData)
	return
end

function MonsterAcademyMessageUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.messageView:OnUpdate(elapseSeconds, realElapseSeconds)
end

function MonsterAcademyMessageUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyMessageUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyMessageUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyMessageUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.messageView:Dispose()
end

function MonsterAcademyMessageUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function MonsterAcademyMessageUI:OnUpdateBaseEvent()
	self:RefreshGameTime()
end

function MonsterAcademyMessageUI:OnSendMessageResult(messageID, girlID)
	self:RefreshMessageCount()
end

function MonsterAcademyMessageUI:OnUpdateMessageEvent()
	self:UpdateView()
end

function MonsterAcademyMessageUI:UpdateView()
	self:ShowTextCountState(false)

	self.girlData = MonsterAcademyModule.girlDic[self.girlID]

	UGUIUtil.SetText(self.TextGirlName, self.girlData.cfgInfo.Name)
	UGUIUtil.SetText(self.TextGirlName1, self.girlData.cfgInfo.Name)
	self.messageView:UpdateView(self.girlData)
	self:RefreshGameTime()
	self:RefreshMessageCount()
end

function MonsterAcademyMessageUI:RefreshMessageCount()
	local sendCount = MonsterAcademyModule.GetMessageCount(0, Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_WEEK)
	local maxCount = CfgDiscreteDataTable[6520093].Data[1]
	local count = maxCount - sendCount

	if count < 0 then
		count = 0
	end

	UGUIUtil.SetText(self.TextCount, MonsterAcademyMessageUIApi:GetString("TextCount", count))
end

function MonsterAcademyMessageUI:RefreshGameTime()
	local cfgData = MonsterAcademyModule.GetGameTime()
	local str = MonsterAcademyMessageUIApi:GetString("TextDayOfPhase", MonsterAcademyModule.SaveDataDetailPOD.basePOD.dayOfPhase)

	UGUIUtil.SetText(self.TextGameTime, MonsterAcademyMessageUIApi:GetString("TextGameTime", cfgData.Year, cfgData.Month, cfgData.Day, str))
end

function MonsterAcademyMessageUI:ShowTextCountState(top)
	self.TextCount:SetActive(top)
end

return MonsterAcademyMessageUI
