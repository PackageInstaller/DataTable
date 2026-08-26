-- chunkname: @modules/logic/summon/view/luckybag/SummonLuckyBagDescProbUpView.lua

module("modules.logic.summon.view.luckybag.SummonLuckyBagDescProbUpView", package.seeall)

local SummonLuckyBagDescProbUpView = class("SummonLuckyBagDescProbUpView", BaseView)

function SummonLuckyBagDescProbUpView:onInitView()
	self._goheroitem = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content/#go_heroItem")
	self._godesctitle = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content/#go_heroItem/#go_desctitle")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonLuckyBagDescProbUpView:addEvents()
	return
end

function SummonLuckyBagDescProbUpView:removeEvents()
	return
end

local MAX_RARE_LV = 5
local SSR_RARE_LV = 5

function SummonLuckyBagDescProbUpView:_editableInitView()
	self._scrollroot = gohelper.findChildScrollRect(self.viewGO, "infoScroll")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content")
	self._rectscrollcontent = self._goscrollcontent.transform
	self._probUpItemMap = {}
end

function SummonLuckyBagDescProbUpView:onDestroyView()
	TaskDispatcher.cancelTask(self.delayJumpToLuckyBag, self)

	if self._probUpItemMap then
		for _, probUpItem in pairs(self._probUpItemMap) do
			for __, heroIcon in pairs(probUpItem.heroIcons) do
				heroIcon.simageHero:UnLoadImage()
				heroIcon.btn:RemoveClickListener()
			end

			for __, equipIcon in pairs(probUpItem.equipIcons) do
				equipIcon.simageEquip:UnLoadImage()
				equipIcon.btn:RemoveClickListener()
			end
		end

		self._probUpItemMap = nil
	end
end

function SummonLuckyBagDescProbUpView:onUpdateParam()
	self:onOpen()
end

function SummonLuckyBagDescProbUpView:onOpen()
	self._poolParam = SummonController.instance:getPoolInfo()
	self._poolDetailId = self._poolParam.poolDetailId
	self._poolId = self._poolParam.poolId

	local poolCo = SummonConfig.instance:getSummonPool(self._poolId)

	self._resultType = SummonMainModel.getResultType(poolCo)
	self._poolType = poolCo.type

	self:refreshUI()
	self:checkJumpToTarget()
end

function SummonLuckyBagDescProbUpView:checkJumpToTarget()
	local targetLuckyBagId = SummonPoolDetailCategoryListModel.instance:getJumpLuckyBag()

	if targetLuckyBagId ~= nil then
		TaskDispatcher.runDelay(self.delayJumpToLuckyBag, self, 0.01)
	end
end

function SummonLuckyBagDescProbUpView:delayJumpToLuckyBag()
	if not self._probUpItemMap then
		return
	end

	local targetLuckyBagId = SummonPoolDetailCategoryListModel.instance:getJumpLuckyBag()
	local itemUI = self._probUpItemMap[targetLuckyBagId]

	if itemUI then
		local rectTarget = itemUI.go.transform
		local totalHeight = recthelper.getHeight(self._rectscrollcontent)
		local x, y = recthelper.getAnchor(rectTarget)
		local height = recthelper.getHeight(rectTarget)

		y = y + height * 0.5

		recthelper.setAnchorY(self._rectscrollcontent, y)

		local targetPosY = self._scrollroot.verticalNormalizedPosition - 1

		self._scrollroot.verticalNormalizedPosition = 1 - targetPosY
		SummonLuckyBagDescProbUpView._test = self._scrollroot
	end
end

function SummonLuckyBagDescProbUpView:refreshUI()
	self._resultIds, self._resultArrs = SummonPoolDetailCategoryListModel.buildLuckyBagDict(self._poolId)

	self:refreshPropUpAD()
end

