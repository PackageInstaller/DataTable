-- chunkname: @modules/logic/summon/view/custompick/HundredSummonCustomView.lua

module("modules.logic.summon.view.custompick.HundredSummonCustomView", package.seeall)

local HundredSummonCustomView = class("HundredSummonCustomView", BaseView)

function HundredSummonCustomView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._gounselected = gohelper.findChild(self.viewGO, "#go_ui/current/#go_unselected")
	self._simagebgunselect = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_unselected/#simage_bgunselect")
	self._simagebgunselect2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_unselected/#simage_bgunselect2")
	self._simagebgunselect3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_unselected/#simage_bgunselect3")
	self._simageunselect = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_unselected/#simage_unselect")
	self._simagebgunselect4 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_unselected/#simage_bgunselect4")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	self._goselected = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected")
	self._gorole = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role")
	self._simagerole2outline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role/#simage_role2_outline")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#go_role/#simage_role2")
	self._gocharacteritem2 = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role/#go_characteritem2")
	self._simageline31 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#simage_line3_1")
	self._simageline32 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#simage_line3_2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#simage_mask")
	self._simageline2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#go_selected/#simage_line2")
	self._simagefrontbg1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg1")
	self._simagefrontbg2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg2")
	self._simagetitle1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/title/#simage_title1")
	self._simagetips = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/#simage_tips")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_ui/current/tip/#txt_tips")
	self._gotip2bg = gohelper.findChild(self.viewGO, "#go_ui/current/tip/#go_tip2bg")
	self._gotip2 = gohelper.findChild(self.viewGO, "#go_ui/current/tip2")
	self._txttips2 = gohelper.findChildText(self.viewGO, "#go_ui/current/tip2/txt_tips2")
	self._imageFill2 = gohelper.findChildImage(self.viewGO, "#go_ui/current/tip2/line2")
	self._gotips3 = gohelper.findChild(self.viewGO, "#go_ui/current/tip3")
	self._txttips3 = gohelper.findChildText(self.viewGO, "#go_ui/current/tip3/txt_tips3")
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
	self._govxtxtlight = gohelper.findChild(self.viewGO, "#go_ui/current/tip3/txt_bg/txt_bg_light")
	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HundredSummonCustomView:addEvents()
	self._btnselfselect:AddClickListener(self._btnselfselectOnClick, self)
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
end

function HundredSummonCustomView:removeEvents()
	self._btnselfselect:RemoveClickListener()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
end

function HundredSummonCustomView:_btnselfselectOnClick()
	self:openSelectView()
end

function HundredSummonCustomView:_btnsummon1OnClick()
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

function HundredSummonCustomView:_btnsummon1OnClick_2()
	SummonMainController.instance:summon1Action()
end

function HundredSummonCustomView:_btnsummon10OnClick()
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

function HundredSummonCustomView:_btnsummon10OnClick_2()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local param = {}

	param.callback = self._summon10Confirm
	param.callbackObj = self

	SummonMainController.instance:summon10Action(param)
end

function HundredSummonCustomView:_editableInitView()
	self._characteritem = self:getUserDataTb_()
	self._characteritem.go = self._gocharacteritem2
	self._characteritem.imagecareer = gohelper.findChildImage(self._characteritem.go, "image_career")
	self._characteritem.txtnamecn = gohelper.findChildText(self._characteritem.go, "txt_namecn")
	self._characteritem.btndetail = gohelper.findChildButtonWithAudio(self._characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
	self._characteritem.gorole = gohelper.findChild(self.viewGO, "#go_ui/current/#go_selected/#go_role1")
	self._characteritem.simagehero = self._simagerole2
	self._characteritem.rares = self:getUserDataTb_()

	for j = 1, 6 do
		local rareGO = gohelper.findChild(self._characteritem.go, "rare/go_rare" .. j)

		table.insert(self._characteritem.rares, rareGO)
	end

	self._characteritem.btndetail:AddClickListener(self._onClickDetail, self)
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function HundredSummonCustomView:_onClickDetail()
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

function HundredSummonCustomView:_summon10Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, true)
end

function HundredSummonCustomView:_summon1Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 1, false, true)
end

function HundredSummonCustomView:onUpdateParam()
	return
end

function HundredSummonCustomView:onOpen()
	self:addAllEvents()
	self:playEnterAnim()
	self:refreshView()
end

function HundredSummonCustomView:openSelectView()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = curPool.id
	})
end

function HundredSummonCustomView:refreshPickHero(pool)
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
					imgTransform = self._simagerole2.gameObject.transform,
					offsetX = offsetX,
					offsetY = offsetY,
					scale = scale
				})
				self._simagerole2outline:LoadImage(ResUrl.getHeadIconImg(heroConfig.skinId), self.handleLoadedImage, {
					imgTransform = self._simagerole2outline.gameObject.transform,
					offsetX = offsetX - 5,
					offsetY = offsetY + 2,
					scale = scale
				})
			end
		end
	end
end

function HundredSummonCustomView:getOffset(skinId)
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

function HundredSummonCustomView.handleLoadedImage(param)
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

function HundredSummonCustomView:getPickHeroIds(pool)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(pool.id)

	if summonServerMO and summonServerMO.customPickMO then
		return summonServerMO.customPickMO.pickHeroIds
	end

	return nil
