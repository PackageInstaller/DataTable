-- chunkname: @modules/logic/character/defines/CharacterVoiceEnum.lua

module("modules.logic.character.defines.CharacterVoiceEnum", package.seeall)

local CharacterVoiceEnum = _M

CharacterVoiceEnum.SkipMesFightSuccPosAdjust = true
CharacterVoiceEnum.Live2dScale = 88
CharacterVoiceEnum.RTCameraOffsetY = 527
CharacterVoiceEnum.RTRawImageOffsetY = 1000
CharacterVoiceEnum.FullScreenRTRawImageOffsetY = -350
CharacterVoiceEnum.FullScreenViewName = "CharacterSkinFullScreenView"
CharacterVoiceEnum.ChangeRTSize = true
CharacterVoiceEnum.RTCameraSize = 5
CharacterVoiceEnum.RTWidth = 2592
CharacterVoiceEnum.RTHeight = 1080
CharacterVoiceEnum.Scale = 1.16
CharacterVoiceEnum.RTSizeLegacy = false
CharacterVoiceEnum.RTCameraSizeLegacy = 12
CharacterVoiceEnum.RTWidthLegacy = 3000
CharacterVoiceEnum.RTHeightLegacy = 3000

function CharacterVoiceEnum.getCameraSize(createType)
	if createType ~= CharacterVoiceEnum.CreateType.GuiModelAgent then
		return CharacterVoiceEnum.RTCameraSizeLegacy
	end

	if CharacterVoiceEnum.RTSizeLegacy then
		return CharacterVoiceEnum.RTCameraSizeLegacy
	else
		return CharacterVoiceEnum.RTCameraSize
	end
end

function CharacterVoiceEnum.getRTWidth()
	if CharacterVoiceEnum.RTSizeLegacy then
		return CharacterVoiceEnum.RTWidthLegacy
	else
		return CharacterVoiceEnum.RTWidth
	end
end

function CharacterVoiceEnum.getRTHeight()
	if CharacterVoiceEnum.RTSizeLegacy then
		return CharacterVoiceEnum.RTHeightLegacy
	else
		return CharacterVoiceEnum.RTHeight
	end
end

function CharacterVoiceEnum.getLive2dScale(createType)
	if createType ~= CharacterVoiceEnum.CreateType.GuiModelAgent then
		return CharacterVoiceEnum.Live2dScale
	end

	if CharacterVoiceEnum.RTSizeLegacy then
		return CharacterVoiceEnum.Live2dScale
	else
		return CharacterVoiceEnum.Live2dScale * CharacterVoiceEnum.Scale
	end
end

function CharacterVoiceEnum.getRTRawImageOffsetPosY(rtViewName)
	return (rtViewName == CharacterVoiceEnum.FullScreenViewName or nil) and (CharacterVoiceEnum.FullScreenRTRawImageOffsetY or CharacterVoiceEnum.RTRawImageOffsetY)
end

function CharacterVoiceEnum.getRTRawImageOffsetScale(rtViewName)
	return rtViewName == CharacterVoiceEnum.CharacterSkinView and 1.11 or 1
end

function CharacterVoiceEnum.setRTRawPos(rawImageTransform, createType, rtViewName)
	if createType ~= CharacterVoiceEnum.CreateType.GuiModelAgent then
		transformhelper.setLocalPos(rawImageTransform, 0, CharacterVoiceEnum.getRTRawImageOffsetPosY(rtViewName), 0)

		return
	end

	if CharacterVoiceEnum.RTSizeLegacy then
		transformhelper.setLocalPos(rawImageTransform, 0, CharacterVoiceEnum.getRTRawImageOffsetPosY(rtViewName), 0)
	else
		transformhelper.setPos(rawImageTransform, 0, 0, 0)
	end
end

function CharacterVoiceEnum.getCameraOffsetY(createType)
	if createType ~= CharacterVoiceEnum.CreateType.GuiModelAgent then
		return CharacterVoiceEnum.RTCameraOffsetY
	end

	if CharacterVoiceEnum.RTSizeLegacy then
		return CharacterVoiceEnum.RTCameraOffsetY
	else
		return CharacterVoiceEnum.RTCameraOffsetY * CharacterVoiceEnum.Scale
	end
end

function CharacterVoiceEnum.setSpineOffset(uiSpine, offsetX, offsetY)
	if not uiSpine then
		logError("uiSpine is null")

		return
	end

	local isLive2d = uiSpine:isLive2D()
	local spineTransform = uiSpine:getRootTransform()

	if CharacterVoiceEnum.RTSizeLegacy or not isLive2d then
		recthelper.setAnchor(spineTransform, offsetX, offsetY)
	else
		local live2d = uiSpine:getLive2d()

		if not live2d then
			logError("live2d is null")

			return
		end

		local createType = live2d:getCreateType()

		if createType ~= CharacterVoiceEnum.CreateType.GuiModelAgent then
			recthelper.setAnchor(spineTransform, offsetX, offsetY)

			return
		end

		local rtViewName = live2d:getRTViewName()

		if rtViewName ~= CharacterVoiceEnum.FullScreenViewName then
			live2d:setOffsetPos(offsetX, offsetY)
		end

		CharacterVoiceEnum.setLive2dOffset(live2d, offsetX, offsetY, rtViewName)
	end
