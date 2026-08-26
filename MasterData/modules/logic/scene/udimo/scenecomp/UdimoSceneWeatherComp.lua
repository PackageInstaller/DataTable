-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneWeatherComp.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneWeatherComp", package.seeall)

local UdimoSceneWeatherComp = class("UdimoSceneWeatherComp", BaseSceneComp)

function UdimoSceneWeatherComp:onInit()
	return
end

function UdimoSceneWeatherComp:onSceneStart(sceneId, levelId)
	return
end

function UdimoSceneWeatherComp:init(sceneId, levelId)
	self._curCfgWeatherId = nil

	self:initWeatherEffectDict()
	self:updateWeatherByInfo()
	self:addEventListeners()
end

function UdimoSceneWeatherComp:onScenePrepared(sceneId, levelId)
	return
end

function UdimoSceneWeatherComp:initWeatherEffectDict()
	self:_clearEffDict()

	self._effectDict = {}

	local scene = self:getCurScene()
	local sceneObj = scene.level:getSceneGo()
	local weatherGO = gohelper.findChild(sceneObj, UdimoEnum.SceneGOName.Weather)
	local weatherTrans = weatherGO.transform
	local childCount = weatherTrans.childCount

	for i = 1, childCount do
		local child = weatherTrans:GetChild(i - 1)

		self._effectDict[child.name] = child.gameObject
	end
end

function UdimoSceneWeatherComp:updateWeatherByInfo()
	local weatherId = UdimoWeatherModel.instance:getWeatherId()
	local winLevel = UdimoWeatherModel.instance:getWindLevel()
	local cfgWeatherId = UdimoConfig.instance:findCfgWeatherId(weatherId, winLevel)

	if not cfgWeatherId then
		local useBg = UdimoItemModel.instance:getUseBg()

		cfgWeatherId = UdimoConfig.instance:getDefaultWeather(useBg)
	end

	self:changeCfgWeatherId(cfgWeatherId)
end

function UdimoSceneWeatherComp:addEventListeners()
	UdimoController.instance:registerCallback(UdimoEvent.OnGetWeatherInfo, self._onGetWeatherInfo, self)
end

function UdimoSceneWeatherComp:removeEventListeners()
	UdimoController.instance:unregisterCallback(UdimoEvent.OnGetWeatherInfo, self._onGetWeatherInfo, self)
end

function UdimoSceneWeatherComp:_onGetWeatherInfo()
	self:updateWeatherByInfo()
end

function UdimoSceneWeatherComp:stopWeatherAudio()
	if self._curCfgWeatherId then
		local stopAudioId = UdimoConfig.instance:getWeatherStopAudioId(self._curCfgWeatherId)

		if stopAudioId and stopAudioId ~= 0 then
			AudioMgr.instance:trigger(stopAudioId)
		end
	end
end

function UdimoSceneWeatherComp:changeCfgWeatherId(newWeatherId)
	if not newWeatherId or newWeatherId == self._curCfgWeatherId then
		return
	end

	self:stopWeatherAudio()

	self._curCfgWeatherId = newWeatherId

	local audioId = UdimoConfig.instance:getWeatherAudioId(self._curCfgWeatherId)

	if audioId and audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end

	self:refreshWeatherEffect()
end

function UdimoSceneWeatherComp:refreshWeatherEffect()
	if not self._curCfgWeatherId or not self._effectDict then
		return
	end

	local effectDict = UdimoConfig.instance:getWeatherEffectDict(self._curCfgWeatherId)

	for effectName, effectGO in pairs(self._effectDict) do
		gohelper.setActive(effectGO, effectDict[effectName])
	end
end

function UdimoSceneWeatherComp:_clearEffDict()
	if self._effectDict then
		for key in pairs(self._effectDict) do
			self._effectDict[key] = nil
		end
	end

	self._effectDict = nil
end

function UdimoSceneWeatherComp:onSceneClose()
	self:stopWeatherAudio()

	self._curCfgWeatherId = nil

	self:removeEventListeners()
	self:_clearEffDict()
end

return UdimoSceneWeatherComp
