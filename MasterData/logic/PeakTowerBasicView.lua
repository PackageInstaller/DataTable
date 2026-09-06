-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerBasicView.lua

module("logic.extensions.peaktower.view.PeakTowerBasicView", package.seeall)

local PeakTowerBasicView = class("PeakTowerBasicView", ViewComponent)

function PeakTowerBasicView:ctor()
	PeakTowerBasicView.super.ctor(self)
end

function PeakTowerBasicView:unbindEvents()
	PeakTowerBasicView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnReset)
	self._dragTowerTab:RemoveDragListener()
	self._dragTowerTab:RemoveBeginDragListener()
	self._dragTowerTab:RemoveEndDragListener()
	self._maxPlayerTableList:removeDragNotifyParent()
end

function PeakTowerBasicView:bindEvents()
	PeakTowerBasicView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	self._dragTowerTab:AddDragListener(self._onDragTowerScroll, self)
	self._dragTowerTab:AddBeginDragListener(self._onBeginTowerScroll, self)
	self._dragTowerTab:AddEndDragListener(self._onEndTowerScroll, self)
	self._maxPlayerTableList:dragNotifyParent()
end

function PeakTowerBasicView:buildUI()
	PeakTowerBasicView.super.buildUI(self)

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
	self._txtUnlockLegend = self:getTxt("tipsUnlock/txt")
	self._txtScore = self:getTxt("stageInfo/txtScore")
	self._btnReset = self:getGo("stageInfo/btnReset")
	self._maxPlayerCell = self:getGo("towerTableview/mexPlayertableview/maxPlayerCell")
	self._mexPlayertableview = self:getGo("towerTableview/mexPlayertableview")
	self._maxPlayerTableList = ScrollerList.create(self._mexPlayertableview, self._maxPlayerCell, GameUtil.handler(self._updateMaxPlayerCell, self), GameUtil.handler(self._clearMaxPlayerCell, self))

	self._maxPlayerTableList:regGetCellSize(GameUtil.handler(self._getMaxPlayerCellSize, self))

	self._maxPlayerSv = self._mexPlayertableview:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._dragTowerTab = Framework.UIDragTrigger.Get(self._towerTableview)
end

function PeakTowerBasicView:_onDragTowerScroll(eventData)
	self._maxPlayerSv:OnDrag(eventData)
end

function PeakTowerBasicView:_onBeginTowerScroll(eventData)
	self._maxPlayerSv:OnBeginDrag(eventData)
end

function PeakTowerBasicView:_onEndTowerScroll(eventData)
	self._maxPlayerSv:OnEndDrag(eventData)
end

function PeakTowerBasicView:onExit()
	PeakTowerBasicView.super.onExit(self)
end

function PeakTowerBasicView:onEnter()
	PeakTowerBasicView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PeakTowerInfoRes, self._refreshView, self)

	self._activityId = self:getFirstParam()
	self._curWeekId = PeakTowerController.instance:getCurWeekId(self._activityId)

	local floorCfg = PeakTowerConfig.instance:getBasicFloorCfgs(self._activityId, self._curWeekId)

	self._floorCfgList = {}

	for i, v in ipairs(floorCfg) do
		table.insert(self._floorCfgList, v.floorId)
	end

	self._curFloor = PeakTowerModel.instance:getBasicMaxPassFloor(self._activityId)
	self._curFloor = self._curFloor + 1

	if self._curFloor > #self._floorCfgList then
		self._curFloor = #self._floorCfgList
	end

	self:_initView()
	self:_refreshView()
	self._towerTableList:MoveCellToBegin(self._curFloor)
	self._maxPlayerTableList:MoveCellToBegin(self._curFloor)
	PeakTowerAgent.instance:sendPM_PeakTowerBasicRankViewReq(self._activityId)
	PeakTowerController.instance:savePopViewName(self._activityId, self._viewPresentor.viewName)
end

