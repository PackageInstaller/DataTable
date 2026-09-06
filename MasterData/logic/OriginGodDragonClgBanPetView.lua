-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgBanPetView.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgBanPetView", package.seeall)

local OriginGodDragonClgBanPetView = class("OriginGodDragonClgBanPetView", ViewComponent)

function OriginGodDragonClgBanPetView:buildUI()
	OriginGodDragonClgBanPetView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function OriginGodDragonClgBanPetView:bindEvents()
	OriginGodDragonClgBanPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriginGodDragonClgBanPetView:unbindEvents()
	OriginGodDragonClgBanPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginGodDragonClgBanPetView:onEnter()
	OriginGodDragonClgBanPetView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = OriginGodDragonClgController.instance:getSubMo(self._activityId)

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_OriginGodDragonClgInfoRes, self._onUpdate, self)
end

function OriginGodDragonClgBanPetView:onExit()
	OriginGodDragonClgBanPetView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginGodDragonClgBanPetView:_onUpdate()
	local lockRaceIdMap = self._subMo:getAllLockRaceIds()

	self._banPetMoList = {}

	for raceId, _ in pairs(lockRaceIdMap) do
		local petMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, raceId)

		table.insert(self._banPetMoList, petMo)
	end

	self._petScrollerList:reloadData(self._banPetMoList)
end

function OriginGodDragonClgBanPetView:_updatePetCell(view, cell, petMo, tag)
	local skinId = petMo.curFaceId
	local mainGo = cell.gameObject
	local mask = goutil.findChild(mainGo, "mask")
	local con = goutil.findChild(mainGo, "mask/con")

	MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
	GameUtil.addClickHandler(mask, function()
		CommonTipsMgr.instance:showPetTips(petMo, true)
	end)
end

function OriginGodDragonClgBanPetView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local mask = goutil.findChild(mainGo, "mask")
	local con = goutil.findChild(mainGo, "mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(mask)
end

return OriginGodDragonClgBanPetView
