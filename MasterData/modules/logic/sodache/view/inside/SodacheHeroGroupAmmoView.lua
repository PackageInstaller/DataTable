-- chunkname: @modules/logic/sodache/view/inside/SodacheHeroGroupAmmoView.lua

module("modules.logic.sodache.view.inside.SodacheHeroGroupAmmoView", package.seeall)

local SodacheHeroGroupAmmoView = class("SodacheHeroGroupAmmoView", BaseView)

function SodacheHeroGroupAmmoView:onInitView()
	self._btnattr = gohelper.findChildButtonWithAudio(self.viewGO, "#go_sodache/#btn_attr")
	self._btnitem = gohelper.findChildButtonWithAudio(self.viewGO, "#go_sodache/#btn_item")
	self._btnbag = gohelper.findChildButtonWithAudio(self.viewGO, "#go_sodache/#btn_bag")
	self._goempty = gohelper.findChild(self.viewGO, "#go_sodache/#go_empty")
	self._gocarditem = gohelper.findChild(self.viewGO, "#go_sodache/#go_carditem")
end

function SodacheHeroGroupAmmoView:addEvents()
	self._btnattr:AddClickListener(self._onClickAttr, self)
	self._btnitem:AddClickListener(self._onClickItem, self)
	self._btnbag:AddClickListener(self._onClickBag, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnUpdateBattleInfo, self._refreshInfo, self)
end

function SodacheHeroGroupAmmoView:removeEvents()
	self._btnattr:RemoveClickListener()
	self._btnitem:RemoveClickListener()
	self._btnbag:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnUpdateBattleInfo, self._refreshInfo, self)
end

function SodacheHeroGroupAmmoView:onOpen()
	self._carditem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gocarditem, SodacheCardItem)
	self._battleInfo = SodacheModel.instance:getInsideMo().prop.battleInfo

	self:_refreshInfo()
end

function SodacheHeroGroupAmmoView:_onClickAttr()
	ViewMgr.instance:openView(ViewName.SodacheRelicOverView)
end

function SodacheHeroGroupAmmoView:_onClickItem()
	local insideBag = SodacheModel.instance:getOutsideMo():getBag(SodacheEnum.BagType.Inside)

	if #insideBag:getItemsByCardType(SodacheEnum.CardType.Ammo) <= 0 then
		GameFacade.showToast(ToastEnum.SodacheToastId373012)

		return
	end

	local selectMo = SodacheCardSelectMo.New()

	selectMo.selectCallobj = self
	selectMo.selectCallback = self.onSelectCardEnd

	selectMo:setCanSelectCards(SodacheEnum.CardType.Ammo, SodacheEnum.BagType.Inside)

	selectMo.totalSelectCount = 1
	selectMo.recommendList = self._battleInfo.careerIds

	if self._battleInfo.itemId > 0 then
		selectMo:addItemCount(self._battleInfo.itemId, 1)
	end

	ViewMgr.instance:openView(ViewName.SodacheCardQuickSelectView, selectMo)
end

function SodacheHeroGroupAmmoView:onSelectCardEnd(selectCards)
	local itemId, num = next(selectCards)

	if itemId then
		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.FightSelectCard, tostring(itemId) .. ":" .. num)
	else
		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.FightSelectCard, "")
	end
end

function SodacheHeroGroupAmmoView:_onClickBag()
	ViewMgr.instance:openView(ViewName.SodacheBagView)
end

function SodacheHeroGroupAmmoView:_refreshInfo()
	local cardMo = self._battleInfo.itemId > 0 and SodacheCardMo.Create(self._battleInfo.itemId)

	gohelper.setActive(self._gocarditem, cardMo)
	gohelper.setActive(self._goempty, not cardMo)

	if cardMo then
		self._carditem:updateMo(cardMo)
	end
end

return SodacheHeroGroupAmmoView
