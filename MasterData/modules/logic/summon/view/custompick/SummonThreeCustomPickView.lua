-- chunkname: @modules/logic/summon/view/custompick/SummonThreeCustomPickView.lua

module("modules.logic.summon.view.custompick.SummonThreeCustomPickView", package.seeall)

local SummonThreeCustomPickView = class("SummonThreeCustomPickView", BaseView)

function SummonThreeCustomPickView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._gounselected = gohelper.findChild(self.viewGO, "#go_ui/current/#go_unselected")
	self._simagebgunselect = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_unselected/#simage_bgunselect")
	self._simageunselect = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_unselected/#simage_unselect")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_unselected/#simage_line")
	self._goselected = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#simage_bg")
	self._simageline1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#simage_line1")
	self._gorole1 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role1")
	self._simagerole1outline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_outline")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1")
	self._gocharacteritem1 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role1/#go_characteritem1")
	self._gorole3 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role3")
	self._simagerole3outline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role3/#simage_role3_outline")
	self._simagerole3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role3/#simage_role3")
	self._gocharacteritem3 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role3/#go_characteritem3")
	self._simagemask2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#simage_mask2")
	self._gorole2 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role2")
	self._simagerole2outline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role2/#simage_role2_outline")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role2/#simage_role2")
	self._gocharacteritem2 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role2/#go_characteritem2")
	self._simageline31 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#simage_line3_1")
	self._simageline32 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#simage_line3_2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#simage_mask")
	self._simageline2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#simage_line2")
	self._simagefrontbg1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg1")
	self._simagefrontbg2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg2")
	self._simagetitle1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/title/#simage_title1")
	self._simagetips = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/#simage_tips")
	self._gotip2bg = gohelper.findChild(self.viewGO, "#go_ui/current/tip/#go_tip2bg")
	self._txttips2 = gohelper.findChildText(self.viewGO, "#go_ui/current/tip/#txt_tips2")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/#txt_deadline")
	self._simageline3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#txt_deadline/#simage_line3")
	self._goselfselect = gohelper.findChild(self.viewGO, "#go_ui/#go_selfselect")
	self._btnselfselect = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#go_selfselect/#btn_selfselect")
	self._gosummonbtns = gohelper.findChild(self.viewGO, "#go_ui/#go_summonbtns")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#go_summonbtns/summon1/#btn_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_2")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#go_summonbtns/summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#txt_currency10_2")
	self._gocount = gohelper.findChild(self.viewGO, "#go_ui/#go_summonbtns/summon10/#go_count")
	self._txtcount = gohelper.findChildText(self.viewGO, "#go_ui/#go_summonbtns/summon10/#go_count/#txt_count")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_ui/#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonThreeCustomPickView:addEvents()
	self._btnselfselect:AddClickListener(self._btnselfselectOnClick, self)
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
end

function SummonThreeCustomPickView:removeEvents()
	self._btnselfselect:RemoveClickListener()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
end

function SummonThreeCustomPickView:_editableInitView()
	logNormal("SummonThreeCustomPickView:_editableInitView()")

	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simageline3:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	self._txttips = gohelper.findChildText(self.viewGO, "#go_ui/current/txt_tips")
	self._characteritems = {}

	local curPool = SummonMainModel.instance:getCurPool()

	self._charaterItemCount = self._charaterItemCount or SummonCustomPickModel.instance:getMaxSelectCount(curPool.id)

	for i = 1, self._charaterItemCount do
		local characteritem = self:getUserDataTb_()
		local indexStr = tostring(i)
		local path = string.format("#go_ui/current/#go_selected/#go_role%s/#go_characteritem%s", indexStr, indexStr)

		characteritem.go = gohelper.findChild(self.viewGO, path)
		characteritem.imagecareer = gohelper.findChildImage(characteritem.go, "image_career")
		characteritem.txtnamecn = gohelper.findChildText(characteritem.go, "txt_namecn")
		characteritem.btndetail = gohelper.findChildButtonWithAudio(characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
		characteritem.gorole = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role" .. indexStr)
		characteritem.simagehero = gohelper.findChildSingleImage(characteritem.gorole, "#simage_role" .. indexStr)
		characteritem.simageroleoutline = gohelper.findChildSingleImage(characteritem.gorole, string.format("#simage_role%s_outline", indexStr))
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

function SummonThreeCustomPickView:onUpdateParam()
	return
end

function SummonThreeCustomPickView:onOpen()
	logNormal("SummonThreeCustomPickView:onOpen()")
	self:playEnterAnim()
	self:refreshView()
	self:addAllEvents()
end

function SummonThreeCustomPickView:onClose()
	logNormal("SummonThreeCustomPickView:onClose()")
	self:removeAllEvents()
end

function SummonThreeCustomPickView:onDestroyView()
	logNormal("SummonThreeCustomPickView:onDestroyView()")
	self._simagebg:UnLoadImage()
	self._simagebgunselect:UnLoadImage()
	self._simageunselect:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simageline1:UnLoadImage()
	self._simageline2:UnLoadImage()
	self._simageline3:UnLoadImage()
	self._simageline31:UnLoadImage()
	self._simageline32:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simagemask2:UnLoadImage()
	self._simagefrontbg1:UnLoadImage()
	self._simagefrontbg2:UnLoadImage()
	self._simagetitle1:UnLoadImage()
	self._simagetips:UnLoadImage()

	if self._compFreeButton then
		self._compFreeButton:dispose()

		self._compFreeButton = nil
	end

	if self._characteritems then
		for i, item in ipairs(self._characteritems) do
			item.btndetail:RemoveClickListener()
			item.simagehero:UnLoadImage()
			item.simageroleoutline:UnLoadImage()
		end

		self._characteritems = nil
	end
end

function SummonThreeCustomPickView:_btnselfselectOnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = curPool.id
	})
