-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/purchaselimit/view/PurchaseLimitView.lua

module("logic.extensions.purchaselimit.view.PurchaseLimitView", package.seeall)

local PurchaseLimitView = class("PurchaseLimitView", ViewComponent)

function PurchaseLimitView:ctor()
	PurchaseLimitView.super.ctor(self)
end

function PurchaseLimitView:unbindEvents()
	PurchaseLimitView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function PurchaseLimitView:bindEvents()
	PurchaseLimitView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickPetInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function PurchaseLimitView:buildUI()
	PurchaseLimitView.super.buildUI(self)

	self._petCon = self:getGo("con")
	self._cell = self:getGo("cell")
	self._petViewGo = self:getGo("petView")
	self._petCell = self:getGo("petCell")
	self._itemcell = self:getGo("itemcell")
	self._tableViewGo = self:getGo("tableview")
	self._rare = self:getGo("petInfo/rare")
	self._txtTime = self:getTxt("time/txt")
	self._txtName = self:getTxt("petInfo/txtName")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._tableView = ScrollerList.create(self._tableViewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scroll = self:getScrollRect("tableview")
end

function PurchaseLimitView:onExit()
	PurchaseLimitView.super.onExit(self)
	self._petView:dispose()
	self._tableView:dispose()

	if self._loader then
		RoleObjectPool.instance:removeRole(self._loader)
	end

	MaterialMgr.resetAll(self._rare)

	for _, v in ipairs(self._contentViewList) do
		v:dispose()
	end
end

function PurchaseLimitView:onEnter()
	PurchaseLimitView.super.onEnter(self)

	self._raceIdCfg = PurchaseLimitController.instance:getRaceIds()

	if #self._raceIdCfg <= 0 then
		FloatWordMgr.instance:show("没到开启时间")
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.PurchaseLimitInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.PurchaseLimitBuyRes, self._sendInfoReq, self)

	self._activityId = self._raceIdCfg[1].activityId

	self:_sendInfoReq()

	self._petView = ScrollerList.create(self._petViewGo, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._contentViewList = {}
end

function PurchaseLimitView:_sendInfoReq()
	PurchaseLimitController.instance:sendPM_PurchaseLimitInfoReq(self._activityId)
end

function PurchaseLimitView:_refresh()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.PurchaseLimit, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))
	self._itemCfg = PurchaseLimitConfig.instance:getItemCfg(self._activityId)

	self._petView:reloadData(self._raceIdCfg)
	self._tableView:reloadData(self._itemCfg)

	self._scroll.scrollRect.verticalNormalizedPosition = 1
	self._petCfg = PurchaseLimitConfig.instance:getPetCfg(self._activityId)
	self._raceId = self._petCfg.raceId

	local x, y, scale = self._petCfg.posAndScale[1], self._petCfg.posAndScale[2], self._petCfg.posAndScale[3]

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._raceId, self._petCon, scale, nil, true, x, y)
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, self._raceId)

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)
end

function PurchaseLimitView:_updatePetCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local select = goutil.findChild(cell, "select")

	MaterialMgr.setIcon(icon, MatType.Pet, data.raceId)
	GameUtil.SetActive(select, self._activityId == data.activityId)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickPet, self, data.activityId))
end

function PurchaseLimitView:_clearPetCell(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(cell)
end

function PurchaseLimitView:_updateCell(view, cell, data)
	local tag = goutil.findChild(cell, "tag")
	local sellOut = goutil.findChild(cell, "sellOut")
	local originalIcon = goutil.findChild(cell, "txtOriginal/icon")
	local priceIcon = goutil.findChild(cell, "btnBuy/txtPrice/icon")
	local original = goutil.findChild(cell, "txtOriginal")
	local contentGo = goutil.findChild(cell, "tableview")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtLimit = goutil.findChildTextComponent(cell, "txtLimit")
	local txtOriginal = goutil.findChildTextComponent(cell, "txtOriginal")
	local txtPrice = goutil.findChildTextComponent(cell, "btnBuy/txtPrice")
	local txtTag = goutil.findChildTextComponent(cell, "tag/txt")
	local btnBuy = goutil.findChildButtonComponent(cell, "btnBuy")
	local contentView = ScrollerList.create(contentGo, self._itemcell, GameUtil.handler(self._updateContentCell, self), GameUtil.handler(self._clearContentCell, self))

	table.insert(self._contentViewList, contentView)

	local contentCfg = string.split(data.content, "#")

	contentView:dragNotifyParent()
	contentView:reloadData(contentCfg)

	local info = PurchaseLimitModel.instance:getItemInfo(data.itemId)
	local remainNum = Mathf.Clamp(data.spaceCountLimit - info.spaceBuyTimes, 0, data.spaceCountLimit)
	local spaceSellOut = remainNum <= 0
	local isSellOut = info.personBuyTimes >= data.personCountLimit

	GameUtil.SetActive(tag, not string.nilorempty(data.tagName))
	GameUtil.SetActive(original, not isSellOut and not spaceSellOut)
	GameUtil.SetActive(btnBuy.gameObject, not isSellOut and not spaceSellOut)
	GameUtil.SetActive(sellOut.gameObject, isSellOut or spaceSellOut)

	txtName.text = data.giftName
	txtLimit.text = data.spaceCountLimit >= 99999 and "不限购" or string.format("全服限购：%d/%d", remainNum, data.spaceCountLimit)
	txtTag.text = data.tagName

	local oriMatType, oriMatId, oriMatNum = MaterialMgr.getMatParams(data.originalPrice)
	local saleMatType, saleMatId, saleMatNum = MaterialMgr.getMatParams(data.salePrice)

	MaterialMgr.setIcon(originalIcon, oriMatType, oriMatId)
	MaterialMgr.setIcon(priceIcon, saleMatType, saleMatId)

	txtPrice.text = saleMatNum
	txtOriginal.text = oriMatNum

	GameUtil.addClickHandler(btnBuy, GameUtil.handler(self._onClickBuy, self, data.itemId, data))
end

function PurchaseLimitView:_clearCell(cell)
	local btnBuy = goutil.findChildButtonComponent(cell, "btnBuy")

	GameUtil.rmClickHandler(btnBuy)
end

function PurchaseLimitView:_updateContentCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function PurchaseLimitView:_clearContentCell(cell)
	MaterialMgr.resetAll(cell)
end

function PurchaseLimitView:_onClickPet(actId)
	self._activityId = actId
	self._raceId = PurchaseLimitConfig.instance:getPetCfg(self._activityId).raceId

	self:_sendInfoReq()
end

function PurchaseLimitView:_onClickPetInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function PurchaseLimitView:_onClickSkill()
	PetbookController.instance:previewBattle(self._raceId, self._raceId)
end

function PurchaseLimitView:_onClickBuy(itemId, data)
	local matType, matId, matNum = MaterialMgr.getMatParams(data.salePrice)
	local matName = MaterialMgr.getMaterialsNameByCfg(data.salePrice)
	local tips = string.format("是否确认花费<color=#eb4642>%d%s</color>购买<color=#eb4642>%s</color>吗？", matNum, matName, data.giftName)

	local function okFunc()
		PurchaseLimitController.instance:sendPM_PurchaseLimitBuyReq(self._activityId, itemId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow(lang("text_buy_tips"), tips, okFunc, cencelFunc, lang("confirm"), lang("cancel"), nil)
end

return PurchaseLimitView
