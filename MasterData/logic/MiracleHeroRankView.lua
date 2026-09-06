-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroRankView.lua

module("logic.extensions.miraclehero.view.MiracleHeroRankView", package.seeall)

local MiracleHeroRankView = class("MiracleHeroRankView", ViewComponent)

function MiracleHeroRankView:ctor()
	MiracleHeroRankView.super.ctor(self)
end

function MiracleHeroRankView:unbindEvents()
	MiracleHeroRankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function MiracleHeroRankView:bindEvents()
	MiracleHeroRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function MiracleHeroRankView:buildUI()
	MiracleHeroRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._empty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")

	local cellGo = self:getGo("right/rankCell")
	local tableviewGo = self:getGo("right/rankListView")

	self._tableView = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function MiracleHeroRankView:onExit()
	MiracleHeroRankView.super.onExit(self)
	self._tableView:dispose()
end

function MiracleHeroRankView:onEnter()
	MiracleHeroRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	MiracleHeroController.instance:sendPM_MiracleHeroRankInfoReq(self._activityId)
	self.addGEvent(self, GlobalNotify.MiracleHeroGetRankInfoRes, self._updateUIByInfo, self)
	self:_updateUIByInfo()
end

function MiracleHeroRankView:_updateUIByInfo()
	local infos = MiracleHeroModel.instance:getRankInfos(self._activityId)
	local myRank = MiracleHeroModel.instance:getMyRank(self._activityId)

	goutil.setActive(self._empty, #infos == 0)
	self._tableView:reloadData(infos)

	self._txtMyRank.text = myRank <= 0 and "未上榜" or myRank
end

function MiracleHeroRankView:_updateRankCell(view, cellGo, data)
	local cell = self:_clearRankCell(cellGo)

	if data then
		cell.txtRank.text = data.rank

		HeadItemController.instance:setHeadCellByInfo(cell.headIcon, data.headInfo)

		cell.txtName.text = data.headInfo.userName
		cell.txtArea.text = data.headInfo.areaName

		local time = GameUtil.time2date(checknumber(data.time) / 1000)

		cell.txtTime.text = string.format("%d.%02d.%02d  %02d:%02d:%02d", time.year, time.month, time.day, time.hour, time.min, time.sec)

		local cfgStr = MiracleHeroConfig.instance:getRankPrizeStrByRank(self._activityId, data.rank)

		MaterialMgr.setCellListByCfg(cfgStr, cell.prizeCon)
	end
end

function MiracleHeroRankView:_clearRankCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.txtRank = goutil.findChildTextComponent(cell.go, "txtRank")
	cell.headIcon = goutil.findChild(cell.go, "headIcon")

	HeadItemController.instance:resetHeadCell(cell.headIcon)

	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtArea = goutil.findChildTextComponent(cell.go, "txtArea")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")
	cell.prizeCon = goutil.findChild(cell.go, "prizeCon")

	MaterialMgr.resetAll(cell.prizeCon)

	return cell
end

return MiracleHeroRankView