end

function SummonThreeCustomPickView:_btnsummon1OnClick()
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

function SummonThreeCustomPickView:_btnsummon1OnClick_2()
	local summonMainModel = SummonMainModel.instance
	local curPool = summonMainModel:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:summon1Action()
end

function SummonThreeCustomPickView:_btnsummon10OnClick()
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

function SummonThreeCustomPickView:_btnsummon10OnClick_2()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:summon10Action()
end

function SummonThreeCustomPickView:_summon10Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, true)
end

function SummonThreeCustomPickView:_summon1Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 1, false, true)
end

function SummonThreeCustomPickView:refreshView()
	self.summonSuccess = false

	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		gohelper.setActive(self._goui, false)

		return
	end

	self:refreshPoolUI()
end

function SummonThreeCustomPickView:getPickHeroIds(pool)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(pool.id)

	if summonServerMO and summonServerMO.customPickMO then
		return summonServerMO.customPickMO.pickHeroIds
	end

	return nil
end

function SummonThreeCustomPickView:refreshPoolUI()
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	local pick = SummonCustomPickModel.instance:isCustomPickOver(pool.id)

	self:handlePickStatus(pick, pool)
	self:_refreshOpenTime()
end

function SummonThreeCustomPickView:handlePickStatus(pick, pool)
	gohelper.setActive(self._gosummonbtns, pick)
	gohelper.setActive(self._goselected, pick)

	local notPick = not pick

	gohelper.setActive(self._simageunselect, notPick)
	gohelper.setActive(self._goselfselect, notPick)
	gohelper.setActive(self._txttips, notPick)
	gohelper.setActive(self._simageunselect, notPick)

	if pick then
		self:refreshCost()
		self:refreshFreeSummonButton(pool)
		self:refreshPickHeroes(pool)
	else
		for i = 1, self._charaterItemCount do
			self:refreshPickHero(pool.id, i, nil)
		end
	end
end

function SummonThreeCustomPickView:refreshPickHeroes(pool)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(pool.id)

	if summonServerMO and summonServerMO.customPickMO then
		local pickHeroIds = summonServerMO.customPickMO.pickHeroIds

		for i = 1, self._charaterItemCount do
			local heroId = pickHeroIds[i]

			self:refreshPickHero(pool.id, i, heroId)
		end
	end
end

function SummonThreeCustomPickView:refreshPickHero(poolId, index, heroId)
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

			local offsetX, offsetY, scale = self:getOffset(heroConfig.skinId)

			item.simagehero:LoadImage(ResUrl.getHeadIconImg(heroConfig.skinId), self.handleLoadedImageOutline, {
				imgTransform = item.simagehero.gameObject.transform,
				offsetX = offsetX,
				offsetY = offsetY,
				scale = scale
			})
			item.simageroleoutline:LoadImage(ResUrl.getHeadIconImg(heroConfig.skinId), self.handleLoadedImageOutline, {
				imgTransform = item.simageroleoutline.gameObject.transform,
				offsetX = offsetX - 5,
				offsetY = offsetY + 2,
				scale = scale
			})
		else
			gohelper.setActive(item.go, false)
			gohelper.setActive(item.simagehero, false)
		end
	end
