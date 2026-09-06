-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/buzhen/ScuffleFormationLeftView.lua

module("logic.extensions.scuffle.view.buzhen.ScuffleFormationLeftView", package.seeall)

local ScuffleFormationLeftView = class("ScuffleFormationLeftView", FormationLeftView)

function ScuffleFormationLeftView:onEnter()
	ScuffleFormationLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
	self:setBtnFormActive(false)
	self:setBtnContractActive(false)
	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
end

function ScuffleFormationLeftView:_isShowBtnEvaluate()
	return false
end

function ScuffleFormationLeftView:_getCurFormId()
	return ScuffleModel.instance:getCurFormationId()
end

function ScuffleFormationLeftView:_getCurFormation()
	return ScuffleModel.instance:getFormation()
end

function ScuffleFormationLeftView:_getPet(id)
	return ScuffleModel.instance:getPet(id)
end

function ScuffleFormationLeftView:_getCurBonds(isGetPetIdList)
	local racesInCurFormation = {}
	local positions = self:_getCurFormation():GetPositions()
	local petIdList = {}

	for i, petId in ipairs(positions) do
		if petId > 0 then
			local raceId = self:_getPet(petId).raceId

			table.insert(racesInCurFormation, raceId)
			table.insert(petIdList, petId)
		end
	end

	return {}, petIdList
end

function ScuffleFormationLeftView:_changeTeamId(id)
	printError("test 切换了阵型？")
end

function ScuffleFormationLeftView:_getCurrTeamId()
	return ScuffleModel.instance:getTeamId()
end

function ScuffleFormationLeftView:_saveCurrFmt()
	return
end

function ScuffleFormationLeftView:_getItemSeatCls()
	return ScuffleItemSeat
end

return ScuffleFormationLeftView
