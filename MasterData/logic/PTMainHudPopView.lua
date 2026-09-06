-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/PTMainHudPopView.lua

module("logic.extensions.peaktournament.view.common.PTMainHudPopView", package.seeall)

local PTMainHudPopView = class("PTMainHudPopView", ViewComponent)

function PTMainHudPopView:buildUI()
	PTMainHudPopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnGoto = goutil.findChild(self.mainGO, "btnGoto")
end

function PTMainHudPopView:bindEvents()
	PTMainHudPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickBtnGoto, self)
end

function PTMainHudPopView:unbindEvents()
	PTMainHudPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoto)
end

function PTMainHudPopView:onEnter()
	PTMainHudPopView.super.onEnter(self)
end

function PTMainHudPopView:onExit()
	PTMainHudPopView.super.onExit(self)
end

function PTMainHudPopView:_onClickBtnGoto()
	UIStateManager.instance:clear()
	GotoMgr.gotoByString("func#729")
end

return PTMainHudPopView
