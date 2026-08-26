-- chunkname: @modules/logic/summon/view/SummonMainCharacterProbUp.lua

module("modules.logic.summon.view.SummonMainCharacterProbUp", package.seeall)

local SummonMainCharacterProbUp = class("SummonMainCharacterProbUp", BaseView)

function SummonMainCharacterProbUp:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg")
	self._gocharacteritem1 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem1")
	self._simagesignature1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/right/#go_characteritem1/#simage_signature1")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	self._gopageitem = gohelper.findChild(self.viewGO, "#go_ui/pageicon/#go_pageitem")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_ui/#go_righttop")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/#txt_deadline")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	self._txtpreferential = gohelper.findChildText(self.viewGO, "#go_ui/current/first/#txt_times")
	self._gopreferential = gohelper.findChild(self.viewGO, "#go_ui/current/first")
	self._gospine = gohelper.findChild(self.viewGO, "#go_ui/current/node1/#go_spine")
	self._gorole = gohelper.findChild(self.viewGO, "#go_ui/current/node1/#simage_role")

	for i = 1, 3 do
		self["_simagead" .. i] = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad" .. i)
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainCharacterProbUp:addEvents()
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
end

function SummonMainCharacterProbUp:removeEvents()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
end

SummonMainCharacterProbUp.DETAIL_COUNT = 1
SummonMainCharacterProbUp.SIMAGE_COUNT = 3
SummonMainCharacterProbUp.preloadList = {
	ResUrl.getSummonHeroIcon("full/bg111")
}

for i = 1, SummonMainCharacterProbUp.SIMAGE_COUNT do
	table.insert(SummonMainCharacterProbUp.preloadList, ResUrl.getSummonHeroIcon("role" .. i))
end

function SummonMainCharacterProbUp:initCharacterItemCount()
	local poolId = SummonMainModel.instance:getCurId()
	local poolConfig = SummonConfig.instance:getSummonPool(poolId)

	self._characterItemCount = SummonCharacterProbUpPreloadConfig.getCharacterItemCountByName((poolConfig or nil) and poolConfig.customClz)
end

function SummonMainCharacterProbUp:initSpine()
	local poolId = SummonMainModel.instance:getCurId()
	local poolConfig = SummonConfig.instance:getSummonPool(poolId)

	if poolConfig and self._gospine then
		self._spineComp = self._spineComp or SummonSpineComp.Create(self._gospine)

		self._spineComp:setConfig(poolConfig, self._gorole)
	end
end

function SummonMainCharacterProbUp:_editableInitView()
	self._characteritems = {}
	self._pageitems = {}
	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:refreshSingleImage()
	self:initCharacterItemCount()
	self:initSpine()

	for i = 1, self._characterItemCount do
		local characteritem = self:getUserDataTb_()

		characteritem.go = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem" .. i)
		characteritem.imagecareer = gohelper.findChildImage(characteritem.go, "image_career")
		characteritem.txtnamecn = gohelper.findChildText(characteritem.go, "txt_namecn")
		characteritem.btndetail = gohelper.findChildButtonWithAudio(characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
		characteritem.rares = {}

		for j = 1, 6 do
			local rareGO = gohelper.findChild(characteritem.go, "rare/go_rare" .. j)

			table.insert(characteritem.rares, rareGO)
		end

		table.insert(self._characteritems, characteritem)
		characteritem.btndetail:AddClickListener(SummonMainCharacterProbUp._onClickDetailByIndex, self, i)
	end

	self._goShop = gohelper.findChild(self.viewGO, "#go_ui/#go_shop")
	self._txtticket = gohelper.findChildText(self.viewGO, "#go_ui/#go_shop/#txt_num")
	self._btnshop = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#go_shop/#btn_shop")

	if self._btnshop then
		self._btnshop:AddClickListener(self._btnshopOnClick, self)
	end
end

function SummonMainCharacterProbUp:onDestroyView()
	if self._compFreeButton then
		self._compFreeButton:dispose()

		self._compFreeButton = nil
	end

	for i = 1, #self._characteritems do
		local characteritem = self._characteritems[i]

		characteritem.btndetail:RemoveClickListener()
	end

	self:unloadSingleImage()

	if self._btnshop then
		self._btnshop:RemoveClickListener()
	end

	if self._spineComp then
		self._spineComp:onDestroy()
	end
end

function SummonMainCharacterProbUp:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonMainCharacterProbUp:unloadSingleImage()
	self._simageline:UnLoadImage()
end

function SummonMainCharacterProbUp:onUpdateParam()
	return
end

function SummonMainCharacterProbUp:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshView, self)
	self:playEnterAnim()
	self:_refreshView()
end

function SummonMainCharacterProbUp:playEnterAnim()
	if self._animRoot then
		if SummonMainModel.instance:getFirstTimeSwitch() then
			SummonMainModel.instance:setFirstTimeSwitch(false)
			self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
		else
			self._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
		end
	end
end

function SummonMainCharacterProbUp:playerEnterAnimFromScene()
	self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function SummonMainCharacterProbUp:onClose()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshView, self)
end

function SummonMainCharacterProbUp:_btnsummon1OnClick()
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local heroId = SummonModel.instance:getSummonFullExSkillHero(curPool.id)

	if heroId == nil then
		self:_btnsummon1OnClick_2()
	else
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)
		local heroName = heroConfig.name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, curPool.id, self._btnsummon1OnClick_2, nil, nil, self, nil, nil, heroName)
	end
