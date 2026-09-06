-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/view/DivineMiMengLiClgStageView.lua

module("logic.extensions.divinemimengliclg.view.DivineMiMengLiClgStageView", package.seeall)

local DivineMiMengLiClgStageView = class("DivineMiMengLiClgStageView", ViewComponent)

function DivineMiMengLiClgStageView:buildUI()
	DivineMiMengLiClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnReset = self:getGo("btnReset")
	self._btnStart = self:getGo("btnStart")
	self._imgLockStart = self:getGo("btnStart/imgLock")
	self._txtLockStart = self:getTxt("btnStart/imgLock/txt")
	self._cellRuleDesc = self:getGo("info/cellRuleDesc")
	self._txtDescCellRule = self:getTxt("info/cellRuleDesc/txt")
	self._cellRuleScr = self:getGo("info/cellRuleScr")
	self._txtDescCellRuleScr = self:getTxt("info/cellRuleScr/scrView/Viewport/Content")
	self._cellBuff = self:getGo("info/cellBuff")
	self._btnTipCellBuff = self:getGo("info/cellBuff/btnTip")
	self._txtCellBuff = self:getTxt("info/cellBuff/scrView/Viewport/Content")
	self._cellPrize = self:getGo("info/cellPrize")
	self._prizeItemCellPrize = self:getGo("info/cellPrize/prizeItem")
	self._gridView = self:getGo("gridCol/gridView")
	self._gridCell = self:getGo("gridCol/gridCell")
	self._youlingView = self:getGo("gridCol/youlingView")
	self._youlingCell = self:getGo("gridCol/youlingCell")
	self._gun = self:getGo("gridCol/gun")
	self._btnDown = self:getGo("gridCol/gun/btnDown")
	self._btnUp = self:getGo("gridCol/gun/btnUp")
	self._lineEff = self:getGo("gridCol/gun/lineEff")
	self._txtStage = self:getTxt("stage/txt")

	GameUtil.SetActive(self._youlingCell, false)
end

function DivineMiMengLiClgStageView:bindEvents()
	DivineMiMengLiClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnDown, GameUtil.handler(self._onClickBtnGunMove, self, 1))
	GameUtil.addClickHandler(self._btnUp, GameUtil.handler(self._onClickBtnGunMove, self, -1))
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnTipCellBuff, self._onClickBtnTipDebuff, self)
end

function DivineMiMengLiClgStageView:unbindEvents()
	DivineMiMengLiClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnDown)
	GameUtil.rmClickHandler(self._btnUp)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnTipCellBuff)
end

function DivineMiMengLiClgStageView:onEnter()
	DivineMiMengLiClgStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = DivineMiMengLiClgController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local isInTime = DivineMiMengLiClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = DivineMiMengLiClgConfig.instance:getActData(self._activityId)
	self._divineMmlClgMo = DivineMiMengLiClgController.instance:getDivineMmlClgMo(self._activityId)
	self._stageCfg = DivineMiMengLiClgConfig.instance:getStageCfg(self._activityId) or {}
	self._curStageId = 0
	self._maxStageId = #self._stageCfg
	self._curTeamId = self._curTeamId or 0
	self._gridCells = {}
	self._youlingCellPool = self._youlingCellPool or self:_creatYoulingCellPool()
	self._youlingCellList = {}
	self._youlingCellPosTags = {}
	self._youlingCellAnimList = {}
	self._tweenerMoves = {}

	self:playViewEffectUniGo("20250228/shenyaomimenglizhan/fx_ui_wuqijiguang.prefab", self._lineEff, self.mainGO, true, nil, nil)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiMengLiClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiMengLiClgResetRes, self._handlePM_DivineMiMengLiClgResetRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiMengLiClgConfirmRes, self._onUpdate, self)
	DivineMiMengLiClgController.instance:sendPM_DivineMiMengLiClgGetInfoReq(self._activityId)
	self:_initAoqiGodUI()
end

function DivineMiMengLiClgStageView:_initAoqiGodUI()
	GameUtil.SetActive(self._cellPrize, not self._isAoqiGodProcessType)
end

function DivineMiMengLiClgStageView:onExit()
	DivineMiMengLiClgStageView.super.onExit(self)
	removetimer(self._continueYoulingAnim, self)
	MaterialMgr.resetAll(self._prizeItemCellPrize)
	GameUtil.clearCells(self._tabView, self._clearTabCell, self)
	self:stopViewEffectUniGo(self._lineEff)
	self:_removeAllYouling()
