-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonEliteChallengeGridShowView.lua

module("logic.extensions.season.view.SeasonEliteChallengeGridShowView", package.seeall)

local SeasonEliteChallengeGridShowView = class("SeasonEliteChallengeGridShowView", SeasonChallengeGridShowView)

function SeasonEliteChallengeGridShowView:ctor()
	SeasonEliteChallengeGridShowView.super.ctor(self)
end

function SeasonEliteChallengeGridShowView:unbindEvents()
	SeasonEliteChallengeGridShowView.super.unbindEvents(self)
end

function SeasonEliteChallengeGridShowView:bindEvents()
	SeasonEliteChallengeGridShowView.super.bindEvents(self)
end

function SeasonEliteChallengeGridShowView:buildUI()
	SeasonEliteChallengeGridShowView.super.buildUI(self)

	self._raceCon = self:getGo("con/pet")
end

function SeasonEliteChallengeGridShowView:onExit()
	SeasonEliteChallengeGridShowView.super.onExit(self)

	if self._petPhoto then
		self._petPhoto:clear()
	end
end

function SeasonEliteChallengeGridShowView:onEnter()
	SeasonEliteChallengeGridShowView.super.onEnter(self)
	self:_showPetLiHui()
end

function SeasonEliteChallengeGridShowView:_showPetLiHui()
	local creeps = SeasonConfig.instance:getCreeps(self._evtDetailConfig.creepsMasterId)

	if self._petPhoto then
		self._petPhoto:clear()
	end

	local minPosId = 99999
	local creepCo

	for k, v in pairs(creeps) do
		if minPosId > v.posId then
			minPosId = v.posId
			creepCo = v
		end
	end

	if creepCo then
		self._petPhoto = PetPhotoShow.Get(self._raceCon)

		self._petPhoto:showPetEffect(creepCo.raceId, true, 4.3)

		local modelCfg = CharactorFacade.instance:getSeasonUIPosAndScale(creepCo.raceId)
		local x = checknumber(modelCfg[1]) / 360
		local y = checknumber(modelCfg[2]) / 360

		if not modelCfg[3] then
			self._petPhoto:setPetLocalPosAndScale(x, y, modelCfg[3])
		end
	end
end

return SeasonEliteChallengeGridShowView
