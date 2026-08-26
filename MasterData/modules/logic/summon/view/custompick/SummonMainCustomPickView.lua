-- chunkname: @modules/logic/summon/view/custompick/SummonMainCustomPickView.lua

module("modules.logic.summon.view.custompick.SummonMainCustomPickView", package.seeall)

local SummonMainCustomPickView = class("SummonMainCustomPickView", BaseView)

function SummonMainCustomPickView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simageunselect = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_unselect")
	self._goselected = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected")
	self._gorole1 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role1")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1")
	self._gorole2 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role2")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role2/#simage_role2")
	self._gocharacteritem1 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem1")
	self._gocharacteritem2 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem2")
	self._godisCountTip = gohelper.findChild(self.viewGO, "#go_ui/current/tip/#go_disCountTip")
	self._simagetips = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/#go_disCountTip/#simage_tips")
	self._gotip2bg = gohelper.findChild(self.viewGO, "#go_ui/current/tip/#go_disCountTip/#go_tip2bg")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_ui/current/tip/#go_disCountTip/#go_tip2bg/#txt_tips")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/#txt_deadline")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	self._goselfselect = gohelper.findChild(self.viewGO, "#go_ui/#go_selfselect")
	self._btnselfselect = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#go_selfselect/#btn_selfselect")
	self._gosummonbtns = gohelper.findChild(self.viewGO, "#go_ui/#go_summonbtns")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#go_summonbtns/summon1/#btn_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_2")
	self._gosummon10 = gohelper.findChild(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10/currency/#txt_currency10_2")
	self._gocount = gohelper.findChild(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10/#go_count")
	self._txtcount = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10/#go_count/#txt_count")
	self._gosummon10normal = gohelper.findChild(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10_normal")
	self._btnsummon10normal = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10_normal/#btn_summon10_normal")
	self._simagecurrency10normal = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10_normal/currency/#simage_currency10_normal")
	self._txtcurrency101normal = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10_normal/currency/#txt_currency10_1_normal")
	self._txtcurrency102normal = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/#go_summon10_normal/currency/#txt_currency10_2_normal")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_ui/#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainCustomPickView:addEvents()
	self._btnselfselect:AddClickListener(self._btnselfselectOnClick, self)
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
	self._btnsummon10normal:AddClickListener(self._btnsummon10normalOnClick, self)
end

function SummonMainCustomPickView:removeEvents()
	self._btnselfselect:RemoveClickListener()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
	self._btnsummon10normal:RemoveClickListener()
end

function SummonMainCustomPickView:_btnselfselectOnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = curPool.id
	})
end

function SummonMainCustomPickView:_btnsummon10normalOnClick()
	self:_btnsummon10OnClick()
end

SummonMainCustomPickView.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_6/selfselectsix/full/v1a6_selfselectsix_summon_fullbg"),
	ResUrl.getSummonCoverBg("heroversion_1_6/selfselectsix/v1a6_selfselectsix_summon_rolemask"),
	ResUrl.getSummonCoverBg("heroversion_1_6/selfselectsix/v1a6_selfselectsix_summon_mask2")
}

function SummonMainCustomPickView:_editableInitView()
	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	self._characteritems = {}

	local pool = SummonMainModel.instance:getCurPool()

	self._charaterItemCount = SummonCustomPickModel.instance:getMaxSelectCount((pool or nil) and (pool.id or 0))

	for i = 1, self._charaterItemCount do
		local characteritem = self:getUserDataTb_()

		characteritem.go = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem" .. i)
		characteritem.imagecareer = gohelper.findChildImage(characteritem.go, "image_career")
		characteritem.txtnamecn = gohelper.findChildText(characteritem.go, "txt_namecn")
		characteritem.btndetail = gohelper.findChildButtonWithAudio(characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
		characteritem.gorole = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role" .. tostring(i))
		characteritem.simagehero = gohelper.findChildSingleImage(characteritem.gorole, "#simage_role" .. tostring(i))
		characteritem.tfimagehero = characteritem.simagehero.transform
		characteritem.rares = {}

		for j = 1, 6 do
			local rareGO = gohelper.findChild(characteritem.go, "rare/go_rare" .. j)

			table.insert(characteritem.rares, rareGO)
		end

		table.insert(self._characteritems, characteritem)
		characteritem.btndetail:AddClickListener(self._onClickDetailByIndex, self, i)
	end
end

function SummonMainCustomPickView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageunselect:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
	self._simageline:UnLoadImage()

	if self._compFreeButton then
		self._compFreeButton:dispose()

		self._compFreeButton = nil
	end

	if self._characteritems then
		for i, item in ipairs(self._characteritems) do
			item.btndetail:RemoveClickListener()
		end

		self._characteritems = nil
	end
end

function SummonMainCustomPickView:onUpdateParam()
	return
end

function SummonMainCustomPickView:onOpen()
	logNormal("SummonMainCustomPickView:onOpen()")
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
	self:playEnterAnim()
	self:refreshView()
end

function SummonMainCustomPickView:onOpenFinish()
	return
end

function SummonMainCustomPickView:playEnterAnim()
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		self._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function SummonMainCustomPickView:playerEnterAnimFromScene()
	self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function SummonMainCustomPickView:onClose()
	logNormal("SummonMainCustomPickView:onClose()")
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function SummonMainCustomPickView:_btnsummon1OnClick()
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local pickHeroIds = self:getPickHeroIds(curPool)
	local heroId = SummonModel.instance:getSummonFullExSkillHero(curPool.id, pickHeroIds)

	if heroId == nil then
		self:_btnsummon1OnClick_2()
	else
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)
		local heroName = heroConfig.name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, curPool.id, self._btnsummon1OnClick_2, nil, nil, self, nil, nil, heroName)
	end
