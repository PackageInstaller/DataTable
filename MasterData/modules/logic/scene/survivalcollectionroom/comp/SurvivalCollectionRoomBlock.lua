-- chunkname: @modules/logic/scene/survivalcollectionroom/comp/SurvivalCollectionRoomBlock.lua

module("modules.logic.scene.survivalcollectionroom.comp.SurvivalCollectionRoomBlock", package.seeall)

local SurvivalCollectionRoomBlock = class("SurvivalCollectionRoomBlock", BaseSceneComp)

function SurvivalCollectionRoomBlock:init()
	self:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
end

function SurvivalCollectionRoomBlock:_onPreloadFinish()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)

	local sceneGo = self:getCurScene():getSceneContainerGO()

	self.blockRoot = gohelper.create3d(sceneGo, "BlockRoot")

	local mapCo = SurvivalConfig.instance:getShelterMapCo()

	self.blocks = {}
	self.blockDict = {}

	for i, v in ipairs(mapCo.allBlocks) do
		local block = SurvivalShelterBlockEntity.Create(v, self.blockRoot)

		table.insert(self.blocks, block)
		SurvivalHelper.instance:addNodeToDict(self.blockDict, v.pos)
	end

	self:dispatchEvent(SurvivalEvent.OnSurvivalBlockLoadFinish)
end

function SurvivalCollectionRoomBlock:onSceneClose()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
	gohelper.destroy(self.blockRoot)

	self.blocks = {}
	self.blockDict = {}
end

function SurvivalCollectionRoomBlock:isClickBlock(hexPoint)
	return SurvivalHelper.instance:getValueFromDict(self.blockDict, hexPoint)
end

return SurvivalCollectionRoomBlock
