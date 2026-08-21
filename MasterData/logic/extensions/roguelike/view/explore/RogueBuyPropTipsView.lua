-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueBuyPropTipsView.lua

module("logic.extensions.roguelike.view.explore.RogueBuyPropTipsView", package.seeall)

local M = class("RogueBuyPropTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._txtPropName = self:getText("item_tips_-1624252585")
	self._txtPropDesc = self:getUIComponent("item_tips_-136867712", UIComponentType.TextMeshProUGUI)
	self._txtCount = self:getText("item_tips_162590809")
	self._txtPropDesc2 = self:getText("item_tips_67372985")
	self._btnClose = self:getBtn("3&empty_mask_tips_29887572")
	self._btnBuy = self:getBtn("item_detail_tips_-957185829")
	self._imgCostIcon = goutil.findChildImageComponent(self._btnBuy.gameObject, "price/icon")
	self._txtCostCount = goutil.findChildTextComponent(self._btnBuy.gameObject, "price/txtPrice")
	self._imgPropIcon = self:getImage("item_detail_tips_copy_1991515580")
	self._goTime = self:getGo("item_detail_tips_-1238849104")
	self._goPath = self:getGo("item_detail_tips_827817151")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))

	goutil.setActive(self._btnBuy.gameObject, true)
	goutil.setActive(self._goTime, false)
	goutil.setActive(self._goPath, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function M:onEnter()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open1")
	self._guiAnimation:SetAniTime(0)
	self:setEvent(true)
	self:updateData()
end

function M:onExit()
	self:setEvent(false)

	self._inBuy = false
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOP_BUY_SUCCESS, self._onShopBuySuccess, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOP_BUY_SUCCESS, self._onShopBuySuccess, self)
	end
end

function M:updateData()
	local cost = self:getFirstParam().cost
	local id = self:getFirstParam().id
	local co = RoguelikeConfig.instance:getPropById(id)

	self._txtPropName.text = co.name

	local linkText = co.link ~= "" and "\n\n" .. co.link or ""

	self._txtPropDesc.text = StringUtil.replaceAllGraphicTmpText(co.descirption .. linkText)
	self._txtPropDesc2.text = StringUtil.replaceAllGraphicText2(co.copywriting)
	self._txtCostCount.text = cost
	self._txtCount.text = ""

	IconLoader.setSprite(self._imgPropIcon, IconType.ItemIcon, co.art)
end

function M:_onShopBuySuccess()
	self:close()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_gain)
end

function M:_onClickClose()
	self:close()
end

function M:_onClickBuy()
	if self._inBuy then
		return
	end

	local cost = self:getFirstParam().cost
	local id = self:getFirstParam().id
	local isRestore = self:getFirstParam().isRestore

	isRestore = isRestore ~= nil and isRestore or false

	local coinNum = RoguelikeModel.instance:getGold() or 0

	if coinNum < cost then
		FloatWordMgr.instance:show(lang("tip_r_not_enough_coin"))

		return
	end

	RoguelikeAgent.instance:sendMallBuyRequest(id, isRestore)

	self._inBuy = true
end

return M
