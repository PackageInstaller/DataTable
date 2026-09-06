-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectBlessingPublishView.lua

module("logic.extensions.birthdaywishes.view.CollectBlessingPublishView", package.seeall)

local CollectBlessingPublishView = class("CollectBlessingPublishView", ViewComponent)

function CollectBlessingPublishView:ctor()
	CollectBlessingPublishView.super.ctor(self)
end

function CollectBlessingPublishView:unbindEvents()
	CollectBlessingPublishView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCanel)
end

function CollectBlessingPublishView:bindEvents()
	CollectBlessingPublishView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCanel, self._onClickClose, self)
end

function CollectBlessingPublishView:buildUI()
	CollectBlessingPublishView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._btnCanel = self:getBtn("btnCancel")
	self._tableview = self:getGo("ScrollView")
	self._tablecell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function CollectBlessingPublishView:onExit()
	CollectBlessingPublishView.super.onExit(self)
	self._scrollList:dispose()
end

function CollectBlessingPublishView:onEnter()
	CollectBlessingPublishView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._cfgs = BirthdayWishesConfig.instance:getBirthdayWishesBaseCfg(self._activityId)
	self._curSelect = 1

	self:_reloadData()
end

function CollectBlessingPublishView:_reloadData()
	local prizeCfgs = BirthdayWishesConfig.instance:getBirthdayWishesListCfgs(self._cfgs.wishlistPlanId)

	self._scrollList:reloadData(prizeCfgs)
end

function CollectBlessingPublishView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)
	local type, id, num = MaterialMgr.getMatParams(BirthdayWishesConfig.instance:getTokenCfgByTokenId(data.tokenId).reward)
	local materialName = MaterialMgr.getMaterialsName(type, id)
	local myNum = MaterialModel.instance:getMaterialsNumber(type, id)

	MaterialMgr.setCell(type, id, cell.item)
	GameUtil.SetActive(cell.select, data.id == self._curSelect)

	cell.txtCount.text = langPara("拥有:%s个", myNum)
	cell.txtName.text = materialName .. "x1"

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickPrize, self, data.id))
end

function CollectBlessingPublishView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.select = goutil.findChild(cell.go, "imgSelect")
	cell.selected = goutil.findChild(cell.go, "imgSelected")
	cell.item = goutil.findChild(cell.go, "item")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtCount = goutil.findChildTextComponent(cell.go, "txtCount")

	MaterialMgr.resetAll(cell)
	GameUtil.rmClickHandler(cell.go)

	return cell
end

function CollectBlessingPublishView:_onClickClose()
	self:close()
end

function CollectBlessingPublishView:_onClickPrize(prizeId)
	self._curSelect = prizeId

	self._scrollList:refresh()
end

function CollectBlessingPublishView:_onClickSure()
	local function okFunc()
		BirthdayWishesController.instance:sendBirthdayWishesPutOutWishListReq(self._activityId, self._curSelect)
		TipsFacade.instance:openCommonTips("心愿单发布成功~")
		self:close()
	end

	local fuName = BirthdayWishesConfig.instance:getBirthdayWishesListCfgsById(self._cfgs.wishlistPlanId, self._curSelect).wishListName
	local CD = self._cfgs.wishListCD
	local content = string.format("是否确认选择%s作为心愿？\n注：心愿单发布后%d分钟内不能再次发布。", fuName, CD)

	TipsFacade.instance:openPopupWindow("提示", content, okFunc, nil, "确定", "取消")
end

return CollectBlessingPublishView
