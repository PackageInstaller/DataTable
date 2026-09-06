-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/TabPTEliMyScheduleView.lua

module("logic.extensions.peaktournament.view.eliminator.tab.TabPTEliMyScheduleView", package.seeall)

local TabPTEliMyScheduleView = class("TabPTEliMyScheduleView", ViewComponent)

function TabPTEliMyScheduleView:buildUI()
	TabPTEliMyScheduleView.super.buildUI(self)

	local btnParent = self:getGo("btn")

	self._btnExChange = goutil.findChild(btnParent, "btnExchange")
	self._btnReport = goutil.findChild(btnParent, "btnReport")
	self._btnReward = goutil.findChild(btnParent, "btnReward")
	self._btnForm = goutil.findChild(btnParent, "btnForm")
	self._btnBless = goutil.findChild(btnParent, "btnBless")
	self._btnBanPet = goutil.findChild(btnParent, "btnBanPet")
	self._nodata = self:getGo("nodata")
	self._txtNodata = goutil.findChildTextComponent(self._nodata, "txt")
	self._details = self:getGo("details")
	self._btnReview = goutil.findChild(self._details, "btnReview")
	self._txtRemainTime = self:getTxt("details/remainTime/txt")
	self._txtBattleTip = goutil.findChildTextComponent(self._details, "battleTip/txtDesc")
	self._playerInfoCells = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = goutil.findChild(self._details, "players/player_" .. i)
		cell.pointHead = goutil.findChild(cell.go, "pointHead")
		cell.txtPower = goutil.findChildTextComponent(cell.go, "txtPower")
		cell.btnAid = goutil.findChild(cell.go, "btnAid")
		cell.txtAid = goutil.findChildTextComponent(cell.btnAid, "txtAid")
		cell.txtUserName = goutil.findChildTextComponent(cell.go, "txtUserName")
		cell.formCells = {}

		for k = 1, 3 do
			local formCell = {}

			formCell.go = goutil.findChild(cell.go, "forms/form_" .. k)
			formCell.txtTeam = goutil.findChildTextComponent(formCell.go, "txtTeam")
			formCell.petCells = {}

			for p = 1, 6 do
				local petCell = {}

				petCell.go = goutil.findChild(formCell.go, "formations/cell_" .. p)
				petCell.pointPet = goutil.findChild(petCell.go, "pointPet")
				formCell.petCells[p] = petCell
			end

			cell.formCells[k] = formCell
		end

		self._playerInfoCells[i] = cell
	end
end

function TabPTEliMyScheduleView:bindEvents()
	TabPTEliMyScheduleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnExChange, self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnReport, self._onClickReport, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickReward, self)
	GameUtil.addClickHandler(self._btnForm, self._onClickForm, self)
	GameUtil.addClickHandler(self._btnReview, self._onClickReview, self)
	GameUtil.addClickHandler(self._btnBless, self._onClickBtnBless, self)
	GameUtil.addClickHandler(self._btnBanPet, self._onCLickBtnBanPet, self)
end

function TabPTEliMyScheduleView:unbindEvents()
	TabPTEliMyScheduleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnExChange)
	GameUtil.rmClickHandler(self._btnReport)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnForm)
	GameUtil.rmClickHandler(self._btnReview)
	GameUtil.rmClickHandler(self._btnBless)
	GameUtil.rmClickHandler(self._btnBanPet)
end

function TabPTEliMyScheduleView:onEnter()
	TabPTEliMyScheduleView.super.onEnter(self)

	self._actId = PeakTournamentController.instance:getCurActivityId()
	self._eliminatorMgr = PeakTournamentController.instance:getEliminatorMgr()

	if self._eliminatorMgr == nil then
		printError("缺失[ EliminatorMgr模块 ],无法运行")
		self:close()

		return
	end

	self._eliRoundCfg = PeakTournamentConfig.instance:getPtEliRoundCfgById(self._actId)

	GlobalDispatcher:addListener(GlobalNotify.EliminatorMgrNotifyChangeNewPeriod, self._sendInfoReq, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGetMyScheduleInfoRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGetParticipationInfoRes, self._onUpdateNodataUI, self)
	self:_sendInfoReq()

	local key = PeakTournamentConfig.instance:getPtCommonValue("LKEY_TABPTELIMYSCHEDULEVIEW_1")

	self._txtBattleTip.text = lang(key)

	local isHave = PeakTournamentController.instance:isTheSeasonHaveBanPet(self._activityId, GameEnum.PeakTournamentStep.Eliminator)

	GameUtil.SetActive(self._btnBanPet, isHave)
end

function TabPTEliMyScheduleView:onExit()
	TabPTEliMyScheduleView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.EliminatorMgrNotifyChangeNewPeriod, self._sendInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGetMyScheduleInfoRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGetParticipationInfoRes, self._onUpdateNodataUI, self)
	self:_resetView()
	removetimer(self._onTicking, self)

	self._eliminatorMgr = nil
end

function TabPTEliMyScheduleView:_sendInfoReq()
	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetMyScheduleInfoReq(self._actId)
	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetParticipationInfoReq(self._actId)
end

function TabPTEliMyScheduleView:_onTicking()
	self._txtRemainTime.text = self._eliminatorMgr:getRemainTimeTipsStr(self._curEliRoundId)
end