end

function SummonThreeCustomPickView:getOffset(skinId)
	local skinCo = SkinConfig.instance:getSkinCo(skinId)
	local offsetStr = skinCo.summonPickUpImgOffset

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")
		local offsetX = offsets[1]
		local offsetY = offsets[2]
		local scale = offsets[3]

		return offsetX, offsetY, scale
	end

	return -150, -150, 0.6
end

function SummonThreeCustomPickView.handleLoadedImage(param)
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

function SummonThreeCustomPickView.handleLoadedImageOutline(param)
	local imgTr = param.imgTransform
	local offsetX = param.offsetX
	local offsetY = param.offsetY
	local scale = param.scale

	ZProj.UGUIHelper.SetImageSize(imgTr.gameObject)
	recthelper.setAnchor(imgTr, offsetX, offsetY)
	transformhelper.setLocalScale(imgTr, scale, scale, scale)
end

function SummonThreeCustomPickView:refreshFreeSummonButton(poolCo)
	self._compFreeButton = self._compFreeButton or SummonFreeSingleGacha.New(self._btnsummon1.gameObject, poolCo.id)

	self._compFreeButton:refreshUI()
end

function SummonThreeCustomPickView:_onClickDetailByIndex(index)
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

function SummonThreeCustomPickView:_refreshOpenTime()
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

function SummonThreeCustomPickView:refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")
		self:refreshCost10(curPool.cost10)
	end
end

function SummonThreeCustomPickView:refreshTicket()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	self._txtticket.text = tostring((curPool.ticketId ~= 0 or nil) and ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, curPool.ticketId))
end

function SummonThreeCustomPickView:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(costs, true)
	local cost_icon = SummonMainModel.getSummonItemIcon(cost_type, cost_id)

	icon:LoadImage(cost_icon)

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function SummonThreeCustomPickView:refreshCost10(costs)
	local curPoolId = SummonMainModel.instance:getCurId()
	local cost_type, cost_id, costNum, ownNum, cost_num = SummonMainModel.instance:getCost10ById(curPoolId, true)
	local cost_icon = SummonMainModel.instance.getSummonItemIcon(cost_type, cost_id)

	self._simagecurrency10:LoadImage(cost_icon)

	local discountCostId = SummonMainModel.instance:getDiscountCostId(curPoolId, cost_id)
	local discountTime10Server = SummonMainModel.instance:getDiscountTime10Server(curPoolId)

	gohelper.setActive(self._gotip2bg, discountTime10Server > 0)
	gohelper.setActive(self._txttips2, discountTime10Server > 0)

	if cost_id == discountCostId then
		gohelper.setActive(self._gocount, discountTime10Server > 0)

		if discountTime10Server > 0 then
			local realyCountTime10 = SummonMainModel.instance:getDiscountCost10(curPoolId)
			local discountStr = luaLang("multiple_color")
			local discountColorStr = "#FFE095"

			self._txtcurrency101.text = GameUtil.getSubPlaceholderLuaLangTwoParam(discountStr, discountColorStr, luaLang("multiple") .. realyCountTime10)
			self._txtcurrency102.text = cost_num

			local preferential = (cost_num - realyCountTime10) / cost_num * 100

			self._txtcount.text = string.format(luaLang("summonpickchoice_discount"), preferential)

			return
		end
	else
		gohelper.setActive(self._gocount, false)
	end

	local colorStr = "#000000"
	local languageStr = luaLang("multiple_color")

	self._txtcurrency101.text = GameUtil.getSubPlaceholderLuaLangTwoParam(languageStr, colorStr, luaLang("multiple") .. cost_num)
	self._txtcurrency102.text = ""
end

function SummonThreeCustomPickView:onSummonFailed()
	self.summonSuccess = false

	self:refreshCost()
end

function SummonThreeCustomPickView:onSummonReply()
	self.summonSuccess = true
end

function SummonThreeCustomPickView:onItemChanged()
	if SummonController.instance.isWaitingSummonResult or self.summonSuccess then
		return
	end

	self:refreshCost()
end

function SummonThreeCustomPickView:addAllEvents()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function SummonThreeCustomPickView:removeAllEvents()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function SummonThreeCustomPickView:playEnterAnim()
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		self._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function SummonThreeCustomPickView:playerEnterAnimFromScene()
	self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

return SummonThreeCustomPickView
