-- chunkname: @modules/logic/scene/main/comp/MainSceneLevelComp.lua

module("modules.logic.scene.main.comp.MainSceneLevelComp", package.seeall)

local MainSceneLevelComp = class("MainSceneLevelComp", CommonSceneLevelComp)

function MainSceneLevelComp:loadLevel(levelId)
	if self._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (self._levelId or "nil") .. ", try to load id = " .. (levelId or "nil"))

		return
	end

	if self._assetItem then
		gohelper.destroy(self._instGO)
		self._assetItem:Release()

		self._assetItem = nil
		self._instGO = nil

		self:releaseSceneEffectsLoader()
	end

	self._isLoadingRes = true
	self._levelId = levelId

	self:getCurScene():setCurLevelId(self._levelId)
	MainSceneSwitchModel.instance:initSceneId()

	local resName = MainSceneSwitchModel.instance:getCurSceneResName()

	self._resPath = ResUrl.getSceneRes(resName)

	loadAbAsset(self._resPath, false, self._onLoadCallback, self)
end

function MainSceneLevelComp:switchLevel()
	self:loadLevel(self._levelId)
end

return MainSceneLevelComp
