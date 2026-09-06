-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclefindtreasure/controller/MiraclefindtreasureController.lua

module("logic.extensions.miraclefindtreasure.controller.MiraclefindtreasureController", package.seeall)

local MiraclefindtreasureController = class("MiraclefindtreasureController", BaseController)

function MiraclefindtreasureController:ctor()
	return
end

function MiraclefindtreasureController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("miracle_find_treasure_map", self._enterTreasureState, self)
end

function MiraclefindtreasureController:onReset()
	return
end

function MiraclefindtreasureController:loadInfoInStartGame()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MiracleFindTreasure)

	if activityId > 0 then
		MiracleFindTreasureAgent.instance:sendPM_MiracleFindTreasureGetInfoReq(activityId)
	end
end

function MiraclefindtreasureController:useItem()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MiracleFindTreasure)

	if activityId > 0 then
		local info = MiraclefindtreasureModel.instance:getInfo(activityId)

		if not info then
			MiracleFindTreasureAgent.instance:sendPM_MiracleFindTreasureGetInfoReq(activityId)
			FloatWordMgr.instance:show("开了小差，请重试")

			return
		else
			local state = MiraclefindtreasureModel.instance:getState(activityId)

			if state ~= 0 then
				UIStateManager.instance:popByName(ViewName.MiraclefindtreasuretaskView)
				FloatWordMgr.instance:show("还有未完成挖宝任务，请先完成任务")

				return
			end

			if self:isAllPrizeGain(activityId) then
				FloatWordMgr.instance:show("目前所有奖励均已挖完")

				return
			end
		end
	else
		FloatWordMgr.instance:show("活动未开启")

		return
	end

	MiracleFindTreasureAgent.instance:sendPM_MiracleFindTreasureStartDigReq(activityId)
end

function MiraclefindtreasureController:startDigRes(msg)
	MiraclefindtreasureModel.instance:startDigRes(msg)
	self:calRedpoint()

	local targetcfg = MiraclefindtreasureModel.instance:getTargetCfg(msg.activityId)

	UIStateManager.instance:clear(true)

	if targetcfg then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		mainPlayer:gotoScenePosition(targetcfg.sceneId, targetcfg.x, targetcfg.y, function()
			UIStateManager.instance:open(ViewName.MiraclefindtreasuredigView, msg.activityId, true)
		end)
	end
end

function MiraclefindtreasureController:_enterTreasureState()
	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("当前正在护送，无法进入挖宝流程!")

		return
	end

	local activityId = MiraclefindtreasureModel.instance:getActiityId()

	if not activityId or activityId <= 0 then
		return
	end

	self:_sendGetInfoReq(activityId)
end

function MiraclefindtreasureController:_openTreasureView(activityId)
	UIStateManager.instance:push(ViewName.MiraclefindtreasureView, activityId)
end

function MiraclefindtreasureController:_sendGetInfoReq(activityId)
	self._needHandleInInfoBack = activityId > 0

	if activityId > 0 then
		MiracleFindTreasureAgent.instance:sendPM_MiracleFindTreasureGetInfoReq(activityId)
	else
		FloatWordMgr.instance:show("数据异常")
	end
end

function MiraclefindtreasureController:calRedpoint()
	local activityId = MiraclefindtreasureModel.instance:getActiityId()
	local isShowPoint = MiraclefindtreasureModel.instance:getState(activityId) ~= 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_MiracleFindTreasure, isShowPoint)
	GlobalDispatcher:dispatch(GlobalNotify.RedPointUpdate)
end

function MiraclefindtreasureController:handlePM_MiracleFindTreasureGetInfoRes(msg)
	MiraclefindtreasureModel.instance:setInfo(msg)
	MiraclefindtreasureController.instance:calRedpoint()

	if self._needHandleInInfoBack then
		self._needHandleInInfoBack = false

		self:_autoWabao()
	end
end

function MiraclefindtreasureController:_autoWabao()
	local activityId = MiraclefindtreasureModel.instance:getActiityId()
	local state = MiraclefindtreasureModel.instance:getState(activityId)

	if state == 0 then
		-- block empty
	elseif state == 1 then
		local targetcfg = MiraclefindtreasureModel.instance:getTargetCfg(activityId)

		if targetcfg then
			UIStateManager.instance:clear(true)

			local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

			mainPlayer:gotoScenePosition(targetcfg.sceneId, targetcfg.x, targetcfg.y, function()
				UIStateManager.instance:open(ViewName.MiraclefindtreasuredigView, activityId, true)
			end)
		end
	elseif state == 2 then
		self:_openTreasureView(activityId)
	else
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_MiracleFindTreasure, false)
	end
end

function MiraclefindtreasureController:handlePM_MiracleFindTreasureLotteryRes(msg)
	local activityId = msg.activityId
	local prizeInfo = msg.prizeInfo
	local changeSetId = msg.changeSetId

	MiraclefindtreasureModel.instance:updateGainPrize(activityId, prizeInfo)
	MaterialController.instance:saveChangeSetToTemp(changeSetId)
	self:calRedpoint()

	self._changeSetId = changeSetId
end

function MiraclefindtreasureController:showCI()
	if self._changeSetId and self._changeSetId > 0 then
		local changeSetId = self._changeSetId

		self._changeSetId = 0

		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function MiraclefindtreasureController:isAllPrizeGain(activityId)
	local info = MiraclefindtreasureModel.instance:getInfo(activityId)

	if not info then
		return false
	end

	local prizeCfgs = MiraclefindtreasureConfig.instance:getPrizeCfgs(activityId)
	local prizeId2GainCount = {}

	for i, v in ipairs(info.prizeInfoList) do
		prizeId2GainCount[v.prizeId] = v.gainCount
	end

	local canUse = false

	for i, v in ipairs(prizeCfgs) do
		if checknumber(prizeId2GainCount[v.prizeId]) < v.timeLimit then
			canUse = true

			break
		end
	end

	if not canUse then
		return true
	end
end

MiraclefindtreasureController.instance = MiraclefindtreasureController.New()

return MiraclefindtreasureController
