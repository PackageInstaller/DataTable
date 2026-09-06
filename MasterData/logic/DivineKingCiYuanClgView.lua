-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/view/DivineKingCiYuanClgView.lua

module("logic.extensions.divinekingciyuan.view.DivineKingCiYuanClgView", package.seeall)

local DivineKingCiYuanClgView = class("DivineKingCiYuanClgView", ViewComponent)

function DivineKingCiYuanClgView:ctor()
	DivineKingCiYuanClgView.super.ctor(self)
end

function DivineKingCiYuanClgView:buildUI()
	DivineKingCiYuanClgView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._phaseRoot = self:getGo("phaseRoot")
	self._phaseDesc = self:getGo("phaseMsg/rule/desc"):GetComponent(typeof(UnityEngine.UI.Text))
	self._prize = self:getGo("phaseMsg/prize/item")
	self._prizeGo = self:getGo("phaseMsg/prize")
	self._progLine1 = self:getGo("progress/line_1")
	self._progLine2 = self:getGo("progress/line_2")
	self._goTableview = self:getGo("tableview")
	self._goPhaseCell = self:getGo("tableview/phaseCell")
	self._stageSL = ScrollerList.create(self._goTableview, self._goPhaseCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._stageSL:regReloadFinish(GameUtil.handler(self.reloadFinish, self))
	self:_recordGoDefaultActive(self._prizeGo)
end

function DivineKingCiYuanClgView:onExit()
	DivineKingCiYuanClgView.super.onExit(self)
	self._stageSL:dispose()
	MaterialMgr.resetAll(self._prize)
end

function DivineKingCiYuanClgView:unbindEvents()
	DivineKingCiYuanClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineKingCiYuanClgView:bindEvents()
	DivineKingCiYuanClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTipBtn, self)
end

function DivineKingCiYuanClgView:onEnter()
	DivineKingCiYuanClgView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineKingCiYuanGetInfoRes, self._refreshView, self)

	self._activityId = checkint(self:getFirstParam()) or 405001
	self._activityType = DivineKingCiYuanController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._phaseList = DivineKingCiYuanConfig.instance:getPhaseCfgsByActId(self._activityId)
	self._scrollMap = {}

	self:_refreshView()

	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._prizeGo, false)
	else
		self:_refreshDefaultActive(self._prizeGo)
	end

	self.addGEvent(self, GlobalNotify.DivineKingCiYuanGetInfoRes, self._refreshView, self)
	DivineKingCiYuanAgent.instance:sendPM_DivineKingCiYuanGetInfoReq(self._activityId)
end

function DivineKingCiYuanClgView:_refreshView()
	self:_refreshData()
	self:_refreshViewUI()
end

function DivineKingCiYuanClgView:_refreshData()
	self._curPhaseId = DivineKingCiYuanModel.instance:getCurPhaseId(self._activityId)
	self._curStageId = DivineKingCiYuanModel.instance:getCurStageId(self._activityId, self._curPhaseId)

	if self._curPhaseId > #self._phaseList then
		self._curPhaseId = 3
	end

	local stagePlanId = self._phaseList[self._curPhaseId].stagePlanId

	self._stageList = DivineKingCiYuanConfig.instance:getStageCfgsByStagePlanId(stagePlanId)

	local stageInfos = DivineKingCiYuanModel.instance:getStageInfos(self._activityId, self._curPhaseId) or {}

	self._stageInfoMap = {}

	for i, v in pairs(stageInfos) do
		self._stageInfoMap[v.stageId] = v
	end
end

function DivineKingCiYuanClgView:_refreshViewUI()
	local phaseCount = #self._phaseList

	for phaseId = 1, phaseCount do
		local phaseConfig = self._phaseList[phaseId]
		local goPhase = self._phaseRoot.transform:GetChild(phaseId - 1).gameObject
		local imgColor = goutil.findChild(goPhase, "btn"):GetComponent(typeof(UIImageColorChange))
		local pass = goutil.findChild(goPhase, "pass")
		local btn = goutil.findChild(goPhase, "btn")
		local txt = goutil.findChildTextComponent(goPhase, "btn/txt")
		local islock = phaseId > self._curPhaseId
		local isPass = phaseId < self._curPhaseId
		local isOpen = false
		local str = langPara("第<size=36>%s</size><size=22>层</size>", phaseId)
		local openTime = GameUtil.string2time(phaseConfig.openTime)

		isOpen = not string.nilorempty(openTime) and openTime <= ServerTime.now()
		str = islock and lang("<size=22><color=#ffffff>通关上一层\n开启</color></size>") or str
		str = isOpen and str or langPara("<size=22><color=#ffffff>通关上一层\n%s\n开启</color></size>", GameUtil.formatTimeString("%m.%d", phaseConfig.openTime))

		imgColor:SetState((islock or isPass or not isOpen) and 1 or 0)

		txt.text = str

		goutil.setActive(pass, isPass)
	end

	if self._curPhaseId > 1 then
		goutil.setActive(self._progLine1, true)

		if self._curPhaseId > 2 then
			goutil.setActive(self._progLine2, true)
		end
	else
		goutil.setActive(self._progLine1, false)
		goutil.setActive(self._progLine2, false)
	end

	self._phaseDesc.text = self._phaseList[self._curPhaseId].rule

	MaterialMgr.setCellByCfg(self._phaseList[self._curPhaseId].prize, self._prize)
	self._stageSL:reloadData(self._stageList)
