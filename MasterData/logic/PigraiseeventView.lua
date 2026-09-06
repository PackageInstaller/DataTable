-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigraiseeventView.lua

module("logic.extensions.pigraise.view.PigraiseeventView", package.seeall)

local PigraiseeventView = class("PigraiseeventView", ViewComponent)

function PigraiseeventView:ctor()
	PigraiseeventView.super.ctor(self)
end

function PigraiseeventView:buildUI()
	PigraiseeventView.super.buildUI(self)

	self._pig = self:getGo("BG/pig")
	self._btnTake = self:getBtn("BG/btnTake")
	self._txtEventDesc = goutil.findChildTextComponent(self.mainGO, "BG/txtEventDesc")
	self._prizeList = {}

	for i = 1, 4 do
		self._prizeList[i] = self:getGo("BG/prizeList/" .. i)
	end
end

function PigraiseeventView:bindEvents()
	PigraiseeventView.super.bindEvents(self)
	self._btnTake:AddClickListener(self._onClickBtnTake, self)
end

function PigraiseeventView:unbindEvents()
	PigraiseeventView.super.unbindEvents(self)
	self._btnTake:RemoveClickListener()
end

function PigraiseeventView:destroyUI()
	PigraiseeventView.super.destroyUI(self)
end

function PigraiseeventView:onEnter()
	PigraiseeventView.super.onEnter(self)
	PigraiseModelMgr.instance:pushViewWithModel(self._pig, self._viewPresentor.viewName, 0.6, 210)

	self._eventCfg = self:getFirstParam()
	self._txtEventDesc.text = self._eventCfg.desc

	self:_updatePrizeItems(self._eventCfg.prize)
end

function PigraiseeventView:onEnterFinished()
	PigraiseeventView.super.onEnterFinished(self)
end

function PigraiseeventView:onExit()
	PigraiseeventView.super.onExit(self)
	PigraiseModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
end

function PigraiseeventView:onExitFinished()
	PigraiseeventView.super.onExitFinished(self)
end

function PigraiseeventView:_onClickBtnTake()
	if self._eventCfg.icon then
		PigraiseController.instance:processFeedBackReq()
	else
		PigraiseController.instance:showCI()
	end

	self:close()
end

function PigraiseeventView:_updatePrizeItems(itemStr)
	local t = string.split(itemStr, "#")

	for i = 1, 4 do
		goutil.setActive(self._prizeList[i], i <= #t)

		if i <= #t then
			MaterialMgr.setCellByCfg(t[i], self._prizeList[i])
		end
	end
end

return PigraiseeventView
