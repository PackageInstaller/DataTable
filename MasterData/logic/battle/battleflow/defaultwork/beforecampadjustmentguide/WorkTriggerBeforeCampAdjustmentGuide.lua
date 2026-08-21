-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/beforecampadjustmentguide/WorkTriggerBeforeCampAdjustmentGuide.lua

module("logic.battle.battleflow.defaultwork.beforecampadjustmentguide.WorkTriggerBeforeCampAdjustmentGuide", package.seeall)

local WorkTriggerBeforeCampAdjustmentGuide = class("WorkTriggerBeforeCampAdjustmentGuide", WorkBase)

function WorkTriggerBeforeCampAdjustmentGuide:onEnter(context)
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if not dungeonCode then
		self:onDone(WorkResult.Succeed)

		return
	end

	BattleDispatcher:dispatchEvent(BattleEventType.OnBeforeCampAdjustmentGuide, dungeonCode)

	if not self:isInBeforeCampAdjustmentGuide() then
		self:onDone(WorkResult.Succeed)

		return
	end

	self:_setupEnvironmentForGuide()
	self:onDone(WorkResult.Succeed)
end

function WorkTriggerBeforeCampAdjustmentGuide:onExit(isInterrupt)
	VirtualCameraMgr.instance:resetBlendDuration()
end

function WorkTriggerBeforeCampAdjustmentGuide:_setupEnvironmentForGuide()
	BattleDispatcher:dispatchEvent(BattleEventType.OnEnableCullingChanged, true)
	BattleCampAdjustmentModel.instance:setBeforeCampAdjustmentGuideTriggerred(true)
	VirtualCameraMgr.instance:setBlendDuration(0)
	VirtualCameraMgr.instance:releaseTemporaryCamera(BattleConst.START_CAMERA_CODE)
end

function WorkTriggerBeforeCampAdjustmentGuide:isInBeforeCampAdjustmentGuide()
	if not GuideController.instance:isGuiding() then
		return false
	end

	local guideId = GuideController.instance:getCurGuideId()
	local guideCO = GuideConfig.instance:getGuideCO(guideId)

	if not guideCO then
		return false
	end

	return guideCO.triggerType == GuideEnum.TriggerType.BeforeCampAdjustment
end

return WorkTriggerBeforeCampAdjustmentGuide
