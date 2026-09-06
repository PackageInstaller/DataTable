-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanrankView.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanrankView", package.seeall)

local SixartdaoguanrankView = class("SixartdaoguanrankView", ViewComponent)

function SixartdaoguanrankView:ctor()
	SixartdaoguanrankView.super.ctor(self)
end

function SixartdaoguanrankView:unbindEvents()
	SixartdaoguanrankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SixartdaoguanrankView:bindEvents()
	SixartdaoguanrankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function SixartdaoguanrankView:buildUI()
	SixartdaoguanrankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getTxt("rankCol/myRank/txtTime")
	self._txtMyRank = self:getTxt("rankCol/myRank/txtMyRank")
	self._tableviewGo = self:getGo("rankCol/tableview")
	self._cellGo = self:getGo("rankCol/cell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = self:getGo("rankCol/empty")
end

function SixartdaoguanrankView:onExit()
	SixartdaoguanrankView.super.onExit(self)
	self._scrollerList:dispose()
end

function SixartdaoguanrankView:onEnter()
	SixartdaoguanrankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SixArtDaoguanRankRes, self._onSixArtDaoguanRankRes, self)

	self._activityId = self:getFirstParam()

	SixArtDaoguanAgent.instance:sendPM_SixArtDaoguanRankReq(self._activityId)
end

function SixartdaoguanrankView:_onClickbtnClose()
	self:close()
end

function SixartdaoguanrankView:_updateUI()
	if not self._rankMsg then
		return
	end

	self:_updateRanks()
	self:_updateMyRank()
end

function SixartdaoguanrankView:_updateCell(view, cell, data, tag)
	local goHead = goutil.findChild(cell.gameObject, "head")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtArea = goutil.findChildTextComponent(cell.gameObject, "txtArea")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")
	local rewardScroll = self:_getRewardScrollList(goTableview, goTablecell)

	HeadItemController.instance:resetHeadCell(goHead)
	HeadItemController.instance:setHeadCellByInfo(goHead, data.headInfo, true)

	local date = GameUtil.time2date(checknumber(data.time) / 1000)
	local isTop3 = data.rank <= 3

	if isTop3 then
		imgChangeImgRank:SetState(data.rank - 1)
		goutil.setActive(imgChangeImgRank.gameObject, true)

		txtRank.text = ""
	else
		goutil.setActive(imgChangeImgRank.gameObject, false)

		txtRank.text = data.rank
	end

	txtArea.text = data.headInfo.areaName
	txtName.text = data.headInfo.userName
	txtTime.text = string.format("%s.%2d.%2d\n%2d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)

	local cfg = SixartdaoguanConfig.instance:getRankPrizeCfg(self._activityId, data.rank)

	rewardScroll:reloadData((cfg or nil) and string.split(cfg.prize, "#"))
end

function SixartdaoguanrankView:_clearCell(cell)
	local tableview = goutil.findChild(cell.gameObject, "tableview")

	self:_disposeRewardScrollList(tableview)
end

function SixartdaoguanrankView:_getRewardScrollList(tableview, tablecell)
	self._rewardSrolls = self._rewardSrolls or {}

	if not self._rewardSrolls[tableview] then
		local scroller

		self._rewardSrolls[tableview] = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	end

	return self._rewardSrolls[tableview]
end

function SixartdaoguanrankView:_disposeRewardScrollList(tableview)
	if self._rewardSrolls[tableview] then
		self._rewardSrolls[tableview]:dispose()

		self._rewardSrolls[tableview] = nil
	end
end

function SixartdaoguanrankView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function SixartdaoguanrankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function SixartdaoguanrankView:_onSixArtDaoguanRankRes(msg)
	self._rankMsg = msg

	self:_updateUI()
end

function SixartdaoguanrankView:_updateRanks()
	self._scrollerList:reloadData(self._rankMsg.rankInfos)
	goutil.setActive(self._emptyGo, not self._rankMsg.rankInfos or #self._rankMsg.rankInfos <= 0)
end

function SixartdaoguanrankView:_updateMyRank()
	local myRank = checknumber(self._rankMsg.myRank)

	self._txtMyRank.text = myRank <= 0 and "未上榜" or string.format("第%s名", myRank)

	local myRankInfo
	local userId = checknumber(RoleModel.instance:getUserId())

	for i, v in ipairs(self._rankMsg.rankInfos) do
		if checknumber(v.headInfo.userId) == userId then
			myRankInfo = v

			break
		end
	end

	if myRankInfo then
		local date = GameUtil.time2date(checknumber(myRankInfo.time) / 1000)

		self._txtTime.text = string.format("%s.%2d.%2d %2d:%2d:%2d", date.year, date.month, date.day, date.hour, date.min, date.sec)
	else
		self._txtTime.text = "暂无"
	end
end

return SixartdaoguanrankView
