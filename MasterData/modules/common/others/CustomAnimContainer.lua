-- chunkname: @modules/common/others/CustomAnimContainer.lua

module("modules.common.others.CustomAnimContainer", package.seeall)

local BaseViewContainer = BaseViewContainer
local TypeAnimatorPlayer = typeof(SLFramework.AnimatorPlayer)

BaseViewContainer.superOnContainerInit = BaseViewContainer.onContainerInit
BaseViewContainer.superOnPlayOpenTransitionFinish = BaseViewContainer.onPlayOpenTransitionFinish
BaseViewContainer.superOnPlayCloseTransitionFinish = BaseViewContainer.onPlayCloseTransitionFinish
BaseViewContainer.superDestroyView = BaseViewContainer.destroyView
BaseViewContainer.openViewTime = 0.2
BaseViewContainer.closeViewTime = 0.1
BaseViewContainer.openViewEase = EaseType.Linear
BaseViewContainer.closeViewEase = EaseType.Linear

local forceCloseAnimViewList

function BaseViewContainer.initForceAnimViewList()
	forceCloseAnimViewList = {
		ViewName.HeroGroupEditView,
		ViewName.RougeHeroGroupEditView,
		ViewName.HeroGroupPresetEditView,
		ViewName.V1a6_CachotHeroGroupEditView,
		ViewName.Season123HeroGroupEditView,
		ViewName.Season123_2_3HeroGroupEditView,
		ViewName.VersionActivity_1_2_HeroGroupEditView,
		ViewName.Act183HeroGroupEditView,
		ViewName.DungeonView,
		ViewName.DungeonStoryEntranceView,
		ViewName.TaskView,
		ViewName.ActivityNormalView,
		ViewName.PowerView,
		ViewName.RoomFormulaView,
		ViewName.RoomBlockPackageGetView,
		ViewName.VersionActivity1_2EnterView
	}
end

function BaseViewContainer:onContainerInit()
	BaseViewContainer.superOnContainerInit(self)

	if not self.viewGO then
		return
	end

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if not animator then
		return
	end

	local stateInfo = animator:GetCurrentAnimatorStateInfo(0)
	local normalizedTime = stateInfo.normalizedTime

	if normalizedTime >= 1 then
		return
	end

	local length = stateInfo.length * (1 - normalizedTime)

	if length <= 0 then
		return
	end

	BaseViewContainer.openViewAnimStartTime = Time.time
	BaseViewContainer.openViewAnimLength = math.min(length, 1)
end

function BaseViewContainer:playOpenTransition(paramTable)
	self:_cancelBlock()
	self:_stopOpenCloseAnim()

	if not self._viewSetting.anim or self._viewSetting.anim ~= ViewAnim.Default then
		if not string.nilorempty(self._viewSetting.anim) then
			self:_setAnimatorRes()

			if not paramTable or not paramTable.noBlock then
				self:startViewOpenBlock()
			end

			local animatorPlayer = self:__getAnimatorPlayer()

			if not gohelper.isNil(animatorPlayer) then
				if paramTable then
					if not paramTable.anim then
						do
							local animName = "open"

							animatorPlayer:Play(animName, self.onPlayOpenTransitionFinish, self)
						end

						if paramTable then
							if not paramTable.duration then
								local duration = 2

								TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, duration)
							end
						end
					end
				end
			end
		else
			self:onPlayOpenTransitionFinish()
		end

		return
	end

	if not self._canvasGroup then
		self:onPlayOpenTransitionFinish()

		return
	end

	if not paramTable or not paramTable.noBlock then
		self:startViewOpenBlock()
	end

	self:_animSetAlpha(0.01, true)

	if self._viewSetting.customAnimFadeTime then
		if not self._viewSetting.customAnimFadeTime[1] then
			local openViewTime = BaseViewContainer.openViewTime
			local openViewEase = BaseViewContainer.openViewEase

			self._openAnimTweenId = ZProj.TweenHelper.DOTweenFloat(0.01, 1, openViewTime, self._onOpenTweenFrameCallback, self._onOpenTweenFinishCallback, self, nil, openViewEase)

			TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, 2)
		end
	end
end

function BaseViewContainer:onPlayOpenTransitionFinish()
	TaskDispatcher.cancelTask(self.onPlayOpenTransitionFinish, self)
	self:_cancelBlock()
	BaseViewContainer.superOnPlayOpenTransitionFinish(self)
end

function BaseViewContainer:_setAnimatorRes()
	if string.find(self._viewSetting.anim, ".controller") then
		local animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))

		animator.runtimeAnimatorController = self._abLoader:getAssetItem(self._viewSetting.anim):GetResource()
	end
end

function BaseViewContainer:__getAnimatorPlayer()
	if not self.__animatorPlayer and not gohelper.isNil(self.viewGO) then
		self.__animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	end

	return self.__animatorPlayer
end

function BaseViewContainer:_onOpenTweenFrameCallback(value)
	if self._viewStatus ~= BaseViewContainer.Status_Opening then
		return
	end

	self:_animSetAlpha(value, true)
end

function BaseViewContainer:_onOpenTweenFinishCallback()
	self._openAnimTweenId = nil

	if self._viewStatus ~= BaseViewContainer.Status_Opening then
		return
	end

	self:_animSetAlpha(1)
	self:onPlayOpenTransitionFinish()
end

function BaseViewContainer:_animSetAlpha(value, keepBg)
	self._canvasGroup.alpha = value

	do return end

	local bgs = self:_animGetBgs()

	if not bgs then
		return
	end

	for _, bg in pairs(bgs) do
		if bg.gameObject then
			bg:SetAlpha((keepBg or nil) and (value <= 0.0001 and 0 or 1 / value))
		end
	end
