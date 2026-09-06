-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimatewarFinalStartView.lua

module("logic.extensions.ultimatewar.view.UltimatewarFinalStartView", package.seeall)

local UltimatewarFinalStartView = class("UltimatewarFinalStartView", ViewComponent)
local _MaxClickCount = 3

function UltimatewarFinalStartView:buildUI()
	UltimatewarFinalStartView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._imgCenter = self:getGo("imgCenter")
	self._centerTips = self:getGo("centerTips")
	self._puzzleView = self:getGo("puzzle/puzzleView")
	self._puzzleGoList = {}

	for idx = 1, self._puzzleView.transform.childCount do
		self._puzzleGoList[idx] = self._puzzleView.transform:GetChild(idx - 1).gameObject
	end

	_MaxClickCount = #self._puzzleGoList
	self._puzzle = self:getGo("puzzle")
	self._btnUse = self:getGo("puzzle/btnUse")
	self._imgEgg = self:getGo("imgEgg")
	self._rawImage = self._imgEgg:GetComponent(ComponentType.RawImage)
	self._baokaiEffRoot = self:getGo("baokaiEffRoot")
end

function UltimatewarFinalStartView:bindEvents()
	UltimatewarFinalStartView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnUse, self._onClickBtnUse, self)
	GameUtil.addClickHandler(self._imgCenter, self._onClickImgCenter, self)
end

function UltimatewarFinalStartView:unbindEvents()
	UltimatewarFinalStartView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnUse)
	GameUtil.rmClickHandler(self._imgCenter)
end

function UltimatewarFinalStartView:onEnter()
	UltimatewarFinalStartView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._playingStoryId = nil
	self._finishCallBack = nil
	self._isPlaying = false
	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._clickCount = 0

	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarFinishPlotRes, self._handlePM_UltimateWarFinishPlotRes, self)
	self.addGEvent(self, GlobalNotify.EndStory, self._handleEndStory, self)

	if not self._ultimateWarMo:isFinishPlotId(UltimateWarEnum.Story_Plot_4) then
		UltimateWarController.instance:sendPM_UltimateWarFinishPlotReq(self._activityId, UltimateWarEnum.Story_Plot_4)
	end

	for i, mainGo in ipairs(self._puzzleGoList) do
		GameUtil.SetActive(mainGo, i > self._clickCount)

		local puzzleRawImage = mainGo:GetComponent(ComponentType.RawImage)

		Game.ImageUtil.SetRawImageAlpha(puzzleRawImage, 1)
	end

	GameUtil.SetActive(self._puzzle, self._isPunch)
	GameUtil.SetActive(self._btnUse, self._isPunch)
	GameUtil.SetActive(self._imgCenter, not self._isPunch)
	GameUtil.SetActive(self._centerTips, not self._isPunch)

	local form, to = self:getAlphaFormTo(self._clickCount, _MaxClickCount)

	Game.ImageUtil.SetRawImageAlpha(self._rawImage, form)
end

function UltimatewarFinalStartView:onExit()
	UltimatewarFinalStartView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._baoKaiEff)

	self._baoKaiEff = nil

	UIEffectManager.instance:stopEffect(self._bianBaiEff)

	self._bianBaiEff = nil

	if self._sequence then
		self._sequence:Kill(false)
	end
end

function UltimatewarFinalStartView:_handlePM_UltimateWarFinishPlotRes(status, msg)
	if status ~= 0 then
		self._clickCount = 0

		self:close()

		return
	end

	local plotId = msg.plotId

	if plotId == UltimateWarEnum.Story_Plot_4 then
		local storyId = UltimateWarConfig.instance:getPlotStoryId(self._activityId, plotId)

		GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
	elseif plotId == UltimateWarEnum.Story_Plot_5 then
		local effParent = self.mainGO
		local path = "20241220/zhongyanzhizhan/fx_ui_bianbai.prefab"

		UIEffectManager.instance:stopEffect(self._bianBaiEff)

		local function finishHandler(handlerTarget, eff)
			local storyId = UltimateWarConfig.instance:getPlotStoryId(self._activityId, plotId)

			self._playingStoryId = storyId

			function self._finishCallBack()
				self:close()
				UIStateManager.instance:push(ViewName.UltimateWarFinalBossView, self._activityId)
				UIStateManager.instance:push(ViewName.UltimateWarVoteView, self._activityId)
			end

			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		self._bianBaiEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, nil)
	end
end

function UltimatewarFinalStartView:_handleEndStory(storyId, isAllEnd)
	if not isAllEnd then
		return
	end

	if self._playingStoryId ~= storyId then
		return
	end

	GameUtil.callBack(self._finishCallBack)

	self._playingStoryId = nil
	self._finishCallBack = nil
end

function UltimatewarFinalStartView:_onClickBtnUse()
	if self._isPlaying or self._clickCount >= _MaxClickCount then
		FloatWordMgr.instance:show("能量注入中")

		return
	end

	self._isPlaying = true
	self._clickCount = self._clickCount + 1

	if self._sequence then
		self._sequence:Kill(false)

		self._sequence = nil
	end

	local sequence = DG.Tweening.DOTween.Sequence()

	self._sequence = sequence

	local form, to = self:getAlphaFormTo(self._clickCount, _MaxClickCount)
	local tweenerA = TweenUtil.ValueTo(form, to, 2, function(val)
		Game.ImageUtil.SetRawImageAlpha(self._rawImage, val)
	end, nil, self, DG.Tweening.Ease.OutQuad)
	local puzzleGo = self._puzzleGoList[self._clickCount]
	local puzzleRawImage = puzzleGo:GetComponent(ComponentType.RawImage)
	local tweenerB = TweenUtil.ValueTo(1, 0, 2, function(val)
		Game.ImageUtil.SetRawImageAlpha(puzzleRawImage, val)
	end, nil, self, DG.Tweening.Ease.OutQuad)

	tweenerB:OnComplete(function()
		GameUtil.SetActive(puzzleGo, false)
	end)
	sequence:Join(tweenerA)
	sequence:Join(tweenerB)
	sequence:OnComplete(function()
		self._isPlaying = false

		if self._clickCount >= _MaxClickCount then
			GameUtil.SetActive(self._btnUse, false)
			UltimateWarController.instance:sendPM_UltimateWarFinishPlotReq(self._activityId, UltimateWarEnum.Story_Plot_5)
		end
	end)
	self:stopViewEffectUniGo(self._baokaiEffRoot)
	self:playViewEffectUniGo("20241220/zhongyanzhizhan/fx_ui_baokai.prefab", self._baokaiEffRoot, self.mainGO, true)
end

function UltimatewarFinalStartView:getAlphaFormTo(cur, max)
	cur = Mathf.Max(cur - 1, 0)

	local form = 1 / max * (max - cur)
	local to = 1 / max * Mathf.Max(max - cur - 1, 0)

	return form, to
end

function UltimatewarFinalStartView:_onClickImgCenter()
	if self._isPunch then
		return
	end

	self._isPunch = true

	local effParent = self._baokaiEffRoot
	local path = "20241220/zhongyanzhizhan/fx_ui_baokai.prefab"

	UIEffectManager.instance:stopEffect(self._baoKaiEff)

	local function finishHandler(handlerTarget, eff)
		GameUtil.SetActive(self._imgCenter, false)
		GameUtil.SetActive(self._puzzle, true)
		GameUtil.SetActive(self._btnUse, true)
		GameUtil.SetActive(self._centerTips, false)
	end

	local function loadedHandler(handlerTarget, eff)
		eff:setParent(effParent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end

	self._baoKaiEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, nil)
end

return UltimatewarFinalStartView
