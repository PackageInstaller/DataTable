-- chunkname: @modules/logic/main/view/MainThumbnailView.lua

module("modules.logic.main.view.MainThumbnailView", package.seeall)

local MainThumbnailView = class("MainThumbnailView", BaseView)

function MainThumbnailView:onInitView()
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "#simage_leftbg")
	self._goplayerinfo = gohelper.findChild(self.viewGO, "#go_playerinfo")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "#simage_signature")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_playerinfo/#txt_name")
	self._txtlevel = gohelper.findChildText(self.viewGO, "#go_playerinfo/#txt_level")
	self._txtid = gohelper.findChildText(self.viewGO, "#go_playerinfo/#txt_id")
	self._gobanner = gohelper.findChild(self.viewGO, "#go_banner")
	self._goslider = gohelper.findChild(self.viewGO, "#go_banner/#go_slider")
	self._gobannerscroll = gohelper.findChild(self.viewGO, "#go_banner/#go_bannerscroll")
	self._gobannercontent = gohelper.findChild(self.viewGO, "#go_banner/#go_bannercontent")
	self._gospinescale = gohelper.findChild(self.viewGO, "#go_spine_scale")
	self._golightspine = gohelper.findChild(self.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	self._golightspinecontrol = gohelper.findChild(self.viewGO, "#go_lightspinecontrol")
	self._gocontentbg = gohelper.findChild(self.viewGO, "bottom/#go_contentbg")
	self._txtanacn = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_cn")
	self._txtanaen = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_en")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_switch")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_playerinfo/#btn_detail")
	self._goplayinforeddotparent = gohelper.findChild(self.viewGO, "#go_playerinfo/#btn_detail/#go_playinforeddot")
	self._goscroll = gohelper.findChild(self.viewGO, "btns/#go_scroll")
	self._gocontent = gohelper.findChild(self.viewGO, "btns/#go_content")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnblank = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_blank")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainThumbnailView:addEvents()
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnblank:AddClickListener(self._btnblankOnClick, self)
end

function MainThumbnailView:removeEvents()
	self._btnswitch:RemoveClickListener()
	self._btndetail:RemoveClickListener()
	self._btnblank:RemoveClickListener()
end

function MainThumbnailView:_btnblankOnClick()
	if self._animator.enabled or self._cameraAnimator.enabled then
		if not self._checkCloseTime then
			self._checkCloseTime = Time.realtimeSinceStartup

			return
		end

		if Time.realtimeSinceStartup - self._checkCloseTime <= 2 then
			return
		end
	end

	self:closeThis()
end

function MainThumbnailView:_btndetailOnClick()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	PlayerController.instance:openPlayerView(playerInfo, true)
end

function MainThumbnailView:_btnswitchOnClick()
	UIBlockHelper.instance:startBlock("MainThumbnailView_CloseAnim", 0.8)

	local player = SLFramework.AnimatorPlayer.Get(self.viewGO)

	player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
	TaskDispatcher.cancelTask(self.onPlayCloseTransitionFinish, self)
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.3)
end

function MainThumbnailView:onPlayCloseTransitionFinish()
	TaskDispatcher.cancelTask(self.onPlayCloseTransitionFinish, self)
	ViewMgr.instance:openTabView(ViewName.MainSwitchView, nil, nil, 1)
end

function MainThumbnailView:_editableInitView()
	self._festivalAtmosphereComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, FestivalAtmosphereComp, self)

	self:_onChangePlayerName()

	self._txtlevel.text = string.format("<size=19>LV</size>.%s", PlayerModel.instance:getPlayinfo().level)
	self._txtid.text = string.format("ID:%s", PlayerModel.instance:getPlayinfo().userId)

	self._simageleftbg:LoadImage(ResUrl.getMainImage("bg_hd"))

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	self._simagelogoGo = gohelper.findChild(self.viewGO, "#simage_logo")
	self._simageactbgGo = gohelper.findChild(self.viewGO, "#simage_actbg")

	self:RefreshSignature()
	gohelper.addUIClickAudio(self._btndetail.gameObject, AudioEnum.UI.Play_UI_Magazines)
end

function MainThumbnailView:_getFormatStr(content)
	if string.nilorempty(content) then
		return ""
	end

	local first = GameUtil.utf8sub(content, 1, 1)

	return string.format("<size=62>%s</size>%s", first, (GameUtil.utf8len(content) >= 2 or nil) and GameUtil.utf8sub(content, 2, GameUtil.utf8len(content) - 1))
end

function MainThumbnailView:onUpdate()
	return
end

function MainThumbnailView:RefreshSignature()
	local heroId = CharacterSwitchListModel.instance:getMainHero()
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo then
		return
	end

	self._simagesignature:LoadImage(ResUrl.getSignature(heroMo.config.signature))
end

function MainThumbnailView:onOpen()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.MainThumbnailSignature, self.RefreshSignature, self)
	self.addEventCb(self, PlayerController.instance, PlayerEvent.ChangePlayerName, self._onChangePlayerName, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._freshBtns, self)

	self.playerInfoRedDot = RedDotController.instance:addNotEventRedDot(self._goplayinforeddotparent, PlayerModel.isHasAssistReward, PlayerModel.instance)

	self.addEventCb(self, PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, self.refreshRedDot, self)
	self:_freshBtns()

	local isReview = VersionValidator.instance:isInReviewing()

	gohelper.setActive(self._gobanner, not isReview)

	if self.viewParam and self.viewParam.isSwitch then
		self:_justSwithView()
	end
end

function MainThumbnailView:_justSwithView()
	local player = SLFramework.AnimatorPlayer.Get(self.viewGO)

	player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
	TaskDispatcher.cancelTask(self._justSwithViewCb, self)
	TaskDispatcher.runDelay(self._justSwithViewCb, self, 0.3)
end

function MainThumbnailView:_justSwithViewCb()
	if self.viewParam and self.viewParam.jumpTabs then
		if self.viewParam.jumpTabs then
			ViewMgr.instance:openTabView(ViewName.MainSwitchView, self.viewParam, nil, self.viewParam.jumpTabs or 1)
		end
	end
end

function MainThumbnailView:_freshBtns()
	self:_checkActivityImgVisible()
end

function MainThumbnailView:_checkActivityImgVisible()
	local isShow = ActivityModel.showActivityEffect()

	self._festivalAtmosphereComp:setFestival(isShow)
end

function MainThumbnailView:refreshRedDot()
	if not self.playerInfoRedDot then
		return
	end

	self.playerInfoRedDot:refreshRedDot()
end

function MainThumbnailView:_onChangePlayerName()
	local name = PlayerModel.instance:getPlayinfo().name

	self._txtname.text = self:_getFormatStr(name)
end

function MainThumbnailView:onClose()
	UIBlockMgr.instance:endBlock("MainThumbnailView_CloseAnim")
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.MainThumbnailSignature, self.RefreshSignature, self)
	TaskDispatcher.cancelTask(self._justSwithViewCb, self)
end

function MainThumbnailView:onDestroyView()
	self._simagesignature:UnLoadImage()
	self._simageleftbg:UnLoadImage()
	self._festivalAtmosphereComp:onDestroy()
end

return MainThumbnailView
