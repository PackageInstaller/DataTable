-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPlotPlayView.lua

module("logic.extensions.season.view.SeasonPlotPlayView", package.seeall)

local SeasonPlotPlayView = class("SeasonPlotPlayView", ViewComponent)

function SeasonPlotPlayView:ctor()
	SeasonPlotPlayView.super.ctor(self)
end

function SeasonPlotPlayView:unbindEvents()
	SeasonPlotPlayView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPass)
	GameUtil.rmClickHandler(self._btnSpeed)
end

function SeasonPlotPlayView:bindEvents()
	SeasonPlotPlayView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPass, self.close, self)
	GameUtil.addClickHandler(self._btnSpeed, self._onClickSpeed, self)
end

function SeasonPlotPlayView:buildUI()
	SeasonPlotPlayView.super.buildUI(self)

	self._btnPass = self:getGo("btnPass")
	self._btnSpeed = self:getGo("btnSpeed")
	self._rewardScrollerRect = self:getScrollRect("scrollview")
	self._txtDesc = self:getTxt("scrollview/Viewport/Content/txtDesc")
end

function SeasonPlotPlayView:onExit()
	SeasonPlotPlayView.super.onExit(self)
end

function SeasonPlotPlayView:onEnter()
	SeasonPlotPlayView.super.onEnter(self)

	self._rate = 1

	local cfg = self:getFirstParam() or {}

	if not cfg.strPlotContent then
		self._txtDesc.text = ""

		local height = self._txtDesc.preferredHeight

		self:_playSliderMovie(height / 28)
	end
end

function SeasonPlotPlayView:_playSliderMovie(duration)
	duration = math.max(duration, 1)

	local startPos = 0
	local endPos = 1

	self._rewardScrollerRect.scrollRect.verticalNormalizedPosition = 1

	local sequence = DG.Tweening.DOTween.Sequence()
	local isDoClose = false

	local function updateTween(num)
		if self._rewardScrollerRect.scrollRect then
			self._rewardScrollerRect.scrollRect.verticalNormalizedPosition = math.max(1 - num * self._rate, 0)

			if not isDoClose and self._rewardScrollerRect.scrollRect.verticalNormalizedPosition <= 0.1 then
				isDoClose = true

				self:_doDelayClose()
			end
		end
	end

	local tween = TweenUtil.DOTweenNum(startPos, endPos, duration, updateTween, {})

	sequence:Append(tween)
end

function SeasonPlotPlayView:_doDelayClose()
	local sequence = DG.Tweening.DOTween.Sequence()
	local tween = TweenUtil.DoDelay(3, function()
		self:close()
	end)

	sequence:Append(tween)
end

function SeasonPlotPlayView:_onClickSpeed()
	self._rate = 1.2
end

return SeasonPlotPlayView
