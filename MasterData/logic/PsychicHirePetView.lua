-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/view/PsychicHirePetView.lua

module("logic.extensions.psychicimprove.view.PsychicHirePetView", package.seeall)

local PsychicHirePetView = class("PsychicHirePetView", ViewComponent)

function PsychicHirePetView:buildUI()
	PsychicHirePetView.super.buildUI(self)

	self._btnTip = self:getGo("btnTip")
	self._cellList = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("cell_" .. i)
		cell.btnSkill = goutil.findChild(cell.go, "petInfo/btnSkill")
		cell.btnIntroduce = goutil.findChild(cell.go, "petInfo/btnIntroduce")
		cell.txtName = goutil.findChildTextComponent(cell.go, "petInfo/txtName")
		cell.btnHire = goutil.findChild(cell.go, "btnHire")
		cell.cfg = nil
		self._cellList[i] = cell
	end

	self._txtCount = self:getTxt("txtCount")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnReturn = self:getGo("cell_3/btnReturn")
end

function PsychicHirePetView:bindEvents()
	PsychicHirePetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnReturn, self._onClickReurn, self)

	for i = 1, 4 do
		local cell = self._cellList[i]

		GameUtil.addClickHandler(cell.btnSkill, GameUtil.handler(self._onClickSkill, self, i))
		GameUtil.addClickHandler(cell.btnIntroduce, GameUtil.handler(self._onClickInfo, self, i))
		GameUtil.addClickHandler(cell.btnHire, GameUtil.handler(self._onClickHire, self, i))
	end
end

function PsychicHirePetView:unbindEvents()
	PsychicHirePetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReturn)

	for i = 1, 4 do
		local cell = self._cellList[i]

		GameUtil.rmClickHandler(cell.btnSkill)
		GameUtil.rmClickHandler(cell.btnIntroduce)
		GameUtil.rmClickHandler(cell.btnHire)
	end
end

function PsychicHirePetView:onEnter()
	PsychicHirePetView.super.onEnter(self)

	local hudCfg = self:getFirstParam()
	local actId = checkint(hudCfg and hudCfg.parameter)

	PsychicImproveController.instance:sendGetInfo(actId)
	GlobalDispatcher:addListener(GlobalNotify.PsychicImproveInfoUpdate, self.refreshView, self)

	self._mainEff = UIEffectManager.instance:playEffect(self, "20221125/tonglingshi_jm/fx_ui_tonglingshi_jm.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function PsychicHirePetView:onExit()
	PsychicHirePetView.super.onExit(self)
	removetimer(self._onTimer, self)
	GlobalDispatcher:removeListener(GlobalNotify.PsychicImproveInfoUpdate, self.refreshView, self)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end
end

function PsychicHirePetView:refreshView()
	self._actId = PsychicImproveModel.instance:getCurActId()
	self._actTimeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.PsychicHirePet, self._actId)
	self._actCfg = PsychicImproveConfig.instance:getActCfgById(self._actId)
	self._hideCfgs = PsychicImproveConfig.instance:getHideCfgsById(self._actCfg.hirePlanId)
	self._hasHidePetIds = PsychicImproveModel.instance:getCurHidePetIds()
	self._hasHidePetNums = table.nums(self._hasHidePetIds)

	removetimer(self._onTimer, self)

	self._curCoolingTime = PsychicImproveModel.instance:getCurCoolingTime()

	if self._curCoolingTime > 0 then
		self._curCoolingTime = checkint(self._curCoolingTime / 1000)

		settimer(1, self._onTimer, self)
		goutil.setActive(self._txtCount.gameObject, true)

		self._txtCount.text = langPara("距离下一次租借时间：<color=#33B57FFF>%s</color>", GameUtil.FormatTimeSymbol(self._curCoolingTime))
	else
		goutil.setActive(self._txtCount.gameObject, false)
	end

	for i = 1, 4 do
		local cell = self._cellList[i]

		cell.cfg = self._hideCfgs[i]

		local hasHire = self._hasHidePetIds[i]

		if cell.cfg then
			local raceId = checkint(cell.cfg.petRaceId)
			local petCfg = CharacterConfig.instance:getPetCo(raceId)

			cell.txtName.text = petCfg and petCfg.name

			goutil.setActive(cell.go, true)

			if self._hasHidePetNums >= self._actCfg.hireLimit or hasHire then
				goutil.setActive(cell.btnHire, false)
			else
				goutil.setActive(cell.btnHire, true)
			end
		else
			goutil.setActive(cell.go, false)
		end
	end

	local startTime = string.gsub(string.gsub(string.gsub(self._actTimeCfg.startTime, ":00", "", 1), "T", " "), "-", ".")
	local endTime = string.gsub(string.gsub(string.gsub(self._actTimeCfg.endTime, ":00", "", 1), "T", " "), "-", ".")

	self._txtTime.text = string.format("活动时间:%s-%s", startTime, endTime)
end

function PsychicHirePetView:_onClickTip()
	UIStateManager.instance:push(ViewName.PetNoticeView, 6)
end

function PsychicHirePetView:_onClickSkill(id)
	local cfg = self._hideCfgs[id]
	local raceId = checkint(cfg and cfg.petRaceId)

	if raceId > 0 then
		PetbookController.instance:previewBattle(raceId, raceId)
	end
end

function PsychicHirePetView:_onClickInfo(id)
	local cfg = self._hideCfgs[id]
	local raceId = checkint(cfg and cfg.petRaceId)

	if raceId > 0 then
		PetbookController.instance:openPetinfoView(raceId)
	end
end

function PsychicHirePetView:_onClickHire(hireId)
	if not self._hideCfgs[hireId] then
		return
	end

	if self._curCoolingTime > 0 then
		return
	end

	if self._hasHidePetNums >= self._actCfg.hireLimit then
		return
	end

	if self._hasHidePetIds[hireId] then
		return
	end

	SurveyController.instance:reportBehavior(self._hideCfgs[hireId].reportBehavior)
	TipsFacade.instance:openPopupWindowWithX(lang("提示"), lang("tip_psychic_hire_pet"), function()
		PsychicImproveController.instance:sendHidePet(self._actId, hireId)
	end)
end

function PsychicHirePetView:_onTimer()
	if self._curCoolingTime > 0 then
		self._curCoolingTime = self._curCoolingTime - 1
		self._txtCount.text = langPara("距离下一次租借时间：<color=#33B57FFF>%s</color>", GameUtil.FormatTimeSymbol(self._curCoolingTime))
	else
		removetimer(self._onTimer, self)
		PsychicImproveController.instance:sendGetInfo(self._actId)
	end
end

function PsychicHirePetView:_onClickReurn()
	GotoMgr.gotoByString("func#551")
end

return PsychicHirePetView
