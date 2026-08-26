-- chunkname: @modules/logic/equip/view/EquipGetView.lua

module("modules.logic.equip.view.EquipGetView", package.seeall)

local EquipGetView = class("EquipGetView", BaseView)

function EquipGetView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_bg/#simage_bg")
	self._simagecircle = gohelper.findChildSingleImage(self.viewGO, "#go_bg/#simage_circle/circlewainew/circle")
	self._simageequipicon = gohelper.findChildSingleImage(self.viewGO, "equip/#simage_equipicon")
	self._simageblackbg = gohelper.findChildSingleImage(self.viewGO, "introduce/#simage_blackbg")
	self._txtcharacterNameCn = gohelper.findChildText(self.viewGO, "introduce/#txt_characterNameCn")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "introduce/#txt_characterNameCn/#image_career")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "introduce/#simage_icon")
	self._gostarList = gohelper.findChild(self.viewGO, "introduce/#go_starList")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipGetView:addEvents()
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function EquipGetView:removeEvents()
	self._btnskip:RemoveClickListener()
end

function EquipGetView:_btnskipOnClick()
	if self._isSummonTen then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonSkip)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
		self:closeThis()
	elseif not self._animFinish then
		self:_skipAnim()
	end
end

local UI_Max_Rare = 6

function EquipGetView:_editableInitView()
	self._animSkip = true
	self._goEquipRoot = gohelper.findChild(self.viewGO, "equip")
	self._goDetailRoot = gohelper.findChild(self.viewGO, "introduce")

	self._simagebg:LoadImage(ResUrl.getCommonViewBg("full/bg_characterget"))
	self._simagecircle:LoadImage(ResUrl.getCharacterGetIcon("bg_yuanchuan"))
	self._simageblackbg:LoadImage(ResUrl.getCharacterGetIcon("heisedi"))
	self._simageicon:LoadImage(ResUrl.getSignature("qm123"))

	for i = 1, UI_Max_Rare do
		self["_starGo" .. tostring(i)] = gohelper.findChild(self._gostarList, "star" .. tostring(i))
	end

	self._goeffectstarList = gohelper.findChild(self.viewGO, "#go_bg/xingxing")

	for i = 1, UI_Max_Rare do
		self["_starEffectGo" .. tostring(i)] = gohelper.findChild(self._goeffectstarList, "star" .. i)
	end

	self._bgClick = gohelper.getClickWithAudio(self._gobg)

	self._bgClick:AddClickListener(self._onBgClick, self)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._animEventWrap = self._animator:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("star", self._playStarAudio, self)
	self._animEventWrap:AddEventListener("skip", self._playSkip, self)

	self._videoGo = gohelper.findChild(self.viewGO, "#go_bg/videoplayer")

	NavigateMgr.instance:addEscape(self.viewName, self._onBgClick, self)
	self:setEquipShowVisible(false)
end

function EquipGetView:_initVideoPlayer()
	if self._videoPlayer then
		return
	end

	local parentGO = gohelper.findChild(self.viewGO, "#go_bg/videoplayer")

	self._videoPlayer = VideoPlayerMgr.instance:createGoAndVideoPlayer(parentGO)

	self._videoPlayer:setEventListener(self._videoStatusUpdate, self)
end

function EquipGetView:onDestroyView()
	NavigateMgr.instance:removeEscape(self.viewName, self._onBgClick, self)
	self._bgClick:RemoveClickListener()
	self._simagebg:UnLoadImage()
	self._simagecircle:UnLoadImage()
	self._simageblackbg:UnLoadImage()
	self._simageicon:UnLoadImage()
	self._simageequipicon:UnLoadImage()
	self._animEventWrap:RemoveAllEventListener()

	if self._animator then
		self._animator.enabled = false
	end

	if self._videoPlayer then
		if not BootNativeUtil.isIOS() then
			self._videoPlayer:stop()
		end

		self._videoPlayer:clear()

		self._videoPlayer = nil
	end

	TaskDispatcher.cancelTask(self._openAnimFinish, self)
end

function EquipGetView:_onBgClick()
	if self._animFinish then
		self:closeThis()
	elseif not self._animSkip then
		self:_skipAnim()
	end
end

function EquipGetView:onUpdateParam()
	self:onOpen()
end

function EquipGetView:onOpen()
	self._animFinish = false
	self._equipId = self.viewParam.equipId
	self._isSummonTen = self.viewParam.isSummonTen
	self._skipVideo = self.viewParam.skipVideo

	if not self._equipId then
		return
	end

	self._equipCo = EquipConfig.instance:getEquipCo(self._equipId)

	if self._equipCo then
		self._rare = self._equipCo.rare

		self:_refreshView()
	end

	if not self._skipVideo then
		-- block empty
	end

	self:_skipAnim()