end

function BaseViewContainer:_animGetBgs()
	if not self._viewSetting.customAnimBg then
		return nil
	end

	if self._animBgs then
		return self._animBgs
	end

	self._animBgs = {}

	for _, path in ipairs(self._viewSetting.customAnimBg) do
		local go = gohelper.findChild(self.viewGO, path)

		if go then
			local cr = go:GetComponent(typeof(UnityEngine.CanvasRenderer))

			if cr then
				table.insert(self._animBgs, cr)
			end

			local crs = go:GetComponentsInChildren(typeof(UnityEngine.CanvasRenderer), true)
			local iter = crs:GetEnumerator()

			while iter:MoveNext() do
				table.insert(self._animBgs, iter.Current)
			end
		end
	end

	return self._animBgs
end

function BaseViewContainer:animBgUpdate()
	self._animBgs = nil
end

function BaseViewContainer:playCloseTransition(paramTable)
	self:_cancelBlock()
	self:_stopOpenCloseAnim()

	if not forceCloseAnimViewList then
		BaseViewContainer.initForceAnimViewList()
	end

	if (not self._viewSetting.anim or self._viewSetting.anim ~= ViewAnim.Default) and not LuaUtil.tableContains(forceCloseAnimViewList, self.viewName) then
		if not string.nilorempty(self._viewSetting.anim) then
			self:_setAnimatorRes()

			if not paramTable or not paramTable.noBlock then
				self:startViewCloseBlock()
			end

			local animatorPlayer = self:__getAnimatorPlayer()

			if not gohelper.isNil(animatorPlayer) then
				if paramTable then
					if not paramTable.anim then
						do
							local animName = "close"

							animatorPlayer:Play(animName, self.onPlayCloseTransitionFinish, self)
						end

						if paramTable then
							if not paramTable.duration then
								local duration = 2

								TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, duration)
							end
						end
					end
				end
			end
		else
			self:onPlayCloseTransitionFinish()
		end

		return
	end

	if not self._canvasGroup then
		self:onPlayCloseTransitionFinish()

		return
	end

	if not paramTable or not paramTable.noBlock then
		self:startViewCloseBlock()
	end

	self:_animSetAlpha(1)

	if self._viewSetting.customAnimFadeTime then
		if not self._viewSetting.customAnimFadeTime[2] then
			local closeViewTime = BaseViewContainer.closeViewTime
			local closeViewEase = BaseViewContainer.closeViewEase

			self._closeAnimTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, closeViewTime, self._onCloseTweenFrameCallback, self._onCloseTweenFinishCallback, self, nil, closeViewEase)

			TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 2)
		end
	end
end

function BaseViewContainer:onPlayCloseTransitionFinish()
	TaskDispatcher.cancelTask(self.onPlayCloseTransitionFinish, self)
	self:_cancelBlock()
	BaseViewContainer.superOnPlayCloseTransitionFinish(self)
end

function BaseViewContainer:_onCloseTweenFrameCallback(value)
	if self._viewStatus ~= BaseViewContainer.Status_Closing then
		return
	end

	self:_animSetAlpha(value)
end

function BaseViewContainer:_onCloseTweenFinishCallback()
	self._closeAnimTweenId = nil

	if self._viewStatus ~= BaseViewContainer.Status_Closing then
		return
	end

	self:_animSetAlpha(0)
	self:onPlayCloseTransitionFinish()
end

function BaseViewContainer:startViewOpenBlock()
	UIBlockMgr.instance:startBlock(self:_getViewOpenBlock())
end

function BaseViewContainer:startViewCloseBlock()
	UIBlockMgr.instance:startBlock(self:_getViewCloseBlock())
end

function BaseViewContainer:_cancelBlock()
	UIBlockMgr.instance:endBlock(self:_getViewOpenBlock())
	UIBlockMgr.instance:endBlock(self:_getViewCloseBlock())
end

function BaseViewContainer:_getViewOpenBlock()
	self._viewOpenBlock = self._viewOpenBlock or self.viewName .. "ViewOpenAnim"

	return self._viewOpenBlock
end

function BaseViewContainer:_getViewCloseBlock()
	self._viewCloseBlock = self._viewCloseBlock or self.viewName .. "ViewCloseAnim"

	return self._viewCloseBlock
end

function BaseViewContainer:_stopOpenCloseAnim()
	if self._openAnimTweenId then
		ZProj.TweenHelper.KillById(self._openAnimTweenId)

		self._openAnimTweenId = nil
	end

	if self._closeAnimTweenId then
		ZProj.TweenHelper.KillById(self._closeAnimTweenId)

		self._closeAnimTweenId = nil
	end

	if not gohelper.isNil(self.__animatorPlayer) then
		self.__animatorPlayer:Stop()
	end

	TaskDispatcher.cancelTask(self.onPlayOpenTransitionFinish, self)
	TaskDispatcher.cancelTask(self.onPlayCloseTransitionFinish, self)
end

function BaseViewContainer:_stopAllAnimatorPlayers()
	if not gohelper.isNil(self.viewGO) then
		local allAnimatorPlayers = self.viewGO:GetComponentsInChildren(TypeAnimatorPlayer, true)

		if allAnimatorPlayers then
			for i = 0, allAnimatorPlayers.Length - 1 do
				allAnimatorPlayers[i]:Stop()
			end
		end
	end
end

function BaseViewContainer:destroyView()
	self:_cancelBlock()
	self:_stopOpenCloseAnim()
	self:_stopAllAnimatorPlayers()

	self.__animatorPlayer = nil

	BaseViewContainer.superDestroyView(self)
end

function BaseViewContainer.activateCustom()
	return
end

return BaseViewContainer
