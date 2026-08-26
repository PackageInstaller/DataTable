-- chunkname: @modules/logic/bgmswitch/view/BGMSwitchMusicView.lua

module("modules.logic.bgmswitch.view.BGMSwitchMusicView", package.seeall)

local BGMSwitchMusicView = class("BGMSwitchMusicView", BaseView)

function BGMSwitchMusicView:onInitView()
	self._gomusics = gohelper.findChild(self.viewGO, "#go_musics")
	self._musicAni = self._gomusics:GetComponent(typeof(UnityEngine.Animator))
	self._simageRightBG = gohelper.findChildSingleImage(self.viewGO, "#go_musics/#simage_RightBG")
	self._gomusictop = gohelper.findChild(self.viewGO, "#go_musics/#go_musictop")
	self._btnmusicfilter = gohelper.findChildButton(self.viewGO, "#go_musics/#go_musictop/#btn_musicfilter")
	self._gofilterbtn1 = gohelper.findChild(self.viewGO, "#go_musics/#go_musictop/#btn_musicfilter/btn1")
	self._gofilterbtn2 = gohelper.findChild(self.viewGO, "#go_musics/#go_musictop/#btn_musicfilter/btn2")
	self._gotab = gohelper.findChild(self.viewGO, "#go_musics/#go_musictop/#go_tab")
	self._btntaball = gohelper.findChildButton(self.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_taball")
	self._goallreddot = gohelper.findChild(self.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_taball/#go_allreddot")
	self._gotaballselected = gohelper.findChild(self.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_taball/#go_taballselected")
	self._btntablike = gohelper.findChildButton(self.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_tablike")
	self._gotablikeselected = gohelper.findChild(self.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_tablike/#go_tablikeselected")
	self._scrollSongList = gohelper.findChildScrollRect(self.viewGO, "#go_musics/#scroll_SongList")

	local scrollRectGO = self._scrollSongList.gameObject

	self._scrollTransition = LuaScrollRectTransition.getByScrollRectGO(scrollRectGO, ScrollEnum.ScrollDirV, 2)
	self._gosongitem = gohelper.findChild(self.viewGO, "#go_musics/#scroll_SongList/Viewport/Content/#go_songitem")
	self._gomusicbottom = gohelper.findChild(self.viewGO, "#go_musics/#go_musicbottom")
	self._gocurrent = gohelper.findChild(self.viewGO, "#go_musics/#go_musicbottom/#go_current")
	self._txtcurrent = gohelper.findChildText(self.viewGO, "#go_musics/#go_musicbottom/#go_current/txt_Current")
	self._txtcurrentEn = gohelper.findChildText(self.viewGO, "#go_musics/#go_musicbottom/#go_current/txt_Current/txt_CurrentEn")
	self._goset = gohelper.findChild(self.viewGO, "#go_musics/#go_musicbottom/#go_set")
	self._btnset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_musics/#go_musicbottom/#go_set/#btn_set")
	self._tabClick = gohelper.findChildClick(self.viewGO, "#go_musics/#go_musictop/#go_tab/#tab_click")
	self._selectedItem = nil

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BGMSwitchMusicView:addEvents()
	self._btnmusicfilter:AddClickListener(self._btnmusicfilterOnClick, self)
	self._btntaball:AddClickListener(self._btntaballOnClick, self)
	self._btntablike:AddClickListener(self._btntablikeOnClick, self)
	self._tabClick:AddClickListener(self._btntabOnClick, self)
	self._btnset:AddClickListener(self._btnsetOnClick, self)
	self._scrollSongList:AddOnValueChanged(self._onScrollRectValueChanged, self)
end

function BGMSwitchMusicView:removeEvents()
	self._btnmusicfilter:RemoveClickListener()
	self._btntaball:RemoveClickListener()
	self._btntablike:RemoveClickListener()
	self._tabClick:RemoveClickListener()
	self._btnset:RemoveClickListener()
	self._scrollSongList:RemoveOnValueChanged()
end

function BGMSwitchMusicView:_onScrollRectValueChanged(scrollX, scrollY)
	if self._clickTabBlock then
		return
	end

	if not self._scrollY or scrollY < 0 or scrollY > 1 then
		self._scrollY = scrollY

		return
	end

	self._scrollTime = self._scrollTime or 0
	self._scrollTime = self._scrollTime + UnityEngine.Time.deltaTime

	local exceedCount = Mathf.Ceil((self._showItemCount or 0) * 0.5) - 5

	exceedCount = exceedCount > 0 and exceedCount or 0

	local offsetY = exceedCount * math.abs(self._scrollY - scrollY)

	if self._scrollTime > 0.1 and offsetY > 0.2 then
		self._scrollTime = 0
		self._scrollY = scrollY

		BGMSwitchAudioTrigger.play_ui_checkpoint_resources_cardpass()
	end
end

function BGMSwitchMusicView:_btnmusicfilterOnClick()
	BGMSwitchController.instance:openBGMSwitchMusicFilterView()
	BGMSwitchAudioTrigger.play_ui_achieve_weiqicard_switch()
end

function BGMSwitchMusicView:_btntaballOnClick()
	local curSelectType = BGMSwitchModel.instance:getBGMSelectType()

	if curSelectType == BGMSwitchEnum.SelectType.All then
		return
	end

	self._musicAni:Play("switch", 0, 0)
	BGMSwitchModel.instance:clearFilterTypes()
	BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.All)
	TaskDispatcher.runDelay(self._switchRefresh, self, 0.16)
	BGMSwitchAudioTrigger.play_ui_rolesgo()
end

function BGMSwitchMusicView:_btntablikeOnClick()
	local curSelectType = BGMSwitchModel.instance:getBGMSelectType()

	if curSelectType == BGMSwitchEnum.SelectType.Loved then
		return
	end

	local bgms = BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted()

	if not bgms or not next(bgms) then
		GameFacade.showToast(ToastEnum.NoSetLoveSongs)

		return
	end

	self._musicAni:Play("switch", 0, 0)
	BGMSwitchModel.instance:clearFilterTypes()
	BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.Loved)
	TaskDispatcher.runDelay(self._switchRefresh, self, 0.16)
	BGMSwitchAudioTrigger.play_ui_rolesgo()
end

function BGMSwitchMusicView:_btntabOnClick()
	if self._clickTabBlock then
		return
	end

	self._clickTabBlock = true

	TaskDispatcher.runDelay(self._cancelTabBlock, self, 0.2)

	local curSelectType = BGMSwitchModel.instance:getBGMSelectType()

	if curSelectType == BGMSwitchEnum.SelectType.All then
		self:_btntablikeOnClick()
		self:_delayFocus()
	elseif curSelectType == BGMSwitchEnum.SelectType.Loved then
		self:_btntaballOnClick()
		self:_delayFocus()
	end
end

function BGMSwitchMusicView:_cancelTabBlock()
	self._clickTabBlock = nil
end

function BGMSwitchMusicView:_switchRefresh()
	self:_refreshView()
end

function BGMSwitchMusicView:_btnsetOnClick()
	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear ~= BGMSwitchEnum.Gear.On1 then
		ToastController.instance:showToast(ToastEnum.OnlyChannelOneCouldSwitch)

		return
	end

	local requestUsedBgmId = BGMSwitchModel.instance:getCurBgm()
	local isRandom = BGMSwitchModel.instance:isRandomMode()

	if isRandom then
		requestUsedBgmId = BGMSwitchModel.RandomBgmId
	end

	BgmRpc.instance:sendSetUseBgmRequest(requestUsedBgmId)

	local bgmCO = BGMSwitchConfig.instance:getBGMSwitchCO(requestUsedBgmId)

	if bgmCO then
		if not bgmCO.audioName then
			local bgmName = ""
			local prevSetBgmId = BGMSwitchModel.instance:getUsedBgmIdFromServer()
			local prevSetBgmCO = BGMSwitchConfig.instance:getBGMSwitchCO(prevSetBgmId)

			if prevSetBgmCO then
				if not prevSetBgmCO.audioName then
					local prevSetBgmName = ""
					local currSelBgmList = BGMSwitchModel.instance:getCurrentUsingBgmList()

					StatController.instance:track(StatEnum.EventName.SetBackgroundBGM, {
						[StatEnum.EventProperties.AudioId] = tostring(requestUsedBgmId),
						[StatEnum.EventProperties.AudioName] = bgmName,
						[StatEnum.EventProperties.BeforeSwitchAudio] = prevSetBgmName,
						[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(currSelBgmList)
					})
				end
			end
		end
	end
end

function BGMSwitchMusicView:_editableInitView()
	self:_addSelfEvents()

	self._items = {}

	local item = BGMSwitchMusicItem.New()

	item:init(self._gosongitem)
	item:hide(false)
	item:setRandom(true)
	item:setItem()

	self._items[0] = item
end

function BGMSwitchMusicView:_addSelfEvents()
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.SetPlayingBgm, self._refreshView, self)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.ItemSelected, self._refreshView, self)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.FilterClassSelect, self._refreshView, self)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.BgmSwitched, self._onBgmSwitched, self)
end

