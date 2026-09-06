-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/view/ReviveElizabethFlowerView.lua

module("logic.extensions.reviveelizabeth.view.ReviveElizabethFlowerView", package.seeall)

local ReviveElizabethFlowerView = class("ReviveElizabethFlowerView", ViewComponent)

function ReviveElizabethFlowerView:ctor()
	ReviveElizabethFlowerView.super.ctor(self)
end

function ReviveElizabethFlowerView:unbindEvents()
	ReviveElizabethFlowerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function ReviveElizabethFlowerView:bindEvents()
	ReviveElizabethFlowerView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function ReviveElizabethFlowerView:buildUI()
	ReviveElizabethFlowerView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btn")

	local var_4_0 = {
		icon = self:getGo("cell/icon")
	}

	var_4_0.content = self:getGo("cell/scorllview/viewport/txt"):GetComponent("Text")
	self._cell = var_4_0
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ReviveElizabethFlowerView:onExit()
	ReviveElizabethFlowerView.super.onExit(self)
	self._scrollerList:dispose()
end

function ReviveElizabethFlowerView:onEnter()
	ReviveElizabethFlowerView.super.onEnter(self)

	local param = self:getOpenParam()

	if not param then
		FloatWordMgr.instance:show("打开页面失败~")
		self:close()

		return
	end

	self._activityId = checknumber(param[1])
	self._flowerId = checknumber(param[2])
	self._prizeId = checknumber(param[3])

	if self._activityId and self._flowerId then
		local cfg = ReviveElizabethConfig.instance:getReviveElizabethSoulOnceCfg(self._activityId, self._flowerId)

		ReviveElizabethController.instance:setSpriteToImage(self._cell.icon, ReviveElizabethController.FlowerIconFolderUrl, cfg.flowerIcon)

		self._cell.content.text = cfg.flowerContent
	end

	self._message = ReviveElizabethConfig.instance:getMessage()
	self._selectedId = -1

	self._scrollerList:reloadData(self._message)
end

function ReviveElizabethFlowerView:_updateCell(view, cell, data)
	local content = goutil.findChildTextComponent(cell, "txt")
	local btn = goutil.findChildButtonComponent(cell, "btn")
	local select = goutil.findChild(cell, "select")

	content.text = data.words

	local isSelect = data.messageId == self._selectedId

	goutil.setActive(select, isSelect)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._changeSelectMsg, self, data.messageId), self)
end

function ReviveElizabethFlowerView:_clearCell(cell)
	local select = goutil.findChild(cell, "select")
	local btn = goutil.findChildButtonComponent(cell, "btn")

	goutil.setActive(select, false)
	GameUtil.rmClickHandler(btn)
end

function ReviveElizabethFlowerView:_changeSelectMsg(id)
	if self._selectedId == id then
		return
	end

	self._selectedId = id

	self._scrollerList:refresh()
end

function ReviveElizabethFlowerView:_onClickBtnSure()
	if self._selectedId == -1 then
		FloatWordMgr.instance:show("注入失败，请先选择寄语")

		return
	end

	ReviveElizabethAgent.instance:sendPM_ReviveElizabethInjectSoulReq(self._activityId, self._prizeId)
	self:close()
end

return ReviveElizabethFlowerView