end

function SummonMainCustomPickView:_btnsummon1OnClick_2()
	if SummonController.instance:isInSummonGuide() then
		return
	end

	SummonMainController.instance:summon1Action()
end

function SummonMainCustomPickView:_btnsummon10OnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local pickHeroIds = self:getPickHeroIds(curPool)
	local heroId = SummonModel.instance:getSummonFullExSkillHero(curPool.id, pickHeroIds)

	if heroId == nil then
		self:_btnsummon10OnClick_2()
	else
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)
		local heroName = heroConfig.name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, curPool.id, self._btnsummon10OnClick_2, nil, nil, self, nil, nil, heroName)
	end
end

function SummonMainCustomPickView:_btnsummon10OnClick_2()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:summon10Action()
end

function SummonMainCustomPickView:_summon10Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, true)
end

function SummonMainCustomPickView:_summon1Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 1, false, true)
end

function SummonMainCustomPickView:_btnpickOnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = curPool.id
	})
end

function SummonMainCustomPickView:_onClickDetailByIndex(index)
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	local summonServerMO = SummonMainModel.instance:getPoolServerMO(pool.id)

	if summonServerMO and summonServerMO.customPickMO then
		local heroId = summonServerMO.customPickMO.pickHeroIds[index]

		if heroId then
			ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
				heroId = heroId
			})
		end
	end
end

function SummonMainCustomPickView:refreshView()
	self.summonSuccess = false

	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		gohelper.setActive(self._goui, false)

		return
	end

	self:refreshPoolUI()
end

function SummonMainCustomPickView:refreshPoolUI()
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	if SummonCustomPickModel.instance:isCustomPickOver(pool.id) then
		self:handlePickOverStatus(pool)
	else
		self:handleNeedPickStatus()
	end

	self:refreshPickHeroes(pool)
	self:_refreshOpenTime()

	local realyCountTime10 = SummonMainModel.instance:getDiscountCost10(pool.id, 1)

	self._txttips.text = string.format(luaLang("summon_discount_tips"), realyCountTime10)

	self:refreshCost()
end

function SummonMainCustomPickView:refreshCost10(costs)
	local curPoolId = SummonMainModel.instance:getCurId()
	local cost_type, cost_id, costNum, ownNum, cost_num = SummonMainModel.instance:getCost10ById(curPoolId)
	local cost_icon = SummonMainModel.instance.getSummonItemIcon(cost_type, cost_id)

	self._simagecurrency10:LoadImage(cost_icon)
	self._simagecurrency10normal:LoadImage(cost_icon)

	local discountCostId = SummonMainModel.instance:getDiscountCostId(curPoolId, cost_id)
	local discountTime10Server = SummonMainModel.instance:getDiscountTime10Server(curPoolId)
	local showDisCount = discountTime10Server > 0

	gohelper.setActive(self._gotip2bg, showDisCount)
	gohelper.setActive(self._gosummon10, showDisCount)
	gohelper.setActive(self._gosummon10normal, not showDisCount)

	local currency101Str = ""
	local currency102Str = ""

	if cost_id == discountCostId then
		gohelper.setActive(self._gocount, discountTime10Server > 0)

		if discountTime10Server > 0 then
			local realyCountTime10 = SummonMainModel.instance:getDiscountCost10(curPoolId)

			currency101Str = string.format("<color=%s>%s</color>", "#FFE095", luaLang("multiple") .. realyCountTime10)
			currency102Str = cost_num

			local preferential = (cost_num - realyCountTime10) / cost_num * 100

			self._txtcount.text = string.format(luaLang("summonpickchoice_discount"), preferential)
		else
			currency101Str = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. cost_num)
		end
	else
		currency101Str = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. cost_num)

		gohelper.setActive(self._gocount, false)
	end

	self._txtcurrency101.text = currency101Str
	self._txtcurrency101normal.text = currency101Str
	self._txtcurrency102.text = currency102Str
	self._txtcurrency102normal.text = currency102Str
