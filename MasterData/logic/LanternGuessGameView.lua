-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternriddle/view/LanternGuessGameView.lua

module("logic.extensions.lanternriddle.view.LanternGuessGameView", package.seeall)

local LanternGuessGameView = class("LanternGuessGameView", GuessLanternAnswerView)
local OptionEnum = {
	"A",
	"B",
	"C"
}

function LanternGuessGameView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.GuessLanternIncProgressRes, self._onIncProgressRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._problemId = params[3]
	self._problemPlanId = params[4]
	self._nextProblemId = 0
	self._curRealAnswter = ""
	self._reqProblemId = 0
	self._isStartQuestioning = true

	self:_closeMask()
	self:_initBtnNext()
	self:_refreshProblem(self._problemId)
	self:_loadEffects()
end

function LanternGuessGameView:_onClickAnswer(index)
	if not self._isStartQuestioning then
		printInfo("test 不在答题中")

		return
	end

	local selectAnswer = OptionEnum[index]

	printInfo("test LanternGuessGameView:_onClickAnswer", index, selectAnswer, self._curRealAnswter, selectAnswer == self._curRealAnswter)

	if not string.nilorempty(selectAnswer) and selectAnswer == self._curRealAnswter then
		FloatWordMgr.instance:show("回答正确")

		self._isStartQuestioning = false

		self:_refreshProblemOnAnswered(true, index)
		self:_closeMask()
		LanternRiddleController.instance:sendPM_LanternRiddleEndGameReq(self._activityId, self._stageId, true, self._problemId)
		self:close()
	else
		self:_refreshProblemOnAnswered(false, index)

		if not self:_isLeftUniqueAnswer() then
			self:_openMask()
			self:_delayCloseMask()
			FloatWordMgr.instance:show("作答错误，冷静3秒再想想~")
		end
	end
end

return LanternGuessGameView
