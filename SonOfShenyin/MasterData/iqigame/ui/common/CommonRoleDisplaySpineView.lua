-- chunkname: @IQIGame\\UI\\Common\\CommonRoleDisplaySpineView.lua

local CommonRoleDisplaySpineView = {
	skinUniqueEntityID = 0,
	DisplayAlpha = "_DisplayAlpha",
	showPosition = 0,
	displayActionControlData = 0,
	cacheTimelines = {}
}

function CommonRoleDisplaySpineView.New(view, showPosition)
	local obj = Clone(CommonRoleDisplaySpineView)

	obj:__Init(view, showPosition)

	return obj
end

function CommonRoleDisplaySpineView:__Init(view, showPosition)
	self.gameObject = view
	self.showPosition = showPosition
	self.userData = nil

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnTimelineStopped(playableDirector)
		self:__OnTimelineStopped(playableDirector)
	end

	function self.__delegateOnSpineClick()
		if self.userData.disableClick == true then
			return
		end

		self:__PlayDisplayGroupActionByType(Constant.DynamicSkinDisplayActionType.Touch)
	end

	self.contentRoot:GetComponent("Button").onClick:AddListener(self.__delegateOnSpineClick)

	self.audioSource = self.AudioSourceRoot.gameObject:GetComponent(typeof(UnityEngine.AudioSource))
	self.audioSource.volume = SettingModule.currentCvVolume * SettingModule.AllAudioVolume

	EventUtil.AddEventListener(self, EventID.SoundVolumeChange_CVGroup, self.__OnSoundVolumeChanged)
	EventUtil.AddEventListener(self, EventID.NotifySoundGroupTypeChange, self.__OnNotifySoundGroupTypeChange)
end

function CommonRoleDisplaySpineView:__OnSoundVolumeChanged(value)
	self.audioSource.volume = value
end

function CommonRoleDisplaySpineView:__OnNotifySoundGroupTypeChange(groupType, isOn)
	if groupType ~= Constant.SoundGroupType.Battle then
		return
	end

	if self.userData == nil then
		return
	end

	local discreteData = CfgHeroSkinDiscreteTable[self.userData.__skinDiscreteCid]

	if discreteData == nil then
		return
	end

	self:__UpdateDisplayActionControlData(discreteData)
end

function CommonRoleDisplaySpineView:Show(userData)
	self:__StopTimeline()
	self:__Release()

	self.userData = userData

	self.gameObject:SetActive(true)

	local discreteData = CfgHeroSkinDiscreteTable[self.userData.__skinDiscreteCid]

	self.contentRoot.transform.localPosition, self.__skinDiscreteScale = SkinModule.GetHeroDynamicSkinSpineOffset(discreteData, self.showPosition)

	self:__UpdateDisplayActionControlData(discreteData)
	self:__LoadDynamicSpine(self.userData.__skinEntityCid)
end

function CommonRoleDisplaySpineView:Hide()
	self.gameObject:SetActive(false)
	self:__StopTimeline()
	self:__Release()
end

function CommonRoleDisplaySpineView:Dispose()
	EventUtil.ClearEventListener(self)

	self.audioSource = nil

	self.contentRoot:GetComponent("Button").onClick:RemoveListener(self.__delegateOnSpineClick)
	self:__StopTimeline()
	self:__Release()
	self:__ReleaseTimeline()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function CommonRoleDisplaySpineView:__Release()
	self.displayActionControlData = nil

	self:__ReleaseDynamicSpine()

	self.userData = nil
end

function CommonRoleDisplaySpineView:__LoadDynamicSpine(UIDynamicEntityID)
	self.skinUniqueEntityID = EntityUtility.GetHeroUIEntityByDynamicPrefabCid(UIDynamicEntityID, self.spineRoot.transform, Vector3.zero, function(_entityComponent)
		if _entityComponent.Id ~= self.skinUniqueEntityID then
			EntityUtility.HideEntity(_entityComponent)

			return
		end

		self:__LoadDynamicSpineComplete(_entityComponent.gameObject)
	end)
end

function CommonRoleDisplaySpineView:__LoadDynamicSpineComplete(previewSpine)
	self.spineEntityGo = previewSpine

	local spineGraphicRoot = self.spineEntityGo.transform:FindChildByName("SpineRoot/SkeletonGraphic")

	if spineGraphicRoot then
		self.skeletonGraphic = spineGraphicRoot.gameObject:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

		self.skeletonGraphic:Initialize(true)
	end

	self:__PlayDisplayAction()