function BGMSwitchMusicView:_onBgmSwitched()
	self:_refreshView()

	local curPlayingBgm = BGMSwitchModel.instance:getCurBgm()

	if self._items[curPlayingBgm] then
		self._items[curPlayingBgm]:showSwitchEffect()
	end
end

function BGMSwitchMusicView:onUpdateParam()
	return
end

function BGMSwitchMusicView:onOpen()
	local selectTypeStoreInServer = BGMSwitchModel.instance:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)
	local usedBgmId = BGMSwitchModel.instance:getUsedBgmIdFromServer()

	if BGMSwitchModel.instance:isRandomBgmId(usedBgmId) then
		BGMSwitchModel.instance:setBGMSelectType(selectTypeStoreInServer)
	elseif selectTypeStoreInServer == BGMSwitchEnum.SelectType.Loved then
		local favoriteBgms = BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted()

		if LuaUtil.tableContains(favoriteBgms, usedBgmId) then
			BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.Loved)
		else
			BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.All)
		end
	else
		BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.All)
	end

	BGMSwitchModel.instance:setCurBgm(usedBgmId)
	self:_refreshView()
	self:_delayFocus()
end

function BGMSwitchMusicView:_delayFocus()
	self:_cancelDelayFocus()
	TaskDispatcher.runDelay(self._focusItem, self, 0.5)
