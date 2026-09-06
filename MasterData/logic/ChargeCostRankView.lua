-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatecharge/view/ChargeCostRankView.lua

module("logic.extensions.accumulatecharge.view.ChargeCostRankView", package.seeall)

local ChargeCostRankView = class("ChargeCostRankView", ViewComponent)

function ChargeCostRankView:buildUI()
	ChargeCostRankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goCell = self:getGo("right/cell")
	self._goTableView = self:getGo("right/tableview")
	self._tableview = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._myRankTxt = self:getTxt("right/myRank/txtMyRank")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtTip = self:getTxt("right/description/txtTip")
end

function ChargeCostRankView:bindEvents()
	ChargeCostRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ChargeCostRankView:unbindEvents()
	ChargeCostRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ChargeCostRankView:onEnter()
	ChargeCostRankView.super.onEnter(self)

	local params = self:getOpenParam()
	local actId = checkint(params[2])
	local rankType = checkint(params[1])

	AccumulateChargeController.instance:getRankInfo(rankType, actId)
	GlobalDispatcher:addListener(GlobalNotify.CampaignConsumeGetInfoRes, self.refreshView, self)

	self._txtTip.text = rankType == 1 and langPara("消费神钻") or langPara("充值金额")
end

function ChargeCostRankView:onExit()
	ChargeCostRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CampaignConsumeGetInfoRes, self.refreshView, self)
	self._tableview:dispose()
end

function ChargeCostRankView:refreshView()
	local infos, myRank = AccumulateChargeModel.instance:getRankInfo()

	self._tableview:reloadData(infos)

	if infos and #infos > 0 then
		goutil.setActive(self._goEmpty, false)
	else
		goutil.setActive(self._goEmpty, true)
	end

	self._myRankTxt.text = myRank <= 0 and lang("未上榜") or myRank
end

function ChargeCostRankView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtName.text = data.headInfo.userName
	cell.txtServer.text = data.areaName
	cell.txtNum.text = data.cost or data.money

	if data.rank > 3 then
		goutil.setActive(cell.txtRank.gameObject, true)
		goutil.setActive(cell.imgRank.gameObject, false)

		cell.txtRank.text = data.rank
	else
		goutil.setActive(cell.txtRank.gameObject, false)
		goutil.setActive(cell.imgRank.gameObject, true)
		cell.imgRank:SetState(data.rank - 1)
	end

	HeadItemController.instance:setHeadCellByInfo(cell.icon, data.headInfo)
	GameUtil.addClickHandler(cell.btnIcon, function()
		local userId = data.headInfo.userId

		if userId == RoleModel.instance:getUserId() then
			RoleController.instance:openMyInfoCard()
		else
			RoleController.instance:openCardByUserId(data.headInfo.userId)
		end
	end)
end

function ChargeCostRankView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.imgRank = goutil.findChildComponent(cell.go, "imgRank", "UIImageSpriteChange")
	cell.icon = goutil.findChild(cell.go, "imgIcon")
	cell.btnIcon = goutil.findChild(cell.go, "btnIcon")
	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtServer = goutil.findChildTextComponent(cell.go, "txtServer")
	cell.txtRank = goutil.findChildTextComponent(cell.go, "txtRank")

	HeadItemController.instance:resetHeadCell(cell.icon)

	return cell
end

return ChargeCostRankView