end

function DivineMiMengLiClgStageView:destroyUI()
	DivineMiMengLiClgStageView.super.destroyUI(self)

	if self._youlingCellPool then
		self._youlingCellPool:clear()
	end
end

function DivineMiMengLiClgStageView:_handlePM_DivineMiMengLiClgResetRes()
	DivineMiMengLiClgController.instance:sendPM_DivineMiMengLiClgGetInfoReq(self._activityId)
end

function DivineMiMengLiClgStageView:_onUpdate()
	local curStageId = 1

	for _, data in ipairs(self._stageCfg) do
		if self._divineMmlClgMo:isPassStage(data.stageId) then
			curStageId = data.stageId + 1
		else
			break
		end
	end

	self._curStageId = Mathf.Clamp(curStageId, 0, self._maxStageId)

	local teamCfg = DivineMiMengLiClgConfig.instance:getTeamCfg(self._activityId, self._curStageId) or {}

	self._teamCount = #teamCfg

	if self._curTeamId == 0 then
		for _, data in ipairs(teamCfg) do
			self._curTeamId = data.teamId

			if not self._divineMmlClgMo:isPassTeam(self._curStageId, data.teamId) then
				break
			end
		end
	end

	self._curTeamId = Mathf.Clamp(self._curTeamId, 1, self._teamCount)

	local stageData = DivineMiMengLiClgConfig.instance:getStageData(self._activityId, self._curStageId)

	self._stageType = DivineMiMengLiClgConfig.instance:getStageType(self._activityId, self._curStageId)
	self._txtDescCellRule.text = stageData.ruleDesc
	self._txtDescCellRuleScr.text = stageData.ruleDesc

	MaterialMgr.setCellByCfg(stageData.prize, self._prizeItemCellPrize)
	self:_initAoqiGodUI()

	self._txtStage.text = string.format("当前关：%s/%s", self._curStageId, self._maxStageId)

	local gridIdList = {}

	self._gridCount = self._teamCount * DivineMmlClgEnum.GridCountEachTeam

	for gridId = 1, self._gridCount do
		table.insert(gridIdList, gridId)
	end

	GameUtil.updateCellsList(self._gridView, self._gridCell, gridIdList, self._updateGridCell, self)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._gridView:GetComponent(goutil.Type_RectTransform))
	GameUtil.SetActive(self._btnReset, self._stageType == DivineMmlClgEnum.StageType_Two or self._stageType == DivineMmlClgEnum.StageType_Three)
	GameUtil.SetActive(self._cellBuff, self._stageType == DivineMmlClgEnum.StageType_Two)
	GameUtil.SetActive(self._cellRuleScr, self._stageType == DivineMmlClgEnum.StageType_Two)
	GameUtil.SetActive(self._cellRuleDesc, self._stageType ~= DivineMmlClgEnum.StageType_Two)

	if self._stageType == DivineMmlClgEnum.StageType_Two then
		local signBuffCount = self._divineMmlClgMo:getSignBuffCountInStage(self._curStageId)
		local buffData = DivineMiMengLiClgConfig.instance:getBuffDataByCount(self._activityId, self._curStageId, signBuffCount)

		if buffData then
			self._txtCellBuff.text = buffData.desc or "暂无"
		end
	else
		self._txtCellBuff.text = ""
	end

	self:_continueYoulingAnim()
	self:_onUpdateTeamChangeUI()

	if self._divineMmlClgMo:isPassChallenge() then
		if not self._isAoqiGodProcessType then
			local tipsContent = "挑战已完成"

			local function okFunc()
				self:close()
			end

			TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
		else
			AoqiGodController.instance:doHandleChallengeFinishReady(DivineMiMengLiClgController.instance:getActivityType(), self._activityId)
			UIStateManager.instance:popByName(ViewName.DivineMiMengLiClgMainView)
			self:close()
		end
	else
		local changeSetId = self._divineMmlClgMo:popChangeSetId()

		while changeSetId do
			MaterialController.instance:showChangeSetInTemp(changeSetId)

			changeSetId = self._divineMmlClgMo:popChangeSetId()
		end
	end
end

