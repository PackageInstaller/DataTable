-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleExtLockPetView.lua

module("logic.extensions.divineinvincible.view.DivineInvincibleExtLockPetView", package.seeall)

local DivineInvincibleExtLockPetView = class("DivineInvincibleExtLockPetView", ViewComponent)

function DivineInvincibleExtLockPetView:ctor()
	DivineInvincibleExtLockPetView.super.ctor(self)

	self._banRaceIds = {}
end

function DivineInvincibleExtLockPetView:buildUI()
	DivineInvincibleExtLockPetView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._empty = goutil.findChild(self.mainGO, "petCol/empty")

	local petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function DivineInvincibleExtLockPetView:bindEvents()
	DivineInvincibleExtLockPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function DivineInvincibleExtLockPetView:unbindEvents()
	DivineInvincibleExtLockPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineInvincibleExtLockPetView:onEnter()
	DivineInvincibleExtLockPetView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = DivineInvincibleController.instance:getActivityType()

	local isInTime = DivineInvincibleController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._clgMo = DivineInvincibleController.instance:getClgMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_DivineInvincibleClgExtremeInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineInvincibleClgExtremeResetRes, self._onUpdate, self)
	self:_onUpdate()
end

function DivineInvincibleExtLockPetView:onExit()
	DivineInvincibleExtLockPetView.super.onExit(self)
	self:_onClear()
end

function DivineInvincibleExtLockPetView:_onUpdate()
	local banRaceIds = self._clgMo:getAllLockRaceIdsInExt()

	self._banPetMoList = {}

	for i = 1, #banRaceIds do
		local raceId = checknumber(banRaceIds[i])

		if raceId > 0 then
			local petMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, raceId)

			table.insert(self._banPetMoList, petMo)
		end
	end

	self:_onUpdatePetColUI()
end

function DivineInvincibleExtLockPetView:_onClear()
	self:_onClearPetCol()
end

function DivineInvincibleExtLockPetView:_onUpdatePetColUI()
	self._petScrollerList:reloadData(self._banPetMoList)
	GameUtil.SetActive(self._empty, #self._banPetMoList == 0)
end

function DivineInvincibleExtLockPetView:_onClearPetCol()
	self._petScrollerList:dispose()
end

function DivineInvincibleExtLockPetView:_updatePetCell(view, cell, petMo, tag)
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

function DivineInvincibleExtLockPetView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
end

return DivineInvincibleExtLockPetView