end

function CommonRoleDisplaySpineView:__UpdateDisplayActionControlData(heroSkinDiscreteData)
	self.displayActionControlData = nil

	local index = 1

	if PlayerModule.PlayerInfo.baseInfo.sex == Constant.PlayerSex.WoMen then
		index = 3
	end

	local selectIndex = PlayerPrefsUtil.GetInt("SoundGroupType", Constant.PlayerPrefsConst.OpenSecondSound, 2)

	if selectIndex == 1 then
		index = index + 1
	end

	local displayActionControlID = GetArrayValue(heroSkinDiscreteData.DisplayActionControlID, index, 0)

	if displayActionControlID == 0 then
		return
	end

	if displayActionControlID == nil then
		return
	end

	self.displayActionControlData = CfgHeroSkinDisplayActionControlTable[displayActionControlID]
end

function CommonRoleDisplaySpineView:__ReleaseDynamicSpine()
	if self.skinUniqueEntityID == 0 then
		return
	end

	EntityUtility.HideEntityByEntityID(self.skinUniqueEntityID)

	self.spineEntityGo = nil
	self.skinUniqueEntityID = 0
	self.skeletonGraphic = nil
end

function CommonRoleDisplaySpineView:__ChangeSpineRoot(transform)
	if self.spineEntityGo == nil then
		return
	end

	self.spineEntityGo.transform:SetParent(transform)

	self.spineEntityGo.transform.localPosition = Vector3.zero
	self.spineEntityGo.transform.localScale = Vector3.one
end

function CommonRoleDisplaySpineView:__PlayTimeline(actionData, userData)
	self:__StopTimeline()

	local index = 1

	if PlayerModule.PlayerInfo.baseInfo.sex == Constant.PlayerSex.WoMen then
		index = 2
	end

	local timelinePath = actionData.TimelinePath[index]

	self.__PlayDisplayActionData = userData
	self.playTimelinePath = timelinePath

	local timelineGo = self:__GetTimelineGo()

	if timelineGo ~= nil then
		self:__DoPlayTimeline(timelineGo, actionData)

		return
	end

	local __userData = {
		EntityCid = self.userData.__skinEntityCid,
		TimelinePath = timelinePath,
		ActionData = actionData,
		Scale = userData.scale
	}

	AssetUtil.LoadAsset(self, timelinePath, function(_, _assetUrl, _asset, _duration, _userData)
		self:__AddCacheTimeline(_asset, _userData)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("Play Timeline Fail---------->>{0}", _assetName)
	end, __userData)
end

function CommonRoleDisplaySpineView:__OnInitTimelineGo(asset, userData)
	local timelineGo = GameObject.Instantiate(asset)

	timelineGo.transform:SetParent(self.timeLineRoot.transform)

	timelineGo.transform.localPosition = Vector3.zero
	timelineGo.transform.localScale = Vector3.one

	local playableDirector = timelineGo:GetComponent("PlayableDirector")

	playableDirector.playOnAwake = false
	playableDirector.stopped = playableDirector.stopped + self.__delegateOnTimelineStopped

	timelineGo.gameObject:SetActive(false)

	local scaleRoot = timelineGo.transform:FindChildByName("ScaleRoot")

	if scaleRoot ~= nil then
		scaleRoot.transform.localScale = Vector3.New(userData.Scale, userData.Scale, userData.Scale)
	end

	return timelineGo
end

function CommonRoleDisplaySpineView:__AddCacheTimeline(asset, userData)
	if self.userData == nil then
		return
	end

	if self.cacheTimelines[userData.EntityCid] == nil then
		self.cacheTimelines[userData.EntityCid] = {}
	end

	local timelineGo = self:__OnInitTimelineGo(asset, userData)

	self.cacheTimelines[userData.EntityCid][userData.TimelinePath] = timelineGo

	if self.playTimelinePath ~= userData.TimelinePath then
		return
	end

	self:__DoPlayTimeline(timelineGo, userData.ActionData)
end

function CommonRoleDisplaySpineView:__GetTimelineGo()
	local timelines = self.cacheTimelines[self.userData.__skinEntityCid]

	if timelines == nil then
		return nil
	end

	return timelines[self.playTimelinePath]
end

function CommonRoleDisplaySpineView:__ReleaseTimeline()
	ForPairs(self.cacheTimelines, function(_entityCid, _timelines)
		ForPairs(_timelines, function(_path, _timelineGo)
			GameObject.DestroyImmediate(_timelineGo)
		end)
	end)

	self.cacheTimelines = nil
