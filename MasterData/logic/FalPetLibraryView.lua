-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalPetLibraryView.lua

module("logic.extensions.landlords.view.FalPetLibraryView", package.seeall)

local FalPetLibraryView = class("FalPetLibraryView", ViewComponent)

function FalPetLibraryView:buildUI()
	FalPetLibraryView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._petScrollerview = goutil.findChild(self.mainGO, "petCol/petScrollerview")
	self._petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")
	self._petScrollList = ScrollerList.create(self._petScrollerview, self._petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function FalPetLibraryView:bindEvents()
	FalPetLibraryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FalPetLibraryView:unbindEvents()
	FalPetLibraryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FalPetLibraryView:onEnter()
	FalPetLibraryView.super.onEnter(self)

	self._activityId = FightAgainstLandlordsController.instance:getActivityId()

	self:_onUpdatePetColUI()
end

function FalPetLibraryView:onExit()
	FalPetLibraryView.super.onExit(self)
	self._petScrollList:dispose()
end

function FalPetLibraryView:_onUpdatePetColUI()
	local creepsCfg = FightAgainstLandlordsConfig.instance:getFalCreepsCfg()

	self._petScrollList:reloadData(creepsCfg)
end

function FalPetLibraryView:_updatePetCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "con")
	local txtPetName = goutil.findChildTextComponent(mainGo, "txtPetName")
	local txtPower = goutil.findChildTextComponent(mainGo, "txtPower")
	local petMo = FightAgainstLandlordsModel.instance:getPetMoAsFal(data.creepsId)
	local skinId = petMo.curFaceId
	local proxy = MaterialMgr.setCell(MatType.Pet, skinId, con)

	if proxy then
		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:showPetTips(petMo)
		end)
	end

	txtPower.text = petMo:getFightingPower()
	txtPetName.text = data.creepsName
end

function FalPetLibraryView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "con")

	MaterialMgr.resetAll(con)
end

return FalPetLibraryView
