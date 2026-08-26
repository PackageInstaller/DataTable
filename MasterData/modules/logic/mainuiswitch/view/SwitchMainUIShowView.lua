-- chunkname: @modules/logic/mainuiswitch/view/SwitchMainUIShowView.lua

module("modules.logic.mainuiswitch.view.SwitchMainUIShowView", package.seeall)

local SwitchMainUIShowView = class("SwitchMainUIShowView", BaseView)

function SwitchMainUIShowView:onInitView()
	self._golightspinecontrol = gohelper.findChild(self.viewGO, "#go_lightspinecontrol")
	self._btnquest = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_quest")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "left/#btn_quest/#go_taskreddot")
	self._btnstorage = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_storage")
	self._godeadline = gohelper.findChild(self.viewGO, "left/#btn_storage/#go_deadline")
	self._godeadlineEffect = gohelper.findChild(self.viewGO, "left/#btn_storage/#go_deadline/#effect")
	self._imagetimebg = gohelper.findChildImage(self.viewGO, "left/#btn_storage/#go_deadline/timebg")
	self._txttime = gohelper.findChildText(self.viewGO, "left/#btn_storage/#go_deadline/#txt_time")
	self._imagetimeicon = gohelper.findChildImage(self.viewGO, "left/#btn_storage/#go_deadline/#txt_time/timeicon")
	self._txtformat = gohelper.findChildText(self.viewGO, "left/#btn_storage/#go_deadline/#txt_time/#txt_format")
	self._gostoragereddot = gohelper.findChild(self.viewGO, "left/#btn_storage/#go_storagereddot")
	self._btnbank = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_bank")
	self._gobankreddot = gohelper.findChild(self.viewGO, "left/#btn_bank/#go_bankreddot")
	self._godeadlinebank = gohelper.findChild(self.viewGO, "left/#btn_bank/#go_deadlinebank")
	self._gobankeffect = gohelper.findChild(self.viewGO, "left/#btn_bank/#go_bankeffect")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._btnroom = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_room")
	self._goroomlock = gohelper.findChild(self.viewGO, "right/#btn_room/#go_roomlock")
	self._goroomreddot = gohelper.findChild(self.viewGO, "right/#btn_room/#go_roomreddot")
	self._gogreendot = gohelper.findChild(self.viewGO, "right/#btn_room/#go_roomreddot/#go_greendot")
	self._goreddot = gohelper.findChild(self.viewGO, "right/#btn_room/#go_roomreddot/#go_reddot")
	self._goroomgiftreddot = gohelper.findChild(self.viewGO, "right/#btn_room/#go_v1a9actroom")
	self._gobanners = gohelper.findChild(self.viewGO, "left/#go_banners")
	self._goactivity = gohelper.findChild(self.viewGO, "left/#go_activity")
	self._btnswitchrole = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_switchrole")
	self._gothumbnialreddot = gohelper.findChild(self.viewGO, "left/#btn_switchrole/#go_thumbnailreddot")
	self._btnplayerinfo = gohelper.findChildButtonWithAudio(self.viewGO, "left_top/playerinfos/info/#btn_playerinfo")
	self._imageslider = gohelper.findChildImage(self.viewGO, "left_top/playerinfos/info/#image_slider")
	self._txtname = gohelper.findChildText(self.viewGO, "left_top/playerinfos/txtContainer/#txt_name")
	self._txtid = gohelper.findChildText(self.viewGO, "left_top/playerinfos/txtContainer/#txt_id")
	self._txtlevel = gohelper.findChildText(self.viewGO, "left_top/playerinfos/txtContainer/layout/#txt_level")
	self._goplayerreddot = gohelper.findChild(self.viewGO, "left_top/#go_reddot")
	self._btnmail = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_mail")
	self._gomailreddot = gohelper.findChild(self.viewGO, "left/#btn_mail/#go_mailreddot")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._btnpower = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_power")
	self._btnrole = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_role")
	self._btnsummon = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_summon")
	self._btncopost = gohelper.findChild(self.viewGO, "right/#btn_copost")
	self._gocopostred = gohelper.findChild(self.viewGO, "right/#btn_copost/#go_reddot")
	self._txtpower = gohelper.findChildText(self.viewGO, "right/txtContainer/#txt_power")
	self._gospinescale = gohelper.findChild(self.viewGO, "#go_spine_scale")
	self._golightspine = gohelper.findChild(self.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	self._gocontentbg = gohelper.findChild(self.viewGO, "bottom/#go_contentbg")
	self._txtanacn = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_cn")
	self._txtanaen = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_en")
	self._btnhide = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_hide")
	self._btnbgm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_bgm")
	self._gobgmnone = gohelper.findChild(self.viewGO, "#btn_bgm/none")
	self._gobgmplay = gohelper.findChild(self.viewGO, "#btn_bgm/playing")
	self._btnlimitedshow = gohelper.findChildButtonWithAudio(self.viewGO, "limitedshow/#btn_limitedshow")
	self._golimitedshow = gohelper.findChild(self.viewGO, "limitedshow")
	self._pcBtnHide = gohelper.findChild(self._btnhide.gameObject, "#go_pcbtn")
	self._pcBtnRoom = gohelper.findChild(self._btnroom.gameObject, "#go_pcbtn")
	self._pcBtnCharactor = gohelper.findChild(self._btnrole.gameObject, "#go_pcbtn")
	self._pcBtnSummon = gohelper.findChild(self._btnsummon.gameObject, "#go_pcbtn")

	gohelper.setActive(self._btnlimitedshow.gameObject, true)
	gohelper.setActive(self._golimitedshow, false)

	self._showMainView = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SwitchMainUIShowView:addEvents()
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, self._onSwitchUIVisible, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, self._onSwitchUIVisible, self)
end

