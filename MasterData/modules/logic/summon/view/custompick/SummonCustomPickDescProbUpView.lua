-- chunkname: @modules/logic/summon/view/custompick/SummonCustomPickDescProbUpView.lua

module("modules.logic.summon.view.custompick.SummonCustomPickDescProbUpView", package.seeall)

local SummonCustomPickDescProbUpView = class("SummonCustomPickDescProbUpView", BaseView)

function SummonCustomPickDescProbUpView:onInitView()
	self._goheroitem = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content/#go_heroItem")
	self._godesctitle = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content/#go_heroItem/#go_desctitle")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonCustomPickDescProbUpView:addEvents()
	return
end

function SummonCustomPickDescProbUpView:removeEvents()
	return
end

local MAX_RARE_LV = 5
local SSR_RARE_LV = 5

function SummonCustomPickDescProbUpView:_editableInitView()
	self._scrollroot = gohelper.findChildScrollRect(self.viewGO, "infoScroll")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content")
	self._rectscrollcontent = self._goscrollcontent.transform
	self._probUpItemMap = {}
end

function SummonCustomPickDescProbUpView:onDestroyView()
	TaskDispatcher.cancelTask(self.delayJumpToLuckyBag, self)

	if self._probUpItemMap then
		for _, probUpItem in pairs(self._probUpItemMap) do
			for __, heroIcon in pairs(probUpItem.heroIcons) do
				heroIcon.simageHero:UnLoadImage()
				heroIcon.simageHero2:UnLoadImage()
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

function SummonCustomPickDescProbUpView:onUpdateParam()
	self:onOpen()
end

function SummonCustomPickDescProbUpView:onOpen()
	self._poolParam = SummonController.instance:getPoolInfo()
	self._poolDetailId = self._poolParam.poolDetailId
	self._poolId = self._poolParam.poolId

	local poolCo = SummonConfig.instance:getSummonPool(self._poolId)

	self._resultType = SummonMainModel.getResultType(poolCo)
	self._poolType = poolCo.type

	self:refreshUI()
end

function SummonCustomPickDescProbUpView:refreshUI()
	self._resultIds = SummonPoolDetailCategoryListModel.buildCustomPickDict(self._poolId)

	self:refreshPropUpAD()
end

function SummonCustomPickDescProbUpView:refreshPropUpAD()
	local poolCo = SummonConfig.instance:getSummonPool(self._poolId)
	local item = self:getProbUpItem(1)

	gohelper.setActive(item.go, true)
	self:applyRareStar(item, SummonEnum.CustomPickRare)
	self:refreshProbIcons(item, self._resultIds)

	local probability, totalProbability, onlyOne = SummonMainModel.instance:getCustomPickProbability(self._poolId)
	local rare = SummonEnum.CustomPickRare + 1
	local desc = luaLang(totalProbability ~= 0 and "summonpooldetail_up_probability_total" or "p_summonpooldetail_up_probability")

	gohelper.setActive(item.txtProbability, totalProbability == 0 and not onlyOne)

	if totalProbability ~= 0 then
		item.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLangThreeParam(desc, rare, probability, totalProbability / 10)
	elseif onlyOne then
		desc = luaLang("summonpooldetail_up_probability_StrongCustomOnePick")
		item.txtProbabilityLabel.text = GameUtil.getSubPlaceholderLuaLangTwoParam(desc, rare, probability)
	else
		item.txtProbabilityLabel.text = string.format(desc, rare)
		item.txtProbability.text = probability .. "%"
	end
end

function SummonCustomPickDescProbUpView:getProbUpItem(index)
	local item = self._probUpItemMap[index]

	if not item then
		item = self:getUserDataTb_()
		item.heroIcons = {}
		item.equipIcons = {}

		local itemGo = gohelper.clone(self._godesctitle, self._goheroitem, "prob_up_item_" .. tostring(index))

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
		self._probUpItemMap[index] = item
	end

	return item
end

function SummonCustomPickDescProbUpView:applyRareStar(item, rare)
	for i = 1, MAX_RARE_LV + 1 do
		gohelper.setActive(item.starList[i], i <= rare + 1)
	end
end

