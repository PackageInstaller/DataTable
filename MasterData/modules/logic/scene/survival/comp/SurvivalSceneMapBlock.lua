-- chunkname: @modules/logic/scene/survival/comp/SurvivalSceneMapBlock.lua

module("modules.logic.scene.survival.comp.SurvivalSceneMapBlock", package.seeall)

local SurvivalSceneMapBlock = class("SurvivalSceneMapBlock", BaseSceneComp)

function SurvivalSceneMapBlock:init()
	self:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
end

function SurvivalSceneMapBlock:_onPreloadFinish()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)

	self._sceneGo = self:getCurScene():getSceneContainerGO()
	self._blockRoot = gohelper.create3d(self._sceneGo, "BlockRoot")

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local dict = {}

	for k, v in pairs(sceneMo.blocks) do
		SurvivalHelper.instance:addNodeToDict(dict, v.pos)

		for _, vv in pairs(v.exPoints) do
			SurvivalHelper.instance:addNodeToDict(dict, vv)
		end
	end

	local mapCo = SurvivalMapModel.instance:getCurMapCo()

	self._allBlocks = {}

	for i, v in ipairs(mapCo.allBlocks) do
		local pos = v.pos

		if not SurvivalHelper.instance:getValueFromDict(sceneMo.allDestroyPos, pos) and not SurvivalHelper.instance:getValueFromDict(dict, pos) then
			self._allBlocks[pos.q] = self._allBlocks[pos.q] or {}
			self._allBlocks[pos.q][pos.r] = SurvivalBlockEntity.Create(v, self._blockRoot)
		end
	end

	for _, v in ipairs(sceneMo.extraBlock) do
		local pos = v.pos

		if not SurvivalHelper.instance:getValueFromDict(sceneMo.allDestroyPos, pos) and not SurvivalHelper.instance:getValueFromDict(dict, pos) then
			self._allBlocks[pos.q] = self._allBlocks[pos.q] or {}
			self._allBlocks[pos.q][pos.r] = SurvivalExBlockEntity.Create(v, self._blockRoot)

			mapCo:setWalkByUnitMo(v, true)
		end
	end

	self:dispatchEvent(SurvivalEvent.OnSurvivalBlockLoadFinish)
end

function SurvivalSceneMapBlock:addExBlock(mo)
	local pos = mo.pos

	self._allBlocks[pos.q] = self._allBlocks[pos.q] or {}
	self._allBlocks[pos.q][pos.r] = SurvivalExBlockEntity.Create(mo, self._blockRoot)

	local mapCo = SurvivalMapModel.instance:getCurMapCo()

	mapCo:setWalkByUnitMo(mo, true)
end

function SurvivalSceneMapBlock:setBlockActive(pos, isActive)
	if self._allBlocks[pos.q] then
		if self._allBlocks[pos.q] then
			gohelper.setActive(self._allBlocks[pos.q].go, isActive)
		end
	end
end

function SurvivalSceneMapBlock:onSceneClose()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
	gohelper.destroy(self._blockRoot)

	self._blockRoot = nil
	self._sceneGo = nil
	self._allBlocks = {}
end

function SurvivalSceneMapBlock:getBlock(hexPoint)
	if not hexPoint then
		return
	end

	if self._allBlocks[hexPoint.q] then
		return self._allBlocks[hexPoint.q][hexPoint.r]
	end
end

return SurvivalSceneMapBlock
