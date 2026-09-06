-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petintroduction/view/NpcIntrodView.lua

module("logic.extensions.petintroduction.view.NpcIntrodView", package.seeall)

local NpcIntrodView = class("NpcIntrodView", ViewComponent)

function NpcIntrodView:buildUI()
	NpcIntrodView.super.buildUI(self)
	self:_initRoleInfos()
	self:_initAnimations()
end

function NpcIntrodView:_initRoleInfos()
	self._roleParent = self:getGo("RoleParent").transform
	self._name = self:getTxt("Info/Name")
	self._title = self:getTxt("Info/Title")
	self._txtDesc = self:getTxt("Info/Desc")
	self._camera = self:getGo("Camera"):GetComponent(ComponentType.Camera)
	self._rtDest = self:getGo("RTDest"):GetComponent(ComponentType.RawImage)
	self._clickMask = Framework.UIClickTrigger.Get(self:getGo("ClickMask"))
end

function NpcIntrodView:_initAnimations()
	local canvasGroup = typeof(UnityEngine.CanvasGroup)

	self._bg = self:getGo("Bg")
	self._clickContinue = self:getGo("ClickContinue")
	self._bgCanvasGroup = self._bg:GetComponent(canvasGroup)
	self._clickCanvasGroup = self._clickContinue:GetComponent(canvasGroup)
end

function NpcIntrodView:bindEvents()
	self._clickMask:AddClickListener(self._onClickMask, self)
end

function NpcIntrodView:unbindEvents()
	self._clickMask:RemoveClickListener()
end

function NpcIntrodView:onEnter()
	self._rendererTex = UnityEngine.RenderTexture.GetTemporary(UnityEngine.Screen.width, UnityEngine.Screen.height)
	self._camera.targetTexture = self._rendererTex
	self._rtDest.texture = self._rendererTex

	self:_updateRoleInfos()
end

function NpcIntrodView:_updateRoleInfos()
	local npcIntrodCo = PetIntroductionConfig.instance:getNpcIntrodMoById(self:getFirstParam())

	self:_updateRoleNpc(npcIntrodCo)

	local resPath = PetIntroductionConfig.instance:getNpcIntrodModelPathById(self:getFirstParam())
	local res = Framework.ResourceCache.Instance:GetResourceNoLoadIfNotExists(resPath)
	local mainAsset = res:GetMainAsset()

	self._gameObject = goutil.cloneAndSetParent(mainAsset, self._roleParent.transform)

	self:_updateTransform(npcIntrodCo)
	GoUtil.PlaySpineAnim(self._gameObject, "idle", true, true, true, 1)
end

function NpcIntrodView:_updateRoleNpc(npcIntrodCo)
	self._txtDesc.text = npcIntrodCo.desc
	self._title.text = npcIntrodCo.title
	self._name.text = npcIntrodCo.name
end

function NpcIntrodView:_updateTransform(npcIntrodCo)
	Framework.TransformUtil.SetLocalPos(self._gameObject.transform, npcIntrodCo.offsetX, npcIntrodCo.offsetY, 0)
	Framework.TransformUtil.SetLocalScale(self._gameObject.transform, npcIntrodCo.scale, npcIntrodCo.scale, npcIntrodCo.scale)
	Framework.GameObjectUtil.SetLayerRecursively(self._gameObject, SceneLayer.UI3D_Value)
end

function NpcIntrodView:onExit()
	UnityTweens.TweenEmpty.StopTween(self.mainGO)
end

function NpcIntrodView:onExitFinished()
	self._camera.targetTexture = nil
	self._rtDest.texture = nil

	if self._rendererTex then
		UnityEngine.RenderTexture.ReleaseTemporary(self._rendererTex)

		self._rendererTex = nil
	end

	if self._gameObject then
		goutil.destroy(self._gameObject)

		self._gameObject = nil
	end
end

function NpcIntrodView:_onClickMask()
	self:close()
end

return NpcIntrodView
