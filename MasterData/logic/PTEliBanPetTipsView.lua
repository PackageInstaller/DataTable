-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliBanPetTipsView.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliBanPetTipsView", package.seeall)

local PTEliBanPetTipsView = class("PTEliBanPetTipsView", ViewComponent)

function PTEliBanPetTipsView:ctor()
	PTEliBanPetTipsView.super.ctor(self)

	self._banRaceIds = {}
end

function PTEliBanPetTipsView:buildUI()
	PTEliBanPetTipsView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._empty = goutil.findChild(self.mainGO, "petCol/empty")

	local petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollerList:setCenterMode(true)
end

function PTEliBanPetTipsView:bindEvents()
	PTEliBanPetTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function PTEliBanPetTipsView:unbindEvents()
	PTEliBanPetTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function PTEliBanPetTipsView:onEnter()
	PTEliBanPetTipsView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.PeakTournamentBanPetInfoRes, self._onUpdate, self)

	local isBanInQual = PeakTournamentController.instance:isTheSeasonHaveBanPet(self._activityId, GameEnum.PeakTournamentStep.Qualifier)
	local isBanInEli = PeakTournamentController.instance:isTheSeasonHaveBanPet(self._activityId, GameEnum.PeakTournamentStep.Eliminator)

	self._txtTips.text = isBanInQual and isBanInEli and "下列精灵在本赛季的预选赛、淘汰赛中禁止上阵" or isBanInQual and "下列精灵在本赛季的预选赛中禁止上阵" or isBanInEli and "下列精灵在本赛季的淘汰中禁止上阵" or "本赛季没有禁止上阵的精灵"

	self:_onUpdate()
	PeakTournamentController.instance:sendPM_PeakTournamentBanPetInfoReq(self._activityId)
end

function PTEliBanPetTipsView:onExit()
	PTEliBanPetTipsView.super.onExit(self)
	self:_onClear()
end

function PTEliBanPetTipsView:_onUpdate()
	self._banPetData = PeakTournamentConfig.instance:getPtBanPetData(self._activityId)

	if self._banPetData then
		self._banRaceIdCount = self._banPetData.banRaceIdCount or 0
	end

	self._banPetInfo = PeakTournamentModel.instance:getBanPetInfo()

	if self._banPetInfo then
		if not self._banPetInfo.banRaceIds then
			local banRaceIds = {}

			self._banPetMoList = {}

			for i = 1, self._banRaceIdCount do
				local raceId = checknumber(banRaceIds[i])

				if raceId > 0 then
					local petMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, raceId)

					table.insert(self._banPetMoList, petMo)
				end
			end

			self:_onUpdatePetColUI()
		end
	end
end

function PTEliBanPetTipsView:_onClear()
	self:_onClearPetCol()
end

function PTEliBanPetTipsView:_onUpdatePetColUI()
	self._petScrollerList:reloadData(self._banPetMoList)
	GameUtil.SetActive(self._empty, #self._banPetMoList == 0)
end

function PTEliBanPetTipsView:_onClearPetCol()
	self._petScrollerList:dispose()
end

function PTEliBanPetTipsView:_updatePetCell(view, cell, petMo, tag)
	local skinId = petMo.curFaceId
	local raceId = petMo:getDefineId()
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	if raceId > 0 then
		MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
	else
		MaterialMgr.clearIcon(con)
	end

	GameUtil.addClickHandler(pet, function()
		CommonTipsMgr.instance:showPetTips(petMo, true)
	end)
end

function PTEliBanPetTipsView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
end

return PTEliBanPetTipsView
