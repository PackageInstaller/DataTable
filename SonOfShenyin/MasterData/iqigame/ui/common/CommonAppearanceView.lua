-- chunkname: @IQIGame\\UI\\Common\\CommonAppearanceView.lua

local CommonAppearanceView = {}

function CommonAppearanceView.New(view)
	local obj = Clone(CommonAppearanceView)

	obj:__Init(view)

	return obj
end

function CommonAppearanceView:__Init(view)
	self.gameObject = view
	self.__cacheTimelineGo = {}

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	UIEventUtil.AddClickEventListener_DoubleButton(self, "SkipBtn", self.__OnSkipButtonClick)

	function self.__delegateOnTimelineStopped(playableDirector)
		self:__OnTimelineStopped(playableDirector)
	end
end

function CommonAppearanceView:PlayAppearance(skinCid, userData)
	local skinCfg = CfgHeroSkinTable[skinCid]

	if LuaUtility.StrIsNullOrEmpty(skinCfg.AppearanceTimeline) then
		if userData.callback ~= nil then
			userData.callback(userData)
		end

		return false
	end

	local disableSkip = TryToBoolean(userData.disableSkip, false)

	LuaCodeInterface.SetGameObjectShow(self.SkipBtn, not disableSkip)

	self.skinCid = skinCid
	self.userData = userData

	self:__PlayAppearanceTimeline(skinCid, skinCfg.AppearanceTimeline)

	return true
end

function CommonAppearanceView:__PlayAppearanceTimeline(skinCid, path)
	self.gameObject:SetActive(true)

	local timelineGo = self.__cacheTimelineGo[skinCid]

	if timelineGo ~= nil then
		self:__PlayTimeline(timelineGo)

		return
	end

	local timelinePath = "Assets/03_Prefabs/Entity/Skin/" .. path

	AssetUtil.LoadAsset(self, timelinePath, function(_, _assetUrl, _asset, _duration, _userData)
		self:__OnTimelineLoaded(_asset, skinCid)
	end, function(_assetName, _status, _errorMessage, _userData)
		self:__OnComplete()
	end)
end

function CommonAppearanceView:__OnTimelineLoaded(asset, skinCid)
	local timelineGo = GameObject.Instantiate(asset)

	timelineGo.transform:SetParent(self.TimelineRoot.transform)

	timelineGo.transform.localPosition = Vector3.zero
	timelineGo.transform.localScale = Vector3.one

	LuaCodeInterface.SetRectTransformStretchMode(timelineGo.transform, 0, 0, 0, 0)
	timelineGo.gameObject:SetActive(false)

	self.__cacheTimelineGo[skinCid] = timelineGo

	if self.skinCid ~= skinCid then
		return
	end

	self:__PlayTimeline(timelineGo)
end

function CommonAppearanceView:__PlayTimeline(timelineGo)
	timelineGo.gameObject:SetActive(true)

	local playableDirector = timelineGo:GetComponent("PlayableDirector")

	playableDirector.stopped = playableDirector.stopped + self.__delegateOnTimelineStopped

	playableDirector:Play()
end

function CommonAppearanceView:__OnTimelineStopped(playableDirector)
	local timelineGo = self.__cacheTimelineGo[self.skinCid]

	playableDirector.stopped = playableDirector.stopped - self.__delegateOnTimelineStopped

	timelineGo.gameObject:SetActive(false)
	self:__OnComplete()
end

function CommonAppearanceView:__OnComplete()
	self.skinCid = nil

	if self.userData == nil then
		return
	end

	if self.userData.callback == nil then
		-- block empty
	end

	self.userData.callback(self.userData)
end

function CommonAppearanceView:Hide()
	self.gameObject:SetActive(false)
end

function CommonAppearanceView:Dispose()
	UIEventUtil.ClearEventListener(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function CommonAppearanceView:__OnSkipButtonClick()
	local timelineGo = self.__cacheTimelineGo[self.skinCid]
	local playableDirector = timelineGo:GetComponent("PlayableDirector")

	playableDirector:Stop()
end

return CommonAppearanceView
