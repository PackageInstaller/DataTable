-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/triggers/WorkTriggerEnterDone.lua

module("logic.battle.battleflow.defaultwork.triggers.WorkTriggerEnterDone", package.seeall)

local WorkTriggerEnterDone = class("WorkTriggerEnterDone", WorkBase)
local kLocalSettingKey = "WorkTriggerEnterDone"

function WorkTriggerEnterDone:onEnter(context)
	context.settingModel:internal_SetupSettings()
	context.unitMgr:internal_BuildUnits()
	context:internal_NotifyComponent(BattleFunctionName.onEnterDone)
	context:handleEnterBattleFinish()
	context.preloadMgr:clearPreloadResources()

	local snapshotInfo = BattleSnapshotInfo:createInstance()

	BattleDispatcher:dispatchEvent(BattleEventType.OnBattleEnterFinish, snapshotInfo)
	snapshotInfo:returnSelf()
	WorkTriggerEnterDone:setUIPropertiesVisible(false)
	self:onDone(WorkResult.Succeed)
end

function WorkTriggerEnterDone:onExit(isInterrupt)
	return
end

function WorkTriggerEnterDone:setUIPropertiesVisible(visible)
	local dangerArea = BattleMgr.instance:getDangerArea()

	dangerArea:setVisibleByKey(visible, kLocalSettingKey)

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local units = unitMgr:getAllUnits()

	for _, unit in pairs(units) do
		if unit.property:isMaskEnable(BattleUnitFlagMask.MaskAttackable) then
			unit:setProxyVisible(visible, kLocalSettingKey)
		end
	end

	BattleCampAdjustmentModel.instance:setShowUnitUI(visible)
end

return WorkTriggerEnterDone
