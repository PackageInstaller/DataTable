-- chunkname: @modules/logic/versionactivity1_8/dungeon/controller/VersionActivity1_8StatController.lua

module("modules.logic.versionactivity1_8.dungeon.controller.VersionActivity1_8StatController", package.seeall)

local VersionActivity1_8StatController = class("VersionActivity1_8StatController")

function VersionActivity1_8StatController:startStat()
	self.startTime = ServerTime.now()
end

function VersionActivity1_8StatController:statSuccess()
	self:_statEnd(StatEnum.Result.Success)
end

function VersionActivity1_8StatController:statAbort()
	self:_statEnd(StatEnum.Result.Abort)
end

function VersionActivity1_8StatController:statReset()
	self:_statEnd(StatEnum.Result.Reset)
	self:startStat()
end

function VersionActivity1_8StatController:_statEnd(result)
	if not self.startTime then
		return
	end

	StatController.instance:track(StatEnum.EventName.FactoryConnectionGame, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - self.startTime,
		[StatEnum.EventProperties.PartsId] = tostring(Activity157RepairGameModel.instance:getCurComponentId()),
		[StatEnum.EventProperties.Result] = result
	})

	self.startTime = nil
end

VersionActivity1_8StatController.instance = VersionActivity1_8StatController.New()

return VersionActivity1_8StatController
