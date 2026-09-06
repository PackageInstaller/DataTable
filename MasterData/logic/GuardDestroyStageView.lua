-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/view/GuardDestroyStageView.lua

module("logic.extensions.guarddestroy.view.GuardDestroyStageView", package.seeall)

local GuardDestroyStageView = class("GuardDestroyStageView", ViewComponent)

function GuardDestroyStageView:ctor()
	GuardDestroyStageView.super.ctor(self)
end

function GuardDestroyStageView:unbindEvents()
	GuardDestroyStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function GuardDestroyStageView:bindEvents()
	GuardDestroyStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function GuardDestroyStageView:buildUI()
	GuardDestroyStageView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtScoreType1 = self:getTxt("txtScoreType1")
	self._txtScoreType2 = self:getTxt("txtScoreType2")
end

function GuardDestroyStageView:onExit()
	GuardDestroyStageView.super.onExit(self)
	self._tableList:dispose()
end

function GuardDestroyStageView:onEnter()
	GuardDestroyStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GuardDestroyGetInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	self:_refreshView()
	GuardDestroyController.instance:checkBattleResultComfirm()
end

function GuardDestroyStageView:_refreshView()
	local list = GuardDestroyConfig.instance:getStageCfgs(self._activityId)

	self._tableList:reloadData(list)

	self._txtScoreType1.text = langPara("累计存活：%d", GuardDestroyModel.instance:getProgress(self._activityId, 1))
	self._txtScoreType2.text = langPara("累计击杀：%d", GuardDestroyModel.instance:getProgress(self._activityId, 2))

	local maxPassStage = 0

	for i, v in ipairs(list) do
		if GuardDestroyModel.instance:_isStagePass(self._activityId, v.stageId) then
			maxPassStage = v.stageId
		end
	end

	if maxPassStage == #list then
		maxPassStage = maxPassStage - 1
	end

	self._tableList:MoveCellToCenter(maxPassStage)
end

function GuardDestroyStageView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local type1TeamEnemy = goutil.findChild(go, "teamEnemyType1")
	local type2TeamEnemy = goutil.findChild(go, "teamEnemyType2")
	local btnType1 = goutil.findChild(type1TeamEnemy, "btn")
	local btnType2 = goutil.findChild(type2TeamEnemy, "btn")
	local txtStage = goutil.findChildTextComponent(go, "stage/txtStage")
	local scoreType1Go = goutil.findChild(go, "scoreType1")
	local scoreType2Go = goutil.findChild(go, "scoreType2")
	local txtType1Score = goutil.findChildTextComponent(scoreType1Go, "txtScore")
	local txtType2Score = goutil.findChildTextComponent(scoreType2Go, "txtScore")
	local scoreEmpty1 = goutil.findChild(go, "scoreEmpty1")
	local scoreEmpty2 = goutil.findChild(go, "scoreEmpty2")
	local openTimeGo = goutil.findChild(go, "openTime")
	local txtTime = goutil.findChildTextComponent(go, "openTime/txtTime")

	txtStage.text = langPara("第%d关", data.stageId)

	local teamGoMap = {}

	for i = 1, 9 do
		local cellGo = goutil.findChild(type1TeamEnemy, "cell_" .. i)
		local cellCon = goutil.findChild(type1TeamEnemy, "cell_" .. i .. "/icon")

		MaterialMgr.resetAll(cellCon)
		GameUtil.SetActive(cellGo, false)

		teamGoMap[i] = {
			con = cellCon,
			go = cellGo
		}
	end

	local creepCfg1 = GuardDestroyConfig.instance:getCreepsCfg(data.type1CreepsMasterId)

	for i, v in ipairs(creepCfg1) do
		if teamGoMap[v.posId] then
			local proxy = MaterialMgr.setIcon(teamGoMap[v.posId].con, MatType.Pet, v.raceId)

			GameUtil.SetActive(teamGoMap[v.posId].go, true)
		end
	end

	for i = 1, 9 do
		local cellGo = goutil.findChild(type2TeamEnemy, "cell_" .. i)
		local cellCon = goutil.findChild(type2TeamEnemy, "cell_" .. i .. "/icon")

		MaterialMgr.resetAll(cellCon)
		GameUtil.SetActive(cellGo, false)

		teamGoMap[i].con = cellCon
		teamGoMap[i].go = cellGo
	end

	local creepCfg2 = GuardDestroyConfig.instance:getCreepsCfg(data.type2CreepsMasterId)

	for i, v in ipairs(creepCfg2) do
		if teamGoMap[v.posId] then
			local proxy = MaterialMgr.setIcon(teamGoMap[v.posId].con, MatType.Pet, v.raceId)

			GameUtil.SetActive(teamGoMap[v.posId].go, true)
		end
	end

	GameUtil.rmClickHandler(btnType1)
	GameUtil.rmClickHandler(btnType2)
	GameUtil.addClickHandler(btnType1, function()
		self:_onClickStage(data.stageId, 1)
	end)
	GameUtil.addClickHandler(btnType2, function()
		self:_onClickStage(data.stageId, 2)
	end)

	local isOnTime, openTimeStamp = GuardDestroyController.instance:isStageOpen(self._activityId, data.stageId)
	local isOpen = GuardDestroyModel.instance:_isStagePass(self._activityId, data.stageId - 1) == true

	GameUtil.SetActive(openTimeGo, not isOnTime)
	GameUtil.SetGray(type1TeamEnemy, not isOnTime)
	GameUtil.SetGray(type2TeamEnemy, not isOnTime)

	local opemTimeDate = GameUtil.time2date(openTimeStamp)

	txtTime.text = langPara("%d.%d %d:%02d后开放", opemTimeDate.month, opemTimeDate.day, opemTimeDate.hour, opemTimeDate.min)

	local type1Info = GuardDestroyModel.instance:getStageScore(self._activityId, data.stageId, 1)

	if type1Info and type1Info >= 0 then
		txtType1Score.text = langPara("存活数：%d", type1Info)

		GameUtil.SetActive(scoreType1Go, isOnTime and isOpen)
		GameUtil.SetActive(scoreEmpty1, false)
	else
		GameUtil.SetActive(scoreType1Go, false)
		GameUtil.SetActive(scoreEmpty1, isOnTime and isOpen)
	end

	local type2Info = GuardDestroyModel.instance:getStageScore(self._activityId, data.stageId, 2)

	if type2Info and type2Info >= 0 then
		txtType2Score.text = langPara("击杀数：%d", type2Info)

		GameUtil.SetActive(scoreType2Go, isOnTime and isOpen)
		GameUtil.SetActive(scoreEmpty2, false)
	else
		GameUtil.SetActive(scoreType2Go, false)
		GameUtil.SetActive(scoreEmpty2, isOnTime and isOpen)
	end