function SwitchMainUIShowView:removeEvents()
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, self._onSwitchUIVisible, self)
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, self._onSwitchUIVisible, self)
end

function SwitchMainUIShowView:_editableInitView()
	self._festivalAtmosphereComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, FestivalAtmosphereComp, self)
	self._goleft = gohelper.findChild(self.viewGO, "left")
	self._golefttop = gohelper.findChild(self.viewGO, "left_top")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._goactbgGo = gohelper.findChild(self.viewGO, "#simage_actbg")
	self._currencyObjs = {}

	if self._currencyLoader then
		self._currencyLoader:dispose()

		self._currencyLoader = nil
	end

	self._currencyLoader = MultiAbLoader.New()

	self._currencyLoader:addPath(CurrencyView.prefabPath)
	self._currencyLoader:startLoad(self._loadFinishCurrency, self)
	self:_initOffsetGos()

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	self._cameraAnimator.speed = 1
	self._animatorRight = gohelper.findChildComponent(self.viewGO, "right", typeof(UnityEngine.Animator))
	self._openOtherView = false
	self._goroomImage = gohelper.findChild(self.viewGO, "right/#btn_room")
	self._roomCanvasGroup = gohelper.onceAddComponent(self._goroomImage, typeof(UnityEngine.CanvasGroup))
	self._openMainThumbnailTime = Time.realtimeSinceStartup
	self._animator.enabled = false
	self._mailreddot = MonoHelper.addNoUpdateLuaComOnceToGo(self._gomailreddot, SwitchMainUIReddotIcon)
	self._taskreddot = MonoHelper.addNoUpdateLuaComOnceToGo(self._gotaskreddot, SwitchMainUIReddotIcon)
	self._bankreddot = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobankreddot, SwitchMainUIReddotIcon)
	self._goskinBg = gohelper.findChild(self.viewGO, "right/#go_skinBg")

	gohelper.setActive(self._btnhide.gameObject, false)
	gohelper.setActive(self._goactivity.gameObject, false)

	self._imagesummonnews = self:getUserDataTb_()
	self._tuziGoList = self:getUserDataTb_()

	for _, skinId in pairs(MainUISwitchEnum.Skin) do
		local newName = string.format("right/#btn_summon/%s/layout/#image_summonnew", skinId)
		local tuziName = string.format("right/#btn_summon/%s/layout/#image_tuzi", skinId)
		local new = gohelper.findChild(self.viewGO, newName)

		table.insert(self._imagesummonnews, new)
		table.insert(self._tuziGoList, gohelper.findChild(self.viewGO, tuziName))
	end

	self:initFreeTag()
	self:_refreshSummonTuziRed()
