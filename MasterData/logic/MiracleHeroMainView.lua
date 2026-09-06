-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroMainView.lua

module("logic.extensions.miraclehero.view.MiracleHeroMainView", package.seeall)

local MiracleHeroMainView = class("MiracleHeroMainView", ViewComponent)

function MiracleHeroMainView:ctor()
	MiracleHeroMainView.super.ctor(self)
end

function MiracleHeroMainView:unbindEvents()
	MiracleHeroMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTeam)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
end

function MiracleHeroMainView:bindEvents()
	MiracleHeroMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnTeam, self._onClickTeam, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
end

function MiracleHeroMainView:buildUI()
	MiracleHeroMainView.super.buildUI(self)

	self._btnClose = self:getGo("topleft/btnClose")
	self._btnTip = self:getGo("topleft/btnTip")
	self._btnShop = self:getGo("btnShop")
	self._btnTeam = self:getGo("btnTeam")
	self._rdBtnTeam = self:getGo("btnTeam/redpoint")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._txtTime = self:getTxt("time/txtTime")
	self._challengeCell = self:getGo("challengeList/cell")
	self._challengeListGo = self:getGo("challengeList")
	self._bubbleCon = self:getGo("bubble/con")

	goutil.setActive(self._challengeCell, false)
end

function MiracleHeroMainView:onExit()
	MiracleHeroMainView.super.onExit(self)

	self._challengeList = self._challengeList or {}

	for _, cell in ipairs(self._challengeList) do
		goutil.setActive(cell.go, false)
		GameUtil.rmClickHandler(cell.btn)
	end

	MaterialMgr.resetAll(self._bubbleCon)
	RedPointController.instance:unregRedPoint(self._rdBtnTeam)
end

function MiracleHeroMainView:onEnter()
	MiracleHeroMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.MiracleHero, self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	MiracleHeroController.instance:sendPM_MiracleHeroInfoReq(self._activityId)
	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.MiracleHeroGetInfoRes, self._updateUIByInfo, self)
	RedPointController.instance:regRedPoint(self._rdBtnTeam, RedPointModel.ID_MIRACLE_HERO_PET_LEVEL_UP)
end

function MiracleHeroMainView:_updateUIByCfg()
	self._actCfg = MiracleHeroConfig.instance:getActCfg(self._activityId)
	self._challengeCfgs = MiracleHeroConfig.instance:getChallengeCfgs(self._activityId)
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_updateHud()

	local sotryId = self._actCfg.copyId

	if sotryId > 0 then
		local userDataKey = string.format("%s_%s_firstOpen", ViewName.MiracleHeroMainView, self._activityId)

		if checkint(GameUtil.getUserData(userDataKey)) <= 0 then
			self._isShowTips = true

			GameUtil.saveUserData(userDataKey, 1)
		end
	end

	MaterialMgr.resetAll(self._bubbleCon)
	MaterialMgr.setCellByCfg(self._actCfg.bubbleShowMat, self._bubbleCon)
end

function MiracleHeroMainView:_onEndStroy()
	if self._isShowTips == true then
		local userDataKey = string.format("%s_%s_firstOpenRule", ViewName.MiracleHeroMainView, self._activityId)

		GameUtil.doCallbackWhenFirst(userDataKey, function()
			self:_onClickTip()
		end)
	end
end

function MiracleHeroMainView:_updateUIByInfo()
	MiracleHeroController.instance:sendPM_MiracleHeroGetFormationReq(self._activityId)
end

function MiracleHeroMainView:_updateHud()
	self._challengeList = self._challengeList or {}

	for _, cell in ipairs(self._challengeList) do
		goutil.setActive(cell.go, false)

		cell.cfg = nil

		GameUtil.rmClickHandler(cell.btn)
	end

	for _, cfg in ipairs(self._challengeCfgs) do
		local cell = self:_getHudCell(cfg.challengeId)

		self:_updateHudCell(cell, cfg)
	end
end

