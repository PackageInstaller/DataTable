-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonHirePetGridShowView.lua

module("logic.extensions.season.view.SeasonHirePetGridShowView", package.seeall)

local SeasonHirePetGridShowView = class("SeasonHirePetGridShowView", SeasonChallengeGridShowView)

function SeasonHirePetGridShowView:ctor()
	SeasonHirePetGridShowView.super.ctor(self)
end

function SeasonHirePetGridShowView:unbindEvents()
	SeasonHirePetGridShowView.super.unbindEvents(self)
end

function SeasonHirePetGridShowView:bindEvents()
	SeasonHirePetGridShowView.super.bindEvents(self)
end

function SeasonHirePetGridShowView:buildUI()
	SeasonHirePetGridShowView.super.buildUI(self)

	self._raceCon = self:getGo("con/pet")
end

function SeasonHirePetGridShowView:onExit()
	SeasonHirePetGridShowView.super.onExit(self)
	self._teamScrollList:dispose()
	self._rewardScrollList:dispose()

	if self._petPhoto then
		self._petPhoto:clear()
	end
end

function SeasonHirePetGridShowView:onEnter()
	SeasonHirePetGridShowView.super.onEnter(self)

	local params = self:getFirstParam()

	self._evtConfig = params.evtConfig
	self._evtDetailConfig = params.evtDetailConfig

	self:_showPetLiHui()
end

function SeasonHirePetGridShowView:_showPetLiHui()
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

function SeasonHirePetGridShowView:_showReword()
	local hirePetCfg = SeasonConfig.instance:getHirePetCfgById(self._evtDetailConfig.hirePetId)
	local rewardList = {}

	if hirePetCfg then
		local hierPetMo = SeasonPetsModel.instance:createHirePetMo(hirePetCfg.defineId)

		rewardList = {
			hierPetMo
		}

		self._rewardScrollList:reloadData(rewardList)
	end

	self._rewardScrollList:reloadData(rewardList)
end

function SeasonHirePetGridShowView:_updateRewardCell(view, cell, data, tag)
	local proxy = MaterialMgr.setCellByMo(data, cell)

	if proxy then
		proxy.binder:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(data)
		end)
	end
end

function SeasonHirePetGridShowView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return SeasonHirePetGridShowView
