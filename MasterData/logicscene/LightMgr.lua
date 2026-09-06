-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/light/LightMgr.lua

module("logicscene.scene.light.LightMgr", package.seeall)

local LightMgr = class("LightMgr")

LightMgr.LightType = {
	FarSceneLight = 2,
	NearSceneLight = 1,
	UILight = 3,
	NormalSceneLight = 4
}

function LightMgr:ctor()
	self._lightParam = {
		[LightMgr.LightType.NearSceneLight] = {
			_intensity = 0.9,
			_shadowDistance = 3,
			_pos = {
				5,
				0,
				0
			},
			_rotation = {
				22,
				360,
				164
			}
		},
		[LightMgr.LightType.FarSceneLight] = {
			_intensity = 0.8,
			_shadowDistance = 6,
			_pos = {
				5,
				0,
				0
			},
			_rotation = {
				22,
				325,
				164
			}
		},
		[LightMgr.LightType.UILight] = {
			_intensity = 0.9,
			_shadowDistance = 6,
			_pos = {
				5,
				0,
				0
			},
			_rotation = {
				22,
				0,
				164
			}
		},
		[LightMgr.LightType.NormalSceneLight] = {
			_intensity = 1,
			_shadowDistance = 6,
			_pos = {
				0,
				3,
				0
			},
			_rotation = {
				35,
				14,
				0
			}
		}
	}
	self._useModelLight = false
end

function LightMgr:clear()
	return
end

function LightMgr:setLightParam(_lightType)
	if not _lightType then
		error("_lightType is nil")

		return
	end

	local _dirLight = goutil.find("Directional light")

	if _dirLight then
		local _pos = self._lightParam[_lightType]._pos
		local _rotation = self._lightParam[_lightType]._rotation

		GameUtil.setLocalPos(_dirLight, _pos[1], _pos[2], _pos[3])
		Framework.TransformUtil.SetLocalRotation(_dirLight.transform, _rotation[1], _rotation[2], _rotation[3])

		if self._lightParam[_lightType]._intensity then
			local _dirLightComp = _dirLight:GetComponent("Light")

			_dirLightComp.intensity = self._lightParam[_lightType]._intensity
		end

		if self._lightParam[_lightType]._shadowDistance then
			UnityEngine.QualitySettings.shadowDistance = self._lightParam[_lightType]._shadowDistance
		end
	end
end

function LightMgr:_changeLightTransInterpolation(_light, _pos, _rotation)
	if not _light then
		return
	end

	if _pos then
		local _oldPos = GameUtil.getLocalPos(_light)

		print("crcrcr _oldPos:", _oldPos.x, _oldPos.y, _oldPos.z)

		if _oldPos.x ~= _pos[1] or _oldPos.y ~= _pos[2] or _oldPos.z ~= _pos[3] then
			UnityTweens.TweenPosition.StartTween(_light, _oldPos, Vector3.New(_pos[1], _pos[2], _pos[3]), 0.5, UnityTweens.EaseType.easeInSine)
		end
	end

	if _rotation then
		local _oldRotationX, _oldRotationY, _oldRotationZ = Framework.TransformUtil.GetLocalRotation(_light.transform, 0, 0, 0)

		print("crcrcr _oldRotationX, _oldRotationY, _oldRotationZ:", _oldRotationX, _oldRotationY, _oldRotationZ)

		if _oldRotationX ~= _rotation[1] or _oldRotationY ~= _rotation[2] or _oldRotationZ ~= _rotation[3] then
			UnityTweens.TweenRotate.StartTween(_light, Vector3.New(_oldRotationX, _oldRotationY, _oldRotationZ), Vector3.New(_rotation[1], _rotation[2], _rotation[3]), 0.5)
		end
	end
end