end

function CharacterVoiceEnum.setLive2dOffset(live2d, offsetX, offsetY, rtViewName)
	if not offsetX or not offsetY then
		logError("offsetX or offsetY is null")

		return
	end

	local spineTransform = live2d._gameTr
	local rawImageOffsetX, rawImageOffsetY = live2d:getRawImageLocalPos()

	rawImageOffsetY = rawImageOffsetY - CharacterVoiceEnum.getRTRawImageOffsetPosY(rtViewName)

	local rawImageOffsetScale = CharacterVoiceEnum.getRTRawImageOffsetScale(rtViewName)

	recthelper.setAnchor(spineTransform, offsetX * CharacterVoiceEnum.Scale - rawImageOffsetX / rawImageOffsetScale, offsetY * CharacterVoiceEnum.Scale - rawImageOffsetY / rawImageOffsetScale)
end

CharacterVoiceEnum.CreateType = {
	GuiModelAgent = 1
}
CharacterVoiceEnum.Hero = {
	Luxi = 3086
}
CharacterVoiceEnum.LuxiState = {
	HumanFace = 2,
	MetalFace = 1
}
CharacterVoiceEnum.LuxiSkin2 = 308602
CharacterVoiceEnum.PlayType = {
	Auto = 2,
	Click = 1
}
CharacterVoiceEnum.StatusParams = {
	Luxi_NoChangeStatus = "noChangeStatus"
}
CharacterVoiceEnum.WaitVoiceParamsType = {
	MultiGroup = 1,
	VoiceWithWeightGroup = 2
}
CharacterVoiceEnum.WaitVoiceParamsCls = {
	[CharacterVoiceEnum.WaitVoiceParamsType.MultiGroup] = "MultiGroupWaitVoiceParams",
	[CharacterVoiceEnum.WaitVoiceParamsType.VoiceWithWeightGroup] = "VoiceWithWeightGroupParams"
}
CharacterVoiceEnum.EffectsType = {
	DelayPlayAudio = 2,
	RestrictedInteraction = 3,
	HideMainView = 1
}
CharacterVoiceEnum.SkinInteraction = {
	[313402] = "BleSkinInteraction",
	[314102] = "LuSiJianSkinInteraction",
	[314702] = "WMZSkinInteraction",
	[310504] = "ZxqeSkinInteraction",
	[311003] = "LiangYueSkinInteraction",
	[314602] = "XRAnSkinInteraction"
}
CharacterVoiceEnum.RankUpResultShowMask = {
	[3120] = true
}
CharacterVoiceEnum.UIBloomView = {
	CharacterDataView = "view_CharacterDataView"
}
CharacterVoiceEnum.NormalBloomViewType = {
	Capture = 2,
	CustomOpen = 3,
	Normal = 1
}
CharacterVoiceEnum.NormalBloomView = {
	WeekWalk_2HeartResultView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	RoleStoryFightSuccView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	RougeFightSuccessView = CharacterVoiceEnum.NormalBloomViewType.Capture,
	Rouge2_FightSuccessView = CharacterVoiceEnum.NormalBloomViewType.Capture,
	CharacterGetView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterRankUpResultView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterRankUpView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterSkinGainView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterSkinView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterRecommedView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	StoreSkinDefaultShowView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	StoreView = CharacterVoiceEnum.NormalBloomViewType.CustomOpen,
	FightSuccView = CharacterVoiceEnum.NormalBloomViewType.Capture,
	V3a8EchoSongGameView = CharacterVoiceEnum.NormalBloomViewType.Normal
}
CharacterVoiceEnum.RTShareType = {
	BloomClose = 2,
	BloomOpen = 3,
	BloomAuto = 100,
	FullScreen = 4,
	Normal = 1
}
CharacterVoiceEnum.XRAnStoryId = 8003701
CharacterVoiceEnum.MainViewIgnoreStory = {
	[CharacterVoiceEnum.XRAnStoryId] = true
}
CharacterVoiceEnum.BloomCameraSize = {
	[3116] = 10,
	[3108] = 10,
	[3122] = 10,
	[3107] = 10,
	[3134] = 10,
	[3070] = 10,
	[3047] = 10,
	[3128] = 10,
	[3120] = 10
}
CharacterVoiceEnum.NormalTypeCameraSize = 10
CharacterVoiceEnum.BloomTypeCameraSize = 10
CharacterVoiceEnum.NormalFullScreenEffectCameraSize = 13
CharacterVoiceEnum.BloomFullScreenEffectCameraSize = 13
CharacterVoiceEnum.DelayFrame = 5

return CharacterVoiceEnum
