-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/controller/WuErLiXiHelper.lua

module("modules.logic.versionactivity2_4.wuerlixi.controller.WuErLiXiHelper", package.seeall)

local WuErLiXiHelper = class("WuErLiXiHelper")

function WuErLiXiHelper.getUnitSpriteName(unitType, state)
	local tag = state and 2 or 1

	if unitType == WuErLiXiEnum.UnitType.SignalEnd or unitType == WuErLiXiEnum.UnitType.Obstacle or unitType == WuErLiXiEnum.UnitType.Key then
		return string.format("v2a4_wuerlixi_unit_icon%s_%s", unitType, tag)
	end

	return string.format("v2a4_wuerlixi_unit_icon%s", unitType)
end

function WuErLiXiHelper.getLimitTimeStr()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity2_4Enum.ActivityId.WuErLiXi)

	if not actInfoMo then
		return ""
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		return TimeUtil.SecondToActivityTimeFormat(offsetSecond)
	end

	return ""
end

function WuErLiXiHelper.getOppositeDir(dir)
	return math.abs((2 + dir) % 4)
end

function WuErLiXiHelper.getNextDir(dir)
	return (dir + 1) % 4
end

function WuErLiXiHelper.getPreDir(dir)
	return (4 + dir - 1) % 4
end

return WuErLiXiHelper
