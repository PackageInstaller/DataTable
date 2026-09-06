-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/view/OriginXiuErExplainView.lua

module("logic.extensions.originxiuer.view.OriginXiuErExplainView", package.seeall)

local OriginXiuErExplainView = class("OriginXiuErExplainView", ViewComponent)

function OriginXiuErExplainView:ctor()
	OriginXiuErExplainView.super.ctor(self)
end

function OriginXiuErExplainView:unbindEvents()
	OriginXiuErExplainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginXiuErExplainView:bindEvents()
	OriginXiuErExplainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriginXiuErExplainView:buildUI()
	OriginXiuErExplainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tablecellUnMax = self:getGo("tableviewUnMax/tablecell")
	self._tableviewUnMax = self:getGo("tableviewUnMax")
	self._scrollListUnMax = ScrollerList.create(self._tableviewUnMax, self._tablecellUnMax, GameUtil.handler(self._updateCellUnMax, self), GameUtil.handler(self._clearCellUnMax, self))
	self._tablecellMax = self:getGo("tableviewMax/tablecell")
	self._tableviewMax = self:getGo("tableviewMax")
	self._scrollListMax = ScrollerList.create(self._tableviewMax, self._tablecellMax, GameUtil.handler(self._updateCellMax, self), GameUtil.handler(self._clearCellMax, self))
end

function OriginXiuErExplainView:onExit()
	OriginXiuErExplainView.super.onExit(self)
	self._scrollListUnMax:dispose()
	self._scrollListMax:dispose()
end

function OriginXiuErExplainView:onEnter()
	OriginXiuErExplainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 537001
	end

	self._info = OriginXiuErModel.instance:getInfo(self._activityId)
	self._actCfg = OriginXiuErConfig.instance:getActCfg(self._activityId)
	self._unLockPetList = {}
	self._lockPetList = {}
	self._lockPetList, self._unLockPetList = OriginXiuErController.instance:getLockAndUnlockPetPair(self._activityId)

	self._scrollListUnMax:reloadData(self._unLockPetList)
	self._scrollListMax:reloadData(self._lockPetList)
end

function OriginXiuErExplainView:_updateCellUnMax(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	txtNum.text = string.format("幽魂数量：%d", data.right)

	MaterialMgr.setCell(MatType.Pet, data.left, pet)
end

function OriginXiuErExplainView:_clearCellUnMax(cell)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
end

function OriginXiuErExplainView:_updateCellMax(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	txtNum.text = string.format("幽魂数量：%d", data.right)

	MaterialMgr.setCell(MatType.Pet, data.left, pet)
end

function OriginXiuErExplainView:_clearCellMax(cell)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
end

return OriginXiuErExplainView
