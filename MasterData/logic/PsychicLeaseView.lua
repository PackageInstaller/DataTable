-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/view/PsychicLeaseView.lua

module("logic.extensions.psychicimprove.view.PsychicLeaseView", package.seeall)

local PsychicLeaseView = class("PsychicLeaseView", ViewComponent)

function PsychicLeaseView:ctor()
	PsychicLeaseView.super.ctor(self)
end

function PsychicLeaseView:unbindEvents()
	PsychicLeaseView.super.unbindEvents(self)

	for i, v in ipairs(self._cellList) do
		local cell = self._cellList[i]

		GameUtil.rmClickHandler(cell.btnSkill)
		GameUtil.rmClickHandler(cell.btnIntroduce)
	end
end

function PsychicLeaseView:bindEvents()
	PsychicLeaseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHire, GameUtil.handler(self._onClickHire, self, 1))
end

function PsychicLeaseView:buildUI()
	PsychicLeaseView.super.buildUI(self)

	self._cellList = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("cell_" .. i)
		cell.btnSkill = goutil.findChild(cell.go, "petInfo/btnSkill")
		cell.btnIntroduce = goutil.findChild(cell.go, "petInfo/btnIntroduce")
		cell.txtName = goutil.findChildTextComponent(cell.go, "petInfo/txtName")
		self._cellList[i] = cell
	end

	self._btnHire = self:getBtn("btnHire")
	self._txtTime = self:getTxt("time/txtTime")
	self._tickGo = self:getGo("tick")
	self._txtTickTime = self:getTxt("tick/txt")
end

function PsychicLeaseView:onExit()
	PsychicLeaseView.super.onExit(self)
	removetimer(self._onTimer, self)
	removetimer(self._tickLease, self)
	GlobalDispatcher:removeListener(GlobalNotify.PsychicImproveInfoUpdate, self.refreshView, self)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end
end

function PsychicLeaseView:onEnter()
	PsychicLeaseView.super.onEnter(self)

	local hudCfg = self:getFirstParam()
	local actId = checkint(hudCfg and hudCfg.parameter)

	self._petId = {}

	PsychicImproveController.instance:sendGetInfo(actId)
	GlobalDispatcher:addListener(GlobalNotify.PsychicImproveInfoUpdate, self.refreshView, self)

	self._mainEff = UIEffectManager.instance:playEffect(self, "20221125/tonglingshi_jm/fx_ui_tonglingshi_jm.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)

	self:_refreLeaseTime()
end

function PsychicLeaseView:refreshView()
	self._actId = PsychicImproveModel.instance:getCurActId()
	self._actTimeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.PsychicHirePet, self._actId)
	self._actCfg = PsychicImproveConfig.instance:getActCfgById(self._actId)
	self._hideCfgs = PsychicImproveConfig.instance:getHideCfgsById(self._actCfg.hirePlanId)
	self._hasHidePetIds = PsychicImproveModel.instance:getCurHidePetIds()
	self._hasHidePetNums = table.nums(self._hasHidePetIds)

	local cfg = self._hideCfgs[1]
	local raceCfg = string.split(cfg.petRaceId, "#")

	if #raceCfg > 1 then
		for i = 1, 5 do
			local cell = self._cellList[i]

			cell.cfg = self._hideCfgs[i]

			local raceId = checkint(raceCfg[i])
			local petCfg = CharacterConfig.instance:getPetCo(raceId)

			cell.txtName.text = petCfg and petCfg.name

			GameUtil.addClickHandler(cell.btnSkill, GameUtil.handler(self._onClickSkill, self, raceId))
			GameUtil.addClickHandler(cell.btnIntroduce, GameUtil.handler(self._onClickInfo, self, raceId))
		end
	end

	if self._hasHidePetNums >= self._actCfg.hireLimit or hasHire then
		GameUtil.SetActive(self._btnHire, false)
	else
		GameUtil.SetActive(self._btnHire, true)
	end

	local startTime = string.gsub(string.gsub(string.gsub(self._actTimeCfg.startTime, ":00", "", 1), "T", " "), "-", ".")
	local endTime = string.gsub(string.gsub(string.gsub(self._actTimeCfg.endTime, ":00", "", 1), "T", " "), "-", ".")

	self._txtTime.text = string.format("活动时间:%s-%s", startTime, endTime)

	self:_refreLeaseTime()
end

function PsychicLeaseView:_onClickSkill(raceId)
	local raceId = checkint(raceId)

	if raceId > 0 then
		PetbookController.instance:previewBattle(raceId, raceId)
	end
end

function PsychicLeaseView:_onClickInfo(raceId)
	local raceId = checkint(raceId)

	if raceId > 0 then
		PetbookController.instance:openPetinfoView(raceId)
	end
end

function PsychicLeaseView:_onClickHire(hireId)
	if not self._hideCfgs[hireId] then
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

function PsychicLeaseView:_refreLeaseTime()
	local coolTime = PsychicImproveModel.instance:getCurCoolingTime()
	local coolSec = coolTime / 1000
	local show = coolSec > 0

	goutil.setActive(self._tickGo, show)

	if show then
		self._targetTime = coolSec + ServerTime.now()

		settimer(1, self._tickLease, self, true)
		self:_tickLease()
	else
		removetimer(self._tickLease, self)
	end
end

function PsychicLeaseView:_tickLease()
	local leftTime = checknumber(self._targetTime) - ServerTime.now()

	if leftTime <= 0 then
		self:_refreLeaseTime()

		return
	else
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(leftTime)

		self._txtTickTime.text = day > 0 and string.format("租借倒计时:\n%s天%s时%s分%s秒", day, hour, min, sec) or string.format("租借倒计时:\n%s时%s分%s秒", hour, min, sec)
	end
end

return PsychicLeaseView