function DivineMiMengLiClgStageView:_updateGridCell(mainGo, gridId, idx)
	local index, teamId = self:_getGridXY(gridId)
	local teamData = DivineMiMengLiClgConfig.instance:getTeamData(self._activityId, self._curStageId, teamId)

	if teamData then
		if not teamData.creepsMasterId then
			local creepsCfg = DivineMiMengLiClgConfig.instance:getCreepsCfg(teamData.creepsMasterId) or {}
			local creepsData = creepsCfg[index]
			local isPassTeam = self._divineMmlClgMo:isPassTeam(self._curStageId, teamId)
			local cell = {}

			cell._mainGo = mainGo
			cell._head = goutil.findChild(mainGo, "head")
			cell._headCon = goutil.findChild(mainGo, "head/con")
			cell._youlingRoot = goutil.findChild(mainGo, "youlingRoot")
			self._gridCells[gridId] = cell

			if creepsData then
				local skinId = checknumber(creepsData.faceId)

				if skinId <= 0 then
					skinId = creepsData.raceId
				end

				MaterialMgr.setIcon(cell._headCon, MatType.Pet, skinId, nil, nil)
			else
				MaterialMgr.clearIcon(cell._headCon)
			end

			GameUtil.SetActive(cell._head, not isPassTeam)
			GameUtil.addClickHandler(cell._mainGo, function()
				if self._curTeamId ~= teamId then
					self:_switchToTeam(teamId)
				end
			end)
		end
	end
end

function DivineMiMengLiClgStageView:_clearGridCell(mainGo)
	local headCon = goutil.findChild(mainGo, "head/con")

	MaterialMgr.clearIcon(headCon)
end

function DivineMiMengLiClgStageView:_getGridCellById(gridId)
	return self._gridCells[gridId]
end

function DivineMiMengLiClgStageView:_getGridCell(teamId, index)
	local gridId = self:_getGridId(index, teamId)

	return self._gridCells[gridId]
end

function DivineMiMengLiClgStageView:_getGridId(x, y)
	return (y - 1) * DivineMmlClgEnum.GridCountEachTeam + x
end

function DivineMiMengLiClgStageView:_getGridXY(gridId)
	local x = (gridId - 1) % DivineMmlClgEnum.GridCountEachTeam + 1
	local y = math.floor((gridId - 1) / DivineMmlClgEnum.GridCountEachTeam) + 1

	return x, y
end

function DivineMiMengLiClgStageView:_isExceedRange(x, y)
	return x <= 0 or x > DivineMmlClgEnum.GridCountEachTeam or y <= 0 or y > self._teamCount
end

function DivineMiMengLiClgStageView:_onUpdateTeamChangeUI()
	local gridCell = self:_getGridCell(self._curTeamId, 1)

	if gridCell then
		local gunPos = GameUtil.getPos(self._gun)
		local girdPos = GameUtil.getPos(gridCell._mainGo)

		GameUtil.setPos(self._gun, gunPos.x, girdPos.y, gunPos.z)
	end

	local isUnlockStage = self._divineMmlClgMo:isUnlockStage(self._curStageId)
	local isPassTeam = self._divineMmlClgMo:isPassTeam(self._curStageId, self._curTeamId)

	GameUtil.SetActive(self._imgLockStart, not isUnlockStage)

	local stageData = DivineMiMengLiClgConfig.instance:getStageData(self._activityId, self._curStageId)

	if stageData then
		local date = GameUtil.string2date(stageData.openTime)

		self._txtLockStart.text = string.format("%d.%d.%d. %02d:%02d后开启", date.year, date.month, date.day, date.hour, date.min)
	else
		self._txtLockStart.text = ""
	end
end

