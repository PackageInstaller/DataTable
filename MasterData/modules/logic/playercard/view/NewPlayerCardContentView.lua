-- chunkname: @modules/logic/playercard/view/NewPlayerCardContentView.lua

module("modules.logic.playercard.view.NewPlayerCardContentView", package.seeall)

local NewPlayerCardContentView = class("NewPlayerCardContentView", BaseView)

function NewPlayerCardContentView:onInitView()
	self._goContent = gohelper.findChild(self.viewGO, "view")
	self._goLoading = gohelper.findChild(self.viewGO, "loadingmainview")
	self._loadAnim = self._goLoading:GetComponent(typeof(UnityEngine.Animator))
	self._goBottom = gohelper.findChild(self.viewGO, "bottom")
	self._btnbottomclose = gohelper.findChildButton(self.viewGO, "bottom/#btn_bottomclose")
	self._goskinpreviewnode = gohelper.findChild(self.viewGO, "bottom/#go_skinpreview")
	self._btnswitchskin = gohelper.findChildButton(self.viewGO, "#btn_switch")
	self._goswitchskinreddot = gohelper.findChild(self.viewGO, "#btn_switch/#go_reddot")
	self._btnsettingskin = gohelper.findChildButton(self.viewGO, "#btn_setting")
	self._gosettingreddot = gohelper.findChild(self.viewGO, "#btn_setting/#go_reddot")
	self._bgreddot = RedDotController.instance:addNotEventRedDot(self._goswitchskinreddot, self._isShowRedDot, self)
	self._openswitchskin = false
	self._firstopen = true
	self._bottomAnimator = self._goBottom:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NewPlayerCardContentView:addEvents()
	self._btnbottomclose:AddClickListener(self._btnswitchskinOnClick, self)
	self._btnswitchskin:AddClickListener(self._btnswitchskinOnClick, self)
	self._btnsettingskin:AddClickListener(self._btnsettingOnClick, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SwitchTheme, self.SwitchTheme, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.ChangeSkin, self.ChangeSkin, self)
end

function NewPlayerCardContentView:removeEvents()
	self._btnbottomclose:RemoveClickListener()
	self._btnswitchskin:RemoveClickListener()
	self._btnsettingskin:RemoveClickListener()
	self.removeEventCb(self, PlayerCardController.instance, PlayerCardEvent.SwitchTheme, self.SwitchTheme, self)
	self.removeEventCb(self, PlayerCardController.instance, PlayerCardEvent.ChangeSkin, self.ChangeSkin, self)
end

function NewPlayerCardContentView:_btnsettingOnClick()
	if not self._tempSkinId then
		local skinId = self.skinId

		ViewMgr.instance:openView(ViewName.PlayerCardEnterSettingView, {
			SkinId = skinId,
			playercardinfo = self.playercardinfo
		})

		local isNew = PlayerCardModel.instance:isShowEnterAnimSettingNewReddot(skinId)

		if isNew then
			PlayerCardModel.instance:cancelShowEnterAnimSettingNewReddot(skinId)
			PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCancelShowEnterAnimSettingNewReddot)
		end

		gohelper.setActive(self._gosettingreddot.gameObject, false)
	end
end

function NewPlayerCardContentView:_editableInitView()
	return
end

function NewPlayerCardContentView:onUpdateParam()
	return
end

function NewPlayerCardContentView:_isShowRedDot()
	return PlayerCardModel.instance:getShowRed()
end

function NewPlayerCardContentView:onOpen()
	if self.viewParam and self.viewParam.userId then
		self.userId = self.viewParam.userId
	end

	self.playercardinfo = PlayerCardModel.instance:getCardInfo(self.userId)

	gohelper.setActive(self._goBottom, self._openswitchskin)

	local themeInfo = self:_getThemeInfo(self.userId)

	if themeInfo then
		if not themeInfo.BtnDelayShowTime then
			local delayShowTime = 0

			TaskDispatcher.cancelTask(self._showSwitchBtn, self)

			if self.playercardinfo:isSelf() then
				gohelper.setActive(self._btnswitchskin.gameObject, self.playercardinfo:isSelf())

				if delayShowTime > 0 then
					gohelper.setActive(self._btnswitchskin.gameObject, false)
					TaskDispatcher.runDelay(self._showSwitchBtn, self, delayShowTime)
				else
					self:_showSwitchBtn()
				end
			else
				gohelper.setActive(self._btnswitchskin.gameObject, false)
			end

			self.skinId = self.playercardinfo:getThemeId()

			self:loadRes(self.skinId)
			self:_initSkinPreView()
		end
	end
