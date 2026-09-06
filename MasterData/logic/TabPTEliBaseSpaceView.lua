-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/space/TabPTEliBaseSpaceView.lua

module("logic.extensions.peaktournament.view.eliminator.tab.space.TabPTEliBaseSpaceView", package.seeall)

local TabPTEliBaseSpaceView = class("TabPTEliBaseSpaceView", ViewComponent)

function TabPTEliBaseSpaceView:buildUI()
	TabPTEliBaseSpaceView.super.buildUI(self)

	self._txtRemainTime = goutil.findChildTextComponent(self.mainGO, "txtRemainTime/txt")
	self._btnExchange = goutil.findChild(self.mainGO, "btnCol/btnExchange")
	self._btnReward = goutil.findChild(self.mainGO, "btnCol/btnReward")
	self._btnVote = goutil.findChild(self.mainGO, "btnCol/btnVote")
	self._btnBanPet = goutil.findChild(self.mainGO, "btnCol/btnBanPet")
	self._groupCol = goutil.findChild(self.mainGO, "groupCol")
	self._btnChooseGroup = goutil.findChild(self.mainGO, "groupCol/btnChooseGroup")
	self._txtBtnChooseGroup = goutil.findChildTextComponent(self.mainGO, "groupCol/btnChooseGroup/txt")
	self._groupScrollerview = goutil.findChild(self.mainGO, "groupCol/groupScrollerview")
	self._groupScrollercell = goutil.findChild(self.mainGO, "groupCol/groupScrollercell")

	if self._groupScrollerview then
		self._groupScrollList = ScrollerList.create(self._groupScrollerview, self._groupScrollercell, GameUtil.handler(self._updateGroupCell, self), GameUtil.handler(self._clearGroupCell, self))
	end

	if self._btnChooseGroup then
		self._btnChooseGroupUiCustonInput = UICustomInput.Get(self._groupScrollerview)
	end

	self._effCol = goutil.findChild(self.mainGO, "effCol")
	self._roundCol = goutil.findChild(self.mainGO, "contentCol/roundCol")
	self._seatCellGo = goutil.findChild(self.mainGO, "contentCol/seatCellGo")
	self._btnWatchGo = goutil.findChild(self.mainGO, "contentCol/btnWatchGo")

	GameUtil.SetActive(self._seatCellGo, false)
	GameUtil.SetActive(self._btnWatchGo, false)
	GameUtil.SetActive(self._groupScrollerview, false)

	self._fightEffList = {}
end

function TabPTEliBaseSpaceView:bindEvents()
	TabPTEliBaseSpaceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickBtnExchange, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
	GameUtil.addClickHandler(self._btnChooseGroup, self._onClickBtnChooseGroup, self)
	GameUtil.addClickHandler(self._btnVote, self._onCLickBtnVote, self)
	GameUtil.addClickHandler(self._btnBanPet, self._onCLickBtnBanPet, self)

	if self._btnChooseGroupUiCustonInput then
		self._btnChooseGroupUiCustonInput:AddListener(self._onClickBtnChooseGroup, self)
	end
end

function TabPTEliBaseSpaceView:unbindEvents()
	TabPTEliBaseSpaceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnChooseGroup)
	GameUtil.rmClickHandler(self._btnVote)
	GameUtil.rmClickHandler(self._btnBanPet)

	if self._btnChooseGroupUiCustonInput then
		self._btnChooseGroupUiCustonInput:RemoveListener()
	end
end

function TabPTEliBaseSpaceView:onEnter()
	TabPTEliBaseSpaceView.super.onEnter(self)

	self._activityId = PeakTournamentController.instance:getCurActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")
		self:close()

		return
	end

	self._eliminatorMgr = PeakTournamentController.instance:getEliminatorMgr()

	if self._eliminatorMgr == nil then
		printError("缺失[ EliminatorMgr模块 ],无法运行")
		self:close()

		return
	end

	self._eliRoundIdList = self:_getEliRoundIdList()

	if self._eliRoundIdList == nil or #self._eliRoundIdList == 0 then
		printError("EliRoundIdList 需继承后正确重写")
		self:close()

		return
	end

	self._groupCount = self:_getGroupCount()

	if self._groupCount == nil or self._groupCount == 0 then
		printError("GroupCount 需继承后正确重写")
		self:close()

		return
	end

	self._myUserId = RoleModel.instance:getUserId()
	self._eliRoundCfg = PeakTournamentConfig.instance:getPtEliRoundCfgById(self._activityId)

	GlobalDispatcher:addListener(GlobalNotify.EliminatorMgrNotifyChangeNewPeriod, self._sendGetParticipationInfoReq, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGetGroupStageInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGetParticipationInfoRes, self._sendCurGroupRoundInfoReq, self)
	self:_onUpdateEliRoundInfo()
	self:_sendGetParticipationInfoReq()
	settimer(0.1, self._onTicking, self)
	self:_onUpdate()

	local isHave = PeakTournamentController.instance:isTheSeasonHaveBanPet(self._activityId, GameEnum.PeakTournamentStep.Eliminator)

	GameUtil.SetActive(self._btnBanPet, isHave)
