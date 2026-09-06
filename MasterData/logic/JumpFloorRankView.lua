-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorRankView.lua

module("logic.extensions.jumpfloor.view.JumpFloorRankView", package.seeall)

local JumpFloorRankView = class("JumpFloorRankView", ViewComponent)

function JumpFloorRankView:ctor()
	JumpFloorRankView.super.ctor(self)
end

function JumpFloorRankView:buildUI()
	JumpFloorRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._scrollerGo = self:getGo("rankCol/tableview")
	self._cellGo = self:getGo("rankCol/cell")
	self._scrollList = ScrollerList.create(self._scrollerGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function JumpFloorRankView:bindEvents()
	JumpFloorRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function JumpFloorRankView:unbindEvents()
	JumpFloorRankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function JumpFloorRankView:onEnter()
	JumpFloorRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DancingLionJumpGetRankRes, self._onGetRankRes, self)

	self._activityId = self:getFirstParam()

	self:_updateEmptyGo()
	self:_updateMyRank()
	JumpFloorAgent.instance:sendPM_DancingLionJumpGetRankReq(self._activityId)
end

function JumpFloorRankView:onExit()
	JumpFloorRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DancingLionJumpGetRankRes, self._onGetRankRes, self)
	self._scrollList:dispose()
end

function JumpFloorRankView:_updateCell(view, cell, data, tag)
	local imgRankChange = goutil.findChildComponent(cell, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local isShowRankImage = data.rank <= 3

	goutil.setActive(imgRankChange.gameObject, isShowRankImage)
	goutil.setActive(txtRank.gameObject, not isShowRankImage)

	if isShowRankImage then
		imgRankChange:SetState(data.rank - 1)
	else
		txtRank.text = data.rank
	end

	HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo)

	txtName.text = data.headInfo.userName
	txtArea.text = data.areaName
	txtScore.text = data.value
end

function JumpFloorRankView:_clearCell(cell)
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgHeadIcon)
end

function JumpFloorRankView:_onGetRankRes()
	self:_updateEmptyGo()
	self:_updateMyRank()
	self:_initRankCells()
end

function JumpFloorRankView:_initRankCells()
	local datas = JumpFloorModel.instance:getRankList()

	self._scrollList:reloadData(datas)
end

function JumpFloorRankView:_updateEmptyGo()
	local datas = JumpFloorModel.instance:getRankList()

	goutil.setActive(self._emptyGo, #datas == 0)
end

function JumpFloorRankView:_updateMyRank()
	local rank = JumpFloorModel.instance:getMyRank()

	self._txtMyRank.text = rank > 0 and rank or lang("text_rank_notrank")
end

return JumpFloorRankView