function LightMgr:setLightForCreateRole()
	UnityEngine.QualitySettings.shadows = UnityEngine.ShadowQuality.All
	UnityEngine.QualitySettings.shadowCascades = 2
	self._shadowResolution = UnityEngine.QualitySettings.shadowResolution
	UnityEngine.QualitySettings.shadowResolution = UnityEngine.ShadowResolution.High
	self._shadowDistance = UnityEngine.QualitySettings.shadowDistance
	UnityEngine.QualitySettings.shadowDistance = 6

	local quality = HardwareQuality._autoComputeQuality()

	if quality and quality ~= HardwareQuality.LOW then
		print("return quality === ", quality, HardwareQuality.getQualityLevel())
		HardwareQuality.setRuntimeAntiAliasing(2)
	end

	self._pixelLightCount = UnityEngine.QualitySettings.pixelLightCount
	UnityEngine.QualitySettings.pixelLightCount = 2
	UnityEngine.QualitySettings.shadowProjection = UnityEngine.ShadowProjection.CloseFit

	local _dirLight = goutil.find("Directional light")

	if _dirLight then
		print("crcrcr light _setLightForCreateRole  310")

		local _pos = self._lightParam[LightMgr.LightType.FarSceneLight]._pos
		local _rotation = self._lightParam[LightMgr.LightType.FarSceneLight]._rotation

		GameUtil.setLocalPos(_dirLight, _pos[1], _pos[2], _pos[3])
		Framework.TransformUtil.SetLocalRotation(_dirLight.transform, _rotation[1], _rotation[2], _rotation[3])

		local _dirLightComp = _dirLight:GetComponent("Light")

		_dirLightComp.shadows = UnityEngine.LightShadows.Soft
		_dirLightComp.shadowStrength = 0.2
		_dirLightComp.shadowBias = 0
		_dirLightComp.shadowNormalBias = 0
		_dirLightComp.shadowNearPlane = 0.1
		_dirLightComp.color = Color.New(0.9019607843137255, 0.8705882352941177, 0.8941176470588236, 1)
		_dirLightComp.intensity = self._lightParam[LightMgr.LightType.FarSceneLight]._intensity
	end
end

function LightMgr:setLightForNormalScene(_fromCreateRole)
	if _fromCreateRole then
		UnityEngine.QualitySettings.shadows = UnityEngine.ShadowQuality.Disable
		UnityEngine.QualitySettings.shadowCascades = 0

		if self._shadowResolution then
			UnityEngine.QualitySettings.shadowResolution = self._shadowResolution
		end

		if self._shadowDistance then
			UnityEngine.QualitySettings.shadowDistance = self._shadowDistance
		end

		HardwareQuality.setRuntimeAntiAliasing(0)

		UnityEngine.QualitySettings.pixelLightCount = self._pixelLightCount or 1
		UnityEngine.QualitySettings.shadowProjection = UnityEngine.ShadowProjection.StableFit

		local _dirLight = goutil.find("Directional light")

		if _dirLight then
			print("crcrcr light _setLightForNormalScene  14")

			local _pos = self._lightParam[LightMgr.LightType.NormalSceneLight]._pos
			local _rotation = self._lightParam[LightMgr.LightType.NormalSceneLight]._rotation

			GameUtil.setLocalPos(_dirLight, _pos[1], _pos[2], _pos[3])
			Framework.TransformUtil.SetLocalRotation(_dirLight.transform, _rotation[1], _rotation[2], _rotation[3])

			local _dirLightComp = _dirLight:GetComponent("Light")

			_dirLightComp.shadows = UnityEngine.LightShadows.None
			_dirLightComp.color = Color.New(1, 1, 1, 1)
			_dirLightComp.intensity = self._lightParam[LightMgr.LightType.NormalSceneLight]._intensity or 1
		end
	else
		local _dirLight = goutil.find("Directional light")

		if _dirLight then
			local _pos = self._lightParam[LightMgr.LightType.NormalSceneLight]._pos
			local _rotation = self._lightParam[LightMgr.LightType.NormalSceneLight]._rotation

			GameUtil.setLocalPos(_dirLight, _pos[1], _pos[2], _pos[3])
			Framework.TransformUtil.SetLocalRotation(_dirLight.transform, _rotation[1], _rotation[2], _rotation[3])

			local _dirLightComp = _dirLight:GetComponent("Light")

			_dirLightComp.intensity = self._lightParam[LightMgr.LightType.NormalSceneLight]._intensity or 1
		end
	end
end

function LightMgr:operPostSwitch(_switch)
	local _mainCameraGO = goutil.find("createrolecamera") or goutil.find("MainCamera")

	if _mainCameraGO then
		local _post = _mainCameraGO:GetComponent(typeof(UnityEngine.PostProcessing.PostProcessingBehaviour))

		if _post then
			_post.enabled = _switch
		end
	end
end

function LightMgr:operBattleScenePostSwitch(_switch)
	local _skillCameraGO = goutil.find("SkillCamera")

	if _skillCameraGO then
		local _post = _skillCameraGO:GetComponent(typeof(UnityEngine.PostProcessing.PostProcessingBehaviour))

		if _post then
			_post.enabled = _switch
		end
	end
end

function LightMgr:operAllPostSwitch(_switch)
	self:operBattleScenePostSwitch(_switch)
end

function LightMgr:setUseModelLight(useModelLight)
	self._useModelLight = useModelLight
end

function LightMgr:getUseModelLight()
	return self._useModelLight
end

LightMgr.instance = LightMgr.New()

return LightMgr
