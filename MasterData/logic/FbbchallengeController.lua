-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/controller/FbbchallengeController.lua

module("logic.extensions.fbbchallenge.controller.FbbchallengeController", package.seeall)

local FbbchallengeController = class("FbbchallengeController", BaseController)

FbbchallengeController.PM_FengBaoBaoClgGetInfoRes = "FbbchallengeController.PM_FengBaoBaoClgGetInfoRes"
FbbchallengeController.PM_FengBaoBaoChallengeSetFormRes = "FbbchallengeController.PM_FengBaoBaoChallengeSetFormRes"
FbbchallengeController.PM_FengBaoBaoChallengeGetFormRes = "FbbchallengeController.PM_FengBaoBaoChallengeGetFormRes"
FbbchallengeController.PM_FengBaoBaoClgStartGameRes = "FbbchallengeController.PM_FengBaoBaoClgStartGameRes"
FbbchallengeController.PM_FengBaoBaoClgEndGameRes = "FbbchallengeController.PM_FengBaoBaoClgEndGameRes"
FbbchallengeController.PM_FengBaoBaoClgFightRes = "FbbchallengeController.PM_FengBaoBaoClgFightRes"
FbbchallengeController.PM_FengBaoBaoClgBuyTimesRes = "FbbchallengeController.PM_FengBaoBaoClgBuyTimesRes"

function FbbchallengeController:ctor()
	return
end

function FbbchallengeController:onInit()
	GlobalDispatcher:addListener(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgGetInfoRes, self._PM_FengBaoBaoClgGetInfoRes, self)
	GlobalDispatcher:addListener(FengBaoBaoChallengeAgent.PM_FengBaoBaoChallengeSetFormRes, self._PM_FengBaoBaoChallengeSetFormRes, self)
	GlobalDispatcher:addListener(FengBaoBaoChallengeAgent.PM_FengBaoBaoChallengeGetFormRes, self._PM_FengBaoBaoChallengeGetFormRes, self)
	GlobalDispatcher:addListener(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgStartGameRes, self._PM_FengBaoBaoClgStartGameRes, self)
	GlobalDispatcher:addListener(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgFightRes, self._PM_FengBaoBaoClgFightRes, self)
	GlobalDispatcher:addListener(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgBuyTimesRes, self._PM_FengBaoBaoClgBuyTimesRes, self)
	self:onReset()
end

function FbbchallengeController:onReset()
	self._clientKey = 0
end

function FbbchallengeController:_PM_FengBaoBaoClgGetInfoRes(status, msg)
	if status == 0 then
		FbbchallengeModel.instance:setClgInfo(msg)
	end

	GlobalDispatcher:dispatch(FbbchallengeController.PM_FengBaoBaoClgGetInfoRes, status, msg)
end

function FbbchallengeController:_PM_FengBaoBaoChallengeSetFormRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(FbbchallengeController.PM_FengBaoBaoChallengeSetFormRes, status, msg)
end

function FbbchallengeController:_PM_FengBaoBaoChallengeGetFormRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(FbbchallengeController.PM_FengBaoBaoChallengeGetFormRes, status, msg)
end

function FbbchallengeController:_PM_FengBaoBaoClgStartGameRes(status, msg)
	if status == 0 then
		FbbchallengeModel.instance:setStartGameServerKey(msg.serverKey)
		UIStateManager.instance:push(ViewName.FbbgameView)
	end

	UIStateManager.instance:popByName(ViewName.FbbgameresultView)
	GlobalDispatcher:dispatch(FbbchallengeController.PM_FengBaoBaoClgStartGameRes, status, msg)
end

function FbbchallengeController:_PM_FengBaoBaoClgFightRes(status, msg)
	if status == 0 then
		local maxHp = FbbchallengeModel.instance:getClgInfo().bossHp

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Fengbaobao, {
			msg.curHp,
			maxHp,
			"剩余血量"
		})
		BattleSettlementModel.instance:setChangeSetId(msg.changSetId)
	end

	GlobalDispatcher:dispatch(FbbchallengeController.PM_FengBaoBaoClgFightRes, status, msg)
end

function FbbchallengeController:_PM_FengBaoBaoClgBuyTimesRes(status, msg)
	if status == 0 then
		FbbchallengeModel.instance:buyTimeSuccess()
	end

	GlobalDispatcher:dispatch(FbbchallengeController.PM_FengBaoBaoClgBuyTimesRes, status, msg)
end

function FbbchallengeController:sendPM_FengBaoBaoClgEndGameReq(shovelNums)
	local lastShovelNums = FbbchallengeModel.instance:getBestShovelNums()
	local key = GameUtil.getClientEncryptedKey(self._clientKey, FbbchallengeModel.instance:getStartGameServerKey(), {
		shovelNums
	})

	FengBaoBaoChallengeAgent.instance:sendPM_FengBaoBaoClgEndGameReq(shovelNums, key, function(msg)
		self:_onWYGameResult(shovelNums, lastShovelNums)
		GlobalDispatcher:dispatch(FbbchallengeController.PM_FengBaoBaoClgEndGameRes, 0, msg)
	end, nil, function(msg, status)
		GlobalDispatcher:dispatch(FbbchallengeController.PM_FengBaoBaoClgEndGameRes, status, msg)
	end)
end

function FbbchallengeController:_onWYGameResult(shovelNums, lastShovelNums)
	UIStateManager.instance:push(ViewName.FbbgameresultView, shovelNums, lastShovelNums)
end

function FbbchallengeController:gotoPlaySamallGame()
	local randomNum = math.random(1, 9)

	self._clientKey = randomNum

	FengBaoBaoChallengeAgent.instance:sendPM_FengBaoBaoClgStartGameReq(randomNum)
end

FbbchallengeController.instance = FbbchallengeController.New()

return FbbchallengeController