end

function SummonMainCustomPickView:handleNeedPickStatus()
	gohelper.setActive(self._gosummonbtns, false)
	gohelper.setActive(self._goselected, false)
	gohelper.setActive(self._simageunselect, true)
	gohelper.setActive(self._goselfselect, true)
	gohelper.setActive(self._simageunselect, true)
end

function SummonMainCustomPickView:handlePickOverStatus(pool)
	gohelper.setActive(self._gosummonbtns, true)
	gohelper.setActive(self._goselected, true)
	gohelper.setActive(self._simageunselect, false)
	gohelper.setActive(self._goselfselect, false)
	gohelper.setActive(self._simageunselect, false)
	self:refreshFreeSummonButton(pool)
end

function SummonMainCustomPickView:refreshPickHeroes(pool)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(pool.id)

	if summonServerMO and summonServerMO.customPickMO then
		for i = 1, self._charaterItemCount do
			local heroId = summonServerMO.customPickMO.pickHeroIds[i]

			self:_refreshPickHero(pool.id, i, heroId)
		end
	end
end

function SummonMainCustomPickView:getPickHeroIds(pool)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(pool.id)

	if summonServerMO and summonServerMO.customPickMO then
		return summonServerMO.customPickMO.pickHeroIds
	end

	return nil
end

function SummonMainCustomPickView:_refreshPickHero(poolId, index, heroId)
	local item = self._characteritems[index]

	if item then
		if heroId then
			gohelper.setActive(item.go, true)
			gohelper.setActive(item.simagehero, true)

			local heroConfig = HeroConfig.instance:getHeroCO(heroId)

			UISpriteSetMgr.instance:setCommonSprite(item.imagecareer, "lssx_" .. tostring(heroConfig.career))

			item.txtnamecn.text = heroConfig.name

			for j = 1, 6 do
				gohelper.setActive(item.rares[j], j <= CharacterEnum.Star[heroConfig.rare])
			end

			item.simagehero:LoadImage(ResUrl.getHeadIconImg(heroConfig.skinId), self.handleLoadedImage, {
				panel = self,
				skinId = heroConfig.skinId,
				index = index
			})
		else
			gohelper.setActive(item.go, false)
			gohelper.setActive(item.simagehero, false)
		end
	end
end

function SummonMainCustomPickView.handleLoadedImage(param)
	local view = param.panel
	local skinId = param.skinId
	local index = param.index
	local item = view._characteritems[index]

	ZProj.UGUIHelper.SetImageSize(item.simagehero.gameObject)

	local skinCo = SkinConfig.instance:getSkinCo(skinId)
	local offsetStr = skinCo.skinViewImgOffset

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(item.tfimagehero, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(item.tfimagehero, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	else
		recthelper.setAnchor(item.tfimagehero, -150, -150)
		transformhelper.setLocalScale(item.tfimagehero, 0.6, 0.6, 0.6)
	end
end

function SummonMainCustomPickView:refreshFreeSummonButton(poolCo)
	self._compFreeButton = self._compFreeButton or SummonFreeSingleGacha.New(self._btnsummon1.gameObject, poolCo.id)

	self._compFreeButton:refreshUI()
end

function SummonMainCustomPickView:refreshRemainTimes(poolCo)
	local times = SummonConfig.getSummonSSRTimes(poolCo)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolCo.id)

	self._txttimes.text = summonServerMO and summonServerMO.luckyBagMO and string.format("%s/%s", summonServerMO.luckyBagMO.summonTimes, times) or "-"
end

function SummonMainCustomPickView:refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")
		self:refreshCost10(curPool.cost10)
	end
end

function SummonMainCustomPickView:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(costs, true)
	local cost_icon = SummonMainModel.getSummonItemIcon(cost_type, cost_id)

	icon:LoadImage(cost_icon)

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function SummonMainCustomPickView:_refreshOpenTime()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local poolMO = SummonMainModel.instance:getPoolServerMO(curPool.id)

	if poolMO ~= nil and poolMO.offlineTime ~= 0 and poolMO.offlineTime < TimeUtil.maxDateTimeStamp then
		local time = poolMO.offlineTime - ServerTime.now()

		self._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(time))
	else
		self._txtdeadline.text = ""
	end
end

function SummonMainCustomPickView:onSummonFailed()
	self.summonSuccess = false

	self:refreshCost()
end

function SummonMainCustomPickView:onSummonReply()
	self.summonSuccess = true
end

function SummonMainCustomPickView:onItemChanged()
	if SummonController.instance.isWaitingSummonResult or self.summonSuccess then
		return
	end

	self:refreshCost()
end

return SummonMainCustomPickView
