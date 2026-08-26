-- chunkname: @modules/logic/sodache/view/inside/SodacheMapUseCardView.lua

module("modules.logic.sodache.view.inside.SodacheMapUseCardView", package.seeall)

local SodacheMapUseCardView = class("SodacheMapUseCardView", BaseView)

function SodacheMapUseCardView:onInitView()
	self._btncard = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Card/#btn_card")
	self._gocardcontainer = gohelper.findChild(self.viewGO, "Left/Card/#btn_card/#go_cardcontainer")
	self._btnclosecardcontainer = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Card/#btn_card/#go_cardcontainer/#btn_click")
	self._txtcardNum = gohelper.findChildTextMesh(self.viewGO, "Left/Card/#btn_card/#txt_level")
	self._cardgoitem = gohelper.findChild(self.viewGO, "Left/Card/#btn_card/#go_cardcontainer/card/#scroll_card/viewport/content/carditem")
	self._goscroll = gohelper.findChild(self.viewGO, "Left/Card/#btn_card/#go_cardcontainer/card/#scroll_card")
	self._animMask = gohelper.findChildAnim(self.viewGO, "mask2")
	self._animCard = gohelper.findChildAnim(self.viewGO, "Left/Card/#btn_card/#go_cardcontainer/card")
end

function SodacheMapUseCardView:addEvents()
	self._btncard:AddClickListener(self._onClickCard, self)
	self._btnclosecardcontainer:AddClickListener(self._onClickCardClose, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnBagUpdate, self._refreshCardNum, self)
end

function SodacheMapUseCardView:removeEvents()
	self._btncard:RemoveClickListener()
	self._btnclosecardcontainer:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnBagUpdate, self._refreshCardNum, self)
end

function SodacheMapUseCardView:onOpen()
	gohelper.setActive(self._gocardcontainer, false)
	self:_refreshCardNum()
end

function SodacheMapUseCardView:_onClickCard()
	if #self._canUseCards <= 0 then
		GameFacade.showToast(ToastEnum.SodacheToastId373004)

		return
	end

	gohelper.setActive(self._gocardcontainer, true)
	self:refreshCardList()
end

function SodacheMapUseCardView:_onClickCardClose()
	self._animCard:Play("close")
	UIBlockHelper.instance:startBlock("SodacheMapUseCardView_CardClose", 0.2)
	TaskDispatcher.runDelay(self._delayHideCardContainer, self, 0.2)
end

function SodacheMapUseCardView:_delayHideCardContainer()
	gohelper.setActive(self._gocardcontainer, false)
end

function SodacheMapUseCardView:_refreshCardNum()
	self._canUseCards = {}

	local dict = {}
	local items = SodacheUtil.getItemsByCardType(SodacheEnum.CardType.Adventure, SodacheEnum.BagType.Inside)

	for i, v in ipairs(items) do
		if v.itemCo.directUse == 1 then
			if not dict[v.configId] then
				dict[v.configId] = SodacheCardMo.Create(v.configId, v.count)

				table.insert(self._canUseCards, dict[v.configId])
			else
				dict[v.configId].serverMo.count = dict[v.configId].serverMo.count + v.count
			end
		end
	end

	self._txtcardNum.text = #self._canUseCards

	if self._gocardcontainer.activeSelf then
		if #self._canUseCards <= 0 then
			gohelper.setActive(self._gocardcontainer, false)
		else
			self:refreshCardList()
		end
	end

	gohelper.setActive(self._btncard, #self._canUseCards > 0)
end

function SodacheMapUseCardView:refreshCardList()
	self._allCardGos = {}

	gohelper.CreateObjList(self, self._createCardItem, self._canUseCards, nil, self._cardgoitem, SodacheMapCardUseItem, nil, nil, 1)
end

function SodacheMapUseCardView:_createCardItem(obj, data, index)
	obj:updateMo(data)

	self._allCardGos[index] = obj
end

function SodacheMapUseCardView:onClose()
	TaskDispatcher.cancelTask(self._delayHideCardContainer, self)
end

return SodacheMapUseCardView
