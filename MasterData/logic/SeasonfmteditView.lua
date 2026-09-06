-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonfmteditView.lua

module("logic.extensions.season.view.SeasonfmteditView", package.seeall)

local SeasonfmteditView = class("SeasonfmteditView", SeasonfmttabextView)

function SeasonfmteditView:ctor()
	SeasonfmteditView.super.ctor(self)
end

function SeasonfmteditView:unbindEvents()
	SeasonfmteditView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnReset)
	GameUtil.rmClickHandler(self.btnSetting)
	GameUtil.rmClickHandler(self.btnHolyStripe)
	GameUtil.rmClickHandler(self.btnHuizhang)
	GameUtil.rmClickHandler(self.btnTuteng)
	GameUtil.rmClickHandler(self.btn_tip)
	GameUtil.rmClickHandler(self.btnCutePet)
	self._customInput:RemoveListener()
end

function SeasonfmteditView:bindEvents()
	SeasonfmteditView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnReset, self.onResetClick, self)
	GameUtil.addClickHandler(self.btnSetting, self.onSettingClick, self)
	GameUtil.addClickHandler(self.btnHolyStripe, self.onHolyStripeClick, self)
	GameUtil.addClickHandler(self.btnTuteng, self.onTutengClick, self)
	GameUtil.addClickHandler(self.btnHuizhang, self.onHuizhangClick, self)
	GameUtil.addClickHandler(self.btn_tip, self.onStrengTipClick, self)
	GameUtil.addClickHandler(self.btnCutePet, self.onCutePetClick, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function SeasonfmteditView:buildUI()
	SeasonfmteditView.super.buildUI(self)

	self.btnReset = self:getGo("btnReset")
	self.btnSetting = self:getGo("btnSetting")
	self.btnSettingRed = self:getGo("btnSetting/redpoint")
	self.btnTuteng = self:getGo("btnTuteng")
	self.btnHuizhang = self:getGo("btnHuizhang")
	self.btnHolyStripe = self:getGo("btnHolyStripe")
	self.rpHolyStripe = self:getGo("btnHolyStripe/redpoint")
	self.btnCutePet = self:getGo("btnCutePet")
	self.rpCutePet = self:getGo("btnCutePet/redpoint")
	self.empty = self:getGo("empty")
	self.txtTitle = self:getTxt("title/txtTitle")
	self.txtTili = self:getTxt("title/txtTili")
	self.btn_tip = self:getGo("title/btn_tip")
	self.strengthTip = self:getGo("title/strengthTip")
	self._customInput = UICustomInput.Get(self.strengthTip)
	self.txtDesc = self:getTxt("title/strengthTip/txtDesc")
	self.txtTime = self:getTxt("title/strengthTip/txtTime")
	self.txtCount = self:getTxt("btnReset/txtCount")
	self.txtSetCount = self:getTxt("txtSetCount")
	self.redpointList = {}

	for i = 1, 3 do
		local go = self:getGo("teams/btnTeam_" .. i .. "/redpoint")

		table.insert(self.redpointList, go)
	end

	GameUtil.SetActive(self.rpCutePet, false)
	GameUtil.SetActive(self.rpHolyStripe, false)
end

function SeasonfmteditView:onExit()
	SeasonfmteditView.super.onExit(self)
	removetimer(self.onTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self._onFormationChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtBuyPayTime, self._onFormationChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtHolyStripesInfo, self._onUpdateHolyStripeRedPoint, self)

	for i, v in ipairs(self.redpointList) do
		RedPointController.instance:unregRedPoint(v)
	end

	RedPointController.instance:unregRedPoint(self.btnSettingRed)
end

function SeasonfmteditView:onEnter()
	SeasonfmteditView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtHolyStripesInfo, self._onUpdateHolyStripeRedPoint, self)
	self:addGEvent(GlobalNotify.SeasonFmtCutePetInfo, self._onUpdateCutePetRedPoint)

	self.isCanDragTab = false
	self.teamAdjustTimes = checknumber(SeasonConfig.instance:getCommonValue("TEAM_ADJUST_TIMES"))
	self.configTime = checknumber(SeasonConfig.instance:getCommonValue("DAILY_RESET_TEAM_TIMES"))

	GameUtil.SetActive(self.strengthTip, false)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtBuyPayTime, self._onFormationChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self._onFormationChanged, self)
	self:_onFormationChanged()
	self:showTabs()
