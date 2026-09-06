-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/FreeskinwelfareView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.FreeskinwelfareView", package.seeall)

local FreeskinwelfareView = class("FreeskinwelfareView", SummarySubTabView)

function FreeskinwelfareView:ctor()
	FreeskinwelfareView.super.ctor(self)
end

function FreeskinwelfareView:unbindEvents()
	FreeskinwelfareView.super.unbindEvents(self)
end

function FreeskinwelfareView:bindEvents()
	FreeskinwelfareView.super.bindEvents(self)
end

function FreeskinwelfareView:buildUI()
	FreeskinwelfareView.super.buildUI(self)

	self.con = self:getGo("con")
end

function FreeskinwelfareView:onExit()
	FreeskinwelfareView.super.onExit(self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function FreeskinwelfareView:onEnter()
	FreeskinwelfareView.super.onEnter(self)
end

function FreeskinwelfareView:buildBtnJump()
	for _, cfg in pairs(self._cfgs) do
		self.btnJump[cfg.id] = self:getGo("btnGoto")
	end
end

return FreeskinwelfareView