end

function SwitchMainUIShowView:_isShowSummonReddot()
	local isSummonUnlock = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon)
	local needReddot = SummonMainModel.instance:entryNeedReddot()

	return isSummonUnlock and needReddot
end

function SwitchMainUIShowView:initFreeTag()
	self._goFreeTag = gohelper.findChild(self.viewGO, "right/#btn_summon/Tag")
	self._gosummonreddot = gohelper.findChild(self.viewGO, "right/#btn_summon/#go_summonreddot")
	self._goSummonFreeOne = gohelper.findChild(self.viewGO, "right/#btn_summon/Tag/single")
	self._goSummonFreeTen = gohelper.findChild(self.viewGO, "right/#btn_summon/Tag/ten")
	self._summonFreeSingleTagList = self:getUserDataTb_()
	self._summonFreeTenTagList = self:getUserDataTb_()

	local childCount = self._goSummonFreeOne.transform.childCount

	for i = 1, childCount do
		local singleTagTran = self._goSummonFreeOne.transform:GetChild(i - 1)

		table.insert(self._summonFreeSingleTagList, singleTagTran.gameObject)
	end

	childCount = self._goSummonFreeTen.transform.childCount

	for i = 1, self._goSummonFreeTen.transform.childCount do
		local singleTagTran = self._goSummonFreeTen.transform:GetChild(i - 1)

		table.insert(self._summonFreeTenTagList, singleTagTran.gameObject)
	end

	gohelper.setActive(self._gosummonreddot, true)

	self._summonreddot = MonoHelper.addNoUpdateLuaComOnceToGo(self._gosummonreddot, SwitchMainUIReddotIcon)

	self._summonreddot:setShowReddotCb(self._isShowSummonReddot, self)
end

function SwitchMainUIShowView:_loadFinishCurrency()
	local assetItem = self._currencyLoader:getAssetItem(CurrencyView.prefabPath)
	local viewPrefab = assetItem:GetResource(CurrencyView.prefabPath)

	self._currencyView = self._currencyView or gohelper.clone(viewPrefab, self._gorighttop)
	self._gocurrency = gohelper.findChild(self._currencyView, "#go_container/#go_currency")
end

function SwitchMainUIShowView:_checkActivityImgVisible()
	local isShow = ActivityModel.showActivityEffect()

	self._festivalAtmosphereComp:setFestival(isShow)
end

function SwitchMainUIShowView:onOpen()
	self:_refreshBtns()
	self:_refreshView()
	self:_checkActivityImgVisible()
end

function SwitchMainUIShowView:_refreshBtns()
	local taskShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Task)

	gohelper.setActive(self._btnquest.gameObject, taskShow)

	local storageShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Storage)

	gohelper.setActive(self._btnstorage.gameObject, storageShow)

	local bankShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Bank)

	gohelper.setActive(self._btnbank.gameObject, bankShow)

	local roomShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Room)

	gohelper.setActive(self._btnroom.gameObject, roomShow)

	local isUnLockRoom = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room)

	self._roomCanvasGroup.alpha = isUnLockRoom and 1 or 0.65

	gohelper.setActive(self._goroomlock, not isUnLockRoom)
	gohelper.setActive(self._btnmail.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Mail))
	gohelper.setActive(self._btnsummon.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon))
	gohelper.setActive(self._btnrole.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Role))
	gohelper.setActive(self._btnswitchrole.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.MainThumbnail))

	if CommandStationEnum.ForceHideCommandStation then
		gohelper.setActive(self._btncopost.gameObject, false)
	else
		gohelper.setActive(self._btncopost.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.CommandStation) and not VersionValidator.instance:isInReviewing())
	end
