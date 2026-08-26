-- chunkname: @modules/logic/season/view3_0/Season3_0SpecialMarketView.lua

module("modules.logic.season.view3_0.Season3_0SpecialMarketView", package.seeall)

local Season3_0SpecialMarketView = class("Season3_0SpecialMarketView", BaseView)

function Season3_0SpecialMarketView:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#go_info/bg/#simage_bg1")
	self._simagepage = gohelper.findChildSingleImage(self.viewGO, "#go_info/left/#simage_page")
	self._simagestageicon = gohelper.findChildSingleImage(self.viewGO, "#go_info/left/#simage_stageicon")
	self._txtlevelnamecn = gohelper.findChildText(self.viewGO, "#go_info/left/#txt_levelnamecn")
	self._descScroll = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View")
	self._animScroll = self._descScroll:GetComponent(typeof(UnityEngine.Animator))
	self._descContent = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/Viewport/Content")
	self._goDescItem = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/Viewport/Content/#go_descitem")
	self._txtcurindex = gohelper.findChildText(self.viewGO, "#go_info/right/position/center/#txt_curindex")
	self._txtmaxindex = gohelper.findChildText(self.viewGO, "#go_info/right/position/center/#txt_maxindex")
	self._btnlast = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/position/#btn_last")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/position/#btn_next")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_info/right/#txt_desc")
	self._txtenemylv = gohelper.findChildText(self.viewGO, "#go_info/right/enemylv/enemylv/#txt_enemylv")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/btns/#btn_start")
	self._gopart = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_part")
	self._gostage = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_part/#go_stage")
	self._gostagelvlitem = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_part/#go_stage/list/#go_stagelvlitem")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock")
	self._gounlocktype1 = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype1")
	self._gounlocktype2 = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype2")
	self._gounlocktype3 = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype3")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._golevel = gohelper.findChild(self.viewGO, "#go_level")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_level/#simage_bg")
	self._simageleveldecorate = gohelper.findChildSingleImage(self.viewGO, "#go_level/decorate/#simage_leveldecorate")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_level/decorate/#simage_line")
	self._goscrolllv = gohelper.findChild(self.viewGO, "#go_level/#go_scrolllv")
	self._goscrolllvcontent = gohelper.findChild(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content")
	self._gofront = gohelper.findChild(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_front")
	self._golvitem = gohelper.findChild(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem")
	self._goline = gohelper.findChild(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_line")
	self._goselectedpass = gohelper.findChild(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_selectedpass")
	self._txtselectpassindex = gohelper.findChildText(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_selectedpass/#txt_selectpassindex")
	self._gopass = gohelper.findChild(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_pass")
	self._txtpassindex = gohelper.findChildText(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_pass/#txt_passindex")
	self._gounpass = gohelper.findChild(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_unpass")
	self._txtunpassindex = gohelper.findChildText(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_unpass/#txt_unpassindex")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#btn_click")
	self._gorear = gohelper.findChild(self.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_rear")
	self._gostagelvitem1 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem1")
	self._gostagelvitem2 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem2")
	self._gostagelvitem3 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem3")
	self._gostagelvitem4 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem4")
	self._gostagelvitem5 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem5")
	self._gostagelvitem6 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem6")
	self._btnlvstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_level/#btn_lvstart")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gopartempty = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_partempty")
	self._simageempty = gohelper.findChildSingleImage(self.viewGO, "#go_info/right/layout/#go_partempty/#simage_empty")
	self._goleftscrolltopmask = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/mask2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0SpecialMarketView:addEvents()
	self._btnlast:AddClickListener(self._btnlastOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnlvstart:AddClickListener(self._btnlvstartOnClick, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.StartAct104BattleReply, self._onBattleReply, self)
end

function Season3_0SpecialMarketView:removeEvents()
	self._btnlast:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self._btnlvstart:RemoveClickListener()
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.StartAct104BattleReply, self._onBattleReply, self)
end

function Season3_0SpecialMarketView:_onBattleReply(msg)
	Activity104Model.instance:onStartAct104BattleReply(msg)
end

function Season3_0SpecialMarketView:_btnlvstartOnClick()
	gohelper.setActive(self._goinfo, true)
	gohelper.setActive(self._golevel, false)
	self:_refreshInfo()
end

function Season3_0SpecialMarketView:_btnlastOnClick()
	local lastLayer = self._layer - 1

	if lastLayer < 1 then
		return
	end

	local actId = Activity104Model.instance:getCurSeasonId()
	local isOpen, remainTime = Activity104Model.instance:isSpecialLayerOpen(actId, lastLayer)

	if not isOpen then
		local day = math.ceil(remainTime / TimeUtil.OneDaySecond)
		local msg = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("season166_unlockHardEpisodeTime"), day)

		GameFacade.showToastString(msg)

		return
	end

	self._layer = lastLayer

	self._animScroll:Play(UIAnimationName.Switch, 0, 0)
	self:_refreshInfo()
end

function Season3_0SpecialMarketView:_btnnextOnClick()
	local maxLayer = Activity104Model.instance:getMaxSpecialLayer()
	local nextLayer = self._layer + 1

	if maxLayer < nextLayer then
		return
	end

	local actId = Activity104Model.instance:getCurSeasonId()
	local isOpen, remainTime = Activity104Model.instance:isSpecialLayerOpen(actId, nextLayer)

	if not isOpen then
		local day = math.ceil(remainTime / TimeUtil.OneDaySecond)
		local msg = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("season166_unlockHardEpisodeTime"), day)

		GameFacade.showToastString(msg)

		return
	end

	self._layer = nextLayer

	self._animScroll:Play(UIAnimationName.Switch, 0, 0)
	self:_refreshInfo()
end

function Season3_0SpecialMarketView:_btnstartOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local episodeId = SeasonConfig.instance:getSeasonSpecialCo(actId, self._layer).episodeId

	Activity104Model.instance:enterAct104Battle(episodeId, self._layer)
end

function Season3_0SpecialMarketView:_btnclickOnClick()
	return
end

function Season3_0SpecialMarketView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getSeasonIcon("full/img_bg.png"))
	self._simagepage:LoadImage(SeasonViewHelper.getSeasonIcon("shuye.png"))
	self._simageempty:LoadImage(SeasonViewHelper.getSeasonIcon("kongzhuangtai.png"))
	self._simageline:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
end

function Season3_0SpecialMarketView:onUpdateParam()
	return
end

function Season3_0SpecialMarketView:onOpen()
	gohelper.setActive(self._golevel, true)
	gohelper.setActive(self._goinfo, false)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.SwitchSpecialEpisode, self._onSwitchEpisode, self)

	self._showLvItems = {}
	self._rewardItems = {}

	local defaultSelectLayer, directOpenLayer

	if self.viewParam then
		defaultSelectLayer = self.viewParam.defaultSelectLayer

		if self.viewParam.directOpenLayer then
			directOpenLayer = true
		end
	end

	self._layer = defaultSelectLayer or Activity104Model.instance:getAct104SpecialInitLayer()

	self:_refreshLevel()

	if directOpenLayer then
		self:_btnlvstartOnClick()
	else
		self:gotoScroll()
	end
end

function Season3_0SpecialMarketView:gotoScroll()
	local content = self._goscrolllvcontent.transform

	ZProj.UGUIHelper.RebuildLayout(content)

	local layer = self._layer
	local item = self._showLvItems[layer]

	if item then
		local pos = recthelper.getAnchorX(item.transform) - 50
		local contentWidth = recthelper.getWidth(content)
		local scrollWidth = recthelper.getWidth(self._goscrolllv.transform)
		local widthOffset = contentWidth - scrollWidth
		local moveLimt = math.max(0, widthOffset)

		pos = math.min(moveLimt, pos)

		recthelper.setAnchorX(content, -pos)
	end
end

function Season3_0SpecialMarketView:onClose()
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.SwitchSpecialEpisode, self._onSwitchEpisode, self)
end

function Season3_0SpecialMarketView:_onSwitchEpisode(layer)
	self._layer = layer

	self:_refreshLevel()
end

function Season3_0SpecialMarketView:_refreshLevel()
	local maxSpecialLayer = Activity104Model.instance:getMaxSpecialLayer()

	for i = 1, maxSpecialLayer do
		if not self._showLvItems[i] then
			local child = gohelper.cloneInPlace(self._golvitem)

			self._showLvItems[i] = Season3_0SpecialMarketShowLevelItem.New()

			self._showLvItems[i]:init(child)
		end

		self._showLvItems[i]:reset(i, self._layer, maxSpecialLayer)
	end

	gohelper.setAsLastSibling(self._gorear)

	local spEpisodeCo = SeasonConfig.instance:getSeasonSpecialCo(Activity104Model.instance:getCurSeasonId(), self._layer)

	self._simageleveldecorate:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/ty_chatu_%s.png", spEpisodeCo.icon)))
end

function Season3_0SpecialMarketView:_refreshInfo()
	local spEpisodeCo = SeasonConfig.instance:getSeasonSpecialCo(Activity104Model.instance:getCurSeasonId(), self._layer)

	self._txtlevelnamecn.text = spEpisodeCo.name
	self._txtcurindex.text = string.format("%02d", self._layer)

	local maxLayer = Activity104Model.instance:getMaxSpecialLayer()

	self._txtmaxindex.text = string.format("%02d", maxLayer)
	self._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(spEpisodeCo.level)

	self._simagestageicon:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/a_chatu_%s.png", spEpisodeCo.icon)))

	local episodeCo = DungeonConfig.instance:getEpisodeCO(spEpisodeCo.episodeId)

	self._txtdesc.text = episodeCo.desc

	gohelper.setActive(self._gorewarditem, false)

	local rewards = DungeonModel.instance:getEpisodeFirstBonus(spEpisodeCo.episodeId)

	for i = 1, math.max(#self._rewardItems, #rewards) do
		if not self._rewardItems[i] then
			local item = self:createRewardItem(i)

			self:refreshRewardItem(self._rewardItems[i], rewards[i])
		end
	end

	gohelper.setActive(self._gopart, false)
	gohelper.setActive(self._gopartempty, true)

	self._btnlast.button.interactable = self._layer > 1
	self._btnnext.button.interactable = self._layer < Activity104Model.instance:getMaxSpecialLayer()

	self:updateLeftDesc()
end

function Season3_0SpecialMarketView:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.cloneInPlace(self._gorewarditem, "reward_" .. tostring(index))

	item.go = itemGo
	item.itemParent = gohelper.findChild(itemGo, "go_prop")
	item.cardParent = gohelper.findChild(itemGo, "go_card")
	item.receive = gohelper.findChild(itemGo, "go_receive")
	self._rewardItems[index] = item

	return item
end

function Season3_0SpecialMarketView:refreshRewardItem(item, itemCo)
	if not itemCo then
		gohelper.setActive(item.go, false)

		return
	end

	item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.itemParent)

	item.itemIcon:setMOValue(tonumber(itemCo[1]), tonumber(itemCo[2]), tonumber(itemCo[3]), nil, true)
	item.itemIcon:isShowCount(tonumber(itemCo[1]) ~= MaterialEnum.MaterialType.Hero)
	item.itemIcon:setCountFontSize(40)
	item.itemIcon:showStackableNum2()
	item.itemIcon:setHideLvAndBreakFlag(true)
	item.itemIcon:hideEquipLvAndBreak(true)
	gohelper.setActive(item.go, true)
	gohelper.setActive(item.receive, Activity104Model.instance:isSpecialLayerPassed(self._layer))
end

function Season3_0SpecialMarketView:updateLeftDesc()
	self.descItems = self.descItems or {}

	local dict = SeasonConfig.instance:getSeasonSpecialCos(Activity104Model.instance:getCurSeasonId())
	local list = {}

	if dict then
		for k, v in pairs(dict) do
			table.insert(list, v)
		end

		table.sort(list, function(a, b)
			return a.layer < b.layer
		end)
	end

	self._curDescItem = nil

	for i = 1, math.max(#list, #self.descItems) do
		local item = self.descItems[i]

		if not item then
			item = self:createLeftDescItem(i)
			self.descItems[i] = item
		end

		self:updateLeftDescItem(item, list[i])
	end

	gohelper.setActive(self._goleftscrolltopmask, self._curDescItem.index ~= 1)
	TaskDispatcher.runDelay(self.moveToCurDesc, self, 0.02)
end

function Season3_0SpecialMarketView:createLeftDescItem(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.cloneInPlace(self._goDescItem, "desc" .. index)
	item.txt = gohelper.findChildTextMesh(item.go, "txt_desc")
	item.goLine = gohelper.findChild(item.go, "go_underline")

	return item
end

function Season3_0SpecialMarketView:updateLeftDescItem(item, co)
	if not co then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local desc = co.desc

	if co.layer == self._layer then
		gohelper.setActive(item.goLine, true)

		item.txt.text = desc
		item.txt.lineSpacing = 49.75

		ZProj.UGUIHelper.SetColorAlpha(item.txt, 1)

		self._curDescItem = item
	else
		gohelper.setActive(item.goLine, false)

		item.txt.text = desc
		item.txt.lineSpacing = -12.5

		ZProj.UGUIHelper.SetColorAlpha(item.txt, 0.7)
	end
end

function Season3_0SpecialMarketView:moveToCurDesc()
	TaskDispatcher.cancelTask(self.moveToCurDesc, self)

	local curItem = self._curDescItem

	if not curItem then
		return
	end

	local txtHeight = curItem.txt.preferredHeight
	local scrollHeight = recthelper.getHeight(self._descScroll.transform)
	local maxPosY = math.max(0, recthelper.getHeight(self._descContent.transform) - scrollHeight)
	local offset = (scrollHeight - txtHeight) * 0.5
	local posY = recthelper.getAnchorY(curItem.go.transform) + offset

	recthelper.setAnchorY(self._descContent.transform, Mathf.Clamp(-posY, 0, -posY))
end

function Season3_0SpecialMarketView:onDestroyView()
	TaskDispatcher.cancelTask(self.moveToCurDesc, self)
	self._simagebg:UnLoadImage()
	self._simagestageicon:UnLoadImage()
	self._simageleveldecorate:UnLoadImage()
	self._simagepage:UnLoadImage()
	self._simageline:UnLoadImage()

	if self._showLvItems then
		for _, v in pairs(self._showLvItems) do
			v:destroy()
		end

		self._showLvItems = nil
	end
end

return Season3_0SpecialMarketView
