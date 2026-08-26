-- chunkname: @modules/logic/scene/newbie/comp/NewbieSceneLevelComp.lua

module("modules.logic.scene.newbie.comp.NewbieSceneLevelComp", package.seeall)

local NewbieSceneLevelComp = class("NewbieSceneLevelComp", BaseSceneComp)

function NewbieSceneLevelComp:onInit()
	self._scene = self:getCurScene()
end

function NewbieSceneLevelComp:onSceneStart(sceneId, levelId)
	self.animSuccess = false
	self.switchSuccess = false

	self:_loadMainScene(levelId, function()
		self._scene:onPrepared()
	end)
end

function NewbieSceneLevelComp:_loadMainScene(levelId, callback, callbackTarget)
	self._callback = callback
	self._callbackTarget = callbackTarget

	if self._resPath then
		self:doCallback()

		return
	end

	self._levelId = levelId
	self._resPath = ResUrl.getSceneLevelUrl(self._levelId)

	loadAbAsset(self._resPath, false, self._onLoadCallback, self)
end

function NewbieSceneLevelComp:_onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem

		self._assetItem = assetItem

		self._assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		local sceneGO = GameSceneMgr.instance:getScene(SceneType.Main):getSceneContainerGO()

		self._instGO = gohelper.clone(self._assetItem:GetResource(self._resPath), sceneGO)

		WeatherController.instance:initSceneGo(self._instGO, self._onSwitchResLoaded, self)
		self._scene.yearAnimation:initAnimationCurve(self._onAnimationCurveLoaded, self)
		self:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, self._levelId)
	end
end

function NewbieSceneLevelComp:_onAnimationCurveLoaded()
	self.animSuccess = true

	self:_check()
end

function NewbieSceneLevelComp:_onSwitchResLoaded()
	self.switchSuccess = true

	self:_check()
end

function NewbieSceneLevelComp:_check()
	if self.animSuccess and self.switchSuccess then
		self:doCallback()
	end
end

function NewbieSceneLevelComp:doCallback()
	if self._callback then
		self._callback(self._callbackTarget)

		self._callback = nil
		self._callbackTarget = nil
	end
end

function NewbieSceneLevelComp:onSceneClose()
	if self._assetItem then
		if self._instGO then
			gohelper.destroy(self._instGO)
		end

		self._assetItem:Release()

		self._assetItem = nil
	end

	self._resPath = nil
	self.animSuccess = false
	self.switchSuccess = false

	WeatherController.instance:onSceneClose()
end

function NewbieSceneLevelComp:_onLevelLoaded(levelId)
	return
end

function NewbieSceneLevelComp:getSceneGo()
	return self._instGO
end

return NewbieSceneLevelComp
