-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgExtView.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgExtView", package.seeall)

local DragonPsychicClgExtView = class("DragonPsychicClgExtView", ViewComponent)

function DragonPsychicClgExtView:buildUI()
	DragonPsychicClgExtView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._btnShop = goutil.findChild(self.mainGO, "btnShop")
	self._partScrView = goutil.findChild(self.mainGO, "partScrView")
	self._stageScrCell = goutil.findChild(self.mainGO, "stageScrCell")
	self._teamScrCell = goutil.findChild(self.mainGO, "teamScrCell")

	local tagGoList = {
		self._stageScrCell,
		self._teamScrCell
	}

	self._sizeList = {}

	for tag, tagGo in ipairs(tagGoList) do
		local width, height = GameUtil.getWidth(tagGo), GameUtil.getHeight(tagGo)

		self._sizeList[tag] = {
			width,
			height
		}
	end

	self._partScrollerList = ScrollerList.create(self._partScrView, tagGoList, GameUtil.handler(self._updatePartCell, self), GameUtil.handler(self._clearPartCell, self))

	self._partScrollerList:regGetTagByIdx(function(data, idx)
		return data.tag
	end)
	self._partScrollerList:regGetCellSize(function(view, idx)
		local list = self._partScrollerList:getData()
		local data = list[idx + 1]

		return self._sizeList[data.tag][1], self._sizeList[data.tag][2]
	end)
	self._partScrollerList:setCenterMode(true)

	self._petScrollListDic = {}
	self._sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO)
end

function DragonPsychicClgExtView:bindEvents()
	DragonPsychicClgExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function DragonPsychicClgExtView:unbindEvents()
	DragonPsychicClgExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnShop)
end

function DragonPsychicClgExtView:onEnter()
	DragonPsychicClgExtView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = DragonPsychicClgController.instance:getActivityType()

	local isInTime = DragonPsychicClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = DragonPsychicClgConfig.instance:getDpcData(self._activityId)
	self._stageCfgs = DragonPsychicClgConfig.instance:getDpcExtremeStageCfgs(self._activityId)
	self._partInfos = {}

	for planId = 0, #self._stageCfgs do
		self._partInfos[planId] = {}

		for stageId, cfg in ipairs(self._stageCfgs) do
			local teamCount = #cfg
			local info = {}

			info.tag = 1
			info.stageId = stageId
			info.teamId = 0
			info.sortingOrder = self._sortingOrder + teamCount + 1

			table.insert(self._partInfos[planId], info)

			if planId == stageId then
				for teamId, data in ipairs(cfg) do
					local info = {}

					info.tag = 2
					info.stageId = stageId
					info.teamId = teamId
					info.sortingOrder = self._sortingOrder + teamId

					table.insert(self._partInfos[planId], info)
				end
			end
		end
	end

	self.addGEvent(self, GlobalNotify.handlePM_DPClgGetExtremeInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgResetRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgNotifyExtremeChallengeRes, self._onUpdate, self)
	DragonPsychicClgController.instance:sendPM_DPClgGetExtremeInfoReq(self._activityId)
end

function DragonPsychicClgExtView:onExit()
	DragonPsychicClgExtView.super.onExit(self)
	self:_onClear()
end

function DragonPsychicClgExtView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function DragonPsychicClgExtView:_onClear()
	self._partScrollerList:dispose()
end

