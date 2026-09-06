-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/view/EndlessPopView.lua

module("logic.extensions.endlessbattle.view.EndlessPopView", package.seeall)

local EndlessPopView = class("EndlessPopView", ViewComponent)

function EndlessPopView:unbindEvents()
	EndlessPopView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function EndlessPopView:bindEvents()
	EndlessPopView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function EndlessPopView:onExit()
	EndlessPopView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.InfiniteOneKeyRes, self._onOneKeyRes, self)
	removetimer(self._onEffPlayFinished, self)
end

function EndlessPopView:buildUI()
	EndlessPopView.super.buildUI(self)

	self._closeButton = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
	self._txtRounds = self:getTxt("txtRounds")
end

function EndlessPopView:onEnter()
	EndlessPopView.super.onEnter(self)

	local params = self:getOpenParam()

	self._sureCall = params[2]
	self._handlerObj = params[3]
	self._txtRounds.text = params[1]

	GlobalDispatcher:addListener(GlobalNotify.InfiniteOneKeyRes, self._onOneKeyRes, self)
end

function EndlessPopView:_onClickClose()
	self:close()
end

function EndlessPopView:_onClickSure()
	EndlessBattleController.instance:sendOneKeyReq()
end

function EndlessPopView:_onOneKeyRes()
	local url = "fx_ui_kuaisutongguan/fx_ui_kuaisutongguan.prefab"
	local parent = self.mainGO
	local eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, loop)

	eff:setParent(parent.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1)
	eff:setLocalEulerAngle(0, 0, 0)
	settimer(2.1, self._onEffPlayFinished, self, false)
end

function EndlessPopView:_onEffPlayFinished()
	self:close()
	GameUtil.callBack(self._sureCall, self._handlerObj)
	EndlessBattleController.instance:showCacheChangeSetId()
end

return EndlessPopView
