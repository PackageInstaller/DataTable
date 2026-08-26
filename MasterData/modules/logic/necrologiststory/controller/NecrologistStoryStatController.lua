-- chunkname: @modules/logic/necrologiststory/controller/NecrologistStoryStatController.lua

module("modules.logic.necrologiststory.controller.NecrologistStoryStatController", package.seeall)

local NecrologistStoryStatController = class("NecrologistStoryStatController")

function NecrologistStoryStatController:startGameStat()
	self.startGameTime = ServerTime.now()
end

function NecrologistStoryStatController:startStoryStat()
	self.startStoryTime = ServerTime.now()
end

function NecrologistStoryStatController:statStoryEnd(param)
	self:_statStoryEnd(param, StatEnum.Result.Completion)
end

function NecrologistStoryStatController:statStoryInterrupt(param)
	self:_statStoryEnd(param, StatEnum.Result.Abort)
end

function NecrologistStoryStatController:_statStoryEnd(param, result)
	if not self.startStoryTime then
		return
	end

	local heroStoryId = param.heroStoryId
	local config = RoleStoryConfig.instance:getStoryById(heroStoryId)

	if not config then
		return
	end

	StatController.instance:track(StatEnum.EventName.NecrologistStoryEnd, {
		[StatEnum.EventProperties.HeroStoryId] = tostring(heroStoryId),
		[StatEnum.EventProperties.HeroStoryQueryVersion] = config.queryVersion,
		[StatEnum.EventProperties.HeroStoryPlotGroup] = tostring(param.plotGroup),
		[StatEnum.EventProperties.HeroStoryResult] = StatEnum.Result2Cn[result],
		[StatEnum.EventProperties.HeroStoryTime] = ServerTime.now() - self.startStoryTime,
		[StatEnum.EventProperties.HeroStorySkipNum] = param.skipNum,
		[StatEnum.EventProperties.HeroStoryLastText] = param.lastText,
		[StatEnum.EventProperties.HeroStoryEntrance] = param.entrance
	})

	self.startStoryTime = nil
end

function NecrologistStoryStatController:statStorySkip(param)
	local heroStoryId = param.heroStoryId
	local config = RoleStoryConfig.instance:getStoryById(heroStoryId)

	if not config then
		return
	end

	StatController.instance:track(StatEnum.EventName.NecrologistStorySkip, {
		[StatEnum.EventProperties.HeroStoryId] = tostring(heroStoryId),
		[StatEnum.EventProperties.HeroStoryQueryVersion] = config.queryVersion,
		[StatEnum.EventProperties.HeroStoryPlotGroup] = tostring(param.plotGroup),
		[StatEnum.EventProperties.HeroStoryLastText] = param.lastText,
		[StatEnum.EventProperties.HeroStoryEntrance] = param.entrance
	})
end

function NecrologistStoryStatController:statStorySettlement(param, result)
	if not self.startGameTime then
		return
	end

	local heroStoryId = param.heroStoryId
	local config = RoleStoryConfig.instance:getStoryById(heroStoryId)

	if not config then
		return
	end

	StatController.instance:track(StatEnum.EventName.NecrologistStorySettlement, {
		[StatEnum.EventProperties.HeroStoryId] = tostring(heroStoryId),
		[StatEnum.EventProperties.HeroStoryQueryVersion] = config.queryVersion,
		[StatEnum.EventProperties.HeroStoryResult] = StatEnum.Result2Cn[result],
		[StatEnum.EventProperties.HeroStoryUseTime] = ServerTime.now() - self.startGameTime,
		[StatEnum.EventProperties.HeroStoryStrongHold] = tostring(param.baseId),
		[StatEnum.EventProperties.HeroStoryStrongTime] = param.time
	})

	self.startGameTime = nil
end

NecrologistStoryStatController.instance = NecrologistStoryStatController.New()

return NecrologistStoryStatController