end

function TabPTEliBaseSpaceView:onExit()
	TabPTEliBaseSpaceView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.EliminatorMgrNotifyChangeNewPeriod, self._sendGetParticipationInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGetGroupStageInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGetParticipationInfoRes, self._sendCurGroupRoundInfoReq, self)
	removetimer(self._onTicking, self)
	self:_onClearUI()

	self._eliminatorMgr = nil
end

function TabPTEliBaseSpaceView:_sendGetParticipationInfoReq()
	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetParticipationInfoReq(self._activityId)
end

function TabPTEliBaseSpaceView:_sendCurGroupRoundInfoReq()
	self:_onUpdateGroupColData()
	self:_sendTheRoundGroupInfoReq(self._curGroupIndex)
end

function TabPTEliBaseSpaceView:_sendTheRoundGroupInfoReq(groupIdx)
	local roundGroupListPool = {}

	for _, roundId in ipairs(self._eliRoundIdList) do
		roundGroupListPool[roundId] = {
			groupIdx
		}
	end

	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetGroupStageInfoReq(self._activityId, roundGroupListPool)
end

function TabPTEliBaseSpaceView:_sendInfoReq()
	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetGroupStageInfoReq(self._activityId, self._eliRoundIdList)
end

function TabPTEliBaseSpaceView:_getEliRoundIdList()
	return {}
end

function TabPTEliBaseSpaceView:_getGroupCount()
	return 0
end

function TabPTEliBaseSpaceView:_getPlayerCount(eliRoundId)
	local power = 0

	if self._eliRoundCfg[eliRoundId].spaceKnockout == true then
		local totalRoundCount = self:_getTotalRoundCount()

		power = totalRoundCount - eliRoundId

		return Mathf.Pow(2, totalRoundCount - eliRoundId)
	else
		totalRoundCount = PeakTournamentController.instance:getTotalRoundNotSpaceKnockoutCount(self._activityId)

		return Mathf.Pow(2, totalRoundCount - eliRoundId)
	end
end

function TabPTEliBaseSpaceView:_getStageCount(eliRoundId)
	return self:_getPlayerCount(eliRoundId) / self:_getGroupCount() / 2
end

function TabPTEliBaseSpaceView:_getTotalRoundCount()
	return PeakTournamentController.instance:getTotalRoundCount(self._activityId)
end

function TabPTEliBaseSpaceView:_onUpdate()
	self:_onUpdateEliRoundInfo()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TabPTEliBaseSpaceView:_onUpdateData()
	self:_onUpdateGroupColData()
	self:_onUpdateRoundColData()
end

function TabPTEliBaseSpaceView:_onUpdateUI()
	self:_onUpdateGroupColUI()
	self:_onUpdateRoundColUI()
end

function TabPTEliBaseSpaceView:_onClearUI()
	self:_onClearRoundColUI()
	self:_onClearGroupColUI()
end

function TabPTEliBaseSpaceView:_onTicking()
	self:_onUpdateRemainTimeUI()
end