end

function SummonMainCharacterProbUp:_btnsummon1OnClick_2()
	SummonMainController.instance:summon1Action()
end

function SummonMainCharacterProbUp:_summon1Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 1, false, true)
end

function SummonMainCharacterProbUp:_btnsummon10OnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local heroId = SummonModel.instance:getSummonFullExSkillHero(curPool.id)

	if heroId == nil then
		self:_btnsummon10OnClick_2()
	else
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)
		local heroName = heroConfig.name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, curPool.id, self._btnsummon10OnClick_2, nil, nil, self, nil, nil, heroName)
	end
end

function SummonMainCharacterProbUp:_btnsummon10OnClick_2()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local param = {}

	param.callback = self._summon10Confirm
	param.callbackObj = self

	SummonMainController.instance:summon10Action(param)
end

function SummonMainCharacterProbUp:_summon10Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, true)
end

function SummonMainCharacterProbUp:_onClickDetailByIndex(index)
	if not self._characteritems then
		return
	end

	local characteritem = self._characteritems[index]

	if characteritem then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			id = characteritem.characterDetailId
		})
	end
end

function SummonMainCharacterProbUp:_refreshView()
	self.summonSuccess = false

	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		gohelper.setActive(self._goui, false)

		return
	end

	self:_refreshPoolUI()
	self:_refreshTicket()
end

function SummonMainCharacterProbUp:_refreshPoolUI()
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	self:_refreshCost()
	self:showCharacter(pool)
	self:refreshFreeSummonButton(pool)
	self:_refreshOpenTime()
	self:_refreshPreferentialInfo()
end

function SummonMainCharacterProbUp:refreshFreeSummonButton(poolCo)
	self._compFreeButton = self._compFreeButton or SummonFreeSingleGacha.New(self._btnsummon1.gameObject, poolCo.id)

	self._compFreeButton:refreshUI()
end

function SummonMainCharacterProbUp:_refreshOpenTime()
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

function SummonMainCharacterProbUp:_refreshPreferentialInfo()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local poolMO = SummonMainModel.instance:getPoolServerMO(curPool.id)
	local preferentialLimitCount = poolMO.canGetGuaranteeSRCount

	if self._gopreferential then
		gohelper.setActive(self._gopreferential, preferentialLimitCount > 0)

		if self._txtpreferential and preferentialLimitCount > 0 then
			self._txtpreferential.text = poolMO.guaranteeSRCountDown
		end
	end
end

function SummonMainCharacterProbUp:_adLoaded()
	for i = 1, SummonMainCharacterProbUp.SIMAGE_COUNT do
		local imagead = self["_simagead" .. i]:GetComponent(typeof(UnityEngine.UI.Image))

		imagead:SetNativeSize()
	end
end

function SummonMainCharacterProbUp:showCharacter(poolCo)
	local characterDetails

	if not string.nilorempty(poolCo.characterDetail) then
		characterDetails = string.split(poolCo.characterDetail, "#")
	end

	local indexDict = {}

	if characterDetails ~= nil then
		for i = 1, #characterDetails do
			local characterDetailId = tonumber(characterDetails[i])
			local characterDetailConfig = SummonConfig.instance:getCharacterDetailConfig(characterDetailId)
			local index = characterDetailConfig.location
			local characteritem = self._characteritems[index]

			if characteritem then
				local heroId = characterDetailConfig.heroId
				local heroConfig = HeroConfig.instance:getHeroCO(heroId)

				UISpriteSetMgr.instance:setCommonSprite(characteritem.imagecareer, "lssx_" .. tostring(heroConfig.career))

				characteritem.txtnamecn.text = heroConfig.name

				for j = 1, 6 do
					gohelper.setActive(characteritem.rares[j], j <= CharacterEnum.Star[heroConfig.rare])
				end

				characteritem.characterDetailId = characterDetailId

				gohelper.setActive(characteritem.go, true)

				indexDict[index] = true
			end
		end
	end

	for i = 1, #self._characteritems do
		gohelper.setActive(self._characteritems[i].go, indexDict[i])
	end
end

function SummonMainCharacterProbUp:_refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")
		self:_refreshSingleCost(curPool.cost10, self._simagecurrency10, "_txtcurrency10")
	end
end

function SummonMainCharacterProbUp:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(costs, true)
	local cost_icon = SummonMainModel.getSummonItemIcon(cost_type, cost_id)

	icon:LoadImage(cost_icon)

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function SummonMainCharacterProbUp:onSummonFailed()
	self.summonSuccess = false

	self:_refreshCost()
end

function SummonMainCharacterProbUp:onSummonReply()
	self.summonSuccess = true

	self:_refreshPreferentialInfo()
end

function SummonMainCharacterProbUp:onItemChanged()
	if SummonController.instance.isWaitingSummonResult or self.summonSuccess then
		return
	end

	self:_refreshCost()
	self:_refreshTicket()
end

function SummonMainCharacterProbUp:_refreshTicket()
	if self._txtticket == nil then
		return
	end

	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	if curPool.ticketId ~= 0 then
		self._txtticket.text = tostring((ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, curPool.ticketId)))
	end

	gohelper.setActive(self._goShop, curPool.ticketId ~= 0)
end

function SummonMainCharacterProbUp:_btnshopOnClick()
	local jumpTab = StoreEnum.StoreId.LimitStore

	StoreController.instance:checkAndOpenStoreView(jumpTab)
end

return SummonMainCharacterProbUp
