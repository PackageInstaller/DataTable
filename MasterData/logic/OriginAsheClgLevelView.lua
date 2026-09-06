-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/view/OriginAsheClgLevelView.lua

module("logic.extensions.originasheclg.view.OriginAsheClgLevelView", package.seeall)

local OriginAsheClgLevelView = class("OriginAsheClgLevelView", ViewComponent)

function OriginAsheClgLevelView:ctor()
	OriginAsheClgLevelView.super.ctor(self)
end

function OriginAsheClgLevelView:unbindEvents()
	OriginAsheClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnFirstFormation)
	GameUtil.rmClickHandler(self._btnSecondFormation)
end

function OriginAsheClgLevelView:bindEvents()
	OriginAsheClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnFirstFormation, self._onClickFirstFomtion, self)
	GameUtil.addClickHandler(self._btnSecondFormation, self._onClickSecondFomtion, self)
end

function OriginAsheClgLevelView:buildUI()
	OriginAsheClgLevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._firstFormation = self:getGo("firstFormation")

	local firstTeamGo = self:getGo("firstFormation/teamEnemy")

	self._firstPetList = {}

	for i = 1, 9 do
		self._firstPetList[i] = {
			go = goutil.findChild(firstTeamGo, "cell_" .. i),
			con = goutil.findChild(firstTeamGo, "cell_" .. i .. "/icon")
		}
	end

	self._firstEmptyGo = self:getGo("firstFormation/teamEnemy/mask")
	self._firstPassGo = self:getGo("firstFormation/pass")
	self._btnFirstFormation = self:getGo("firstFormation/teamEnemy/btn")
	self._txtFirstWinDesc = self:getTxt("firstFormation/txtWinDesc")
	self._secondFormation = self:getGo("secondFormation")

	local secondTeamGo = self:getGo("secondFormation/teamEnemy")

	self._secondPetList = {}

	for i = 1, 9 do
		self._secondPetList[i] = {
			go = goutil.findChild(secondTeamGo, "cell_" .. i),
			con = goutil.findChild(secondTeamGo, "cell_" .. i .. "/icon")
		}
	end

	self._secondEmptyGo = self:getGo("secondFormation/teamEnemy/mask")
	self._secondEmptyTextGo = self:getGo("secondFormation/teamEnemy/mask/empty/txt")
	self._secondPassGo = self:getGo("secondFormation/pass")
	self._secondOpenTips = self:getGo("secondFormation/openTips")
	self._btnSecondFormation = self:getGo("secondFormation/teamEnemy/btn")
	self._txtSecondWinDesc = self:getTxt("secondFormation/txtWinDesc")
	self._enemyFormation = self:getGo("enemyFormation")

	local enemyTeamGo = self:getGo("enemyFormation/teamEnemy")

	self._enemyPetList = {}

	for i = 1, 9 do
		local go = goutil.findChild(enemyTeamGo, "cell_" .. i)

		self._enemyPetList[i] = {
			go = go,
			con = goutil.findChild(go, "icon"),
			txtHpRate = goutil.findChildTextComponent(go, "hp/txt")
		}
	end

	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableView/tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._prizeReceive = self:getGo("passItem/receive")
	self._prizeCon = self:getGo("passItem/con")
	self._btnReset = self:getGo("btnReset")
end

function OriginAsheClgLevelView:onExit()
	OriginAsheClgLevelView.super.onExit(self)
	self:_resetFormation(self._firstPetList)
	self:_resetFormation(self._secondPetList)
	self:_resetFormation(self._enemyPetList)
	MaterialMgr.resetAll(self._prizeCon)
end

function OriginAsheClgLevelView:onEnter()
	OriginAsheClgLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_OriginAsheClgGetInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._maxPassStage = OriginAsheClgModel.instance:getMaxPassStage(self._activityId)

	local stagCfgs = OriginAsheClgConfig.instance:getStageCfgs(self._activityId)

	if not self._curStageId or #stagCfgs > self._maxPassStage then
		self._curStageId = self._maxPassStage + 1
	end

	self:_refreshView()
	self._tableList:MoveCellToCenter(self._curStageId - 1)
end

