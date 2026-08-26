-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_CommonBuffItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_CommonBuffItem", package.seeall)

local Rouge2_CommonBuffItem = class("Rouge2_CommonBuffItem", LuaCompBase)

function Rouge2_CommonBuffItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_CommonBuffItem)
end

function Rouge2_CommonBuffItem:init(go)
	self.go = go
	self._imageBg = gohelper.findChildImage(self.go, "root/BG")
	self._imageRare = gohelper.findChildImage(self.go, "root/Info/#image_Rare")
	self._imageNameBg = gohelper.findChildImage(self.go, "root/Info/image_namebg")
	self._simageIcon = gohelper.findChildSingleImage(self.go, "root/Info/#image_Icon")
	self._txtName = gohelper.findChildText(self.go, "root/Info/#txt_Name")
	self._goContainer = gohelper.findChild(self.go, "root/#go_Container")
	self._txtDesc = gohelper.findChildText(self.go, "root/#go_Container/#txt_Desc")
	self._goSelect = gohelper.findChild(self.go, "root/#go_Select")
	self._goReddot = gohelper.findChild(self.go, "root/Info/#go_Reddot")
	self._goRecommend = gohelper.findChild(self.go, "root/Info/#go_Recommend")
	self._goTeamTips = gohelper.findChild(self.go, "root/Info/#go_TeamTips")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)

	gohelper.setActive(self._goReddot, false)
	gohelper.setActive(self._goSelect, false)
	self:initRareEffectTab()

	self._teamTipsParams = {}
	self._teamTipsLoader = Rouge2_TeamRecommendTipsLoader.Load(self._goTeamTips, Rouge2_Enum.TeamRecommendTipType.MultiItemSystemTag)
	self._teamTipsLoader2 = Rouge2_TeamRecommendTipsLoader.Load(self._goRecommend, Rouge2_Enum.TeamRecommendTipType.ItemRecommend)
	self._listener = Rouge2_CommonItemDescModeListener.Get(self.go)

	self._listener:initCallback(self.refreshItemDesc, self)
end

function Rouge2_CommonBuffItem:addEventListeners()
	return
end

function Rouge2_CommonBuffItem:removeEventListeners()
	return
end

function Rouge2_CommonBuffItem:getReddotGo()
	return self._goReddot
end

function Rouge2_CommonBuffItem:onUpdateMO(dataType, id)
	self._dataType = dataType
	self._id = id
	self._buffCo, self._buffMo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, id)
	self._buffId = self._buffCo and self._buffCo.id
	self._teamTipsParams[Rouge2_Enum.TeamRecommendParam.ItemId] = self._buffId

	self._teamTipsLoader:initInfo(nil, self._teamTipsParams)
	self._teamTipsLoader2:initInfo(nil, self._teamTipsParams)
	self._listener:startListen()
	self:refreshUI()
end

function Rouge2_CommonBuffItem:refreshUI()
	self:showRareEffect()

	self._txtName.text = self._buffCo and self._buffCo.name

	Rouge2_IconHelper.setBuffIcon(self._buffId, self._simageIcon)
	Rouge2_IconHelper.setBuffRareIcon(self._buffId, self._imageRare)
	Rouge2_IconHelper.setBuffRareIcon(self._buffId, self._imageBg, Rouge2_Enum.ItemRareIconType.Bg)
	Rouge2_IconHelper.setBuffRareIcon(self._buffId, self._imageNameBg, Rouge2_Enum.ItemRareIconType.NameBg)
end

function Rouge2_CommonBuffItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)

	local animName = isSelect and "light" or "normal"

	self:playAnim(animName)
end

function Rouge2_CommonBuffItem:playAnim(animName)
	if not self.go.activeInHierarchy then
		return
	end

	self._animator:Play(animName, 0, 0)
end

function Rouge2_CommonBuffItem:initRareEffectTab()
	self._rareEffectTab = self:getUserDataTb_()

	local goParent = gohelper.findChild(self.go, "root/Info/#Rare")
	local tranParent = goParent.transform
	local effectNum = tranParent.childCount

	for i = 1, effectNum do
		local goeffect = tranParent:GetChild(i - 1).gameObject
		local effectName = goeffect.name

		self._rareEffectTab[effectName] = goeffect
	end

	gohelper.setActive(goParent, true)
end

function Rouge2_CommonBuffItem:showRareEffect()
	if self._buffCo then
		local rare = self._buffCo.rare
		local rareName = string.format("rare%s", rare)

		for effectName, goRare in pairs(self._rareEffectTab) do
			gohelper.setActive(goRare, effectName == rareName)
		end
	end
end

function Rouge2_CommonBuffItem:initDescModeFlag(descModeFlag)
	self._listener:setDataFlag(descModeFlag)
end

function Rouge2_CommonBuffItem:refreshItemDesc(descMode)
	Rouge2_ItemDescHelper.setItemDescStr(self._dataType, self._id, self._txtDesc, descMode)
end

function Rouge2_CommonBuffItem:onDestroy()
	self._simageIcon:UnLoadImage()
end

return Rouge2_CommonBuffItem