end

function GuardDestroyStageView:_clearCell(cell)
	local go = cell.gameObject
	local type1TeamEnemy = goutil.findChild(go, "teamEnemyType1")
	local type2TeamEnemy = goutil.findChild(go, "teamEnemyType2")
	local btnType1 = goutil.findChild(type1TeamEnemy, "btn")
	local btnType2 = goutil.findChild(type2TeamEnemy, "btn")

	for i = 1, 9 do
		local cellGo = goutil.findChild(type1TeamEnemy, "cell_" .. i)
		local cellCon = goutil.findChild(type1TeamEnemy, "cell_" .. i .. "/icon")

		MaterialMgr.resetAll(cellCon)
		GameUtil.SetActive(cellGo, false)
	end

	for i = 1, 9 do
		local cellGo = goutil.findChild(type2TeamEnemy, "cell_" .. i)
		local cellCon = goutil.findChild(type2TeamEnemy, "cell_" .. i .. "/icon")

		MaterialMgr.resetAll(cellCon)
		GameUtil.SetActive(cellGo, false)
	end

	GameUtil.rmClickHandler(btnType1)
	GameUtil.rmClickHandler(btnType2)
end

function GuardDestroyStageView:_onClickStage(stageId, type)
	if GuardDestroyModel.instance:_isStagePass(self._activityId, stageId - 1) == true then
		local stageCfg = GuardDestroyConfig.instance:getStageCfg(self._activityId, stageId)
		local isOnTime, openTimeStamp = GuardDestroyController.instance:isStageOpen(self._activityId, stageId)

		if isOnTime == true then
			local creepsMasterId

			GuardDestroyController.instance:openMissionView(self._activityId, stageId, type, type == 1 and stageCfg.type1CreepsMasterId or stageCfg.type2CreepsMasterId)
		else
			FloatWordMgr.instance:show(lang("未到开启时间"))
		end
	else
		FloatWordMgr.instance:show(lang("请通关前面的关卡"))
	end
end

function GuardDestroyStageView:_onClickTip()
	TipsFacade.instance:openRulesView("guard_destroy_rule")
end

return GuardDestroyStageView
