-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerLegendView.lua

module("logic.extensions.peaktower.view.PeakTowerLegendView", package.seeall)

local PeakTowerLegendView = class("PeakTowerLegendView", ViewComponent)
local SHOW_TOP_COUNT = 5

function PeakTowerLegendView:ctor()
	PeakTowerLegendView.super.ctor(self)
end

function PeakTowerLegendView:unbindEvents()
	PeakTowerLegendView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnReset)
end

function PeakTowerLegendView:bindEvents()
	PeakTowerLegendView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function PeakTowerLegendView:buildUI()
	PeakTowerLegendView.super.buildUI(self)

	self._btnChallenge = self:getGo("stageInfo/btnChallenge")
	self._btnClose = self:getGo("btnClose")
	self._towerTablecell_1 = self:getGo("towerTableview/towerTablecell_1")
	self._towerTablecell_2 = self:getGo("towerTableview/towerTablecell_2")
	self._towerTablecell_3 = self:getGo("towerTableview/towerTablecell_3")

	local towerTablecells = {
		self._towerTablecell_1,
		self._towerTablecell_2,
		self._towerTablecell_3
	}

	self._towerTableview = self:getGo("towerTableview")
	self._towerTableList = ScrollerList.create(self._towerTableview, towerTablecells, GameUtil.handler(self._updateTowerCell, self), GameUtil.handler(self._clearTowerCell, self))

	self._towerTableList:regGetTagByIdx(GameUtil.handler(self._getTowerCellTagByIdx, self))
	self._towerTableList:regGetCellSize(GameUtil.handler(self._getTowerCellSize, self))

	self._scoreTableview = self:getGo("stageInfo/scoreTableview")
	self._conditionTablecell = self:getGo("stageInfo/conditionTablecell")
	self._scoreTableList = ScrollerList.create(self._scoreTableview, self._conditionTablecell, GameUtil.handler(self._updateConditionCell, self), GameUtil.handler(self._clearConditionCell, self))
	self._txtStage = self:getTxt("stageInfo/txtStage")
	self._myHeadIcon = self:getGo("cur/myHeadIcon")
	self._txtCurFloor = self:getTxt("cur/txt")
	self._txtBuffContent = self:getTxt("stageInfo/buffScrollview/viewport/content")
	self._buffTip = self:getGo("stageInfo/buffTip")
	self._txtBuffTip = self:getTxt("stageInfo/buffTip/txtBuffTip")
	self._txtScore = self:getTxt("stageInfo/txtScore")
	self._btnReset = self:getGo("stageInfo/btnReset")
end

function PeakTowerLegendView:onExit()
	PeakTowerLegendView.super.onExit(self)
end

function PeakTowerLegendView:onEnter()
	PeakTowerLegendView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PeakTowerInfoRes, self._refreshView, self)

	self._activityId = self:getFirstParam()
	self._curWeekId = PeakTowerController.instance:getCurWeekId(self._activityId)

	local floorCfg = PeakTowerConfig.instance:getLegendFloorCfgs(self._activityId, self._curWeekId)

	self._floorCfgList = {}

	for i, v in ipairs(floorCfg) do
		table.insert(self._floorCfgList, v.floorId)
	end

	self._curFloor = PeakTowerModel.instance:getLegendMaxPassFloor(self._activityId)
	self._curFloor = self._curFloor + 1

	if self._curFloor > #self._floorCfgList then
		self._curFloor = #self._floorCfgList
	end

	self:_initView()
	self:_refreshView()
	self._towerTableList:MoveCellToBegin(self._curFloor)
	PeakTowerAgent.instance:sendPM_PeakTowerLegendRankViewReq(self._activityId)
	PeakTowerController.instance:savePopViewName(self._activityId, self._viewPresentor.viewName)
end

function PeakTowerLegendView:_initView()
	local aliveCfgs = PeakTowerConfig.instance:getAliveNumScoreCfgs(self._activityId)
	local aliveList = {}

	for k, v in pairs(aliveCfgs) do
		table.insert(aliveList, v)
	end

	table.sort(aliveList, function(a, b)
		return a.aliveNum[1] < b.aliveNum[1]
	end)

	local circleNumCfgs = PeakTowerConfig.instance:getCircleNumScoreCfgs(self._activityId)
	local circleNumList = {}

	for k, v in pairs(circleNumCfgs) do
		table.insert(circleNumList, v)
	end

	table.sort(circleNumList, function(a, b)
		return a.circle[1] < b.circle[1]
	end)

	local conditionList = {}

	for i, v in ipairs(aliveList) do
		table.insert(conditionList, {
			aliveCfg = v
		})
	end

	for i, v in ipairs(circleNumList) do
		if conditionList[i] then
			conditionList[i].circleCfg = v
		else
			table.insert(conditionList, {
				circleCfg = v
			})
		end
	end

	for i, v in ipairs(conditionList) do
		conditionList[i].index = i
	end

	self._scoreTableList:reloadData(conditionList)

	local myHeadInfo = RoleModel.instance:getHeadInfo()

	HeadItemController.instance:setHeadCellByInfo(self._myHeadIcon, myHeadInfo)
