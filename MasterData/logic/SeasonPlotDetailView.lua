-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPlotDetailView.lua

module("logic.extensions.season.view.SeasonPlotDetailView", package.seeall)

local SeasonPlotDetailView = class("SeasonPlotDetailView", ViewComponent)

function SeasonPlotDetailView:ctor()
	SeasonPlotDetailView.super.ctor(self)
end

function SeasonPlotDetailView:unbindEvents()
	SeasonPlotDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	self._togChoose:RemoveOnValueChanged()
end

function SeasonPlotDetailView:bindEvents()
	SeasonPlotDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	self._togChoose:AddOnValueChanged(self._onToggleChange, self)
end

function SeasonPlotDetailView:buildUI()
	SeasonPlotDetailView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._scrollerGo = self:getGo("tableview")
	self._cellGo = self:getGo("cell")
	self._txtPlotName = self:getTxt("plot/name/txtName")
	self._plotChange = GameUtil.getUIImageSpriteChange(self:getGo("plot/plot"))
	self._togChoose = self:getToggle("btnChoose")
	self._scrollList = ScrollerList.create(self._scrollerGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SeasonPlotDetailView:onExit()
	SeasonPlotDetailView.super.onExit(self)
	self._scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonMapInfoUpdate, self._refreshList, self)
end

function SeasonPlotDetailView:onEnter()
	SeasonPlotDetailView.super.onEnter(self)

	self._groupData = self:getFirstParam()
	self._txtPlotName.text = SeasonGridEvtTypes.Names[self._groupData.eventType]

	self._plotChange:SetState(self._groupData.eventType)

	self._isFilterOnlyNotOccupied = true
	self._togChoose.toggle.isOn = self._isFilterOnlyNotOccupied

	self:_buildData()
	self:_refreshList()
	GlobalDispatcher:addListener(GlobalNotify.SeasonMapInfoUpdate, self._refreshList, self)
end

function SeasonPlotDetailView:_onToggleChange()
	self._isFilterOnlyNotOccupied = self._togChoose.toggle.isOn

	self:_refreshList()
end

function SeasonPlotDetailView:_buildData()
	local lvConfigs = {}

	for k, v in pairs(self._groupData.confs) do
		table.insert(lvConfigs, {
			showLevel = k,
			confs = v
		})
	end

	ArraySort.sortOn(lvConfigs, "showLevel", ArraySort.DESCENDING)

	local all = {}

	for i, v in ipairs(lvConfigs) do
		TableUtil.AddTable(all, v.confs)
	end

	self._configs = all
end

function SeasonPlotDetailView:_refreshList()
	if self._configs then
		self._filterConfigs = {}

		local mo
		local seasonModel = SeasonModel.instance

		for i = 1, #self._configs do
			if not self._isFilterOnlyNotOccupied then
				table.insert(self._filterConfigs, self._configs[i])
			else
				mo = seasonModel:getMapInfoById(self._configs[i].id)

				if mo and not mo:isOccupied() then
					table.insert(self._filterConfigs, self._configs[i])
				end
			end
		end

		self._scrollList:reloadData(self._filterConfigs)
		self._scrollList:refresh()
	end
end

function SeasonPlotDetailView:_updateCell(view, cell, data, tag)
	local txtPos = goutil.findChildTextComponent(cell, "txtPos")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")

	txtPos.text = string.format("(%s,%s)", data.x, data.y)
	txtLevel.text = langPara("%s级", data.showLevel)

	GameUtil.addClickHandler(cell.gameObject, function()
		self:close()
		UIStateManager.instance:popByName(ViewName.SeasonPlotSearchView)

		local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(data.id)
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene.eventsAnimation then
			scene.eventsAnimation:playCamera2Grid(gridX, gridY)
			GlobalDispatcher:dispatch(GlobalNotify.SeasonSelectGrid_R_C, gridX, gridY)
		end
	end)
end

function SeasonPlotDetailView:_clearCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

return SeasonPlotDetailView
