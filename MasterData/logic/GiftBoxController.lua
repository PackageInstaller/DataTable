-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/controller/GiftBoxController.lua

module("logic.extensions.giftbox.controller.GiftBoxController", package.seeall)

local GiftBoxController = class("GiftBoxController", BaseController)

function GiftBoxController:ctor()
	return
end

function GiftBoxController:handleGB_GiftBoxGetInfoRes(status, msg)
	GiftBoxModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handleGB_GiftBoxGetInfoRes)

	if self._needGainLuck == true then
		self:_handleGainLuckByCache()

		self._needGainLuck = nil
	end
end

function GiftBoxController:handleGB_GiftBoxOpenBoxRes(status, msg)
	GiftBoxModel.instance:setBoxOpen(msg)

	if msg.incScore > 0 then
		local actCfg = GiftBoxConfig.instance:getActCfgById(msg.actId)

		if actCfg.scoreFakeItem then
			local matType, matId, matNum = MaterialMgr.getMatParams(actCfg.scoreFakeItem)
			local matInfo = {
				{
					items = {
						{
							id = matId,
							num = msg.incScore
						},
						materialType = matType
					}
				}
			}

			MaterialModel.instance:addChangeSetItems(msg.changeSetId, matInfo)
		end
	end

	if self:isCanShareLuck(msg.actId) == true and not GiftBoxModel.instance:getFirstGainMaxLuck(msg.actId) then
		UIStateManager.instance:push(ViewName.GiftBoxHighLuckTipView)
		GiftBoxModel.instance:saveFirstGainMaxLuck(msg.actId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handleGB_GiftBoxOpenBoxRes)
end

function GiftBoxController:handleGB_GiftBoxShareLuckRes(status, msg)
	FloatWordMgr.instance:show(lang("分享成功"))
	GlobalDispatcher:dispatch(GlobalNotify.handleGB_GiftBoxShareLuckRes)
end

function GiftBoxController:handleGB_GiftBoxGainLuckRes(status, msg)
	if status == 0 then
		local incScore = 0

		if msg.incScore > 0 then
			local actCfg = GiftBoxConfig.instance:getActCfgById(msg.actId)

			incScore = actCfg.scoreMaxLimit < GiftBoxModel.instance:getScore() + msg.incScore and actCfg.scoreMaxLimit - GiftBoxModel.instance:getScore() or msg.incScore

			if actCfg.scoreFakeItem then
				local matType, matId, matNum = MaterialMgr.getMatParams(actCfg.scoreFakeItem)

				matNum = incScore
			end
		end

		GiftBoxModel.instance:setGainLuck(msg, incScore)

		if self:isCanShareLuck(msg.actId) == true and not GiftBoxModel.instance:getFirstGainMaxLuck(msg.actId) then
			UIStateManager.instance:push(ViewName.GiftBoxHighLuckTipView)
			GiftBoxModel.instance:saveFirstGainMaxLuck(msg.actId)
		end

		UIStateManager.instance:push(ViewName.GiftBoxGetLuckView, true, incScore)
		GiftBoxModel.instance:addGainPlayerId(msg.targetId)
	else
		UIStateManager.instance:push(ViewName.GiftBoxGetLuckView, false, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handleGB_GiftBoxGainLuckRes)
end

function GiftBoxController:handleGB_GiftBoxShareListRes(status, msg)
	GiftBoxModel.instance:setShareList(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handleGB_GiftBoxShareListRes)
end

function GiftBoxController:handleGB_GiftBoxGainSharePrizeRes(status, msg)
	GiftBoxModel.instance:setSharePrize(msg.prizeId)
	GlobalDispatcher:dispatch(GlobalNotify.handleGB_GiftBoxGainSharePrizeRes)
end

function GiftBoxController:isCanShareLuck(actId)
	local actCfg = GiftBoxConfig.instance:getActCfgById(actId)
	local isEnough = GiftBoxModel.instance:getMaxScore() >= actCfg.scoreMaxLimit
	local boxCfgs = GiftBoxConfig.instance:getBoxTypeCfgs(actId)
	local maxBoxType = actCfg.superBoxType
	local boxCfg = GiftBoxConfig.instance:getBoxTypeCfg(maxBoxType)
	local superPrezeInfo = GiftBoxModel.instance:getSuperPrizeInfo()

	if not superPrezeInfo then
		return false
	end

	local superPrizeCfg = GiftBoxConfig.instance:getSuperPrizeCfg(boxCfg.superPrizePlanId)
	local gainMaxSuperCount = 0

	for i, v in ipairs(superPrizeCfg) do
		if superPrezeInfo[maxBoxType] and superPrezeInfo[maxBoxType][v.prizeId] then
			gainMaxSuperCount = gainMaxSuperCount + 1

			break
		end
	end

	return isEnough == true and gainMaxSuperCount >= actCfg.shareNeedCount
end

function GiftBoxController:handleGainLuckByChat(activityId, uesrId)
	local inInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.GiftBox, activityId)

	if inInTime == true then
		self._tempActivityId = activityId
		self._tempUesrId = uesrId

		if GiftBoxModel:getIsInit() == true then
			self:_handleGainLuckByCache()
		else
			self._needGainLuck = true

			GiftBoxAgent:sendGB_GiftBoxGetInfoReq(activityId)
		end
	else
		FloatWordMgr.instance:show(lang("不在活动时间内"))
	end
end

function GiftBoxController:_handleGainLuckByCache()
	if self._tempActivityId and self._tempUesrId and GiftBoxModel.instance:getIsInit() == true then
		local actCfg = GiftBoxConfig.instance:getActCfgById(self._tempActivityId)
		local isEnough = GiftBoxModel.instance:getMaxScore() >= actCfg.scoreMaxLimit

		if GiftBoxModel.instance:getMaxScore() >= actCfg.scoreMaxLimit then
			FloatWordMgr.instance:show(lang("欧气值已满"))
		elseif actCfg.dailyTimes <= GiftBoxModel.instance:getGainLuckTimes() then
			FloatWordMgr.instance:show(lang("今日沾欧气次数已用完，明天再来吧~"))
		elseif GiftBoxModel.instance:isExistGainLuckUserId(self._tempUesrId) == true then
			UIStateManager.instance:push(ViewName.GiftBoxGetLuckView, false, -36)
		else
			GiftBoxAgent.instance:sendGB_GiftBoxGainLuckReq(self._tempActivityId, self._tempUesrId)
		end
	end

	self._tempActivityId = nil
	self._tempUesrId = nil
end

GiftBoxController.instance = GiftBoxController.New()

return GiftBoxController
