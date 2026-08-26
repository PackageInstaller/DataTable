-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/mo/MaLiAnNaLaSoliderMoUtil.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.MaLiAnNaLaSoliderMoUtil", package.seeall)

local MaLiAnNaLaSoliderMoUtil = class("MaLiAnNaLaSoliderMoUtil")

function MaLiAnNaLaSoliderMoUtil:init()
	self.soliderOnlyId = 0
	self._allSoliderMoList = {}
end

function MaLiAnNaLaSoliderMoUtil:getOnlyId()
	self.soliderOnlyId = self.soliderOnlyId + 1

	return self.soliderOnlyId
end

function MaLiAnNaLaSoliderMoUtil:createSoliderMo(configId)
	if configId == nil then
		return nil
	end

	local id = self:getOnlyId()
	local soliderMo = MaLiAnNaSoldierEntityMo.create()

	soliderMo:init(id, configId)

	if soliderMo ~= nil then
		self._allSoliderMoList[id] = soliderMo
	end

	return soliderMo
end

function MaLiAnNaLaSoliderMoUtil:recycleSoliderMo(soliderMo)
	if soliderMo == nil then
		return
	end

	local id = soliderMo:getId()
	local isHero = soliderMo:isHero()

	if not isHero then
		self._allSoliderMoList[id] = nil

		Activity201MaLiAnNaGameModel.instance:removeDisPatchSolider(id)
		soliderMo:clear()

		soliderMo = nil
	end
end

function MaLiAnNaLaSoliderMoUtil:getSoliderMoByConfigId(configId)
	if configId == nil then
		return nil
	end

	for _, solider in pairs(self._allSoliderMoList) do
		if solider and solider:getConfigId() == configId then
			return solider
		end
	end

	return nil
end

function MaLiAnNaLaSoliderMoUtil:getSoliderMoById(id)
	if id == nil or self._allSoliderMoList == nil then
		return nil
	end

	return self._allSoliderMoList[id]
end

function MaLiAnNaLaSoliderMoUtil:getAllHeroSolider(camp)
	if self._allSoliderMoList == nil then
		return nil
	end

	local heroSoliderList = {}

	for _, solider in pairs(self._allSoliderMoList) do
		if solider and solider:isHero() and camp == solider:getCamp() then
			heroSoliderList[#heroSoliderList + 1] = solider
		end
	end

	return heroSoliderList
end

function MaLiAnNaLaSoliderMoUtil:getAllSoliderMoList()
	return self._allSoliderMoList
end

function MaLiAnNaLaSoliderMoUtil:clear()
	if self._allSoliderMoList ~= nil then
		for _, solider in pairs(self._allSoliderMoList) do
			if solider then
				solider:clear()
			end
		end

		self._allSoliderMoList = nil
	end
end

MaLiAnNaLaSoliderMoUtil.instance = MaLiAnNaLaSoliderMoUtil.New()

return MaLiAnNaLaSoliderMoUtil
