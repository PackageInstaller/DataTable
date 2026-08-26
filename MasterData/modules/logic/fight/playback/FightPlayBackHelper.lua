-- chunkname: @modules/logic/fight/playback/FightPlayBackHelper.lua

module("modules.logic.fight.playback.FightPlayBackHelper", package.seeall)

local FightPlayBackHelper = _M

function FightPlayBackHelper.startRecordFightData(paramStr, delimiter, isNumber)
	if isNumber then
		return FightStrUtil.instance:getSplitToNumberCache(paramStr, delimiter)
	else
		return FightStrUtil.instance:getSplitCache(paramStr, delimiter)
	end
end

return FightPlayBackHelper
