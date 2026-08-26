-- chunkname: @modules/logic/sp01/assassinChase/helper/AssassinChaseHelper.lua

module("modules.logic.sp01.assassinChase.helper.AssassinChaseHelper", package.seeall)

local AssassinChaseHelper = {}

function AssassinChaseHelper.getActivityEndTimeStamp(realEndTime)
	local constConfig = AssassinChaseConfig.instance:getConstConfig(AssassinChaseEnum.ConstId.EndTime)
	local timeDurationDay = tonumber(constConfig.value)
	local timeDuration = timeDurationDay * TimeUtil.OneDaySecond

	return math.max(0, realEndTime - timeDuration)
end

return AssassinChaseHelper
