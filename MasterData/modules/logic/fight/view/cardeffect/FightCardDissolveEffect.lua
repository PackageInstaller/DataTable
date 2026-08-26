-- chunkname: @modules/logic/fight/view/cardeffect/FightCardDissolveEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardDissolveEffect", package.seeall)

local FightCardDissolveEffect = class("FightCardDissolveEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033
local MeshGOName = "CardItemMeshs"
local MainTex_ID = "_MainTex"
local KeyWorkVariant = "UNITY_UI_DISSOLVE"
local KeyWork = "_UseUIDissolve"
local DissolveParam = {
	"_DissolveOffset",
	"Vector4",
	Vector4.New(0, 25, 3.35, 0),
	Vector4.New(1.3, 25, 3.35, 0)
}

function FightCardDissolveEffect:onStart(context)
	FightCardDissolveEffect.super.onStart(self, context)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	self._dt = dt / FightModel.instance:getUISpeed()
	self._cloneItemGOs = {}

	local uiMeshAssetItem = FightGameMgr.loaderMgr:getAsset(FightPreloadOthersWork.ui_mesh).assetItem
	local uiMeshPrefab = uiMeshAssetItem:GetResource(FightPreloadOthersWork.ui_mesh)
	local matAssetItem = FightGameMgr.loaderMgr:getAsset(FightPreloadOthersWork.ui_effectsmat).assetItem
	local uiEffectMat = matAssetItem:GetResource(FightPreloadOthersWork.ui_effectsmat)

	self._mats = {}
	self._cloneMats = {}
	self._meshGOs = {}
	self._renderers = {}
	self._txtList = {}

	for _, skillItemGO in ipairs(context.dissolveSkillItemGOs) do
		local cloneSkillItemGO = gohelper.cloneInPlace(skillItemGO)

		gohelper.setActive(skillItemGO, false)
		table.insert(self._cloneItemGOs, cloneSkillItemGO)
		self:_hideEffect(cloneSkillItemGO)

		local imgList = cloneSkillItemGO:GetComponentsInChildren(gohelper.Type_Image, false)
		local imageGoList = {}

		for i = 0, imgList.Length - 1 do
			local img = imgList[i]

			img.color.a = 1
			img.enabled = false

			if img.material == img.defaultMaterial then
				img.material = uiEffectMat

				table.insert(imageGoList, img)
			end
		end

		local textList = cloneSkillItemGO:GetComponentsInChildren(gohelper.Type_TextMesh, false)

		for i = 0, textList.Length - 1 do
			local text = textList[i]

			table.insert(self._txtList, text)
		end

		textList = cloneSkillItemGO:GetComponentsInChildren(gohelper.Type_Text, false)

		for i = 0, textList.Length - 1 do
			local text = textList[i]

			table.insert(self._txtList, text)
		end

		local meshGO = self:_setupMesh(imageGoList, uiMeshPrefab)

		table.insert(self._meshGOs, meshGO)

		local meshRenderList = meshGO:GetComponentsInChildren(typeof(UnityEngine.Renderer), false)

		for i = 0, meshRenderList.Length - 1 do
			local mat = meshRenderList[i].material

			table.insert(self._mats, mat)
			mat:EnableKeyword(KeyWorkVariant)
			mat:SetFloat(KeyWork, 1)
		end
	end

	self._flow = FlowSequence.New()

	self._flow:addWork(TweenWork.New({
		from = 0,
		type = "DOTweenFloat",
		to = 1,
		t = self._dt * 30,
		frameCb = self._tweenFrameFunc,
		cbObj = self
	}))
	self._flow:registerDoneListener(self._onWorkDone, self)
	self._flow:start()
end

function FightCardDissolveEffect:_tweenFrameFunc(value)
	if self._txtList then
		for _, txt in ipairs(self._txtList) do
			ZProj.UGUIHelper.SetColorAlpha(txt, math.max(1 - value * 2, 0))
		end
	end

	if self._mats then
		for _, mat in ipairs(self._mats) do
			local propName = DissolveParam[1]
			local propType = DissolveParam[2]
			local startValue = DissolveParam[3]
			local endValue = DissolveParam[4]
			local frameValue = MaterialUtil.getLerpValue(propType, startValue, endValue, value)

			MaterialUtil.setPropValue(mat, propName, propType, frameValue)
		end
	end
end

function FightCardDissolveEffect:_setupMesh(imgList, uiMeshPrefab)
	local unitCamera = CameraMgr.instance:getUnitCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local unitObjRotation = CameraMgr.instance:getCameraTraceGO().transform.rotation * Quaternion.Euler(0, 180, 0)
	local cameraDistance = self:getCameraDistance()
	local fovInRads = unitCamera.fieldOfView * Mathf.Deg2Rad
	local horizontalFov = Mathf.Tan(fovInRads * 0.5) * cameraDistance / UnityEngine.Screen.height
	local scaleFactorX, scaleFactorY = self:getScaleFactor()
	local meshGO = UnityEngine.GameObject.New()

	meshGO.name = MeshGOName
	meshGO.transform.parent = unitCamera.transform

	for i = 1, #imgList do
		local img = imgList[i]
		local imgTr = img.transform
		local cloneMat = UnityEngine.GameObject.Instantiate(img.material)

		table.insert(self._cloneMats, cloneMat)

		cloneMat.name = img.material.name .. "_clone"

		local sprite = img.sprite
		local texture = sprite and sprite.texture

		if not gohelper.isNil(texture) then
			cloneMat:SetTexture(MainTex_ID, img.sprite.texture)

			local totalSize = Vector2.New(img.sprite.texture.width, img.sprite.texture.height)
			local pos = img.sprite.textureRect.min
			local scale = img.sprite.textureRect.size
			local tilling = Vector2.New(scale.x / totalSize.x, scale.y / totalSize.y)
			local offset = Vector2.New(pos.x / totalSize.x, pos.y / totalSize.y)

			cloneMat:SetTextureOffset(MainTex_ID, offset)
			cloneMat:SetTextureScale(MainTex_ID, tilling)

			local imgMeshGO = gohelper.clone(uiMeshPrefab, meshGO, img.name)
			local imgMeshTr = imgMeshGO.transform

			gohelper.setLayer(imgMeshGO, UnityLayer.Unit, true)

			local renderer = imgMeshGO:GetComponent(typeof(UnityEngine.Renderer))

			renderer.sortingOrder = renderer.sortingOrder + i
			renderer.sharedMaterial = cloneMat

			table.insert(self._renderers, renderer)

			local pos = uiCamera:WorldToScreenPoint(imgTr.position)
			local posX = (UnityEngine.Screen.width - pos.x * 2) * horizontalFov
			local posY = (UnityEngine.Screen.height - pos.y * 2) * horizontalFov
			local scaX = scaleFactorX * imgTr.sizeDelta.x * ((not self.context.dissolveScale or nil) and 1)
			local scaY = scaleFactorY * imgTr.sizeDelta.y * ((not self.context.dissolveScale or nil) and 1)
			local localPosition = Vector3.New(-posX, -posY, cameraDistance) * 0.5

			imgMeshTr.localScale = Vector3.New(scaX, scaY, 1)
			imgMeshTr.rotation = unitObjRotation
			imgMeshTr.position = unitCamera.transform:TransformPoint(localPosition)
		end
	end

	return meshGO
end

function FightCardDissolveEffect:getScaleFactor()
	if self.wRate then
		return self.wRate, self.hRate
	end

	local unitCamera = CameraMgr.instance:getUnitCamera()
	local cameraDistance = self:getCameraDistance()
	local uiRoot = ViewMgr.instance:getUIRoot()
	local rectTr = uiRoot:GetComponent(gohelper.Type_RectTransform)
	local curPixelWidth, curPixelHeight = recthelper.getWidth(rectTr), recthelper.getHeight(rectTr)
	local curRate = curPixelWidth / curPixelHeight
	local fovInRads = unitCamera.fieldOfView * Mathf.Deg2Rad * 0.5
	local tan_FovInRads = Mathf.Tan(fovInRads)
	local unitCameraHeight = tan_FovInRads * cameraDistance
	local unitCameraWidth = curRate * unitCameraHeight

	self.wRate, self.hRate = unitCameraWidth / curPixelWidth, unitCameraHeight / curPixelHeight

	return self.wRate, self.hRate
end

function FightCardDissolveEffect:onStop()
	FightCardDissolveEffect.super.onStop(self)

	if self._flow then
		self._flow:unregisterDoneListener(self._onWorkDone, self)

		if self._flow.status == WorkStatus.Running then
			self._flow:stop()
		end
	end
end

function FightCardDissolveEffect:_onWorkDone()
	self:onDone(true)
end

function FightCardDissolveEffect:clearWork()
	if self._cloneMats then
		for i = 1, #self._cloneMats do
			gohelper.destroy(self._cloneMats[i])

			self._cloneMats[i] = nil
		end
	end

	if self._cloneItemGOs then
		for i = 1, #self._cloneItemGOs do
			gohelper.destroy(self._cloneItemGOs[i])

			self._cloneItemGOs[i] = nil
		end
	end

	if self._meshGOs then
		for i = 1, #self._meshGOs do
			gohelper.destroy(self._meshGOs[i])

			self._meshGOs[i] = nil
		end
	end

	if self._mats then
		for i = 1, #self._mats do
			self._mats[i] = nil
		end
	end

	if self._txtList then
		for i = 1, #self._txtList do
			self._txtList[i] = nil
		end
	end

	if self._renderers then
		for i = 1, #self._renderers do
			gohelper.destroy(self._renderers[i].material)

			self._renderers[i] = nil
		end
	end

	if self._flow then
		self._flow:unregisterDoneListener(self._onWorkDone, self)
		self._flow:stop()

		self._flow = nil
	end

	self._cloneMats = nil
	self._cloneItemGOs = nil
	self._meshGOs = nil
	self._mats = nil
	self._renderers = nil
end

function FightCardDissolveEffect.clear()
	local unitCameraTrs = CameraMgr.instance:getUnitCameraTrs()
	local toRemoveList
	local childCount = unitCameraTrs.childCount

	for i = 1, childCount do
		local child = unitCameraTrs:GetChild(i - 1)

		if child.name == MeshGOName then
			toRemoveList = toRemoveList or {}

			table.insert(toRemoveList, child)
		end
	end

	if toRemoveList then
		for _, child in ipairs(toRemoveList) do
			gohelper.destroy(child.gameObject)
		end
	end
end

function FightCardDissolveEffect:getCameraDistance()
	if self.cameraDistance then
		return self.cameraDistance
	end

	local unitCamera = CameraMgr.instance:getUnitCamera()
	local uiRoot = ViewMgr.instance:getUIRoot()

	self.cameraDistance = math.abs(unitCamera.transform.position.z - uiRoot.transform.position.z)

	return self.cameraDistance
end

function FightCardDissolveEffect:_hideEffect(cloneSkillItemGO)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "foranim/lock"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "lock"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "ui_dazhaoka(Clone)"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "foranim/card/ui_dazhaoka(Clone)"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "foranim/card/predisplay"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "vx_balance"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "foranim/card/lv1/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "foranim/card/lv2/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "foranim/card/lv3/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "foranim/card/lv4/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "cardmask"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "cardAppearEffectRoot"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "lvChangeEffect"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "foranim/cardConvertEffect"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "layout"), false)
	gohelper.setActive(gohelper.findChild(cloneSkillItemGO, "foranim/restrain"), false)
end

return FightCardDissolveEffect
