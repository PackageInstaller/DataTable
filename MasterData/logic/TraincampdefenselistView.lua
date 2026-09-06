-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampdefense/view/TraincampdefenselistView.lua

module("logic.extensions.traincampdefense.view.TraincampdefenselistView", package.seeall)

local TraincampdefenselistView = class("TraincampdefenselistView", ViewComponent)

function TraincampdefenselistView:ctor()
	TraincampdefenselistView.super.ctor(self)
end

function TraincampdefenselistView:unbindEvents()
	TraincampdefenselistView.super.unbindEvents(self)
	self._btnRefresh:RemoveClickListener()
end

function TraincampdefenselistView:bindEvents()
	TraincampdefenselistView.super.bindEvents(self)
	self._btnRefresh:AddClickListener(self._onClickbtnRefresh, self)
end

function TraincampdefenselistView:buildUI()
	TraincampdefenselistView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = self:getGo("empty")
	self._btnRefresh = self:getBtn("viewnode/btnRefresh")
end

function TraincampdefenselistView:onExit()
	TraincampdefenselistView.super.onExit(self)
	self._scrollerList:dispose()
end

function TraincampdefenselistView:onEnter()
	TraincampdefenselistView.super.onEnter(self)
	self.addGEvent(self, TrainCampDefenseFormAgent.DF_RefreshFormListRes, self._onGetList, self)

	self._recommendRangeZdl = TraincampqiecuoConfig.instance:getBreakRecommendZdlRange()
	self._myZdl = RoleModel.instance:getMaxPower()

	self:_updateUI()
	TraincampdefenseController.instance:sendPM_DF_RefreshFormListReq(true)
end

function TraincampdefenselistView:_updateUI()
	local list = TraincampdefenseModel.instance:getDefensePlayerlistList()

	self._scrollerList:reloadData(list)
	goutil.setActive(self._emptyGo, not list or #list <= 0)
end

function TraincampdefenselistView:_updateCell(view, cell, data, tag)
	local btnSuer = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSuer")
	local goHead = goutil.findChild(cell.gameObject, "head")
	local goPetcon = goutil.findChild(cell.gameObject, "petcon")
	local goRecommend = goutil.findChild(cell.gameObject, "recommend")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtPower = goutil.findChildTextComponent(cell.gameObject, "txtPower")
	local txtTeamPower = goutil.findChildTextComponent(cell.gameObject, "txtTeamPower")
	local layout = goPetcon:GetComponent(ComponentType.UILayoutSingleLine)

	txtPower.text = data.maxZdl
	txtTeamPower.text = string.format("%s", data.defenseFormZdl)
	txtName.text = data.playerHeadInfo.userName

	HeadItemController.instance:resetHeadCell(goHead)
	HeadItemController.instance:setHeadCellByInfo(goHead, data.playerHeadInfo)
	MaterialMgr.resetAll(goPetcon)

	for i, v in ipairs(data.formFaceIds) do
		local cfgStr = MatType.Pet .. ":" .. v

		MaterialMgr.setCellByCfg(cfgStr, goPetcon, nil, nil, false)
	end

	layout:Layout()
	btnSuer:AddClickListener(function()
		TraincampdefenseController.instance:enterMission(data.playerHeadInfo, data.defenseFormZdl)
		self:close()
	end)

	local range = math.abs(data.maxZdl - self._myZdl)

	goutil.setActive(goRecommend, range <= self._recommendRangeZdl)
end

function TraincampdefenselistView:_clearCell(cell)
	local goHead = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(goHead)
end

function TraincampdefenselistView:_onGetList()
	self:_updateUI()
end

function TraincampdefenselistView:_onClickbtnRefresh()
	TraincampdefenseController.instance:sendPM_DF_RefreshFormListReq()
end

return TraincampdefenselistView
