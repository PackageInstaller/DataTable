-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchSelectView.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchSelectView", package.seeall)

local TianYanMatchSelectView = class("TianYanMatchSelectView", ViewComponent)

function TianYanMatchSelectView:ctor()
	TianYanMatchSelectView.super.ctor(self)
end

function TianYanMatchSelectView:unbindEvents()
	TianYanMatchSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
end

function TianYanMatchSelectView:bindEvents()
	TianYanMatchSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TianYanMatchSelectView:buildUI()
	TianYanMatchSelectView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function TianYanMatchSelectView:onExit()
	TianYanMatchSelectView.super.onExit(self)
end

function TianYanMatchSelectView:onEnter()
	TianYanMatchSelectView.super.onEnter(self)

	local param = self:getOpenParam()

	self._activityId = checknumber(param[1])
	self._isMatchToy = checkbool(param[2])
	self._selectDataList = param[3]
	self._curSelect = self._selectDataList and self._selectDataList[1].toyId or 0

	self:_refreshView()
end

function TianYanMatchSelectView:_refreshView()
	if self._selectDataList then
		self._tableList:reloadData(self._selectDataList)
	else
		self._tableList:reloadData({})
	end
end

function TianYanMatchSelectView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "title/txtName")
	local img = goutil.findChild(go, "img")
	local select = goutil.findChild(go, "select")

	uGuiUtil.clearImage(img)
	uGuiUtil.setSpriteToImage(img, nil, data.res)

	txtName.text = data.desc

	GameUtil.SetActive(select, self._curSelect == data.toyId)
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickToy(data.toyId)
	end)
end

function TianYanMatchSelectView:_clearCell(cell)
	local go = cell.gameObject
	local img = goutil.findChild(go, "img")

	uGuiUtil.clearImage(img)
	GameUtil.rmClickHandler(go)
end

function TianYanMatchSelectView:_onClickToy(toyId)
	self._curSelect = toyId

	self:_refreshView()
end

function TianYanMatchSelectView:_onClickSure()
	GlobalDispatcher:dispatch(GlobalNotify.TianYanMatchSelectToy, self._curSelect, self._isMatchToy)
	self:close()
end

return TianYanMatchSelectView
