-- chunkname: @modules/logic/summon/view/SummonPoolDetailDescProbUpView.lua

module("modules.logic.summon.view.SummonPoolDetailDescProbUpView", package.seeall)

local SummonPoolDetailDescProbUpView = class("SummonPoolDetailDescProbUpView", BaseView)

function SummonPoolDetailDescProbUpView:onInitView()
	self._goheroitem = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content/#go_heroItem")
	self._godesctitle = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content/#go_heroItem/#go_desctitle")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonPoolDetailDescProbUpView:addEvents()
	return
end

function SummonPoolDetailDescProbUpView:removeEvents()
	return
end

local MAX_RARE_LV = 5
local SSR_RARE_LV = 5

function SummonPoolDetailDescProbUpView:_editableInitView()
	self._probUpItemMap = {}
end

function SummonPoolDetailDescProbUpView:onDestroyView()
	for _, probUpItem in pairs(self._probUpItemMap) do
		for __, heroIcon in pairs(probUpItem.heroIcons) do
			heroIcon.simageHero:UnLoadImage()
			heroIcon.btn:RemoveClickListener()
		end
	end

	for _, probUpItem in pairs(self._probUpItemMap) do
		for __, equipIcon in pairs(probUpItem.equipIcons) do
			equipIcon.simageEquip:UnLoadImage()
			equipIcon.btn:RemoveClickListener()
		end
	end
end

function SummonPoolDetailDescProbUpView:onUpdateParam()
	self:onOpen()
end

function SummonPoolDetailDescProbUpView:onOpen()
	self._poolParam = SummonController.instance:getPoolInfo()
	self._poolDetailId = self._poolParam.poolDetailId
	self._poolId = self._poolParam.poolId

	local poolCo = SummonConfig.instance:getSummonPool(self._poolId)

	self._resultType = SummonMainModel.getResultType(poolCo)
	self._poolType = poolCo.type

	self:refreshUI()
end

function SummonPoolDetailDescProbUpView:refreshUI()
	self._probUpRareIds, self._probUpIds, self._hasProbUpItem = SummonPoolDetailCategoryListModel.buildProbUpDict(self._poolId)

	self:refreshPropUpAD()
end

function SummonPoolDetailDescProbUpView:refreshPropUpAD()
	local poolCo = SummonConfig.instance:getSummonPool(self._poolId)
	local isProbUp = SummonMainModel.isProbUp(poolCo)

	if isProbUp then
		for i = MAX_RARE_LV, 1, -1 do
			self:addProbUpItemByRare(i)
		end
	end

	gohelper.setActive(self._goheroitem, isProbUp and self._hasProbUpItem)
end

function SummonPoolDetailDescProbUpView:addProbUpItemByRare(rare)
	local idList = self._probUpRareIds[rare]

	if not idList then
		return
	end

	for _, id in ipairs(idList) do
		local item = self:getProbUpItem(rare)

		gohelper.setActive(item.go, true)
		self:applyRareStar(item, rare)
		self:refreshProbIcons(item, idList)

		if rare == SSR_RARE_LV then
			if not ConstEnum.SummonSSRUpProb then
				if self._poolType == SummonEnum.Type.MultiProbUp4 and rare == SSR_RARE_LV then
					item.txtProbability.text = tostring(SummonEnum.MultiProbUp4ShowRate) .. "%"
					item.txtProbabilityLabel.text = string.format(luaLang("summon_multiup4_rule_title"), rare + 1)
				else
					item.txtProbability.text = CommonConfig.instance:getConstNum(ConstEnum.SummonSSRUpProb) / 10 .. "%"
					item.txtProbabilityLabel.text = string.format(luaLang("p_summonpooldetail_up_probability"), rare + 1)
				end
			end
		end
	end
end

