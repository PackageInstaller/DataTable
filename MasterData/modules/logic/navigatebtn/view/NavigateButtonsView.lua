-- chunkname: @modules/logic/navigatebtn/view/NavigateButtonsView.lua

module("modules.logic.navigatebtn.view.NavigateButtonsView", package.seeall)

local NavigateButtonsView = class("NavigateButtonsView", BaseView)

function NavigateButtonsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnhome = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_home")
	self._btnhelp = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_help")
	self._imageclose = gohelper.findChildImage(self.viewGO, "#btn_close")
	self._imagehome = gohelper.findChildImage(self.viewGO, "#btn_home")
	self._imagehelp = gohelper.findChildImage(self.viewGO, "#btn_help")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NavigateButtonsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnhome:AddClickListener(self._btnhomeOnClick, self)
	self._btnhelp:AddClickListener(self._btnhelpOnClick, self)
end

function NavigateButtonsView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnhome:RemoveClickListener()
	self._btnhelp:RemoveClickListener()
end

NavigateButtonsView.DefaultHelpId = 100

function NavigateButtonsView:ctor(param, helpId, closeCallback, homeCallback, helpCallback, callbackObj, useLightBtn)
	self.param = not param and {
		true,
		true,
		true
	} or param
	self.helpId = not helpId and NavigateButtonsView.DefaultHelpId or helpId
	self._useLightBtn = useLightBtn == nil and true or useLightBtn
	self._extendBtns = self:getUserDataTb_()
	self._closeCallback = closeCallback
	self._homeCallback = homeCallback
	self._helpCallback = helpCallback
	self._callbackObj = callbackObj
	self._animEnabled = true
	self.initDone = false
	self.needReplaceCloseBtnAudioId = false
	self.replaceCloseBtnAudioId = 0
	self.needReplaceHomeBtnAudioId = false
	self.replaceHomeBtnAudioId = 0
	self.needReplaceHelpBtnAudioId = false
	self.replaceHelpBtnAudioId = 0
end

function NavigateButtonsView:setOpenCallback(callback, callbackTarget)
	if self._has_onOpen then
		if callback then
			callback(callbackTarget)
		end

		return
	end

	self._openCallback = callback
	self._openCallbackTarget = callbackTarget
end

function NavigateButtonsView:addExtendBtn(siblingIndex, iconName, callback, callbackTarget)
	local btnParams = self._extendBtns[siblingIndex]

	if btnParams then
		return btnParams[1]
	end

	local extendBtnGo = gohelper.cloneInPlace(self._btnhelp.gameObject)

	gohelper.setActive(extendBtnGo, true)
	gohelper.addUIClickAudio(extendBtnGo)

	local extendBtn = SLFramework.UGUI.ButtonWrap.Get(extendBtnGo)

	extendBtn:AddClickListener(self._extendBtnClick, self, siblingIndex)

	self._extendBtns[siblingIndex] = {
		extendBtn,
		callback,
		callbackTarget
	}

	if iconName then
		local img = extendBtn:GetComponent(gohelper.Type_Image)

		UISpriteSetMgr.instance:setCommonSprite(img, iconName)
	end

	gohelper.setSibling(extendBtnGo, siblingIndex)

	return extendBtn
end

function NavigateButtonsView:getExtendBtn(index)
	local btnParams = self._extendBtns[index]

	if btnParams then
		return btnParams[1]
	end
end

function NavigateButtonsView:_extendBtnClick(index)
	local btnParams = self._extendBtns[index]

	if not btnParams then
		return
	end

	local callback = btnParams[2]
	local callbackTarget = btnParams[3]

	if callback then
		callback(callbackTarget)
	end
end

function NavigateButtonsView:setLight(useLightBtn)
	self._useLightBtn = useLightBtn == nil and true or useLightBtn
end

function NavigateButtonsView:setCloseCheck(closeCheckFunc, closeCheckObj)
	self._closeCheckFunc = closeCheckFunc
	self._closeCheckObj = closeCheckObj
end

function NavigateButtonsView:setHomeCheck(homeCheckFunc, homeCheckObj)
	self._homeCheckFunc = homeCheckFunc
	self._homeCheckObj = homeCheckObj
end

function NavigateButtonsView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
	self._overrideCloseFunc = overrideCloseFunc
	self._overrideCloseObj = overrideCloseObj
end

