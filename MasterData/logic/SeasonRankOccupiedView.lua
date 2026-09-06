-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonRankOccupiedView.lua

module("logic.extensions.season.view.SeasonRankOccupiedView", package.seeall)

local SeasonRankOccupiedView = class("SeasonRankOccupiedView", ViewComponent)

function SeasonRankOccupiedView:ctor()
	SeasonRankOccupiedView.super.ctor(self)
end

function SeasonRankOccupiedView:unbindEvents()
	SeasonRankOccupiedView.super.unbindEvents(self)
end

function SeasonRankOccupiedView:bindEvents()
	SeasonRankOccupiedView.super.bindEvents(self)
end

function SeasonRankOccupiedView:buildUI()
	SeasonRankOccupiedView.super.buildUI(self)

	self._goEmpty = self:getGo("empty")
	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goMyRank = self:getGo("myRank")
	self._goPlotRoot = self:getGo("myRank/plot")
	self._txtMyRank = goutil.findChildTextComponent(self._goMyRank, "txtMyRank")
	self._txtScore = goutil.findChildTextComponent(self._goMyRank, "txtScore")
	self._myTileItemList = {}

	for i = 1, 6 do
		local item = {}

		item.go = goutil.findChild(self._goPlotRoot, "plot" .. i)
		item.txtNum = goutil.findChildTextComponent(item.go, "txtNum")
		self._myTileItemList[i] = item
	end
end

function SeasonRankOccupiedView:onExit()
	SeasonRankOccupiedView.super.onExit(self)
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonRankUpdate, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonInfoUpdate, self._refreshView, self)
	SeasonController.instance:unregisterLocalNotify(SeasonController.RefreshViewData, self._requestViewData, self)
end

function SeasonRankOccupiedView:onEnter()
	SeasonRankOccupiedView.super.onEnter(self)

	local params = self._viewPresentor:getOpenParam()

	if not params or not params[1] then
		return
	end

	self._rankCfg = params[1]

	GlobalDispatcher:addListener(GlobalNotify.SeasonRankUpdate, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonInfoUpdate, self._refreshView, self)
	SeasonController.instance:registerLocalNotify(SeasonController.RefreshViewData, self._requestViewData, self)
	self:_requestViewData(self._rankCfg)
end

function SeasonRankOccupiedView:_requestViewData(data)
	if not data or not self._rankCfg then
		return
	end

	if data.rankType ~= self._rankCfg.rankType or data.seasonId ~= self._rankCfg.seasonId then
		return
	end

	SeasonController.instance:sendGetRankInfo(data.rankType, data.seasonId, data.zoneId)
end

function SeasonRankOccupiedView:_refreshView(data)
	if not data or not self._rankCfg then
		return
	end

	if data.rankType ~= self._rankCfg.rankType or data.seasonId ~= self._rankCfg.seasonId then
		return
	end

	self._viewData = data

	self._tableView:reloadData(data.rankData)

	if data.myRank > 0 then
		self._txtMyRank.text = data.myRank or "未上榜"
	end

	self._txtScore.text = data.myScore

	for i = 1, 6 do
		self._myTileItemList[i].txtNum.text = data.myOtherData[i] or 0
	end

	goutil.setActive(self._goEmpty, #data.rankData <= 0)
end

function SeasonRankOccupiedView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if data.rank > 0 then
		cell.txtRank.text = data.rank or "未上榜"
	end

	cell.txtScore.text = data.score

	local gameMode = SeasonModel.PVE_GAME_MODE_NONE

	gameMode = data.memberInfo and not string.nilorempty(data.memberInfo.userName) and SeasonModel.PVE_GAME_MODE_GVE or SeasonModel.PVE_GAME_MODE_PVE

	if gameMode == SeasonModel.PVE_GAME_MODE_NONE or gameMode == SeasonModel.PVE_GAME_MODE_PVE then
		GameUtil.SetActive(cell.pve, true)
		GameUtil.SetActive(cell.gve, false)

		cell.pve_txtName.text = data.headInfo.userName

		HeadItemController.instance:setHeadCellByInfo(cell.pve_head, data.headInfo, true)
	elseif gameMode == SeasonModel.PVE_GAME_MODE_GVE then
		GameUtil.SetActive(cell.pve, false)
		GameUtil.SetActive(cell.gve, true)

		cell.gve_txtNameMy.text = data.headInfo.userName

		HeadItemController.instance:setHeadCellByInfo(cell.gve_headMy, data.headInfo, true)

		if data.memberInfo then
			cell.gve_txtNameOther.text = data.memberInfo.userName or ""
		end

		HeadItemController.instance:setHeadCellByInfo(cell.gve_headOther, data.memberInfo, true)
	end

	local isRankTop = data.rank > 0 and data.rank <= 3

	goutil.setActive(cell.goImgRank, isRankTop)

	if isRankTop then
		cell.ctrlRankImg:SetState(data.rank - 1)
	end

	for i = 1, 6 do
		cell.tileItemList[i].txtNum.text = data.otherData[i] or 0
	end
end

function SeasonRankOccupiedView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.ctrlRankImg = goutil.findChildComponent(cell.go, "imgRank", typeof(UIImageSpriteChange))
	cell.txtRank = goutil.findChildTextComponent(cell.go, "txtRank")
	cell.txtScore = goutil.findChildTextComponent(cell.go, "txtScore")
	cell.goImgRank = goutil.findChild(cell.go, "imgRank")
	cell.goPlot = goutil.findChild(cell.go, "plot")
	cell.pve = goutil.findChild(cell.go, "playerInfo/pve")
	cell.pve_head = goutil.findChild(cell.go, "playerInfo/pve/head")
	cell.pve_txtName = goutil.findChildTextComponent(cell.go, "playerInfo/pve/txtName")
	cell.gve = goutil.findChild(cell.go, "playerInfo/gve")
	cell.gve_headMy = goutil.findChild(cell.go, "playerInfo/gve/headMy")
	cell.gve_txtNameMy = goutil.findChildTextComponent(cell.go, "playerInfo/gve/txtNameMy")
	cell.gve_headOther = goutil.findChild(cell.go, "playerInfo/gve/headOther")
	cell.gve_txtNameOther = goutil.findChildTextComponent(cell.go, "playerInfo/gve/txtNameOther")
	cell.tileItemList = {}

	for i = 1, 6 do
		local item = {}

		item.go = goutil.findChild(cell.goPlot, "plot" .. i)
		item.txtNum = goutil.findChildTextComponent(item.go, "txtNum")
		cell.tileItemList[i] = item
	end

	HeadItemController.instance:resetHeadCell(cell.pve_head)
	HeadItemController.instance:resetHeadCell(cell.gve_headMy)
	HeadItemController.instance:resetHeadCell(cell.gve_headOther)

	return cell
end

return SeasonRankOccupiedView
