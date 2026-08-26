-- chunkname: @modules/ugui/icon/common/CommonLiveHeadIcon.lua

module("modules.ugui.icon.common.CommonLiveHeadIcon", package.seeall)

local CommonLiveHeadIcon = class("CommonLiveHeadIcon", LuaCompBase)

function CommonLiveHeadIcon:init(simageheadicon)
	self._simageHeadIcon = simageheadicon
	self._imageComp = self._simageHeadIcon.gameObject:GetComponent(gohelper.Type_Image)
end

function CommonLiveHeadIcon:setLiveHead(itemId, setNativeSize, isParallel, callBack, callBackObj)
	itemId = tonumber(itemId)
	setNativeSize = not not setNativeSize
	isParallel = not not isParallel

	if not itemId then
		return
	end

	local config = lua_item.configDict[itemId]

	if config == nil then
		return
	end

	local portraitId = tonumber(config.icon)
	local isDynamic = config.isDynamic == IconMgrConfig.HeadIconType.Dynamic

	self.isDynamic = isDynamic
	self.setNativeSize = setNativeSize
	self.isParallel = isParallel
	self.isGray = false

	if self.portraitId and self.portraitId == portraitId then
		self:syncAnimationTime()
		self:calculateSize()

		if callBack and callBackObj then
			callBack(callBackObj, self)
		end

		return
	end

	self._loader = self._loader or PrefabInstantiate.Create(self._simageHeadIcon.gameObject)

	if not gohelper.isNil(self._dynamicIconObj) then
		logNormal("destroy liveHead icon" .. tostring(self._dynamicIconObj.name))
		self:removeHeadLiveIcon()
		self._loader:dispose()

		self.animation = nil
	elseif self._loader:getPath() then
		self._loader:dispose()
	end

	self.portraitId = portraitId
	self.callBack = callBack
	self.callBackObj = callBackObj

	if not isDynamic then
		logNormal("set static icon portraitId: " .. tostring(portraitId))
		self._simageHeadIcon:LoadImage(ResUrl.getPlayerHeadIcon(portraitId), self._onStaticLoadCallBack, self)
	else
		logNormal("set dynamic icon portraitId: " .. tostring(portraitId))
		self:setDynamicIcon(portraitId)
	end
end

function CommonLiveHeadIcon:setDynamicIcon(portraitId)
	self.portraitId = portraitId

	local framePath = ResUrl.getLiveHeadIconPrefab(portraitId)

	self._loader:startLoad(framePath, self._onLoadCallBack, self)
end

function CommonLiveHeadIcon:_onStaticLoadCallBack()
	if self.setNativeSize then
		self._imageComp:SetNativeSize()
	end

	self:invokeCallBack()
end

function CommonLiveHeadIcon:_onLoadCallBack()
	self:reInitComp()
	self:syncAnimationTime()
	self:setMaterial()
	self:calculateSize()
	self:invokeCallBack()
end

function CommonLiveHeadIcon:reInitComp()
	self._dynamicIconObj = self._loader:getInstGO()
	self._root = gohelper.findChild(self._dynamicIconObj, "root")
	self.animation = gohelper.findChildComponent(self._dynamicIconObj, "root", gohelper.Type_Animation)

	if self.animation ~= nil and self.animation.clip ~= nil then
		local clip = self.animation.clip

		self.animationState = self.animation:get_Item(clip.name)
	end

	IconMgr.instance:addLiveIconAnimationReferenceTime(self.portraitId)
end

function CommonLiveHeadIcon:invokeCallBack()
	if not self.callBack or not self.callBackObj then
		return
	end

	self.callBack(self.callBackObj, self)

	self.callBack = nil
	self.callBackObj = nil
end

