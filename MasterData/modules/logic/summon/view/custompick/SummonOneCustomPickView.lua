-- chunkname: @modules/logic/summon/view/custompick/SummonOneCustomPickView.lua

module("modules.logic.summon.view.custompick.SummonOneCustomPickView", package.seeall)

local SummonOneCustomPickView = class("SummonOneCustomPickView", BaseView)

function SummonOneCustomPickView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simageunselect = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_unselect")
	self._goselected = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected")
	self._gorole1 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role1")
	self._simagerole1outline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_outline")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg")
	self._gocharacteritem = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem")
	self._simagetitle1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/title/#simage_title1")
	self._simagetips = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/#simage_tips")
	self._gotip2bg = gohelper.findChild(self.viewGO, "#go_ui/current/tip/#go_tip2bg")
	self._txttips2 = gohelper.findChildText(self.viewGO, "#go_ui/current/tip/#txt_tips2")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/#txt_deadline")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_ui/current/#txt_tips")
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

function SummonOneCustomPickView:addEvents()
	self._btnselfselect:AddClickListener(self._btnselfselectOnClick, self)
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
end

function SummonOneCustomPickView:removeEvents()
	self._btnselfselect:RemoveClickListener()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
end

SummonOneCustomPickView.preloadList = {
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_line4_2.png",
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_line4_1.png",
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_fullbg2.png",
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_line.png",
	"singlebg/summon/heroversion_2_8/v2a8_selfselect2/v2a8_selfselect2_rolebg.png",
	"singlebg/summon/heroversion_2_8/v2a8_selfselect2/v2a8_selfselect2_fullbg.png"
}

function SummonOneCustomPickView:_btnselfselectOnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = curPool.id
	})
end

function SummonOneCustomPickView:_btnsummon1OnClick()
	if SummonController.instance:isInSummonGuide() then
		return
	end

	SummonMainController.instance:summon1Action()
end

function SummonOneCustomPickView:_btnsummon10OnClick()
	SummonMainController.instance:summon10Action()
end

function SummonOneCustomPickView:_onClickDetail()
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

function SummonOneCustomPickView:_editableInitView()
	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	self._characteritem = self:getUserDataTb_()
	self._characteritem.go = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem")
	self._characteritem.imagecareer = gohelper.findChildImage(self._characteritem.go, "image_career")
	self._characteritem.txtnamecn = gohelper.findChildText(self._characteritem.go, "txt_namecn")
	self._characteritem.btndetail = gohelper.findChildButtonWithAudio(self._characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
	self._characteritem.gorole = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role1")
	self._characteritem.simagehero = gohelper.findChildSingleImage(self._characteritem.gorole, "#simage_role1")
	self._characteritem.tfimagehero = self._characteritem.simagehero.transform
	self._characteritem.rares = self:getUserDataTb_()

	for j = 1, 6 do
		local rareGO = gohelper.findChild(self._characteritem.go, "rare/go_rare" .. j)

		table.insert(self._characteritem.rares, rareGO)
	end

	self._characteritem.btndetail:AddClickListener(self._onClickDetail, self)
end

function SummonOneCustomPickView:onUpdateParam()
	return
end

function SummonOneCustomPickView:onOpen()
	self:addAllEvents()
	self:playEnterAnim()
	self:refreshView()
end

function SummonOneCustomPickView:onClose()
	self:removeAllEvents()
end

function SummonOneCustomPickView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageunselect:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagefrontbg:UnLoadImage()

	if self._compFreeButton then
		self._compFreeButton:dispose()

		self._compFreeButton = nil
	end

	if self._characteritem then
		self._characteritem.btndetail:RemoveClickListener()
		self._characteritem.simagehero:UnLoadImage()
		self._simagerole1outline:UnLoadImage()

		self._characteritem = nil
	end
end

function SummonOneCustomPickView:handleNeedPickStatus(pool)
	gohelper.setActive(self._gosummonbtns, false)
	gohelper.setActive(self._goselected, false)
	gohelper.setActive(self._simageunselect, true)
	gohelper.setActive(self._goselfselect, true)
	gohelper.setActive(self._txttips, true)
	gohelper.setActive(self._simageunselect, true)
end

function SummonOneCustomPickView:handlePickOverStatus(pool)
	gohelper.setActive(self._gosummonbtns, true)
	gohelper.setActive(self._goselected, true)
	gohelper.setActive(self._simageunselect, false)
	gohelper.setActive(self._goselfselect, false)
	gohelper.setActive(self._txttips, false)
	gohelper.setActive(self._simageunselect, false)
	self:refreshCost()
	self:refreshFreeSummonButton(pool)
end

function SummonOneCustomPickView:refreshFreeSummonButton(poolCo)
	self._compFreeButton = self._compFreeButton or SummonFreeSingleGacha.New(self._btnsummon1.gameObject, poolCo.id)

	self._compFreeButton:refreshUI()
end

function SummonOneCustomPickView:refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")
		self:refreshCost10(curPool.cost10)
	end
end

function SummonOneCustomPickView:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.instance.getCostByConfig(costs)
	local cost_icon = SummonMainModel.instance.getSummonItemIcon(cost_type, cost_id)

	icon:LoadImage(cost_icon)

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function SummonOneCustomPickView:refreshCost10(costs)
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

			self._txtcurrency101.text = string.format("<color=%s>%s</color>", "#FFE095", luaLang("multiple") .. realyCountTime10)
			self._txtcurrency102.text = cost_num

			local preferential = (cost_num - realyCountTime10) / cost_num * 100

			self._txtcount.text = string.format(luaLang("summonpickchoice_discount"), preferential)

			return
		end
	else
		gohelper.setActive(self._gocount, false)
	end

	self._txtcurrency101.text = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. cost_num)
	self._txtcurrency102.text = ""
