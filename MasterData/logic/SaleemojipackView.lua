-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preheatsale/view/SaleemojipackView.lua

module("logic.extensions.preheatsale.view.SaleemojipackView", package.seeall)

local SaleemojipackView = class("SaleemojipackView", ViewComponent)

function SaleemojipackView:ctor()
	SaleemojipackView.super.ctor(self)
end

function SaleemojipackView:unbindEvents()
	SaleemojipackView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnBuy)

	for i = 1, 6 do
		GameUtil.rmClickHandler(self.prizeList[i].item)
	end
end

function SaleemojipackView:bindEvents()
	SaleemojipackView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnBuy, self.onClickBuy, self)

	for i = 1, 6 do
		GameUtil.addClickHandler(self.prizeList[i].item, GameUtil.handler(self.onClickPrize, self, i))
	end
end

function SaleemojipackView:buildUI()
	SaleemojipackView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnBuy = self:getGo("btnBuy")
	self.txtBuy = self:getTxt("btnBuy/txt")
	self.txtDate = self:getTxt("txtDate")
	self.prizeList = {}

	for i = 1, 6 do
		local cell = {}

		cell.go = self:getGo("prizeList/cell_" .. i)
		cell.item = goutil.findChild(cell.go, "item")
		cell.prizeStr = nil
		cell.btn = GameUtil.asBtn(cell.item)
		cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
		self.prizeList[i] = cell
	end

	self.otherHead = self:getGo("left/item_other/Nego_Icon/ImgC_Icon")
	self.otherTxtC_Name = self:getTxt("left/item_other/TxtC_Name")
	self.otherTxtC_Content = self:getTxt("left/item_other/ImgC_ContentBg/TxtC_Content")
	self.myHead2 = self:getGo("left/item_sprite/Nego_Icon/ImgC_Icon")
	self.myTxtC_Name2 = self:getTxt("left/item_sprite/TxtC_Name")
	self.myImg = self:getGo("left/item_sprite/img")
	self.myHead = self:getGo("left/item_my/Nego_Icon/ImgC_Icon")
	self.myTxtC_Name = self:getTxt("left/item_my/TxtC_Name")
	self.myTxtC_Content = self:getTxt("left/item_my/ImgC_ContentBg/TxtC_Content")
	self.otherContent = self:getGo("left/item_other")
	self.mySprite = self:getGo("left/item_sprite")
	self.myContent = self:getGo("left/item_my")
	self.cell = self:getGo("left/cell")
	self.tableview = self:getGo("left/tableview")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function SaleemojipackView:onExit()
	SaleemojipackView.super.onExit(self)
	self.scrollList:dispose()
	HeadItemController.instance:resetHeadCell(self.otherHead)
	HeadItemController.instance:resetHeadCell(self.myHead)
	HeadItemController.instance:resetHeadCell(self.myHead2)
	MaterialMgr.clearIcon(self.myImg)
	GlobalDispatcher:removeListener(GlobalNotify.PreheatSaleError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.PreheatSaleInfoUpdate, self._updateByInfo, self)
	self:remmoveAllTimer()
	removetimer(self._countDown, self)

	for i = 1, 6 do
		MaterialMgr.clearIcon(self.prizeList[i].item)
	end
end

function SaleemojipackView:onEnter()
	SaleemojipackView.super.onEnter(self)

	local activityId = 87002
	local list = PreheatSaleConfig.instance:getActEmojipackCfg(activityId) or {}

	self._curActId = activityId
	self._showList = list
	self.selectId = -1

	if #list > 0 then
		self.selectId = list[1].id

		self:updateUI(list[1])
	end

	self.scrollList:reloadData(list)
	self:_updateByInfo()
	GlobalDispatcher:addListener(GlobalNotify.PreheatSaleError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.PreheatSaleInfoUpdate, self._updateByInfo, self)
	PreheatSaleAgent.instance:sendPM_PreheatSaleGetInfoReq({
		self._curActId
	})
	settimer(1, self._countDown, self)
end

function SaleemojipackView:_updateCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local select = goutil.findChild(cell, "select")
	local top = goutil.findChild(cell, "top")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.item)

	MaterialMgr.setIcon(item, matType, matId)

	local emojiCfg = ChatConfig.instance:getEmojiCfg(matId)

	txtName.text = emojiCfg.name

	GameUtil.SetActive(select, self.selectId == data.id)
	GameUtil.addClickHandler(top, GameUtil.handler(self.onClickCell, self, data))
end

function SaleemojipackView:clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.clearIcon(item)
end

function SaleemojipackView:onClickCell(data)
	self.selectId = data.id

	self.scrollList:refresh()
	self:updateUI(data)
end

