-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/GiftRecordsPopup.lua

module("logic.extensions.birthdaywishes.view.GiftRecordsPopup", package.seeall)

local GiftRecordsPopup = class("GiftRecordsPopup", TableViewComponent)

function GiftRecordsPopup:ctor()
	GiftRecordsPopup.super.ctor(self)
end

function GiftRecordsPopup:onExit()
	GiftRecordsPopup.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBirthdayWishesReceived, self._updataGiftRecordsItem, self)
end

function GiftRecordsPopup:destroyUI()
	GiftRecordsPopup.super.destroyUI(self)
end

function GiftRecordsPopup:bindEvents()
	GiftRecordsPopup.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function GiftRecordsPopup:unbindEvents()
	GiftRecordsPopup.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function GiftRecordsPopup:buildUI()
	GiftRecordsPopup.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._emptyGo = self:getGo("emptyGo")

	GameUtil.SetActive(self._emptyGo, false)
end

function GiftRecordsPopup:onEnter()
	GiftRecordsPopup.super.onEnter(self)

	self._userId = RoleModel.instance:getUserId()

	GlobalDispatcher:addListener(GlobalNotify.UpdataBirthdayWishesReceived, self._updataGiftRecordsItem, self)
	BirthdayWishesController.instance:csGetBirthdayWishesGiveAndGetRecordReq(self:getFirstParam())
end

function GiftRecordsPopup:_updataGiftRecordsItem(list)
	self._curViewDatas = list or {}

	self:reloadData()
	GameUtil.SetActive(self._emptyGo, #self._curViewDatas == 0)
end

function GiftRecordsPopup:_getPath()
	return {
		cellPath = "itemCell",
		viewPath = "itemListSR"
	}
end

function GiftRecordsPopup:_updateCell(view, cell, data)
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")
	local cfg = BirthdayWishesConfig.instance:getTokenCfgByTokenId(data.tokenId)
	local name, count = "信物", 1

	if cfg and not string.nilorempty(cfg.reward) then
		name = MaterialMgr.getMaterialsNameByCfg(cfg.reward)

		local matType, matId, matNum = MaterialMgr.getMatParams(cfg.reward)

		count = matNum
	end

	descTxt.text = self._userId == data.sendId and string.format("您将[%s*%s]赠送给了[%s]", name, count, data.recvName) or string.format("[%s]赠送给您[%s*%s]", data.sendName, name, count)

	local time = GameUtil.time2date(checknumber(data.time) / 1000)

	timeTxt.text = langPara("text_timeinfo", time.month, time.day, time.hour, time.min, time.sec)
end

return GiftRecordsPopup
