-- chunkname: @modules/logic/versionactivity3_4/chg/view/ChgViewBaseContainer.lua

module("modules.logic.versionactivity3_4.chg.view.ChgViewBaseContainer", package.seeall)

local ChgViewBaseContainer = class("ChgViewBaseContainer", TaskViewBaseContainer)
local kPrefix = "Chg|"

function ChgViewBaseContainer:getPrefsKeyPrefix()
	return kPrefix .. tostring(self:actId())
end

function ChgViewBaseContainer:saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function ChgViewBaseContainer:getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

function ChgViewBaseContainer:getPrefsKeyPrefix_episodeId(episodeId)
	return self:getPrefsKeyPrefix() .. tostring(episodeId)
end

function ChgViewBaseContainer:actId()
	return (self.viewParam or nil) and (self.viewParam.actId or ChgController.instance:actId())
end

function ChgViewBaseContainer:taskType()
	return (self.viewParam or nil) and (self.viewParam.taskType or ChgController.instance:taskType())
end

function ChgViewBaseContainer:isLevelUnlock(...)
	return ChgSysModel.instance:isLevelUnlock(...)
end

function ChgViewBaseContainer:isLevelPass(...)
	return ChgSysModel.instance:isLevelPass(...)
end

function ChgViewBaseContainer:currentEpisodeIdToPlay(...)
	return ChgSysModel.instance:currentEpisodeIdToPlay(...)
end

function ChgViewBaseContainer:getStoryLevelList(...)
	return ChgConfig.instance:getStoryLevelList(...)
end

function ChgViewBaseContainer:getElementCo(...)
	return ChgConfig.instance:getElementCo(...)
end

function ChgViewBaseContainer:getElementCoByEpisodeId(...)
	return ChgConfig.instance:getElementCoByEpisodeId(...)
end

function ChgViewBaseContainer:getActivityCo()
	return ActivityConfig.instance:getActivityCo(self:actId())
end

function ChgViewBaseContainer:addRedDot_V1a6RoleActivityTask(goReddot)
	return RedDotController.instance:addRedDot(goReddot, RedDotEnum.DotNode.V1a6RoleActivityTask, self:actId())
end

function ChgViewBaseContainer:startBlock(timeout, key)
	UIBlockHelper.instance:startBlock(key or self.viewName, timeout or 3)
end

function ChgViewBaseContainer:endBlock(key)
	UIBlockHelper.instance:endBlock(key or self.viewName)
end

function ChgViewBaseContainer:startBlockSlient(timeout, key)
	UIBlockMgrExtend.setNeedCircleMv(false)
	self:startBlock(timeout, key)
end

function ChgViewBaseContainer:endBlockSlient(key)
	self:endBlock(key)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function ChgViewBaseContainer:simpleLockScreen(bLock)
	if bLock then
		self:startBlockSlient()
	else
		self:endBlockSlient()
	end
end

function ChgViewBaseContainer:showV3a4_Chg_GameStartView(title, desc)
	local viewParam = {
		title = title or "",
		desc = desc or ""
	}

	ChgController.instance:showV3a4_Chg_GameStartView(viewParam)
end

function ChgViewBaseContainer:showV3a4_Chg_ResultView()
	local viewParam = {}

	ChgController.instance:showV3a4_Chg_ResultView(viewParam)
end

function ChgViewBaseContainer:setSprite(img, name, bSetNativeSize)
	UISpriteSetMgr.instance:setV3a4ChgSprite(img, name, bSetNativeSize)
end

function ChgViewBaseContainer:onContainerDestroy()
	UIBlockMgrExtend.setNeedCircleMv(true)
	ChgViewBaseContainer.super.onContainerDestroy(self)
end

function ChgViewBaseContainer:trackReset()
	ChgBattleModel.instance:track_act_chengheguang_operation(ChgEnum.OperationType.Reset)
end

function ChgViewBaseContainer:trackFailReset()
	ChgBattleModel.instance:track_act_chengheguang_operation(ChgEnum.OperationType.FailReset)
end

function ChgViewBaseContainer:trackExit()
	ChgBattleModel.instance:track_act_chengheguang_operation(ChgEnum.OperationType.Exit)
end

function ChgViewBaseContainer:trackFailExit()
	ChgBattleModel.instance:track_act_chengheguang_operation(ChgEnum.OperationType.FailExit)
end

function ChgViewBaseContainer:trackFinishRound(IsWin)
	local IsFirst = false

	ChgBattleModel.instance:track_act_chengheguang_operation(ChgEnum.OperationType.FinishRound, IsFirst, IsWin)
end

function ChgViewBaseContainer:trackPass(IsFirst)
	local IsWin = true

	ChgBattleModel.instance:track_act_chengheguang_operation(ChgEnum.OperationType.Pass, IsFirst, IsWin)
end

return ChgViewBaseContainer