function TabPTEliBaseSpaceView:_onUpdateEliRoundInfo()
	self._newestEliRoundId = self._eliminatorMgr:getNewestEliRoundId()
	self._curEliRoundId = Mathf.Clamp(self._newestEliRoundId, self._eliRoundIdList[1], self._eliRoundIdList[#self._eliRoundIdList])
	self._curPeriodId = self._eliminatorMgr:getCurPeriodId(self._curEliRoundId)
end

function TabPTEliBaseSpaceView:_onUpdateRemainTimeUI()
	self._txtRemainTime.text = self._eliminatorMgr:getRemainTimeTipsStr(self._curEliRoundId)
end

function TabPTEliBaseSpaceView:_onUpdateGroupColData()
	self._groupInfoList = {}

	for idx = 1, self._groupCount do
		local info = {}

		info.groupIdx = idx
		info.isUnlock = true

		table.insert(self._groupInfoList, info)
	end

	for _, eliRoundId in ipairs(self._eliRoundIdList) do
		self._groupIdxOfMe = PeakTournamentModel.instance:getGroupAsPartInfo(eliRoundId)

		if self._groupIdxOfMe > 0 then
			break
		end
	end

	if self._curGroupIndex == 0 or self._curGroupIndex == nil then
		self._curGroupIndex = self._groupIdxOfMe
	end

	self._curGroupIndex = self._curGroupIndex or 0

	local curInfo = self:_getGroupViewInfo(self._curGroupIndex)

	if curInfo == nil or not curInfo.isUnlock then
		for groupIndex, info in ipairs(self._groupInfoList) do
			if info.isUnlock == true then
				self._curGroupIndex = groupIndex

				break
			end
		end
	end
end

function TabPTEliBaseSpaceView:_getGroupViewInfo(groupIndex)
	return self._groupInfoList[checknumber(groupIndex)]
end

function TabPTEliBaseSpaceView:_onUpdateGroupColUI()
	if self._groupScrollList == nil then
		return
	end

	self._groupScrollList:reloadData(self._groupInfoList)

	if self._curGroupIndex > 0 then
		local idx = self._curGroupIndex - 1
		local isMotion = true

		self._groupScrollList:MoveCellInView(idx, isMotion)
	end

	self._txtBtnChooseGroup.text = string.format("第%s组", self._curGroupIndex)
end

function TabPTEliBaseSpaceView:_onClearGroupColUI()
	if self._groupScrollList == nil then
		return
	end

	self._groupScrollList:dispose()
end

function TabPTEliBaseSpaceView:_updateGroupCell(view, cell, info, tag)
	local isUnlock = info.isUnlock
	local groupIdx = info.groupIdx
	local mainGo = cell.gameObject
	local changeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local lock = goutil.findChild(mainGo, "lock")
	local mark = goutil.findChild(mainGo, "mark")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	GameUtil.SetActive(redPoint, false)
	GameUtil.SetActive(lock, not isUnlock)
	GameUtil.SetActive(mark, self._groupIdxOfMe == groupIdx)

	if changeGroup then
		local isSelected = self._curGroupIndex == groupIdx

		changeGroup:SetState(isSelected and 1 or 0)
	end

	if txtName then
		txtName.text = string.format("第%s组", groupIdx)
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickGroupCell, self, mainGo, groupIdx))
end

function TabPTEliBaseSpaceView:_clearGroupCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function TabPTEliBaseSpaceView:_clickGroupCell(mainGo, groupIndex)
	local info = self:_getGroupViewInfo(groupIndex)

	if not info.isUnlock then
		FloatWordMgr.instance:show("该小组赛事未开放")

		return
	end

	if self._curGroupIndex == groupIndex then
		return
	else
		self._curGroupIndex = groupIndex
	end

	self:_sendTheRoundGroupInfoReq(self._curGroupIndex)
end

function TabPTEliBaseSpaceView:_onClickBtnChooseGroup(hover)
	if not hover then
		GameUtil.SetActive(self._groupScrollerview, not GameUtil.GetActive(self._groupScrollerview))
	end
end

function TabPTEliBaseSpaceView:_onCLickBtnVote(hover)
	GlobalDispatcher:dispatch(GlobalNotify.PeakJumpToTabVote)
end

function TabPTEliBaseSpaceView:_onUpdateRoundColData()
	return
end

