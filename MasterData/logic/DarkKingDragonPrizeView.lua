-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonPrizeView.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonPrizeView", package.seeall)

local DarkKingDragonPrizeView = class("DarkKingDragonPrizeView", ViewComponent)

function DarkKingDragonPrizeView:ctor()
	DarkKingDragonPrizeView.super.ctor(self)
end

function DarkKingDragonPrizeView:unbindEvents()
	DarkKingDragonPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DarkKingDragonPrizeView:bindEvents()
	DarkKingDragonPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DarkKingDragonPrizeView:buildUI()
	DarkKingDragonPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._itemCell = self:getGo("itemCell")

	local goTab = self:getGo("tableview")
	local goCell = self:getGo("tableview/tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DarkKingDragonPrizeView:onExit()
	DarkKingDragonPrizeView.super.onExit(self)
	self._tableView:dispose()
end

function DarkKingDragonPrizeView:onEnter()
	DarkKingDragonPrizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineDarkKingDragonClgInfoRes, self._updateUIByInfo, self)

	self._itemScrollListDic = {}
	self._activityId = 526001

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	DivineDarkKingDragonClgController.instance:getInfo(self._activityId)
end

function DarkKingDragonPrizeView:_updateUIByCfg()
	self._phaseCfgs = DivineDarkKingDragonClgConfig.instance:getPhaseCfgsByActId(self._activityId) or {}
end

function DarkKingDragonPrizeView:_updateUIByInfo()
	self._curMaxPhaseId = 0
	self._hasGainMap = {}

	for phaseId, cfg in ipairs(self._phaseCfgs) do
		local info = DivineDarkKingDragonClgModel.instance:getPhaseInfo(self._activityId, phaseId)

		if info then
			self._hasGainMap[phaseId] = info.info.hadGainedPrize

			if not info.info.stages then
				local stageCfgs = DivineDarkKingDragonClgConfig.instance:getStageCfgsByPhaseId(self._activityId, phaseId) or {}

				if #stageCfgs > 0 and #stageCfgs <= #info.info.stages then
					self._curMaxPhaseId = phaseId
				end
			end
		end
	end

	self._tableView:reloadData(self._phaseCfgs)
end

function DarkKingDragonPrizeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

	txtDesc.text = data.passDesc or ""

	local markFinish = goutil.findChild(go, "markFinish")
	local markNoOpen = goutil.findChild(go, "markNoOpen")
	local markClg = goutil.findChild(go, "markClg")
	local itemListGo = goutil.findChild(go, "itemTableView")

	if itemListGo and self._itemCell then
		if not data.prize then
			local prizes = ""

			if not self._itemScrollListDic[go] then
				local prizeScrollList = ScrollerList.create(itemListGo, self._itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

				self._itemScrollListDic[go] = prizeScrollList

				local prizeStrArr = string.split(prizes, "#")

				prizeScrollList:reloadData(prizeStrArr)
				prizeScrollList:dragNotifyParent()
			end
		end
	end

	goutil.setActive(markFinish, false)
	goutil.setActive(markNoOpen, false)
	goutil.setActive(markClg, false)

	if self._hasGainMap[data.phaseId] then
		goutil.setActive(markFinish, true)
	else
		goutil.setActive(markNoOpen, data.phaseId > self._curMaxPhaseId + 1)
		goutil.setActive(markClg, data.phaseId == self._curMaxPhaseId + 1)
	end
end

function DarkKingDragonPrizeView:_clearCell(cell)
	local go = cell.gameObject
	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function DarkKingDragonPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function DarkKingDragonPrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return DarkKingDragonPrizeView