end

function NewPlayerCardContentView:_getThemeInfo(userid)
	local cardInfo = PlayerCardModel.instance:getCardInfo(userid)
	local themeId = cardInfo and cardInfo:getThemeId()

	if themeId then
		return PlayerCardEnum.Theme[themeId]
	end
end

function NewPlayerCardContentView:_showSwitchBtn()
	gohelper.setActive(self._btnswitchskin.gameObject, true)
end

function NewPlayerCardContentView:_initSkinPreView()
	local otherResPath = self.viewContainer:getSetting().otherRes.skinpreview
	local otherRes = self.viewContainer:getRes(otherResPath)

	self.goskinpreview = gohelper.clone(otherRes, self._goskinpreviewnode)
	self.skinpreviewcls = MonoHelper.addNoUpdateLuaComOnceToGo(self.goskinpreview, PlayerCardSkinPreView)
	self._skinCls = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, PlayerCardThemeView)
	self._skinCls.viewParam = self.viewParam

	self._skinCls:canOpen()
end

function NewPlayerCardContentView:loadRes(skinId)
	local pathname = "playercardview"

	if not string.nilorempty(skinId) and skinId ~= 0 then
		pathname = pathname .. "_" .. skinId
	end

	self._path = string.format("ui/viewres/player/playercard/%s.prefab", pathname)
	self._loader = MultiAbLoader.New()

	self._loader:addPath(self._path)
	self._loader:startLoad(self._onLoadFinish, self)
	self.viewContainer:setShowSkinId(skinId)

	local isSelf = self.playercardinfo:isSelf()
	local themeInfo = PlayerCardEnum.Theme[skinId]
	local isSettingEnterAnim = isSelf and themeInfo and themeInfo.EnterAnim ~= nil

	gohelper.setActive(self._btnsettingskin.gameObject, isSettingEnterAnim)

	if isSettingEnterAnim then
		local isNew = PlayerCardModel.instance:isShowEnterAnimSettingNewReddot(skinId)

		gohelper.setActive(self._gosettingreddot.gameObject, isNew)
	end
end

function NewPlayerCardContentView:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._path)
	local viewPrefab = assetItem:GetResource(self._path)

	self._viewGo = gohelper.clone(viewPrefab, self._goContent)

	if not self._tempSkinId then
		local skinId = self.skinId

		if not _G["NewPlayerCardView_" .. skinId] then
			local playerCardViewClass = NewPlayerCardView

			self._viewCls = MonoHelper.addNoUpdateLuaComOnceToGo(self._viewGo, playerCardViewClass)
			self._achievementCls = MonoHelper.addNoUpdateLuaComOnceToGo(self._viewGo, PlayerCardAchievement)
			self._infoCls = MonoHelper.addNoUpdateLuaComOnceToGo(self._viewGo, PlayerCardPlayerInfo)
			self._viewCls.viewParam = self.viewParam
			self._viewCls.viewContainer = self.viewContainer
			self._viewCls.contentview = self
			self._achievementCls.viewParam = self.viewParam
			self._achievementCls.viewContainer = self.viewContainer
			self._infoCls.viewParam = self.viewParam

			if self._changeSkin then
				self:closeLoading()
			end

			if self._tempSkinId then
				self._viewCls:toBottomView()
			else
				self:closeLoading()

				if not self._firstopen then
					self._viewCls:backBottomView()
				end
			end

			PlayerCardController.instance:checkPlayCardSpecialBgm(skinId)

			self._firstopen = false
		end
	end
end

function NewPlayerCardContentView:afterOpenAnim()
	self._viewCls:toBottomView()
end

function NewPlayerCardContentView:_btnswitchskinOnClick()
	if self.playercardinfo:isSelf() then
		self._openswitchskin = not self._openswitchskin

		if not self._openswitchskin then
			self:onClickCloseBottomView()
			self._viewCls:backBottomView()
		else
			gohelper.setActive(self._goBottom, self._openswitchskin)
			gohelper.setActive(self._btnswitchskin.gameObject, not self._openswitchskin)
		end

		if self._openswitchskin then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_move)
			self._viewCls:toBottomView()
			PlayerCardModel.instance:setIsOpenSkinView(true)
			PlayerCardController.instance:dispatchEvent(PlayerCardEvent.ShowTheme)
		end
	end
