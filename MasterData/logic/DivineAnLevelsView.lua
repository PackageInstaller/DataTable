-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinean/view/DivineAnLevelsView.lua

module("logic.extensions.divinean.view.DivineAnLevelsView", package.seeall)

local DivineAnLevelsView = class("DivineAnLevelsView", InfinfulevelsView)

function DivineAnLevelsView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._rewardBtn = self:getBtn("info/btnReward")
	self._btnTip = self:getBtn("btnTip")
	self._cell = self:getGo("levels/cell")
	self._levelSlider = self:getSlider("info/level")
	self._openDate = self:getTxt("time/txt")
	self._upLevelTxt = self:getTxt("info/txtUp")
	self._downLevelTxt = self:getTxt("info/txtDown")
	self._curLevelTxt = self:getTxt("info/level/Fill Area/info/txtLevel")
	self._headObj = self:getGo("info/level/Fill Area/info/head")
	self._iconObj = self:getGo("info/btnReward/icon")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(GameUtil.handler(self._reloadFinish, self))

	self._txtDesc = self:getGo("desc/txt"):GetComponent(typeof(UnityEngine.UI.Text))
end

function DivineAnLevelsView:onEnter()
	self._scrollerListMp = {}

	DivineAnLevelsView.super.onEnter(self)
end

function DivineAnLevelsView:_onClickReward()
	UIStateManager.instance:push(ViewName.DivineAnPopView, 2, self.curActId, "挑战奖励")
end

function DivineAnLevelsView:_onClickTip()
	DivineAnLevelsView.instance:push(ViewName.RulesView, "divineanlevels_rule")
end

function DivineAnLevelsView:_onClickReward()
	UIStateManager.instance:push(ViewName.DivineAnPopView, 2, self.curActId, "挑战奖励")
end

function DivineAnLevelsView:onRefreshUI()
	self.stageId = InfinitefutureModel.instance.curStageId

	if self.stageId > self.totalCount then
		self:close()

		return
	end

	self.stageTeams = InfinitefutureConfig.instance:getTeamCfgs(self.curActId, self.stageId)
	self.curCount = #self.stageTeams

	local sValue = (self.stageId - 1) / (self.totalCount - 1)

	self._levelSlider:SetValue(sValue)

	self._curLevelTxt.text = string.format("当前%d层", self.stageId)

	self._scrollerList:setCenterMode(true)
	self._scrollerList:reloadData(self.stageTeams)

	local stageCfgs = InfinitefutureConfig.instance:getStageCfgs(self.curActId)

	if stageCfgs then
		if stageCfgs[self.stageId] then
			self._txtDesc.text = stageCfgs[self.stageId].stageDescription or ""
		end
	end
end

function DivineAnLevelsView:_updateCell(view, cell, data)
	self:_setTeamInfo(cell, data.teamId)
end

function DivineAnLevelsView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function DivineAnLevelsView:_reloadFinish()
	local curIndex = 1

	if not InfinitefutureModel.instance.curStageInfo then
		if not TableUtil.isTableEmpty(InfinitefutureModel.instance.curStageInfo) then
			for i, v in ipairs(InfinitefutureModel.instance.curStageInfo) do
				if not v.isChallenged then
					curIndex = i

					break
				end
			end
		end

		self._scrollerList:MoveCellToCenter(curIndex - 1)
	end
end

function DivineAnLevelsView:refreshLockTeam(cell, teamId)
	local raceTeam = InfinitefutureModel.instance:getLockTeams(teamId)
	local lockTeam = {}

	for i, v in ipairs(raceTeam) do
		if v > 0 then
			table.insert(lockTeam, v)
		end
	end

	local isEmpty = TableUtil.isTableEmpty(lockTeam)
	local txtempty = goutil.findChild(cell, "information/txtempty")

	goutil.setActive(txtempty, isEmpty)

	if not self._scrollerListMp[cell] then
		local tableview = goutil.findChild(cell, "information/tableview")
		local tablecell = goutil.findChild(cell, "information/tableview/petcell")

		self._scrollerListMp[cell] = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updateLockCell, self), GameUtil.handler(self._clearLockCell, self))
	end

	local scrollerList = self._scrollerListMp[cell]

	scrollerList:setCenterMode(true)
	scrollerList:reloadData(lockTeam)
end

function DivineAnLevelsView:_updateLockCell(view, cell, data)
	if data > 0 then
		local con = goutil.findChild(cell, "con")

		MaterialMgr.setCell(MatType.Pet, data, con)
	end
end

function DivineAnLevelsView:_clearLockCell(cell)
	MaterialMgr.resetAll(cell)
end

return DivineAnLevelsView
