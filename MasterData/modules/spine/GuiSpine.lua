-- chunkname: @modules/spine/GuiSpine.lua

module("modules.spine.GuiSpine", package.seeall)

local GuiSpine = class("GuiSpine", BaseSpine)
local imgMatPath = "spine/spine_ui_image.mat"
local rtSrcMatPath = "spine/spine_ui_rt_source.mat"

GuiSpine.TypeSkeletonGraphic = typeof(Spine.Unity.SkeletonGraphic)
GuiSpine.TypeUISpineAnimationEvent = typeof(ZProj.UISpineAnimationEvent)

function GuiSpine.Create(gameObj, isStory)
	local ret = MonoHelper.addNoUpdateLuaComOnceToGo(gameObj, GuiSpine)

	ret._isStory = isStory

	return ret
end

function GuiSpine:initSkeletonComponent()
	self._skeletonComponent = self._spineGo:GetComponent(GuiSpine.TypeSkeletonGraphic)

	self._skeletonComponent:Initialize(false)

	self._skeletonComponent.freeze = self._bFreeze
	self._skeletonComponent.startingLoop = false
	self._skeletonComponent.PhysicsPositionInheritanceFactor = Vector2.New(0, 0)
	self._animationEvent = GuiSpine.TypeUISpineAnimationEvent
end

function GuiSpine:getSkeletonGraphic()
	return self._skeletonComponent
end

function GuiSpine:onDestroy()
	TaskDispatcher.cancelTask(self._updateMatProp, self)
	GuiSpine.super.onDestroy(self)

	if self._rawImageGo then
		gohelper.destroy(self._rawImageGo)
	end

	self:_disposeLoader()
	gohelper.destroy(self._imgMat)

	self._imgMat = nil
	self._uiMaskBuffer = nil
	self._useRT = nil
	self._imgWidth = nil
	self._imgHeight = nil
	self._imgPosX = nil
	self._imgPosY = nil
	self._imgParent = nil
	self._xialiRtMatPath = nil
	self._tttRtMatPath = nil
end

function GuiSpine:_clear()
	TaskDispatcher.cancelTask(self._updateMatProp, self)
	GuiSpine.super._clear(self)
end

function GuiSpine:_useScreenCenter(resPath)
	return string.find(resPath, "301702_xiali_p") or string.find(resPath, "303301_ttt_p") or string.find(resPath, "303302_ttt_p") or string.find(resPath, "303303_ttt_p") or string.find(resPath, "305901_door_p")
end

function GuiSpine:_onResLoaded()
	GuiSpine.super._onResLoaded(self)

	if self:_useScreenCenter(self._resPath) then
		self._mat = UnityEngine.Object.Instantiate(self._skeletonComponent.material)
		self._skeletonComponent.material = self._mat
		self._centerID = UnityEngine.Shader.PropertyToID("_ScreenCenter")
		self._posVec3 = Vector3()
		self._forceUpdateCount = 0

		TaskDispatcher.runRepeat(self._updateMatProp, self, 0)
	end

	if self._useRT then
		self._skeletonComponent.enabled = false

		self:_initImageAndMat()
	end
end

function GuiSpine:_disposeLoader()
	if self._guispineLoader then
		self._guispineLoader:dispose()

		self._guispineLoader = nil
	end
end

function GuiSpine:_initImageAndMat()
	self._rawImageGo = self._rawImageGo or UnityEngine.GameObject.New("spine_rawImage")

	local transform = self._rawImageGo.transform

	transform:SetParent(self._imgParent or self._gameTr.parent)
	gohelper.setAsFirstSibling(self._rawImageGo)
	self:_disposeLoader()

	self._guispineLoader = MultiAbLoader.New()

	self._guispineLoader:addPath(imgMatPath)

	if string.find(self._resPath, "301702_xiali_p") then
		self._xialiRtMatPath = "rolesstory/dynamic/301702_xiali_p_material_ui_rt_source.mat"

		self._guispineLoader:addPath(self._xialiRtMatPath)
	elseif string.find(self._resPath, "303301_ttt_p") then
		self._tttRtMatPath = "rolesstory/dynamic/303301_ttt_p_material_ui_rt_source.mat"

		self._guispineLoader:addPath(self._tttRtMatPath)
	elseif string.find(self._resPath, "303302_ttt_p") then
		self._tttRtMatPath = "rolesstory/dynamic/303302_ttt_p_material_ui_rt_source.mat"

		self._guispineLoader:addPath(self._tttRtMatPath)
	elseif string.find(self._resPath, "303303_ttt_p") then
		self._tttRtMatPath = "rolesstory/dynamic/303303_ttt_p_material_ui_rt_source.mat"

		self._guispineLoader:addPath(self._tttRtMatPath)
	else
		self._guispineLoader:addPath(rtSrcMatPath)
	end

	self._guispineLoader:startLoad(self._onSpineImgLoaderFinish, self)
end

