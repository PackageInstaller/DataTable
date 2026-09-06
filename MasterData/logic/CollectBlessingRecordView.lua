-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectBlessingRecordView.lua

module("logic.extensions.birthdaywishes.view.CollectBlessingRecordView", package.seeall)

local CollectBlessingRecordView = class("CollectBlessingRecordView", ViewComponent)
local TabType = {
	WishListRecord = 2,
	GiveRecord = 1
}

function CollectBlessingRecordView:ctor()
	CollectBlessingRecordView.super.ctor(self)
end

function CollectBlessingRecordView:unbindEvents()
	CollectBlessingRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, v in ipairs(self._btnTab) do
		GameUtil.rmClickHandler(v.go)
	end
end

function CollectBlessingRecordView:bindEvents()
	CollectBlessingRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)

	for i, v in ipairs(self._btnTab) do
		GameUtil.addClickHandler(v.go, GameUtil.handler(self._onClickTab, self, i))
	end
end

function CollectBlessingRecordView:buildUI()
	CollectBlessingRecordView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._emptyGo = self:getGo("emptyGo")
	self._btnTab = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("btn_" .. i)
		cell.select = goutil.findChild(cell.go, "select")

		table.insert(self._btnTab, cell)
	end

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function CollectBlessingRecordView:onExit()
	CollectBlessingRecordView.super.onExit(self)
	self._scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBirthdayWishesReceived, self._reloadData, self)
	GlobalDispatcher:removeListener(GlobalNotify.WishListRecordRes, self._reloadData, self)
end

function CollectBlessingRecordView:onEnter()
	CollectBlessingRecordView.super.onEnter(self)

	self._userId = RoleModel.instance:getUserId()

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._cfgs = BirthdayWishesConfig.instance:getBirthdayWishesBaseCfg(self._activityId)
	self._curType = TabType.GiveRecord

	self:_onClickTab(TabType.GiveRecord)
	GlobalDispatcher:addListener(GlobalNotify.UpdataBirthdayWishesReceived, self._reloadData, self)
	GlobalDispatcher:addListener(GlobalNotify.WishListRecordRes, self._reloadData, self)
	BirthdayWishesController.instance:csGetBirthdayWishesGiveAndGetRecordReq(self._activityId)
	BirthdayWishesController.instance:sendBirthdayWishesGetWishListRecordReq(self._activityId)
end

function CollectBlessingRecordView:_reloadData()
	local list = {}

	list = self._curType == TabType.GiveRecord and BirthdayWishesModel.instance:getRecordInfos() or BirthdayWishesModel.instance:getWishListRecordInfos()

	self._scrollList:reloadData(list)
	GameUtil.SetActive(self._emptyGo, #list == 0)
end

function CollectBlessingRecordView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)
	local time = GameUtil.time2date(checknumber(data.time) / 1000)

	cell.txtTime.text = langPara("text_timeinfo", time.month, time.day, time.hour, time.min, time.sec)

	if self._curType == TabType.GiveRecord then
		local cfg = BirthdayWishesConfig.instance:getTokenCfgByTokenId(data.tokenId)
		local name, count = "信物", 1

		if cfg and not string.nilorempty(cfg.reward) then
			name = MaterialMgr.getMaterialsNameByCfg(cfg.reward)

			local matType, matId, matNum = MaterialMgr.getMatParams(cfg.reward)

			count = matNum
		end

		cell.txtDesc.text = self._userId == data.sendId and string.format("您将[%s*%s]赠送给了[%s]", name, count, data.recvName) or string.format("[%s]赠送给您[%s*%s]", data.sendName, name, count)
	elseif data.finishUserId ~= self._userId then
		local fuName = BirthdayWishesConfig.instance:getBirthdayWishesListCfgsById(self._cfgs.wishlistPlanId, data.wishListId).wishListName

		cell.txtDesc.text = string.format("该心愿单已被好友【%s】实现，您获得%s*1！", data.finishUserName, fuName)
	end
end

function CollectBlessingRecordView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "descTxt")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "timeTxt")

	return cell
end

function CollectBlessingRecordView:_onClickClose()
	self:close()
end

function CollectBlessingRecordView:_onClickTab(idx)
	for i, v in ipairs(self._btnTab) do
		GameUtil.SetActive(v.select, idx == i)
	end

	self._curType = idx

	self:_reloadData()
end

return CollectBlessingRecordView
