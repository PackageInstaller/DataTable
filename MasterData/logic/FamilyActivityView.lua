-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyActivityView.lua

module("logic.extensions.family.view.FamilyActivityView", package.seeall)

local FamilyActivityView = class("FamilyActivityView", TableViewComponent)

function FamilyActivityView:ctor()
	FamilyActivityView.super.ctor(self)
end

function FamilyActivityView:onExit()
	FamilyActivityView.super.onExit(self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._tickDailyRefreshData, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilyActivityItem, self._updateCellAtIndex, self)
end

function FamilyActivityView:buildUI()
	FamilyActivityView.super.buildUI(self)
end

function FamilyActivityView:onEnter()
	FamilyActivityView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._planId = checknumber(params[1])

	if self._planId <= 0 then
		self._planId = 1
	end

	self._isInitSR = false

	self:_onUpdateTableData()
	self._tableview:ReloadData()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._tickDailyRefreshData, self)
	self.addGEvent(self, GlobalNotify.UpdataFamilyActivityItem, self._updateCellAtIndex, self)
	self.addGEvent(self, GlobalNotify.GetFamilyActivityPanelInfoRes, self._tickDailyRefreshData, self)
	FamilyController.instance:sendGetFamilyActivityPanelInfoReq()

	if self._curViewDatas then
		for _, data in ipairs(self._curViewDatas) do
			if not data.isHide then
				if data.actType == GameEnum.FamilyActivityType.TeamPlay then
					FamilyteamplayController.instance:csSendGetTeamPlayProgressInfoReq()
				elseif data.actType == GameEnum.FamilyActivityType.FamilyWar then
					FamilyWarController.instance:csRequestFamilyBattleGetRegistrationInfoReq()
				elseif data.actType == GameEnum.FamilyActivityType.GodStatuesWar then
					local seasonId = GodStatuesWarController.instance:getSeasonId()

					if seasonId > 0 then
						GodStatuesWarController.instance:sendPM_NewFamilyBattleGetRegistrationReq()
					end
				end
			end
		end
	end
end

function FamilyActivityView:_onUpdateTableData()
	local dataList = {}
	local cfg = FamilyConfig.instance:getFamilyActivityItemCfgs(self._planId)

	if cfg then
		for _, data in ipairs(cfg) do
			if not data.isHide then
				table.insert(dataList, data)
			end
		end

		table.sort(dataList, function(a, b)
			return a.sort < b.sort
		end)
	end

	self._curViewDatas = dataList
end

function FamilyActivityView:_updateCellAtIndex(index)
	if checknumber(index) <= 0 or not self._isInitSR then
		return
	end

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		return
	end

	for i = 1, #self._curViewDatas do
		if self._curViewDatas[i] and self._curViewDatas[i].actType == index then
			self._tableview:UpdateCellAtIndex(i - 1)
		end
	end
end

function FamilyActivityView:_tickDailyRefreshData()
	if not self._isInitSR or self._tableview == nil then
		return
	end

	self._tableview:ReloadData()
end

function FamilyActivityView:_onReloadFinish()
	self._isInitSR = true
end

function FamilyActivityView:_getPath()
	return {
		cellPath = "tableCell",
		viewPath = "tableListSR"
	}
end

function FamilyActivityView:_cellSize()
	return 339, 558
end