end

function SwitchMainUIShowView:_initOffsetGos()
	self._offsetGos = self:getUserDataTb_()

	table.insert(self._offsetGos, {
		offsetType = 1,
		go = self._goleft
	})
	table.insert(self._offsetGos, {
		offsetType = 1,
		go = self._golefttop
	})
	table.insert(self._offsetGos, {
		offsetType = 2,
		go = self._goright
	})
	table.insert(self._offsetGos, {
		offsetType = 2,
		go = self._gorighttop
	})
	table.insert(self._offsetGos, {
		offsetType = 2,
		go = self._goactbgGo
	})

	for _, v in ipairs(self._offsetGos) do
		v.anchorX = recthelper.getAnchorX(v.go.transform)
	end

	self._scale = MainUISwitchEnum.MainUIScale

	self:_refreshOffest()
end

function SwitchMainUIShowView:_refreshOffest(isFull)
	local offsetType = MainUISwitchEnum.SwitchMainUIOffsetType
	local scale = isFull and 1 or self._scale

	transformhelper.setLocalScale(self.viewGO.transform, scale, scale, 1)

	for _, v in ipairs(self._offsetGos) do
		if offsetType[v.offsetType] and not isFull then
			if not offsetType[v.offsetType].offsetX then
				local offset = 0
				local anchorX = v.anchorX + offset

				recthelper.setAnchorX(v.go.transform, anchorX)
			end
		end
	end
end

function SwitchMainUIShowView:_refreshScale(scale)
	self._scale = scale

	transformhelper.setLocalScale(self.viewGO.transform, scale, scale, 1)
end

function SwitchMainUIShowView:_refreshView()
	self:_refreshRedDot()
	self:_refreshPower()
	self:_refreshBgm()
	self:_refreshBackpack()
	self:_refreshSummonNewFlag()
	self:_setPlayerInfo(PlayerModel.instance:getPlayinfo())
	self:_showCurrency()
	self:showStoreDeadline(false)
end

function SwitchMainUIShowView:_setPlayerInfo(playerinfo)
	local level = playerinfo.level

	self._txtlevel.text = playerinfo.level
	self._txtname.text = playerinfo.name
	self._txtid.text = "ID:" .. playerinfo.userId

	local exp_now = playerinfo.exp
	local exp_max = 0

	if level < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		exp_max = PlayerConfig.instance:getPlayerLevelCO(level + 1).exp
	else
		exp_max = PlayerConfig.instance:getPlayerLevelCO(level).exp
		exp_now = exp_max
	end

	self._imageslider.fillAmount = exp_now / exp_max

	if self._lastUpdateLevel ~= playerinfo.level then
		self._lastUpdateLevel = playerinfo.level
	end

	self:_refreshPower()
end

function SwitchMainUIShowView:_refreshSummonNewFlagStyle()
	if self.viewParam then
		if not self.viewParam.SkinId then
			local skinId = MainUISwitchModel.instance:getCurUseUI()

			self._summonreddot:showCurUIRedDot(skinId)
		end
	end
end