function GuiSpine:_onSpineImgLoaderFinish()
	local imgMatAssetItem = self._guispineLoader:getAssetItem(imgMatPath)

	if imgMatAssetItem then
		self._imgMat = self._imgMat or UnityEngine.Object.Instantiate(imgMatAssetItem:GetResource())

		if self._uiMaskBuffer ~= nil then
			self:setImageUIMask(self._uiMaskBuffer)
		end

		local img = gohelper.onceAddComponent(self._rawImageGo, gohelper.Type_RawImage)

		gohelper.onceAddComponent(self._rawImageGo, typeof(ZProj.UISpineImage))

		local transform = self._rawImageGo.transform

		transformhelper.setLocalScale(transform, 0, 0, 0)

		if img then
			img.raycastTarget = false
			img.material = self._imgMat

			local root = ViewMgr:getUIRoot()

			if not self._imgWidth then
				local width = root.transform.sizeDelta.x

				if not self._imgHeight then
					local height = root.transform.sizeDelta.y

					recthelper.setSize(transform, width, height)
					transformhelper.setLocalScale(transform, 1, 1, 1)

					if not self._imgPosX then
						if self._imgPosY then
							transformhelper.setLocalPos(transform, self._imgPosX or transform.localPosition.x, self._imgPosY or transform.localPosition.y, transform.localPosition.z)
						end
					end
				end
			end
		end
	end

	local rtSrcMatAssetItem = self._guispineLoader:getAssetItem(self._tttRtMatPath or self._xialiRtMatPath or rtSrcMatPath)

	if rtSrcMatAssetItem then
		local rtSrcMat = UnityEngine.Object.Instantiate(rtSrcMatAssetItem:GetResource())

		if self:getSkeletonGraphic() then
			self:getSkeletonGraphic().material = rtSrcMat
		end

		if self._xialiRtMatPath then
			self._mat = self:getSkeletonGraphic().material

			TaskDispatcher.runRepeat(self._updateMatProp, self, 0)
		end

		if self._tttRtMatPath then
			self._mat = self:getSkeletonGraphic().material

			TaskDispatcher.runRepeat(self._updateMatProp, self, 0)
		end
	end

	if self._skeletonComponent then
		self._skeletonComponent.enabled = true
	end
end

function GuiSpine:setImgSize(width, height)
	self._imgWidth = width
	self._imgHeight = height
end

function GuiSpine:setImgParent(parent)
	self._imgParent = parent
end

function GuiSpine:setImgPos(posX, posY)
	self._imgPosX = posX
	self._imgPosY = posY
end

function GuiSpine:_updateMatProp()
	if gohelper.isNil(self._spineGo) then
		TaskDispatcher.cancelTask(self._updateMatProp, self)

		return
	end

	if self._spineGo and not self._spineGo.activeInHierarchy then
		self._forceUpdateCount = 2

		return
	end

	local x, y, z = transformhelper.getPos(self._spineTr)
	local sx, sy, sz = transformhelper.getLocalScale(self._spineTr.parent)

	if self._posVec3.x == x and self._posVec3.y == y and self._posVec3.z == z and sx == self._preScaleX and sy == self.preScaleY and self._forceUpdateCount == 0 then
		return
	end

	if self._forceUpdateCount > 0 then
		self._forceUpdateCount = self._forceUpdateCount - 1
	end

	self._posVec3.x = x
	self._posVec3.y = y
	self._posVec3.z = z
	self._preScaleX, self.preScaleY = sx, sy

	local root = ViewMgr.instance:getUIRoot()
	local scale, _, _ = transformhelper.getLocalScale(root.transform)
	local vec4 = Vector4(x / scale, y / scale, 1 / sx, 1 / sy)

	self._mat:SetVector(self._centerID, vec4)
end

function GuiSpine:_setKeyword(keywordName, isActive)
	if not self:getSkeletonGraphic() then
		return
	end

	local mat = self:getSkeletonGraphic().material

	if not mat then
		return
	end

	if isActive == true then
		mat:EnableKeyword(keywordName)
	else
		mat:DisableKeyword(keywordName)
	end
end

function GuiSpine:setUIMask(isActive)
	self:_setKeyword("_UIMASK_ON", isActive)
end

function GuiSpine:useRT()
	self._useRT = true
end

function GuiSpine:showModel()
	if self._rawImageGo then
		gohelper.setActive(self._rawImageGo, true)
	end
end

function GuiSpine:hideModel()
	if self._rawImageGo then
		gohelper.setActive(self._rawImageGo, false)
	end
end

function GuiSpine:setImageUIMask(isActive)
	if self._imgMat then
		if isActive == true then
			self._imgMat:EnableKeyword("_UIMASK_ON")
		else
			self._imgMat:DisableKeyword("_UIMASK_ON")
		end
	else
		self._uiMaskBuffer = isActive
	end
end

function GuiSpine:setFreezeState(isFreeze)
	self._bFreeze = isFreeze

	if not self._skeletonComponent then
		return
	end

	self._skeletonComponent.freeze = isFreeze
end

return GuiSpine
