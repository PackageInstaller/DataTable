-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/controller/DoushouqiController.lua

module("logic.extensions.doushouqi.controller.DoushouqiController", package.seeall)

local DoushouqiController = class("DoushouqiController", BaseController)

DoushouqiController.ImgRuleRed = "DoushouqiController.ImgRuleRed"
DoushouqiController.ChessType = {
	Weihuqi = 2,
	Doushouqi = 1
}
DoushouqiController.Dir = {
	Left = 1,
	Right = 2
}

function DoushouqiController:ctor()
	return
end

function DoushouqiController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
end

function DoushouqiController:onReset()
	self._activityId = 0
end

function DoushouqiController:onNotifyBeastFightingChessStartGameRes(msg)
	DoushouqiModel.instance:resetBeforeStartGame()
	DoushouqiModel.instance:setGameStartInfo(msg)

	if msg.typeId == DoushouqiController.ChessType.Doushouqi then
		DoushouqiGameController.instance:startGame(self._activityId)
	else
		DoushouqiTigerGameController.instance:startGame(self._activityId)
	end

	UIStateManager.instance:popByName(ViewName.DoushouqimatchView)
end

function DoushouqiController:onNotifyBeastFightingChessActionRes(msg)
	if DoushouqiModel.instance:getCurChessType() == DoushouqiController.ChessType.Doushouqi then
		DoushouqiGameController.instance:onNotifyBeastFightingChessActionRes(msg)
	else
		DoushouqiTigerGameController.instance:onNotifyBeastFightingChessActionRes(msg)
	end
end

function DoushouqiController:sendBeastFightingChessMatchReq(activityId, chessType)
	self._activityId = activityId

	DoushouqiModel.instance:setCurChessType(chessType)
	BeastFightingChessAgent.instance:sendBeastFightingChessMatchReq(activityId, chessType)
end

function DoushouqiController:onChessReleaseSkillRes()
	DoushouqiModel.instance:useSkillSuccess()
end

function DoushouqiController:_onStartEnterGame()
	self:_checkDailyRedpoint()
end

function DoushouqiController:_checkDailyRedpoint()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.BeastFightingChess)
	local isRed = false

	if activityId > 0 then
		local key = self:getImgRuleKey(DoushouqiController.ImgRuleRed, activityId)
		local value = GameUtil.getUserData(key) or 0

		isRed = value == 0
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DOUSHOUQI_IMG_RULE, isRed)
end

function DoushouqiController:getImgRuleKey(key, activityId)
	return string.format("%s-%s", key, activityId)
end

function DoushouqiController:saveImgRuleRedpoint(activityId)
	local key = DoushouqiController.instance:getImgRuleKey(DoushouqiController.ImgRuleRed, activityId)
	local value = GameUtil.getUserData(key) or 0

	if value == 0 then
		GameUtil.saveUserData(key, 1)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_DOUSHOUQI_IMG_RULE, false)
	end
end

function DoushouqiController:_getBanTimeMillis(activityId, banStartTimeMillis)
	return checknumber(banStartTimeMillis) + DoushouqiConfig.instance:getHangUpBanSec(activityId) * 1000 + 3000
end

function DoushouqiController:isBan(activityId, chessType)
	local typeInfo = DoushouqiModel.instance:getTypeInfo(chessType)

	if not typeInfo then
		return false
	end

	local banStartTimeMillis = self:_getBanTimeMillis(activityId, typeInfo.banStartTimeMillis)
	local nowMs = ServerTime.nowMs()
	local leftMs = banStartTimeMillis - nowMs

	return leftMs > 0
end

function DoushouqiController:getBanTip(activityId, chessType)
	local typeInfo = DoushouqiModel.instance:getTypeInfo(chessType)

	if not typeInfo then
		return ""
	end

	local banStartTimeMillis = self:_getBanTimeMillis(activityId, typeInfo.banStartTimeMillis)
	local nowMs = ServerTime.nowMs()
	local leftMs = banStartTimeMillis - nowMs

	if leftMs > 0 then
		local leftTime = math.ceil(leftMs / 1000)
		local hour, min, sec = GameUtil.getTimeHHMMSS(leftTime)

		return string.format("当前处于挂机惩罚中，%s后才可继续匹配", leftTime > 60 and string.format("%s分%s秒", min, sec) or string.format("%s秒", sec))
	end

	return ""
end

function DoushouqiController:isDoushouqiGuiding()
	local branch = GuideModel.instance:getGuideBranch(121)

	return branch and not branch:isFinished()
end

function DoushouqiController:isWenhuqiGuiding()
	local branch = GuideModel.instance:getGuideBranch(122)

	return branch and not branch:isFinished()
end

DoushouqiController.instance = DoushouqiController.New()

return DoushouqiController
