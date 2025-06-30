-- chunkname: @IQIGame\\UI\\Lottery\\LotteryDrawResultView.lua

local LotteryHeroShow = require("IQIGame.UI.Lottery.LotteryHeroShow")
local LotteryResultDisplayView = require("IQIGame/UI/Lottery/LotteryResultDisplayView")
local MovieView = {}

function MovieView.New(view, callback)
	local obj = Clone(MovieView)

	obj:__Init(view, callback)

	return obj
end

function MovieView:__Init(view, callback)
	self.view = view
	self.completeEvent = callback

	LuaCodeInterface.BindOutlet(self.view, self)

	function self.delegateOnJumpBtnClick()
		self.qualityVideoPlayerCom:Stop()
		self:__OnMovieComplete(true)
	end

	function self.lotteryVideoPlayerPlayCompleted()
		self:__OnMovieComplete(false)
	end

	function self.lotteryVideoPlayerErrorReceived()
		self.lotteryVideoPlayerCom:Stop()
		self:__OnMovieComplete(false)
	end

	self.lotteryVideoPlayer.gameObject:SetActive(false)

	function self.qualityVideoPlayerPrepareCompleted()
		self.qualityVideoPlayerCom:Play()
		self.movieCanvas.gameObject:SetActive(true)
	end

	function self.qualityVideoPlayerEnd()
		self:__OnMovieComplete(false)
	end

	function self.qualityVideoPlayerErrorReceived()
		self:__OnMovieComplete(false)
	end

	self.qualityVideoPlayerCom = self.qualityVideoPlayer:GetComponent(typeof(UnityEngine.Video.VideoPlayer))
	self.qualityVideoPlayerCom.prepareCompleted = self.qualityVideoPlayerCom.prepareCompleted + self.qualityVideoPlayerPrepareCompleted
	self.qualityVideoPlayerCom.loopPointReached = self.qualityVideoPlayerCom.loopPointReached + self.qualityVideoPlayerEnd
	self.qualityVideoPlayerCom.errorReceived = self.qualityVideoPlayerCom.errorReceived + self.qualityVideoPlayerErrorReceived

	self.jumpBtn:GetComponent("Button").onClick:AddListener(self.delegateOnJumpBtnClick)
end

function MovieView:Play(quality)
	EventDispatcher.Dispatch(EventID.SwitchLotteryBGM, 11100004)
	self.movieCanvas.gameObject:SetActive(false)
	self.view.gameObject:SetActive(true)

	self.qualityVideoPlayerCom.url = AssetPath.GetRealVideoPath(LotteryUIApi:GetLotteryResultQualityMoviePath(quality))

	self.qualityVideoPlayerCom:Prepare()
	self.jumpBtn.gameObject:SetActive(false)
	self:__StartJumpTime()
end

function MovieView:__StartJumpTime()
	self.jumpTimer = Timer.New(function()
		self.jumpBtn.gameObject:SetActive(true)
	end, LotteryUIApi:GetMovieJumpButtonShowDelayTime())

	self.jumpTimer:Start()
end

function MovieView:__StopJumpTime()
	if self.jumpTimer == nil then
		return
	end

	self.jumpTimer:Stop()

	self.jumpTimer = nil
end

function MovieView:__OnMovieComplete(jump)
	self:__StopJumpTime()
	EventDispatcher.Dispatch(EventID.SwitchLotteryBGM, LotteryModule.GetLotteryBGM())

	self.startPlayMovie = false

	self.completeEvent(jump)
end

function MovieView:Hide()
	self:__StopJumpTime()
	self.view.gameObject:SetActive(false)
end

function MovieView:Dispose()
	self:__StopJumpTime()
	self.jumpBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnJumpBtnClick)

	self.qualityVideoPlayerCom.prepareCompleted = self.qualityVideoPlayerCom.prepareCompleted - self.qualityVideoPlayerPrepareCompleted
	self.qualityVideoPlayerCom.loopPointReached = self.qualityVideoPlayerCom.loopPointReached - self.qualityVideoPlayerEnd
	self.qualityVideoPlayerCom.errorReceived = self.qualityVideoPlayerCom.errorReceived - self.qualityVideoPlayerErrorReceived
	self.qualityVideoPlayerCom = nil

	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local LotteryDrawResultView = {
	cardJackpotID = 0
}

function LotteryDrawResultView.New(view)
	local obj = Clone(LotteryDrawResultView)

	obj:__Init(view)

	return obj
end

function LotteryDrawResultView:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)

	self.movieView = MovieView.New(self.movieRoot, function(_jump)
		self:__OnMovieComplete(_jump)
	end)
	self.heroShowView = LotteryHeroShow.New(self.heroShowUI)
	self.resultDisplayView = LotteryResultDisplayView.New(self.rewardShow)

	self.view.gameObject:SetActive(false)
end

function LotteryDrawResultView:Show(cardJackpotID, drawResultPOD)
	self.view.gameObject:SetActive(true)

	if not self.isGroupCid then
		self.cardJackpotID = cardJackpotID
	end

	self.drawResultPOD = drawResultPOD

	self.heroShowView:Hide()
	self.resultDisplayView:Hide()

	local maxQuality = self:__GetResultMaxQuality(self.drawResultPOD.drawResults, 5, 3)

	self.movieView:Play(maxQuality)
end

function LotteryDrawResultView:ShowHistoryDrawResult(cardJackpotID, drawResultPOD)
	self.view.gameObject:SetActive(true)
	self.movieView:Hide()
	self.heroShowView:Hide()
	self.resultDisplayView:Show(cardJackpotID, drawResultPOD, true)
end

function LotteryDrawResultView:__GetResultMaxQuality(drawResults, maxValue, minValue)
	local tempMaxValue = minValue

	ForArray(drawResults, function(_index, _drawResult)
		local itemCid = _drawResult.srcId
		local itemCfg = CfgItemTable[itemCid]

		if itemCfg.Quality <= tempMaxValue then
			return
		end

		tempMaxValue = itemCfg.Quality

		if tempMaxValue < maxValue then
			return
		end

		tempMaxValue = maxValue

		return true
	end)

	return tempMaxValue
end

function LotteryDrawResultView:Hide()
	self.view.gameObject:SetActive(false)
end

function LotteryDrawResultView:Dispose()
	self.movieView:Dispose()
	self.heroShowView:Dispose()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

function LotteryDrawResultView:__OnMovieComplete(_jump)
	self.movieView:Hide()
	self.resultDisplayView:Hide()
	self.heroShowView:SetData(self.drawResultPOD, function()
		if #self.drawResultPOD.drawResults == 1 then
			EventDispatcher.Dispatch(EventID.GuideSubCustomTriggerEvent, Constant.GuideEvent.LotteryComplete)

			return
		end

		self.resultDisplayView:Show(self.cardJackpotID, self.drawResultPOD, false)
	end)
end

return LotteryDrawResultView
