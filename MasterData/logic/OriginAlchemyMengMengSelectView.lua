-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/view/OriginAlchemyMengMengSelectView.lua

module("logic.extensions.originalchemymengmeng.view.OriginAlchemyMengMengSelectView", package.seeall)

local OriginAlchemyMengMengSelectView = class("OriginAlchemyMengMengSelectView", ViewComponent)

function OriginAlchemyMengMengSelectView:ctor()
	OriginAlchemyMengMengSelectView.super.ctor(self)
end

function OriginAlchemyMengMengSelectView:unbindEvents()
	OriginAlchemyMengMengSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginAlchemyMengMengSelectView:bindEvents()
	OriginAlchemyMengMengSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriginAlchemyMengMengSelectView:buildUI()
	OriginAlchemyMengMengSelectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._empty = self:getGo("empty")
	self._txtEffect = self:getTxt("txtEffect")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginAlchemyMengMengSelectView:onExit()
	OriginAlchemyMengMengSelectView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginAlchemyMengMengSelectView:onEnter()
	OriginAlchemyMengMengSelectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 601001
	end

	self._fmtMo = params[2]
	self._info = OriginalChemyMengMengModel.instance:getInfo(self._activityId) or {}
	self._gainReagent = checktable(self._info.gainReagent)
	self._hasUsedReagent = checktable(self._info.hasUsedReagent)
	self._reagentList = {}

	for i, reagentId in ipairs(self._gainReagent) do
		if not table.indexof(self._hasUsedReagent, reagentId) then
			table.insert(self._reagentList, reagentId)
		end
	end

	local preSelectId = OriginalChemyMengMengModel.instance:getSelectedReagentId(self._activityId)

	self._selectId = table.indexof(self._reagentList, preSelectId) and preSelectId or checknumber(self._reagentList[1])

	local reagentCfg = OriginalChemyMengMengConfig.instance:getReagentCfg(self._activityId, self._selectId)

	if reagentCfg then
		if reagentCfg then
			self._txtEffect.text = reagentCfg.desc or ""
		end
	end

	self._scrollList:reloadData(self._reagentList)
	self._scrollList:setCenterMode(true)
	GameUtil.SetActive(self._tableview, #self._gainReagent ~= #self._hasUsedReagent)
	GameUtil.SetActive(self._empty, #self._gainReagent == #self._hasUsedReagent)
	GameUtil.SetActive(self._txtEffect, #self._gainReagent ~= #self._hasUsedReagent)
end

function OriginAlchemyMengMengSelectView:_updateCell(view, cell, data)
	local select = goutil.findChild(cell, "select")
	local imgChange = goutil.findChild(cell, "imgChange")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local reagentCfg = OriginalChemyMengMengConfig.instance:getReagentCfg(self._activityId, data)

	if reagentCfg then
		txtName.text = reagentCfg.name or ""
	end

	GameUtil.SetActive(select, self._selectId == data)
	GameUtil.addClickHandler(cell, function()
		self._selectId = data

		if reagentCfg then
			self._txtEffect.text = reagentCfg.desc or ""
		end

		self._scrollList:reloadData(self._reagentList)
	end, self)
	uGuiUtil.setSpriteToImage(imgChange, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(reagentCfg.resName))
end

function OriginAlchemyMengMengSelectView:_clearCell(cell)
	local imgChange = goutil.findChild(cell, "imgChange")

	GameUtil.rmClickHandler(cell)
	uGuiUtil.clearImage(imgChange)
end

function OriginAlchemyMengMengSelectView:_onClickBtnSure()
	if #self._gainReagent == #self._hasUsedReagent then
		FloatWordMgr.instance:show(lang("暂无试剂可选择"))

		return
	end

	self._fmtMo:setUseReagentId(self._selectId)
	OriginalChemyMengMengModel.instance:setSelectedReagentId(self._activityId, self._selectId)
	GlobalDispatcher:dispatch(GlobalNotify.OriginAlchemyMengMengChangeReagentId, self._selectId)
	self:close()
end

return OriginAlchemyMengMengSelectView
