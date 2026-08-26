-- chunkname: @modules/logic/versionactivity1_5/peaceulu/view/PeaceUluView.lua

module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluView", package.seeall)

local PeaceUluView = class("PeaceUluView", BaseView)

function PeaceUluView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._golightspinecontrol = gohelper.findChild(self.viewGO, "#go_role/#go_lightspinecontrol")
	self._gospinescale = gohelper.findChild(self.viewGO, "#go_role/#go_spine_scale")
	self._golightspine = gohelper.findChild(self.viewGO, "#go_role/#go_spine_scale/lightspine/#go_lightspine")
	self._txtanacn = gohelper.findChildText(self.viewGO, "bottom/#txt_Dialouge")
	self._txtanaen = gohelper.findChildText(self.viewGO, "bottom/#txt_Dialouge/#txt_DialougeEn")
	self._gocontentbg = gohelper.findChild(self.viewGO, "bottom")
	self._gobubble = gohelper.findChild(self.viewGO, "#go_Bubble")
	self._txtbubble = gohelper.findChildText(self.viewGO, "#go_Bubble/node/#scroll_bubble/Viewport/Content/#txt_BubbleTips")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.tweenDuration = 0.3

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PeaceUluView:addEvents()
	self.addEventCb(self, PeaceUluController.instance, PeaceUluEvent.onSwitchTab, self._toSwitchTab, self)
	self.addEventCb(self, PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, self._checkVoice, self)
	self.addEventCb(self, PeaceUluController.instance, PeaceUluEvent.playVoice, self.playVoice, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function PeaceUluView:removeEvents()
	self.removeEventCb(self, PeaceUluController.instance, PeaceUluEvent.onSwitchTab, self._toSwitchTab, self)
	self.removeEventCb(self, PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, self._checkVoice, self)
	self.removeEventCb(self, PeaceUluController.instance, PeaceUluEvent.playVoice, self.playVoice, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function PeaceUluView:onOpen()
	self.jumpparam = self.viewParam.param

	self:_updateHero(PeaceUluEnum.RoleID.Idle)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_arena_open)
end

function PeaceUluView:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self._golightspinecontrol)

	self._click:AddClickListener(self._onClickHero, self)
	gohelper.setActive(self._gocontentbg, false)
	gohelper.setActive(self._gobubble, false)
end

function PeaceUluView:_updateHero(skinId)
	self._skinId = skinId

	local heroConfig = HeroConfig.instance:getHeroCO(self._heroId)
	local skinCo = SkinConfig.instance:getSkinCo(self._skinId)

	self._heroId = skinCo.characterId
	self._heroSkinConfig = skinCo
	self._uiSpine = self._uiSpine or GuiModelAgent.Create(self._golightspine, true)

	self._uiSpine:setResPath(skinCo, self._onLightSpineLoaded, self)
end

function PeaceUluView:_playVoice(config, isFirst, callback)
	if not self._uiSpine or not config then
		return
	end

	if self._uiSpine:isPlayingVoice() then
		self._uiSpine:stopVoice()
	end

	if isFirst then
		gohelper.setActive(self._gobubble, false)
		self._uiSpine:playVoice(config, callback, self._txtanacn, self._txtanaen, self._gocontentbg)
	else
		self._uiSpine:playVoice(config, callback, self._txtbubble, nil, self._gobubble, true)
	end
end

function PeaceUluView:_onLightSpineLoaded()
	self._uiSpine:setModelVisible(true)

	self._l2d = self._uiSpine:_getLive2d()

	function self._opencallack()
		TaskDispatcher.cancelTask(self._opencallack, self)

		local voiceCo = self:_getVoiceCoByType(PeaceUluEnum.VoiceType.FirstEnterView)

		gohelper.setActive(self._gobubble, true)
		self:_playVoice(voiceCo)
	end

	TaskDispatcher.runDelay(self._opencallack, self, 0.2)

	if self.jumpparam == VersionActivity1_5Enum.ActivityId.PeaceUlu then
		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Game)
	end
end

function PeaceUluView:_toSwitchTab(tabIndex)
	gohelper.setActive(self._gobubble, false)

	if self._uiSpine:isPlayingVoice() then
		self._uiSpine:stopVoice()
	end

	if tabIndex == PeaceUluEnum.TabIndex.Game then
		self._animator:Play("startin", 0, 0)
		self._animator:Update(0)
	elseif tabIndex == PeaceUluEnum.TabIndex.Main then
		self._animator:Play("open", 0, 0)
		self._animator:Update(0)

		local currentAnimatorStateInfo = self._animator:GetCurrentAnimatorStateInfo(0)
		local length = currentAnimatorStateInfo.length

		self._animator:Play("open", 0, 0.3333333333333333 * length)
		self._animator:Update(0)
	end
end

function PeaceUluView:_getVoiceCoByType(voiceType)
	local config = PeaceUluConfig.instance:getVoiceConfigByType(voiceType)
	local voiceCo = PeaceUluVoiceCo.New()
	local var_11_0 = {
		content = config.content,
		motion = config.motion
	}

	var_11_0.displayTime = config.displayTime or 2

	voiceCo:init(var_11_0)

	return voiceCo
end

function PeaceUluView:playVoice(voiceType)
	if not voiceType then
		return
	end

	local voiceCo = self:_getVoiceCoByType(voiceType)

	self:_playVoice(voiceCo)
end

function PeaceUluView:_checkVoice()
	local haveTimes = PeaceUluModel.instance:getGameHaveTimes()
	local state = haveTimes ~= 0 or PeaceUluModel.instance:checkCanRemove()

	if PeaceUluTaskModel.instance:checkAllTaskFinished() and state then
		local voiceCo = self:_getVoiceCoByType(PeaceUluEnum.VoiceType.CanRemoveButFinish)

		self:_playVoice(voiceCo)
	end
end

function PeaceUluView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView and PeaceUluModel.instance:checkBonusIds() then
		local function callback()
			PeaceUluModel.instance:cleanBonusIds()
		end

		local voiceCo = self:_getVoiceCoByType(PeaceUluEnum.VoiceType.GetReward)

		self:_playVoice(voiceCo, false, callback)
	elseif viewName == ViewName.CommonPropView and PeaceUluModel.instance:checkTaskId() then
		if self._uiSpine:isPlayingVoice() then
			return
		end

		local function callback()
			PeaceUluModel.instance:cleanTaskId()
		end

		local voiceCo = self:_getVoiceCoByType(PeaceUluEnum.VoiceType.RemoveTask)

		self:_playVoice(voiceCo, false, callback)
	end
end

function PeaceUluView:onClose()
	TaskDispatcher.cancelTask(self._enterGameView, self)
	TaskDispatcher.cancelTask(self._opencallack, self)
	self._click:RemoveClickListener()
end

function PeaceUluView:onDestroyView()
	return
end

return PeaceUluView