function FamilyActivityView:_updateCell(view, cell, data)
	local itemGrp = goutil.findChildComponent(cell, "itemGrp", "UIChangeGroup")
	local itemGo = goutil.findChild(cell, "itemGo")
	local countGo = goutil.findChild(itemGo, "countGo")
	local middleTips = goutil.findChild(itemGo, "middleTips")
	local middleTips_txt = goutil.findChildTextComponent(itemGo, "middleTips/txt")
	local middleTips2 = goutil.findChild(itemGo, "middleTips2")
	local middleTips2_txt = goutil.findChildTextComponent(itemGo, "middleTips2/txt")
	local titleTxt = goutil.findChildTextComponent(countGo, "titleTxt")
	local countTxt = goutil.findChildTextComponent(countGo, "countTxt")
	local timeTxt = goutil.findChildTextComponent(itemGo, "timeTxt")
	local redPointGo = goutil.findChild(itemGo, "redPoint")
	local lockGo = goutil.findChild(itemGo, "lockGo")
	local lockTxt = goutil.findChildTextComponent(lockGo, "lockTxt")
	local tagGo = goutil.findChild(itemGo, "tagGo")
	local tagTxt = goutil.findChildTextComponent(tagGo, "tagTxt")
	local otherGo = goutil.findChild(itemGo, "otherGo")
	local nameTxt = goutil.findChildTextComponent(otherGo, "nameTxt")
	local descTxt = goutil.findChildTextComponent(otherGo, "descTxt")
	local nextTxt = goutil.findChildTextComponent(otherGo, "nextTxt")

	GameUtil.asBtn(itemGo):RemoveClickListener()
	itemGrp:SetState(data.grpIndex)

	timeTxt.text = ""
	lockTxt.text = "尚未开启"
	middleTips_txt.text = ""

	GameUtil.SetActive(lockGo, false)
	GameUtil.SetActive(tagGo, false)
	GameUtil.SetActive(otherGo, false)

	local countStr = ""
	local middleTipsStr = ""
	local middleTipsStrTwo = ""

	if data.actType == GameEnum.FamilyActivityType.TeamPlay then
		local baseInfo = FamilyteamplayModel.instance:getBaseProgressInfo()
		local allTime, progressInfo

		if baseInfo and checknumber(baseInfo.curZoneId) > 0 then
			progressInfo = baseInfo.progressInfo[FamilyteamplayController.teamPlayType.Season]
			allTime = FamilyteamplayConfig.instance:getChallengeTimes(FamilyteamplayController.teamPlayType.Season)
		else
			progressInfo = baseInfo.progressInfo[FamilyteamplayController.teamPlayType.Common]
			allTime = FamilyteamplayConfig.instance:getChallengeTimes(FamilyteamplayController.teamPlayType.Common)
		end

		local useTime = checknumber(progressInfo.todayChallengedTimes)

		countStr = allTime - useTime .. "/" .. allTime

		if FamilyteamplayModel.instance:isFunOpen() then
			GameUtil.SetActive(otherGo, true)

			nameTxt.text = "家族围剿"

			local isAllPass = FamilyteamplayModel.instance:isAllStagePass()
			local des = string.format("挑战次数：%s/%s", allTime - useTime, allTime)

			des = des .. "\n" .. FamilyteamplayModel.instance:getPeriodEndDescStr()
			descTxt.text = des
			nextTxt.text = FamilyteamplayModel.instance:getNextPeriodOpenDescStr()

			if isAllPass then
				GameUtil.SetActive(tagGo, true)

				tagTxt.text = "已通关"
			end
		else
			GameUtil.SetActive(lockGo, true)

			timeTxt.text = FamilyteamplayModel.instance:getPeriodOpenTimeStr()
		end
	elseif data.actType == GameEnum.FamilyActivityType.Battle then
		-- block empty
	elseif data.actType == GameEnum.FamilyActivityType.Escort then
		local boxBaseCfg = EscortConfig.instance:GetBaxBaseInfo()
		local isOpen = EscortModel.instance:JudgeOpenCondition()

		goutil.setActive(lockGo, not isOpen)

		local escortInfo = EscortModel.instance:GetEscortBaseInfo()

		countStr = escortInfo and (isOpen and string.format("<color=#474086FF>%s/%s</color>", escortInfo.supEscortCount, escortInfo.freeEscortCount) or string.format("<color=#FFFFFFF>%s/%s</color>", escortInfo.supEscortCount, escortInfo.freeEscortCount)) or isOpen and string.format("<color=#474086FF>%s/%s</color>", boxBaseCfg.maxConvoyTimes, boxBaseCfg.maxConvoyTimes) or string.format("<color=#FFFFFFF>%s/%s</color>", boxBaseCfg.maxConvoyTimes, boxBaseCfg.maxConvoyTimes)

		if boxBaseCfg and boxBaseCfg.openTimes and #boxBaseCfg.openTimes > 0 then
			local openTimes = boxBaseCfg.openTimes
			local timeStr = "每日："

			for i = 1, #openTimes do
				if i > 1 then
					timeStr = timeStr .. "\n           "
				end

				if openTimes[i].startHour < 10 then
					if not ("0" .. openTimes[i].startHour) then
						local sh = tostring(openTimes[i].startHour)

						if openTimes[i].startMin < 10 then
							if not ("0" .. openTimes[i].startMin) then
								local sm = tostring(openTimes[i].startMin)

								if openTimes[i].endHour < 10 then
									if not ("0" .. openTimes[i].endHour) then
										local eh = tostring(openTimes[i].endHour)

										if openTimes[i].endMin < 10 then
											if not ("0" .. openTimes[i].endMin) then
												local em = tostring(openTimes[i].endMin)

												timeStr = timeStr .. string.format("%s:%s--%s:%s", sh, sm, eh, em)
											end
										end
									end
								end
							end
						end
					end
				end
			end

			timeTxt.text = isOpen and string.format("<color=#474086FF>%s</color>", timeStr) or string.format("<color=#FFFFFFF>%s</color>", timeStr)
		end
	elseif data.actType == GameEnum.FamilyActivityType.FamilyWar then
		if not FamilyWarModel.instance:isFamilyWarFuncUnlock() then
			GameUtil.SetActive(lockGo, true)

			lockTxt.text = string.format("家族等级%s级开启", FamilyWarConfig.instance:getFamilyWarLimitLevel())
		end

		local str = FamilyWarConfig.instance:getFamilyWarCommonParam("NEST_ATTACK_TIMES_LIMIT")
		local allCount = checknumber(str)

		str = FamilyWarConfig.instance:getFamilyWarCommonParam("DIVINE_PILLAR_ATTACK_TIMES_LIMIT")
		allCount = allCount + checknumber(str)

		local isOpen, desc = FamilyWarModel.instance:getFamilyWarFuncOpenDes()

		timeTxt.text = desc

		if isOpen then
			local baseInfo = FamilyWarModel.instance:getFamilyWarBaseInfo()
			local supCount = baseInfo.nestAttackTimes + baseInfo.pillarAttackTimes

			countStr = string.format("<color=#474086FF>%s/%s</color>", allCount - supCount, allCount)

			if FamilyWarModel.instance:isApplyFamilyWar() then
				GameUtil.SetActive(tagGo, true)

				tagTxt.text = "已报名"
			end
		else
			countStr = string.format("<color=#474086FF>%s/%s</color>", allCount, allCount)
		end
	elseif data.actType == GameEnum.FamilyActivityType.Task then
		-- block empty
	elseif data.actType == GameEnum.FamilyActivityType.Contribution then
		local poolCfg = FamilyConfig.instance:getDonatePoolCfg(FamilyModel.instance:getFamilyLv())

		if poolCfg then
			if not poolCfg.maxDonateTimes then
				local maxCount = 0
				local leftCount = math.max(0, maxCount - FamilyModel.instance:getDonateTimes())

				countStr = string.format("<color=#474086FF>%s/%s</color>", leftCount, maxCount)
			end
		end
	elseif data.actType == GameEnum.FamilyActivityType.RedEnvelope then
		-- block empty
	elseif data.actType == GameEnum.FamilyActivityType.FamilyShop then
		-- block empty
	elseif data.actType == GameEnum.FamilyActivityType.FamilyHoudingClg then
		local fhId = self:_getFhIdOfFamilyHoudingClg()
		local leftTimes = self:_getLeftTimesOfFamilyHoudingClg()
		local maxTimes = self:_getMaxTimesOfFamilyHoudingClg(fhId)
		local myFamilyRank = self:_getMyFamilyRankOfFamilyHoudingClg()
		local myRank = self:_getMyRankOfFamilyHoudingClg()
		local result, tips = self:getTryEnterFamilyHoudingClgViewResultAndTips()
		local isLock = result ~= GameEnum.ResultCode.Success

		GameUtil.SetActive(lockGo, isLock)

		if result == GameEnum.ResultCode.NotInTime then
			lockTxt.text = "尚未开启"
		end

		GameUtil.SetActive(otherGo, not isLock)

		nameTxt.text = "家族围剿"

		local str1 = string.format("挑战次数：<color=#0070E7FF>%s/%s</color>", leftTimes, maxTimes)
		local str2 = myFamilyRank > 0 and string.format("家族排名：第<color=#0070E7FF>%s</color>名", myFamilyRank) or "家族排名：未上榜"
		local str3

		descTxt.text = string.format("%s\n%s\n%s", str1, str2, myRank > 0 and string.format("个人排名：第<color=#0070E7FF>%s</color>名", myRank) or "个人排名：未上榜")
	elseif data.actType == GameEnum.FamilyActivityType.FamilyPartyClg then
		local isIntime = FamilyPartyModel.instance:isPartyOpening()

		GameUtil.SetActive(lockGo, false)

		if not isIntime then
			lockTxt.text = "尚未开启\n\n每周三、五20:00开启"
		end

		local nowCount = FamilyPartyModel.instance:getHasGainIdlePrizeCount()
		local total = checknumber(FamilyPartyConfig.instance:getCommonValue("IDLE_PRIZE_LIMIT"))

		countStr = string.format("%s/%s", total - nowCount, total)
		timeTxt.text = "每周三、五20:00开启"
	elseif data.actType == GameEnum.FamilyActivityType.GodStatuesWar then
		local curSeasonId = GodStatuesWarController.instance:getSeasonId()
		local nextSeasonId = GodStatuesWarController.instance:getNextOpenSeasonId()
		local isHaveCurSeason = curSeasonId > 0
		local isHaveNextSeason = nextSeasonId > 0
		local isInTimeOfNext = GodStatuesWarController.instance:isInSeasonTime(nextSeasonId)
		local stepInCur = GodStatuesWarController.instance:getCurStepOfGsw(curSeasonId)
		local stepIntervalInCur = GodStatuesWarController.instance:getStepInterval(curSeasonId, stepInCur)
		local isRegisteredInCur = GodStatuesWarController.instance:isRegisteredOfGsw(curSeasonId)
		local isCanParticipateInCur = GodStatuesWarController.instance:isCanParticipateOfGsw(curSeasonId)
		local isCanFightInCur = GodStatuesWarController.instance:isCanFight(curSeasonId)
		local stepInNext = GodStatuesWarController.instance:getCurStepOfGsw(nextSeasonId)
		local isRegisteredInNext = GodStatuesWarController.instance:isRegisteredOfGsw(nextSeasonId)
		local stepIntervalInNext = GodStatuesWarController.instance:getStepInterval(nextSeasonId, stepInNext)
		local isCanParticipateInNext = GodStatuesWarController.instance:isCanParticipateOfGsw(nextSeasonId)
		local isCanFightInNext = GodStatuesWarController.instance:isCanFight(nextSeasonId)
		local result, tips = GodStatuesWarController.instance:getTryEnterGodStatuesWarResultAndTips(curSeasonId)

		if result == GameEnum.ResultCode.NotInTime then
			if isHaveNextSeason then
				local nextSeasonData = GodStatuesWarConfig.instance:getNfbSeasonData(nextSeasonId)

				if nextSeasonData then
					local sDate, eDate = GameUtil.string2date(nextSeasonData.seasonStartTime), GameUtil.string2date(nextSeasonData.seasonEndTime)

					lockTxt.text = string.format("下期时间：%d月%d日 %d点-%d月%d日 %d点", sDate.month, sDate.day, sDate.hour, eDate.month, eDate.day, eDate.hour)
				end
			else
				lockTxt.text = "活动已结束"
			end

			GameUtil.SetActive(lockGo, true)
		elseif result == GameEnum.ResultCode.ErrorLevel then
			lockTxt.text = string.format("家族等级%s级开启", GodStatuesWarConfig.instance:getNfbParamsValue("FAMILY_LEVEL_LIMIT"))

			GameUtil.SetActive(lockGo, true)
		end

		if result == GameEnum.ResultCode.Success then
			tagTxt.text = "已报名"

			if isHaveCurSeason or isHaveNextSeason then
				if isCanParticipateInCur and isCanFightInCur then
					GameUtil.SetActive(tagGo, isRegisteredInCur)
				elseif isCanParticipateInNext then
					GameUtil.SetActive(tagGo, isRegisteredInNext)
				end
			else
				GameUtil.SetActive(tagGo, false)
			end
		end

		if result == GameEnum.ResultCode.Success then
			if isHaveCurSeason then
				local stepData = GodStatuesWarConfig.instance:getNfbStepData(curSeasonId, stepInCur)

				middleTipsStr = stepData and stepData.desc or ""
			elseif isInTimeOfNext then
				local stepData = GodStatuesWarConfig.instance:getNfbStepData(nextSeasonId, stepInNext)

				if stepData then
					if stepIntervalInNext <= GswEnum.StepInterval_Reg then
						local sDate = GameUtil.string2date(stepData.registrationStartTime)

						middleTipsStr = string.format("新赛季报名：%d月%d日", sDate.month, sDate.day)
					elseif stepData then
						if not stepData.desc then
							local desc = ""

							middleTipsStr = string.format("新赛季：%s", desc)
						end
					end
				end
			end
		end

		if result == GameEnum.ResultCode.Success and not string.nilorempty(middleTipsStr) and isInTimeOfNext then
			local stepData = GodStatuesWarConfig.instance:getNfbStepData(nextSeasonId, stepInNext)

			if stepData then
				if stepIntervalInNext <= GswEnum.StepInterval_Reg then
					local sDate = GameUtil.string2date(stepData.registrationStartTime)

					middleTipsStrTwo = string.format("新赛季报名：%d月%d日", sDate.month, sDate.day)
				elseif stepData then
					if not stepData.desc then
						local desc = ""

						middleTipsStrTwo = string.format("新赛季：%s", desc)
					end
				end
			end
		end

		if result == GameEnum.ResultCode.Success and isCanParticipateInCur and isCanFightInCur and stepIntervalInCur == GswEnum.StepInterval_Bat then
			local leftPillar = GodStatuesWarController.instance:getLeftDivinePillarFightTime(curSeasonId, stepInCur)
			local maxPillar = GodStatuesWarController.instance:getMaxDivinePillarFightTime(curSeasonId, stepInCur)
			local leftNest = GodStatuesWarController.instance:getNestLeftFightTime(curSeasonId)
			local maxNest = GodStatuesWarController.instance:getNestMaxFightTime(curSeasonId, stepInCur)
			local left, max = 0, 0

			if stepIntervalInCur == GswEnum.StepInterval_Bat then
				left = leftPillar + leftNest
				max = maxPillar + maxNest
			else
				left = maxPillar + maxNest
				max = maxPillar + maxNest
			end

			countStr = string.format("%s/%s", left, max)
		end

		local timeTxtDesc = ""

		local function getTimeTxtDesc(seasonId)
			local result = ""
			local step = GodStatuesWarController.instance:getCurStepOfGsw(seasonId)
			local stepInterval = GodStatuesWarController.instance:getStepInterval(seasonId, step)
			local stepIntervalTimeFields = GodStatuesWarController.instance:getStepIntervalTimeFields(seasonId, step, stepInterval)

			if stepIntervalTimeFields then
				local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)
				local sDate, eDate = GameUtil.string2date(stepData[stepIntervalTimeFields[1]]), GameUtil.string2date(stepData[stepIntervalTimeFields[2]])
				local intervalName = GswEnum.StepIntervalNames[stepIntervalInCur]

				result = string.format("%s：%d月%d日 %d点-%d月%d日 %d点", intervalName, sDate.month, sDate.day, sDate.hour, eDate.month, eDate.day, eDate.hour)
			else
				local nextStepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step + 1)

				if nextStepData then
					local nextFirstStepInterval = GodStatuesWarController.instance:getFirstStepInterval(seasonId, nextStepData.step)
					local intervalName = GswEnum.StepIntervalNames[nextFirstStepInterval]
					local fields = GodStatuesWarController.instance:getStepIntervalTimeFields(seasonId, nextStepData.step, nextFirstStepInterval)

					if fields then
						local sDate, eDate = GameUtil.string2date(nextStepData[fields[1]]), GameUtil.string2date(nextStepData[fields[2]])

						result = string.format("%s：%d月%d日 %d点-%d月%d日 %d点", intervalName, sDate.month, sDate.day, sDate.hour, eDate.month, eDate.day, eDate.hour)
					end
				end
			end

			return result
		end

		if result == GameEnum.ResultCode.Success then
			if isHaveCurSeason and isRegisteredInCur and isCanParticipateInCur and isCanFightInCur or not isRegisteredInCur and stepInCur <= GswEnum.StepInterval_Reg then
				timeTxtDesc = getTimeTxtDesc(curSeasonId)
			end

			if string.nilorempty(timeTxtDesc) then
				if isInTimeOfNext then
					timeTxtDesc = getTimeTxtDesc(nextSeasonId)
				else
					local nextSeasonData = GodStatuesWarConfig.instance:getNfbSeasonData(nextSeasonId)

					if nextSeasonData then
						local sDate, eDate = GameUtil.string2date(nextSeasonData.seasonStartTime), GameUtil.string2date(nextSeasonData.seasonEndTime)

						timeTxtDesc = string.format("新赛季：%d月%d日 %d点-%d月%d日 %d点", sDate.month, sDate.day, sDate.hour, eDate.month, eDate.day, eDate.hour)
					end
				end
			end
		end

		timeTxt.text = timeTxtDesc
	end

	if string.nilorempty(data.redIds) then
		GameUtil.SetActive(redPointGo, false)
	else
		RedPointController.instance:regRedPoint(redPointGo, unpack(string.split(data.redIds, "#")))
	end

	if string.nilorempty(data.titleStr) or string.nilorempty(countStr) then
		titleTxt.text = ""
		countTxt.text = ""

		GameUtil.SetActive(countGo, false)
	else
		GameUtil.SetActive(countGo, true)

		titleTxt.text = data.titleStr
		countTxt.text = countStr
	end

	if string.nilorempty(middleTipsStr) then
		GameUtil.SetActive(middleTips, false)
	else
		middleTips_txt.text = middleTipsStr

		GameUtil.SetActive(middleTips, true)
	end

	if string.nilorempty(middleTipsStrTwo) then
		GameUtil.SetActive(middleTips2, false)
	else
		middleTips2_txt.text = middleTipsStrTwo

		GameUtil.SetActive(middleTips2, true)
	end

	GameUtil.asBtn(itemGo):AddClickListener(function()
		self:_onClickBtn(data)
	end)
