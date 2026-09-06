-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastRewardShowView.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastRewardShowView", package.seeall)

local PanTaoFeastRewardShowView = class("PanTaoFeastRewardShowView", ViewComponent)

function PanTaoFeastRewardShowView:ctor()
	PanTaoFeastRewardShowView.super.ctor(self)
end

function PanTaoFeastRewardShowView:unbindEvents()
	PanTaoFeastRewardShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PanTaoFeastRewardShowView:bindEvents()
	PanTaoFeastRewardShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PanTaoFeastRewardShowView:buildUI()
	PanTaoFeastRewardShowView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local goTabReward = self:getGo("tableview")
	local goCellReward = self:getGo("cell")

	self._tableViewReward = ScrollerList.create(goTabReward, goCellReward, GameUtil.handler(self._updateCellReward, self), GameUtil.handler(self._clearCellReward, self))
	self._itemcell = self:getGo("itemcell")
	self._subTableviewDic = {}
end

function PanTaoFeastRewardShowView:onExit()
	PanTaoFeastRewardShowView.super.onExit(self)
	self._tableViewReward:dispose()
end

function PanTaoFeastRewardShowView:onEnter()
	PanTaoFeastRewardShowView.super.onEnter(self)
	table.clear(self._subTableviewDic)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastGetInfoRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = PanTaoFeastController.instance:getDefaultActivityId() or 0
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	PanTaoFeastController.instance:getInfo(self._activityId)
end

function PanTaoFeastRewardShowView:_updateUIByCfg()
	local buildingCfgs = PanTaoFeastConfig.instance:getBuildingCfgs(self._activityId) or {}

	self._curshowDataList = {}

	for _, cfg in ipairs(buildingCfgs) do
		if cfg.prize then
			table.insert(self._curshowDataList, cfg)
		end
	end
end

function PanTaoFeastRewardShowView:_updateUIByInfo()
	self._repairedBuildingCount = 0

	local info = PanTaoFeastModel.instance:getInfo(self._activityId)

	if info then
		self._repairedBuildingCount = info.repairedBuildingCount or 0
	end

	table.sort(self._curshowDataList, function(a, b)
		local aReceived = self._repairedBuildingCount >= a.buildingId
		local bReceived = self._repairedBuildingCount >= b.buildingId

		if aReceived == bReceived then
			return a.buildingId < b.buildingId
		else
			return not aReceived and bReceived
		end
	end)
	self._tableViewReward:reloadData(self._curshowDataList)
	self._tableViewReward:MoveCellToBegin(0)
end

function PanTaoFeastRewardShowView:_updateCellReward(view, cell, data)
	if not data.buildingId then
		local buildingId = 0
		local isReceived = buildingId <= self._repairedBuildingCount
		local go = cell.gameObject
		local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

		txtDesc.text = langPara("当前修复建筑:\n%s/%s", self._repairedBuildingCount, buildingId)

		local markGeted = goutil.findChild(go, "markGeted")

		GameUtil.SetActive(markGeted, isReceived)

		local markNotGeted = goutil.findChild(go, "markNotGeted")

		GameUtil.SetActive(markNotGeted, not isReceived)

		local goTabPrize = goutil.findChild(go, "subTableview")
		local goCellPrize = self._itemcell
		local prizeScrollList = self._subTableviewDic[go]

		if not prizeScrollList then
			prizeScrollList = ScrollerList.create(goTabPrize, goCellPrize, GameUtil.handler(self._updateCellPrize, self), GameUtil.handler(self._clearCellPrize, self))
			self._subTableviewDic[go] = prizeScrollList
		end

		if not data.prize then
			local prizes = ""
			local prizeStrArr = string.split(prizes, "#")

			prizeScrollList:reloadData(prizeStrArr)
			prizeScrollList:MoveCellToBegin(0)
			prizeScrollList:dragNotifyParent()
		end
	end
end

function PanTaoFeastRewardShowView:_clearCellReward(cell)
	local go = cell.gameObject
	local prizeScrollList = self._subTableviewDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._subTableviewDic[go] = nil
	end
end

function PanTaoFeastRewardShowView:_updateCellPrize(view, cell, data)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function PanTaoFeastRewardShowView:_clearCellPrize(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return PanTaoFeastRewardShowView
