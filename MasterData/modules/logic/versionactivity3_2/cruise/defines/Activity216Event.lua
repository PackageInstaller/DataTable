-- chunkname: @modules/logic/versionactivity3_2/cruise/defines/Activity216Event.lua

module("modules.logic.versionactivity3_2.cruise.defines.Activity216Event", package.seeall)

local Activity216Event = _M

Activity216Event.onGetInfo = GameUtil.getUniqueTb()
Activity216Event.onFinishTask = GameUtil.getUniqueTb()
Activity216Event.onTaskInfoUpdate = GameUtil.getUniqueTb()
Activity216Event.onBonusStateChange = GameUtil.getUniqueTb()
Activity216Event.onInfoChanged = GameUtil.getUniqueTb()

return Activity216Event
