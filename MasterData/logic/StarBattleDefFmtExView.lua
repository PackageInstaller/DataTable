-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleDefFmtExView.lua

module("logic.extensions.starbattle.view.StarBattleDefFmtExView", package.seeall)

local StarBattleDefFmtExView = class("StarBattleDefFmtExView", ViewComponent)

function StarBattleDefFmtExView:ctor()
	StarBattleDefFmtExView.super.ctor(self)
end

function StarBattleDefFmtExView:unbindEvents()
	StarBattleDefFmtExView.super.unbindEvents(self)
end

function StarBattleDefFmtExView:bindEvents()
	StarBattleDefFmtExView.super.bindEvents(self)
end

function StarBattleDefFmtExView:buildUI()
	StarBattleDefFmtExView.super.buildUI(self)

	self._txtTips = self:getTxt("txtTips")
	self._bg = self:getGo("bg")
end

function StarBattleDefFmtExView:onExit()
	StarBattleDefFmtExView.super.onExit(self)
end

function StarBattleDefFmtExView:onEnter()
	StarBattleDefFmtExView.super.onEnter(self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]
	self._txtTips.text = ""
	self._txtTips.text = self.customFmtMo.addShowTips

	local isEmptyStr = GameUtil.isEmptyString(self.customFmtMo.addShowTips)

	goutil.setActive(self._bg, not isEmptyStr)
end

return StarBattleDefFmtExView