end

function FamilyActivityView:_clearTableview(cell)
	local redPoint = goutil.findChild(cell.gameObject, "itemGo/redPoint")
	local itemGo = goutil.findChild(cell, "itemGo")

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.asBtn(itemGo):RemoveClickListener()
end

function FamilyActivityView:_onClickBtn(data)
	if data == nil then
		FloatWordMgr.instance:show("功能未开启！")

		return
	end

	if not string.nilorempty(data.jumpTo) then
		GotoMgr.gotoByString(data.jumpTo)

		return
	end

	if data.actType == GameEnum.FamilyActivityType.Escort then
		if not EscortModel.instance:JudgeOpenCondition() then
			FloatWordMgr.instance:show("功能尚未开启！")

			return
		end

		if not EscortModel.instance:IsOpenEscortView() then
			FloatWordMgr.instance:show("未到开放时间！")

			return
		end

		FamilySceneController.instance:leaveScene()
		EscortModel.instance:StartFindGotoNPC()
	elseif data.actType == GameEnum.FamilyActivityType.FamilyWar then
		local value = GameUtil.getUserData("FamilyWarTabRule")

		if checknumber(value) ~= 1 then
			GameUtil.saveUserData("FamilyWarTabRule", 1)
			UIStateManager.instance:push(ViewName.FamilyWarRule, true)
		else
			FamilyWarController.instance:openFamilyWarMianView()
		end
	elseif data.actType == GameEnum.FamilyActivityType.FamilyHoudingClg then
		local result, tips = self:getTryEnterFamilyHoudingClgViewResultAndTips()

		FloatWordMgr.instance:show(tips)

		if result == GameEnum.ResultCode.Success then
			UIStateManager.instance:push(ViewName.FamilyHoudingClgMainView)
		end
	elseif data.actType == GameEnum.FamilyActivityType.FamilyPartyClg then
		FamilyPartyController.instance:onClickFamilyPartyTab()
	elseif data.actType == GameEnum.FamilyActivityType.FamilyTutengClg then
		UIStateManager.instance:push(ViewName.FamilytotemView)
	else
		FloatWordMgr.instance:show("功能未开启！")
	end