function SwitchMainUIShowView:_refreshSummonNewFlag()
	self:_refreshSummonNewFlagStyle()

	local isSummonUnlock = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon)
	local needReddot = SummonMainModel.instance:entryNeedReddot()

	self._summonreddot:refreshRedDot()

	local hasFree, freeSinglePoolId = SummonMainModel.instance:entryHasFree()
	local hasFree10Count, freeTenPoolId = SummonMainModel.instance:entryHasFree10Count()
	local hasNew = SummonMainModel.instance:entryHasNew()
	local hasCanget = SummonMainModel.instance:entryHasCanget()
	local showNew = isSummonUnlock and not needReddot and not hasFree10Count and hasNew

	for _, new in ipairs(self._imagesummonnews) do
		gohelper.setActive(new, showNew)
	end

	gohelper.setActive(self._goFreeTag, isSummonUnlock and (hasFree or hasFree10Count or hasCanget))
	gohelper.setActive(self._goSummonFreeOne.gameObject, isSummonUnlock and hasFree and not hasFree10Count)
	gohelper.setActive(self._goSummonFreeTen.gameObject, isSummonUnlock and hasFree10Count)
	gohelper.setActive(self._goSummonCanget, isSummonUnlock and hasCanget and not hasFree and not hasFree10Count)

	if not isSummonUnlock or not hasFree and not hasFree10Count then
		return
	end

	local showSingle = hasFree and not hasFree10Count
	local poolId = showSingle and freeSinglePoolId or freeTenPoolId
	local poolConfig = SummonConfig.instance:getSummonPool(poolId)
	local tagStyleParam = string.splitToNumber(poolConfig.freeTagStyle, "#")

	if showSingle then
		if not tagStyleParam[1] then
			local styleId = tagStyleParam[2]

			styleId = styleId or SummonEnum.DefaultTagStyle

			if showSingle then
				if not self._summonFreeSingleTagList then
					local tagItemList = self._summonFreeTenTagList

					for index, itemGo in ipairs(tagItemList) do
						gohelper.setActive(itemGo, index == styleId)
					end
				end
			end
		end
	end
end

function SwitchMainUIShowView:_refreshRedDot()
	if self.viewParam then
		if not self.viewParam.SkinId then
			local skinId = MainUISwitchModel.instance:getCurUseUI()

			self._mailreddot:setId(RedDotEnum.DotNode.MailBtn, nil, skinId)
			self._taskreddot:setId(RedDotEnum.DotNode.TaskBtn, nil, skinId)
			self._bankreddot:setId(RedDotEnum.DotNode.StoreBtn, nil, skinId)
			self._mailreddot:defaultRefreshDot()
			self._taskreddot:defaultRefreshDot()
			self._bankreddot:defaultRefreshDot()
			RedDotController.instance:addRedDotTag(self._goreddot, RedDotEnum.DotNode.MainRoomProductionFull)
			RedDotController.instance:addRedDotTag(self._gogreendot, RedDotEnum.DotNode.MainRoomCharacterFaithGetFull)
			RedDotController.instance:addRedDotTag(self._goroomgiftreddot, RedDotEnum.DotNode.RoomGift)
			self._bankreddot:showRedDot()
			self:_refreshSummonNewFlagStyle()
		end
	end
end

function SwitchMainUIShowView:_refreshPower()
	local level = PlayerModel.instance:getPlayinfo().level
	local recoverLimit = PlayerConfig.instance:getPlayerLevelCO(level).maxAutoRecoverPower
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)

	if currencyMO then
		if not currencyMO.quantity then
			local power = 0

			self._txtpower.text = string.format("%s/%s", power, recoverLimit)
		end
	end
end

function SwitchMainUIShowView:_refreshBgm()
	local lightGo = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Effect/bgm")
	local bgmGo = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Obj/s01_obj_b")
	local isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)
	local gear = BGMSwitchModel.instance:getMechineGear()

	gohelper.setActive(lightGo, gear == BGMSwitchEnum.Gear.On1 and isUnlock)
	gohelper.setActive(bgmGo, isUnlock)

	if not bgmGo then
		logError("_refreshBgm no bgmGo")
	end

	if not lightGo then
		logError("_refreshBgm no lightGo")
	end
end

function SwitchMainUIShowView:_refreshBackpack()
	self._itemDeadline = BackpackModel.instance:getItemDeadline()
	self._laststorageDeadLineHasDay = nil

	self:_onRefreshDeadline()
end