function NavigateButtonsView:setOverrideHome(overrideHomeFunc, overrideHomeObj)
	self._overrideHomeFunc = overrideHomeFunc
	self._overrideHomeFuncObj = overrideHomeObj
end

function NavigateButtonsView:setOverrideHelp(overrideHelpFunc, overrideHelpObj)
	self._overrideHelpFunc = overrideHelpFunc
	self._overrideHelpObj = overrideHelpObj
end

function NavigateButtonsView:setHelpId(helpId)
	if self.helpId == helpId then
		return
	end

	self.helpId = helpId

	self:setParam({
		self.param[1],
		self.param[2],
		true
	})
end

function NavigateButtonsView:hideHelpIcon()
	if self.helpId == NavigateButtonsView.DefaultHelpId then
		return
	end

	self.helpId = NavigateButtonsView.DefaultHelpId

	self:setParam({
		self.param[1],
		self.param[2],
		false
	})
end

function NavigateButtonsView:setAnimEnabled(value)
	self._animEnabled = value
end

function NavigateButtonsView:_onEscBtnClick()
	if self.param[1] and self._btnclose.gameObject.activeInHierarchy then
		self:_btncloseOnClick()
	end
end

function NavigateButtonsView:_btncloseOnClick()
	if self._closeCheckFunc and not self._closeCheckFunc(self._closeCheckObj, self._reallyClose, self) then
		return
	end

	if self._overrideCloseFunc then
		self._overrideCloseFunc(self._overrideCloseObj)

		return
	end

	self:_reallyClose()
end

function NavigateButtonsView:_reallyClose()
	local viewName = self.viewContainer.viewName

	if ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:closeView(viewName, nil, true)
	end

	if self._closeCallback then
		self._closeCallback(self._callbackObj)
	end
end

function NavigateButtonsView:_btnhomeOnClick()
	if self._homeCheckFunc and not self._homeCheckFunc(self._homeCheckObj, self._reallyHome, self) then
		return
	end

	if self._overrideHomeFunc then
		self._overrideHomeFunc(self._overrideHomeFuncObj)

		return
	end

	self:_reallyHome()
end

function NavigateButtonsView:_reallyHome()
	NavigateButtonsView.homeClick()

	if self._homeCallback then
		self._homeCallback(self._callbackObj)
	end
end

function NavigateButtonsView.homeClick()
	NavigateMgr.instance:dispatchEvent(NavigateEvent.BeforeClickHome)

	DungeonModel.instance.curSendEpisodeId = nil

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomController.instance:homeClick()
	else
		ViewMgr.instance:closeAllPopupViews(nil, true)
		MainController.instance:enterMainScene(true, false)

		local curScene = GameSceneMgr.instance:getCurSceneType()
		local isOpenMain = ViewMgr.instance:isOpen(ViewName.MainView)
		local dontOpenMain = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DontOpenMain)

		if not isOpenMain and curScene == SceneType.Main and not dontOpenMain then
			ViewMgr.instance:openView(ViewName.MainView)
		elseif isOpenMain and dontOpenMain then
			ViewMgr.instance:closeView(ViewName.MainView)
		end
	end

	NavigateMgr.instance:dispatchEvent(NavigateEvent.ClickHome)
end

function NavigateButtonsView:_btnhelpOnClick()
	if not HelpController.instance:checkGuideStepLock(self.helpId) then
		return
	end

	if self._overrideHelpFunc then
		self._overrideHelpFunc(self._overrideHelpObj)

		return
	end

	HelpController.instance:showHelp(self.helpId)

	if self._helpCallback then
		self._helpCallback(self._callbackObj)
	end
end

function NavigateButtonsView:_changeIconState()
	if not self._initialized then
		return
	end

	if self._useLightBtn then
		UISpriteSetMgr.instance:setCommonSprite(self._imageclose, "btn_back_light")
		UISpriteSetMgr.instance:setCommonSprite(self._imagehome, "btn_home_light")
	else
		UISpriteSetMgr.instance:setCommonSprite(self._imageclose, "btn_back_dark")
		UISpriteSetMgr.instance:setCommonSprite(self._imagehome, "btn_home_dark")
	end
end

function NavigateButtonsView:_editableInitView()
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(self._btnhome.gameObject, AudioEnum.UI.play_ui_common_pause)

	self._initialized = true

	self:refreshUI()

	self.initDone = true
end

