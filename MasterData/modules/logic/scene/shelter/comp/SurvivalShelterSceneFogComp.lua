-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterSceneFogComp.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterSceneFogComp", package.seeall)

local SurvivalShelterSceneFogComp = class("SurvivalShelterSceneFogComp", BaseSceneComp)

SurvivalShelterSceneFogComp.FogResPath = "survival/common/survialfog.prefab"

function SurvivalShelterSceneFogComp:init(sceneId, levelId)
	self:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
end

function SurvivalShelterSceneFogComp:_onPreloadFinish()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)

	self._sceneGo = self:getCurScene().level:getSceneGo()
	self._fogRoot = gohelper.create3d(self._sceneGo, "FogRoot")

	local fogRes = SurvivalMapHelper.instance:getBlockRes(SurvivalShelterSceneFogComp.FogResPath)

	if not fogRes then
		return
	end

	local rainEffectRoot = gohelper.findChild(self._sceneGo, "virtualCameraXZ/ocean")

	self._rainGo = gohelper.create3d(rainEffectRoot, "survival_rain")
	self._rainTrans = self._rainGo and self._rainGo.transform
	self._fogGo = gohelper.clone(fogRes, self._fogRoot)
	self._fogComp = self._fogGo:GetComponent(typeof(ZProj.SurvivalFog))
	self._rainEntity = MonoHelper.addNoUpdateLuaComOnceToGo(self._fogGo, SurvivalRainEntity, {
		effectRoot = self._rainGo,
		onLoadedFunc = self.onRainLoaded,
		callBackContext = self
	})

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self._rainEntity:setCurRain(weekInfo.rainType)
	self:setFogSize()
	self:setRainEnable(true)
end

function SurvivalShelterSceneFogComp:onRainLoaded()
	self:dispatchEvent(SurvivalEvent.OnSurvivalFogLoaded)
end

function SurvivalShelterSceneFogComp:setRainEnable(enable)
	if not self._fogComp then
		return
	end

	self:setFogEnable(false)

	if not enable then
		self._nowCircle = nil

		return
	end

	local shelterMapId = SurvivalConfig.instance:getCurShelterMapId()
	local shelterMapConfig = lua_survival_shelter.configDict[shelterMapId]
	local posList = string.splitToNumber(shelterMapConfig.stormCenter, "#")
	local pos = SurvivalHexNode.New(posList[1], posList[2])

	self:setRainDis(pos, shelterMapConfig.stormArea)
end

function SurvivalShelterSceneFogComp:setFogSize()
	if not self._fogComp then
		return
	end

	local mapCo = SurvivalConfig.instance:getShelterMapCo()

	self._fogComp:SetCenterAndSize(mapCo.maxX - mapCo.minX + 1, mapCo.maxY - mapCo.minY + 1, (mapCo.maxX + mapCo.minX) / 2, (mapCo.maxY + mapCo.minY) / 2)
	self._fogComp:UpdateBoudingBoxData()
end

function SurvivalShelterSceneFogComp:setBlockStatu(mr, isInFog, isInRain)
	if not self._fogComp then
		return
	end

	if isInFog ~= nil then
		self._fogComp:SetClearFogFlag(mr, not isInFog)
	end
end

function SurvivalShelterSceneFogComp:setFogEnable(isEnable)
	if not self._fogComp then
		return
	end

	self._fogComp:SetFogToggle(isEnable)
end

function SurvivalShelterSceneFogComp:setRainDis(centerPos, distance)
	if not self._fogComp then
		return
	end

	self.centerPos = centerPos

	if self._nowCircle == distance then
		return
	end

	if not self._nowCircle then
		self:frameSetCircle(distance)
	else
		self:killCirCleTween()

		self._circleTweenId = ZProj.TweenHelper.DOTweenFloat(self._nowCircle, distance, SurvivalConst.PlayerMoveSpeed * math.abs(self._nowCircle - distance), self.frameSetCircle, nil, self)
	end

	self._nowCircle = distance
end

function SurvivalShelterSceneFogComp:killCirCleTween()
	if self._circleTweenId then
		ZProj.TweenHelper.KillById(self._circleTweenId)

		self._circleTweenId = nil
	end
end

function SurvivalShelterSceneFogComp:frameSetCircle(value)
	self._fogComp:SetRainHex(self.centerPos.q, self.centerPos.r, self.centerPos.s, value)
end

function SurvivalShelterSceneFogComp:updateTexture()
	if not self._fogComp then
		return
	end

	self._fogComp:UpdateTexture()
end

function SurvivalShelterSceneFogComp:updateCenterPos(pos)
	if not self._rainTrans then
		return
	end

	local _, y, _ = transformhelper.getLocalPos(self._rainTrans)

	transformhelper.setLocalPos(self._rainTrans, pos.x, y, pos.z)
end

function SurvivalShelterSceneFogComp:onSceneClose()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
	self:killCirCleTween()

	if self._fogGo then
		gohelper.destroy(self._fogGo)

		self._fogGo = nil
		self._fogComp = nil
	end

	if self._fogRoot then
		gohelper.destroy(self._fogRoot)

		self._fogRoot = nil
	end

	self._sceneGo = nil
	self._rainGo = nil
	self._rainTrans = nil
	self._nowCircle = nil

	if self._rainEntity then
		self._rainEntity:onDestroy()

		self._rainEntity = nil
	end
end

return SurvivalShelterSceneFogComp
