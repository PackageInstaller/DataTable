-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindiyiming/view/OriginDiYiMingLevelsView.lua

module("logic.extensions.origindiyiming.view.OriginDiYiMingLevelsView", package.seeall)

local OriginDiYiMingLevelsView = class("OriginDiYiMingLevelsView", InfinfulevelsView)

function OriginDiYiMingLevelsView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "origin_diyiming_clg_rule")
end

function OriginDiYiMingLevelsView:_onClickReward()
	UIStateManager.instance:push(ViewName.InfinitefuturepopView, 2, self.curActId, "查看奖励")
end

return OriginDiYiMingLevelsView
