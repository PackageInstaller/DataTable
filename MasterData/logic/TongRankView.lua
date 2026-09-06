-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongRankView.lua

module("logic.extensions.tongbattle.view.TongRankView", package.seeall)

local TongRankView = class("TongRankView", ViewComponent)

function TongRankView:ctor()
	TongRankView.super.ctor(self)

	self._curLeftDatas = nil
	self._curRightDatas = nil
end

function TongRankView:bindEvents()
	TongRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function TongRankView:unbindEvents()
	TongRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function TongRankView:onExit()
	TongRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateTongRankInfo, self._updataRankItemListShow, self)

	self._curLeftDatas = nil
	self._curRightDatas = nil
end

function TongRankView:destroyUI()
	TongRankView.super.destroyUI(self)
end

function TongRankView:buildUI()
	TongRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._leftListSR = self:getGo("tabListSR"):GetComponent("UITableview")
	self._leftItem = self:getGo("tabItme")

	self._leftItem:SetActive(false)

	local rightInfoGo = self:getGo("rightInfoGo")

	self._rightListSR = goutil.findChild(rightInfoGo, "rankListSR"):GetComponent("UITableview")
	self._rightItem = goutil.findChild(rightInfoGo, "rankItem")

	self._rightItem:SetActive(false)

	self._emptyGo = goutil.findChild(rightInfoGo, "emptyGo")

	local myRankGo = goutil.findChild(rightInfoGo, "myRankGo")

	self._myRankTxt = goutil.findChildTextComponent(myRankGo, "myRankTxt")
	self._rankDescTxt = goutil.findChildTextComponent(myRankGo, "rankDescTxt")
	self._myRankTxt.text = ""
	self._rankDescTxt.text = ""

	self._emptyGo:SetActive(false)
	self:registCallbacks()
end

function TongRankView:registCallbacks()
	self._leftListSR:RegisterCallback(self._LeftInView, function()
		return 170, 65
	end, self._LeftAtIndex, self)
	self._leftListSR:RegisterUpdateCellCallback(self._OnLeftCellUpdate)
	self._rightListSR:RegisterCallback(self._RightInView, function()
		return 1070, 110
	end, self._RightAtIndex, self)
	self._rightListSR:RegisterUpdateCellCallback(self._OnRightCellUpdate)
end

function TongRankView:_LeftInView()
	if not self._curLeftDatas then
		return 0
	end

	return #self._curLeftDatas
end

function TongRankView:_LeftAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._leftItem)

	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateLeftCell(view, cell, data)

	return cell
end

function TongRankView:_OnLeftCellUpdate(view, cell)
	local index = cell.index
	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1

	self:_UpdateLeftCell(view, cell, data)
end

function TongRankView:_RightInView()
	if not self._curRightDatas then
		return 0
	end

	return #self._curRightDatas
end

function TongRankView:_RightAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rightItem)

	local data = self._curRightDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateRightCell(view, cell, data)

	return cell
end

function TongRankView:_OnRightCellUpdate(view, cell)
	local index = cell.index
	local data = self._curRightDatas[index + 1]

	cell.data = index + 1

	self:_UpdateRightCell(view, cell, data)
end

function TongRankView:onEnter()
	TongRankView.super.onEnter(self)

	self._isRankComm = self:getFirstParam()

	GlobalDispatcher:addListener(GlobalNotify.UpdateTongRankInfo, self._updataRankItemListShow, self)

	self._curLeftDatas = TongBattleModel.instance:getTongRankTabList()

	self:_updataRankItemListShow()
end

function TongRankView:_updataRankItemListShow()
	self._leftListSR:ReloadData()

	local rankInfo = TongBattleModel.instance:getPlayerRankInfo(self._isRankComm)

	self._curRightDatas = {}
	self._rankDescTxt.text = self._isRankComm and lang("text_tong_rank_1") or lang("text_tong_rank_2")

	if rankInfo then
		self._curRightDatas = rankInfo.infoList
		self._myRankTxt.text = checknumber(rankInfo.myRank) <= 0 and lang("text_rank_notrank") or tostring(rankInfo.myRank)
	else
		self._myRankTxt.text = lang("text_rank_notrank")
	end

	if self._curRightDatas == nil or #self._curRightDatas == 0 then
		self._emptyGo:SetActive(true)
	else
		self._emptyGo:SetActive(false)
	end

	self._rightListSR:ReloadData()
end

function TongRankView:_UpdateLeftCell(view, cell, data)
	local iconIma = cell:GetComponent("UIImageSpriteChange")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")

	GameUtil.asBtn(cell):RemoveClickListener()

	local num = self._isRankComm and 1 or 2
	local index = cell.data

	if num == index then
		iconIma:SetState(1)
	else
		iconIma:SetState(0)
	end

	nameTxt.text = data

	GameUtil.asBtn(cell):AddClickListener(function()
		if num == index then
			return
		end

		self._isRankComm = not self._isRankComm

		self:_updataRankItemListShow()
	end, self)
end

function TongRankView:_UpdateRightCell(view, cell, data)
	local rankIma = goutil.findChild(cell, "rankIma"):GetComponent("UIImageSpriteChange")
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local headBtnGo = goutil.findChild(cell, "headBtn")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local familyTxt = goutil.findChildTextComponent(cell, "familyTxt")
	local timerTxt = goutil.findChildTextComponent(cell, "timerTxt")

	MaterialMgr.resetAll(headGo)
	GameUtil.asBtn(headGo):RemoveClickListener()

	local rankNum = checknumber(data.rank)

	if rankNum <= 3 then
		GameUtil.SetActive(rankIma, true)
		rankIma:SetState(rankNum - 1)

		rankTxt.text = ""
	else
		GameUtil.SetActive(rankIma, false)

		rankTxt.text = tostring(data.rank)
	end

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

	nameTxt.text = data.headInfo.userName
	familyTxt.text = string.nilorempty(data.familyName) and "无" or data.familyName

	local timer = GameUtil.time2date(data.gainTime / 1000)

	timerTxt.text = string.format(lang("text_timeinfo"), timer.month, timer.day, timer.hour, timer.min, timer.sec)

	GameUtil.addClickHandler(headBtnGo, GameUtil.handler(self._onClickHeadItem, self, data.headInfo.userId, headBtnGo))
end

function TongRankView:_onClickHeadItem(userId, go)
	FriendController.instance:showInfoView(userId, go)
end

return TongRankView
