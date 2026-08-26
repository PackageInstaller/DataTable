-- chunkname: @modules/logic/summon/view/SummonMainCharacterView.lua

module("modules.logic.summon.view.SummonMainCharacterView", package.seeall)

local SummonMainCharacterView = class("SummonMainCharacterView", BaseView)

function SummonMainCharacterView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_icon")
	self._gocharacteritem1 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem1")
	self._gocharacteritem2 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem2")
	self._simagesignature1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/right/#go_characteritem1/#simage_signature1")
	self._simagesignature2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/right/#go_characteritem2/#simage_signature2")
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

	for i = 1, 4 do
		self["_simagead" .. i] = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad" .. i)
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainCharacterView:addEvents()
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
end

function SummonMainCharacterView:removeEvents()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
end

SummonMainCharacterView.SIMAGE_COUNT = 4
SummonMainCharacterView.preloadList = {
	ResUrl.getSignature("3003"),
	ResUrl.getSignature("3025"),
	ResUrl.getSummonHeroIcon("full/bg"),
	ResUrl.getSummonHeroIcon("wz")
}

for i = 1, SummonMainCharacterView.SIMAGE_COUNT do
	table.insert(SummonMainCharacterView.preloadList, ResUrl.getSummonHeroIcon("hero" .. i))
end

function SummonMainCharacterView:onUpdateParam()
	return
end

function SummonMainCharacterView:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshView, self)
	self:playEnterAnim()
	self:_refreshView()
end

function SummonMainCharacterView:playEnterAnim()
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		self._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function SummonMainCharacterView:playerEnterAnimFromScene()
	self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function SummonMainCharacterView:onClose()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshView, self)
end

function SummonMainCharacterView:_btnsummon1OnClick()
	if SummonController.instance:isInSummonGuide() then
		return
	end

	SummonMainController.instance:summon1Action()
end

function SummonMainCharacterView:_summon1Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 1, false, false)
end

function SummonMainCharacterView:_btnsummon10OnClick()
	SummonMainController.instance:summon10Action()
end

function SummonMainCharacterView:_summon10Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, false)
end

function SummonMainCharacterView:_editableInitView()
	self._characteritems = {}
	self._pageitems = {}
	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simagebg:LoadImage(ResUrl.getSummonHeroIcon("full/bg"))
	self._simageicon:LoadImage(ResUrl.getSummonHeroIcon("wz"))

	for i = 1, 2 do
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
		characteritem.btndetail:AddClickListener(SummonMainCharacterView._onClickDetailByIndex, self, i)
	end
end

function SummonMainCharacterView:_onClickDetailByIndex(index)
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

function SummonMainCharacterView:_refreshView()
	self.summonSuccess = false

	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		gohelper.setActive(self._goui, false)

		return
	end

	self:_refreshPoolUI()
end

function SummonMainCharacterView:_refreshPoolUI()
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	local tabIndex = SummonMainModel.instance:getADPageTabIndexForUI(pool)
	local clz = SummonMainModel.instance:getUIClassDef(tabIndex)

	if clz ~= SummonMainCharacterView then
		return
	end

	self:_refreshCost()
	self:showSummonPool(pool)
	self:refreshFreeSummonButton(pool)
end

function SummonMainCharacterView:refreshFreeSummonButton(poolCo)
	self._compFreeButton = self._compFreeButton or SummonFreeSingleGacha.New(self._btnsummon1.gameObject, poolCo.id)

	self._compFreeButton:refreshUI()
end

function SummonMainCharacterView:showSummonPool(poolCo)
	for i = 1, SummonMainCharacterView.SIMAGE_COUNT do
		self["_simagead" .. i]:LoadImage(ResUrl.getSummonHeroIcon("hero" .. i), self._adLoaded, self)
	end

	self._simagesignature1:LoadImage(ResUrl.getSignature("3003"))
	self._simagesignature2:LoadImage(ResUrl.getSignature("3025"))
	self:showCharacter(poolCo)
end

function SummonMainCharacterView:_adLoaded()
	for i = 1, SummonMainCharacterView.SIMAGE_COUNT do
		local imagead = self["_simagead" .. i]:GetComponent(typeof(UnityEngine.UI.Image))

		imagead:SetNativeSize()
	end
end

function SummonMainCharacterView:showCharacter(poolCo)
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

				if heroConfig ~= nil then
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
	end

	for i = 1, #self._characteritems do
		gohelper.setActive(self._characteritems[i].go, indexDict[i])
	end
end

function SummonMainCharacterView:_refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")
		self:_refreshSingleCost(curPool.cost10, self._simagecurrency10, "_txtcurrency10")
	end
end

function SummonMainCharacterView:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(costs, true)
	local cost_icon = SummonMainModel.getSummonItemIcon(cost_type, cost_id)

	icon:LoadImage(cost_icon)

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function SummonMainCharacterView:onSummonFailed()
	self.summonSuccess = false

	self:_refreshCost()
end

function SummonMainCharacterView:onSummonReply()
	self.summonSuccess = true
end

function SummonMainCharacterView:onItemChanged()
	if SummonController.instance.isWaitingSummonResult or self.summonSuccess then
		return
	end

	self:_refreshCost()
end

function SummonMainCharacterView:onDestroyView()
	for i = 1, #self._characteritems do
		local characteritem = self._characteritems[i]

		characteritem.btndetail:RemoveClickListener()
	end

	for i = 1, SummonMainCharacterView.SIMAGE_COUNT do
		self["_simagead" .. i]:UnLoadImage()
	end

	self._simagebg:UnLoadImage()
	self._simageicon:UnLoadImage()
	self._simagesignature1:UnLoadImage()
	self._simagesignature2:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()

	if self._compFreeButton then
		self._compFreeButton:dispose()

		self._compFreeButton = nil
	end
end

return SummonMainCharacterView
