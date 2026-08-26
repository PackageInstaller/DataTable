-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterSceneMapBlock.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterSceneMapBlock", package.seeall)

local SurvivalShelterSceneMapBlock = class("SurvivalShelterSceneMapBlock", BaseSceneComp)

function SurvivalShelterSceneMapBlock:init()
	self:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
end

function SurvivalShelterSceneMapBlock:_onPreloadFinish()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)

	self._sceneGo = self:getCurScene():getSceneContainerGO()
	self._blockRoot = gohelper.create3d(self._sceneGo, "BlockRoot")

	local mapCo = SurvivalConfig.instance:getShelterMapCo()

	self._allBlocks = {}
	self.blockDict = {}

	for i, v in ipairs(mapCo.allBlocks) do
		SurvivalHelper.instance:addNodeToDict(self.blockDict, v.pos)

		local block = SurvivalShelterBlockEntity.Create(v, self._blockRoot)

		table.insert(self._allBlocks, block)
	end

	self:dispatchEvent(SurvivalEvent.OnSurvivalBlockLoadFinish)
end

function SurvivalShelterSceneMapBlock:isClickBlock(hexPoint)
	return SurvivalHelper.instance:getValueFromDict(self.blockDict, hexPoint)
end

function SurvivalShelterSceneMapBlock:onSceneClose()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
	gohelper.destroy(self._blockRoot)

	self._blockRoot = nil
	self._sceneGo = nil
	self.blockDict = {}
	self._allBlocks = {}
end

return SurvivalShelterSceneMapBlock