end

function NewPlayerCardContentView:closeLoading()
	self:checkCanOpen()
	self._loadAnim:Play("close")
	TaskDispatcher.runDelay(self.afterClose, self, 0.3)
end

function NewPlayerCardContentView:afterClose()
	TaskDispatcher.cancelTask(self.afterClose, self)
	gohelper.setActive(self._goLoading, false)

	self._changeSkin = false

	UIBlockMgr.instance:endBlock("NewPlayerCardContentView")
end

function NewPlayerCardContentView:SwitchTheme(newSkinId)
	if not newSkinId then
		return
	end

	if not self._tempSkinId and newSkinId == self.skinId then
		return
	end

	if self._tempSkinId == newSkinId then
		return
	end

	self._tempSkinId = newSkinId
	self._oldViewGo = self._oldViewGo or self._viewGo

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._changeSkin = true

	gohelper.setActive(self._goLoading, true)
	UIBlockMgr.instance:startBlock("NewPlayerCardContentView")
	TaskDispatcher.runDelay(self.afterOpenLoad, self, 0.3)
	gohelper.setActive(self._goswitchskinreddot, self:_isShowRedDot())
end

function NewPlayerCardContentView:afterOpenLoad()
	TaskDispatcher.cancelTask(self.afterOpenLoad, self)
	self:disposeView()

	if self._isreset and not self._tempSkinId then
		self:loadRes(self.skinId)
	else
		self:loadRes(self._tempSkinId)
	end
end

function NewPlayerCardContentView:ChangeSkin(skinId)
	self._tempSkinId = nil
	self.skinId = skinId
end

function NewPlayerCardContentView:getCurrentView()
	return self._viewCls
end

function NewPlayerCardContentView:checkCanOpen()
	self._viewCls:canOpen(self._tempSkinId)
	self._achievementCls:canOpen()
	self._infoCls:canOpen()
end

function NewPlayerCardContentView:onClickCloseBottomView()
	self._bottomAnimator:Play("close")
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_enemy_move)

	if self._tempSkinId and self._tempSkinId ~= self.skinId then
		self:SwitchTheme(self.skinId)

		self._isreset = true
		self._tempSkinId = nil

		gohelper.setActive(self._goBottom, self._openswitchskin)
	else
		gohelper.setActive(self._goswitchskinreddot, self:_isShowRedDot())
		TaskDispatcher.runDelay(self.afterAnim, self, 0.2)
	end

	PlayerCardModel.instance:setIsOpenSkinView(false)

	local mo = PlayerCardThemeListModel.instance:getMoById(self.skinId)

	PlayerCardModel.instance:setSelectSkinMO(mo)
	self.skinpreviewcls:onHide()
	gohelper.setActive(self._btnswitchskin.gameObject, not self._openswitchskin)
end

function NewPlayerCardContentView:afterAnim()
	gohelper.setActive(self._goBottom, self._openswitchskin)
end

function NewPlayerCardContentView:disposeView()
	self._achievementCls:onCloseInternal()
	self._skinCls:onCloseInternal()
	self._infoCls:onCloseInternal()
	self._viewCls:onCloseInternal()

	if self._oldViewGo then
		gohelper.destroy(self._oldViewGo)

		self._oldViewGo = nil
	end
end

function NewPlayerCardContentView:onClose()
	self:disposeView()
	TaskDispatcher.cancelTask(self.afterOpenLoad, self)
	TaskDispatcher.cancelTask(self.afterClose, self)
	TaskDispatcher.cancelTask(self.closeLoading, self)
	TaskDispatcher.cancelTask(self._showSwitchBtn, self)

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	PlayerCardModel.instance:setIsOpenSkinView(false)
	PlayerCardController.instance:stopCardSpecialBgm()
end

function NewPlayerCardContentView:onDestroyView()
	if self.skinpreviewcls then
		self.skinpreviewcls:onDestroy()
	end

	self.skinpreviewcls = nil
end

return NewPlayerCardContentView
