-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/view/DivinexiunuoresultlView.lua

module("logic.extensions.divinexiunuo.view.DivinexiunuoresultlView", package.seeall)

local DivinexiunuoresultlView = class("DivinexiunuoresultlView", ViewComponent)

function DivinexiunuoresultlView:ctor()
	DivinexiunuoresultlView.super.ctor(self)
end

function DivinexiunuoresultlView:unbindEvents()
	DivinexiunuoresultlView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnOk)
end

function DivinexiunuoresultlView:bindEvents()
	DivinexiunuoresultlView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOK, self)
end

function DivinexiunuoresultlView:buildUI()
	DivinexiunuoresultlView.super.buildUI(self)

	self._btnOk = self:getGo("btnOk")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)
end

function DivinexiunuoresultlView:onExit()
	DivinexiunuoresultlView.super.onExit(self)
	self._scrollList:dispose()
end

function DivinexiunuoresultlView:onEnter()
	DivinexiunuoresultlView.super.onEnter(self)

	local pb = self:getFirstParam()

	if pb == nil then
		self:close()
	elseif not pb.petFightInfo then
		local petFightInfo = {}

		self._scrollList:reloadData(petFightInfo)
	end
end

function DivinexiunuoresultlView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local lock = goutil.findChild(cell, "lock")
	local txt_1 = goutil.findChildTextComponent(cell, "txt_1")
	local txt_2 = goutil.findChildTextComponent(cell, "txt_2")

	MaterialMgr.setCell(MatType.Pet, data.race, con)
	GameUtil.SetActive(lock, data.locked)

	txt_1.text = checknumber(data.lightCount)
	txt_2.text = checknumber(data.darkCount)
end

function DivinexiunuoresultlView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function DivinexiunuoresultlView:_onClickOK()
	BattleController.instance:endBattle()
	self:close()
end

return DivinexiunuoresultlView