function SummonLuckyBagDescProbUpView:refreshPropUpAD()
	local poolCo = SummonConfig.instance:getSummonPool(self._poolId)
	local hasItem = next(self._resultIds) ~= nil

	if hasItem then
		for i, luckBagId in ipairs(self._resultIds) do
			self:addProbUpItemByLuckyBagId(i, luckBagId)
		end
	end

	gohelper.setActive(self._goheroitem, hasItem)
end

function SummonLuckyBagDescProbUpView:addProbUpItemByLuckyBagId(index, luckBagId)
	local idList = self._resultArrs[index]

	if not idList or not next(idList) then
		return
	end

	for _, id in ipairs(idList) do
		local item = self:getProbUpItem(luckBagId)

		gohelper.setActive(item.go, true)
		self:applyRareStar(item, -1)
		self:refreshProbIcons(item, idList)

		local luckyBagCfg = SummonConfig.instance:getLuckyBag(self._poolId, luckBagId)

		item.txtProbabilityLabel.text = string.format(luaLang("summonpooldetail_luckybag_prop"), luckyBagCfg.name)
		item.txtProbability.text = luaLang("summonpooldetail_luckybag_prop2")
	end
end

function SummonLuckyBagDescProbUpView:getProbUpItem(luckyBagId)
	local item = self._probUpItemMap[luckyBagId]

	if not item then
		item = self:getUserDataTb_()
		item.heroIcons = {}
		item.equipIcons = {}

		local itemGo = gohelper.clone(self._godesctitle, self._goheroitem, "prob_up_item_" .. tostring(luckyBagId))

		item.go = itemGo
		item.starList = self:getUserDataTb_()
		item.iconContainerGo = gohelper.findChild(itemGo, "heroshowlist")
		item.iconEquipContainerGo = gohelper.findChild(itemGo, "equipshowlist")
		item.iconTemplateGo = gohelper.findChild(itemGo, "heroshowlist/summonpooldetailheroitem")
		item.iconEquipTemplateGo = gohelper.findChild(itemGo, "equipshowlist/summonpooldetailequipitem")
		item.starContainerGo = gohelper.findChild(itemGo, "#go_starList")

		for i = 1, MAX_RARE_LV + 1 do
			item.starList[i] = gohelper.findChild(item.starContainerGo, "star" .. tostring(i))
		end

		item.txtProbability = gohelper.findChildText(item.starContainerGo, "probability/#txt_probability")
		item.txtProbabilityLabel = gohelper.findChildText(item.starContainerGo, "probability")
		self._probUpItemMap[luckyBagId] = item
	end

	return item
end

function SummonLuckyBagDescProbUpView:applyRareStar(item, rare)
	for i = 1, MAX_RARE_LV + 1 do
		gohelper.setActive(item.starList[i], i <= rare + 1)
	end
end

function SummonLuckyBagDescProbUpView:refreshProbIcons(probUpItem, idList)
	if self._resultType == SummonEnum.ResultType.Char then
		self:refreshHeroProbIcons(probUpItem, idList)
	elseif self._resultType == SummonEnum.ResultType.Equip then
		self:refreshEquipProbIcons(probUpItem, idList)
	end

	gohelper.setActive(probUpItem.iconContainerGo, self._resultType == SummonEnum.ResultType.Char)
	gohelper.setActive(probUpItem.iconEquipContainerGo, self._resultType == SummonEnum.ResultType.Equip)
end

function SummonLuckyBagDescProbUpView:refreshHeroProbIcons(probUpItem, idList)
	for index, id in ipairs(idList) do
		local item = self:getProbUpHeroIconItem(probUpItem, index)

		gohelper.setActive(item.go, true)
		self:refreshProbUpHeroIconItem(id, item)
	end
end

function SummonLuckyBagDescProbUpView:refreshEquipProbIcons(probUpItem, idList)
	for index, id in ipairs(idList) do
		local item = self:getProbUpEquipIconItem(probUpItem, index)

		gohelper.setActive(item.go, true)
		self:refreshProbUpEquipIconItem(id, item)
	end
end

