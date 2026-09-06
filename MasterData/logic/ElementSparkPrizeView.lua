-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkPrizeView.lua

module("logic.extensions.elementspark.view.ElementSparkPrizeView", package.seeall)

local ElementSparkPrizeView = class("ElementSparkPrizeView", ViewComponent)

function ElementSparkPrizeView:ctor()
	ElementSparkPrizeView.super.ctor(self)
end

function ElementSparkPrizeView:unbindEvents()
	ElementSparkPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCamp)
	GameUtil.rmClickHandler(self._btnPerson)
end

function ElementSparkPrizeView:bindEvents()
	ElementSparkPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCamp, self._onClickCamp, self)
	GameUtil.addClickHandler(self._btnPerson, self._onClickPerson, self)
end

function ElementSparkPrizeView:buildUI()
	ElementSparkPrizeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnCamp = self:getBtn("btnCamp")
	self._btnPerson = self:getBtn("btnPerson")
	self._campChange = self._btnCamp:GetComponent("UIChangeGroup")
	self._personChange = self._btnPerson:GetComponent("UIChangeGroup")
	self._campGo = self:getGo("camp")
	self._campPrizeviewGo = self:getGo("camp/prizeView")
	self._campCellGo = self:getGo("camp/campCell")
	self._campTitle = self:getGo("camp/campTitle")
	self._personGo = self:getGo("person")
	self._personPrizeviewGo = self:getGo("person/prizeView")
	self._personCellGo = self:getGo("person/personCell")
	self._item = self:getGo("item")
	self._campPrizeView = ScrollerList.create(self._campPrizeviewGo, self._campCellGo, GameUtil.handler(self._updateCampCell, self), GameUtil.handler(self._clearCampCell, self))
	self._personPrizeView = ScrollerList.create(self._personPrizeviewGo, self._personCellGo, GameUtil.handler(self._updatePersonCell, self), GameUtil.handler(self._clearPersonCell, self))
end

function ElementSparkPrizeView:onExit()
	ElementSparkPrizeView.super.onExit(self)
	self._campPrizeView:dispose()
	self._personPrizeView:dispose()
end

function ElementSparkPrizeView:onEnter()
	ElementSparkPrizeView.super.onEnter(self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._campPrizeCfg = ElementSparkConfig.instance:getCampPrizeCfg(self._activityId)
	self._personPrizeCfg = ElementSparkConfig.instance:getPersonPrizeCfg(self._activityId)
	self._campRewardScroller = {}
	self._personRewardScroller = {}

	self._campPrizeView:reloadData(self._campPrizeCfg)
	self._personPrizeView:reloadData(self._personPrizeCfg)
	self:_onClickCamp()
end

function ElementSparkPrizeView:_updateCampCell(view, cell, data)
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local campViewGo = goutil.findChild(cell, "campView")
	local leaderViewGo = goutil.findChild(cell, "leaderView")
	local campView, leaderView

	if self._campRewardScroller[cell] == nil then
		self._campRewardScroller[cell] = {}
		campView = ScrollerList.create(campViewGo, self._item, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		campView:dragNotifyParent()

		leaderView = ScrollerList.create(leaderViewGo, self._item, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		leaderView:dragNotifyParent()

		self._campRewardScroller[cell][campViewGo] = campView
		self._campRewardScroller[cell][leaderViewGo] = leaderView
	else
		campView = self._campRewardScroller[cell][campViewGo]
		leaderView = self._campRewardScroller[cell][leaderViewGo]
	end

	txtRank.text = data.title

	local campPrizeCfg = string.split(data.prize, "#")

	if campPrizeCfg then
		campView:reloadData(campPrizeCfg)
	end

	local leaderPrizeCfg = string.split(data.commanderPrize, "#")

	if leaderPrizeCfg then
		leaderView:reloadData(leaderPrizeCfg)
	end
end

function ElementSparkPrizeView:_clearCampCell(cell)
	if self._campRewardScroller[cell] then
		for _, view in ipairs(self._campRewardScroller[cell]) do
			view:dispose()
		end
	end
end

function ElementSparkPrizeView:_updatePersonCell(view, cell, data)
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local personViewGo = goutil.findChild(cell, "personView")
	local personView = self._personRewardScroller[cell]

	if personView == nil then
		personView = ScrollerList.create(personViewGo, self._item, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		personView:dragNotifyParent()

		self._personRewardScroller[cell] = personView
	end

	local prizeCfg = string.split(data.prize, "#")

	if prizeCfg then
		personView:reloadData(prizeCfg)
	end

	txtRank.text = data.title
end

function ElementSparkPrizeView:_clearPersonCell(cell)
	if self._personRewardScroller[cell] then
		self._personRewardScroller[cell]:dispose()
	end
end

function ElementSparkPrizeView:_updatePrizeCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function ElementSparkPrizeView:_clearPrizeCell(cell)
	MaterialMgr.resetAll(cell)
end

function ElementSparkPrizeView:_onClickCamp()
	self._campChange:SetState(1)
	self._personChange:SetState(0)
	GameUtil.SetActive(self._campGo, true)
	GameUtil.SetActive(self._personGo, false)
end

function ElementSparkPrizeView:_onClickPerson()
	self._campChange:SetState(0)
	self._personChange:SetState(1)
	GameUtil.SetActive(self._campGo, false)
	GameUtil.SetActive(self._personGo, true)
end

return ElementSparkPrizeView
