-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleRankView.lua

module("logic.extensions.scuffle.view.ScuffleRankView", package.seeall)

local ScuffleRankView = class("ScuffleRankView", TableViewComponent)

function ScuffleRankView:ctor()
	ScuffleRankView.super.ctor(self)
end

function ScuffleRankView:buildUI()
	ScuffleRankView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
end

function ScuffleRankView:bindEvents()
	ScuffleRankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ScuffleRankView:unbindEvents()
	ScuffleRankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function ScuffleRankView:onEnter()
	ScuffleRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SF_GetRankInfoRes, self._onGetRankInfoRes, self)
	self:_initView()
	self:_updateRankList()
	ScuffleAgent.instance:sendSF_GetRankInfoReq()
end

function ScuffleRankView:onExit()
	ScuffleRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_GetRankInfoRes, self._onGetRankInfoRes, self)
end

function ScuffleRankView:_onClickClose()
	self:close()
end

function ScuffleRankView:_onGetRankInfoRes()
	self:_initView()
	self:_updateRankList()
end

function ScuffleRankView:_initView()
	self._txtTip.text = "1.此为全服务器排名，榜单每10分钟更新一次\n2.只会显示前100名的奥奇"
	self._txtMyRank.text = ScuffleModel.instance:getMyRank()

	self:_setGoEmpty(false)
end

function ScuffleRankView:_updateRankList()
	local list = ScuffleModel.instance:getRankList()

	self:updateListData(list)
	self:_setGoEmpty(#list == 0)
end

function ScuffleRankView:_getPath()
	return {
		cellPath = "right/cell",
		viewPath = "right/rankScrollRect"
	}
end

function ScuffleRankView:_cellSize()
	return 1084, 108
end

function ScuffleRankView:_updateCell(view, cell, data)
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtFamily = goutil.findChildTextComponent(cell, "txtFamily")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local imgRank = goutil.findChild(cell, "imgRank"):GetComponent(typeof(UIImageSpriteChange))

	HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo)

	txtRank.text = data.rank
	txtName.text = data.headInfo.userName
	txtFamily.text = data.familyName
	txtScore.text = data.score
	txtArea.text = data.areaName

	goutil.setActive(imgRank.gameObject, data.rank <= 3)

	if data.rank <= 3 then
		imgRank:SetState(data.rank - 1)
	end
end

function ScuffleRankView:_clearTableview(cell)
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")

	MaterialMgr.resetAll(imgHeadIcon)
end

function ScuffleRankView:_setGoEmpty(isActive)
	self._goEmpty:SetActive(isActive)
end

return ScuffleRankView
