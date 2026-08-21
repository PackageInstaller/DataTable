-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/battle/calculate/FootballCalculateResultItem.lua

module("logic.extensions.football.view.battle.calculate.FootballCalculateResultItem", package.seeall)

local FootballCalculateResultItem = class("FootballCalculateResultItem", UIReusableLuaBehavior)

function FootballCalculateResultItem:buildUI()
	self._imgHead = goutil.findChildImageComponent(self.mainGO, "imgPlayerHead")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "txtScore")
	self._txtLoseReason = goutil.findChildTextComponent(self.mainGO, "txtReason")
	self._goWin = goutil.findChild(self.mainGO, "win")
	self._goLose = goutil.findChild(self.mainGO, "lose")
	self._goTie = goutil.findChild(self.mainGO, "tie")
	self._userInfoMO = false
end

function FootballCalculateResultItem:destroyUI()
	self._imgHead = false
	self._txtName = false
	self._txtScore = false
	self._txtLoseReason = false
	self._goWin = false
	self._goLose = false
	self._goTie = false
end

function FootballCalculateResultItem:getTeamId()
	return self._userInfoMO.teamId
end

function FootballCalculateResultItem:setUserInfoMO(userInfoMO)
	self._userInfoMO = userInfoMO
	self._txtName.text = userInfoMO.nickname

	IconLoader.setSprite(self._imgHead, IconType.HeadIcon, userInfoMO:getIconName())

	local settleNO = FootballModel.instance:getUserSettle(userInfoMO.userId)

	if settleNO then
		self._txtScore.text = string.format("%s <color=#22B473>+%s</color>", settleNO.oldScore, settleNO.newScore - settleNO.oldScore)

		self:_setResult(settleNO.gameResult, settleNO.gameResultReason)
	else
		if enableErrorLog then
			printError("cannot find settleNO for userId:", tostring(userInfoMO.userId))
		end

		self._txtScore.text = string.format("%s <color=#22B473>+%s</color>", 0, 0)

		self:_setResult(GameEnum.GameResultEnum.DRAW, settleNO.gameResultReason)
	end
end

function FootballCalculateResultItem:_setResult(result, gameResultReason)
	goutil.setActive(self._goWin, result == GameEnum.GameResultEnum.WIN)
	goutil.setActive(self._goLose, result == GameEnum.GameResultEnum.LOSE)
	goutil.setActive(self._goTie, result == GameEnum.GameResultEnum.DRAW)

	if result == GameEnum.GameResultEnum.LOSE then
		if gameResultReason == GameEnum.GameResultReasonEnum.Surrender then
			self._txtLoseReason.text = "投降"
		elseif gameResultReason == GameEnum.GameResultReasonEnum.AllDead then
			self._txtLoseReason.text = "全员阵亡"
		else
			self._txtLoseReason.text = ""
		end
	else
		self._txtLoseReason.text = ""
	end
end

return FootballCalculateResultItem