end

function CommonRoleDisplaySpineView:__DoPlayTimeline(timelineGo, actionData)
	timelineGo:SetActive(true)

	local playableDirector = timelineGo:GetComponent("PlayableDirector")
	local parent = timelineGo.transform:FindChildByName("SpineRoot")
	local speakTextData, speakContentCfg = SkinModule.GetSpeakTextBySex(actionData, self.showPosition)
	local textBackgroundSourceCom
	local speakContentRoot = timelineGo.transform:FindChildByName("SpeakContentRoot")

	if speakContentRoot ~= nil then
		local textRoot = timelineGo.transform:FindChildByName("SpeakContentRoot/speakContent")

		if textRoot ~= nil then
			textBackgroundSourceCom = textRoot.gameObject:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))

			textBackgroundSourceCom:SetProgress(0)

			local background = textBackgroundSourceCom.transform.parent.gameObject:GetComponent(typeof(BordlessFramework.UI.TextBackground))
			local mat = background.material

			if mat ~= nil then
				local speakInfo = speakTextData[1]
				local alpha = 1

				if LuaUtility.StrIsNullOrEmpty(speakInfo) then
					alpha = 0
				end

				mat:SetFloat(self.DisplayAlpha, alpha)
			end
		end

		local rectTrans = speakContentRoot.gameObject:GetComponent("RectTransform")

		rectTrans.localPosition = speakContentCfg.localPosition
		rectTrans.sizeDelta = speakContentCfg.sizeDelta
	end

	self:__ChangeSpineRoot(parent.transform)

	local playableAsset = playableDirector.playableAsset
	local tracks = playableAsset:GetOutputTracks()
	local length = tracks.Length - 1

	ForArrayByCount(0, length, 1, function(_index)
		local track = tracks[_index]

		if track.name == "Graphic" then
			playableDirector:SetGenericBinding(track, self.skeletonGraphic)

			return
		end

		if track:GetType() == typeof(IQIGame.TimelineEx.SpeakTextTrack) then
			if textBackgroundSourceCom == nil then
				logError("找不到对话组件")
			else
				playableDirector:SetGenericBinding(track, textBackgroundSourceCom)
				track:SetSpeakTextGroup(speakTextData)
			end

			return
		end

		LuaCodeInterface.BindingTimelineAudioTrack(playableDirector, track, self.audioSource)
	end)

	if self.__PlayDisplayActionData.loop then
		LuaCodeInterface.SetPlayableDirectorWarpModule(playableDirector, 2)
	else
		LuaCodeInterface.SetPlayableDirectorWarpModule(playableDirector, 0)
	end

	playableDirector:Play()
end

function CommonRoleDisplaySpineView:__OnTimelineStopped(playableDirector)
	if LuaUtility.StrIsNullOrEmpty(self.playTimelinePath) then
		return
	end

	self:__ChangeSpineRoot(self.spineRoot.transform)

	local timelineGo = self:__GetTimelineGo()

	timelineGo:SetActive(false)

	self.playTimelinePath = ""

	if self.__PlayDisplayActionData.resetToIdle then
		self:__PlayDisplayGroupActionByType(Constant.DynamicSkinDisplayActionType.Idle)
	else
		self:__PlayDisplayGroupActionByType(Constant.DynamicSkinDisplayActionType.Standby)
	end
end

function CommonRoleDisplaySpineView:__StopTimeline()
	if LuaUtility.StrIsNullOrEmpty(self.playTimelinePath) then
		return
	end

	self:__ChangeSpineRoot(self.spineRoot.transform)

	local timelineGo = self:__GetTimelineGo()

	if timelineGo ~= nil then
		timelineGo:SetActive(false)

		local playableDirector = timelineGo:GetComponent("PlayableDirector")

		playableDirector:Stop()
	end

	self.playTimelinePath = ""
end

function CommonRoleDisplaySpineView:__PlayAnimation(layer, animName, isLoop)
	self.skeletonGraphic.AnimationState:SetAnimation(layer, animName, isLoop)
end

function CommonRoleDisplaySpineView:__PlayDisplayAction()
	if self.displayActionControlData == nil then
		return
	end

	if self.userData.displayGroupAction ~= nil then
		self:__PlayDisplayGroupActionByType(self.userData.displayGroupAction)

		return
	end

	if self.showPosition == Constant.DynamicSkinShowPosition.MobilePhone then
		self:__PlayDisplayGroupActionByType(Constant.DynamicSkinDisplayActionType.Greeting)
	else
		self:__PlayDisplayGroupActionByType(Constant.DynamicSkinDisplayActionType.Idle)
	end
