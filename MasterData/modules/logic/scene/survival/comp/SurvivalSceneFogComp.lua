-- chunkname: @modules/logic/scene/survival/comp/SurvivalSceneFogComp.lua

module("modules.logic.scene.survival.comp.SurvivalSceneFogComp", package.seeall)

local SurvivalSceneFogComp = class("SurvivalSceneFogComp", BaseSceneComp)

SurvivalSceneFogComp.FogResPath = "survival/common/survialfog.prefab"
SurvivalSceneFogComp.OnLoaded = 1

function SurvivalSceneFogComp:init(sceneId, levelId)
	self._fogEnabled = true

	self:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
end

function SurvivalSceneFogComp:_onPreloadFinish()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)

	self._sceneGo = self:getCurScene().level:getSceneGo()
	self._fogRoot = gohelper.create3d(self._sceneGo, "FogRoot")

	local fogRes = SurvivalMapHelper.instance:getBlockRes(SurvivalSceneFogComp.FogResPath)

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

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if sceneMo._mapInfo.rainCo then
		if not sceneMo._mapInfo.rainCo.type then
			local rainId = 1

			self._rainEntity:setCurRain(rainId)
			self:setFogSize()
			self:setRainDis()

			if not self._fogEnabled then
				self:setFogEnable(false)
			end
		end
	end
end

function SurvivalSceneFogComp:onRainLoaded()
	self:dispatchEvent(SurvivalEvent.OnSurvivalFogLoaded)
end

function SurvivalSceneFogComp:setFogSize()
	if not self._fogComp then
		return
	end

	local mapCo = SurvivalMapModel.instance:getCurMapCo()

	self._fogComp:SetCenterAndSize(mapCo.maxX - mapCo.minX + 1, mapCo.maxY - mapCo.minY + 1, (mapCo.maxX + mapCo.minX) / 2, (mapCo.maxY + mapCo.minY) / 2)
	self._fogComp:UpdateBoudingBoxData()
end

function SurvivalSceneFogComp:setBlockStatu(mr, isInFog, isInRain)
	if not self._fogComp then
		return
	end

	if isInFog ~= nil then
		self._fogComp:SetClearFogFlag(mr, not isInFog)
	end
end

function SurvivalSceneFogComp:setFogEnable(isEnable)
	self._fogEnabled = isEnable

	if not self._fogComp then
		return
	end

	self._fogComp:SetFogToggle(isEnable)
	gohelper.setActive(self._fogComp, isEnable)

	if not isEnable then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()

		if sceneMo then
			self:frameSetCircle(sceneMo.circle)
		end
	end

	if not isEnable then
		self:killCirCleTween()
	end
end

function SurvivalSceneFogComp:setRainDis()
	if not self._fogComp then
		return
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if self._nowCircle == sceneMo.circle then
		return
	end

	self:killCirCleTween()

	if not self._nowCircle or not self._fogEnabled then
		self:frameSetCircle(sceneMo.circle)

		if not self._fogEnabled then
			self:setFogEnable(false)
		end
	else
		self._circleTweenId = ZProj.TweenHelper.DOTweenFloat(self._nowCircle, sceneMo.circle, SurvivalConst.PlayerMoveSpeed * math.abs(self._nowCircle - sceneMo.circle), self.frameSetCircle, nil, self)
	end

	self._nowCircle = sceneMo.circle
end

function SurvivalSceneFogComp:killCirCleTween()
	if self._circleTweenId then
		ZProj.TweenHelper.KillById(self._circleTweenId)

		self._circleTweenId = nil
	end
end

function SurvivalSceneFogComp:frameSetCircle(value)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	self._fogComp:SetRainHex(sceneMo.exitPos.q, sceneMo.exitPos.r, sceneMo.exitPos.s, value)
end

function SurvivalSceneFogComp:updateTexture()
	if not self._fogComp then
		return
	end

	self._fogComp:UpdateTexture()
end

function SurvivalSceneFogComp:updateCenterPos(pos)
	if not self._rainTrans then
		return
	end

	local _, y, _ = transformhelper.getLocalPos(self._rainTrans)

	transformhelper.setLocalPos(self._rainTrans, pos.x, y, pos.z)
end

function SurvivalSceneFogComp:onSceneClose()
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

return SurvivalSceneFogComp
