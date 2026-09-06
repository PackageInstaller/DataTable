-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miukechallenge/view/MiukellevelsView.lua

module("logic.extensions.miukechallenge.view.MiukellevelsView", package.seeall)

local MiukellevelsView = class("MiukellevelsView", InfinfulevelsView)

function MiukellevelsView:buildUI()
	MiukellevelsView.super.buildUI(self)

	self._singleLine = self:getGo("levels"):GetComponent(ComponentType.UILayoutSingleLine)
end

function MiukellevelsView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "miukelevels_rule")
end

function MiukellevelsView:_onClickReward()
	UIStateManager.instance:push(ViewName.MiukepopView, 2, self.curActId, "缪可奖励")
end

function MiukellevelsView:onRefreshUI()
	MiukellevelsView.super.onRefreshUI(self)
	self._singleLine:Layout()
end

return MiukellevelsView
