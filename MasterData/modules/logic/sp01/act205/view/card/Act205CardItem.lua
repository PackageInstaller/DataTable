-- chunkname: @modules/logic/sp01/act205/view/card/Act205CardItem.lua

module("modules.logic.sp01.act205.view.card.Act205CardItem", package.seeall)

local Act205CardItem = class("Act205CardItem", LuaCompBase)

function Act205CardItem:init(go)
	self.go = go
	self._goWeapon = gohelper.findChild(self.go, "#go_Weapon")
	self._simageweapon = gohelper.findChildSingleImage(self.go, "#go_Weapon/image_WeaponPic")
	self._txtWeaponName = gohelper.findChildText(self.go, "#go_Weapon/#txt_WeaponName")
	self._goRole = gohelper.findChild(self.go, "#go_Role")
	self._simagerole = gohelper.findChildSingleImage(self.go, "#go_Role/image_RolePic")
	self._txtRoleName = gohelper.findChildText(self.go, "#go_Role/#txt_RoleName")
	self._txtDescr = gohelper.findChildText(self.go, "Scroll View/Viewport/#txt_Descr")
	self._btnclick = gohelper.findChildClickWithAudio(self.go, "Scroll View/#btn_click")
	self._goSelected = gohelper.findChild(self.go, "#go_Selected")
	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act205CardItem:addEventListeners()
	self._btnclick:AddClickListener(self._onClick, self)
	self.addEventCb(self, Act205CardController.instance, Act205Event.PlayerSelectCard, self._onSelectCard, self)
end

function Act205CardItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, Act205CardController.instance, Act205Event.PlayerSelectCard, self._onSelectCard, self)
end

function Act205CardItem:_onClick()
	if not self._canClick then
		return
	end

	Act205CardController.instance:playerClickCard(self._cardId)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_common_click)
end

function Act205CardItem:_onSelectCard(carId)
	if not self._cardId or not self._canClick then
		return
	end

	self:refreshSelected(carId == self._cardId)
end

function Act205CardItem:_editableInitView()
	self:setCanClick()
end

function Act205CardItem:setData(cardId, canClick)
	self._cardId = cardId

	self:_setCard()
	self:setCanClick(canClick)
end

function Act205CardItem:_setCard()
	local cardType = Act205Config.instance:getCardType(self._cardId)
	local isWeapon = cardType == Act205Enum.CardType.Weapon
	local img = Act205Config.instance:getCardImg(self._cardId)
	local imgPath = ResUrl.getV2a9ActSingleBg("card_item_pic/" .. img)

	if isWeapon then
		self._simageweapon:LoadImage(imgPath)
	else
		self._simagerole:LoadImage(imgPath)
	end

	gohelper.setActive(self._goWeapon, isWeapon)
	gohelper.setActive(self._goRole, not isWeapon)

	local name = Act205Config.instance:getCardName(self._cardId)

	self._txtWeaponName.text = name
	self._txtRoleName.text = name
	self._txtDescr.text = Act205Config.instance:getCardDesc(self._cardId)
end

function Act205CardItem:setCanClick(isCanClick)
	self._canClick = isCanClick

	self:refreshSelected()
end

function Act205CardItem:refreshSelected(needPlay)
	if self._canClick then
		self:playAnim(Act205CardModel.instance:isCardSelected(self._cardId) and "select" or "unselect", needPlay)
	end
end

function Act205CardItem:playAnim(animName, needPlay)
	if string.nilorempty(animName) or not self._animator then
		return
	end

	self._animator:Play(animName, 0, needPlay and 0 or 1)
end

function Act205CardItem:onDestroy()
	self._simageweapon:UnLoadImage()
	self._simagerole:UnLoadImage()
end

return Act205CardItem