end

function DivineKingCiYuanClgView:_updateCell(view, cell, data, tag)
	local pass = goutil.findChild(cell, "fmt/pass")
	local phaseMsg = goutil.findChild(cell, "phaseMsg")
	local tablecell = goutil.findChild(cell, "phaseMsg/tableview/petcell")
	local tableview = goutil.findChild(cell, "phaseMsg/tableview")
	local empty = goutil.findChild(cell, "phaseMsg/txtempty")
	local fmt = goutil.findChild(cell, "fmt")
	local btnReset = goutil.findChildButtonComponent(cell, "btnGroup/btnReset")
	local btnFight = goutil.findChildButtonComponent(cell, "btnGroup/btnFight")
	local creepsCfg = DivineKingCiYuanConfig.instance:getCreepsCfgsById(data.creepsMasterId) or {}
	local monsterCfg = DivineKingCiYuanConfig.instance:getMonsterCfgById(data.monsterId) or {}
	local stageInfo = DivineKingCiYuanModel.instance:getStageInfoById(self._activityId, self._curPhaseId, data.stageId)
	local scrollList = self._scrollMap[cell]
	local map = {}

	for i = 1, 9 do
		local go = goutil.findChild(cell, "fmt/cell_" .. i)

		map[i] = go

		GameUtil.SetActive(go, false)
	end

	for i, v in ipairs(creepsCfg) do
		local posId = checknumber(v.posId)

		if posId > 0 then
			local go = map[posId]

			GameUtil.SetActive(go, true)

			local con = goutil.findChild(go, "con")
			local tagCell = goutil.findChild(go, "tagCell")

			MaterialMgr.setIcon(con, MatType.Pet, v.raceId)

			local flag = v.flag

			GameUtil.SetActive(tagCell, false)

			if not string.nilorempty(flag) then
				GameUtil.SetActive(tagCell, true)

				local txt1 = goutil.findChild(tagCell, "txt_1")
				local txt2 = goutil.findChild(tagCell, "txt_2")

				GameUtil.SetActive(txt1, flag == ConstString.Race[GameEnum.RaceType.Guang])
				GameUtil.SetActive(txt2, flag == ConstString.Race[GameEnum.RaceType.An])
			end

			GameUtil.addClickHandler(con, function()
				local petMo = FightingPowerPetMo.New()

				petMo:fromChallengeCreepCo(v, creepsCfg)

				petMo.creepName = v.creepName

				CommonTipsMgr.instance:showPetTips(petMo)
			end, self)
		end
	end

	GameUtil.addClickHandler(btnFight, GameUtil.handler(self._onClickFmt, self, data))
	GameUtil.addClickHandler(btnReset, GameUtil.handler(self._onClickResetBtn, self, data))

	if scrollList == nil then
		scrollList = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
		self._scrollMap[cell] = scrollList
	end

	if not stageInfo.lockRaceIds then
		local lockRaceList = {}

		scrollList:setCenterMode(true)
		scrollList:reloadData(lockRaceList)
		goutil.setActive(empty, #lockRaceList == 0)

		if not stageInfo.isPass then
			local txt = goutil.findChildTextComponent(cell, "phaseMsg/actionCount/txt")

			txt.text = "出手次数 >= " .. data.targetCount

			goutil.setActive(pass, stageInfo.isPass)
			goutil.setActive(btnReset.gameObject, stageInfo.isPass)
			goutil.setActive(btnFight.gameObject, not stageInfo.isPass)
		end
	end
end

function DivineKingCiYuanClgView:_clearCell(cell)
	return
end

function DivineKingCiYuanClgView:reloadFinish()
	local curStageId = DivineKingCiYuanModel.instance:getCurStageId(self._activityId, self._curPhaseId)

	if curStageId then
		self._stageSL:MoveCellToCenter(curStageId - 1)
	end
end

function DivineKingCiYuanClgView:_updatePetCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.setCell(MatType.Pet, data, con)
end

function DivineKingCiYuanClgView:_clearPetCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function DivineKingCiYuanClgView:_onClickResetBtn(data)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local info = self._stageInfoMap[data.stageId]

	if info and info.isPass then
		TipsFacade.instance:openPopupWindow(lang("tip"), "是否重置本关挑战为未挑战，且解除精灵封印", function()
			DivineKingCiYuanAgent.instance:sendPM_DivineKingCiYuanResetReq(self._activityId, self._curPhaseId, data.stageId)
		end)
	end
end

function DivineKingCiYuanClgView:_onClickFmt(data)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local info = self._stageInfoMap[data.stageId]

	if info and info.isPass then
		TipsFacade.instance:openCommonTips("当前关卡已通关")
	else
		local now = ServerTime.now()
		local openTime = self._phaseList[self._curPhaseId].openTime
		local timeStart = GameUtil.string2time(openTime)

		if timeStart <= now then
			DivineKingCiYuanController.instance:openFmtView(self._activityId, self._curPhaseId, data.stageId)
		else
			TipsFacade.instance:openCommonTips("活动未开启")
		end
	end
end

function DivineKingCiYuanClgView:_onClickTipBtn()
	TipsFacade.instance:openRulesView("divinekingciyuanmainview_rule")
end

function DivineKingCiYuanClgView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function DivineKingCiYuanClgView:_refreshDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}

	GameUtil.SetActive(go, checkbool(self._goDefaultActives[go]))
end

return DivineKingCiYuanClgView
