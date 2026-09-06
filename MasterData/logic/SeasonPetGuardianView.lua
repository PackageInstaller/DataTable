-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPetGuardianView.lua

module("logic.extensions.season.view.SeasonPetGuardianView", package.seeall)

local SeasonPetGuardianView = class("SeasonPetGuardianView", ViewComponent)
local TabHighRate = 1
local TabLowRate = 2

function SeasonPetGuardianView:ctor()
	SeasonPetGuardianView.super.ctor(self)
end

function SeasonPetGuardianView:unbindEvents()
	SeasonPetGuardianView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, go in ipairs(self._tabGroup) do
		GameUtil.rmClickHandler(go)
	end
end

function SeasonPetGuardianView:bindEvents()
	SeasonPetGuardianView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, go in ipairs(self._tabGroup) do
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTab, self, i))
	end
end

function SeasonPetGuardianView:buildUI()
	SeasonPetGuardianView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txt = self:getTxt("txt")
	self._scrollerGo = self:getGo("tableview")
	self._cellGo = self:getGo("item")
	self._scrollList = ScrollerList.create(self._scrollerGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tabGroup = {}

	for i = 1, 2 do
		local go = self:getGo(string.format("btnTab_%s", i))

		table.insert(self._tabGroup, go)
	end

	GameUtil.SetActive(self._cellGo, false)
end

function SeasonPetGuardianView:onExit()
	SeasonPetGuardianView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self._onGetFmtInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtBagPetInfo, self._onGetBagInfo, self)
	self._scrollList:dispose()
end

function SeasonPetGuardianView:onEnter()
	SeasonPetGuardianView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self._onGetFmtInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtBagPetInfo, self._onGetBagInfo, self)

	self._posId = checknumber(self:getFirstParam())
	self._tabId = -1
	self._bagPetMap = nil
	self._fmtPetMap = nil

	local seasonId = SeasonModel.instance:getSeasonId()
	local mainCampConfig = SeasonMainCampConfig.instance:getMainCampConfig(seasonId)

	self._petGuardPlanId = mainCampConfig.petGuardPlanId

	self:_onClickTab(1)
	self:_sendMsg()
end

function SeasonPetGuardianView:_sendMsg()
	SeasonController.instance:sendGetAllTeamInfo()
	SeasonController.instance:sendGetAllPetListInfo()
end

function SeasonPetGuardianView:_onGetBagInfo()
	self._bagPetMap = {}

	for _, mo in ipairs(SeasonPetsModel.instance:getSeasonBagPetList() or {}) do
		self._bagPetMap[mo.raceId] = self._bagPetMap[mo.raceId] == nil and mo.awakenLv or math.max(self._bagPetMap[mo.raceId], mo.awakenLv)
	end

	self:_updateDetails()
end

function SeasonPetGuardianView:_onGetFmtInfo()
	self._fmtPetMap = {}

	for _, teamMo in ipairs(SeasonTeamsModel.instance:getTeams() or {}) do
		for _, mo in ipairs(teamMo:getPetMoList() or {}) do
			self._fmtPetMap[mo.raceId] = self._fmtPetMap[mo.raceId] == nil and mo.awakenLv or math.max(self._fmtPetMap[mo.raceId], mo.awakenLv)
		end
	end

	self:_updateDetails()
end

function SeasonPetGuardianView:_getCurPetGroups()
	local configInstance = SeasonMainCampConfig.instance

	if self._tabId == TabHighRate then
		local recommendPets, _ = configInstance:getPetGuardRecommendRaceIds(self._petGuardPlanId)

		return recommendPets
	elseif self._tabId == TabLowRate then
		local normalPets, _ = configInstance:getPetGuardNormalRaceIds(self._petGuardPlanId)

		return normalPets
	end
end

function SeasonPetGuardianView:_updateDetails()
	if self._fmtPetMap and self._bagPetMap then
		self._scrollList:reloadData(self:_getCurPetGroups())
	end
end

function SeasonPetGuardianView:_getAwakenLv(raceId)
	return math.max(checknumber(self._fmtPetMap[raceId]), checknumber(self._bagPetMap[raceId]))
end

function SeasonPetGuardianView:_getHasPet(raceId)
	return self._fmtPetMap[raceId] or self._bagPetMap[raceId]
end

function SeasonPetGuardianView:_updateCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local raceId = data
	local hasSelect = SeasonMainCampModel.instance:hasSetPetAsGuard(raceId)

	GameUtil.SetActive(imgSelect, hasSelect)

	local proxy = MaterialMgr.setCellByCfg(MaterialMgr.createSerName(MatType.Pet, raceId, 1), item)

	proxy.binder:setAutoTips(false)
	proxy:setGray(not self:_getHasPet(raceId))
	proxy:setCallBack(function()
		if hasSelect then
			FloatWordMgr.instance:show(lang("该精灵已经是守护者了"))
		else
			SeasonModePveAgent.instance:sendPM_SMPVEChangePetGuardReq(self._posId, raceId)
			self:close()
		end
	end)
end

function SeasonPetGuardianView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function SeasonPetGuardianView:_updateTabState()
	for i, go in ipairs(self._tabGroup) do
		if self._tabId == i then
			GameUtil.setUIGroupIdx(go, 1)
		else
			GameUtil.setUIGroupIdx(go, 0)
		end
	end
end

function SeasonPetGuardianView:_onClickTab(index)
	if self._tabId ~= index then
		self._tabId = index

		self:_updateTabState()
		self:_updateDetails()
	end
end

return SeasonPetGuardianView
