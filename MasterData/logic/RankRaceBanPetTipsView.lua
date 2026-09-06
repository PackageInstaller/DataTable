-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceBanPetTipsView.lua

module("logic.extensions.rankrace.view.RankRaceBanPetTipsView", package.seeall)

local RankRaceBanPetTipsView = class("RankRaceBanPetTipsView", ViewComponent)

function RankRaceBanPetTipsView:ctor()
	RankRaceBanPetTipsView.super.ctor(self)

	self._banRaceIds = {}
end

function RankRaceBanPetTipsView:buildUI()
	RankRaceBanPetTipsView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._empty = goutil.findChild(self.mainGO, "petCol/empty")

	local petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollerList:setCenterMode(true)
end

function RankRaceBanPetTipsView:bindEvents()
	RankRaceBanPetTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function RankRaceBanPetTipsView:unbindEvents()
	RankRaceBanPetTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function RankRaceBanPetTipsView:onEnter()
	RankRaceBanPetTipsView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._viewType = params[2]

	if self._seasonId <= 0 then
		self:close()

		return
	end

	self._banRaceIdCount = RankRaceConfig.instance:getRankCommonValue("BAN_RACE_COUNT", true)

	self.addGEvent(self, GlobalNotify.HandleRM_GetBanPetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandleRM_BanPetRes, self._onUpdate, self)
	self:_onUpdate()
end

function RankRaceBanPetTipsView:onExit()
	RankRaceBanPetTipsView.super.onExit(self)
	self:_onClear()
end

function RankRaceBanPetTipsView:_onUpdate()
	local msg = RankRaceController.instance:getOpenRankingMatchData(self._viewType)

	if msg then
		if not msg.banRaceIds then
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

function RankRaceBanPetTipsView:_onClear()
	self:_onClearPetCol()
end

function RankRaceBanPetTipsView:_onUpdatePetColUI()
	self._petScrollerList:reloadData(self._banPetMoList)
	GameUtil.SetActive(self._empty, #self._banPetMoList == 0)
end

function RankRaceBanPetTipsView:_onClearPetCol()
	self._petScrollerList:dispose()
end

function RankRaceBanPetTipsView:_updatePetCell(view, cell, petMo, tag)
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

function RankRaceBanPetTipsView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
end

return RankRaceBanPetTipsView
