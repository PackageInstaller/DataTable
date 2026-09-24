-- chunkname: @modules/logic/versionactivity4_0/concertlimit/define/ActFlipEvent.lua

module("modules.logic.versionactivity4_0.concertlimit.define.ActFlipEvent", package.seeall)

local ActFlipEvent = _M

ActFlipEvent.RewardInfoChanged = GameUtil.getUniqueTb()
ActFlipEvent.RewardBonusGet = GameUtil.getUniqueTb()
ActFlipEvent.RewardBonusGetShowFinished = GameUtil.getUniqueTb()
ActFlipEvent.GetAllTaskReward = GameUtil.getUniqueTb()
ActFlipEvent.ShowOtherBlockGetBigRewardGet = GameUtil.getUniqueTb()
ActFlipEvent.ShowAutoChangeCard = GameUtil.getUniqueTb()

return ActFlipEvent
