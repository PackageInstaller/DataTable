-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakRewardView.lua

module("logic.extensions.skypeak.view.SkyPeakRewardView", package.seeall)

local SkyPeakRewardView = class("SkyPeakRewardView", ViewComponent)

function SkyPeakRewardView:ctor()
	SkyPeakRewardView.super.ctor(self)
end

function SkyPeakRewardView:unbindEvents()
	SkyPeakRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSweep)
end

function SkyPeakRewardView:bindEvents()
	SkyPeakRewardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSweep, self._onClickBtnSweep, self)
end

function SkyPeakRewardView:buildUI()
	SkyPeakRewardView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSweep = self:getGo("btnSweep")

	local goCell = self:getGo("tableview/tablecell")
	local goTableView = self:getGo("tableview")

	self._tableView = ScrollerList.create(goTableView, goCell, GameUtil.handler(self._updateCellReward, self), GameUtil.handler(self._clearCellReward, self))
	self._goItem = self:getGo("item")
	self._txtTimeTips = self:getTxt("txtTimeTips")
	self._txtCurStage = self:getTxt("curstage/txt")
end

function SkyPeakRewardView:onExit()
	SkyPeakRewardView.super.onExit(self)
	self._tableView:dispose()
end

function SkyPeakRewardView:onEnter()
	SkyPeakRewardView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SkyPeakGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_SkyPeakSweepRes, self._handleSweep, self)

	self._itemTableviewDic = {}
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = SkyPeakController.instance:getDefaultActivityId() or 0
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	SkyPeakController.instance:getInfo(self._activityId)
end

function SkyPeakRewardView:_updateUIByCfg()
	self._stageCfgs = SkyPeakConfig.instance:getAllStageCfgs(self._activityId) or {}

	local startDay = ActivityDefineController.instance:getActivityCurrentDay(self._activityId)
	local isfirstWeek = startDay <= 7 and startDay > 0

	goutil.setActive(self._btnSweep, not isfirstWeek)
	goutil.setActive(self._txtTimeTips.gameObject, not isfirstWeek)
end

function SkyPeakRewardView:_updateUIByInfo()
	self._curCanSweepCount = 0
	self._curRemainSweepStage = 0
	self._curRemainSweepCount = 0
	self._curMaxPassStageId = SkyPeakModel.instance:getMaxPassStageId(self._activityId)

	local info = SkyPeakModel.instance:getInfo(self._activityId) or {}

	if info then
		self._curCanSweepCount = SkyPeakModel.instance:getTotalPassStageCount(self._activityId)
		self._curRemainSweepCount = info.hasSweepThisWeek and 0 or 1
		self._curRemainSweepStage = SkyPeakModel.instance:getTotalSweepableStageCount(self._activityId)
	end

	self._txtTimeTips.text = self._curRemainSweepCount <= 0 and langPara("本周剩余扫荡次数：<color=#FF4A4AFF>%s</color>", self._curRemainSweepCount) or langPara("本周剩余扫荡次数：%s", self._curRemainSweepCount)
	self._txtCurStage.text = langPara("当前层数：%s", self._curMaxPassStageId)

	self._tableView:reloadData(self._stageCfgs)

	local showId = math.max(self._curMaxPassStageId - 1, 0)
	local stageCount = #self._stageCfgs

	if stageCount > 0 then
		showId = math.min(showId, stageCount - 1)
	end

	self._tableView:setCenterMode(true)
	self._tableView:MoveCellToBegin(showId)
end

function SkyPeakRewardView:_handleSweep()
	TipsFacade.instance:openCommonTips(lang("扫荡成功"))
	self:_updateUIByInfo()
end