function NavigateButtonsView:refreshUI()
	gohelper.setActive(self._btnclose and self._btnclose.gameObject, self.param[1])
	gohelper.setActive(self._btnhome and self._btnhome.gameObject, self.param[2])
	self:_updateHelpBtn()
end

function NavigateButtonsView:_updateHelpBtn()
	if self._helpVisible then
		gohelper.setActive(self._btnhelp and self._btnhelp.gameObject, self._helpVisible)
	else
		gohelper.setActive(self._btnhelp and self._btnhelp.gameObject, self.param[3] and HelpController.instance:checkGuideStepLock(self.helpId))
	end
end

function NavigateButtonsView:setParam(param)
	self.param = param

	self:refreshUI()
end

function NavigateButtonsView:showHelpBtnIcon()
	self:setParam({
		self.param[1],
		self.param[2],
		true
	})
end

function NavigateButtonsView:changerHelpId(helpId)
	self.helpId = helpId

	self:showHelpBtnIcon()
end

function NavigateButtonsView:resetCloseBtnAudioId(audioId)
	if self.initDone then
		self:_resetCloseBtnAudioId(audioId)
	else
		self.needReplaceCloseBtnAudioId = true
		self.replaceCloseBtnAudioId = audioId
	end
end

function NavigateButtonsView:_resetCloseBtnAudioId(audioId)
	if audioId ~= 0 then
		gohelper.addUIClickAudio(self._btnclose.gameObject, audioId)
	else
		gohelper.removeUIClickAudio(self._btnclose.gameObject)
	end
end

function NavigateButtonsView:resetHomeBtnAudioId(audioId)
	if self.initDone then
		self:_resetHomeBtnAudioId(audioId)
	else
		self.needReplaceHomeBtnAudioId = true
		self.replaceHomeBtnAudioId = audioId
	end
end

function NavigateButtonsView:_resetHomeBtnAudioId(audioId)
	if audioId ~= 0 then
		gohelper.addUIClickAudio(self._btnhome.gameObject, audioId)
	else
		gohelper.removeUIClickAudio(self._btnhome.gameObject)
	end
end

function NavigateButtonsView:resetHelpBtnAudioId(audioId)
	if self.initDone then
		self:_resetHelpBtnAudioId(audioId)
	else
		self.needReplaceHelpBtnAudioId = true
		self.replaceHelpBtnAudioId = audioId
	end
end

function NavigateButtonsView:_resetHelpBtnAudioId(audioId)
	if audioId ~= 0 then
		gohelper.addUIClickAudio(self._btnhelp.gameObject, audioId)
	else
		gohelper.removeUIClickAudio(self._btnhelp.gameObject)
	end
end

function NavigateButtonsView:setHelpVisible(value)
	self._helpVisible = value

	if not self._btnhelp then
		return
	end

	gohelper.setActive(self._btnhelp.gameObject, value)
end

function NavigateButtonsView:resetOnCloseViewAudio(audioId)
	self:resetCloseBtnAudioId(audioId)
	self:resetHomeBtnAudioId(audioId)
end

function NavigateButtonsView:onDestroyView()
	for k, v in pairs(self._extendBtns) do
		local btn = v[1]

		btn:RemoveClickListener()
	end
end

function NavigateButtonsView:onOpen()
	if self._anim and self._animEnabled then
		self._anim:Play(UIAnimationName.Open, 0, 0)
	end

	NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onEscBtnClick, self, true)

	if self.needReplaceCloseBtnAudioId then
		self:_resetCloseBtnAudioId(self.replaceCloseBtnAudioId)

		self.needReplaceCloseBtnAudioId = false
	end

	if self.needReplaceHomeBtnAudioId then
		self:_resetHomeBtnAudioId(self.replaceHomeBtnAudioId)

		self.needReplaceHomeBtnAudioId = false
	end

	if self.needReplaceHelpBtnAudioId then
		self:_resetHomeBtnAudioId(self.replaceHelpBtnAudioId)

		self.needReplaceHelpBtnAudioId = false
	end

	if self._openCallback then
		self._openCallback(self._openCallbackTarget)
	end

	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self._gudieEnd, self)
end

function NavigateButtonsView:_gudieEnd()
	self:_updateHelpBtn()
end

function NavigateButtonsView:onClose()
	if self._anim and self._animEnabled then
		self._anim:Play(UIAnimationName.Close, 0, 0)
	end
end

NavigateButtonsView.prefabPath = "ui/viewres/common/commonbtnsview.prefab"

return NavigateButtonsView