function PeakTowerBasicView:_initView()
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

	local activityCfg = PeakTowerConfig.instance:getActivityCfg(self._activityId)

	self._txtUnlockLegend.text = langPara("最高分达到<color=#ff2e2e><size=24>%s</size></color>后开启传奇模式", activityCfg.legendOpenScore)
end

function PeakTowerBasicView:_refreshView()
	self.maxFloor = PeakTowerModel.instance:getBasicMaxPassFloor(self._activityId)
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
	self._towerTableList:reloadData(self._showList)

	self._txtStage.text = langPara("入门模式·第%d层", self._curFloor)

	local maxScore = PeakTowerController.instance:getAllBasicScore(self._activityId)
	local floorInfo = PeakTowerModel.instance:getBasicFloorInfo(self._activityId, self._curFloor)

	self._txtScore.text = langPara("本层最高分：%d\n总最高分数：%d", (floorInfo or nil) and floorInfo.maxScore, maxScore)

	self._maxPlayerTableList:reloadData(self._showList)
end

function PeakTowerBasicView:_updateTowerCell(view, cell, data, tag)
	local go = cell.gameObject

	if data < 0 or data > #self._floorCfgList then
		return
	end

	local txtName = goutil.findChildTextComponent(go, "txtDesc")
	local select = goutil.findChild(go, "select")
	local btn = goutil.findChild(go, "btn")
	local cur = goutil.findChild(go, "cur")
	local myHeadIcon = goutil.findChild(cur, "myHeadIcon")
	local txtMyCurFloor = goutil.findChildTextComponent(cur, "txt")

	txtName.text = langPara("第%d层", data)

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickFloor(data)
	end)

	local curFloor = self.maxFloor

	GameUtil.SetActive(cur, false)
	HeadItemController.instance:resetHeadCell(myHeadIcon)

	if curFloor == data then
		local myHeadInfo = RoleModel.instance:getHeadInfo()

		HeadItemController.instance:setHeadCellByInfo(myHeadIcon, myHeadInfo)
		GameUtil.SetActive(cur, true)

		txtMyCurFloor.text = langPara("当前第<color=#ff2e2e><size=24>%d</size></color>层", curFloor)
	end

	local maxPlayerInfo

	if maxPlayerInfo then
		HeadItemController.instance:setHeadCellByInfo(maxPlayerHead, maxPlayerInfo.headInfo, true)

		txtMaxPlayerName.text = maxPlayerInfo.headInfo.userName
		txtMaxPlayerScore.text = maxPlayerInfo.value

		GameUtil.SetActive(maxPlayerInfoGo, true)
	else
		GameUtil.SetActive(maxPlayerInfoGo, false)
	end

	GameUtil.SetActive(select, self._curFloor == data)
end

function PeakTowerBasicView:_clearTowerCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function PeakTowerBasicView:_getTowerCellTagByIdx(data, index)
	if data <= 0 then
		return 1
	elseif data > #self._floorCfgList then
		return 3
	else
		return 2
	end
end

function PeakTowerBasicView:_getTowerCellSize(view, index)
	if self._showList[index + 1] <= 0 then
		return GameUtil.getWidth(self._towerTablecell_1), GameUtil.getHeight(self._towerTablecell_1)
	elseif self._showList[index + 1] > #self._floorCfgList then
		return GameUtil.getWidth(self._towerTablecell_3), GameUtil.getHeight(self._towerTablecell_3) - 320
	else
		return GameUtil.getWidth(self._towerTablecell_2), GameUtil.getHeight(self._towerTablecell_2)
	end
end

function PeakTowerBasicView:_getMaxPlayerCellSize(view, index)
	if self._showList[index + 1] <= 0 then
		return GameUtil.getWidth(self._towerTablecell_1), GameUtil.getHeight(self._towerTablecell_1)
	elseif self._showList[index + 1] > #self._floorCfgList then
		return GameUtil.getWidth(self._towerTablecell_3), GameUtil.getHeight(self._towerTablecell_3) - 116 - 320
	else
		return GameUtil.getWidth(self._towerTablecell_2), GameUtil.getHeight(self._towerTablecell_2)
	end
