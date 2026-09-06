-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTower3v3FmtLeftView.lua

module("logic.extensions.mission.view.MangTower3v3FmtLeftView", package.seeall)

local MangTower3v3FmtLeftView = class("MangTower3v3FmtLeftView", FormationLeftView)

function MangTower3v3FmtLeftView:onEnter()
	MangTower3v3FmtLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
	GlobalDispatcher:addListener(GlobalNotify.CurFormTabChange, self._RefreshView, self)
end

function MangTower3v3FmtLeftView:onExit()
	MangTower3v3FmtLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CurFormTabChange, self._RefreshView, self)
end

function MangTower3v3FmtLeftView:_setBtnFormationActive()
	return false
end

function MangTower3v3FmtLeftView:_initSelfFormation()
	return
end

function MangTower3v3FmtLeftView:_getCurFormId()
	return 0
end

function MangTower3v3FmtLeftView:_getCurFormation()
	local tab = MangTowerModel.instance:getSelectFmtTab()

	return MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_3V3, tab)
end

function MangTower3v3FmtLeftView:_changeTeamId(id)
	return
end

function MangTower3v3FmtLeftView:_getCurrTeamId()
	return 1
end

function MangTower3v3FmtLeftView:_saveCurrFmt()
	return
end

function MangTower3v3FmtLeftView:dealWithLimitPetPos()
	local formationMo = self:_getCurFormation()

	if formationMo then
		for k, petId in ipairs(formationMo:GetPositions()) do
			if petId > 0 then
				local pet = self:_getPet(petId)

				if pet then
					MangTowerController.instance:clearOtherTabPetByRaceId(pet.raceId)
				end
			end
		end
	end
end

return MangTower3v3FmtLeftView
