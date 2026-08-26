-- chunkname: @modules/live2d/controller/Live2dRTShareController.lua

module("modules.live2d.controller.Live2dRTShareController", package.seeall)

local Live2dRTShareController = class("Live2dRTShareController", BaseController)
local SystemInfo = UnityEngine.SystemInfo

function Live2dRTShareController:onInit()
	self:reInit()
end

function Live2dRTShareController:reInit()
	self:_clearAll()
end

function Live2dRTShareController:_clearAll()
	TaskDispatcher.cancelTask(self._checkRT, self)

	self._minType = CharacterVoiceEnum.RTShareType.Normal
	self._maxType = CharacterVoiceEnum.RTShareType.FullScreen
	self._debugLog = false
	self._clearTime = nil

	if self._typeInfoList and self._typeRTList then
		self:clearAllRT()
	end

	self._typeInfoList = {}
	self._typeRTList = {}
end

function Live2dRTShareController:addConstEvents()
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, self._onExistScene, self)
end

function Live2dRTShareController:_onExistScene()
	self:_clearAll()
end

function Live2dRTShareController:clearAllRT()
	for i = self._maxType, self._minType, -1 do
		local info = self:_getRTInfoList(i)

		if info.rt then
			UnityEngine.RenderTexture.ReleaseTemporary(info.rt)
			self:_replaceRT(i)

			info.rt = nil

			if self._debugLog then
				logError(string.format("Live2dRTShareController:clearAllRT shareType:%s", i))
			end
		end

		info.orthographicSize = nil
	end
end

function Live2dRTShareController:_replaceRT(shareType)
	self._defaultRT = self._defaultRT or UnityEngine.RenderTexture.GetTemporary(8, 8, 0, UnityEngine.RenderTextureFormat.ARGB32)

	local list = self:_getTypeInfoList(shareType)

	for i, v in ipairs(list) do
		if not gohelper.isNil(v.camera) then
			v.camera.targetTexture = self._defaultRT

			if not gohelper.isNil(v.image) then
				v.image.texture = nil

				recthelper.setSize(v.image.rectTransform, 0, 0)
			end
		end
	end
end

function Live2dRTShareController:_getRT(camera, orthographicSize, shareType, heroId, skinId)
	local infoList = self:_getRTInfoList(shareType)

	if infoList.orthographicSize ~= orthographicSize then
		self:clearAllRT()

		infoList.orthographicSize = orthographicSize

		if shareType == CharacterVoiceEnum.RTShareType.FullScreen then
			infoList.rt = camera.targetTexture

			if self._debugLog then
				logError(string.format("Live2dRTShareController:_reuseRT orthographicSize:%s shareType:%s", orthographicSize, shareType))
			end
		else
			infoList.rt = self:_createRT(orthographicSize, shareType, heroId, skinId)
		end
	end

	return infoList.rt
end

function Live2dRTShareController:_getTextureSizeByCameraSize(orthographicSize)
	local _qualityScale, _adapterScaleOnCreate = GuiLive2d.GetScaleByDevice()
	local textureSizeByCamera = GuiLive2d.getTextureSizeByCameraSize(orthographicSize)
	local textureSize = textureSizeByCamera * _adapterScaleOnCreate * _qualityScale

	return CharacterVoiceEnum.ChangeRTSize and CharacterVoiceEnum.getRTWidth() or math.floor(textureSize)
end

function Live2dRTShareController:_getTextureSize(orthographicSize, shareType, heroId, skinId)
	if self:_isBloomType(shareType) then
		local cameraSize = CharacterVoiceEnum.BloomTypeCameraSize

		if cameraSize then
			return self:_getTextureSizeByCameraSize(cameraSize)
		end
	end

	if shareType == CharacterVoiceEnum.RTShareType.Normal then
		local cameraSize = CharacterVoiceEnum.NormalTypeCameraSize

		if cameraSize then
			return self:_getTextureSizeByCameraSize(cameraSize)
		end
	end

	return self:_getTextureSizeByCameraSize(orthographicSize)
end

function Live2dRTShareController:_createRT(orthographicSize, shareType, heroId, skinId)
	local textureSize = self:_getTextureSize(orthographicSize, shareType, heroId, skinId)
	local maxTextureSize = SystemInfo.maxTextureSize

	if maxTextureSize < textureSize then
		textureSize = maxTextureSize
	end

	if self._debugLog then
		logError(string.format("Live2dRTShareController:_createRT orthographicSize:%s textureSize:%s shareType:%s", orthographicSize, textureSize, shareType))
	end

	local rtHeight = CharacterVoiceEnum.getRTHeight()

	if shareType == CharacterVoiceEnum.RTShareType.BloomOpen or shareType == CharacterVoiceEnum.RTShareType.Normal then
		return UnityEngine.RenderTexture.GetTemporary(textureSize, rtHeight, 0, UnityEngine.RenderTextureFormat.ARGBHalf)
	end

	return UnityEngine.RenderTexture.GetTemporary(textureSize, rtHeight, 0, UnityEngine.RenderTextureFormat.ARGB32)