function DivineMiMengLiClgStageView:_switchToTeam(teamId)
	teamId = Mathf.Clamp(teamId, 1, self._teamCount)

	removetimer(self._continueYoulingAnim, self)

	self._curTeamId = teamId

	self:_onUpdateTeamChangeUI()

	local rmList = {}

	for idx = DivineMmlClgEnum.GridCountEachTeam, #self._youlingCellList do
		table.insert(rmList, self._youlingCellList[idx])
	end

	for _, youlingCell in ipairs(rmList) do
		self:_rmYouling(youlingCell)
	end

	local posList = MathUtil.randomEx(1, DivineMmlClgEnum.GridCountEachTeam, #self._youlingCellList)

	for idx, cell in ipairs(self._youlingCellList) do
		self:_stopYoulingMoveAnim(cell)

		if not posList[idx] then
			local index = 0

			if not self:_isExceedRange(index, self._curTeamId) then
				self._youlingCellPosTags[cell] = self:_getGridId(index, self._curTeamId)

				local gridCell = self:_getGridCell(self._curTeamId, index)
				local x, y, z = Framework.TransformUtil.GetPos(gridCell._youlingRoot.transform, 0, 0, 0)

				GameUtil.setPos(cell, x, y, z)
			end
		end
	end

	settimer(3, self._continueYoulingAnim, self, false)
end

function DivineMiMengLiClgStageView:_tryDoYoulingCellAnims()
	while #self._youlingCellAnimList > 0 do
		local youlingCell = table.remove(self._youlingCellAnimList, #self._youlingCellAnimList)

		if not self._youlingCellPosTags[youlingCell] then
			local fromGridId = Mathf.Random(1, self._gridCount)
			local list = {
				1,
				2,
				3,
				4
			}

			for i = 1, #list do
				local ranIdx = Mathf.Random(i, #list)

				list[i] = list[ranIdx]
				list[ranIdx] = list[i]
			end

			local idx = Mathf.Random(1, #list)
			local formX, formY = self:_getGridXY(fromGridId)
			local toX, toY = 0, 0

			while #list > 0 do
				local toward = table.remove(list, #list)

				toY = formY + DivineMmlClgEnum.Towards[toward][2]
				toX = formX + DivineMmlClgEnum.Towards[toward][1]

				if not self:_isExceedRange(formX + DivineMmlClgEnum.Towards[toward][1], formY + DivineMmlClgEnum.Towards[toward][2]) then
					break
				end
			end

			local toGridId = self:_getGridId(toX, toY)

			if toGridId > 0 then
				self:_playYoulingMoveAnim(fromGridId, toGridId, youlingCell)
			else
				printError(string.format("无路可去( %s:[%s, %s], %s:[%s, %s] )", fromGridId, formX, formY, toGridId, toX, toY))
			end
		end
	end
end

function DivineMiMengLiClgStageView:_playYoulingMoveAnim(fromGridId, toGridId, youlingCell)
	self:_stopYoulingMoveAnim(youlingCell)

	local fromGridCell = self:_getGridCellById(fromGridId)
	local toGridCell = self:_getGridCellById(toGridId)

	self._youlingCellPosTags[youlingCell] = toGridId

	local formPos = GameUtil.getPos(fromGridCell._youlingRoot)
	local toPos = GameUtil.getPos(toGridCell._youlingRoot)
	local distance = Vector2.Distance(formPos, toPos)
	local deltaTime = distance / 0.3

	GameUtil.setPos(youlingCell, formPos.x, formPos.y, formPos.z)

	local tweenerMove = youlingCell.transform:DOMove(toPos, deltaTime)

	tweenerMove:SetEase(DG.Tweening.Ease.Linear)
	tweenerMove:OnComplete(function()
		self._tweenerMoves[youlingCell] = nil

		table.insert(self._youlingCellAnimList, youlingCell)
		self:_tryDoYoulingCellAnims()
	end)

	self._tweenerMoves[youlingCell] = tweenerMove
end

function DivineMiMengLiClgStageView:_addYouling(count)
	while count > 0 do
		count = count - 1

		local cell = self:_fetchYoulingCell()

		table.insert(self._youlingCellList, cell)
		table.insert(self._youlingCellAnimList, cell)

		local gridId = Mathf.Random(1, self._gridCount)
		local gridCell = self:_getGridCellById(gridId)

		self._youlingCellPosTags[cell] = gridId

		GameUtil.SetActive(cell, true)

		local x, y, z = Framework.TransformUtil.GetPos(gridCell._youlingRoot.transform, 0, 0, 0)

		GameUtil.setPos(cell, x, y, z)
	end

	self:_tryDoYoulingCellAnims()
end

function DivineMiMengLiClgStageView:_stopYoulingMoveAnim(youlingCell)
	if self._tweenerMoves[youlingCell] then
		self._tweenerMoves[youlingCell]:Kill(false)

		self._tweenerMoves[youlingCell] = nil
	end
end

function DivineMiMengLiClgStageView:_rmYouling(youlingCell)
	self._youlingCellPosTags[youlingCell] = nil

	self:_stopYoulingMoveAnim(youlingCell)
	self:_returnChatCell(youlingCell)
	table.removebyvalue(self._youlingCellList, youlingCell)
	table.removebyvalue(self._youlingCellAnimList, youlingCell)
end

function DivineMiMengLiClgStageView:_removeAllYouling()
	for _, cell in ipairs(self._youlingCellList) do
		self._youlingCellPosTags[cell] = nil

		self:_stopYoulingMoveAnim(cell)
		self:_returnChatCell(cell)
	end

	table.clear(self._youlingCellList)
	table.clear(self._youlingCellAnimList)
end

function DivineMiMengLiClgStageView:_fetchYoulingCell()
	return self._youlingCellPool:fetchObject()
end

function DivineMiMengLiClgStageView:_returnChatCell(cell)
	if self._youlingCellPool then
		self._youlingCellPool:returnObject(cell)
	end
end

function DivineMiMengLiClgStageView:_creatYoulingCellPool()
	local function createFunc()
		local cell = goutil.cloneAndSetParent(self._youlingCell, self._youlingView.transform, self._youlingCell.name)

		goutil.addChildToParent(cell, self._youlingView)

		return cell
	end

	local function disposeFunc(cell)
		UnityEngine.GameObject.Destroy(cell)
	end

	local function resetFunc(cell)
		GameUtil.SetActive(cell, false)
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function DivineMiMengLiClgStageView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineMiMengLiClgStageView:_onClickBtnGunMove(delta)
	local teamId = (self._curTeamId + delta - 1) % self._teamCount + 1

	teamId = Mathf.Clamp(teamId, 1, self._teamCount)

	if teamId == self._curTeamId then
		return
	end

	self:_switchToTeam(teamId)
end

function DivineMiMengLiClgStageView:_continueYoulingAnim()
	if self._stageType ~= DivineMmlClgEnum.StageType_Three then
		return
	end

	local youlingCount = self._divineMmlClgMo:getCurYoulingCount(self._curStageId)
	local addCount = youlingCount - #self._youlingCellList

	if addCount > 0 then
		self:_addYouling(addCount)
	elseif addCount < 0 then
		local rmList = {}
		local count = #self._youlingCellList

		for idx = count, count + addCount, -1 do
			table.insert(rmList, self._youlingCellList[idx])
		end

		for _, youlingCell in ipairs(rmList) do
			self:_rmYouling(youlingCell)
		end
	end

	for _, youlingCell in ipairs(self._youlingCellList) do
		if self._tweenerMoves[youlingCell] == nil then
			table.insert(self._youlingCellAnimList, youlingCell)
		end
	end

	self:_tryDoYoulingCellAnims()
end

function DivineMiMengLiClgStageView:_onClickBtnStart()
	local result = GameEnum.ResultCode.Success
	local tips

	if not DivineMiMengLiClgController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif self._divineMmlClgMo:isPassTeam(self._curStageId, self._curTeamId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif not self._divineMmlClgMo:isUnlockStage(self._curStageId) then
		result = GameEnum.ResultCode.Error
		tips = "未开放"
	end

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if not DivineMiMengLiClgController.instance:checkPassAoqiGodProcessResult(self._activityId) then
		return
	end

	DivineMiMengLiClgController.instance:enterBattle(self._activityId, self._curStageId, self._curTeamId)
end

function DivineMiMengLiClgStageView:_onClickBtnReset()
	local result = GameEnum.ResultCode.Success
	local tips
	local activityId = self._activityId
	local stageId = self._curStageId

	if not DivineMiMengLiClgController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif self._divineMmlClgMo:isPassStage(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif not self._divineMmlClgMo:isUnlockStage(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "未开放"
	end

	if result == GameEnum.ResultCode.Success then
		local stageType = DivineMiMengLiClgConfig.instance:getStageType(activityId, stageId)

		if stageType ~= DivineMmlClgEnum.StageType_Two and stageType ~= DivineMmlClgEnum.StageType_Three then
			result = GameEnum.ResultCode.Error
			tips = "非可重置关卡"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isNeedReset = false
		local cfg = DivineMiMengLiClgConfig.instance:getTeamCfg(activityId, stageId)

		if cfg then
			for _, data in ipairs(cfg) do
				if self._divineMmlClgMo:isPassTeam(stageId, data.teamId) then
					isNeedReset = true

					break
				end
			end
		end

		if not isNeedReset then
			result = GameEnum.ResultCode.Error
			tips = "无需重置关卡"
		end
	end

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "是否确认重置？"

	local function okFunc()
		DivineMiMengLiClgController.instance:sendPM_DivineMiMengLiClgResetReq(activityId, self._curStageId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function DivineMiMengLiClgStageView:_onClickBtnTipDebuff()
	UIStateManager.instance:push(ViewName.DivineMiMengLiClgStageDebuffView, self._activityId, self._curStageId)
end

return DivineMiMengLiClgStageView
