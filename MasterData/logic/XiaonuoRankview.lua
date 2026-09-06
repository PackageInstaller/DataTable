-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/XiaonuoRankview.lua

module("logic.extensions.idlegame.view.XiaonuoRankview", package.seeall)

local XiaonuoRankview = class("XiaonuoRankview", TableViewComponent)

function XiaonuoRankview:ctor()
	XiaonuoRankview.super.ctor(self)
end

function XiaonuoRankview:buildUI()
	XiaonuoRankview.super.buildUI(self)

	self._btnClose2 = self:getBtn("btnClose2")
	self._txtMyRankValue = goutil.findChildTextComponent(self.mainGO, "txtMyRank/value")
end

function XiaonuoRankview:bindEvents()
	XiaonuoRankview.super.bindEvents(self)
	self._btnClose2:AddClickListener(self._onClickBtnClose, self)
end

function XiaonuoRankview:unbindEvents()
	XiaonuoRankview.super.unbindEvents(self)
	self._btnClose2:RemoveClickListener()
end

function XiaonuoRankview:destroyUI()
	XiaonuoRankview.super.destroyUI(self)
end

function XiaonuoRankview:onEnter()
	XiaonuoRankview.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.RankDataGet, self._refresh, self)
	IdleGameController.instance:sendReqRankData()
end

function XiaonuoRankview:onEnterFinished()
	XiaonuoRankview.super.onEnterFinished(self)
end

function XiaonuoRankview:onExit()
	XiaonuoRankview.super.onExit(self)
end

function XiaonuoRankview:onExitFinished()
	XiaonuoRankview.super.onExitFinished(self)
	GlobalDispatcher:removeListener(GlobalNotify.RankDataGet, self._refresh, self)
end

function XiaonuoRankview:_onClickBtnClose()
	self:close()
end

function XiaonuoRankview:_getPath()
	return {
		cellPath = "rankCell",
		viewPath = "ranktableview"
	}
end

function XiaonuoRankview:_cellSize()
	return 1100, 110
end

function XiaonuoRankview:_updateCell(view, cell, data)
	local _txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")

	_txtRank.text = data.rank

	local _txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	_txtName.text = data.headInfo.userName

	local _txtFamily = goutil.findChildTextComponent(cell.gameObject, "txtFamily")

	_txtFamily.text = data.familyName

	local _txtTotalMoney = goutil.findChildTextComponent(cell.gameObject, "xiaonuobian/txtTotalMoney")

	_txtTotalMoney.text = data.totalMoney
end

function XiaonuoRankview:_refresh()
	local data = IdleGameModel.instance:getRankData()

	self._curViewDatas = data.infos
	self._txtMyRankValue.text = data.rank == -1 and "未上榜" or data.rank

	self._tableview:ReloadData()
end

return XiaonuoRankview
