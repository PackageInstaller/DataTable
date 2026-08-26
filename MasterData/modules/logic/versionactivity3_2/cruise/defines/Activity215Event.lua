-- chunkname: @modules/logic/versionactivity3_2/cruise/defines/Activity215Event.lua

module("modules.logic.versionactivity3_2.cruise.defines.Activity215Event", package.seeall)

local Activity215Event = _M

Activity215Event.onGetInfo = GameUtil.getUniqueTb()
Activity215Event.onItemSubmitCountChange = GameUtil.getUniqueTb()
Activity215Event.onAcceptedRewardIdChange = GameUtil.getUniqueTb()
Activity215Event.OnInfoChanged = GameUtil.getUniqueTb()

return Activity215Event