end

function Live2dRTShareController:_getRTInfoList(shareType)
	local infoList = self._typeRTList[shareType]

	if not infoList then
		infoList = {}
		self._typeRTList[shareType] = infoList
	end

	return infoList
end

function Live2dRTShareController:_getTypeInfoList(shareType)
	local infoList = self._typeInfoList[shareType]

	if not infoList then
		infoList = {}
		self._typeInfoList[shareType] = infoList
	end

	return infoList
end

function Live2dRTShareController:addShareInfo(camera, image, shareType, heroId, skinId, viewName)
	if not camera or not image or not shareType or not heroId or not skinId then
		logError(string.format("addShareInfo error camera:%s image:%s shareType:%s heroId:%s skinId:%s", camera, image, shareType, heroId, skinId))

		return
	end

	if shareType < self._minType or shareType > self._maxType then
		logError(string.format("addShareInfo error shareType:%s", shareType))

		return
	end

	local list = self:_getTypeInfoList(shareType)

	for i, v in ipairs(list) do
		if v.camera == camera and v.image == image then
			logError(string.format("addShareInfo error same camera:%s image:%s shareType:%s", camera, image, shareType))

			return
		end
	end

	table.insert(list, {
		camera = camera,
		orthographicSize = camera.orthographicSize,
		textureSize = self:_getTextureSizeByCameraSize(camera.orthographicSize),
		image = image,
		shareType = shareType,
		heroId = heroId,
		skinId = skinId,
		viewName = viewName
	})

	if shareType == CharacterVoiceEnum.RTShareType.Normal then
		self:_sortNormalList(list)
	end

	if self._debugLog then
		logError(string.format("addShareInfo camera:%s orthographicSize:%s image:%s shareType:%s num:%s viewName:%s", camera, camera.orthographicSize, image, shareType, #list, viewName))
	end

	self._clearTime = nil

	self:_checkRT()
	TaskDispatcher.cancelTask(self._checkRT, self)
	TaskDispatcher.runRepeat(self._checkRT, self, 0)
end

function Live2dRTShareController:_sortNormalList(list)
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for i, info in ipairs(list) do
		info.priority = tabletool.indexOf(openViewList, info.viewName) or 0
	end

	table.sort(list, function(a, b)
		return a.priority < b.priority
	end)
end

function Live2dRTShareController:_getTopInfoList()
	for i = self._maxType, self._minType, -1 do
		local list = self:_getTypeInfoList(i)

		if #list > 0 then
			return list, i
		end
	end

	return self:_getTypeInfoList(self._minType), self._minType
end

function Live2dRTShareController:_isBloomType(shareType)
	return shareType == CharacterVoiceEnum.RTShareType.BloomClose or shareType == CharacterVoiceEnum.RTShareType.BloomOpen
end

function Live2dRTShareController:_checkRT()
	local list, shareType = self:_getTopInfoList()

	if #list == 0 then
		self._clearTime = self._clearTime or Time.time

		if Time.time - self._clearTime > 1 then
			TaskDispatcher.cancelTask(self._checkRT, self)

			self._clearTime = nil

			self:clearAllRT()
		end

		return
	end

	local showInfo

	for i = #list, 1, -1 do
		local info = list[i]

		if gohelper.isNil(info.camera) or gohelper.isNil(info.image) then
			table.remove(list, i)

			info = nil

			if self._debugLog then
				logError(string.format("Live2dRTShareController:_checkRT remove frame:%s index:%s shareType:%s remain:%s", Time.frameCount, i, shareType, #list))
			end
		end

		if info and shareType == CharacterVoiceEnum.RTShareType.Normal then
			local rt = self:_getRT(info.camera, info.orthographicSize, info.shareType, info.heroId, info.skinId)

			info.camera.targetTexture = rt
			info.image.texture = rt

			local width = rt.width
			local height = rt.height

			recthelper.setSize(info.image.rectTransform, width, height)

			showInfo = info

			break
		elseif info and info.image.gameObject.activeInHierarchy then
			local rt = self:_getRT(info.camera, info.orthographicSize, info.shareType, info.heroId, info.skinId)

			info.camera.targetTexture = rt
			info.image.texture = rt

			local width = rt.width
			local height = rt.height

			recthelper.setSize(info.image.rectTransform, width, height)

			showInfo = info

			break
		end
	end

	for i, info in ipairs(list) do
		local show = info == showInfo

		if not gohelper.isNil(info.camera) then
			info.camera.enabled = show
		end
	end

	self._clearTime = nil
end

Live2dRTShareController.instance = Live2dRTShareController.New()

return Live2dRTShareController
