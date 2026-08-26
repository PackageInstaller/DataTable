-- chunkname: @modules/logic/scene/survival/entity/SurvivalRainEntity.lua

module("modules.logic.scene.survival.entity.SurvivalRainEntity", package.seeall)

local SurvivalRainEntity = class("SurvivalRainEntity", LuaCompBase)
local Shader = UnityEngine.Shader

function SurvivalRainEntity:ctor(param)
	self.onLoadedFunc = param.onLoadedFunc
	self.callBackContext = param.callBackContext
	self._param = param
end

function SurvivalRainEntity:init(go)
	self._rainComp = go:GetComponent("ZProj.SurvivalRain")
	self._rainComp.enabled = false
	self._rainLoader = PrefabInstantiate.Create((self._param or nil) and (self._param.effectRoot or go))
	self._textureLoader = SequenceAbLoader.New()

	if GameResMgr.IsFromEditorDir then
		local texturePaths = SLFramework.FileHelper.GetDirFilePaths("Assets/ZResourcesLib/survival/common/rain")

		if texturePaths then
			for i = 0, texturePaths.Length - 1 do
				local path = texturePaths[i]

				if string.sub(path, -4) == ".png" then
					local fileName = SLFramework.FileHelper.GetFileName(path, true)

					self._textureLoader:addPath("survival/common/rain/" .. fileName)
				end
			end
		end
	else
		self._textureLoader:addPath("survival/common/rain")
	end

	self._textureLoader:startLoad(self._onAbLoaded, self)
end

function SurvivalRainEntity:onStart()
	self._inited = true

	self:_setRainParam()
end

function SurvivalRainEntity:_onAbLoaded()
	self._abLoaded = true

	self:_setRainParam()

	if self.onLoadedFunc then
		self.onLoadedFunc(self.callBackContext)
	end
end

function SurvivalRainEntity:setCurRain(rainId)
	if not self._rainLoader then
		return
	end

	if self._rainId == rainId then
		return
	end

	local preRainId = self._rainId

	self._rainId = rainId

	if self._inited and self._abLoaded then
		self:_resetParam(preRainId)
		self:_setRainParam()
	end
end

function SurvivalRainEntity:_setRainParam()
	if not self._rainId or not self._inited or not self._abLoaded then
		return
	end

	local rainParam = SurvivalRainParam[self._rainId]

	if not rainParam then
		return
	end

	Shader.DisableKeyword("_SURVIAL_SCENE")
	Shader.DisableKeyword("_ENABLE_SURVIVAL_RAIN_DISTORTION")
	Shader.DisableKeyword("_ENABLE_SURVIVAL_RAIN_GLITCH")
	self:applyRainParam()

	self._allTextRef = self._allTextRef or self:getUserDataTb_()

	for k, v in pairs(rainParam) do
		local func = SurvivalRainParam.ParamToShaderFunc[k]

		if func == Shader.SetGlobalTexture then
			local texture = self:getTexture(v)

			self._allTextRef[k] = texture

			if texture then
				func(k, texture)
			end
		elseif func then
			func(k, v)
		end
	end

	if rainParam.KeyWord then
		Shader.EnableKeyword(rainParam.KeyWord)
	end

	local path = string.format("survival/common/rain/survival_rain%d.prefab", self._rainId)

	if self._rainLoader:getPath() ~= path then
		self._rainLoader:dispose()
		self._rainLoader:startLoad(path)
	end
end

function SurvivalRainEntity:applyRainParam()
	self._rainComp:UpdateRainSetting()
end

function SurvivalRainEntity:getTexture(fileName)
	local resPath = "survival/common/rain/" .. fileName .. ".png"
	local assetItem = GameResMgr.IsFromEditorDir and self._textureLoader:getAssetItem(resPath) or self._textureLoader:getAssetItem("survival/common/rain")

	if not assetItem then
		logError("没有资源文件" .. resPath)

		return
	end

	return assetItem:GetResource(resPath)
end

function SurvivalRainEntity:_resetParam()
	Shader.DisableKeyword("_SURVIAL_SCENE")
	Shader.DisableKeyword("_ENABLE_SURVIVAL_RAIN_DISTORTION")
	Shader.DisableKeyword("_ENABLE_SURVIVAL_RAIN_GLITCH")
end

function SurvivalRainEntity:onDestroy()
	TaskDispatcher.cancelTask(self._setRainParam, self)

	for id, func in pairs(SurvivalRainParam.ParamToShaderFunc) do
		if func == Shader.SetGlobalTexture then
			Shader.SetGlobalTexture(id, nil)
		end
	end

	self:_resetParam()

	self._rainId = nil

	if self._rainLoader then
		self._rainLoader:dispose()

		self._rainLoader = nil
	end

	if self._textureLoader then
		self._textureLoader:dispose()

		self._textureLoader = nil
	end
end

return SurvivalRainEntity