function SkyPeakRewardView:_updateCellReward(view, cell, data, tag)
	local go = cell.gameObject
	local info = SkyPeakModel.instance:getStageInfo(self._activityId, data.stageId) or {}
	local isPass = info.prizeState == SkyPeakModel.StatePassStatus.Pass or info.prizeState == SkyPeakModel.StatePassStatus.Sweep
	local txtStage = goutil.findChildTextComponent(go, "txtStage")

	txtStage.text = string.format("第%s层", data.stageId)

	local goTableviewPass = goutil.findChild(go, "tv_prizePass")
	local itemTableViewPass = self._itemTableviewDic[goTableviewPass]

	if not itemTableViewPass then
		local goCell = self._goItem

		itemTableViewPass = ScrollerList.create(goTableviewPass, goCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		self._itemTableviewDic[goTableviewPass] = itemTableViewPass
	end

	if not data.challengePrize then
		local prizeStrPass = ""
		local prizeAttrsPass = string.split(prizeStrPass, "#")
		local temDatalist1 = {}

		for _, v in pairs(prizeAttrsPass) do
			local data = {}

			data.itemStr = v
			data.isGained = isPass
			data.isSweepPrize = false
			data.passState = info.prizeState

			table.insert(temDatalist1, data)
		end

		itemTableViewPass:dragNotifyParent()
		itemTableViewPass:setCenterMode(true)
		itemTableViewPass:reloadData(temDatalist1)

		local goTableviewSweep = goutil.findChild(go, "tv_prizeSweep")
		local itemTableViewSweep = self._itemTableviewDic[goTableviewSweep]

		if not itemTableViewSweep then
			local goCell = self._goItem

			itemTableViewSweep = ScrollerList.create(goTableviewSweep, goCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
			self._itemTableviewDic[goTableviewSweep] = itemTableViewSweep
		end

		if not data.sweepPrize then
			local prizeStrSweep = ""
			local prizeAttrsSweep = string.split(prizeStrSweep, "#")
			local temDatalist = {}

			for _, v in pairs(prizeAttrsSweep) do
				local data = {}

				data.itemStr = v
				data.isGained = isPass
				data.passState = info.prizeState
				data.isSweepPrize = true

				table.insert(temDatalist, data)
			end

			itemTableViewSweep:dragNotifyParent()
			itemTableViewSweep:setCenterMode(true)
			itemTableViewSweep:reloadData(temDatalist)
		end
	end
end

function SkyPeakRewardView:_clearCellReward(cell)
	return
end

function SkyPeakRewardView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local geted = goutil.findChild(go, "geted")

	if data.isGained then
		if data.isSweepPrize then
			goutil.setActive(geted, data.passState == SkyPeakModel.StatePassStatus.Sweep)
		else
			goutil.setActive(geted, data.passState == SkyPeakModel.StatePassStatus.Pass)
		end
	else
		goutil.setActive(geted, false)
	end

	MaterialMgr.setCellByCfg(data.itemStr, icon)
end

function SkyPeakRewardView:_clearItemCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	MaterialMgr.resetAll(icon)
end

function SkyPeakRewardView:_onClickBtnSweep()
	if self._curRemainSweepCount <= 0 then
		TipsFacade.instance:openCommonTips(lang("没有可用的扫荡次数了"))

		return
	end

	if self._curRemainSweepStage <= 0 then
		TipsFacade.instance:openCommonTips(lang("没有可扫荡的关卡了"))

		return
	end

	local newMaxPassStageId = self._curMaxPassStageId + self._curRemainSweepStage
	local prizestr = self:getCurTotalPrizeStr() or ""
	local mattype, matId, matNum = MaterialMgr.getMatParams(prizestr)
	local matName = MaterialMgr.getMaterialsName(mattype, matId)
	local tips = langPara("<size=30>将根据您的首通层数，可扫荡<color=#FF4A4A>第%s-%s层</color>奖励，\n获得<color=#FF4A4A>[%s]X%s</color>，是否确认扫荡?</size> \n \n注:<color=#FF4A4A>扫荡奖励少于首通奖励，扫荡后无法再获得该层首通奖励</color>", self._curMaxPassStageId + 1, newMaxPassStageId, matName, matNum)

	TipsFacade.instance:openPopupWindow(lang("提示"), tips, function()
		SkyPeakController.instance:sweep(self._activityId)
	end, nil, lang("确定"), lang("取消"), UnityEngine.TextAnchor.UpperCenter)
end

function SkyPeakRewardView:getCurTotalPrizeStr()
	local temList = {}

	for i = self._curMaxPassStageId + 1, self._curMaxPassStageId + self._curRemainSweepStage do
		local stageCfg = SkyPeakConfig.instance:getStageCfgById(self._activityId, i)

		if stageCfg and not GameUtil.isEmptyString(stageCfg.sweepPrize) then
			table.insert(temList, stageCfg.sweepPrize)
		end
	end

	local mergeMatStrList = MaterialMgr.mergeMatStrList(temList) or {}

	return table.concat(mergeMatStrList, "#")
end

return SkyPeakRewardView
