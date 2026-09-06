-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchBuffView.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchBuffView", package.seeall)

local SummerTreasureSnatchBuffView = class("SummerTreasureSnatchBuffView", ViewComponent)

function SummerTreasureSnatchBuffView:ctor()
	SummerTreasureSnatchBuffView.super.ctor(self)
end

function SummerTreasureSnatchBuffView:buildUI()
	SummerTreasureSnatchBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("viewnode/btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._btnSure = self:getBtn("btnSure")
	self._empty = self:getGo("empty")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SummerTreasureSnatchBuffView:bindEvents()
	SummerTreasureSnatchBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function SummerTreasureSnatchBuffView:unbindEvents()
	SummerTreasureSnatchBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function SummerTreasureSnatchBuffView:onEnter()
	SummerTreasureSnatchBuffView.super.onEnter(self)

	if self._scrollList == nil then
		self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	end

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._selectedBuffId = checknumber(params[2])

	self:_onUpdate()
end

function SummerTreasureSnatchBuffView:onExit()
	SummerTreasureSnatchBuffView.super.onExit(self)

	if self._scrollList then
		self._scrollList:dispose()

		self._scrollList = nil
	end
end

function SummerTreasureSnatchBuffView:_onUpdate()
	self._info = SummerTreasureSnatchModel.instance:getInfo(self._activityId) or {}

	local gainBuffId = checktable(self._info.gainBuffId) or {}
	local hasBuff = #gainBuffId > 0

	GameUtil.SetActive(self._empty, not hasBuff)
	GameUtil.SetActive(self._tableview, hasBuff)
	GameUtil.SetActive(self._btnSure.gameObject, hasBuff)
	self._scrollList:reloadData(gainBuffId)
	self._scrollList:setCenterMode(true)
end

function SummerTreasureSnatchBuffView:_updateCell(view, cell, buffId)
	local selectGo = goutil.findChild(cell, "select")
	local btnGo = goutil.findChild(cell, "btn")
	local BuffIcon = goutil.findChild(cell, "BuffIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local cfg = SummerTreasureSnatchConfig.instance:getBuffCfg(self._activityId, buffId) or {}

	txtName.text = cfg.name or ""
	txtDesc.text = cfg.desc or ""

	GameUtil.SetActive(selectGo, self._selectedBuffId == buffId)
	GameUtil.addClickHandler(btnGo, GameUtil.handler(self._onClickBuffCell, self, buffId))
	uGuiUtil.setSpriteToImage(BuffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))
end

function SummerTreasureSnatchBuffView:_clearCell(cell)
	local btnGo = goutil.findChild(cell, "btn")
	local BuffIcon = goutil.findChild(cell, "BuffIcon")

	GameUtil.rmClickHandler(btnGo)
	uGuiUtil.clearImage(BuffIcon)
end

function SummerTreasureSnatchBuffView:_onClickBuffCell(buffId)
	self._selectedBuffId = buffId

	self:_onUpdate()
end

function SummerTreasureSnatchBuffView:_onClickSure()
	if self._selectedBuffId <= 0 then
		FloatWordMgr.instance:show(lang("请选择祝福"))

		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.SummerTreasureSnatchChooseBuff, self._selectedBuffId)
	self:close()
end

return SummerTreasureSnatchBuffView