end

function HundredSummonCustomView:_refreshOpenTime()
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

function HundredSummonCustomView:refreshView()
	self.summonSuccess = false

	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		gohelper.setActive(self._goui, false)

		return
	end

	self:refreshPoolUI()
end

function HundredSummonCustomView:refreshPoolUI()
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	local isPick = SummonCustomPickModel.instance:isCustomPickOver(pool.id)

	self:refreshPickHero(pool)
	gohelper.setActive(self._goselected, isPick)
	gohelper.setActive(self._gounselected, not isPick)
	gohelper.setActive(self._gosummonbtns, isPick)
	gohelper.setActive(self._goselfselect, not isPick)
	gohelper.setActive(self._gotips3, isPick)
	gohelper.setActive(self._gotip2, isPick)

	if isPick then
		self:refreshCost()
	end

	self:_refreshOpenTime()
	self:_refreshTips2()
end

function HundredSummonCustomView:_refreshTips2()
	local pool = SummonMainModel.instance:getCurPool()
	local times = SummonConfig.getSummonSSRTimes(pool)
	local notSSRcount = SummonMainModel.instance:getNotSSRCount(pool.id)
	local remainCount = times - notSSRcount

	self._txttips2.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("p_hundredsummoncustomview_progress"), remainCount)
	self._imageFill2.fillAmount = notSSRcount / times
end

function HundredSummonCustomView:refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")
		self:_refreshSingleCost(curPool.cost10, self._simagecurrency10, "_txtcurrency10")
		self:refreshCost10(curPool.cost10)
	end
end

function HundredSummonCustomView:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.instance.getCostByConfig(costs)
	local cost_icon = SummonMainModel.instance.getSummonItemIcon(cost_type, cost_id)

	icon:LoadImage(cost_icon)

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function HundredSummonCustomView:refreshCost10(costs)
	local curPoolId = SummonMainModel.instance:getCurId()
	local cost_type, cost_id, cost_num = SummonMainModel.instance:getCost10ById(curPoolId, true)
	local cost_icon = SummonMainModel.instance.getSummonItemIcon(cost_type, cost_id)

	self._simagecurrency10:LoadImage(cost_icon)

	local havefree10Count = SummonMainModel.instance:checkHaveFree10Count(curPoolId)
	local isOver = SummonMainModel.instance:checkFree10CountOver(curPoolId)

	gohelper.setActive(self._gocount, false)

	if isOver then
		gohelper.setActive(self._gotips3, false)
	else
		gohelper.setActive(self._gotips3, true)

		if havefree10Count then
			cost_num = 0
			self._txttips3.text = luaLang("p_v3a3_versionsummon100summonview_txt_tips4")
		else
			local curPool = SummonMainModel.instance:getCurPool()
			local poolMO = SummonMainModel.instance:getPoolServerMO(curPool.id)
			local remainTime = ServerTime.getToadyEndTimeStamp(true) - ServerTime.nowInLocal()
			local nextDayTime = ServerTime.now() + remainTime + 1

			if nextDayTime >= poolMO.offlineTime then
				TaskDispatcher.cancelTask(self._refresh10FreeCountTime, self)
				gohelper.setActive(self._gotips3, false)
			else
				TaskDispatcher.cancelTask(self._refresh10FreeCountTime, self)
				self:_refresh10FreeCountTime()
				TaskDispatcher.runRepeat(self._refresh10FreeCountTime, self, 1)
			end
		end
	end

	gohelper.setActive(self._govxtxtlight, havefree10Count)

	self._txtcurrency101.text = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. cost_num)
end

function HundredSummonCustomView:_refresh10FreeCountTime()
	local remainTime = ServerTime.getToadyEndTimeStamp(true) - ServerTime.nowInLocal()
	local time, timeFormat = TimeUtil.secondToRoughTime2(remainTime)

	self._txttips3.text = string.format(luaLang("summon_free_after_time"), tostring(time) .. tostring(timeFormat))
end

function HundredSummonCustomView:playEnterAnim()
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		self:playAnim(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		self:playAnim(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function HundredSummonCustomView:playerEnterAnimFromScene()
	self:playAnim(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function HundredSummonCustomView:playAnim(name, layer, normalizedTime)
	if self._animRoot ~= nil then
		self._animRoot:Play(name, layer, normalizedTime)
	end
end

function HundredSummonCustomView:onItemChanged()
	if SummonController.instance.isWaitingSummonResult or self.summonSuccess then
		return
	end

	self:refreshCost()
end

function HundredSummonCustomView:onSummonFailed()
	self.summonSuccess = false

	self:refreshCost()
end

function HundredSummonCustomView:onSummonReply()
	self.summonSuccess = true
end

function HundredSummonCustomView:addAllEvents()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function HundredSummonCustomView:removeAllEvents()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function HundredSummonCustomView:onClose()
	self:removeAllEvents()
end

function HundredSummonCustomView:onDestroyView()
	TaskDispatcher.cancelTask(self._refresh10FreeCountTime, self)

	if self._characteritem then
		self._characteritem.btndetail:RemoveClickListener()

		self._characteritem = nil
	end
end

return HundredSummonCustomView
