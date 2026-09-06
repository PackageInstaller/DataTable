-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneEffDistort.lua

module("logicscene.scene.SceneEffDistort", package.seeall)

local SceneEffDistort = class("SceneEffDistort")
local skillEffsLayer = Framework.LayerUtil.GetLayerMask(SceneLayer.SkillEffects_Value, SceneLayer.SkillEffects_II_Value)
local skillEff_I_Layer = Framework.LayerUtil.GetLayerMask(SceneLayer.SkillEffects_Value)
local skillEff_II_Layer = Framework.LayerUtil.GetLayerMask(SceneLayer.SkillEffects_II_Value)
local typeOfAMMirrorCamera = typeof(AMMirrorCamera)

function SceneEffDistort:ctor(cameraGo)
	self._cameraGo = cameraGo
	self._distortCamGo = nil
	self._distortCam = nil
	self._refCount = 0
	self._renderTexture = nil
end

function SceneEffDistort:startDistort(unit)
	if self._distortCamGo == nil then
		self._distortCamGo = UnityEngine.GameObject.New(self._cameraGo.name .. "_Distort")
	end

	if self._renderTexture == nil then
		self._renderTexture = UnityEngine.RenderTexture.GetTemporary(UnityEngine.Screen.width, UnityEngine.Screen.height)
	end

	if not self._distortCam then
		local camera = self._cameraGo:GetComponent(ComponentType.Camera)
		local distortCam = self._distortCamGo:GetComponent(ComponentType.Camera)

		if distortCam == nil then
			distortCam = self._distortCamGo:AddComponent(ComponentType.Camera)
		end

		distortCam.cullingMask = camera.cullingMask
		distortCam.orthographic = camera.orthographic
		distortCam.orthographic = camera.orthographic
		distortCam.orthographicSize = camera.orthographicSize
		distortCam.allowHDR = false
		distortCam.allowMSAA = false
		distortCam.fieldOfView = camera.fieldOfView
		distortCam.nearClipPlane = camera.nearClipPlane
		distortCam.farClipPlane = camera.farClipPlane
		distortCam.clearFlags = camera.clearFlags
		distortCam.depth = camera.depth - 0.05
		distortCam.targetTexture = self._renderTexture

		if self._cameraGo.name == "MainCamera" then
			distortCam.cullingMask = Framework.LayerUtil.GetLayerMask(SceneLayer.Default, SceneLayer.Ground3D, "TransparentFX", SceneLayer.Unit, SceneLayer.MainPlayer, SceneLayer.InteractiveObject, SceneLayer.SceneElem)
			distortCam.backgroundColor = Color.New(0, 0, 0, 0)
		elseif distortCam.cullingMask == skillEffsLayer or distortCam.cullingMask == skillEff_I_Layer or distortCam.cullingMask == skillEff_II_Layer then
			local compMirrorCamera = self._distortCamGo:GetComponent(typeOfAMMirrorCamera)

			if not compMirrorCamera then
				self._distortCamGo:AddComponent(typeOfAMMirrorCamera)
			end

			local rightTeamId = BattleModel.instance:getRightTeamId()

			GoUtil.TryMirrorFlipCamera(self._distortCamGo, unit.teamId == rightTeamId)
		end

		self._distortCam = distortCam
	end

	AMFollowTarget.BeginFollow(self._distortCamGo, self._cameraGo.transform, 0, 0, 0, 0, 0, true, true, true, true, 0, 0, true, false, false, false, true)
	UnityEngine.Shader.SetGlobalTexture("_DistortBaseMap", self._renderTexture)
end

function SceneEffDistort:addRef()
	self._refCount = self._refCount + 1
end

function SceneEffDistort:releaseRef()
	self._refCount = self._refCount - 1
end

function SceneEffDistort:getRef()
	return self._refCount
end

function SceneEffDistort:stopDistort()
	UnityEngine.Shader.SetGlobalTexture("_DistortBaseMap", nil)

	if self._renderTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(self._renderTexture)

		self._renderTexture = nil
	end

	if self._distortCam then
		self._distortCam.targetTexture = nil
		self._distortCam = nil
	end

	if self._distortCamGo then
		UnityEngine.GameObject.DestroyImmediate(self._distortCamGo)

		self._distortCamGo = nil
	end

	self._refCount = 0
	self._cameraGo = nil
end

return SceneEffDistort
