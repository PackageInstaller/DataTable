-- chunkname: @modules/logic/scene/summon/SummonSceneShell.lua

module("modules.logic.scene.summon.SummonSceneShell", package.seeall)

local SummonSceneShell = class("SummonSceneShell")
local SummonSceneStep = {
	Prepared = 3,
	Close = 1,
	Start = 2
}

function SummonSceneShell:init(sceneId, levelId)
	self._curSceneId = sceneId
	self._curLevelId = levelId
	self._curStep = SummonSceneStep.Close
	self._allComps = {}

	self:registClz()

	for _, comp in ipairs(self._allComps) do
		if comp.onInit then
			comp:onInit()
		end
	end
end

function SummonSceneShell:registClz()
	self:_addComp("director", SummonSceneDirector)
	self:_addComp("view", SummonSceneViewComp)
	self:_addComp("bgm", SummonSceneBgmComp)
	self:_addComp("cameraAnim", SummonSceneCameraComp)
	self:_addComp("preloader", SummonScenePreloader)
	self:_addComp("selector", SummonSceneSelector)
end

function SummonSceneShell:_addComp(compName, compDefine)
	local compObj = compDefine.New(self)

	self[compName] = compObj

	table.insert(self._allComps, compObj)
end

function SummonSceneShell:onStart(sceneId, levelId)
	if self._curStep ~= SummonSceneStep.Close then
		return
	end

	self._curStep = SummonSceneStep.Start

	logNormal("summmon start")

	for _, comp in ipairs(self._allComps) do
		if comp.onSceneStart and not comp.isOnStarted then
			comp:onSceneStart(sceneId, levelId)
		end
	end
end

function SummonSceneShell:onPrepared()
	if self._curStep ~= SummonSceneStep.Start then
		return
	end

	self._curStep = SummonSceneStep.Prepared

	logNormal("summmon onPrepared")

	for _, comp in ipairs(self._allComps) do
		if comp.onScenePrepared then
			comp:onScenePrepared(self._curSceneId, self._curLevelId)
		end
	end

	SummonController.instance:dispatchEvent(SummonEvent.onSummonScenePrepared)
end

function SummonSceneShell:onClose()
	if self._curStep == SummonSceneStep.Close then
		return
	end

	self._curStep = SummonSceneStep.Close

	logNormal("summmon close")

	self._isClosing = true

	for _, comp in ipairs(self._allComps) do
		if comp.onSceneClose then
			comp:onSceneClose()
		end
	end

	self._isClosing = false
end

function SummonSceneShell:onHide()
	if self._curStep == SummonSceneStep.Close then
		return
	end

	self._curStep = SummonSceneStep.Close

	logNormal("summmon hide")

	for _, comp in ipairs(self._allComps) do
		if comp.onSceneHide then
			comp:onSceneHide()
		end
	end
end

function SummonSceneShell:getSceneContainerGO()
	return VirtualSummonScene.instance:getRootGO()
end

return SummonSceneShell