end

function EquipGetView:onClose()
	return
end

function EquipGetView:setEquipShowVisible(visible)
	gohelper.setActive(self._goEquipRoot, visible)
	gohelper.setActive(self._goDetailRoot, visible)
end

function EquipGetView:_refreshView()
	self._playedStar = 0

	if self._equipCo then
		self._txtcharacterNameCn.text = self._equipCo.name

		EquipHelper.loadEquipCareerNewIcon(self._equipCo, self._imagecareer)
		self._simageequipicon:LoadImage(ResUrl.getEquipSuit(self._equipCo.icon))
		self:_applyStar()
	end

	gohelper.setActive(self._btnskip.gameObject, not SummonController.instance:isInSummonGuide() and not SummonModel.instance:getSendEquipFreeSummon())
end

function EquipGetView:_applyStar()
	local starCount = 1 + self._rare

	for i = 1, UI_Max_Rare do
		gohelper.setActive(self["_starGo" .. tostring(i)], i <= starCount)
		gohelper.setActive(self["_starEffectGo" .. tostring(i)], i <= starCount)
	end
end

function EquipGetView:_skipAnim()
	if not self._isSummonTen then
		gohelper.setActive(self._btnskip.gameObject, false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)

	self._animSkip = true

	self._animatorPlayer:Play("skip", self._openAnimFinish, self)
	self:setEquipShowVisible(true)
	gohelper.setActive(self._videoGo, false)
	self:_resetVideo()
end

function EquipGetView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.Started then
		self._animSkip = false

		self._animatorPlayer:Play(UIAnimationName.Open, self._openAnimFinish, self)

		self._animator.speed = 1

		self._animator:Play(UIAnimationName.Idle, 1, 0)

		if self._rare < 3 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Low_Hero)
		elseif self._rare < 5 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Middle_Hero)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_High_Hero)
		end

		self:setEquipShowVisible(true)
	elseif status == VideoEnum.PlayerStatus.FinishedPlaying then
		if not self._isSummonTen then
			gohelper.setActive(self._btnskip.gameObject, false)
		end

		self:setEquipShowVisible(true)
		self:_resetVideo()
	end
end

function EquipGetView:_resetVideo()
	gohelper.setActive(self._videoGo, false)

	if not self._videoPlayer then
		return
	end

	if BootNativeUtil.isAndroid() or BootNativeUtil.isWindows() then
		self._videoPlayer:stop()
	else
		self._videoPlayer:stop()
	end
end

function EquipGetView:_playOpenAnimation()
	gohelper.setActive(self._simageequipicon.gameObject, false)
	TaskDispatcher.cancelTask(self._openAnimFinish, self)

	if self._animator then
		self._animator.enabled = true

		self._animator:Play(UIAnimationName.Open, 0, 0)
		self._animator:Play(UIAnimationName.Idle, 1, 0)

		self._animator.speed = 0

		self._animator:Update(0)
	end

	self._animatorPlayer:Play(UIAnimationName.Open, self._openAnimFinish, self)
	gohelper.setActive(self._videoGo, true)
	self:_initVideoPlayer()
	self._videoPlayer:loadMedia("character_get_start")
	self._videoPlayer.play(self._videoPlayer._url, false, self._videoStatusUpdate, self)
	TaskDispatcher.runDelay(self._openAnimFinish, self, 10)
end

function EquipGetView:_playStarAudio()
	local starCount = 1 + self._rare

	if starCount <= self._playedStar then
		return
	end

	self._playedStar = self._playedStar + 1

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Hero_Stars)
	gohelper.setActive(self._simageequipicon.gameObject, true)
end

function EquipGetView:_openAnimFinish()
	self._animSkip = true

	TaskDispatcher.cancelTask(self._openAnimFinish, self)

	if self._animator then
		self._animator.enabled = true

		self._animator:Play(UIAnimationName.Loop, 0, 0)
		self._animator:Play(UIAnimationName.Voice, 1, 0)
	end

	self._animFinish = true

	SummonController.instance:dispatchEvent(SummonEvent.onSummonEquipSingleFinish)
end

function EquipGetView:_playSkip()
	self._animSkip = true

	logNormal("draw in rare : " .. tostring(self._rare))

	if self._rare < 3 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_General_Last)
	elseif self._rare < 5 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Medium_Last)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Special_Last)
	end
end

return EquipGetView