function TabPTEliBaseSpaceView:_onUpdateRoundColUI()
	if self._roundCellList == nil then
		self._roundCellList = {}

		for roundIdx, eliRoundId in ipairs(self._eliRoundIdList) do
			local roundCell = {}

			self._roundCellList[roundIdx] = roundCell
			roundCell._mainGo = self._roundCol.transform:GetChild(roundIdx - 1)
			roundCell._stageCellList = {}

			if roundCell._mainGo == nil then
				printError(string.format("错误,缺失预制体[ roundCell ]!( roundIdx = %s | eliRoundId = %s )", roundIdx, eliRoundId))
			else
				local stageCount = self:_getStageCount(eliRoundId)

				if stageCount > roundCell._mainGo.transform.childCount then
					printError("roundCell预制数量不对,请检查")
				end

				for stageIdx = 1, stageCount do
					local stageCell = {}

					roundCell._stageCellList[stageIdx] = stageCell
					stageCell._mainGo = roundCell._mainGo.transform:GetChild(stageIdx - 1)
					stageCell._btnWatchParent = goutil.findChild(stageCell._mainGo, "btnWatchParent")
					stageCell._fightEffParent = goutil.findChild(stageCell._mainGo, "fightEffParent")
					stageCell._seatCell1 = goutil.findChild(stageCell._mainGo, "seatCol/seatCell1")
					stageCell._seatCell2 = goutil.findChild(stageCell._mainGo, "seatCol/seatCell2")
					stageCell._seatCellList = {}

					local btnWatchGo
					local btnWatchParentChildCount = stageCell._btnWatchParent.transform.childCount

					if btnWatchParentChildCount == 0 then
						btnWatchGo = goutil.cloneAndSetParent(self._btnWatchGo, stageCell._btnWatchParent.transform, self._btnWatchGo.name)

						GameUtil.setLocalPos(btnWatchGo, 0, 0, 0)
						GameUtil.SetActive(btnWatchGo, true)
					elseif btnWatchParentChildCount == 1 then
						btnWatchGo = stageCell._btnWatchParent.transform:GetChild(0)
					elseif btnWatchParentChildCount > 1 then
						printError("过分了,孩子怎么可以超过1个")
					end

					stageCell._btnWatch = btnWatchGo
					stageCell._btnWatchRed = goutil.findChild(btnWatchGo, "redPoint")

					for seatIdx, seatCellGoParent in ipairs({
						stageCell._seatCell1,
						stageCell._seatCell2
					}) do
						local seatCell = {}

						stageCell._seatCellList[seatIdx] = seatCell

						local seatCellGo
						local seatCellGoParentChildCount = seatCellGoParent.transform.childCount

						if seatCellGoParentChildCount == 0 then
							seatCellGo = goutil.cloneAndSetParent(self._seatCellGo, seatCellGoParent.transform, self._seatCellGo.name)

							GameUtil.setLocalPos(seatCellGo, 0, 0, 0)
							GameUtil.SetActive(seatCellGo, true)
						elseif seatCellGoParentChildCount == 1 then
							seatCellGo = seatCellGoParent.transform:GetChild(0)
						elseif seatCellGoParentChildCount > 1 then
							printError("过分了,孩子怎么可以超过1个")
						end

						seatCell._mainGo = seatCellGo
						seatCell._imgNilSeat = goutil.findChild(seatCell._mainGo, "imgNilSeat")
						seatCell._headcell = goutil.findChild(seatCell._mainGo, "headcell")
						seatCell._headIcon = goutil.findChild(seatCell._mainGo, "headcell/headIcon")
						seatCell._txtName = goutil.findChildTextComponent(seatCell._mainGo, "headcell/txtName")
						seatCell._winTag = goutil.findChild(seatCell._mainGo, "headcell/winTag")
						seatCell._myTag = goutil.findChild(seatCell._mainGo, "headcell/myTag")
						seatCell._tag = goutil.findChild(seatCell._mainGo, "headcell/tag")
						seatCell._tagUIImageSpriteChange = goutil.findChild(seatCell._mainGo, "headcell/tag/img"):GetComponent("UIImageSpriteChange")
					end
				end
			end
		end
	end

	local eliRoundId = 0
	local periodId = EliminatorMgr.PeriodId.WaitOpen

	for roundIdx, roundCell in ipairs(self._roundCellList) do
		eliRoundId = self._eliRoundIdList[roundIdx]
		periodId = self._eliminatorMgr:getCurPeriodId(self._eliRoundIdList[roundIdx])

		for stageIdx, stageCell in ipairs(roundCell._stageCellList) do
			GameUtil.SetActive(stageCell._btnWatch, eliRoundId <= self._curEliRoundId and periodId >= EliminatorMgr.PeriodId.Performance)
			GameUtil.addClickHandler(stageCell._btnWatch, GameUtil.handler(self._onClickStageCellBtnWatch, self, eliRoundId, periodId, self._curGroupIndex, stageIdx))

			local isNeedFightEff = periodId == EliminatorMgr.PeriodId.Performance
			local effParent = stageCell._fightEffParent
			local effRoot = self._effCol

			UIEffectManager.instance:stopEffect(self._fightEffList[effParent])

			if isNeedFightEff then
				local pathName = "20221223/duizhan/fx_ui_zhandou_jian"

				if effParent and not string.nilorempty(pathName) then
					local path = pathName .. ".prefab"

					local function finishHandler(handlerTarget, eff)
						return
					end

					local function loadedHandler(handlerTarget, eff)
						eff:setClipping(effRoot:GetComponent(goutil.Type_RectTransform))
						eff:setParent(effRoot.transform)

						local pos = GameUtil.getPos(effParent)

						eff:setPos(pos.x, pos.y, pos.z)
						eff:setScale(1, 1, 1)

						eff.hideEffWhileNotOnTop = false
					end

					local handlerTarget

					self._fightEffList[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
				end
			end

			local resultInfoMo = PeakTournamentModel.instance:getResultInfoMo(eliRoundId, self._curGroupIndex, stageIdx)

			for seatIdx, seatCell in ipairs(stageCell._seatCellList) do
				local isMe = seatIdx == 1
				local isNilSeat = true

				isNilSeat = resultInfoMo and (eliRoundId > self._curEliRoundId and true or periodId <= EliminatorMgr.PeriodId.WaitOpen) or true

				GameUtil.SetActive(seatCell._imgNilSeat, isNilSeat)
				GameUtil.SetActive(seatCell._headcell, not isNilSeat)

				if not isNilSeat and resultInfoMo then
					local headInfo = resultInfoMo:getHeadInfo(isMe)

					if headInfo then
						HeadItemController.instance:setHeadCellByInfo(seatCell._headIcon, headInfo, true)
					else
						HeadItemController.instance:resetHeadCell(seatCell._headIcon)
					end

					local userName = resultInfoMo:getUserNameAddAreaId(isMe)
					local userId = resultInfoMo:getUserId(isMe)

					if userId == self._myUserId then
						userName = string.format("<color=#3E8F4E>%s</color>", userName)
					end

					seatCell._txtName.text = userName

					local isWin = resultInfoMo:isWin(isMe)

					if periodId == EliminatorMgr.PeriodId.Ended and not isWin then
						seatCell._tagUIImageSpriteChange:SetState(0)
						GameUtil.SetActive(seatCell._tag, true)
					else
						GameUtil.SetActive(seatCell._tag, false)
					end

					GameUtil.SetActive(seatCell._winTag, periodId == EliminatorMgr.PeriodId.Ended and isWin)
					GameUtil.SetActive(seatCell._myTag, userId == self._myUserId)
				else
					HeadItemController.instance:resetHeadCell(seatCell._headIcon)
				end
			end
		end
	end

	self:_updateThroneColUI()
end

function TabPTEliBaseSpaceView:_onClearRoundColUI()
	if self._roundCellList == nil then
		return
	end

	for roundIdx, roundCell in ipairs(self._roundCellList) do
		for stageIdx, stageCell in ipairs(roundCell._stageCellList) do
			local effParent = stageCell._fightEffParent

			UIEffectManager.instance:stopEffect(self._fightEffList[effParent])

			self._fightEffList[effParent] = nil

			for seatIdx, seatCell in ipairs(stageCell._seatCellList) do
				HeadItemController.instance:resetHeadCell(seatCell._headIcon)
			end
		end
	end

	self:_clearThroneColUI()
end

function TabPTEliBaseSpaceView:_updateThroneColUI()
	return
end

function TabPTEliBaseSpaceView:_clearThroneColUI()
	return
end

function TabPTEliBaseSpaceView:_onClickStageCellBtnWatch(eliRoundId, periodId, groupIndex, stageIdx)
	local tipsStr = ""

	if eliRoundId > self._curEliRoundId then
		tipsStr = "未到该比赛进程"
	end

	if eliRoundId == self._curEliRoundId and periodId < EliminatorMgr.PeriodId.Performance then
		tipsStr = "战斗还未开始"
	end

	if not string.nilorempty(tipsStr) then
		FloatWordMgr.instance:show(tipsStr)

		return
	end

	local resultInfoMo = PeakTournamentModel.instance:getResultInfoMo(eliRoundId, groupIndex, stageIdx)

	if periodId == EliminatorMgr.PeriodId.Performance then
		local battleIdList = resultInfoMo:getBattleIdList()

		if #battleIdList > 0 then
			UIJumper.instance:saveCurStack()

			local fightType = PeakTournamentController.FightType.EliFight

			PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetBattleVideoReq(battleIdList, nil, fightType)
			SurveyController.instance:reportBehavior(201370, self._activityId, eliRoundId)
		else
			FloatWordMgr.instance:show("没有可观看的战斗")
		end
	else
		UIStateManager.instance:push(ViewName.PTBattlefieldReportAsEliFightView, {
			resultInfoMo
		}, self._activityId, eliRoundId)
	end
end

function TabPTEliBaseSpaceView:_onClickBtnExchange()
	local jumpToStr = PeakTournamentConfig.instance:getPtCommonValue("PT_JUMP_SHOP_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function TabPTEliBaseSpaceView:_onClickBtnReward()
	UIStateManager.instance:push(ViewName.PTEliRankPrizeView, self._activityId)
end

function TabPTEliBaseSpaceView:_onCLickBtnBanPet()
	UIStateManager.instance:push(ViewName.PTEliBanPetTipsView, self._activityId)
end

return TabPTEliBaseSpaceView