function OriginAsheClgLevelView:_refreshView()
	self._maxPassStage = OriginAsheClgModel.instance:getMaxPassStage(self._activityId)

	local list = OriginAsheClgConfig.instance:getStageCfgs(self._activityId)

	if self._curStageId > #list then
		self._curStageId = #list
	end

	self._tableList:reloadData(list)
	self:_refreshEnemyFormation()
	self:_resetFormation(self._firstPetList)
	self:_resetFormation(self._secondPetList)

	local curStageCfg = OriginAsheClgConfig.instance:getStageCfg(self._activityId, self._curStageId)
	local winDesc1 = curStageCfg.winDesc[1]

	if string.nilorempty(winDesc1) then
		winDesc1 = BattleSettlementController.instance:getDescByWinId(curStageCfg.winIds[1])
	end

	local winDesc2 = curStageCfg.winDesc[2]

	if string.nilorempty(winDesc2) then
		winDesc2 = BattleSettlementController.instance:getDescByWinId(curStageCfg.winIds[2])
	end

	self._txtFirstWinDesc.text = langPara("通关目标:%s", winDesc1)
	self._txtSecondWinDesc.text = langPara("通关目标:%s", winDesc2)

	local firstInfo = OriginAsheClgModel.instance:getPetInfo(self._activityId, self._curStageId, 1)

	if firstInfo then
		for i, v in pairs(firstInfo) do
			if self._firstPetList[i] and v > 0 then
				GameUtil.setLocalScale(self._firstPetList[i].con, 0.8, 0.8, 0.8)

				local proxy = MaterialMgr.setCell(MatType.Pet, v, self._firstPetList[i].con)

				if proxy then
					proxy.binder:setAutoTips(false)
				end

				GameUtil.SetActive(self._firstPetList[i].go, true)
			end
		end

		GameUtil.SetActive(self._firstPassGo, true)
		GameUtil.SetActive(self._firstEmptyGo, false)
	else
		GameUtil.SetActive(self._firstPassGo, false)
		GameUtil.SetActive(self._firstEmptyGo, true)
	end

	local secondInfo = OriginAsheClgModel.instance:getPetInfo(self._activityId, self._curStageId, 2)

	if secondInfo then
		for i, v in pairs(secondInfo) do
			if self._secondPetList[i] and v > 0 then
				GameUtil.setLocalScale(self._secondPetList[i].con, 0.8, 0.8, 0.8)

				local proxy = MaterialMgr.setCell(MatType.Pet, v, self._secondPetList[i].con)

				if proxy then
					proxy.binder:setAutoTips(false)
				end

				GameUtil.SetActive(self._secondPetList[i].go, true)
			end
		end

		GameUtil.SetActive(self._secondPassGo, true)
		GameUtil.SetActive(self._secondEmptyGo, false)
	else
		GameUtil.SetActive(self._secondPassGo, false)
		GameUtil.SetActive(self._secondEmptyGo, true)
	end

	GameUtil.SetActive(self._secondOpenTips, firstInfo == nil and secondInfo == nil)
	GameUtil.SetActive(self._secondEmptyTextGo, firstInfo ~= nil and secondInfo == nil)
	MaterialMgr.resetAll(self._prizeCon)
	MaterialMgr.setCellByCfg(curStageCfg.passPrize, self._prizeCon)
	GameUtil.SetActive(self._prizeReceive, self._curStageId <= self._maxPassStage)
end

function OriginAsheClgLevelView:_refreshEnemyFormation()
	self:_resetFormation(self._enemyPetList)

	local curStageCfg = OriginAsheClgConfig.instance:getStageCfg(self._activityId, self._curStageId)
	local enemyCreepCfg = OriginAsheClgConfig.instance:getCreepsCfg(curStageCfg.creepsMasterId)
	local stageInfo = OriginAsheClgModel.instance:getStageInfo(self._activityId, self._curStageId)
	local hpMap = {}

	if stageInfo and stageInfo.info.hpWanPercent then
		for i, v in ipairs(stageInfo.info.hpWanPercent) do
			hpMap[v.left] = v.right
		end
	end

	for i, v in ipairs(enemyCreepCfg) do
		if self._enemyPetList[v.posId] then
			GameUtil.setLocalScale(self._enemyPetList[v.posId].con, 0.8, 0.8, 0.8)

			local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, self._enemyPetList[v.posId].con)

			if proxy then
				proxy.binder:setAutoTips(false)
			end

			GameUtil.SetActive(self._enemyPetList[v.posId].go, true)

			self._enemyPetList[v.posId].txtHpRate.text = (not stageInfo or checknumber(stageInfo.info.passBattleSeq) <= 0 or not hpMap[v.creepsId]) and string.format("%d%%", 100) or string.format("%.0f%%", math.ceil(hpMap[v.creepsId] / 100))
		end
	end
