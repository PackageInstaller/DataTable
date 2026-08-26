-- chunkname: @modules/logic/versionactivity3_7/wmz/view/WmzViewBaseContainer.lua

module("modules.logic.versionactivity3_7.wmz.view.WmzViewBaseContainer", package.seeall)

local WmzViewBaseContainer = class("WmzViewBaseContainer", TaskViewBaseContainer)
local kPrefix = "Wmz|"

function WmzViewBaseContainer:getPrefsKeyPrefix()
	return kPrefix .. tostring(self:actId())
end

function WmzViewBaseContainer:saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function WmzViewBaseContainer:getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

function WmzViewBaseContainer:getPrefsKeyPrefix_episodeId(episodeId)
	return self:getPrefsKeyPrefix() .. tostring(episodeId)
end

function WmzViewBaseContainer:actId()
	return (self.viewParam or nil) and (self.viewParam.actId or WmzController.instance:actId())
end

function WmzViewBaseContainer:taskType()
	return (self.viewParam or nil) and (self.viewParam.taskType or WmzController.instance:taskType())
end

function WmzViewBaseContainer:addRedDot_Activity220Task(goReddot)
	return RedDotController.instance:addRedDot(goReddot, RedDotEnum.DotNode.Activity220Task, self:actId())
end

function WmzViewBaseContainer:setSprite(img, spriteName, bSetNativeSize)
	UISpriteSetMgr.instance:setV3a7WmzSprite(img, spriteName, bSetNativeSize)
end

function WmzViewBaseContainer:onContainerDestroy()
	WmzViewBaseContainer.super.onContainerDestroy(self)
end

function WmzViewBaseContainer:restart(...)
	return WmzController.instance:restart(...)
end

function WmzViewBaseContainer:startSimpleGameFlow(...)
	return WmzController.instance:startSimpleGameFlow(...)
end

function WmzViewBaseContainer:setOnPreHookGamePreStory(...)
	WmzController.instance:setOnPreHookGamePreStory(...)
end

function WmzViewBaseContainer:setOnPostHookGamePreStory(...)
	WmzController.instance:setOnPostHookGamePreStory(...)
end

function WmzViewBaseContainer:setOnPreHookRestartGame(...)
	WmzController.instance:setOnPreHookRestartGame(...)
end

function WmzViewBaseContainer:setOnPostHookRestartGame(...)
	WmzController.instance:setOnPostHookRestartGame(...)
end

function WmzViewBaseContainer:setOnPreHookGamePostStory(...)
	WmzController.instance:setOnPreHookGamePostStory(...)
end

function WmzViewBaseContainer:setOnPostHookGamePostStory(...)
	WmzController.instance:setOnPostHookGamePostStory(...)
end

function WmzViewBaseContainer:bHasGame(...)
	return WmzController.instance:configInst():bHasGame(...)
end

function WmzViewBaseContainer:getEpisodeConfig(...)
	return WmzController.instance:configInst():getEpisodeConfig(...)
end

function WmzViewBaseContainer:getEpisodeConfigList(...)
	return WmzController.instance:configInst():getEpisodeConfigList(...)
end

function WmzViewBaseContainer:getActivity220MO(...)
	return WmzController.instance:systemInst():getActivity220MO(...)
end

function WmzViewBaseContainer:getNewFinishEpisode(...)
	return WmzController.instance:systemInst():getNewFinishEpisode(...)
end

function WmzViewBaseContainer:clearFinishEpisode(...)
	return WmzController.instance:systemInst():clearFinishEpisode(...)
end

function WmzViewBaseContainer:getMaxUnlockEpisodeId(...)
	return WmzController.instance:systemInst():getMaxUnlockEpisodeId(...)
end

function WmzViewBaseContainer:isEpisodeUnlock(...)
	return WmzController.instance:systemInst():isEpisodeUnlock(...)
end

function WmzViewBaseContainer:isEpisodePass(...)
	return WmzController.instance:systemInst():isEpisodePass(...)
end

local kActFirstEnter = "ActFirstEnter"

function WmzViewBaseContainer:_getPrefsKeyPrefix_ActFirstEnter()
	return self:getPrefsKeyPrefix() .. kActFirstEnter .. self:actId()
end

function WmzViewBaseContainer:getIsActFirstEnter()
	local key = self:_getPrefsKeyPrefix_ActFirstEnter()

	return self:getInt(key, 0) == 1
end

function WmzViewBaseContainer:setIsActFirstEnter(isFirst)
	local key = self:_getPrefsKeyPrefix_ActFirstEnter()

	self:saveInt(key, isFirst and 1 or 0)
end

function WmzViewBaseContainer:trackReset(curEnergy)
	self:trackMO():onGameReset()
	WmzBattleModel.instance:track_act_WMZ_operation(WmzEnum.OperationType.Reset, curEnergy)
end

function WmzViewBaseContainer:trackFailReset(curEnergy)
	self:trackMO():onGameReset()
	WmzBattleModel.instance:track_act_WMZ_operation(WmzEnum.OperationType.FailReset, curEnergy)
end

function WmzViewBaseContainer:trackExit(curEnergy)
	WmzBattleModel.instance:track_act_WMZ_operation(WmzEnum.OperationType.Exit, curEnergy)
end

function WmzViewBaseContainer:trackFailExit(curEnergy)
	WmzBattleModel.instance:track_act_WMZ_operation(WmzEnum.OperationType.FailExit, curEnergy)
end

function WmzViewBaseContainer:trackPass(curEnergy)
	WmzBattleModel.instance:track_act_WMZ_operation(WmzEnum.OperationType.Pass, curEnergy)
end

return WmzViewBaseContainer
