-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakStageView.lua

module("logic.extensions.skypeak.view.SkyPeakStageView", package.seeall)

local SkyPeakStageView = class("SkyPeakStageView", ViewComponent)

function SkyPeakStageView:ctor()
	SkyPeakStageView.super.ctor(self)
end

function SkyPeakStageView:unbindEvents()
	SkyPeakStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnClgStage)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnBuff)
end

function SkyPeakStageView:bindEvents()
	SkyPeakStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnBossClg, self)
	GameUtil.addClickHandler(self._btnClgStage, self._onClickBtnStageClg, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function SkyPeakStageView:buildUI()
	SkyPeakStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnReward = self:getGo("btnReward")
	self._btnBuff = self:getGo("btnBuff")

	local goCellStageInfo = self:getGo("stageInfo/cell")
	local goTabStageInfo = self:getGo("stageInfo/tableview")

	self._tableviewStageInfo = ScrollerList.create(goTabStageInfo, goCellStageInfo, GameUtil.handler(self._updateCellStageInfo, self), GameUtil.handler(self._clearCellStageInfo, self))
	self._stage = self:getGo("stage")
	self._head = self:getGo("stage/firstPlayer/head")
	self._firstPlayer = self:getGo("stage/firstPlayer")
	self._txtPlayerName = self:getTxt("stage/firstPlayer/txtPlayerName")
	self._txtPlayerScore = self:getTxt("stage/firstPlayer/txtScore")
	self._txtTitleFirstPlayer = self:getTxt("stage/firstPlayer/txtTitle")
	self._txtScoreStage = self:getTxt("stage/txtScore")

	local goCellActiveNum = self:getGo("stage/activeNum/cell")
	local goTabActiveNum = self:getGo("stage/activeNum/tableview")

	self._tableviewActiveNum = ScrollerList.create(goTabActiveNum, goCellActiveNum, GameUtil.handler(self._updateCellActiveNum, self), GameUtil.handler(self._clearCellActiveNum, self))

	local goCellRoundNum = self:getGo("stage/roundNum/cell")
	local goTabRoundNum = self:getGo("stage/roundNum/tableview")

	self._tableviewRoundNum = ScrollerList.create(goTabRoundNum, goCellRoundNum, GameUtil.handler(self._updateCellRoundNum, self), GameUtil.handler(self._clearCellRoundNum, self))
	self._btnClgStage = self:getGo("stage/btnClg")
	self._txtAddScoreTips = self:getTxt("stage/killInfo/txtAddScoreTips")
	self._txtName = self:getTxt("stage/killInfo/txtName")
	self._petCon = self:getGo("stage/killInfo/petCon")
	self._posCon = self:getGo("stage/killInfo/posCon")
	self._posList = {}

	for i = 1, 9 do
		local posGo = goutil.findChild(self._posCon, "pos" .. i)

		table.insert(self._posList, posGo)
	end

	self._boss = self:getGo("boss")
	self._btnClg = self:getGo("boss/btnClg")
	self._showCon = self:getGo("boss/showCon")
	self._sliderHp = self:getSlider("boss/hp/slider")
	self._txtHp = self:getTxt("boss/hp/txt")
	self._bossCon = self:getGo("boss/bossCon")
	self._txtBossName = self:getTxt("boss/txtBossName")
end

function SkyPeakStageView:onExit()
	SkyPeakStageView.super.onExit(self)
	self._tableviewStageInfo:dispose()
	MaterialMgr.resetAll(self._showCon)
	MaterialMgr.resetAll(self._bossCon)
	MaterialMgr.resetAll(self._petCon)

	self._subCellMap = {}
end

function SkyPeakStageView:onEnter()
	SkyPeakStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SkyPeakGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_SkyPeakSweepRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_SkyPeakGetStageInfoRes, self._handleGetStageDetail, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = SkyPeakController.instance:getDefaultActivityId() or 0
	end

	goutil.setActive(self._stage, false)
	goutil.setActive(self._boss, false)
	self:_updateUIByCfg()
	self:_updateUIByInfo()

	self._isFirstEnter = true

	SkyPeakController.instance:getInfo(self._activityId)
end

function SkyPeakStageView:_updateUIByCfg()
	self._actCfg = SkyPeakConfig.instance:getActivityCfg(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._showStageDataList = {}

	local bossCfgList = SkyPeakConfig.instance:getAllBossCfgs(self._activityId) or {}
	local stageCfgList = SkyPeakConfig.instance:getAllStageCfgs(self._activityId) or {}

	if #stageCfgList == 0 then
		return
	end

	local lastBossId = 0
	local sortId = 0

	for stageId, stageCfg in ipairs(stageCfgList) do
		if not stageCfg.preBossId then
			local curBossId = 0

			if lastBossId < curBossId then
				local bossCfg = SkyPeakConfig.instance:getBossCfgById(self._activityId, curBossId)

				if bossCfg then
					local stageInfo = {}

					stageInfo.isBoss = true
					sortId = sortId + 1
					stageInfo.sortId = sortId
					stageInfo.cfg = bossCfg

					table.insert(self._showStageDataList, stageInfo)

					lastBossId = curBossId
				end
			end

			local stageInfo = {}

			stageInfo.isBoss = false
			stageInfo.cfg = stageCfg
			sortId = sortId + 1
			stageInfo.sortId = sortId

			table.insert(self._showStageDataList, stageInfo)
		end
	end

	local lastBossCfg = bossCfgList[#bossCfgList]

	if lastBossCfg then
		if lastBossId < (lastBossCfg.bossId or 0) then
			local bossCfg = SkyPeakConfig.instance:getBossCfgById(self._activityId, lastBossCfg.bossId)

			if bossCfg then
				local stageInfo = {}

				stageInfo.isBoss = true
				sortId = sortId + 1
				stageInfo.sortId = sortId
				stageInfo.cfg = bossCfg

				table.insert(self._showStageDataList, stageInfo)
			end
		end
	end
end

function SkyPeakStageView:_updateUIByInfo()
	self._curMaxPassStageId = SkyPeakModel.instance:getMaxPassStageId(self._activityId)

	self._tableviewStageInfo:reloadData(self._showStageDataList)

	if #self._showStageDataList == 0 then
		goutil.setActive(self._stage, false)
		goutil.setActive(self._boss, false)

		return
	end

	if not self._isFirstEnter then
		return
	end

	self._isFirstEnter = false

	local showId = 0

	for i, stageData in ipairs(self._showStageDataList) do
		if stageData.isBoss then
			-- block empty
		elseif not stageData.cfg.stageId then
			local stageId = 0
			local isPass = SkyPeakModel.instance:isStagePassed(self._activityId, stageId)

			if not isPass then
				showId = i

				break
			end
		end
	end

	local showDataBf = self._showStageDataList[showId - 1]

	if showDataBf and showDataBf.isBoss then
		if not showDataBf.cfg.bossId then
			do
				local bossId = 0
				local isPassBoss = SkyPeakModel.instance:isBossPassed(self._activityId, bossId)

				if not isPassBoss then
					showId = showId - 1
				end
			end

			local showData = self._showStageDataList[showId]

			if showData then
				local unlockTimeStr = ""

				unlockTimeStr = showData.isBoss and (showData.cfg.unlockTime or "") or showData.cfg.unlockTime or ""

				if not string.nilorempty(unlockTimeStr) then
					local unlockTimestamp = GameUtil.string2time(unlockTimeStr)
					local curTimestamp = ServerTime.now()

					if curTimestamp < unlockTimestamp then
						showId = showId - 1
					end
				end
			end

			if showId <= 0 then
				showId = 1
			end

			local showData = self._showStageDataList[showId]

			if not showData then
				return
			end

			self:_switchToStage(showData)
			self._tableviewStageInfo:MoveCellToBegin(showData.sortId - 1)
		end
	end
end

function SkyPeakStageView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function SkyPeakStageView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.SkyPeakBuffTreeView, self._activityId)
end

function SkyPeakStageView:_onClickBtnReward()
	UIStateManager.instance:push(ViewName.SkyPeakRewardView, self._activityId)
end

function SkyPeakStageView:_onClickBtnStage(data)
	self:_switchToStage(data)
end

function SkyPeakStageView:_onClickBtnBossClg()
	if self._curSelectStageData and self._curSelectStageData.isBoss then
		if not self._curSelectStageData.cfg.bossId then
			if not self._curSelectStageData.cfg.preStageId then
				local preStageId = 0
				local isPrePass = SkyPeakModel.instance:isStagePassed(self._activityId, preStageId)

				if not isPrePass then
					TipsFacade.instance:openCommonTips(lang("请先通关前置关卡"))

					return
				end

				if not self._curSelectStageData.cfg.unlockTime then
					local unlocktime = ""

					if not string.nilorempty(unlocktime) then
						local unlockTimestamp = GameUtil.string2time(unlocktime)
						local curTimestamp = ServerTime.now()

						if curTimestamp < unlockTimestamp then
							TipsFacade.instance:openCommonTips(lang("BOSS未开放"))

							return
						end
					end

					SkyPeakController.instance:showMissionViewBoss(self._activityId, self._curSelectStageData.cfg.bossId)
				end
			end
		end
	end
end

function SkyPeakStageView:_switchToStage(data)
	self._curSelectStageData = data

	self._tableviewStageInfo:reloadData(self._showStageDataList)
	goutil.setActive(self._stage, not data.isBoss)
	goutil.setActive(self._boss, data.isBoss)

	if data.isBoss then
		if not data.cfg.bossId then
			local bossId = 0

			self:_updateBossInfo(bossId)
		end
	elseif not data.cfg.stageId then
		local stageId = 0

		self:_updateStageInfo(stageId)
	end
end

function SkyPeakStageView:_updateStageInfo(stageId)
	local stageInfo = SkyPeakModel.instance:getStageInfo(self._activityId, stageId)

	if stageInfo then
		self._txtScoreStage.text = checknumber(stageInfo.maxScore)
	end

	local stageCfg = SkyPeakConfig.instance:getStageCfgById(self._activityId, stageId)
	local roundCfgs = SkyPeakConfig.instance:getRoundCircleScoreCfgs(stageCfg.circleScorePlanId) or {}
	local temCfgs = {}

	for i, cfg in ipairs(roundCfgs) do
		if cfg.score > 0 then
			local temData = {}

			temData.sortId = i
			temData.cfg = cfg

			table.insert(temCfgs, temData)
		end
	end

	self._tableviewRoundNum:reloadData(temCfgs)
	self._tableviewActiveNum:MoveCellToBegin(0)

	local activeCfgs = SkyPeakConfig.instance:getAliveScoreCfgs(stageCfg.aliveScorePlanId) or {}

	self._tableviewActiveNum:reloadData(activeCfgs)
	self._tableviewActiveNum:MoveCellToBegin(0)
	goutil.setActive(self._firstPlayer, false)

	if not stageCfg.killUnitScore then
		self._txtAddScoreTips.text = langPara("每击杀一个精灵可得<color=#FF6464>%s分</color>", stageCfg.killUnitScore)

		if not stageCfg.scorePetValidator then
			local scorePetValidator = ""
			local params = string.split(scorePetValidator, "$")
			local paramType = params[1]
			local paramValue = params[2]

			goutil.setActive(self._petCon, false)
			goutil.setActive(self._posCon, false)

			self._txtName.text = ""

			if paramType == SkyPeakModel.KillScoreParamType.OriginalPos then
				goutil.setActive(self._posCon, true)

				local pos = checknumber(paramValue)

				self._txtName.text = langPara("第<color=#FF6464>%s</color>站位的精灵", pos + 1)

				for i, posGo in ipairs(self._posList) do
					if i == pos + 1 then
						GameUtil.setUIImageSpriteIdx(posGo, 1)
					else
						GameUtil.setUIImageSpriteIdx(posGo, 0)
					end
				end
			elseif paramType == SkyPeakModel.KillScoreParamType.OriginalRace then
				local raceId = checknumber(paramValue)
				local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)

				if petSkinCfg then
					self._txtName.text = petSkinCfg.name or ""

					local proxy = MaterialMgr.setCell(MatType.Pet, raceId, self._petCon)

					if proxy then
						proxy:setAutoTips(false)
					end

					goutil.setActive(self._petCon, true)
				end
			end

			SkyPeakController.instance:getStageInfo(self._activityId, stageId)
		end
	end
end

function SkyPeakStageView:_updateBossInfo(bossId)
	local bossCfg = SkyPeakConfig.instance:getBossCfgById(self._activityId, bossId)

	if self._actCfg and bossCfg then
		local showItemStr = string.format("%s:%s", self._actCfg.scoreShowItem or "", bossCfg.buffScore)

		MaterialMgr.resetAll(self._showCon)
		MaterialMgr.setCellByCfg(showItemStr, self._showCon)
	end

	local bossTotalHp = SkyPeakModel.instance:getBossTotalHp(self._activityId, bossId)
	local hpPercent = 0
	local bossLeftHp = 0
	local bossInfo = SkyPeakModel.instance:getBossInfo(self._activityId, bossId)

	bossLeftHp = bossInfo and checknumber(bossInfo.bossLeftHp) or bossTotalHp

	if bossTotalHp > 0 then
		hpPercent = math.floor(bossLeftHp / bossTotalHp * 100)

		if hpPercent <= 0 and bossLeftHp > 0 then
			hpPercent = 1
		end
	else
		hpPercent = 0
	end

	self._txtHp.text = langPara("%s%%", hpPercent)

	local isPass = SkyPeakModel.instance:isBossPassed(self._activityId, bossId)

	goutil.setActive(self._btnClg, not isPass)
	self._sliderHp:SetValue(hpPercent / 100)
	MaterialMgr.resetAll(self._bossCon)

	local bossMo = SkyPeakModel.instance:getBossMo(self._activityId, bossId)

	if bossMo then
		self._txtBossName.text = bossMo:getName()

		local proxy = MaterialMgr.setCellByMo(bossMo, self._bossCon)

		if proxy then
			proxy:setAutoTips(false)
		end
	end
end

function SkyPeakStageView:_getSubInfoCell(parentGo)
	self._subCellMap = self._subCellMap or {}

	local cell = self._subCellMap[parentGo]

	if not cell then
		cell = {
			gameObject = parentGo,
			txtStage = goutil.findChildTextComponent(parentGo, "txtStage"),
			markBoss = goutil.findChild(parentGo, "markBoss"),
			txtInfo = goutil.findChildTextComponent(parentGo, "txtInfo")
		}
		self._subCellMap[parentGo] = cell
	end

	return cell
end

function SkyPeakStageView:_updateCellStageInfo(view, cell, data, tag)
	local go = cell.gameObject
	local unselectGo = goutil.findChild(go, "unselect")
	local selectGo = goutil.findChild(go, "select")
	local lockGo = goutil.findChild(go, "lock")

	GameUtil.SetGray(lockGo, true)

	local txtUnlockTips = goutil.findChildTextComponent(go, "lock/txtUnlockTips")
	local isTimeLock = false
	local unlockTimeStr = ""
	local isBossStage = data.isBoss

	unlockTimeStr = isBossStage and (data.cfg.unlockTime or "") or data.cfg.unlockTime or ""

	if not string.nilorempty(unlockTimeStr) then
		local unlockTimestamp = GameUtil.string2time(unlockTimeStr)
		local curTimestamp = ServerTime.now()

		if curTimestamp < unlockTimestamp then
			isTimeLock = true

			local unLockTimeDate = GameUtil.time2date(unlockTimestamp)

			txtUnlockTips.text = langPara("%s.%s 5:00后解锁", unLockTimeDate.month, unLockTimeDate.day)
		end
	end

	goutil.setActive(unselectGo, false)
	goutil.setActive(selectGo, false)
	goutil.setActive(lockGo, false)

	local cell
	local isSelect = data == self._curSelectStageData

	cell = isTimeLock and self:_getSubInfoCell(lockGo) or isSelect and self:_getSubInfoCell(selectGo) or self:_getSubInfoCell(unselectGo)

	local isPass = false

	if cell then
		goutil.setActive(cell.gameObject, true)

		if isTimeLock then
			cell.txtInfo.text = ""

			if isBossStage then
				goutil.setActive(cell.markBoss, true)
				goutil.setActive(cell.txtStage.gameObject, false)
			else
				goutil.setActive(cell.markBoss, false)
				goutil.setActive(cell.txtStage.gameObject, true)

				cell.txtStage.text = langPara("%s层", data.cfg.stageId or 0)
			end
		elseif isBossStage then
			goutil.setActive(cell.markBoss, true)
			goutil.setActive(cell.txtStage.gameObject, false)

			cell.txtInfo.text = data.cfg.title or ""

			if not data.cfg.bossId then
				local bossId = 0

				isPass = SkyPeakModel.instance:isBossPassed(self._activityId, bossId)
			end
		end

		goutil.setActive(cell.markBoss, false)
		goutil.setActive(cell.txtStage.gameObject, true)

		cell.txtStage.text = langPara("%s层", data.cfg.stageId or 0)

		if not data.cfg.stageId then
			do
				local stageId = 0

				isPass = SkyPeakModel.instance:isStagePassed(self._activityId, stageId)

				if isPass then
					local stageInfo = SkyPeakModel.instance:getStageInfo(self._activityId, stageId)

					cell.txtInfo.text = langPara("分数：%s", (stageInfo or nil) and checknumber(stageInfo.maxScore))
				else
					cell.txtInfo.text = "未通关"
				end
			end

			local markPass = goutil.findChild(go, "markPass")

			goutil.setActive(markPass, isPass)

			local btn = goutil.findChild(go, "btn")

			GameUtil.addClickHandler(btn, function()
				if isTimeLock then
					TipsFacade.instance:openCommonTips(lang("该关卡未解锁"))

					return
				end

				self:_onClickBtnStage(data)
			end, self)
		end
	end
end

function SkyPeakStageView:_clearCellStageInfo(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	if btn then
		GameUtil.rmClickHandler(btn)
	end
end

function SkyPeakStageView:_updateCellActiveNum(view, cell, data, tag)
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtNum.text = data.aliveNum

	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")

	txtScore.text = data.score

	local bg1 = goutil.findChild(cell.gameObject, "bg1")
	local bg2 = goutil.findChild(cell.gameObject, "bg2")

	goutil.setActive(bg1, data.aliveNum % 2 == 0)
	goutil.setActive(bg2, data.aliveNum % 2 ~= 0)
end

function SkyPeakStageView:_clearCellActiveNum(cell)
	return
end

function SkyPeakStageView:_updateCellRoundNum(view, cell, data, tag)
	if not data.cfg then
		local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

		txtNum.text = data.cfg.minCircle

		local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")

		txtScore.text = data.cfg.score

		local bg1 = goutil.findChild(cell.gameObject, "bg1")
		local bg2 = goutil.findChild(cell.gameObject, "bg2")

		goutil.setActive(bg1, data.sortId % 2 == 0)
		goutil.setActive(bg2, data.sortId % 2 ~= 0)
	end
end

function SkyPeakStageView:_clearCellRoundNum(cell)
	return
end

function SkyPeakStageView:_onClickBtnStageClg()
	if self._curSelectStageData and not self._curSelectStageData.isBoss then
		if not self._curSelectStageData.cfg.stageId then
			local stageId = 0
			local isPass = SkyPeakModel.instance:isStagePassed(self._activityId, stageId)

			if isPass then
				SkyPeakController.instance:showMissionViewStage(self._activityId, stageId)
			elseif not self._curSelectStageData.cfg.preBossId then
				local preBossId = 0
				local isPrePassBoss = preBossId == 0 or SkyPeakModel.instance:isBossPassed(self._activityId, preBossId)
				local isPrePassStage = stageId <= self._curMaxPassStageId + 1

				if isPrePassBoss and isPrePassStage then
					if not self._curSelectStageData.cfg.unlockTime then
						local unlockTime = ""
						local isTimeOpen = false

						if not string.nilorempty(unlockTime) then
							local unlockTimestamp = GameUtil.string2time(unlockTime)
							local curTimestamp = ServerTime.now()

							if unlockTimestamp <= curTimestamp then
								isTimeOpen = true
							end
						else
							isTimeOpen = true
						end

						if isTimeOpen then
							SkyPeakController.instance:showMissionViewStage(self._activityId, stageId)
						else
							TipsFacade.instance:openCommonTips(lang("请先等待解锁时间"))
						end
					end
				elseif not isPrePassBoss then
					TipsFacade.instance:openCommonTips(lang("请先通关前置BOSS"))
				elseif not isPrePassStage then
					TipsFacade.instance:openCommonTips(lang("请先通关前置关卡"))
				end
			end
		end
	end
end

function SkyPeakStageView:_handleGetStageDetail()
	if not self._curSelectStageData then
		return
	end

	if self._curSelectStageData.isBoss then
		return
	end

	if not self._curSelectStageData.cfg.stageId then
		local stageId = 0
		local stageDetail = SkyPeakModel.instance:getStageDetail(self._activityId, stageId)

		if stageDetail and stageDetail.strongestRankInfo then
			local rankInfo = stageDetail.strongestRankInfo

			goutil.setActive(self._firstPlayer, true)
			HeadItemController.instance:resetHeadCell(self._head)
			HeadItemController.instance:setHeadCellByInfo(self._head, rankInfo.headInfo, true)

			self._txtPlayerName.text = rankInfo.headInfo.userName or ""
			self._txtPlayerScore.text = langPara("最高分：%s", rankInfo.value or 0)
			self._txtTitleFirstPlayer.text = langPara("第%s层最强者", stageId or 0)
		else
			goutil.setActive(self._firstPlayer, false)
		end
	end
end

return SkyPeakStageView
