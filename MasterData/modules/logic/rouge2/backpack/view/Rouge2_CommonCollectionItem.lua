-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_CommonCollectionItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_CommonCollectionItem", package.seeall)

local Rouge2_CommonCollectionItem = class("Rouge2_CommonCollectionItem", LuaCompBase)

function Rouge2_CommonCollectionItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_CommonCollectionItem)
end

function Rouge2_CommonCollectionItem:init(go)
	self.go = go
	self._simageBg = gohelper.findChildSingleImage(self.go, "BG_dissolve")
	self._simageBg2 = gohelper.findChildSingleImage(self.go, "image_BG")
	self._txtRare = gohelper.findChildText(self.go, "image_BG/#txt_rare")
	self._imageNameBg = gohelper.findChildImage(self.go, "Relics/image_namebg")
	self._imageRareIcon = gohelper.findChildImage(self.go, "Relics/#image_RareIcon")
	self._imageRelicsIcon = gohelper.findChildSingleImage(self.go, "Relics/#image_RelicsIcon")
	self._imageIcon = gohelper.findChildImage(self.go, "Relics/#image_Icon")
	self._txtRelicsName = gohelper.findChildText(self.go, "Relics/#txt_RelicsName")
	self._scrollOverview = gohelper.findChild(self.go, "#scroll_overview"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._goContent = gohelper.findChild(self.go, "#scroll_overview/Viewport/Content")
	self._btnClick = gohelper.getClickWithAudio(self.go, AudioEnum.Rouge2.SelectDropItem)
	self._btnClick2 = gohelper.findChildClickWithAudio(self.go, "#scroll_overview/Viewport", AudioEnum.Rouge2.SelectDropItem)
	self._goReddot = gohelper.findChild(self.go, "Relics/#go_Reddot")
	self._goSelect = gohelper.findChild(self.go, "#go_Select")
	self._animator = SLFramework.AnimatorPlayer.Get(self.go)

	gohelper.setActive(self._goReddot, false)
	gohelper.setActive(self._goSelect, false)
	self:initRareEffectTab()

	self._listener = Rouge2_CommonItemDescModeListener.Get(self.go)

	self._listener:initCallback(self.refreshItemDesc, self)
end

function Rouge2_CommonCollectionItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnClick2:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_CommonCollectionItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self._btnClick2:RemoveClickListener()
end

function Rouge2_CommonCollectionItem:_btnClickOnClick()
	if self._clickCallback then
		self._clickCallback(self._clickCallbackObj)
	end
end

function Rouge2_CommonCollectionItem:initClickCallback(clickCallback, clickCallbackObj)
	self._clickCallback = clickCallback
	self._clickCallbackObj = clickCallbackObj
end

function Rouge2_CommonCollectionItem:initDescModeFlag(descModeFlag)
	self._listener:setDataFlag(descModeFlag)
end

function Rouge2_CommonCollectionItem:initDescIncludeTypes(includeTypes)
	self._descIncludeTypes = includeTypes
end

function Rouge2_CommonCollectionItem:setParentScroll(goParentScroll)
	self._scrollOverview.parentGameObject = goParentScroll
end

function Rouge2_CommonCollectionItem:getReddotGo()
	return self._goReddot
end

function Rouge2_CommonCollectionItem:initRareEffectTab()
	self._rareEffectTab = self:getUserDataTb_()

	local goParent = gohelper.findChild(self.go, "Relics/#Rare")
	local tranParent = goParent.transform
	local effectNum = tranParent.childCount

	for i = 1, effectNum do
		local goeffect = tranParent:GetChild(i - 1).gameObject
		local effectName = goeffect.name

		self._rareEffectTab[effectName] = goeffect
	end

	gohelper.setActive(goParent, true)
end

function Rouge2_CommonCollectionItem:onUpdateMO(dataType, dataId)
	self._dataType = dataType
	self._dataId = dataId
	self._relicsCo, self._relicsMo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)
	self._uid = self._relicsMo and self._relicsMo:getUid()
	self._relicsId = self._relicsCo.id
	self._attrId = self._relicsCo and self._relicsCo.attributeTag

	self:refreshUI()
end

function Rouge2_CommonCollectionItem:refreshUI()
	self._txtRelicsName.text = self._relicsCo and self._relicsCo.name

	self:showRareEffect()
	Rouge2_IconHelper.setRelicsIcon(self._relicsId, self._imageRelicsIcon)
	Rouge2_IconHelper.setRelicsRareIcon(self._relicsId, self._imageRareIcon)
	Rouge2_IconHelper.setRelicsRareIcon(self._relicsId, self._simageBg, Rouge2_Enum.ItemRareIconType.Bg)
	Rouge2_IconHelper.setRelicsRareIcon(self._relicsId, self._simageBg2, Rouge2_Enum.ItemRareIconType.Bg)
	Rouge2_IconHelper.setRelicsRareIcon(self._relicsId, self._imageNameBg, Rouge2_Enum.ItemRareIconType.NameBg)
	Rouge2_IconHelper.setAttributeIcon(self._attrId, self._imageIcon)

	local rareCo = Rouge2_CollectionConfig.instance:getRareConfig(self._relicsCo.rare)
	local rareName = rareCo and rareCo.name
	local rareColor = rareCo and rareCo.relicsColor

	self._txtRare.text = string.format("<#%s>%s</color>", rareColor, rareName)

	self._listener:startListen()
end

function Rouge2_CommonCollectionItem:showRareEffect()
	if self._relicsCo then
		local rare = self._relicsCo.rare
		local rareName = string.format("rare%s", rare)

		for effectName, goRare in pairs(self._rareEffectTab) do
			gohelper.setActive(goRare, effectName == rareName)
		end
	end
end

function Rouge2_CommonCollectionItem:refreshItemDesc(descMode)
	Rouge2_ItemDescHelper.setItemDesc(self._dataType, self._dataId, self._goContent, descMode, self._descIncludeTypes)
end

function Rouge2_CommonCollectionItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)

	local animName = isSelect and "select" or "normal"

	self:playAnim(animName)
end

function Rouge2_CommonCollectionItem:playAnim(animName, callback, callbackObj)
	if not self.go.activeInHierarchy then
		return
	end

	self._animator:Play(animName, callback or self._defaultOnPlayAnimDone, callbackObj or self)
end

function Rouge2_CommonCollectionItem:_defaultOnPlayAnimDone()
	return
end

function Rouge2_CommonCollectionItem:onDestroy()
	self._clickCallback = nil
	self._clickCallbackObj = nil
	self._scrollOverview.parentGameObject = nil

	self._simageBg:UnLoadImage()
	self._simageBg2:UnLoadImage()
end

return Rouge2_CommonCollectionItem