function TabPTEliMyScheduleView:_onUpdateEliRoundInfo()
	local resultInfoMo = PeakTournamentModel.instance:getResultInfoMoInMySchedule()

	self._curEliRoundId = resultInfoMo:getRoundId()
	self._curPeriodId = self._curEliRoundId > 0 and self._eliminatorMgr:getCurPeriodId(self._curEliRoundId) or 0
end

function TabPTEliMyScheduleView:_onClickExchange()
	local jumpToStr = PeakTournamentConfig.instance:getPtCommonValue("PT_JUMP_SHOP_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function TabPTEliMyScheduleView:_onClickReport()
	UIStateManager.instance:push(ViewName.PTBattlefieldReportAsMyView)
end

function TabPTEliMyScheduleView:_onClickReward()
	UIStateManager.instance:push(ViewName.PTEliRankPrizeView, self._actId)
end

function TabPTEliMyScheduleView:_onClickForm()
	local tipsStr = ""

	if PeakTournamentModel.instance:getCurIsKnockout() then
		tipsStr = "本届巅峰赛被淘汰，无法布阵哦"
	elseif self._curPeriodId ~= EliminatorMgr.PeriodId.Preparation then
		tipsStr = "只有在准备阶段可以调整布阵"
	end

	if not string.nilorempty(tipsStr) then
		FloatWordMgr.instance:show(tipsStr)

		return
	end

	PeakTournamentController.instance:enterFormationAsPT(self._actId, true)
end

function TabPTEliMyScheduleView:_onClickReview()
	local tipsStr = ""

	if PeakTournamentModel.instance:getCurIsKnockout() then
		tipsStr = "本届巅峰赛被淘汰，无法观看战斗哦"
	elseif self._curEliRoundId ~= self._eliminatorMgr:getNewestEliRoundId() then
		tipsStr = "未到该比赛进程"
	elseif self._curPeriodId ~= EliminatorMgr.PeriodId.Performance then
		tipsStr = "不在战斗阶段无法观看"
	end

	if not string.nilorempty(tipsStr) then
		FloatWordMgr.instance:show(tipsStr)

		return
	end

	local resultInfoMo = PeakTournamentModel.instance:getResultInfoMoInMySchedule()
	local battleIdList = resultInfoMo:getBattleIdList()

	if #battleIdList > 0 then
		UIJumper.instance:saveCurStack()

		local fightType = PeakTournamentController.FightType.EliFight

		PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetBattleVideoReq(battleIdList, nil, fightType)
	else
		FloatWordMgr.instance:show("没有可观看的战斗")
	end
end

function TabPTEliMyScheduleView:_onClickBtnBless()
	UIStateManager.instance:push(ViewName.BirthdaySportsWishesMainView)
end

function TabPTEliMyScheduleView:_onCLickBtnBanPet()
	UIStateManager.instance:push(ViewName.PTEliBanPetTipsView, self._activityId)
end

function TabPTEliMyScheduleView:_resetView()
	for k, v in ipairs(self._playerInfoCells) do
		HeadItemController.instance:resetHeadCell(v.pointHead)

		for k1, v1 in ipairs(v.formCells) do
			for k2, v2 in ipairs(v1.petCells) do
				MaterialMgr.resetAll(v2.pointPet)
			end
		end
	end
end

function TabPTEliMyScheduleView:_refreshView()
	self:_onUpdateEliRoundInfo()

	local isKnockout = PeakTournamentModel.instance:getCurIsKnockout()

	if isKnockout then
		goutil.setActive(self._nodata, true)
		goutil.setActive(self._details, false)
	else
		settimer(0.1, self._onTicking, self)
		goutil.setActive(self._nodata, false)
		goutil.setActive(self._details, true)
		GameUtil.SetActive(self._btnReview, self._curPeriodId == EliminatorMgr.PeriodId.Performance)
		self:_resetView()

		local resultInfoMo = PeakTournamentModel.instance:getResultInfoMoInMySchedule()

		for playerIdx, cell in ipairs(self._playerInfoCells) do
			local isMe = playerIdx == ((resultInfoMo:getUserId(false) == RoleModel.instance:getUserId() or nil) and 2)

			cell.txtAid.text = resultInfoMo:getGuessNums(isMe)
			cell.txtPower.text = resultInfoMo:getEverMaxZdl(isMe)

			local headInfo = resultInfoMo:getHeadInfo(isMe)

			if headInfo then
				HeadItemController.instance:setHeadCellByInfo(cell.pointHead, headInfo)
			else
				HeadItemController.instance:resetHeadCell(cell.pointHead)
			end

			cell.txtUserName.text = resultInfoMo:getUserNameAddAreaId(isMe)

			for formId, formCell in ipairs(cell.formCells) do
				local petInfoList = resultInfoMo:getPetInfoList(formId, isMe)

				if petInfoList then
					for petIdx, petInfo in ipairs(petInfoList) do
						local petMatStr = string.format("%s:%s:%s:1", MatType.Pet, checkint(petInfo.raceId), checkint(petInfo.level))

						MaterialMgr.setCellByCfg(petMatStr, formCell.petCells[petIdx].pointPet)
					end
				end
			end
		end
	end
end

function TabPTEliMyScheduleView:_onUpdateNodataUI()
	local knockoutTips = PeakTournamentController.instance:getKnockoutTips(self._actId)

	GameUtil.SetActive(self._nodata, not string.nilorempty(knockoutTips))
	GameUtil.SetActive(self._details, not GameUtil.GetActive(self._nodata))

	self._txtNodata.text = PeakTournamentController.instance:getKnockoutTips(self._actId)
end

return TabPTEliMyScheduleView