function SummonLuckyBagDescProbUpView:getProbUpHeroIconItem(probUpItem, index)
	local item = probUpItem.heroIcons[index]

	if not item then
		item = self:getUserDataTb_()

		local itemGo = gohelper.clone(probUpItem.iconTemplateGo, probUpItem.iconContainerGo, "prob_up_item")

		item.go = itemGo
		item.imageRare = gohelper.findChildImage(itemGo, "image_rare")
		item.imageCareer = gohelper.findChildImage(itemGo, "image_career")
		item.simageHero = gohelper.findChildSingleImage(itemGo, "simage_hero")
		item.imageNameEn = gohelper.findChildImage(itemGo, "image_nameen")
		item.txtNameCn = gohelper.findChildText(itemGo, "txt_namecn")
		item.data = {}
		item.btn = gohelper.findChildButtonWithAudio(itemGo, "simage_hero")

		item.btn:AddClickListener(self.onClickHeroItem, self, item.data)

		probUpItem.heroIcons[index] = item
	end

	return item
end

function SummonLuckyBagDescProbUpView:refreshProbUpHeroIconItem(heroId, item)
	local heroCo = HeroConfig.instance:getHeroCO(heroId)

	UISpriteSetMgr.instance:setSummonSprite(item.imageRare, heroCo.rare < SSR_RARE_LV and "bg_choukahuang" or "bg_choukaju")
	UISpriteSetMgr.instance:setCommonSprite(item.imageCareer, "lssx_" .. tostring(heroCo.career))
	item.simageHero:LoadImage(ResUrl.getHandbookheroIcon(heroCo.skinId))

	item.data.clickId = heroId
	item.txtNameCn.text = heroCo.name
end

function SummonLuckyBagDescProbUpView:getProbUpEquipIconItem(probUpItem, index)
	local item = probUpItem.equipIcons[index]

	if not item then
		item = self:getUserDataTb_()

		local itemGo = gohelper.clone(probUpItem.iconEquipTemplateGo, probUpItem.iconEquipContainerGo, "prob_up_equip_item")

		item.go = itemGo
		item.imageCareer = gohelper.findChildImage(itemGo, "txt_namecn/image_career")
		item.simageEquip = gohelper.findChildSingleImage(itemGo, "simage_equip")
		item.imageNameEn = gohelper.findChildImage(itemGo, "image_nameen")
		item.txtNameCn = gohelper.findChildText(itemGo, "txt_namecn")
		item.data = {}
		item.btn = gohelper.findChildButtonWithAudio(itemGo, "simage_equip")

		item.btn:AddClickListener(self.onClickEquipItem, self, item.data)

		probUpItem.equipIcons[index] = item
	end

	return item
end

function SummonLuckyBagDescProbUpView:refreshProbUpEquipIconItem(equipId, item)
	local equipCo = EquipConfig.instance:getEquipCo(equipId)

	item.simageEquip:LoadImage(ResUrl.getEquipSuit(equipCo.icon))
	transformhelper.setLocalScale(item.simageEquip.transform, 0.39, 0.39, 1)

	local maxEquipMO = EquipHelper.createMaxLevelEquipMo(equipId)
	local equipCarrer = EquipHelper.getEquipSkillCareer(equipId, maxEquipMO.refineLv)

	if not string.nilorempty(equipCarrer) then
		gohelper.setActive(item.imageCareer.gameObject, true)

		local carrerIconName = "jinglian_" .. equipCarrer

		UISpriteSetMgr.instance:setCommonSprite(item.imageCareer, carrerIconName)
	else
		gohelper.setActive(item.imageCareer.gameObject, false)
	end

	item.data.clickId = equipId
	item.txtNameCn.text = equipCo.name
end

function SummonLuckyBagDescProbUpView:onClickHeroItem(item)
	if item.clickId ~= nil then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = item.clickId
		})
	end
end

function SummonLuckyBagDescProbUpView:onClickEquipItem(item)
	if item.clickId ~= nil then
		local param = {}

		param.equipId = item.clickId

		EquipController.instance:openEquipView(param)
	end
end

return SummonLuckyBagDescProbUpView
