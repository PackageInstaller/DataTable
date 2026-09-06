-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/LightKingController.lua

module("logic.extensions.timelimitedchallenge.controller.LightKingController", package.seeall)

local LightKingController = class("LightKingController", BaseController)

function LightKingController:onInit()
	LightKingChallengeAgent.instance:addHandler(LightKingChallengeAgent.PM_LightKingChallengeAfterFightRes, self._onAfterFightRes, self)
	self:onReset()
end

function LightKingController:onReset()
	self._showChangeSetId = nil
	self._items = nil
end

function LightKingController:sendGetInfoReq()
	LightKingChallengeAgent.instance:sendPM_LightKingChallengeGetInfoReq(self._onInfoRes, self)
end

function LightKingController:_onInfoRes(msg)
	LightKingModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LightKingGetInfo)
end

function LightKingController:sendBuyTimesReq(challengeType, callback)
	self._callback = callback
	self._cacheChallengeType = challengeType

	LightKingChallengeAgent.instance:sendPM_LightKingChallengeBuyTimesReq(challengeType, self._onBuyTimesRes, self)
end

function LightKingController:_onBuyTimesRes(msg)
	LightKingModel.instance:addCurBuyTimes(self._cacheChallengeType)
	GlobalDispatcher:dispatch(GlobalNotify.LightKingBuyTimes)

	if self._callback then
		self._callback()
	end
end

function LightKingController:sendGainPrize(id)
	self._cacheId = id

	LightKingChallengeAgent.instance:sendPM_LightKingChallengeGainProgressPrizeReq(id, self._onGainPrizeRes, self)
end

function LightKingController:_onGainPrizeRes(msg)
	LightKingModel.instance:addGainedId(self._cacheId)
	GlobalDispatcher:dispatch(GlobalNotify.LightKingGainPrize)
end

function LightKingController:sendUpgradeReq()
	LightKingChallengeAgent.instance:sendPM_LightKingChallengeUpgradeReq(self._onUpgradeRes, self)
end

function LightKingController:_onUpgradeRes(msg)
	FloatWordMgr.instance:show("升级成功~")
	LightKingModel.instance:setTodayHasUpgrade(true)
	LightKingModel.instance:addBuffLevel()
	GlobalDispatcher:dispatch(GlobalNotify.LightKingUpgrade)
end

function LightKingController:sendGetFormReq(challengeType, stage)
	LightKingChallengeAgent.instance:sendPM_LightKingChallengeGetFormReq(challengeType, stage, self._onGetFormRes, self)
end

function LightKingController:_onGetFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LightKingGetFormRes, msg.simpleForm)
end

function LightKingController:sendSetFormReq(challengeType, stage, simpleForm)
	self._items = {}

	if challengeType == GameEnum.LightKingChallengeType.SHENGGUANG then
		local stageCfg = LightKingConfig.instance:getStageCfg(challengeType, stage)

		if not string.nilorempty(stageCfg.prize) then
			for _, v in ipairs(string.split(stageCfg.prize, "#")) do
				local array = string.splitToNumber(v, ":")
				local data = {}

				data.type = array[1]
				data.id = array[2]
				data.num = array[3]

				table.insert(self._items, data)
			end
		end

		local matType, matId = LightKingModel.instance:getItemTypeAndId()

		table.insert(self._items, {
			type = matType,
			id = matId,
			num = stageCfg.score
		})
		print("self._items len = " .. #self._items)
	end

	LightKingChallengeAgent.instance:sendPM_LightKingChallengeSetFormReq(challengeType, stage, simpleForm, self._onSetFormRes, self)
end

function LightKingController:_onSetFormRes(msg)
	print("光明王保存阵型成功")
	GlobalDispatcher:dispatch(GlobalNotify.LightKingSetFormRes, msg.simpleForm)
end

function LightKingController:_onAfterFightRes(msg)
	print("收到战斗结果")
	LightKingModel.instance:setBtlResult(msg)

	local items = self:_saveChangeSetId(msg.changeSetId)

	self._items = items or self._items
end

function LightKingController:sendCheatReq(challengeType, stage)
	LightKingChallengeAgent.instance:sendPM_LightKingChallengeCheatReq(challengeType, stage, function(msg)
		self:_onCheatRes(msg, challengeType)
	end)
end

function LightKingController:_onCheatRes(msg, challengeType)
	local rank = checknumber(msg.rank)

	if rank > 0 then
		LightKingModel.instance:setRank(rank)
	end

	LightKingModel.instance:addStage(challengeType)
	self:_saveChangeSetId(msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.LightKingCheatRes)
end

function LightKingController:_saveChangeSetId(changeSetId)
	changeSetId = checknumber(changeSetId)

	local items

	if changeSetId > 0 then
		items = MaterialController.instance:saveChangeSetToTemp(changeSetId)
		self._showChangeSetId = changeSetId
	end

	return items
end

function LightKingController:getResultItems()
	return self._items or {}
end

function LightKingController:getShowChangeSetId()
	self._showChangeSetId = nil

	return (checknumber(self._showChangeSetId))
end

function LightKingController:getLeftTimes(challengeType)
	local cfg = LightKingConfig.instance:getBaseDefineCfg(challengeType)
	local cur = LightKingModel.instance:getCurUsedTimes(challengeType)
	local buyTimes = LightKingModel.instance:getCurBuyTimes(challengeType)

	return cfg.freeDailyTimes + buyTimes - cur
end

function LightKingController:addTimes(challengeType, callback)
	local buyTimes = LightKingModel.instance:getCurBuyTimes(challengeType)
	local cfg = LightKingConfig.instance:getBaseDefineCfg(challengeType)
	local planCfg = LightKingConfig.instance:getPlanCfg(cfg.buyTimesPlanId, buyTimes + 1)
	local buyCfg

	if planCfg then
		buyCfg = planCfg[buyTimes + 1]
	end

	local costNum = 0

	if buyCfg then
		_, _, costNum = unpack(string.splitToNumber(buyCfg.consume, ":"))
	end

	local cur, total = buyTimes, #planCfg
	local leftTimes = total - cur

	if leftTimes < 1 then
		TipsFacade.instance:openTipWindow("提示", "今日购买次数已达上限，\n次日5点刷新免费次数和购买次数！", nil, "知道了")

		return
	end

	local content = string.format("今日没有免费次数了，确定花费%d钻购买挑战次数吗？\n每天最多可购买%d次，还能购买%d次", costNum, total, leftTimes)

	TipsFacade:openPopupCostDiamondView(costNum, content, function()
		LightKingController.instance:sendBuyTimesReq(challengeType, callback)
	end)
end

function LightKingController:showChangeSetId()
	local changeSetId = self:getShowChangeSetId()

	print("showChangeSetInTemp = " .. tostring(changeSetId))

	if checknumber(changeSetId) > 0 then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

LightKingController.instance = LightKingController.New()

return LightKingController
