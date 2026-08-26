-- chunkname: @modules/logic/summon/view/custompick/SummonStrongOneCustomPickView.lua

module("modules.logic.summon.view.custompick.SummonStrongOneCustomPickView", package.seeall)

local SummonStrongOneCustomPickView = class("SummonStrongOneCustomPickView", BaseView)

function SummonStrongOneCustomPickView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_fullbg")
	self._gounselected = gohelper.findChild(self.viewGO, "#go_ui/current/#go_unselected")
	self._simagerole3unselected = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_unselected/#simage_role3_unselected")
	self._simagerole4unselected = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_unselected/#simage_role4_unselected")
	self._simagerole2unselected = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_unselected/#simage_role2_unselected")
	self._goselfselect = gohelper.findChild(self.viewGO, "#go_ui/current/#go_unselected/#go_selfselect")
	self._btnselfselect = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/current/#go_unselected/#go_selfselect/#btn_selfselect")
	self._goselected = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected")
	self._goreshape = gohelper.findChild(self.viewGO, "#go_ui/current/#go_reshape")
	self._gorole1 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role1")
	self._simagerole1outline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_outline")
	self._simagerole1selected = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_selected")
	self._gocharacteritem1 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role1/#go_characteritem1")
	self._btnrefresh = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/current/#go_selected/#btn_refresh")
	self._simagerolerefresh = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#btn_refresh/#simage_role_refresh")
	self._gosummonbtns = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/#btn_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/currency/#txt_currency1_2")
	self._gosummon10 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/currency/#txt_currency10_2")
	self._gocount = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/#go_count")
	self._txtcount = gohelper.findChildText(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/#go_count/#txt_count")
	self._gosummon10normal = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal")
	self._btnsummon10normal = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/#btn_summon10_normal")
	self._simagecurrency10normal = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/currency/#simage_currency10_normal")
	self._txtcurrency101normal = gohelper.findChildText(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/currency/#txt_currency10_1_normal")
	self._txtcurrency102normal = gohelper.findChildText(self.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/currency/#txt_currency10_2_normal")
	self._simagetitle1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/title/#simage_title1")
	self._godisCountTip = gohelper.findChild(self.viewGO, "#go_ui/current/tip/#go_disCountTip")
	self._simagetips = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/#go_disCountTip/#simage_tips")
	self._gotip2bg = gohelper.findChild(self.viewGO, "#go_ui/current/tip/#go_disCountTip/#go_tip2bg")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_ui/current/tip/#go_disCountTip/#txt_tips")
	self._simagetips2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/#simage_tips2")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/#txt_deadline")
	self._simageline3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#txt_deadline/#simage_line3")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_ui/#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonStrongOneCustomPickView:addEvents()
	self._btnselfselect:AddClickListener(self._btnselfselectOnClick, self)
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
	self._btnsummon10normal:AddClickListener(self._btnsummon10normalOnClick, self)
end

function SummonStrongOneCustomPickView:removeEvents()
	self._btnselfselect:RemoveClickListener()
	self._btnrefresh:RemoveClickListener()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
	self._btnsummon10normal:RemoveClickListener()
end

function SummonStrongOneCustomPickView:_btnsummon10normalOnClick()
	self:_btnsummon10OnClick()
end

function SummonStrongOneCustomPickView:_btnrefreshOnClick()
	self:openSelectView()
end

function SummonStrongOneCustomPickView:_btnselfselectOnClick()
	self:openSelectView()
end

SummonStrongOneCustomPickView.preloadList = {
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_role1.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_role3.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_role4.png"
}

function SummonStrongOneCustomPickView:openSelectView()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = curPool.id
	})
end

function SummonStrongOneCustomPickView:_btnsummon1OnClick()
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	if SummonMainModel.instance:checkCanUseInfallibleItem(curPool.id) and not SummonMainModel.instance:checkHaveShowUseInfallibleItemTip(curPool.id) then
		local tipId = MessageBoxIdDefine.SummonInfallibleUsingTip

		GameFacade.showMessageBox(tipId, MsgBoxEnum.BoxType.Yes_No, self._onContinueUseCommon1Summon, nil, nil, self, nil)
	else
		self:_btnsummon1OnClick_1()
	end
end

function SummonStrongOneCustomPickView:_onContinueUseCommon1Summon()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainModel.instance:setHaveShowUseInfallibleItemTip(curPool.id, true)
	self:_btnsummon1OnClick_1()
end

function SummonStrongOneCustomPickView:_btnsummon1OnClick_1()
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

function SummonStrongOneCustomPickView:_btnsummon1OnClick_2()
	SummonMainController.instance:summon1Action()
end

function SummonStrongOneCustomPickView:_btnsummon10OnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	if SummonMainModel.instance:checkCanUseInfallibleItem(curPool.id) and not SummonMainModel.instance:checkHaveShowUseInfallibleItemTip(curPool.id) then
		local tipId = MessageBoxIdDefine.SummonInfallibleUsingTip

		GameFacade.showMessageBox(tipId, MsgBoxEnum.BoxType.Yes_No, self._onContinueUseCommon10Summon, nil, nil, self, nil)
	else
		self:_btnsummon10OnClick_1()
	end
end

function SummonStrongOneCustomPickView:_onContinueUseCommon10Summon()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainModel.instance:setHaveShowUseInfallibleItemTip(curPool.id, true)
	self:_btnsummon10OnClick_1()
end

function SummonStrongOneCustomPickView:_btnsummon10OnClick_1()
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

function SummonStrongOneCustomPickView:_btnsummon10OnClick_2()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:summon10Action()
end

function SummonStrongOneCustomPickView:_onClickDetail()
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	local pickHeroIds = self:getPickHeroIds(pool)

	if pickHeroIds and #pickHeroIds > 0 then
		local heroId = pickHeroIds[1]

		if heroId then
			ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
				heroId = heroId
			})
		end
	end