function SaleemojipackView:updateUI(data)
	HeadItemController.instance:setHeadCell(self.otherHead, data.otherHeadId, data.otherFrameId)
	HeadItemController.instance:setHeadCell(self.myHead, data.myHeadId, data.myFrameId)
	HeadItemController.instance:setHeadCell(self.myHead2, data.myHeadId, data.myFrameId)

	self.otherTxtC_Name.text = data.otherName
	self.otherTxtC_Content.text = data.otherChat
	self.myTxtC_Name2.text = data.myName
	self.myTxtC_Name.text = data.myName
	self.myTxtC_Content.text = data.myChat

	MaterialMgr.updateItemByStr(self.myImg, data.item)
	self:remmoveAllTimer()
	GameUtil.SetActive(self.otherContent, false)
	GameUtil.SetActive(self.mySprite, false)
	GameUtil.SetActive(self.myContent, false)
	settimer(1, self.onShowOther, self, false)
end

function SaleemojipackView:onShowOther()
	GameUtil.SetActive(self.otherContent, true)
	settimer(1, self.onShowImg, self, false)
end

function SaleemojipackView:onShowImg()
	GameUtil.SetActive(self.mySprite, true)
	settimer(1, self.onShowContent, self, false)
end

function SaleemojipackView:onShowContent()
	GameUtil.SetActive(self.myContent, true)
	settimer(2, self.onShowNext, self, false)
end

function SaleemojipackView:onShowNext()
	local showNextId = self.selectId + 1

	if showNextId > #self._showList then
		showNextId = 1
	end

	self:onClickCell(self._showList[showNextId])
end

function SaleemojipackView:remmoveAllTimer()
	removetimer(self.onShowImg, self)
	removetimer(self.onShowOther, self)
	removetimer(self.onShowContent, self)
	removetimer(self.onShowNext, self)
end

function SaleemojipackView:_onError()
	return
end

function SaleemojipackView:_updateByInfo()
	self._curActCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.PerheatSale, self._curActId)
	self._commonCfg = PreheatSaleConfig.instance:getcommonCfg(self._curActId)

	if not self._commonCfg or not self._commonCfg or not self._curActCfg then
		printError("当前活动配置为空：" .. self._curActId)

		return
	end

	self._isOverTime = PreheatSaleModel.instance:isOverTime(self._curActId)

	if not self._commonCfg.gift then
		local prizeStr = ""
		local prizeStrs = string.split(prizeStr, "#")
		local dataList = {}

		for i, data in pairs(prizeStrs) do
			if not GameUtil.isEmptyString(data) then
				table.insert(dataList, data)
			end
		end

		for i = 1, 6 do
			self.prizeList[i].prizeStr = dataList[i]

			goutil.setActive(self.prizeList[i].go, false)

			if not string.nilorempty(self.prizeList[i].prizeStr) then
				goutil.setActive(self.prizeList[i].go, true)

				local matType, matId, matNum = MaterialMgr.getMatParams(dataList[i])

				MaterialMgr.setIcon(self.prizeList[i].item, matType, matId)

				self.prizeList[i].txtNum.text = "X" .. matNum
			end
		end

		self.txtBuy.text = self._isOverTime and lang("活动结束") or PreheatSaleModel.instance:getIsHasBuy(self._curActId) and lang("已购买") or langPara("%s元", PayConfig.instance:getPayMoneyYuan(self._commonCfg.payGoodsId))
	end
end

function SaleemojipackView:_countDown()
	local timeEnd = GameUtil.string2time(self._curActCfg.endTime)

	self.txtDate.text = langPara("活动结束时间：%s", GameUtil.formatTimeStamp("%m月%d日%H时", self._timeEnd))

	local timeLeft = timeEnd - ServerTime.now()

	if timeLeft > 0 then
		self.txtDate.text = langPara("剩余时间：%s", GameUtil.FormatTimeSymbol(timeLeft))
	else
		self.txtBuy.text = lang("活动结束")
		self.txtDate.text = lang("活动结束")

		removetimer(self._countDown, self)
	end
end

function SaleemojipackView:onClickBuy()
	if not self._commonCfg or not self._commonCfg or not self._curActCfg then
		printError("当前活动配置为空：" .. self._curActId)

		return
	end

	if self._isOverTime then
		self.txtBuy.text = lang("活动结束")

		FloatWordMgr.instance:show(lang("当前活动已结束"))
	elseif PreheatSaleModel.instance:getIsHasBuy(self._curActId) then
		self.txtBuy.text = lang("已购买")

		FloatWordMgr.instance:show(lang("不可重复购买"))
	else
		PayController.instance:sendGenOrderNoReq(self._commonCfg.payGoodsId, GameEnum.PaySubGoodsType.PREHEAT_SALE, self._curActId)
	end
end

function SaleemojipackView:onClickPrize(id)
	local matstr = self.prizeList[id].prizeStr

	if not string.nilorempty(matstr) then
		CommonTipsMgr.instance:openTipsByConfStr(self.prizeList[id].item, matstr)
	end
end

return SaleemojipackView
