-- chunkname: @modules/logic/playercard/view/PlayerCardGetView.lua

module("modules.logic.playercard.view.PlayerCardGetView", package.seeall)

local PlayerCardGetView = class("PlayerCardGetView", BaseView)

function PlayerCardGetView:onInitView()
	self._gomainUI = gohelper.findChild(self.viewGO, "middle/#go_mainUI")
	self._gosocialUI = gohelper.findChild(self.viewGO, "middle/#go_social")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_equip")
	self._goshowing = gohelper.findChild(self.viewGO, "right/start/#go_showing")
	self._goLocked = gohelper.findChild(self.viewGO, "right/start/#go_Locked")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_close")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_card")
	self._goSceneName = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_SceneName")
	self._txtBgName = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName")
	self._txtTime = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_Time")
	self._gospecialTag = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_SceneName/go_playercardTag")
	self._scrolleffect = gohelper.findChildScrollRect(self.viewGO, "#scroll_effect")
	self._goeffectItem = gohelper.findChild(self.viewGO, "#scroll_effect/Viewport/Content/#go_effectItem")
	self._txtBgDescr = gohelper.findChildText(self.viewGO, "left/#txt_SceneDescr")
	self._btnshow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_show")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardGetView:addEvents()
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnshow:AddClickListener(self._btnshowOnClick, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.ChangeSkin, self._onChangeSkin, self)
end

function PlayerCardGetView:removeEvents()
	self._btnequip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnshow:RemoveClickListener()
end

function PlayerCardGetView:_btnequipOnClick()
	PlayerCardController.instance:setPlayerCardSkin(self._id)
end

function PlayerCardGetView:_btncloseOnClick()
	self:closeThis()
end

function PlayerCardGetView:_btnshowOnClick()
	return
end

function PlayerCardGetView:_editableInitView()
	self._effectItems = self:getUserDataTb_()

	gohelper.setActive(self._goeffectItem.gameObject, false)
end

function PlayerCardGetView:onUpdateParam()
	return
end

function PlayerCardGetView:onOpen()
	self._id = self.viewParam and self.viewParam.id
	self._config = ItemConfig.instance:getItemCo(self._id)

	local pathname = string.format("playercardview_%s", self._id)

	self._cardPath = string.format("ui/viewres/player/playercard/%s.prefab", pathname)
	self._cardLoader = MultiAbLoader.New()

	self._cardLoader:addPath(self._cardPath)
	self._cardLoader:startLoad(self._onCardLoadFinish, self)
	self:_initInfo()

	local isSpecial = PlayerCardModel.instance:isSpecialCardSkin(self._id)

	gohelper.setActive(self._gospecialTag.gameObject, isSpecial)
	gohelper.setActive(self._scrolleffect.gameObject, isSpecial)

	if isSpecial then
		self._showEffectIndex = 1

		self:_refreshSpecialUI()
		self:_initSocialView()
		self:_runRepeatEffectAnim()
	end

	gohelper.setActive(self._btnequip.gameObject, not self.viewParam or not self.viewParam.isHideEquipBtn)
end

function PlayerCardGetView:_refreshSpecialUI()
	for i = 1, 2 do
		local item = self:_getEffectItem(i)

		item:addBtnListeners(self._clickEffectBtn, self)

		local str = luaLang("PlayerCardGetView_special_tag" .. i)

		item:onUpdateMO(nil, i)
		item:setTxt(str)
		item:setActive(true)
		item:onSelectByIndex(self._showEffectIndex)
	end

	gohelper.setActive(self._gomainUI, self._showEffectIndex == 1)
	gohelper.setActive(self._gosocialUI, self._showEffectIndex == 2)
end

function PlayerCardGetView:_getEffectItem(index)
	local item = self._effectItems[index]

	if not item then
		local childGO = gohelper.cloneInPlace(self._goeffectItem, "effect_" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, MainSwitchClassifyItem)
		self._effectItems[index] = item
	end

	return item
end

function PlayerCardGetView:_runRepeatEffectAnim()
	TaskDispatcher.runRepeat(self._playEffectAnim, self, 5)
end

function PlayerCardGetView:_playEffectAnim()
	self:_showEffect(self._showEffectIndex == 1 and 2 or 1)
end

function PlayerCardGetView:_showEffect(index)
	if self._showEffectIndex == index then
		return
	end

	self._showEffectIndex = index

	for i, item in ipairs(self._effectItems) do
		item:onSelectByIndex(index)
	end

	gohelper.setActive(self._gomainUI, index == 1)
	gohelper.setActive(self._gosocialUI, index == 2)
end

function PlayerCardGetView:_clickEffectBtn(index)
	self:_showEffect(index)
	TaskDispatcher.cancelTask(self._playEffectAnim, self)
end

function PlayerCardGetView:_initSocialView()
	local viewParam = {
		parentGo = self._gosocialUI,
		skinId = self._id
	}

	ViewMgr.instance:openView(ViewName.PlayerCardGetSocialView, viewParam)
end

function PlayerCardGetView:_onCardLoadFinish()
	local assetItem = self._cardLoader:getAssetItem(self._cardPath)
	local viewPrefab = assetItem:GetResource(self._cardPath)

	self._viewGo = self._viewGo or gohelper.clone(viewPrefab, self._gomainUI)
	self._viewCls = self._viewCls or MonoHelper.addNoUpdateLuaComOnceToGo(self._viewGo, PlayerCardGetMainView)
	self._viewCls.viewParam = {
		userId = PlayerModel.instance:getPlayinfo().userId
	}
	self._viewCls.viewContainer = self.viewContainer

	self._viewCls:onOpen(self._id)
end

function PlayerCardGetView:_initInfo()
	local dt = ServerTime.nowDateInLocal()
	local time = string.format("%04d/%02d/%02d", dt.year, dt.month, dt.day)

	self._txtTime.text = string.format(luaLang("receive_time"), time)
	self._txtBgName.text = self._config.name
	self._txtBgDescr.text = self._config.desc
end

function PlayerCardGetView:onClose()
	PlayerCardController.instance:openSimpleShowView()

	if ViewMgr.instance:isOpen(ViewName.PlayerCardGetSocialView) then
		ViewMgr.instance:closeView(ViewName.PlayerCardGetSocialView)
	end

	TaskDispatcher.cancelTask(self._playEffectAnim, self)
end

function PlayerCardGetView:_onChangeSkin(skinId)
	local isSelect = self._id == skinId

	gohelper.setActive(self._btnequip.gameObject, not isSelect)
	gohelper.setActive(self._goshowing, isSelect)
	GameFacade.showToast(ToastEnum.PlayerCardChangeSkin)
end

function PlayerCardGetView:onDestroyView()
	return
end

return PlayerCardGetView