function MiracleHeroMainView:_getHudCell(challengeId)
	local cell = self._challengeList[challengeId]

	if not cell then
		cell = {}

		local goName = "cell_" .. challengeId
		local goCell = goutil.findChild(self._challengeListGo, goName)

		cell.go = goCell or goutil.cloneAndSetParent(self._challengeCell, self._challengeListGo.transform, goName)
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.txtShow = goutil.findChildTextComponent(cell.btn, "txt")
		cell.btnLast = goutil.findChild(cell.go, "btn_last")
		cell.txtShowLast = goutil.findChildTextComponent(cell.btnLast, "txt")
		cell.time = goutil.findChild(cell.go, "time")
		cell.txtTime = goutil.findChildTextComponent(cell.time, "txt")
		cell.mark = goutil.findChild(cell.go, "mark")
		cell.cfg = nil
		self._challengeList[challengeId] = cell
	end

	return cell
end

function MiracleHeroMainView:_updateHudCell(cell, cfg)
	if cell and cfg then
		cell.cfg = cfg

		if not cfg.hudPos then
			local goPos = {}
			local var_14_1

			if goPos then
				var_14_1 = goPos[1] or 0

				local var_14_2

				if goPos then
					var_14_2 = goPos[2] or 0
				end
			end

			GameUtil.setAnchoredPos(cell.go, var_14_1, var_14_2)

			cell.txtShow.text = cfg.challengeName

			local firstStageCfg = MiracleHeroConfig.instance:getStageCfg(self._activityId, cfg.challengeId, 1)

			if firstStageCfg and not GameUtil.isEmptyString(firstStageCfg.openDateTime) then
				local isOpen = ServerTime.now() >= GameUtil.string2time(firstStageCfg.openDateTime)

				goutil.setActive(cell.time, not isOpen)

				if not isOpen then
					local openDate = GameUtil.string2date(firstStageCfg.openDateTime)

					cell.txtTime.text = string.format("%d.%02d %02d:00后开启", openDate.month, openDate.day, openDate.hour)
				end
			else
				goutil.setActive(cell.time, false)
			end

			goutil.setActive(cell.mark, MiracleHeroModel.instance:getIsPassChallenge(self._activityId, cfg.challengeId))
			goutil.setActive(cell.go, true)
			goutil.setActive(cell.btn, true)

			local changeGroup = cell.go:GetComponent(typeof(UIChangeGroup))

			if changeGroup then
				local posRceord = cell.btn:GetComponent(ComponentType.TestRecordPos)

				changeGroup:SetState(cfg.challengeId - 1)
				posRceord:LoadPlan(cfg.challengeId - 1)
			else
				local isLastCfg = cfg.challengeId == #self._challengeCfgs

				GameUtil.SetActive(cell.btn, not isLastCfg)
				GameUtil.SetActive(cell.btnLast, isLastCfg)
			end

			GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickHud, self, cell))
			GameUtil.addClickHandler(cell.btnLast, GameUtil.handler(self._onClickHud, self, cell))
		end
	end
end

function MiracleHeroMainView:_onClickHud(cell)
	if GameUtil.GetActive(cell.time) then
		TipsFacade.instance:openCommonTips(lang("暂未开启哦~"))

		return
	end

	self:_jumpStageView(cell.cfg)
end

function MiracleHeroMainView:_onClickTip()
	local cfgs = MiracleHeroConfig.instance:getRuleDescCfgs(self._activityId)

	TipsFacade.instance:openImageRuleView(cfgs, lang("奇迹勇者"))
end

function MiracleHeroMainView:_onClickShop()
	local jumpToStr = self._actCfg.shopGoto

	if not GameUtil.isEmptyString(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function MiracleHeroMainView:_onClickTeam()
	self:_jumpMyTeamView(self._activityId)
end

function MiracleHeroMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.MiracleHeroRankView, self._activityId)
end

function MiracleHeroMainView:_onClickPrize()
	UIStateManager.instance:push(ViewName.MiracleHeroPrizeView, self._activityId)
end

function MiracleHeroMainView:_jumpStageView(...)
	UIStateManager.instance:push(ViewName.MiracleHeroStageView, ...)
end

function MiracleHeroMainView:_jumpMyTeamView(...)
	UIStateManager.instance:push(ViewName.MiracleHeroMyTeamView, ...)
end

return MiracleHeroMainView