function SummonCustomPickDescProbUpView:refreshProbIcons(probUpItem, idList)
	if self._resultType == SummonEnum.ResultType.Char then
		self:refreshHeroProbIcons(probUpItem, idList)
	end

	gohelper.setActive(probUpItem.iconContainerGo, self._resultType == SummonEnum.ResultType.Char)
	gohelper.setActive(probUpItem.iconEquipContainerGo, self._resultType == SummonEnum.ResultType.Equip)
end

function SummonCustomPickDescProbUpView:refreshHeroProbIcons(probUpItem, idList)
	for index = 1, SummonCustomPickModel.instance:getMaxSelectCount(self._poolId) do
		local heroId = idList[index]
		local item = self:getProbUpHeroIconItem(probUpItem, index)

		gohelper.setActive(item.go, true)
		self:refreshProbUpHeroIconItem(heroId, item, index)
	end
end

function SummonCustomPickDescProbUpView:getProbUpHeroIconItem(probUpItem, index)
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
		item.simageHero2 = gohelper.findChildSingleImage(itemGo, "simage_hero2")
		item.data = {}
		item.btn = gohelper.findChildButtonWithAudio(itemGo, "simage_hero")

		item.btn:AddClickListener(self.onClickHeroItem, self, item.data)

		probUpItem.heroIcons[index] = item
	end

	return item
end

SummonCustomPickDescProbUpView.EmptyHeroIconList = {
	"300301_1",
	"302501_1"
}
SummonCustomPickDescProbUpView.PickOneEmptyHeroIcon = "306601_1"

function SummonCustomPickDescProbUpView:refreshProbUpHeroIconItem(heroId, item, index)
	if heroId then
		gohelper.setActive(item.imageRare, true)
		gohelper.setActive(item.imageCareer, true)
		gohelper.setActive(item.txtNameCn, true)
		gohelper.setActive(item.imageNameEn, true)
		gohelper.setActive(item.simageHero2, false)

		local heroCo = HeroConfig.instance:getHeroCO(heroId)

		UISpriteSetMgr.instance:setSummonSprite(item.imageRare, heroCo.rare < SSR_RARE_LV and "bg_choukahuang" or "bg_choukaju")
		UISpriteSetMgr.instance:setCommonSprite(item.imageCareer, "lssx_" .. tostring(heroCo.career))
		item.simageHero:LoadImage(ResUrl.getHandbookheroIcon(heroCo.skinId))

		item.data.clickId = heroId
		item.txtNameCn.text = heroCo.name
	else
		gohelper.setActive(item.imageRare, false)
		gohelper.setActive(item.imageCareer, false)
		gohelper.setActive(item.txtNameCn, false)
		gohelper.setActive(item.imageNameEn, false)

		local maxSelectCount = SummonCustomPickModel.instance:getMaxSelectCount(self._poolId)
		local useSimageHeroOne = maxSelectCount == 1 or maxSelectCount == 3

		gohelper.setActive(item.simageHero, not useSimageHeroOne)
		gohelper.setActive(item.simageHero2, useSimageHeroOne)

		if not SummonCustomPickDescProbUpView.EmptyHeroIconList[index] then
			local picName = SummonCustomPickDescProbUpView.EmptyHeroIconList[1]

			if useSimageHeroOne then
				picName = SummonCustomPickDescProbUpView.PickOneEmptyHeroIcon

				item.simageHero2:LoadImage(ResUrl.getHandbookheroIcon(SummonCustomPickDescProbUpView.PickOneEmptyHeroIcon), self.handleLoadedImage, {
					imgTransform = item.simageHero2.gameObject.transform
				})
			else
				item.simageHero:LoadImage(ResUrl.getHandbookheroIcon(SummonCustomPickDescProbUpView.EmptyHeroIconList[index]))
			end
		end
	end
end

function SummonCustomPickDescProbUpView.handleLoadedImage(param)
	local imgTr = param.imgTransform

	ZProj.UGUIHelper.SetImageSize(imgTr.gameObject)
end

function SummonCustomPickDescProbUpView:onClickHeroItem(item)
	if item.clickId ~= nil then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = item.clickId
		})
	end
end

return SummonCustomPickDescProbUpView
