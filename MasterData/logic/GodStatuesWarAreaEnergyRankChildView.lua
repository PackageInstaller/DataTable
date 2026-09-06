-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarAreaEnergyRankChildView.lua

module("logic.extensions.commontabrank.view.tutorsystem.GodStatuesWarAreaEnergyRankChildView", package.seeall)

local GodStatuesWarAreaEnergyRankChildView = class("GodStatuesWarAreaEnergyRankChildView", ViewComponent)

function GodStatuesWarAreaEnergyRankChildView:buildUI()
	GodStatuesWarAreaEnergyRankChildView.super.buildUI(self)

	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._txtEmptyGo = self:getTxt("rankCol/emptyGo/txt")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtEnergy = goutil.findChildTextComponent(self.mainGO, "tipsCol/energy/txt")
	self._openTime = goutil.findChild(self.mainGO, "openTime")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
end

function GodStatuesWarAreaEnergyRankChildView:bindEvents()
	GodStatuesWarAreaEnergyRankChildView.super.bindEvents(self)
end

function GodStatuesWarAreaEnergyRankChildView:unbindEvents()
	GodStatuesWarAreaEnergyRankChildView.super.unbindEvents(self)
end

function GodStatuesWarAreaEnergyRankChildView:onEnter()
	GodStatuesWarAreaEnergyRankChildView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._rankList = {}
	self._myRank = 0
	self._myValue = 0

	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetRegistrationRes, self._handlePM_NewFamilyBattleGetRegistrationRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleRankViewRes, self._handleMsgRes, self)
	self:_onUpdate()
	GameUtil.SetActive(self._openTime, false)

	local isInSeasonTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)
	local isEnoughFamilyLevel = GodStatuesWarController.instance:isEnoughFamilyLevelOfGsw()

	if isInSeasonTime and isEnoughFamilyLevel then
		if not self._hasGetRegistration then
			GodStatuesWarController.instance:sendPM_NewFamilyBattleGetRegistrationReq()
		else
			self:_trySendGetBattleRankViewReq()
		end
	end
end

function GodStatuesWarAreaEnergyRankChildView:onExit()
	GodStatuesWarAreaEnergyRankChildView.super.onExit(self)
	self._rankScrollList:dispose()
end

function GodStatuesWarAreaEnergyRankChildView:_trySendGetBattleRankViewReq()
	local isRegistered = GodStatuesWarController.instance:isRegisteredOfGsw(self._seasonId)

	if isRegistered then
		GodStatuesWarController.instance:sendPM_NewFamilyBattleRankViewReq(self._seasonId)
	else
		self:_onUpdate()
	end
end

function GodStatuesWarAreaEnergyRankChildView:_handlePM_NewFamilyBattleGetRegistrationRes()
	self._hasGetRegistration = true

	self:_trySendGetBattleRankViewReq()
end

function GodStatuesWarAreaEnergyRankChildView:_handleMsgRes(msg)
	self._rankList = msg.rankInfo
	self._myRank = msg.myFamilyRank
	self._myValue = msg.myFamilyEnergy

	self:_onUpdate()
end

function GodStatuesWarAreaEnergyRankChildView:_onUpdate()
	local emptyTips
	local isInSeasonTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInSeasonTime then
		emptyTips = "不在赛季开始期限内"
	end

	if not GodStatuesWarController.instance:isEnoughFamilyLevelOfGsw() then
		local limLv = GodStatuesWarController.instance:getFamilyLevelLimitOfGsw()

		emptyTips = string.format("家族等级%s级开启！", limLv)
	end

	if not emptyTips then
		local isRegistered = GodStatuesWarController.instance:isRegisteredOfGsw(self._seasonId)

		if not isRegistered then
			emptyTips = "您的家族未报名参加比赛，无分配战区"
		end
	end

	if not emptyTips then
		local isEmpty = #self._rankList <= 0

		if isEmpty then
			emptyTips = "暂无排名"
		end
	end

	self._txtEmptyGo.text = emptyTips

	GameUtil.SetActive(self._emptyGo, not string.nilorempty(emptyTips))

	if isInSeasonTime then
		local curStep = GswEnum.Steps_Zone
		local stepData = GodStatuesWarConfig.instance:getNfbStepData(self._seasonId, curStep)
		local startFields = GodStatuesWarController.instance:getStepIntervalTimeFields(self._seasonId, curStep, GswEnum.StepInterval_FmtPre)
		local endFields = GodStatuesWarController.instance:getStepIntervalTimeFields(self._seasonId, curStep, GswEnum.StepInterval_Bat)
		local startStamp = startFields and GameUtil.string2time(stepData[startFields[1]]) or 0
		local endStamp = endFields and GameUtil.string2time(stepData[endFields[2]]) or 0
		local startDate = GameUtil.time2date(startStamp)
		local endDate = GameUtil.time2date(endStamp)

		self._txtOpenTime.text = string.format("比赛时间：%d.%02d.%02d %02d:%02d - %d.%02d.%02d %02d:%02d", startDate.year, startDate.month, startDate.day, startDate.hour, startDate.min, endDate.year, endDate.month, endDate.day, endDate.hour, endDate.min)

		GameUtil.SetActive(self._openTime, true)
	else
		self._txtOpenTime.text = ""

		GameUtil.SetActive(self._openTime, false)
	end

	self._rankScrollList:reloadData(self._rankList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)

	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
	self._txtEnergy.text = self._myValue
end

function GodStatuesWarAreaEnergyRankChildView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local areaName = info.areaName
	local energy = info.energy
	local familyName = info.familyName
	local chiefName = info.chiefName
	local iconId = info.iconId
	local mainGo = cell.gameObject
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtChiefName = goutil.findChildTextComponent(mainGo, "txtChiefName")
	local familyIcon = goutil.findChild(mainGo, "familyIcon")
	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	GameUtil.setUIImageSpriteIdx(familyIcon, iconId)

	txtRank.text = rank
	txtName.text = familyName
	txtValue.text = energy
	txtArea.text = areaName
	txtChiefName.text = chiefName
end

function GodStatuesWarAreaEnergyRankChildView:_clearRankCell(cell)
	return
end

return GodStatuesWarAreaEnergyRankChildView