end

function OriginAsheClgLevelView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local passTag = goutil.findChild(go, "passTag")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local openTag = goutil.findChild(go, "openTips")
	local closeMask = goutil.findChild(go, "closeMask")
	local selectGo = goutil.findChild(go, "imgSelect")

	txtName.text = langPara("第%s关", GameUtil.getChineseNumber(data.stageId))

	GameUtil.addClickHandler(go, function()
		self:_onClickStage(data.stageId)
	end)
	GameUtil.SetActive(selectGo, self._curStageId == data.stageId)
	GameUtil.SetActive(passTag, self._maxPassStage >= data.stageId)
	GameUtil.SetActive(openTag, self._maxPassStage + 1 < data.stageId)
	GameUtil.SetActive(closeMask, self._maxPassStage + 1 < data.stageId)
	GameUtil.SetGray(openTag, true)
end

function OriginAsheClgLevelView:_clearCell(cell)
	return
end

function OriginAsheClgLevelView:_resetFormation(formationList)
	for i = 1, 9 do
		MaterialMgr.resetAll(formationList[i].con)
		GameUtil.SetActive(formationList[i].go, false)
	end
end

function OriginAsheClgLevelView:_onClickStage(stageId)
	self._maxPassStage = OriginAsheClgModel.instance:getMaxPassStage(self._activityId)

	local stagCfgs = OriginAsheClgConfig.instance:getStageCfgs(self._activityId)
	local isPassGame = self._maxPassStage >= #stagCfgs

	if self._curStageId ~= stageId then
		if isPassGame == true then
			self._curStageId = stageId

			self:_refreshView()
		elseif stageId <= self._maxPassStage then
			FloatWordMgr.instance:show(lang("已通关"))
		elseif stageId > self._maxPassStage + 1 then
			FloatWordMgr.instance:show(lang("请通关上一个关卡"))
		end
	end
end

function OriginAsheClgLevelView:_onClickFirstFomtion()
	local stageInfo = OriginAsheClgModel.instance:getStageInfo(self._activityId, self._curStageId)

	if not stageInfo or checknumber(stageInfo.info.passBattleSeq) < 1 then
		OriginAsheClgController.instance:openMissionView(self._activityId, self._curStageId, 1)
	else
		FloatWordMgr.instance:show(lang("已完成战斗"))
	end
end

function OriginAsheClgLevelView:_onClickSecondFomtion()
	local stageInfo = OriginAsheClgModel.instance:getStageInfo(self._activityId, self._curStageId)

	if not stageInfo or checknumber(stageInfo.info.passBattleSeq) < 1 then
		FloatWordMgr.instance:show(lang("请先完成第一场战斗"))
	elseif checknumber(stageInfo.info.passBattleSeq) >= 2 then
		FloatWordMgr.instance:show(lang("已完成战斗"))
	else
		OriginAsheClgController.instance:openMissionView(self._activityId, self._curStageId, 2)
	end
end

function OriginAsheClgLevelView:_onClickReset()
	local stageInfo = OriginAsheClgModel.instance:getStageInfo(self._activityId, self._curStageId)

	if stageInfo and stageInfo.info.passBattleSeq >= 1 then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否将本关重置为未挑战，解除精灵锁定"), function()
			OriginAsheClgAgent.instance:sendPM_OriginAsheClgResetStageReq(self._activityId, self._curStageId)
		end)
	else
		FloatWordMgr.instance:show(lang("未挑战任意关卡"))
	end
end

return OriginAsheClgLevelView