end

function CommonRoleDisplaySpineView:__PlayDisplayGroupActionByType(displayActionType)
	if self.displayActionControlData == nil then
		return
	end

	if displayActionType == Constant.DynamicSkinDisplayActionType.Greeting then
		self:__PlayGreetingAction()

		return
	elseif displayActionType == Constant.DynamicSkinDisplayActionType.Touch and self.__PlayDisplayActionData ~= nil and self.__PlayDisplayActionData.displayActionType ~= Constant.DynamicSkinDisplayActionType.Idle then
		return
	end

	local userData = {}

	userData.resetToIdle = true
	userData.loop = false
	userData.displayActionType = displayActionType
	userData.scale = self.__skinDiscreteScale

	if displayActionType == Constant.DynamicSkinDisplayActionType.Idle then
		if self.showPosition ~= Constant.DynamicSkinShowPosition.BattleResultUI then
			userData.resetToIdle = false
		else
			userData.loop = true
		end

		self:__PlayDisplayGroupAction(self.displayActionControlData.Idle, userData)
	elseif displayActionType == Constant.DynamicSkinDisplayActionType.Greeting_Morning then
		self:__PlayDisplayGroupAction(self.displayActionControlData.MorningGreetings, userData)
	elseif displayActionType == Constant.DynamicSkinDisplayActionType.Greeting_Noon then
		self:__PlayDisplayGroupAction(self.displayActionControlData.NoonGreetings, userData)
	elseif displayActionType == Constant.DynamicSkinDisplayActionType.Greeting_Evening then
		self:__PlayDisplayGroupAction(self.displayActionControlData.EveningGreetings, userData)
	elseif displayActionType == Constant.DynamicSkinDisplayActionType.Greeting_LateEvening then
		self:__PlayDisplayGroupAction(self.displayActionControlData.LateEveningGreetings, userData)
	elseif displayActionType == Constant.DynamicSkinDisplayActionType.Standby then
		self:__PlayDisplayGroupAction(self.displayActionControlData.StandbyAction, userData)
	elseif displayActionType == Constant.DynamicSkinDisplayActionType.Touch then
		self:__PlayDisplayGroupAction(self.displayActionControlData.TouchFeedback, userData)
	elseif displayActionType == Constant.DynamicSkinDisplayActionType.BattleWin then
		self:__PlayDisplayGroupAction(self.displayActionControlData.BattleWin, userData)
	elseif displayActionType == Constant.DynamicSkinDisplayActionType.BattleLost then
		self:__PlayDisplayGroupAction(self.displayActionControlData.BattleLose, userData)
	else
		userData.loop = true

		self:__PlayDisplayGroupAction(self.displayActionControlData.Idle, userData)
	end
end

function CommonRoleDisplaySpineView:__PlayGreetingAction()
	local serverTime = PlayerModule.GetServerTime()
	local hour = tonumber(os.date("%H", serverTime))
	local type = MainUIAPI:GetGreetingType(hour)

	if type == 1 then
		self:__PlayDisplayGroupActionByType(Constant.DynamicSkinDisplayActionType.Greeting_Morning)
	elseif type == 2 then
		self:__PlayDisplayGroupActionByType(Constant.DynamicSkinDisplayActionType.Greeting_Noon)
	elseif type == 3 then
		self:__PlayDisplayGroupActionByType(Constant.DynamicSkinDisplayActionType.Greeting_Evening)
	elseif type == 4 then
		self:__PlayDisplayGroupActionByType(Constant.DynamicSkinDisplayActionType.Greeting_LateEvening)
	else
		self:__PlayDisplayGroupActionByType(Constant.DynamicSkinDisplayActionType.Standby)
	end
end

function CommonRoleDisplaySpineView:__PlayDisplayGroupAction(actionGroup, userData)
	local actionCid = SkinModule.GetRandomSkinDisplayActionCid(actionGroup)

	if actionCid == 0 then
		logError("播放动态立绘动作失败 {0} --》 {1}", self.userData.__skinEntityCid, userData.displayActionType)

		return
	end

	local actionCfg = CfgHeroSkinDisplayActionTable[actionCid]

	self:__PlayTimeline(actionCfg, userData)

	return true
end

return CommonRoleDisplaySpineView
