-- chunkname: @IQIGame\\UI\\WorldDailyLotteryUI.lua

local WorldDailyLotteryUI = {}

WorldDailyLotteryUI = Base:Extend("WorldDailyLotteryUI", "IQIGame.Onigao.UI.WorldDailyLotteryUI", WorldDailyLotteryUI)

local animationName = "Draw_Lots_1"

function WorldDailyLotteryUI:OnInit()
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function WorldDailyLotteryUI:OnOpen(userData)
	EventDispatcher.Dispatch(EventID.AddGlobalBuffNoticeLock)

	self.actionId = userData.actionId

	if not self.actionId then
		logError("【RPG日常】日常界面没有接收到参数 actionId = " .. self.actionId)

		return
	end

	LuaUtility.SetGameObjectShow(self.lotRoot, false)

	self.isLoadComplete = false

	self:CheckRewardGet()
end

function WorldDailyLotteryUI:OnClose(userData)
	return
end

function WorldDailyLotteryUI:InitMembers()
	return
end

function WorldDailyLotteryUI:InitComponent()
	return
end

function WorldDailyLotteryUI:InitDelegate()
	function self.delegateOnClickButtonSure()
		self:OnClickButtonSure()
	end
end

function WorldDailyLotteryUI:OnAddListeners()
	self.buttonSure:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonSure)
	EventUtil.AddEventListener(self, EventID.CommonDialogControl_Action_EndDialog)
end

function WorldDailyLotteryUI:OnRemoveListeners()
	self.buttonSure:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonSure)
	EventUtil.ClearEventListener(self)
end

function WorldDailyLotteryUI:OnClickButtonSure()
	if not self.triggerActionPod then
		return
	end

	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, self.triggerActionPod.shows, nil, function()
		UIModule.CloseSelf(self)
	end)
end

function WorldDailyLotteryUI:__OnCommonDialogControl_Action_EndDialogHandler(actionCid, pod)
	if actionCid ~= self.actionId then
		return
	end

	self.waitServerResponse = false
	self.triggerActionPod = pod

	self:Refresh()
end

function WorldDailyLotteryUI:GetPreloadAssetPaths()
	return nil
end

function WorldDailyLotteryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WorldDailyLotteryUI:IsManualShowOnOpen(userData)
	return false
end

function WorldDailyLotteryUI:GetBGM(userData)
	return nil
end

function WorldDailyLotteryUI:OnPause()
	return
end

function WorldDailyLotteryUI:OnResume()
	return
end

function WorldDailyLotteryUI:OnCover()
	return
end

function WorldDailyLotteryUI:OnReveal()
	return
end

function WorldDailyLotteryUI:OnRefocus(userData)
	return
end

function WorldDailyLotteryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WorldDailyLotteryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WorldDailyLotteryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WorldDailyLotteryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WorldDailyLotteryUI:Refresh()
	LuaUtility.SetGameObjectShow(self.lotRoot, false)

	if not self.triggerActionPod then
		logError("【抽奖】没有抽奖服务器数据")

		return
	end

	self.drawLotCid = self.triggerActionPod.drawLots.cid

	local cfgDraw = CfgUtil.GetCfgDrawLotsDataWithID(self.drawLotCid)

	self.isActorSpineLoadComplete = true

	if not LuaUtility.StrIsNullOrEmpty(cfgDraw.Animations) then
		AssetUtil.LoadAsset(self, cfgDraw.Animations, self.OnActorSpineLoadSuccess)

		self.isActorSpineLoadComplete = false
	end

	if self.isActorSpineLoadComplete then
		self:RefreshLotContent()
	end
end

function WorldDailyLotteryUI:OnActorSpineLoadSuccess(assetName, asset, duration, userData)
	if self.currentActorSpine then
		GameObject.Destroy(self.currentActorSpine)
	end

	self.currentActorSpine = GameObject.Instantiate(asset, self.spineActorRoot.transform)
	self.isActorSpineLoadComplete = true

	self:PlayAnimation()
end

function WorldDailyLotteryUI:CheckLoadComplete()
	if self.isActorSpineLoadComplete then
		self.isLoadComplete = true
	end
end

function WorldDailyLotteryUI:CheckRewardGet()
	local actionData = WorldMapModule.GetComponentActionDataWithId(self.actionId)

	if not actionData:CheckCanAct() then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, "条件不满足")

		return
	end

	WorldMapModule.TriggerAction(self.actionId, 0, "")

	self.waitServerResponse = true
end

function WorldDailyLotteryUI:PlayAnimation()
	if not self.currentActorSpine then
		return
	end

	local duration = LuaUtility.GetGraphicSpineAnimationDataWithGameObject(self.currentActorSpine, animationName).Duration

	LuaUtility.SetSkeletonGraphicAnimationWithGameObject(self.currentActorSpine, 0, animationName, false)
	coroutine.start(function()
		coroutine.wait(duration)

		local cfgDrawLot = CfgUtil.GetCfgDrawLotsDataWithID(self.drawLotCid)

		if cfgDrawLot.Type == Constant.WorldDailyLotteryType.Content then
			self:RefreshLotContent()
			self:PlayEffect()
		elseif cfgDrawLot.Type == Constant.WorldDailyLotteryType.Draw then
			self:PlayEffect()
			coroutine.wait(cfgDrawLot.EffectWaitTime)
			self:OnClickButtonSure()
		end
	end)
end

function WorldDailyLotteryUI:RefreshLotContent()
	if not self.drawLotCid then
		return
	end

	local cfgDrawLot = CfgUtil.GetCfgDrawLotsDataWithID(self.drawLotCid)

	LuaUtility.SetText(self.textIndex, cfgDrawLot.Name)
	LuaUtility.SetText(self.textHead, cfgDrawLot.LotteryPoetryTitle)
	LuaUtility.SetText(self.textContent, cfgDrawLot.LotteryPoetry)
	LuaUtility.SetGameObjectShow(self.lotRoot, true)
end

function WorldDailyLotteryUI:PlayEffect()
	if not self.currentActorSpine then
		return
	end

	local effectRoot = self.currentActorSpine.transform:Find("Effect")

	if not effectRoot then
		return
	end

	LuaUtility.SetTransGameObjectShow(effectRoot, true)
end

function WorldDailyLotteryUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

return WorldDailyLotteryUI