end

function BGMSwitchMusicView:_cancelDelayFocus()
	TaskDispatcher.cancelTask(self._focusItem, self)
end

function BGMSwitchMusicView:_focusItem()
	if self._selectIdx then
		self._scrollTransition:focusCellInViewPort(self._selectIdx, true)
	end
end

function BGMSwitchMusicView:_refreshView(bgmId, focusItem)
	self:_refreshTop()
	self:_refreshMusicItems()
	self:_refreshBottom()

	if focusItem then
		self:_delayFocus()
	end
end

function BGMSwitchMusicView:_refreshTop()
	local selectType = BGMSwitchModel.instance:getBGMSelectType()

	gohelper.setActive(self._gotaballselected, selectType == BGMSwitchEnum.SelectType.All)
	gohelper.setActive(self._gotablikeselected, selectType == BGMSwitchEnum.SelectType.Loved)

	local isFilter = BGMSwitchModel.instance:isFilterMode()

	gohelper.setActive(self._gofilterbtn1, not isFilter)
	gohelper.setActive(self._gofilterbtn2, isFilter)

	local hasUnread = BGMSwitchModel.instance:hasUnreadBgm()

	gohelper.setActive(self._goallreddot, hasUnread)
end

function BGMSwitchMusicView:_refreshBottom()
	if BGMSwitchModel.instance:isLocalRemoteListTypeMatched() and BGMSwitchModel.instance:isLocalRemoteBgmIdMatched() then
		self._txtcurrent.text = luaLang("bgmswitchview_current")
		self._txtcurrentEn.text = luaLang("p_bgmswitchview_current_en")

		gohelper.setActive(self._gocurrent, true)
		gohelper.setActive(self._goset, false)
	elseif self._selectedItem ~= nil then
		gohelper.setActive(self._gocurrent, false)
		gohelper.setActive(self._goset, true)
	else
		self._txtcurrent.text = luaLang("bgmswitchview_selectlisten")
		self._txtcurrentEn.text = luaLang("p_bgmswitchview_selectlisten_en")

		gohelper.setActive(self._gocurrent, true)
		gohelper.setActive(self._goset, false)
	end
end

function BGMSwitchMusicView:_refreshMusicItems()
	local bgms = {}
	local selectType = BGMSwitchModel.instance:getBGMSelectType()

	if selectType == BGMSwitchEnum.SelectType.All then
		bgms = BGMSwitchModel.instance:getFilteredAllBgmsSorted()
	elseif selectType == BGMSwitchEnum.SelectType.Loved then
		bgms = BGMSwitchModel.instance:getFilteredFavoriteBgmsSorted()
	end

	for key, item in pairs(self._items) do
		if key ~= 0 then
			item:hide(true)
		else
			item:setItem()
		end
	end

	local index = 1

	self._selectedItem = nil
	self._selectIdx = nil

	if self._items[0]:isSelected() then
		self._selectedItem = self._items[0]
		self._selectIdx = index
	end

	for _, v in ipairs(bgms) do
		if not self._items[v] then
			local item = BGMSwitchMusicItem.New()
			local go = gohelper.cloneInPlace(self._gosongitem, v)

			item:init(go)
			item:setRandom(false)

			self._items[v] = item
		end

		self._items[v]:hide(false)
		gohelper.setSibling(self._items[v].go, index)

		local mo = BGMSwitchModel.instance:getBgmInfo(v)

		self._items[v]:setItem(mo)

		if self._items[v]:isSelected() then
			self._selectedItem = self._items[v]
			self._selectIdx = index + 1
		end

		index = index + 1
	end

	self._showItemCount = #bgms + 1
end

function BGMSwitchMusicView:onClose()
	BGMSwitchModel.instance:clearFilterTypes()
end

function BGMSwitchMusicView:_removeSelfEvents()
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.SetPlayingBgm, self._refreshView, self)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.ItemSelected, self._refreshView, self)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.FilterClassSelect, self._refreshView, self)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.BgmSwitched, self._onBgmSwitched, self)
end

function BGMSwitchMusicView:onDestroyView()
	TaskDispatcher.cancelTask(self._switchRefresh, self)
	TaskDispatcher.cancelTask(self._cancelTabBlock, self)
	self:_cancelDelayFocus()
	self:_removeSelfEvents()

	if self._items then
		for _, item in pairs(self._items) do
			item:destroy()
		end
	end
end

return BGMSwitchMusicView