end

function SeasonfmteditView:_updateTabs(curTab)
	if self.curTabIdx == curTab then
		return
	end

	self.curTabIdx = curTab

	for i, go in ipairs(self.teamsGoList) do
		local imgSelect = goutil.findChild(go, "imgSelect")

		GameUtil.SetActive(imgSelect, i == curTab)
	end

	local arr = {
		385,
		386,
		387
	}

	for i, v in ipairs(arr) do
		local go = self.redpointList[i]

		RedPointController.instance:unregRedPoint(go)

		if i == curTab then
			GameUtil.SetActive(go, false)
		else
			RedPointController.instance:regRedPoint(go, v)
		end
	end

	RedPointController.instance:unregRedPoint(self.btnSettingRed)
	RedPointController.instance:regRedPoint(self.btnSettingRed, arr[curTab])

	local teamMo = SeasonTeamsModel.instance:getTeam(curTab)

	if teamMo then
		if not teamMo:isInitHolyStripesInfoMap() then
			SeasonController.instance:sendGetHolyStripesinfo(teamMo.teamId)
		else
			self:_onUpdateHolyStripeRedPoint()
		end

		if not teamMo:isInitCutePetInfoMap() then
			SeasonController.instance:sendGetCutePetInfo(teamMo.teamId)
		else
			self:_onUpdateCutePetRedPoint()
		end
	else
		self:_onUpdateHolyStripeRedPoint()
		self:_onUpdateCutePetRedPoint()
	end
end

function SeasonfmteditView:_onUpdateHolyStripeRedPoint()
	local teamMo = SeasonTeamsModel.instance:getTeam(self.curTabIdx)
	local bRed = false

	if teamMo then
		local holyStripesMap = teamMo:getHolyStripesInfoMap()
		local petList = teamMo:getPetMoList()

		for i, v in ipairs(petList) do
			local id = checknumber(holyStripesMap[v.raceId])

			if id <= 0 then
				bRed = true
			end
		end
	end

	GameUtil.SetActive(self.rpHolyStripe, bRed)
end

function SeasonfmteditView:_onUpdateCutePetRedPoint()
	local teamMo = SeasonTeamsModel.instance:getTeam(self.curTabIdx)
	local bRed = false

	if teamMo then
		local cutePetMap = teamMo:getCutePetInfoMap()
		local petList = teamMo:getPetMoList()

		for i, v in ipairs(petList) do
			local info = cutePetMap[v.raceId]

			if not info then
				bRed = true
			end
		end
	end

	local needLv = SeasonMainCampConfig.instance:getMiniCutePetUnLockCampLv()
	local mainLevel = SeasonMainCampModel.instance:getCampLv()

	GameUtil.SetActive(self.rpCutePet, bRed and needLv <= mainLevel)
end

function SeasonfmteditView:checkBossFight()
	return
end

