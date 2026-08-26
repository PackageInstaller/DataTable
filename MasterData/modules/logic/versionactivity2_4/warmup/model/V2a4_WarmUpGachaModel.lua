-- chunkname: @modules/logic/versionactivity2_4/warmup/model/V2a4_WarmUpGachaModel.lua

module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpGachaModel", package.seeall)

local V2a4_WarmUpGachaModel = class("V2a4_WarmUpGachaModel", BaseModel)
local ti = table.insert

function V2a4_WarmUpGachaModel:onInit()
	self:reInit()
end

function V2a4_WarmUpGachaModel:reInit()
	self._waveList = {}
	self._s_RandomList = {}
end

function V2a4_WarmUpGachaModel:clean()
	self._waveList = {}
end

function V2a4_WarmUpGachaModel:curWaveIndex()
	return #self._waveList
end

function V2a4_WarmUpGachaModel:curWave()
	local index = self:curWaveIndex()

	return self._waveList[index]
end

function V2a4_WarmUpGachaModel:curRound()
	local waveMO = self:curWave()

	if not waveMO then
		return nil
	end

	return waveMO:curRound()
end

function V2a4_WarmUpGachaModel:curRoundIndex()
	local roundMO = self:curRound()

	if not roundMO then
		return 0
	end

	return roundMO:index()
end

function V2a4_WarmUpGachaModel:s_RdList(levelId)
	local list = self._s_RandomList[levelId]

	if list then
		return list
	end

	local config = V2a4_WarmUpController.instance:config()
	local textItemList = config:getTextItemListCO(levelId)
	local photoItemList = config:getPhotoItemListCO(levelId)

	list = {
		[V2a4_WarmUpEnum.AskType.Text] = textItemList,
		[V2a4_WarmUpEnum.AskType.Photo] = photoItemList
	}

	assert(#list == 2)

	self._s_RandomList[levelId] = list

	return list
end

function V2a4_WarmUpGachaModel:restart(levelId)
	self:clean()

	local s_levelCOLists = self:s_RdList(levelId)

	SimpleRandomModel.instance:clean(s_levelCOLists)
end

function V2a4_WarmUpGachaModel:genWave(levelId)
	local config = V2a4_WarmUpController.instance:config()
	local s_levelCOLists = self:s_RdList(levelId)
	local whichList, whichItem = SimpleRandomModel.instance:getListIdxAndItemIdx(s_levelCOLists)
	local levelCO = config:getLevelCO(levelId)
	local askCount = levelCO.askCount
	local waveIndex = self:curWaveIndex() + 1
	local levelCOList = s_levelCOLists[whichList]
	local waveMO = V2a4_WarmUpGachaWaveMO.New(waveIndex, whichList)

	for i = 1, askCount do
		waveMO:genRound(levelCOList[whichItem])
	end

	ti(self._waveList, waveMO)

	return waveMO
end

V2a4_WarmUpGachaModel.instance = V2a4_WarmUpGachaModel.New()

return V2a4_WarmUpGachaModel