end

function SummonStrongOneCustomPickView:_editableInitView()
	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simageline3:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	self._characteritem = self:getUserDataTb_()
	self._characteritem.go = self._gocharacteritem1
	self._characteritem.imagecareer = gohelper.findChildImage(self._characteritem.go, "image_career")
	self._characteritem.txtnamecn = gohelper.findChildText(self._characteritem.go, "txt_namecn")
	self._characteritem.btndetail = gohelper.findChildButtonWithAudio(self._characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
	self._characteritem.gorole = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role1")
	self._characteritem.simagehero = self._simagerole1selected
	self._characteritem.simageheroRefresh = self._simagerolerefresh
	self._characteritem.rares = self:getUserDataTb_()

	for j = 1, 6 do
		local rareGO = gohelper.findChild(self._characteritem.go, "rare/go_rare" .. j)

		table.insert(self._characteritem.rares, rareGO)
	end

	self._btncheck1 = gohelper.findChildButton(self.viewGO, "#go_ui/current/#go_unselected/#btn_check_1")
	self._btncheck2 = gohelper.findChildButton(self.viewGO, "#go_ui/current/#go_selected/#btn_check_2")

	self._btncheck1:AddClickListener(self._btnOpenOnClick1, self)
	self._btncheck2:AddClickListener(self._btnOpenOnClick2, self)
	self._characteritem.btndetail:AddClickListener(self._onClickDetail, self)
end

function SummonStrongOneCustomPickView:onOpen()
	self:addAllEvents()
	self:playEnterAnim()
	self:refreshView()
end

function SummonStrongOneCustomPickView:onClose()
	self:removeAllEvents()
end

function SummonStrongOneCustomPickView:onDestroyView()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
	self._simagecurrency10normal:UnLoadImage()
	self._simageline3:UnLoadImage()

	if self._compFreeButton then
		self._compFreeButton:dispose()

		self._compFreeButton = nil
	end

	if self._compInfallibleButton then
		self._compInfallibleButton:dispose()

		self._compInfallibleButton = nil
	end

	if self._characteritem then
		self._characteritem.btndetail:RemoveClickListener()
		self._characteritem.simagehero:UnLoadImage()
		self._characteritem.simageheroRefresh:UnLoadImage()
		self._simagerole1outline:UnLoadImage()

		self._characteritem = nil
	end

	self._btncheck1:RemoveClickListener()
	self._btncheck2:RemoveClickListener()
end

function SummonStrongOneCustomPickView:refreshFreeSummonButton(poolCo)
	self._compFreeButton = self._compFreeButton or SummonFreeSingleGacha.New(self._btnsummon1.gameObject, poolCo.id)

	self._compFreeButton:refreshUI()
end

function SummonStrongOneCustomPickView:refreshInfallibleSummonButton(poolCo)
	local btnGroupList = {}

	table.insert(btnGroupList, self._goselfselect)
	table.insert(btnGroupList, self._gosummonbtns)

	local referenceGo = self._goselected

	self._compInfallibleButton = self._compInfallibleButton or SummonDestinyGiftItem.New(btnGroupList, referenceGo, poolCo.id)

	self._compInfallibleButton:refreshUI()
end

function SummonStrongOneCustomPickView:refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")
		self:refreshCost10(curPool.cost10)
	end
end

function SummonStrongOneCustomPickView:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.instance.getCostByConfig(costs)
	local cost_icon = SummonMainModel.instance.getSummonItemIcon(cost_type, cost_id)

	icon:LoadImage(cost_icon)

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function SummonStrongOneCustomPickView:refreshCost10(costs)
	local curPoolId = SummonMainModel.instance:getCurId()
	local cost_type, cost_id, costNum, ownNum, cost_num = SummonMainModel.instance:getCost10ById(curPoolId, true)
	local cost_icon = SummonMainModel.instance.getSummonItemIcon(cost_type, cost_id)

	self._simagecurrency10:LoadImage(cost_icon)
	self._simagecurrency10normal:LoadImage(cost_icon)

	local discountCostId = SummonMainModel.instance:getDiscountCostId(curPoolId, cost_id)
	local discountTime10Server = SummonMainModel.instance:getDiscountTime10Server(curPoolId)
	local showDisCount = discountTime10Server > 0

	gohelper.setActive(self._gotip2bg, showDisCount)
	gohelper.setActive(self._txttips.gameObject, showDisCount)
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

function SummonStrongOneCustomPickView:getPickHeroIds(pool)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(pool.id)

	if summonServerMO and summonServerMO.customPickMO then
		return summonServerMO.customPickMO.pickHeroIds
	end

	return nil
end

function SummonStrongOneCustomPickView:refreshPickHero(pool)
	local pickHeroIds = self:getPickHeroIds(pool)

	if pickHeroIds then
		if not pickHeroIds[1] then
			local pickHeroId

			if pickHeroId ~= nil and self._characteritem then
				local heroConfig = HeroConfig.instance:getHeroCO(pickHeroId)

				UISpriteSetMgr.instance:setCommonSprite(self._characteritem.imagecareer, "lssx_" .. tostring(heroConfig.career))

				self._characteritem.txtnamecn.text = heroConfig.name

				for j = 1, 6 do
					gohelper.setActive(self._characteritem.rares[j], j <= CharacterEnum.Star[heroConfig.rare])
				end

				local offsetX, offsetY, scale = self:getOffset(heroConfig.skinId)

				self._characteritem.simagehero:LoadImage(ResUrl.getHeadIconImg(heroConfig.skinId), self.handleLoadedImage, {
					imgTransform = self._simagerole1selected.gameObject.transform,
					offsetX = offsetX,
					offsetY = offsetY,
					scale = scale
				})
				self._simagerole1outline:LoadImage(ResUrl.getHeadIconImg(heroConfig.skinId), self.handleLoadedImage, {
					imgTransform = self._simagerole1outline.gameObject.transform,
					offsetX = offsetX - 5,
					offsetY = offsetY + 2,
					scale = scale
				})
				self._simagerolerefresh:LoadImage(ResUrl.getHandbookheroIcon(heroConfig.skinId), nil)
				gohelper.setActive(self._goreshape, self:_isSpecialDestiny(pickHeroId))
			end
		end
	end
end

function SummonStrongOneCustomPickView:_isSpecialDestiny(heroId)
	local tCharacterDestinyConfig = CharacterDestinyConfig.instance
	local cfg = tCharacterDestinyConfig:getHeroDestiny(heroId)

	if not cfg or string.nilorempty(cfg.facetsId) then
		return false
	end

	local destinyIds = string.splitToNumber(cfg.facetsId, "#")

	for _, destinyId in ipairs(destinyIds) do
		if tCharacterDestinyConfig:getSkillExlevelCos(destinyId) then
			return true
		end
	end

	return false
end

function SummonStrongOneCustomPickView:getOffset(skinId)
	local skinCo = SkinConfig.instance:getSkinCo(skinId)
	local offsetStr = skinCo.skinViewImgOffset

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")
		local offsetX = offsets[1]
		local offsetY = offsets[2]
		local scale = offsets[3]

		return offsetX, offsetY, scale
	end

	return -150, -150, 0.6
end

function SummonStrongOneCustomPickView.handleLoadedImage(param)
	local imgTr = param.imgTransform

	if not param.offsetX then
		if not param.offsetY then
			local offsetY = 0

			if not param.scale then
				local scale = 1

				ZProj.UGUIHelper.SetImageSize(imgTr.gameObject)
				recthelper.setAnchor(imgTr, param.offsetX, offsetY)
				transformhelper.setLocalScale(imgTr, scale, scale, scale)
			end
		end
	end
end

function SummonStrongOneCustomPickView:refreshView()
	self.summonSuccess = false

	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		gohelper.setActive(self._goui, false)

		return
	end

	self:refreshPoolUI()
end

function SummonStrongOneCustomPickView:refreshPoolUI()
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	local isPick = SummonCustomPickModel.instance:isCustomPickOver(pool.id)

	self:refreshPickHero(pool)
	gohelper.setActive(self._goselected, isPick)
	gohelper.setActive(self._gounselected, not isPick)

	if isPick then
		self:refreshCost()
		self:refreshFreeSummonButton(pool)
	end

	local canShowGift = SummonMainModel.instance:canShowDestinyGift(pool.id)

	if canShowGift then
		self:refreshInfallibleSummonButton(pool)
	end

	local isHaveFirstSSR = SummonCustomPickModel.instance:isHaveFirstSSR(pool.id)

	gohelper.setActive(self._simagetips.gameObject, not isHaveFirstSSR)
	gohelper.setActive(self._simagetips2.gameObject, isHaveFirstSSR)
	self:_refreshOpenTime()

	local realyCountTime10 = SummonMainModel.instance:getDiscountCost10(pool.id, 1)

	self._txttips.text = string.format(luaLang("summon_discount_tips"), realyCountTime10)
end

function SummonStrongOneCustomPickView:_refreshOpenTime()
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

function SummonStrongOneCustomPickView:playEnterAnim()
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		self:playAnim(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		self:playAnim(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function SummonStrongOneCustomPickView:playerEnterAnimFromScene()
	self:playAnim(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function SummonStrongOneCustomPickView:playAnim(name, layer, normalizedTime)
	if self._animRoot ~= nil then
		self._animRoot:Play(name, layer, normalizedTime)
	end
end

function SummonStrongOneCustomPickView:addAllEvents()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function SummonStrongOneCustomPickView:removeAllEvents()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function SummonStrongOneCustomPickView:_summon10Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, true)
end

function SummonStrongOneCustomPickView:_summon1Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 1, false, true)
end

function SummonStrongOneCustomPickView:onItemChanged()
	if SummonController.instance.isWaitingSummonResult or self.summonSuccess then
		return
	end

	self:refreshCost()
end

function SummonStrongOneCustomPickView:onSummonFailed()
	self.summonSuccess = false

	self:refreshCost()
end

function SummonStrongOneCustomPickView:onSummonReply()
	self.summonSuccess = true
end

function SummonStrongOneCustomPickView:_btnOpenOnClick1()
	local curPool = SummonMainModel.instance:getCurPool()
	local choseIds = SummonConfig.instance:getStrongCustomChoiceIds(curPool.id)
	local param = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = choseIds
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, param)
end

function SummonStrongOneCustomPickView:_btnOpenOnClick2()
	local curPool = SummonMainModel.instance:getCurPool()
	local choseIds = SummonConfig.instance:getStrongCustomChoiceIds(curPool.id)
	local selectId = self:getPickHeroIds(curPool)[1]
	local index

	for i, v in ipairs(choseIds) do
		if v == selectId then
			index = i

			break
		end
	end

	if index then
		table.remove(choseIds, index)
		table.insert(choseIds, 1, selectId)
	end

	local param = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = choseIds
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, param)
end

return SummonStrongOneCustomPickView