function SeasonfmteditView:_onFormationChanged()
	local list = self.customFmtMo:getAllShowPetList()

	GameUtil.SetActive(self.empty, list == nil or #list == 0)

	local curTab = self.customFmtMo:getCurFormTab()
	local teamMo = SeasonTeamsModel.instance:getTeam(curTab)

	if teamMo then
		local seasonId = SeasonModel.instance:getSeasonId()
		local mainLevel = SeasonMainCampModel.instance:getCampLv()
		local cfg = SeasonConfig.instance:getSeasonEnergyCfg(seasonId, mainLevel)

		self.txtTili.text = langPara("体力：%s/%s", teamMo.teamStrength, checknumber(cfg.recoveryLimit))
		self.txtTitle.text = langPara("队伍等级：%s", teamMo.teamLv)
		self.txtDesc.text = langPara("每%s秒恢复%s点", cfg.recoveryEfficiency, cfg.unit)

		local resetTimes = math.max(0, self.configTime - SeasonTeamsModel.instance.resetTimes)

		self.txtCount.text = langPara("%s/%s", resetTimes, self.configTime)

		local total = self.teamAdjustTimes + teamMo.payTimes

		self.txtSetCount.text = langPara("调整次数：%s/%s", math.max(0, total - teamMo.adjustTimes), self.teamAdjustTimes)

		removetimer(self.onTime, self)
		settimer(1, self.onTime, self, true)
		self:onTime()
	end

	self:_onUpdateHolyStripeRedPoint()
end

function SeasonfmteditView:onSettingClick()
	local curTab = self.customFmtMo:getCurFormTab()
	local teamMo = SeasonTeamsModel.instance:getTeam(curTab)

	if teamMo and not teamMo:isServerLocked() then
		self.customFmtMo:sendSaveMsg()
		UIStateManager.instance:push(ViewName.SeasonselectpetView, self.customFmtMo)
	else
		TipsFacade.instance:openCommonTips(lang("已击败分身，当前小队进入疲劳状态"))
	end
end

function SeasonfmteditView:onHolyStripeClick()
	local curTab = self.customFmtMo:getCurFormTab()

	UIStateManager.instance:push(ViewName.SeasonholystripeView, curTab)
end

function SeasonfmteditView:onCutePetClick()
	local curTab = self.customFmtMo:getCurFormTab()

	UIStateManager.instance:push(ViewName.SeasonCutePetShowView, curTab)
end

function SeasonfmteditView:onTutengClick()
	SeasonMainCampController.instance:tryOpenEntrance(2)
end

function SeasonfmteditView:onHuizhangClick()
	UIStateManager.instance:push(ViewName.SeasonBadgeView)
end

function SeasonfmteditView:onTime()
	local curTab = self.customFmtMo:getCurFormTab()
	local teamMo = SeasonTeamsModel.instance:getTeam(curTab)

	if teamMo then
		teamMo:checkAddStrength()

		local list = teamMo:getStrengthCDList()
		local leftTime = 0

		if list and #list > 0 then
			leftTime = checknumber(list[#list]) - ServerTime.now()
			leftTime = leftTime >= 0 and leftTime or 0
		end

		self.txtTime.text = GameUtil.FormatTimeSymbol(leftTime)
	end
end

function SeasonfmteditView:onStrengTipClick()
	if GameUtil.GetActive(self.strengthTip) == false then
		GameUtil.SetActive(self.strengthTip, true)
	else
		GameUtil.SetActive(self.strengthTip, false)
	end
end

function SeasonfmteditView:_onCustomInputCallback(hover)
	if not hover and GameUtil.GetActive(self.strengthTip) then
		GameUtil.SetActive(self.strengthTip, false)
	end
end

function SeasonfmteditView:onResetClick()
	local resetTimes = SeasonTeamsModel.instance.resetTimes

	if resetTimes < self.configTime then
		local hasPet = false
		local teams = SeasonTeamsModel.instance:getTeams()

		for i, teamMo in ipairs(teams or {}) do
			if #teamMo:getPetMoList() > 0 then
				hasPet = true
			end
		end

		TipsFacade.instance:openSeasonPopupWindow(lang("tip"), lang("每天只有一次机会重置，重置后所有小队的精灵及背包都要重新设置，是否继续？"), function()
			if hasPet then
				SeasonController.instance:sendResetAllTeamFmt()
			else
				TipsFacade.instance:openCommonTips(lang("阵上没有精灵，不需要重置"))
			end
		end)
	else
		TipsFacade.instance:openCommonTips(lang("今日重置次数已经用完"))
	end
end

return SeasonfmteditView
