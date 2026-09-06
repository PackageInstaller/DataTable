-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/ThrowShellsResultView.lua

module("logic.extensions.throwshells.view.ThrowShellsResultView", package.seeall)

local ThrowShellsResultView = class("ThrowShellsResultView", ViewComponent)

function ThrowShellsResultView:ctor()
	ThrowShellsResultView.super.ctor(self)
end

function ThrowShellsResultView:unbindEvents()
	ThrowShellsResultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ThrowShellsResultView:bindEvents()
	ThrowShellsResultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._clickClose, self)
end

function ThrowShellsResultView:buildUI()
	ThrowShellsResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtRound = self:getTxt("round/txtRound")
	self._txtTarget = self:getTxt("target/txtTarget")
	self._goWin = self:getGo("imgResultWin")
	self._goLose = self:getGo("imgResultLoe")
end

function ThrowShellsResultView:onExit()
	ThrowShellsResultView.super.onExit(self)

	self._closeCallBack = nil
end

function ThrowShellsResultView:onEnter()
	ThrowShellsResultView.super.onEnter(self)

	local params = self:getFirstParam()
	local color = params.isPass and "#20b376" or "#eb4642"

	self._txtRound.text = params.txtRound
	self._txtTarget.text = langPara("<color=%s>目标：击败所有敌人</color>", color)

	goutil.setActive(self._goWin, params.isPass)
	goutil.setActive(self._goLose, not params.isPass)

	self._closeCallBack = params.closeCallBack
end

function ThrowShellsResultView:_clickClose()
	if self._closeCallBack then
		GameUtil.callBack(self._closeCallBack)
	end

	self:close()
end

return ThrowShellsResultView