end

function PeakTowerLegendView:_refreshView()
	self.maxFloor = PeakTowerModel.instance:getLegendMaxPassFloor(self._activityId)
	self.maxFloor = self.maxFloor + 1

	if self.maxFloor > #self._floorCfgList then
		self.maxFloor = #self._floorCfgList
	end

	self._showList = {
		[1] = -1
	}

	for i, v in ipairs(self._floorCfgList) do
		table.insert(self._showList, v)
	end

	table.insert(self._showList, #self._floorCfgList + 1)

	self._rankInfoList = {}

	local rankInfo = PeakTowerModel.instance:getLegendRankInfo(self._activityId)

	if rankInfo and rankInfo.infoList then
		for i, v in ipairs(rankInfo.infoList) do
			if v.rank <= SHOW_TOP_COUNT then
				self._rankInfoList[v.rank] = v
			end
		end
	end

	self._towerTableList:reloadData(self._showList)

	self._txtStage.text = langPara("传奇模式·第%s层", GameUtil.getChineseNumber(self._curFloor))
	self._txtCurFloor.text = langPara("当前第%d层", self.maxFloor)

	local activeBuffList = {}
	local nextActiveBuffStageId
	local floorCfgs = PeakTowerConfig.instance:getLegendFloorCfgs(self._activityId, self._curWeekId)

	for i = 1, #floorCfgs do
		if i <= self._curFloor then
			for j, v in ipairs(floorCfgs[i].polluteBuffId or {}) do
				local buffCfg = PeakTowerConfig.instance:getBuffCfg(self._activityId, v)

				table.insert(activeBuffList, buffCfg)
			end
		elseif floorCfgs[i].polluteBuffId and #floorCfgs[i].polluteBuffId > 0 then
			nextActiveBuffStageId = floorCfgs[i].floorId

			break
		end
	end

	if nextActiveBuffStageId then
		GameUtil.SetActive(self._buffTip, true)

		self._txtBuffTip.text = langPara("到达<color=#F12F2EFF>第%s层</color>将增加1个污染效果", GameUtil.getChineseNumber(nextActiveBuffStageId))
	else
		GameUtil.SetActive(self._buffTip, false)

		self._txtBuffTip.text = ""
	end

	local buffContent = ""

	for i, v in ipairs(activeBuffList) do
		local singleDesc = langPara("效果%d：%s", i, v.desc)

		buffContent = string.nilorempty(buffContent) and singleDesc or buffContent .. "\n" .. singleDesc
	end

	self._txtBuffContent.text = buffContent

	local maxScore = PeakTowerController.instance:getAllLegendScore(self._activityId)
	local floorInfo = PeakTowerModel.instance:getLegendFloorInfo(self._activityId, self._curFloor)

	self._txtScore.text = langPara("本层最高分：%d\n总最高分数：%d", (floorInfo or nil) and floorInfo.maxScore, maxScore)
end

function PeakTowerLegendView:_updateTowerCell(view, cell, data, tag)
	if data > 0 and data <= #self._floorCfgList then
		self:_updateTowerStageCell(view, cell, data, tag)
	elseif data > #self._floorCfgList then
		self:_updateTowerTopCell(view, cell, data, tag)
	end
end

function PeakTowerLegendView:_clearTowerCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local maxPlayerTop1Go = goutil.findChild(go, "maxTop_1")
	local maxPlayerTop2Go = goutil.findChild(go, "maxTop_2")
	local maxPlayerTop3Go = goutil.findChild(go, "maxTop_3")
	local maxPlayerTop4Go = goutil.findChild(go, "maxTop_4")
	local maxPlayerTop5Go = goutil.findChild(go, "maxTop_5")

	if maxPlayerTop1Go then
		HeadItemController.instance:resetHeadCell(maxPlayerTop1Go)
	end

	if maxPlayerTop2Go then
		HeadItemController.instance:resetHeadCell(maxPlayerTop2Go)
	end

	if maxPlayerTop3Go then
		HeadItemController.instance:resetHeadCell(maxPlayerTop3Go)
	end

	if maxPlayerTop4Go then
		HeadItemController.instance:resetHeadCell(maxPlayerTop4Go)
	end

	if maxPlayerTop4Go then
		HeadItemController.instance:resetHeadCell(maxPlayerTop5Go)
	end

	GameUtil.rmClickHandler(btn)
end

function PeakTowerLegendView:_updateTowerStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtDesc")
	local select = goutil.findChild(go, "select")
	local btn = goutil.findChild(go, "btn")
	local maxPlayerTop4Go = goutil.findChild(go, "maxTop_4")
	local maxPlayerTop5Go = goutil.findChild(go, "maxTop_5")

	txtName.text = langPara("第%d层", data)

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickFloor(data)
	end)
	GameUtil.SetActive(select, self._curFloor == data)

	if data == #self._floorCfgList then
		self:_updateMaxPlayInfo(maxPlayerTop4Go, 4)
		self:_updateMaxPlayInfo(maxPlayerTop5Go, 5)
	else
		HeadItemController.instance:resetHeadCell(maxPlayerTop4Go)
		HeadItemController.instance:resetHeadCell(maxPlayerTop5Go)
		GameUtil.SetActive(maxPlayerTop4Go, false)
		GameUtil.SetActive(maxPlayerTop5Go, false)
	end
