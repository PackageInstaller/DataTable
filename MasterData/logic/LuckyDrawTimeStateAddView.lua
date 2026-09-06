-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckyDrawTimeStateAddView.lua

module("logic.extensions.luckydraw.view.LuckyDrawTimeStateAddView", package.seeall)

local LuckyDrawTimeStateAddView = class("LuckyDrawTimeStateAddView", LuckyDrawTimeStateView)

function LuckyDrawTimeStateAddView:dealWithActIdAndRDId()
	local curActId = checkint(self:getFirstParam())

	LuckyDrawController.instance:refreshActivtyId(curActId)
	LuckyDrawController.instance:resetLuckDrawTimeStateAddRedPoint()
end

function LuckyDrawTimeStateAddView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "luckydrawtimestateaddrule")
end

function LuckyDrawTimeStateAddView:_onClickTipMin()
	UIStateManager.instance:push(ViewName.RulesView, "luckydrawtimestateminaddrule")
end

return LuckyDrawTimeStateAddView