end

function PeakTowerBasicView:_updateMaxPlayerCell(view, cell, data, tag)
	local go = cell.gameObject
	local bg = goutil.findChild(go, "bg")
	local infoGo = goutil.findChild(go, "info")
	local maxPlayerHead = goutil.findChild(go, "info/headIcon")
	local emptyGo = goutil.findChild(go, "empty")
	local txtMaxPlayerName = goutil.findChildTextComponent(go, "info/txtName")
	local txtMaxPlayerScore = goutil.findChildTextComponent(go, "info/txtScore")

	HeadItemController.instance:resetHeadCell(maxPlayerHead)

	if data < 0 or data > #self._floorCfgList then
		GameUtil.SetActive(bg, false)
		GameUtil.SetActive(infoGo, false)
		GameUtil.SetActive(emptyGo, false)
	else
		GameUtil.SetActive(bg, data % 2 == 1)

		local maxPlayerInfo = PeakTowerModel.instance:getBasicRankInfo(self._activityId, data)

		if maxPlayerInfo then
			HeadItemController.instance:setHeadCellByInfo(maxPlayerHead, maxPlayerInfo.headInfo, true)

			txtMaxPlayerName.text = maxPlayerInfo.headInfo.userName
			txtMaxPlayerScore.text = maxPlayerInfo.value

			GameUtil.SetActive(infoGo, true)
			GameUtil.SetActive(emptyGo, false)
		else
			HeadItemController.instance:resetHeadCell(maxPlayerHead)
			GameUtil.SetActive(infoGo, false)
			GameUtil.SetActive(emptyGo, true)
		end
	end
end

function PeakTowerBasicView:_clearMaxPlayerCell(cell)
	return
end

function PeakTowerBasicView:_updateConditionCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgGo = goutil.findChild(go, "bg")
	local txtAliveCondition = goutil.findChildTextComponent(go, "txtAliveCondition")
	local txtCircleCondition = goutil.findChildTextComponent(go, "txtCircleCondition")

	txtAliveCondition.text = data.aliveCfg and langPara("%d只→%d分", data.aliveCfg.aliveNum[1], data.aliveCfg.score) or ""
	txtCircleCondition.text = data.circleCfg and langPara("%d回合→%d分", data.circleCfg.circle[2], data.circleCfg.score) or ""

	GameUtil.SetActive(bgGo, data.index % 2 == 1)
end

function PeakTowerBasicView:_clearConditionCell(cell)
	return
end

function PeakTowerBasicView:_onClickFloor(floorId)
	if floorId > self.maxFloor then
		FloatWordMgr.instance:show(lang("请通关前面的关卡"))

		return
	end

	if self._curFloor ~= floorId then
		self._curFloor = floorId

		self:_refreshView()
	end
end

function PeakTowerBasicView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.PeakTowerStageView, self._activityId, 1, self._curFloor)
end

function PeakTowerBasicView:_onClickReset()
	local stageList = PeakTowerConfig.instance:getBasicStageCfgs(self._activityId, self._curWeekId, self._curFloor)
	local hasInfo = false

	for i, v in ipairs(stageList) do
		if PeakTowerModel.instance:isBasicStagePass(self._activityId, self._curFloor, v.stageId) then
			hasInfo = true

			break
		end
	end

	if hasInfo == true then
		local content = langPara("是否重置第%d层挑战记录和上锁精灵？\n注：重置不影响本层最高分数。", self._curFloor)

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			PeakTowerAgent.instance:sendPM_PeakTowerResetFloorReq(self._activityId, 1, self._curFloor)
		end)
	else
		FloatWordMgr.instance:show("未通关任意关卡")
	end
end

return PeakTowerBasicView
