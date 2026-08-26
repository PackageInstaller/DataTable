-- chunkname: @modules/logic/partygame/view/common/PartyGameCommonCard.lua

module("modules.logic.partygame.view.common.PartyGameCommonCard", package.seeall)

local PartyGameCommonCard = class("PartyGameCommonCard", UserDataDispose)

function PartyGameCommonCard:init(go, index)
	self:__onInit()

	self.viewGO = go
	self.index = index

	self:onInitView()
end

function PartyGameCommonCard:getAnchor()
	return recthelper.getAnchor(self.viewRectTr)
end

function PartyGameCommonCard:onInitView()
	self.viewRectTr = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.rootRectTr = gohelper.findChildComponent(self.viewGO, "root", gohelper.Type_RectTransform)
	self._goqualityframe = gohelper.findChild(self.viewGO, "root/#go_qualityframe")
	self._imageCard = gohelper.findChildImage(self.viewGO, "root/#image_card")
	self._imageCardLose = gohelper.findChildImage(self.viewGO, "root/#image_card_lose")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/txt_power")
	self._goselectframe = gohelper.findChild(self.viewGO, "root/#go_selectframe")
	self._imageselectframe = gohelper.findChildImage(self.viewGO, "root/#go_selectframe")
	self._txtselectnum = gohelper.findChildText(self.viewGO, "root/#go_selected/txt_selectindex")
	self._goselectnum = gohelper.findChild(self.viewGO, "root/#go_selected")
	self._govarianticon = gohelper.findChild(self.viewGO, "root/#go_varianticon")
	self._imagevarianticon = gohelper.findChildImage(self.viewGO, "root/#go_varianticon")

	gohelper.setActive(self._goselectframe, false)
	gohelper.setActive(self._goselectnum, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection

function PartyGameCommonCard:_editableInitView()
	self._ani = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._uiEffect = ZProj_UIEffectsCollection.Get(self.viewGO)

	self._uiEffect:SetGray(false)
end

function PartyGameCommonCard:hide()
	gohelper.setActive(self.viewGO, false)
end

function PartyGameCommonCard:show()
	gohelper.setActive(self.viewGO, true)
end

function PartyGameCommonCard:updateId(id)
	self.id = id
	self.config = lua_partygame_carddrop_card.configDict[self.id]

	if not self.config then
		logError(string.format("卡牌配置不存在：" .. tostring(self.id)))

		self.config = lua_partygame_carddrop_card.configList[1]
	end

	self.typeConfig = lua_partygame_carddrop_cardtype.configDict[self.config.type]

	self:refreshItem()
	self:refreshVariantIcon()
	self:refreshSelectFrame()
end

function PartyGameCommonCard:refreshItem()
	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imageCard, self.typeConfig.icon)
	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imageCardLose, self.typeConfig.loseIcon)

	self._txtnum.text = self.config.power
end

function PartyGameCommonCard:refreshVariantIcon()
	local variant = self.config.variantType

	if variant == CardDropEnum.Variant.None then
		gohelper.setActive(self._govarianticon, false)
	else
		gohelper.setActive(self._govarianticon, true)
		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagevarianticon, CardDropEnum.Variant2Icon[variant])
	end
end

function PartyGameCommonCard:refreshSelectFrame()
	local imageName = self.typeConfig.selectedMask

	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imageselectframe, imageName)
end

function PartyGameCommonCard:getCardId()
	return self.id
end

function PartyGameCommonCard:getIndex()
	return self.index
end

function PartyGameCommonCard:getConfig()
	return self.config
end

function PartyGameCommonCard:getViewRectTr()
	return self.viewRectTr
end

function PartyGameCommonCard:onDestroy()
	self:__onDispose()
end

return PartyGameCommonCard