function SwitchMainUIShowView:_onRefreshDeadline()
	if self._itemDeadline and self._itemDeadline > 0 then
		gohelper.setActive(self._txttime.gameObject, true)

		local limitSec = self._itemDeadline - ServerTime.now()

		if limitSec <= 0 then
			gohelper.setActive(self._godeadline, false)

			return
		end

		self._txttime.text, self._txtformat.text, self._storageDeadLineHasDay = TimeUtil.secondToRoughTime(math.floor(limitSec), true)

		gohelper.setActive(self._godeadline, true)

		if self._laststorageDeadLineHasDay == nil or self._laststorageDeadLineHasDay ~= self._storageDeadLineHasDay then
			UISpriteSetMgr.instance:setCommonSprite(self._imagetimebg, self._storageDeadLineHasDay and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(self._imagetimeicon, self._storageDeadLineHasDay and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(self._txttime, self._storageDeadLineHasDay and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(self._txtformat, self._storageDeadLineHasDay and "#98D687" or "#E99B56")
			gohelper.setActive(self._godeadlineEffect, not self._storageDeadLineHasDay)

			self._laststorageDeadLineHasDay = self._storageDeadLineHasDay
		end
	else
		gohelper.setActive(self._godeadline, false)
		gohelper.setActive(self._txttime.gameObject, false)
	end
end

function SwitchMainUIShowView:showStoreDeadline(needShow)
	if not self.viewGO then
		return
	end

	local deadlineItem = self:getOrCreateStoreDeadline()

	deadlineItem.needShow = needShow or deadlineItem.needShow

	if deadlineItem.needShow then
		local deadlineHasDay = false
		local storeEntranceCfg = StoreConfig.instance:getTabConfig(StoreEnum.StoreId.LimitStore)
		local deadlineTimeSec = 0

		if storeEntranceCfg then
			local sec = StoreHelper.getRemainExpireTime(storeEntranceCfg)

			if sec and sec > 0 and sec <= TimeUtil.OneDaySecond * 7 then
				deadlineTimeSec = sec
			end
		end

		local decorateSec = 0
		local decorateStoreCfg = StoreConfig.instance:getTabConfig(StoreEnum.StoreId.DecorateStore)

		if decorateStoreCfg and decorateStoreCfg.openId ~= nil and decorateStoreCfg.openId ~= 0 then
			if OpenModel.instance:isFunctionUnlock(decorateStoreCfg.openId) then
				decorateSec = StoreHelper.getRemainExpireTimeDeepByStoreId(StoreEnum.StoreId.DecorateStore)
			end
		else
			decorateSec = StoreHelper.getRemainExpireTimeDeepByStoreId(StoreEnum.StoreId.DecorateStore)
		end

		if decorateSec > 0 and decorateSec < TimeUtil.OneWeekSecond then
			deadlineTimeSec = deadlineTimeSec <= 0 and decorateSec or Mathf.Min(decorateSec, deadlineTimeSec)
		end

		if deadlineTimeSec > 0 then
			gohelper.setActive(deadlineItem.godeadline, true)
			gohelper.setActive(deadlineItem.txttime.gameObject, true)

			deadlineItem.txttime.text, deadlineItem.txtformat.text, deadlineHasDay = TimeUtil.secondToRoughTime(math.floor(deadlineTimeSec), true)

			UISpriteSetMgr.instance:setCommonSprite(deadlineItem.imagetimebg, deadlineHasDay and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(deadlineItem.imagetimeicon, deadlineHasDay and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(deadlineItem.txttime, deadlineHasDay and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(deadlineItem.txtformat, deadlineHasDay and "#98D687" or "#E99B56")
			gohelper.setActive(deadlineItem.godeadlineEffect, not deadlineHasDay)

			return
		end
	end

	gohelper.setActive(deadlineItem.godeadline, false)
	gohelper.setActive(deadlineItem.txttime.gameObject, false)
end

function SwitchMainUIShowView:getOrCreateStoreDeadline()
	if not self._deadlineStore then
		self._deadlineStore = self:getUserDataTb_()
		self._deadlineStore.godeadline = self._godeadlinebank
		self._deadlineStore.godeadlineEffect = gohelper.findChild(self._deadlineStore.godeadline, "#effect")
		self._deadlineStore.txttime = gohelper.findChildText(self._deadlineStore.godeadline, "#txt_time")
		self._deadlineStore.txtformat = gohelper.findChildText(self._deadlineStore.godeadline, "#txt_time/#txt_format")
		self._deadlineStore.imagetimebg = gohelper.findChildImage(self._deadlineStore.godeadline, "timebg")
		self._deadlineStore.imagetimeicon = gohelper.findChildImage(self._deadlineStore.godeadline, "#txt_time/timeicon")
	end

	return self._deadlineStore
end

function SwitchMainUIShowView:showBankNewEffect(state)
	gohelper.setActive(self._gobankeffect, state)
end

function SwitchMainUIShowView:_showCurrency()
	local currencyParam = {
		CurrencyEnum.CurrencyType.Gold,
		CurrencyEnum.CurrencyType.FreeDiamondCoupon,
		CurrencyEnum.CurrencyType.Diamond
	}

	for i, param in ipairs(currencyParam) do
		local item = self:getCurrencyItem(i)
		local currencyMO = CurrencyModel.instance:getCurrency(param)
		local currencyCO = CurrencyConfig.instance:getCurrencyCo(param)

		if currencyMO then
			if not currencyMO.quantity then
				local quantity = 0
				local currencyname = currencyCO.icon

				UISpriteSetMgr.instance:setCurrencyItemSprite(item.image, currencyname .. "_1")

				item.txt.text = GameUtil.numberDisplay(quantity)

				gohelper.setActive(item.go, true)
			end
		end
	end
end

function SwitchMainUIShowView:getCurrencyItem(index)
	local currencyObj = self._currencyObjs[index]

	if not currencyObj then
		currencyObj = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gocurrency, "currency")

		currencyObj.go = go
		currencyObj.image = gohelper.findChildImage(go, "#btn_currency/#image")
		currencyObj.simage = gohelper.findChildSingleImage(go, "#btn_currency/#simage")
		currencyObj.txt = gohelper.findChildText(go, "#btn_currency/content/#txt")
		currencyObj.exchangetip = gohelper.findChild(go, "#btn_currency/#btn_exchangetip")

		gohelper.setActive(currencyObj.simage, false)
		gohelper.setActive(currencyObj.exchangetip, false)

		self._currencyObjs[index] = currencyObj
	end

	return currencyObj
end

function SwitchMainUIShowView:_onSwitchUIVisible(visible)
	self:_refreshOffest(not visible)
end

function SwitchMainUIShowView:onClose()
	if self._currencyLoader then
		self._currencyLoader:dispose()

		self._currencyLoader = nil
	end

	self._festivalAtmosphereComp:onDestroy()
	tabletool.clear(self._summonFreeSingleTagList)
	tabletool.clear(self._summonFreeTenTagList)

	self._summonFreeSingleTagList = nil
	self._summonFreeTenTagList = nil
end

function SwitchMainUIShowView:_refreshSummonTuziRed()
	local bLooked = Act101VersionSummonController.instance:getSavedTakeALookSummon()
	local bShowRed = not bLooked

	if not bLooked then
		bShowRed = Act101VersionSummonController.instance:isCliamed()

		local actId = Act101VersionSummonController.instance:actId()
		local dayBonusList = ActivityType101Config.instance:getDayBonusList(actId, 1)

		if bShowRed and dayBonusList and #dayBonusList > 0 then
			local itemCO = dayBonusList[1]
			local materilType = itemCO[1]
			local materilId = itemCO[2]
			local has = ItemModel.instance:getItemQuantity(materilType, materilId)

			bShowRed = has > 0
		else
			bShowRed = false
		end
	end

	for _, go in ipairs(self._tuziGoList) do
		gohelper.setActive(go, bShowRed)
	end
end

return SwitchMainUIShowView
