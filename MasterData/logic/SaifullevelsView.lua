-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/SaifullevelsView.lua

module("logic.extensions.infinitefuture.view.SaifullevelsView", package.seeall)

local SaifullevelsView = class("SaifullevelsView", InfinfulevelsView)

function SaifullevelsView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "saifulevels_rule")
end

function SaifullevelsView:_onClickReward()
	UIStateManager.instance:push(ViewName.InfinitefuturepopView, 2, self.curActId, "赛芙奖励")
end

return SaifullevelsView