function SummonPoolDetailDescProbUpView:getProbUpItem(rare)
	local item = self._probUpItemMap[rare]

	if not item then
		item = self:getUserDataTb_()
		item.heroIcons = {}
		item.equipIcons = {}

		local itemGo = gohelper.clone(self._godesctitle, self._goheroitem, "prob_up_item_" .. tostring(rare))

		item.go = itemGo
		item.starList = self:getUserDataTb_()
		item.iconContainerGo = gohelper.findChild(itemGo, "heroshowlist")
		item.iconEquipContainerGo = gohelper.findChild(itemGo, "equipshowlist")
		item.iconTemplateGo = gohelper.findChild(itemGo, "heroshowlist/summonpooldetailheroitem")
		item.iconEquipTemplateGo = gohelper.findChild(itemGo, "equipshowlist/summonpooldetailequipitem")

		local starContainerGo = gohelper.findChild(itemGo, "#go_starList")

		for i = 1, MAX_RARE_LV + 1 do
			item.starList[i] = gohelper.findChild(starContainerGo, "star" .. tostring(i))
		end

		item.txtProbability = gohelper.findChildText(starContainerGo, "probability/#txt_probability")
		item.txtProbabilityLabel = gohelper.findChildText(starContainerGo, "probability")
		self._probUpItemMap[rare] = item
	end

	return item
end

function SummonPoolDetailDescProbUpView:applyRareStar(item, rare)
	for i = 1, MAX_RARE_LV + 1 do
		gohelper.setActive(item.starList[i], i <= rare + 1)
	end
end

function SummonPoolDetailDescProbUpView:refreshProbIcons(probUpItem, idList)
	if self._resultType == SummonEnum.ResultType.Char then
		self:refreshHeroProbIcons(probUpItem, idList)
	elseif self._resultType == SummonEnum.ResultType.Equip then
		self:refreshEquipProbIcons(probUpItem, idList)
	end

	gohelper.setActive(probUpItem.iconContainerGo, self._resultType == SummonEnum.ResultType.Char)
	gohelper.setActive(probUpItem.iconEquipContainerGo, self._resultType == SummonEnum.ResultType.Equip)
end

function SummonPoolDetailDescProbUpView:refreshHeroProbIcons(probUpItem, idList)
	for index, id in ipairs(idList) do
		local item = self:getProbUpHeroIconItem(probUpItem, index)

		gohelper.setActive(item.go, true)
		self:refreshProbUpHeroIconItem(id, item)
	end
end

function SummonPoolDetailDescProbUpView:refreshEquipProbIcons(probUpItem, idList)
	for index, id in ipairs(idList) do
		local item = self:getProbUpEquipIconItem(probUpItem, index)

		gohelper.setActive(item.go, true)
		self:refreshProbUpEquipIconItem(id, item)
	end
end

function SummonPoolDetailDescProbUpView:getProbUpHeroIconItem(probUpItem, index)
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

function SummonPoolDetailDescProbUpView:refreshProbUpHeroIconItem(heroId, item)
	local heroCo = HeroConfig.instance:getHeroCO(heroId)

	UISpriteSetMgr.instance:setSummonSprite(item.imageRare, heroCo.rare < SSR_RARE_LV and "bg_choukahuang" or "bg_choukaju")
	UISpriteSetMgr.instance:setCommonSprite(item.imageCareer, "lssx_" .. tostring(heroCo.career))
	item.simageHero:LoadImage(ResUrl.getHandbookheroIcon(heroCo.skinId))

	item.data.clickId = heroId
	item.txtNameCn.text = heroCo.name
end

function SummonPoolDetailDescProbUpView:getProbUpEquipIconItem(probUpItem, index)
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

function SummonPoolDetailDescProbUpView:refreshProbUpEquipIconItem(equipId, item)
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

function SummonPoolDetailDescProbUpView:onClickHeroItem(item)
	if item.clickId ~= nil then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = item.clickId
		})
	end
end

function SummonPoolDetailDescProbUpView:onClickEquipItem(item)
	if item.clickId ~= nil then
		local param = {}

		param.equipId = item.clickId

		EquipController.instance:openEquipView(param)
	end
end

return SummonPoolDetailDescProbUpView
