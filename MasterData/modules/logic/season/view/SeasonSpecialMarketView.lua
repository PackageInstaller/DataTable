-- chunkname: @modules/logic/season/view/SeasonSpecialMarketView.lua

module("modules.logic.season.view.SeasonSpecialMarketView", package.seeall)

local SeasonSpecialMarketView = class("SeasonSpecialMarketView", BaseView)

function SeasonSpecialMarketView:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#go_info/bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#go_info/bg/#simage_bg2")
	self._simagedecorate1 = gohelper.findChildSingleImage(self.viewGO, "#go_info/right/#simage_decorate1")
	self._simagedecorate2 = gohelper.findChildSingleImage(self.viewGO, "#go_info/right/#simage_decorate2")
	self._txtlevelnamecn = gohelper.findChildText(self.viewGO, "#go_info/left/#txt_levelnamecn")
	self._gostageinfoitem1 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem1")
	self._gostageinfoitem2 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem2")
	self._gostageinfoitem3 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem3")
	self._gostageinfoitem4 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem4")
	self._gostageinfoitem5 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem5")
	self._gostageinfoitem6 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem6")
	self._txtcurindex = gohelper.findChildText(self.viewGO, "#go_info/left/position/center/#txt_curindex")
	self._txtmaxindex = gohelper.findChildText(self.viewGO, "#go_info/left/position/center/#txt_maxindex")
	self._btnlast = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/left/position/#btn_last")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/left/position/#btn_next")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_info/left/#txt_desc")
	self._txtenemylv = gohelper.findChildText(self.viewGO, "#go_info/left/enemylv/#txt_enemylv")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/left/#btn_start")
	self._gopart = gohelper.findChild(self.viewGO, "#go_info/left/layout/#go_part")
	self._gostage = gohelper.findChild(self.viewGO, "#go_info/left/layout/#go_part/#go_stage")
	self._gostagelvlitem = gohelper.findChild(self.viewGO, "#go_info/left/layout/#go_part/#go_stage/list/#go_stagelvlitem")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock")
	self._gounlocktype1 = gohelper.findChild(self.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype1")
	self._gounlocktype2 = gohelper.findChild(self.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype2")
	self._gounlocktype3 = gohelper.findChild(self.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype3")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._golevel = gohelper.findChild(self.viewGO, "#go_level")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_level/#simage_bg")
	self._simageleveldecorate = gohelper.findChildSingleImage(self.viewGO, "#go_level/decorate/#simage_leveldecorate")
	self._goscrolllv = gohelper.findChild(self.viewGO, "#go_level/#go_scrolllv")
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

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonSpecialMarketView:addEvents()
	self._btnlast:AddClickListener(self._btnlastOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnlvstart:AddClickListener(self._btnlvstartOnClick, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.StartAct104BattleReply, self._onBattleReply, self)
end

function SeasonSpecialMarketView:removeEvents()
	self._btnlast:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self._btnlvstart:RemoveClickListener()
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.StartAct104BattleReply, self._onBattleReply, self)
end

function SeasonSpecialMarketView:_onBattleReply(msg)
	Activity104Model.instance:onStartAct104BattleReply(msg)
end

function SeasonSpecialMarketView:_btnlvstartOnClick()
	gohelper.setActive(self._goinfo, true)
	gohelper.setActive(self._golevel, false)
	self:_refreshInfo()
end

function SeasonSpecialMarketView:_btnlastOnClick()
	if self._layer < 2 then
		return
	end

	self._layer = self._layer - 1

	self:_refreshInfo()
end

function SeasonSpecialMarketView:_btnnextOnClick()
	local maxLayer = Activity104Model.instance:getMaxSpecialLayer()

	if maxLayer <= self._layer then
		return
	end

	self._layer = self._layer + 1

	self:_refreshInfo()
end

function SeasonSpecialMarketView:_btnstartOnClick()
	local actId = ActivityEnum.Activity.Season
	local episodeId = SeasonConfig.instance:getSeasonSpecialCo(actId, self._layer).episodeId

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(actId, self._layer, episodeId)
end

function SeasonSpecialMarketView:_btnclickOnClick()
	return
end

function SeasonSpecialMarketView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/bgyahei.png"))
	self._simagebg2:LoadImage(ResUrl.getSeasonIcon("full/img_bg3.png"))
	self._simagebg:LoadImage(ResUrl.getSeasonIcon("full/img_bg.png"))
	self._simagedecorate1:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
end

function SeasonSpecialMarketView:onUpdateParam()
	return
end

function SeasonSpecialMarketView:onOpen()
	gohelper.setActive(self._golevel, true)
	gohelper.setActive(self._goinfo, false)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.SwitchSpecialEpisode, self._onSwitchEpisode, self)

	self._showLvItems = {}
	self._showStageItems = {}
	self._infoStageItems = {}
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
	end
end

function SeasonSpecialMarketView:onClose()
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.SwitchSpecialEpisode, self._onSwitchEpisode, self)
end

function SeasonSpecialMarketView:_onSwitchEpisode(layer)
	self._layer = layer

	self:_refreshLevel()
end

function SeasonSpecialMarketView:_refreshLevel()
	local maxSpecialLayer = Activity104Model.instance:getMaxSpecialLayer()

	for i = 1, maxSpecialLayer do
		if not self._showLvItems[i] then
			local child = gohelper.cloneInPlace(self._golvitem)

			self._showLvItems[i] = SeasonSpecialMarketShowLevelItem.New()

			self._showLvItems[i]:init(child)
		end

		self._showLvItems[i]:reset(i, self._layer, maxSpecialLayer)
	end

	gohelper.setAsLastSibling(self._gorear)

	local spEpisodeCo = SeasonConfig.instance:getSeasonSpecialCo(ActivityEnum.Activity.Season, self._layer)

	self._simageleveldecorate:LoadImage(ResUrl.getSeasonMarketIcon(spEpisodeCo.icon))
end

function SeasonSpecialMarketView:_refreshInfo()
	local spEpisodeCo = SeasonConfig.instance:getSeasonSpecialCo(ActivityEnum.Activity.Season, self._layer)

	self._txtlevelnamecn.text = spEpisodeCo.name
	self._txtcurindex.text = string.format("%02d", self._layer)

	local maxLayer = Activity104Model.instance:getMaxSpecialLayer()

	self._txtmaxindex.text = string.format("%02d", maxLayer)
	self._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(spEpisodeCo.level)

	self._simagedecorate2:LoadImage(ResUrl.getSeasonMarketIcon(spEpisodeCo.icon))

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

	self._btnlast.button.interactable = self._layer > 1
	self._btnnext.button.interactable = self._layer < Activity104Model.instance:getMaxSpecialLayer()
end

function SeasonSpecialMarketView:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.cloneInPlace(self._gorewarditem, "reward_" .. tostring(index))

	item.go = itemGo
	item.itemParent = gohelper.findChild(itemGo, "go_prop")
	item.cardParent = gohelper.findChild(itemGo, "go_card")
	item.receive = gohelper.findChild(itemGo, "go_receive")
	self._rewardItems[index] = item

	return item
end

function SeasonSpecialMarketView:refreshRewardItem(item, itemCo)
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

function SeasonSpecialMarketView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._simagebg:UnLoadImage()
	self._simagedecorate2:UnLoadImage()
	self._simageleveldecorate:UnLoadImage()
	self._simagedecorate1:UnLoadImage()

	if self._showLvItems then
		for _, v in pairs(self._showLvItems) do
			v:destroy()
		end

		self._showLvItems = nil
	end
end

return SeasonSpecialMarketView
