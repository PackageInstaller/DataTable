-- chunkname: @IQIGame\\UI\\GirlOpening.lua

local GirlOpening = Base:Extend("GirlOpening", "IQIGame.Onigao.UI.GirlOpening", {
	isPlayCloseEffect = false,
	isCallBack = false,
	type = 1
})
local GirlOpenNewStoryView = require("IQIGame.UI.GirlOpening.GirlOpenNewStoryView")
local GirlOpenDatingView = require("IQIGame.UI.GirlOpening.GirlOpenDatingView")
local GirlOpenMainlineView = require("IQIGame.UI.GirlOpening.GirlOpenMainlineView")
local GirlOpenBranchLineView = require("IQIGame.UI.GirlOpening.GirlOpenBranchLineView")

function GirlOpening:OnInit()
	self.childViews = {}
	self.childViews[1] = GirlOpenNewStoryView.New(self.NewStory)
	self.childViews[2] = GirlOpenDatingView.New(self.Dating)
	self.childViews[3] = GirlOpenMainlineView.New(self.Mainline)
	self.childViews[4] = GirlOpenBranchLineView.New(self.BranchLine)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateUIBecameVisibleEvent(sender, arg)
		self:OnUIBecameVisibleEvent(sender, arg)
	end

	function self.delegateFadeoutCallBack()
		self:OnCloseUI()
	end
end

function GirlOpening:GetPreloadAssetPaths()
	return nil
end

function GirlOpening:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GirlOpening:IsManualShowOnOpen(userData)
	return false
end

function GirlOpening:GetBGM(userData)
	return nil
end

function GirlOpening:OnOpen(userData)
	self.type = userData[1]
	self.closeCallBack = userData[2]
	self.param = userData[3]
	self.dialogName = userData[4]

	self:UpdateView()

	self.isCallBack = false
	self.closeDelayTimer = Timer.New(function()
		self.closeDelayTimer = nil

		self:OnBtnClose()
	end, GirlOpeningUIApi:GetString("DelayClose"))

	self.closeDelayTimer:Start()

	self.isPlayCloseEffect = false

	EventDispatcher.Dispatch(EventID.L2DPause)
end

function GirlOpening:OnClose(userData)
	if self.closeDelayTimer then
		self.closeDelayTimer:Stop()
	end

	self.closeDelayTimer = nil
end

function GirlOpening:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	GameEntry.LuaEvent:Subscribe(UIBecameVisibleEventArgs.EventId, self.delegateUIBecameVisibleEvent)
end

function GirlOpening:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	GameEntry.LuaEvent:Unsubscribe(UIBecameVisibleEventArgs.EventId, self.delegateUIBecameVisibleEvent)
end

function GirlOpening:OnPause()
	return
end

function GirlOpening:OnResume()
	return
end

function GirlOpening:OnCover()
	return
end

function GirlOpening:OnReveal()
	return
end

function GirlOpening:OnRefocus(userData)
	return
end

function GirlOpening:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GirlOpening:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GirlOpening:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GirlOpening:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GirlOpening:OnDestroy()
	return
end

function GirlOpening:OnUIBecameVisibleEvent(sender, args)
	local uiName = args.UIName

	if uiName == Constant.UIControllerName.DialogUI then
		self.isPlayCloseEffect = true
		self.childViews[self.type].fadeoutCallBack = self.delegateFadeoutCallBack

		self.childViews[self.type]:CloseEffect()
	end
end

function GirlOpening:UpdateView()
	for i = 1, #self.childViews do
		if i == self.type then
			self.childViews[i]:Open()
			self.childViews[i]:UpdateView(self.type, self.dialogName)
		else
			self.childViews[i]:Close()
		end
	end
end

function GirlOpening:OnBtnClose()
	if self.isPlayCloseEffect then
		return true
	end

	if self.closeCallBack then
		if self.isCallBack == true then
			return
		end

		self.closeCallBack(self.param)

		self.isCallBack = true
	end
end

function GirlOpening:OnCloseUI()
	self.isPlayCloseEffect = false

	UIModule.Close(Constant.UIControllerName.GirlOpening)
end

return GirlOpening
