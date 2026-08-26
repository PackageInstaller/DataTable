-- chunkname: @modules/logic/sodache/view/inside/SodacheGetCardView.lua

module("modules.logic.sodache.view.inside.SodacheGetCardView", package.seeall)

local SodacheGetCardView = class("SodacheGetCardView", BaseView)

function SodacheGetCardView:onInitView()
	self._golose = gohelper.findChild(self.viewGO, "bg/#go_lose")
	self._goget = gohelper.findChild(self.viewGO, "bg/#go_get")
	self._gogetcard = gohelper.findChild(self.viewGO, "bg/#go_lose/txt_title")
	self._golosecard = gohelper.findChild(self.viewGO, "bg/#go_lose/txt_title2")
	self._gogetcard2 = gohelper.findChild(self.viewGO, "bg/#go_get/txt_title")
	self._golosecard2 = gohelper.findChild(self.viewGO, "bg/#go_get/txt_title2")
	self._btnclose = gohelper.findChildClickWithAudio(self.viewGO, "#btn_close")
	self._btnFlipAll = gohelper.findChildClickWithAudio(self.viewGO, "#go_dragArea")
	self._godragarea = gohelper.findChild(self.viewGO, "#go_dragArea")
	self._goLayout = gohelper.findChild(self.viewGO, "#go_content/#go_Layout")
	self._gocarditem = gohelper.findChild(self.viewGO, "#go_content/#go_Layout/#go_carditem")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godragarea)
end

function SodacheGetCardView:addEvents()
	self._drag:AddDragBeginListener(self._onBeginDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self)
	self._btnclose:AddClickListener(self.closeThis, self)
	self._btnFlipAll:AddClickDownListener(self.onClickDown, self)
	self._btnFlipAll:AddClickUpListener(self.onClickUp, self)
end

function SodacheGetCardView:removeEvents()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._btnclose:RemoveClickListener()
	self._btnFlipAll:RemoveClickDownListener()
	self._btnFlipAll:RemoveClickUpListener()
end

function SodacheGetCardView:onClickDown()
	self._isDown = true
end

function SodacheGetCardView:onClickUp()
	if self._isDown then
		for k, v in pairs(self._waitDict1) do
			self:_flipCard(k)
		end
	end
end

function SodacheGetCardView:_onBeginDrag(param, pointerEventData)
	self._isDrag = true
end

function SodacheGetCardView:_onEndDrag(param, pointerEventData)
	self._isDrag = false
end

function SodacheGetCardView:_onCardItemDrag(param, pointerEventData)
	self:_onBeginDrag()
	self:_onCardItemHover(param)
end

function SodacheGetCardView:_onCardItemHover(cardIndex)
	if not self._isDrag then
		return
	end

	self:_flipCard(cardIndex)
end

function SodacheGetCardView:_onClickCard(cardIndex)
	if self._waitDict1[cardIndex] then
		self:_flipCard(cardIndex)
	elseif not self._waitDict2[cardIndex] then
		local cardMo = self._cardItemDict[cardIndex].cardObj.data

		ViewMgr.instance:openView(ViewName.SodacheCardDetailView, {
			cardMo = cardMo
		})
	end
end

function SodacheGetCardView:_flipCard(cardIndex)
	self._isDown = false

	if not self._waitDict1[cardIndex] then
		return
	end

	if self._isAllDebuff then
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.losecard_flip)
	else
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.getcard_flip)
	end

	self._waitDict1[cardIndex] = nil

	self._cardItemDict[cardIndex].cardObj:playAnim(self._onPlayEnd, self, cardIndex)
end

function SodacheGetCardView:_onPlayEnd(cardIndex)
	self._waitDict2[cardIndex] = nil

	self:checkComplete()
end

function SodacheGetCardView:checkComplete()
	local isComplete = not next(self._waitDict2)

	gohelper.setActive(self._godragarea, not isComplete)
	gohelper.setActive(self._btnclose, isComplete)
end

function SodacheGetCardView:onOpen()
	self._cardItemDict = {}
	self._waitDict1 = {}
	self._waitDict2 = {}

	local isAllDebuff = true

	for i, v in ipairs(self.viewParam.items) do
		if v.itemCo.type ~= SodacheEnum.CardType.Status or v.itemCo.subType ~= SodacheEnum.CardSubType.Status_Debuff then
			isAllDebuff = false

			break
		end
	end

	if not self.viewParam.isGetCard then
		isAllDebuff = not isAllDebuff
	end

	gohelper.setActive(self._gogetcard, self.viewParam.isGetCard)
	gohelper.setActive(self._golosecard, not self.viewParam.isGetCard)
	gohelper.setActive(self._gogetcard2, self.viewParam.isGetCard)
	gohelper.setActive(self._golosecard2, not self.viewParam.isGetCard)
	gohelper.setActive(self._golose, isAllDebuff)
	gohelper.setActive(self._goget, not isAllDebuff)

	self._isAllDebuff = isAllDebuff

	if self._isAllDebuff then
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.losecard)
	else
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.getcard)
	end

	gohelper.CreateObjList(self, self._onCreateItem, self.viewParam.items, self._goLayout, self._gocarditem)
	self:checkComplete()
end

function SodacheGetCardView:_onCreateItem(obj, data, index)
	local cardItem = self:getUserDataTb_()

	cardItem.go = obj
	cardItem.click = SLFramework.UGUI.UIClickListener.Get(cardItem.go)
	cardItem.drag = SLFramework.UGUI.UIDragListener.Get(cardItem.go)
	cardItem.press = SLFramework.UGUI.UILongPressListener.Get(cardItem.go)

	cardItem.click:AddClickListener(self._onClickCard, self, index)
	cardItem.drag:AddDragBeginListener(self._onCardItemDrag, self, index)
	cardItem.drag:AddDragEndListener(self._onEndDrag, self)
	cardItem.press:AddHoverListener(self._onCardItemHover, self, index)

	local cardGo = gohelper.findChild(obj, "#go_card/sodache_carditem")
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(cardGo, SodacheCardItem2)

	item:updateMo(data:toCardMo(SodacheEnum.CardSource.Normal))
	item:setNoNeedClick()

	cardItem.cardObj = item
	self._cardItemDict[index] = cardItem
	self._waitDict1[index] = true
	self._waitDict2[index] = true
end

function SodacheGetCardView:onClose()
	if self._cardItemDict then
		for _, cardItem in pairs(self._cardItemDict) do
			cardItem.click:RemoveClickListener()
			cardItem.drag:RemoveDragBeginListener()
			cardItem.drag:RemoveDragEndListener()
			cardItem.press:RemoveHoverListener()
		end
	end

	self._cardItemDict = {}
	self._isDrag = false
end

return SodacheGetCardView
