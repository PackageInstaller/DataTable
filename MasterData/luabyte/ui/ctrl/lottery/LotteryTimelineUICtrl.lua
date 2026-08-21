local LotteryTimelineUICtrl = BaseClass("LotteryTimelineUICtrl", BaseUICtrl)
local M = LotteryTimelineUICtrl

function M:Init()
    self._view.skip:onClick(Bind(self, self._OnClicktsSkipBtn))
end

function M:OnEnter()
end

function M:_OnClicktsSkipBtn(go)
    EventMgr:Broadcast(UIMessageNames.LOTTERY_TIMELINE_CLICKSKIP)
end

return LotteryTimelineUICtrl