end

function FamilyActivityView:getTryEnterFamilyHoudingClgViewResultAndTips()
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local fhId = self:_getFhIdOfFamilyHoudingClg()

	if not self:_isInTimeOfFamilyHoudingClg(fhId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开放时间内"
	end

	return result, tips
end

function FamilyActivityView:_isInTimeOfFamilyHoudingClg(fhId)
	if fhId > 0 then
		return FamilyHoudingClgController.instance:isInTime(fhId)
	else
		return false
	end
end

function FamilyActivityView:_isEnoughTimesOfFamilyHoudingClg(fhId)
	local leftTimes = self:_getLeftTimesOfFamilyHoudingClg()

	return leftTimes > 0
end

function FamilyActivityView:_getFhIdOfFamilyHoudingClg()
	local msg = FamilyController.instance:getFamilyActivityPanelInfoResMsg()

	return (msg and msg.houndingInfo or nil) and msg.houndingInfo.planId
end

function FamilyActivityView:_getLeftTimesOfFamilyHoudingClg()
	local msg = FamilyController.instance:getFamilyActivityPanelInfoResMsg()

	return (msg and msg.houndingInfo or nil) and msg.houndingInfo.leftChallengeTimes
end

function FamilyActivityView:_getMyFamilyRankOfFamilyHoudingClg()
	local msg = FamilyController.instance:getFamilyActivityPanelInfoResMsg()

	return (msg and msg.houndingInfo or nil) and msg.houndingInfo.myFamilyRank
end

function FamilyActivityView:_getMyRankOfFamilyHoudingClg()
	local msg = FamilyController.instance:getFamilyActivityPanelInfoResMsg()

	return (msg and msg.houndingInfo or nil) and msg.houndingInfo.myRank
end

function FamilyActivityView:_getMaxTimesOfFamilyHoudingClg(fhId)
	return FamilyHoudingClgController.instance:getMaxChallengeTimes(fhId)
end

return FamilyActivityView
