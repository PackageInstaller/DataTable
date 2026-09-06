-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/tiling/TilingSceneConfig.lua

module("logicscene.scene.tiling.TilingSceneConfig", package.seeall)

local TilingSceneConfig = class("TilingSceneConfig")

TilingSceneConfig.ExitranceTriggerId = -120000

function TilingSceneConfig:ctor()
	self.sceneId = 0
	self.key = nil
end

function TilingSceneConfig:fromExpedGridDatas(mapData)
	self.elements = {}

	if mapData.canLeave then
		self:createExitrance()
	end

	local evtDatas = ExpeditionTilingModel.instance:getCurGridDatas()

	if not evtDatas then
		self:createExitrance()

		return
	end

	for i = 1, #evtDatas do
		local gridData = evtDatas[i]

		if not ExpeditionModel.instance:isEventCompeleted(gridData.eventId, gridData.progress) then
			local elemData = TilingElem.New()

			elemData:fromExpedGridData(gridData)
			table.insert(self.elements, elemData)
		end
	end
end

function TilingSceneConfig:createExitrance()
	local hasBuildExitrance

	for i = 1, #self.elements do
		if self.elements[i].elemData.scene == TilingElemScene.Exitrance then
			hasBuildExitrance = true

			break
		end
	end

	if hasBuildExitrance then
		return
	end

	self.elements = self.elements or {}

	local elemData = TilingElem.New()

	elemData.elemData = SceneConfig.instance:getRandomTilingElem(TilingElemScene.Exitrance)

	table.insert(self.elements, elemData)

	return elemData
end

return TilingSceneConfig