end

function PeakTowerLegendView:_updateTowerTopCell(view, cell, data, tag)
	local go = cell.gameObject
	local maxPlayerTop1Go = goutil.findChild(go, "maxTop_1")
	local maxPlayerTop2Go = goutil.findChild(go, "maxTop_2")
	local maxPlayerTop3Go = goutil.findChild(go, "maxTop_3")

	self:_updateMaxPlayInfo(maxPlayerTop1Go, 1)
	self:_updateMaxPlayInfo(maxPlayerTop2Go, 2)
	self:_updateMaxPlayInfo(maxPlayerTop3Go, 3)
end

function PeakTowerLegendView:_updateMaxPlayInfo(go, rank)
	local maxPlayerInfo = self._rankInfoList[rank]
	local headIcon = goutil.findChild(go, "headIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	if maxPlayerInfo then
		HeadItemController.instance:setHeadCellByInfo(headIcon, maxPlayerInfo.headInfo, true)
		GameUtil.SetActive(go, true)

		txtName.text = maxPlayerInfo.headInfo.userName
		txtScore.text = langPara("当前第<color=#ff2e2e><size=24>%d</size></color>名\n积分：%d", rank, checknumber(maxPlayerInfo.value))
	else
		GameUtil.SetActive(go, false)
		HeadItemController.instance:resetHeadCell(go)
	end
end

function PeakTowerLegendView:_getTowerCellTagByIdx(data, index)
	if data <= 0 then
		return 1
	elseif data > #self._floorCfgList then
		return 3
	else
		return 2
	end
end

function PeakTowerLegendView:_getTowerCellSize(view, index)
	if self._showList[index + 1] <= 0 then
		return GameUtil.getWidth(self._towerTablecell_1), GameUtil.getHeight(self._towerTablecell_1)
	elseif self._showList[index + 1] > #self._floorCfgList then
		return GameUtil.getWidth(self._towerTablecell_3), GameUtil.getHeight(self._towerTablecell_3) - 150
	else
		return GameUtil.getWidth(self._towerTablecell_2), GameUtil.getHeight(self._towerTablecell_2)
	end
end

function PeakTowerLegendView:_updateConditionCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgGo = goutil.findChild(go, "bg")
	local txtAliveCondition = goutil.findChildTextComponent(go, "txtAliveCondition")
	local txtCircleCondition = goutil.findChildTextComponent(go, "txtCircleCondition")

	txtAliveCondition.text = data.aliveCfg and langPara("%d只→%d分", data.aliveCfg.aliveNum[1], data.aliveCfg.score) or ""
	txtCircleCondition.text = data.circleCfg and langPara("%d回合→%d分", data.circleCfg.circle[2], data.circleCfg.score) or ""

	GameUtil.SetActive(bgGo, data.index % 2 == 1)
end

function PeakTowerLegendView:_clearConditionCell(cell)
	return
end

function PeakTowerLegendView:_onClickFloor(floorId)
	if floorId > self.maxFloor then
		FloatWordMgr.instance:show(lang("请通关前面的关卡"))

		return
	end

	if self._curFloor ~= floorId then
		self._curFloor = floorId

		self:_refreshView()
	end
end

function PeakTowerLegendView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.PeakTowerStageView, self._activityId, 2, self._curFloor)
end

function PeakTowerLegendView:_onClickReset()
	local stageList = PeakTowerConfig.instance:getLegendStageCfgs(self._activityId, self._curWeekId, self._curFloor)
	local hasInfo = false

	for i, v in ipairs(stageList) do
		if PeakTowerModel.instance:isLegendStagePass(self._activityId, self._curFloor, v.stageId) then
			hasInfo = true

			break
		end
	end

	if hasInfo == true then
		local content = langPara("是否重置第%d层挑战记录和上锁精灵？\n注：重置不影响本层最高分数。", self._curFloor)

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			PeakTowerAgent.instance:sendPM_PeakTowerResetFloorReq(self._activityId, 2, self._curFloor)
		end)
	else
		FloatWordMgr.instance:show("未通关任意关卡")
	end
end

return PeakTowerLegendView
