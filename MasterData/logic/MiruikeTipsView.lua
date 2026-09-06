-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miruikeintroduce/view/MiruikeTipsView.lua

module("logic.extensions.miruikeintroduce.view.MiruikeTipsView", package.seeall)

local MiruikeTipsView = class("MiruikeTipsView", ViewComponent)

function MiruikeTipsView:ctor()
	MiruikeTipsView.super.ctor(self)
end

function MiruikeTipsView.showInternal()
	if MiruikeIntroduceConfig.isH5Online then
		UIStateManager.instance:push(ViewName.MiruikeTipsView)
	else
		FloatWordMgr.instance:show(lang("奥奇传说页游签到活动将在4月15日5点开启"))
	end
end

function MiruikeTipsView:unbindEvents()
	MiruikeTipsView.super.unbindEvents(self)
end

function MiruikeTipsView:bindEvents()
	MiruikeTipsView.super.bindEvents(self)
end

function MiruikeTipsView:buildUI()
	MiruikeTipsView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnJump = self:getBtn("btnJump")
	self._link = MiruikeIntroduceConfig.instance:getCommonValue("H5_URL")
end

function MiruikeTipsView:onExit()
	MiruikeTipsView.super.onExit(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnJump)
end

function MiruikeTipsView:onEnter()
	MiruikeTipsView.super.onEnter(self)
	GameUtil.addClickHandler(self._btnClose, GameUtil.handler(self.close, self))
	GameUtil.addClickHandler(self._btnJump, GameUtil.handler(self._onClickJump, self))
end

function MiruikeTipsView:_onClickJump()
	self:close()
	SurveyController.instance:reportBehavior(200928)
end

return MiruikeTipsView