function DragonPsychicClgExtView:_onUpdateData()
	local lastPlanId = self:_getLastPlanId()

	self._curPlanId = lastPlanId or 0
	self._curPlanId = Mathf.Clamp(self._curPlanId, 0, #self._stageCfgs)
end

function DragonPsychicClgExtView:_onUpdateUI()
	local infos = self._partInfos[self._curPlanId]

	self._partScrollerList:reloadData(infos or {})

	local index = 1

	if infos == nil then
		printError(string.format("infos is nil, planId = %s", self._curPlanId))
	else
		local flag = false

		for idx, info in ipairs(infos) do
			local activityId = self._activityId
			local stageId = info.stageId
			local teamId = info.teamId

			if self._curPlanId == stageId then
				index = idx

				if stageId > 0 and teamId > 0 then
					local isPass = DragonPsychicClgController.instance:isPassInTeamOfExt(activityId, stageId, teamId)

					if not isPass then
						index = idx

						break
					end
				end

				flag = true
			elseif flag then
				break
			end
		end
	end

	self._partScrollerList:MoveCellToBegin(Mathf.Max(index - 2, 0), true)
end

function DragonPsychicClgExtView:_getUserDataOfPlanId()
	return "DragonPsychicClgExt_PlanId_" .. self._activityId
end

function DragonPsychicClgExtView:_getLastPlanId()
	local key = self:_getUserDataOfPlanId()

	return GameUtil.getUserData(key)
end

function DragonPsychicClgExtView:_saveLastPlanId(planId)
	local key = self:_getUserDataOfPlanId()

	return GameUtil.saveUserData(key, planId)
end

function DragonPsychicClgExtView:_updatePartCell(view, cell, data, tag)
	if data.tag == 1 then
		self:_updateStageCell(view, cell, data, tag)
	else
		self:_updateTeamCell(view, cell, data, tag)
	end
end

function DragonPsychicClgExtView:_clearPartCell(cell)
	self:_clearStageCell(cell)
	self:_clearTeamCell(cell)
end

function DragonPsychicClgExtView:_updateStageCell(view, cell, data, tag)
	local planId = data.stageId
	local stageId = data.stageId
	local sortingOrder = data.sortingOrder
	local stageTotalData = DragonPsychicClgConfig.instance:getDpcExtremeStageTotalData(self._activityId, stageId)
	local isPassStage = DragonPsychicClgController.instance:isPassInStageOfExt(self._activityId, stageId)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgHasPass = goutil.findChild(mainGo, "imgHasPass")

	txtName.text = stageTotalData.name

	GameUtil.SetActive(imgHasPass, isPassStage)

	mainGo:GetComponent("Canvas").sortingOrder = sortingOrder

	GameUtil.addClickHandler(mainGo, function()
		self._curPlanId = self._curPlanId == planId and 0 or planId

		self:_saveLastPlanId(self._curPlanId)
		self:_onUpdateUI()
	end)
end

function DragonPsychicClgExtView:_clearStageCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function DragonPsychicClgExtView:_updateTeamCell(view, cell, data, tag)
	local activityId = self._activityId
	local stageId = data.stageId
	local teamId = data.teamId
	local sortingOrder = data.sortingOrder
	local teamData = DragonPsychicClgConfig.instance:getDpcExtremeStageData(activityId, stageId, teamId)
	local masterData = DragonPsychicClgConfig.instance:getDpcMasterData(teamData.creepsMasterId)
	local isPass = DragonPsychicClgController.instance:isPassInTeamOfExt(activityId, stageId, teamId)
	local isPassStage = DragonPsychicClgController.instance:isPassInStageOfExt(activityId, stageId)
	local isAllPass = DragonPsychicClgController.instance:isAllPassOfExt(activityId)
	local clg_result, clg_tips = DragonPsychicClgController.instance:getTryStartDpcExtClgResultAndTips(activityId, stageId, teamId)
	local mainGo = cell.gameObject
	local stageName_txt = goutil.findChildTextComponent(mainGo, "stageName/txt")
	local txtStageDesc = goutil.findChildTextComponent(mainGo, "txtStageDesc")
	local txtRuleDesc = goutil.findChildTextComponent(mainGo, "txtRuleDesc")
	local petCol_scrView = goutil.findChild(mainGo, "petCol/scrView")
	local petCol_scrCell = goutil.findChild(mainGo, "petCol/scrCell")
	local petCol_imgEmpty = goutil.findChild(mainGo, "petCol/imgEmpty")
	local btnReset = goutil.findChild(mainGo, "btnReset")
	local btnClg = goutil.findChild(mainGo, "btnClg")

	mainGo:GetComponent("Canvas").sortingOrder = sortingOrder
	stageName_txt.text = string.format("小关卡%s", teamId)
	txtStageDesc.text = teamData.stageDesc or ""
	txtRuleDesc.text = masterData.ruleDesc

	if petCol_scrView and petCol_scrCell then
		local raceIds = DragonPsychicClgController.instance:getLockRaceIdsInTeamOfExt(activityId, stageId, teamId)

		if not self._petScrollListDic[mainGo] then
			local scrollList = ScrollerList.create(petCol_scrView, petCol_scrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

			self._petScrollListDic[mainGo] = self._petScrollListDic[mainGo]

			self._petScrollListDic[mainGo]:setCenterMode(true)
			self._petScrollListDic[mainGo]:reloadData(raceIds)
			self._petScrollListDic[mainGo]:dragNotifyParent()
			GameUtil.SetActive(petCol_imgEmpty, #raceIds <= 0)
		end
	end

	GameUtil.SetActive(btnReset, isPass and not isAllPass)
	GameUtil.SetActive(btnClg, clg_result == GameEnum.ResultCode.Success)
	GameUtil.addClickHandler(btnReset, GameUtil.handler(self._onClickTeamCellBtnReset, self, activityId, stageId, teamId))
	GameUtil.addClickHandler(btnClg, GameUtil.handler(self._onClickTeamCellBtnClg, self, activityId, stageId, teamId))
end

function DragonPsychicClgExtView:_clearTeamCell(cell)
	local mainGo = cell.gameObject
	local btnReset = goutil.findChild(mainGo, "btnReset")
	local btnClg = goutil.findChild(mainGo, "btnClg")
	local scrollList = self._petScrollListDic[mainGo]

	if scrollList then
		scrollList:dispose()

		self._petScrollListDic[mainGo] = nil
	end

	GameUtil.rmClickHandler(btnReset)
	GameUtil.rmClickHandler(btnClg)
end

function DragonPsychicClgExtView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setIcon(item, MatType.Pet, raceId, nil, nil)

	local function callBack()
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, 0)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end

	GameUtil.addClickHandler(mainGo, callBack)
end

function DragonPsychicClgExtView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(mainGo)
end

function DragonPsychicClgExtView:_onClickTeamCellBtnReset(activityId, stageId, teamId)
	local isAllPass = DragonPsychicClgController.instance:isAllPassOfExt(activityId)

	if isAllPass then
		FloatWordMgr.instance:show("所有关卡已通关，无需重置")

		return
	end

	local isPass = DragonPsychicClgController.instance:isPassInTeamOfExt(activityId, stageId, teamId)

	if not isPass then
		FloatWordMgr.instance:show("未通关，无需重置")

		return
	end

	local tipsContent = "是否确认重置此关卡？"

	local function okFunc()
		DragonPsychicClgController.instance:sendPM_DPClgResetReq(activityId, stageId, teamId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function DragonPsychicClgExtView:_onClickTeamCellBtnClg(activityId, stageId, teamId)
	local result, tips = DragonPsychicClgController.instance:getTryStartDpcExtClgResultAndTips(activityId, stageId, teamId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DragonPsychicClgController.instance:enterBattleOfExt(activityId, stageId, teamId)
end

function DragonPsychicClgExtView:_onClickBtnTip()
	local key = DragonPsychicClgConfig.instance:getCommonValue(self._activityId, "ruleKeyExt")

	TipsFacade.instance:openRulesView(key)
end

return DragonPsychicClgExtView
