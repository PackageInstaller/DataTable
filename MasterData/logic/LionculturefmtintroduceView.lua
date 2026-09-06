-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LionculturefmtintroduceView.lua

module("logic.extensions.lionculture.view.LionculturefmtintroduceView", package.seeall)

local LionculturefmtintroduceView = class("LionculturefmtintroduceView", ViewComponent)

function LionculturefmtintroduceView:ctor()
	LionculturefmtintroduceView.super.ctor(self)
end

function LionculturefmtintroduceView:unbindEvents()
	LionculturefmtintroduceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function LionculturefmtintroduceView:bindEvents()
	LionculturefmtintroduceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._closeView, self)
end

function LionculturefmtintroduceView:buildUI()
	LionculturefmtintroduceView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtContent = self:getTxt("contentCol/txtscrollContent/Viewport/txtContent")
	self._tabGO = self:getGo("tabCol/tabScrollerview")
	self._tabCell = self:getGo("tabCol/tabScrollercell")
	self._tabScrollList = ScrollerList.create(self._tabGO, self._tabCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function LionculturefmtintroduceView:onExit()
	LionculturefmtintroduceView.super.onExit(self)
end

function LionculturefmtintroduceView:onEnter()
	LionculturefmtintroduceView.super.onEnter(self)

	self._tabCfg = LioncultureConfig.instance:getFmtIntroduceCfg()[1]
	self._selectIdx = 1

	self._tabScrollList:reloadData(self._tabCfg)
end

function LionculturefmtintroduceView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local imgChange = cell.gameObject:GetComponent("UIImageSpriteChange")
	local txtChange = txtName.gameObject:GetComponent("UITextColorChange")

	txtName.text = data.name

	imgChange:SetState(self._selectIdx == data.id and 1 or 0)
	txtChange:SetState(self._selectIdx == data.id and 1 or 0)

	if self._selectIdx == data.id then
		self._txtContent.text = data.desc
	end

	local function onClick()
		self._selectIdx = data.id

		self._tabScrollList:reloadData(self._tabCfg)
	end

	GameUtil.rmClickHandler(cell.gameObject)
	GameUtil.addClickHandler(cell.gameObject, onClick, self)
end

function LionculturefmtintroduceView:_clearCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function LionculturefmtintroduceView:_btnOnClick(data)
	self._txtContent.text = data.desc
end

function LionculturefmtintroduceView:_closeView()
	self:close()
end

return LionculturefmtintroduceView