function CommonLiveHeadIcon:calculateSize()
	if gohelper.isNil(self._dynamicIconObj) then
		return
	end

	self._dynamicIconObj.transform.parent = self.isParallel and self._simageHeadIcon.transform.parent or self._simageHeadIcon.transform

	self:setDynamicVisible(self.isDynamic and not self.isGray)
	self:setStaticVisible(not self.isDynamic or self.isGray)

	local imageReferenceTran = self._simageHeadIcon.gameObject.transform
	local iconWidth = recthelper.getWidth(self._root.transform)

	if not self.isParallel then
		local scale = 1

		if not self.setNativeSize then
			gohelper.setAsFirstSibling(self._dynamicIconObj)

			local parentWidth = recthelper.getWidth(self._simageHeadIcon.transform)
			local iconWidth = recthelper.getWidth(self._root.transform)

			scale = math.max(0, parentWidth / iconWidth)

			transformhelper.setLocalScale(self._dynamicIconObj.transform, scale, scale, 1)
		else
			recthelper.setSize(imageReferenceTran, iconWidth, iconWidth)
		end

		return
	end

	gohelper.setSiblingAfter(self._dynamicIconObj, self._simageHeadIcon.gameObject)

	local scaleX, scaleY = transformhelper.getLocalScale(imageReferenceTran)
	local posX, posY, posZ = transformhelper.getPos(imageReferenceTran)
	local scale = 1

	if not self.setNativeSize then
		local parentWidth = recthelper.getWidth(imageReferenceTran)

		scale = math.max(0, parentWidth / iconWidth)
	else
		recthelper.setSize(imageReferenceTran, iconWidth, iconWidth)
	end

	local rotateX, rotateY, rotateZ = transformhelper.getLocalRotation(imageReferenceTran)

	transformhelper.setLocalRotation(self._dynamicIconObj.transform, rotateX, rotateY, rotateZ)
	transformhelper.setLocalScale(self._dynamicIconObj.transform, scale * scaleX, scale * scaleY, 1)
	transformhelper.setPos(self._dynamicIconObj.transform, posX, posY, posZ)
end

function CommonLiveHeadIcon:setMaterial()
	if not self.isDynamic then
		return
	end

	local image = gohelper.findChildImage(self.imageReference, "")

	if image == nil or image.material == nil then
		return
	end

	self:traverseReplaceChildrenMaterial(self._root, image.material)
end

function CommonLiveHeadIcon:traverseReplaceChildrenMaterial(root, material)
	local allImage = root:GetComponentsInChildren(gohelper.Type_Image)
	local childCount = allImage.Length

	if childCount <= 0 then
		return
	end

	for i = 0, childCount - 1 do
		local image = allImage[i]

		if image and image.material == image.defaultMaterial then
			image.material = material
		end
	end
end

function CommonLiveHeadIcon:setAlpha(alpha)
	if not alpha then
		return
	end

	if not self.isDynamic then
		ZProj.UGUIHelper.SetColorAlpha(self._imageComp, alpha)

		return
	end

	if self.canvasGroup == nil then
		self.canvasGroup = gohelper.onceAddComponent(self._dynamicIconObj, gohelper.Type_CanvasGroup)
	end

	if self.canvasGroup then
		self.canvasGroup.alpha = alpha
	end
end

function CommonLiveHeadIcon:setAnimationTime(referenceTime)
	if not self.isDynamic or gohelper.isNil(self._dynamicIconObj) or self.animationState == nil then
		return
	end

	local state = self.animationState
	local offsetTime = UnityEngine.Time.timeSinceLevelLoad - referenceTime
	local length = state.length

	if length == nil then
		return
	end

	state.time = offsetTime % length
end

function CommonLiveHeadIcon:setGray(isGray)
	ZProj.UGUIHelper.SetGrayscale(self._simageHeadIcon.gameObject, isGray)

	self.isGray = isGray

	if not self.isDynamic then
		return
	end

	self:setStaticVisible(isGray)
	self:setDynamicVisible(not isGray)
	self._simageHeadIcon:LoadImage(ResUrl.getPlayerHeadIcon(self.portraitId))
end

function CommonLiveHeadIcon:setDynamicVisible(isVisible)
	gohelper.setActive(self._dynamicIconObj, self.isDynamic and isVisible)
end

function CommonLiveHeadIcon:setStaticVisible(isVisible)
	if self.isParallel then
		gohelper.setActive(self._simageHeadIcon, isVisible)
	end
end

function CommonLiveHeadIcon:onEnable()
	self:syncAnimationTime()
end

function CommonLiveHeadIcon:syncAnimationTime()
	if not self.isDynamic or gohelper.isNil(self._dynamicIconObj) or self.animationState == nil then
		return
	end

	local time = IconMgr.instance:getLiveIconReferenceTime(self.portraitId)

	if time then
		self:setAnimationTime(time)
	end
end

function CommonLiveHeadIcon:removeHeadLiveIcon()
	if not self.isDynamic or gohelper.isNil(self._dynamicIconObj) then
		return
	end

	IconMgr.instance:removeHeadLiveIcon(self.portraitId)

	self._dynamicIconObj = nil
end

function CommonLiveHeadIcon:onDestroy()
	self:removeHeadLiveIcon()

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return CommonLiveHeadIcon