end

function SummonOneCustomPickView:getPickHeroIds(pool)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(pool.id)

	if summonServerMO and summonServerMO.customPickMO then
		return summonServerMO.customPickMO.pickHeroIds
	end

	return nil
end

function SummonOneCustomPickView:refreshPickHero(poolId)
	local pickHeroIds = self:getPickHeroIds(poolId)

	if pickHeroIds and #pickHeroIds > 0 and self._characteritem then
		local pickHeroId = pickHeroIds[1]

		gohelper.setActive(self._characteritem.go, true)
		gohelper.setActive(self._characteritem.simagehero, true)

		local heroConfig = HeroConfig.instance:getHeroCO(pickHeroId)

		UISpriteSetMgr.instance:setCommonSprite(self._characteritem.imagecareer, "lssx_" .. tostring(heroConfig.career))

		self._characteritem.txtnamecn.text = heroConfig.name

		for j = 1, 6 do
			gohelper.setActive(self._characteritem.rares[j], j <= CharacterEnum.Star[heroConfig.rare])
		end

		local offsetX, offsetY, scale = self:getOffset(heroConfig.skinId)

		self._characteritem.simagehero:LoadImage(ResUrl.getHeadIconImg(heroConfig.skinId), self.handleLoadedImage, {
			imgTransform = self._simagerole1.gameObject.transform,
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
	else
		gohelper.setActive(self._characteritem.go, false)
		gohelper.setActive(self._characteritem.simagehero, false)
	end
end

function SummonOneCustomPickView:getOffset(skinId)
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

function SummonOneCustomPickView.handleLoadedImage(param)
	local imgTr = param.imgTransform
	local offsetX = param.offsetX
	local offsetY = param.offsetY
	local scale = param.scale

	ZProj.UGUIHelper.SetImageSize(imgTr.gameObject)
	recthelper.setAnchor(imgTr, offsetX, offsetY)
	transformhelper.setLocalScale(imgTr, scale, scale, scale)
end

function SummonOneCustomPickView:refreshView()
	self.summonSuccess = false

	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		gohelper.setActive(self._goui, false)

		return
	end

	self:refreshPoolUI()
end

function SummonOneCustomPickView:refreshPoolUI()
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	if SummonCustomPickModel.instance:isCustomPickOver(pool.id) then
		self:handlePickOverStatus(pool)
	else
		self:handleNeedPickStatus(pool)
	end

	self:refreshPickHero(pool)
	self:_refreshOpenTime()

	local realyCountTime10 = SummonMainModel.instance:getDiscountCost10(pool.id, 1)

	self._txttips2.text = string.format(luaLang("summon_discount_tips"), realyCountTime10)
end

function SummonOneCustomPickView:_refreshOpenTime()
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

function SummonOneCustomPickView:playEnterAnim()
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		self._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function SummonOneCustomPickView:playerEnterAnimFromScene()
	self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function SummonOneCustomPickView:addAllEvents()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function SummonOneCustomPickView:removeAllEvents()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function SummonOneCustomPickView:_summon10Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, true)
end

function SummonOneCustomPickView:_summon1Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 1, false, true)
end

function SummonOneCustomPickView:onItemChanged()
	if SummonController.instance.isWaitingSummonResult or self.summonSuccess then
		return
	end

	self:refreshCost()
end

function SummonOneCustomPickView:onSummonFailed()
	self.summonSuccess = false

	self:refreshCost()
end

function SummonOneCustomPickView:onSummonReply()
	self.summonSuccess = true
end

return SummonOneCustomPickView
