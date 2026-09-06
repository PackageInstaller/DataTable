-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonpaintpopupView.lua

module("logic.extensions.season.view.SeasonpaintpopupView", package.seeall)

local SeasonpaintpopupView = class("SeasonpaintpopupView", ViewComponent)

function SeasonpaintpopupView:ctor()
	SeasonpaintpopupView.super.ctor(self)
end

function SeasonpaintpopupView:unbindEvents()
	SeasonpaintpopupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SeasonpaintpopupView:bindEvents()
	SeasonpaintpopupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SeasonpaintpopupView:buildUI()
	SeasonpaintpopupView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function SeasonpaintpopupView:onExit()
	SeasonpaintpopupView.super.onExit(self)
	self._scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonInfoUpdate, self._refreshUI, self)
end

function SeasonpaintpopupView:onEnter()
	SeasonpaintpopupView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonInfoUpdate, self._refreshUI, self)

	local seasonId = SeasonModel.instance:getSeasonId()

	SeasonController.instance:sendGetSeasonInfo(seasonId)
	self:_refreshUI()
end

function SeasonpaintpopupView:_refreshUI()
	local seasonId = SeasonModel.instance:getSeasonId()
	local array = SeasonConfig.instance:getGridEventMap(seasonId, SeasonGridEvtTypes.EVT_PLOT) or {}
	local list = {}

	for i, cfg in ipairs(array) do
		local detailcfg = SeasonConfig.instance:getMapEvtDetail(seasonId, SeasonGridEvtTypes.EVT_PLOT, cfg.eventId)

		if detailcfg and detailcfg.fragmentId > 0 then
			table.insert(list, detailcfg)
		end
	end

	ArraySort.sortOn(list, "fragmentId")
	self._scrollList:reloadData(list)
end

function SeasonpaintpopupView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgCon = goutil.findChild(go, "imgCon")
	local txtName = goutil.findChildTextComponent(go, "name/txtName")
	local btnPos = GameUtil.asBtn(goutil.findChild(go, "btnPos"))
	local seasonId = SeasonModel.instance:getSeasonId()
	local mo = SeasonModel.instance:getSeasonInfoData(seasonId) or {}

	if not mo.emakiFragmentIds then
		local emakiFragmentIds = {}
		local cfg = SeasonConfig.instance:getSeasonFragmentConfig(seasonId, data.fragmentId)
		local fakeItem = cfg.fakeItem
		local isNotGet = table.indexof(emakiFragmentIds, data.fragmentId) == false

		MaterialMgr.updateItemByStr(imgCon, fakeItem)
		GameUtil.SetGray(imgCon, isNotGet)

		txtName.text = langPara("记忆碎片%s", data.fragmentId)

		btnPos:AddClickListener(function()
			if not isNotGet then
				UIStateManager.instance:push(ViewName.SeasonStoryGridShowView, {
					strDesc = data.desc,
					strTitle = langPara("记忆碎片%s", data.fragmentId),
					strSure = lang("关闭"),
					evtDetailConfig = data
				})
			end
		end, self)
	end
end

function SeasonpaintpopupView:clearCell(cell)
	return
end

function SeasonpaintpopupView:_opFragentView(evtDetailConfig)
	return
end

return SeasonpaintpopupView
