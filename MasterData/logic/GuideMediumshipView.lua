-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideMediumshipView.lua

module("logic.extensions.guide.view.GuideMediumshipView", package.seeall)

local GuideMediumshipView = class("GuideMediumshipView", ViewComponent)

function GuideMediumshipView:ctor()
	GuideMediumshipView.super.ctor(self)
end

function GuideMediumshipView:unbindEvents()
	GuideMediumshipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GuideMediumshipView:bindEvents()
	GuideMediumshipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GuideMediumshipView:buildUI()
	GuideMediumshipView.super.buildUI(self)

	self._btnClose = self:getTxt("btnClose")
	self._txtDesc = self:getTxt("top/desc/txt")
end

function GuideMediumshipView:onExit()
	GuideMediumshipView.super.onExit(self)
	BattleController.instance:setBattlePause(false)
	removetimer(self.close, self)
end

function GuideMediumshipView:onEnter()
	GuideMediumshipView.super.onEnter(self)
	BattleController.instance:setBattlePause(true)

	local guide = self:getFirstParam()

	if guide then
		self._txtDesc.text = guide.guide.dialogue

		local param = guide:getJsonParams()
		local autoNextTime = param.autoNextTime

		if autoNextTime and checknumber(autoNextTime) > 0 then
			settimer(checknumber(autoNextTime), self.close, self, false)
		end
	end
end

return GuideMediumshipView
