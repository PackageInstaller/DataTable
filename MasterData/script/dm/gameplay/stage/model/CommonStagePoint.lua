-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/CommonStagePoint.lua

require("dm.gameplay.stage.model.StagePoint")

CommonStagePoint = class("CommonStagePoint", StagePoint, _M)

function CommonStagePoint:initialize(pointId, type)
	assert(pointId ~= nil, "error:pointId=nil")
	super.initialize(self, pointId)

	self._status = 0
end

function CommonStagePoint:getPointType()
	return self._config.PointType
end

function CommonStagePoint:canWipeOnce()
	local needStars = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stage_Sweep_Stars", "content")

	if self:isPass() and needStars <= self:getStarCount() then
		return true
	end

	return false
end

function CommonStagePoint:getPointDetailViewName()
	if self:getPointBoard() and not self._isPass then
		return "CommonStagePointBossView"
	end

	return "stagePointDetailView"
end

function CommonStagePoint:getChallengeTimes()
	return 10000
end
