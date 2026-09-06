-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/view/DivinehopeselectView.lua

module("logic.extensions.divinehope.view.DivinehopeselectView", package.seeall)

local DivinehopeselectView = class("DivinehopeselectView", ViewComponent)

function DivinehopeselectView:buildUI()
	DivinehopeselectView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:setCenterMode(true)

	self._btnHope = self:getBtn("btnHope")
end

function DivinehopeselectView:bindEvents()
	DivinehopeselectView.super.bindEvents(self)
	self._btnHope:AddClickListener(self._onClickbtnHope, self)
end

function DivinehopeselectView:unbindEvents()
	DivinehopeselectView.super.unbindEvents(self)
	self._btnHope:RemoveClickListener()
end

function DivinehopeselectView:onEnter()
	DivinehopeselectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._floorId = checknumber(params[2])
	self._callBack = params[3]
	self._selectWishId = DivinehopeModel.instance:getSelectWishId(self._activityId)

	self:_updateUI()
end

function DivinehopeselectView:onExit()
	DivinehopeselectView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivinehopeselectView:_updateUI()
	local floorCfg = DivinehopeConfig.instance:getFloorCfg(self._activityId, self._floorId)

	if self._selectWishId <= 0 then
		self._selectWishId = floorCfg.canUseWish[1]
	end

	self._scrollerList:reloadData(floorCfg.canUseWish)
end

function DivinehopeselectView:_updateCell(view, cell, wishId, tag)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local txtYw = goutil.findChildTextComponent(cell.gameObject, "txtYw")
	local txtXw = goutil.findChildTextComponent(cell.gameObject, "txtXw")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtAdd = goutil.findChildTextComponent(cell.gameObject, "txtAdd")
	local wishCfg = DivinehopeConfig.instance:getWishCfg(self._activityId, wishId)
	local typeStr = wishCfg.wishType == 1 and "希望" or "欲望"

	goutil.setActive(txtXw.gameObject, wishCfg.wishType == 1)
	goutil.setActive(txtYw.gameObject, wishCfg.wishType == 2)
	goutil.setActive(goSelect, self._selectWishId == wishId)

	txtDesc.text = string.format("献祭效果：\n%s", wishCfg.buffDesc)
	txtAdd.text = string.format("%s+%s", typeStr, wishCfg.score)

	btn:AddClickListener(function()
		self._selectWishId = wishId

		self._scrollerList:refresh()
	end)
end

function DivinehopeselectView:_clearCell(cell)
	return
end

function DivinehopeselectView:_onClickbtnHope()
	DivinehopeModel.instance:setSelectWishId(self._activityId, self._selectWishId)

	if self._callBack then
		self._callBack(self._selectWishId)

		self._callBack = nil
	else
		self:_enterMissionView()
	end

	self:close()
end

function DivinehopeselectView:_enterMissionView()
	local mo = DivinehopeModel.instance:getFmtMo()

	mo:initParams(self._activityId, self._floorId)
	CustomFmtController.instance:showMissionView(mo)
end

return DivinehopeselectView
