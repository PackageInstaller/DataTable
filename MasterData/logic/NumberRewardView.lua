-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberRewardView.lua

module("logic.extensions.numberbomb.view.NumberRewardView", package.seeall)

local NumberRewardView = class("NumberRewardView", ViewComponent)

function NumberRewardView:ctor()
	NumberRewardView.super.ctor(self)

	self._curScoreDatas = nil
	self._curRankDatas = nil
	self._isChoiScore = true
end

function NumberRewardView:bindEvents()
	NumberRewardView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._scoreBtn:AddClickListener(function()
		self:_onClickScoreAndRankBtn(true)
	end, self)
	self._rankBtn:AddClickListener(function()
		self:_onClickScoreAndRankBtn(false)
	end, self)
end

function NumberRewardView:unbindEvents()
	NumberRewardView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._scoreBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
end

function NumberRewardView:onExit()
	NumberRewardView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ReceiveGameSocrePrize, self._receiveGameSocrePrize, self)

	self._curScoreDatas = nil
	self._curRankDatas = nil
	self._isChoiScore = true
end

function NumberRewardView:destroyUI()
	NumberRewardView.super.destroyUI(self)
end

function NumberRewardView:buildUI()
	NumberRewardView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._titleTxt = goutil.findChildTextComponent(self.mainGO, "titleTxt")
	self._scoreBtn = self:getBtn("scoreBtn")
	self._scoreRed = self:getGo("scoreBtn/scoreRed")
	self._rankBtn = self:getBtn("rankBtn")
	self._scoreGop = self:getGo("scoreBtn"):GetComponent(ComponentType.UIChangeGroup)
	self._rankGop = self:getGo("rankBtn"):GetComponent(ComponentType.UIChangeGroup)

	self._scoreRed:SetActive(false)

	self._sacorInfoGo = self:getGo("sacorInfoGo")
	self._rankInfoGo = self:getGo("rankInfoGo")
	self._viewTipsTxt = goutil.findChildTextComponent(self.mainGO, "viewTipsTxt")
	self._viewTipsTxt.text = ""
	self._scoreSR = goutil.findChild(self._sacorInfoGo, "scoreListSR"):GetComponent("UITableview")
	self._scoreItem = goutil.findChild(self._sacorInfoGo, "scoreItem")

	self._scoreItem:SetActive(false)

	self._rankSR = goutil.findChild(self._rankInfoGo, "rankListSR"):GetComponent("UITableview")
	self._rankItem = goutil.findChild(self._rankInfoGo, "rankItem")

	self._rankItem:SetActive(false)
	self:_registCallbacks()
end

function NumberRewardView:_registCallbacks()
	self._scoreSR:RegisterCallback(self._scoreCountInView, function()
		return 878, 106
	end, self._scoreItemAtIndex, self)
	self._scoreSR:RegisterUpdateCellCallback(self._onScoreItemUpdate)
	self._rankSR:RegisterCallback(self._rankCountInView, function()
		return 878, 106
	end, self._rankItemAtIndex, self)
	self._rankSR:RegisterUpdateCellCallback(self._onRankItemUpdate)
end

function NumberRewardView:_scoreCountInView()
	if not self._curScoreDatas then
		return 0
	end

	return #self._curScoreDatas
end

function NumberRewardView:_scoreItemAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._scoreItem)

	local data = self._curScoreDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateScoreItems(view, cell, data)

	return cell
end

function NumberRewardView:_onScoreItemUpdate(view, cell)
	local idx = cell.index
	local data = self._curScoreDatas[idx + 1]

	cell.data = idx + 1

	self:_updateScoreItems(view, cell, data)
end

function NumberRewardView:_rankCountInView()
	if not self._curRankDatas then
		return 0
	end

	return #self._curRankDatas
end

function NumberRewardView:_rankItemAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rankItem)

	local data = self._curRankDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateRankItems(view, cell, data)

	return cell
end

function NumberRewardView:_onRankItemUpdate(view, cell)
	local idx = cell.index
	local data = self._curRankDatas[idx + 1]

	cell.data = idx + 1

	self:_updateRankItems(view, cell, data)
end

function NumberRewardView:onEnter()
	NumberRewardView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ReceiveGameSocrePrize, self._receiveGameSocrePrize, self)

	local isRed = NumberGameModel.instance:getGameRewardRedpoint()

	self._scoreRed:SetActive(isRed)
	self:_onClickScoreAndRankBtn(true, true)
end

function NumberRewardView:_receiveGameSocrePrize(prizeId)
	local isRed = NumberGameModel.instance:getGameRewardRedpoint()

	self._scoreRed:SetActive(isRed)

	if checknumber(prizeId) <= 0 or self._curScoreDatas == nil or #self._curScoreDatas == 0 then
		self._curScoreDatas = nil

		if self._isChoiScore then
			self:_onClickScoreAndRankBtn(true, true)
		end

		return
	end

	for i = 1, #self._curScoreDatas do
		if self._curScoreDatas[i] and self._curScoreDatas[i].prizeId == prizeId then
			self._curScoreDatas[i].isReceive = true

			break
		end
	end

	if self._isChoiScore then
		self:_onClickScoreAndRankBtn(true, true)
	end
end

function NumberRewardView:_onClickScoreAndRankBtn(isScore, isForce)
	if self._isChoiScore == isScore and not isForce then
		return
	end

	self._isChoiScore = isScore

	if self._isChoiScore then
		self._baseInfo = NumberGameModel.instance:getGameBaseInfo()
		self._titleTxt.text = "积分奖励"
		self._viewTipsTxt.text = "活动期间内，首次达到对应积分可领取奖励！"

		self._scoreGop:SetState(1)
		self._rankGop:SetState(0)

		if self._rankInfoGo and self._rankInfoGo.activeSelf then
			self._rankInfoGo:SetActive(false)
		end

		if self._sacorInfoGo and not self._sacorInfoGo.activeSelf then
			self._sacorInfoGo:SetActive(true)
		end

		if self._curScoreDatas == nil or #self._curScoreDatas == 0 then
			self._curScoreDatas = NumberGameModel.instance:getGameScoreAwardList()
		end

		self._scoreSR:ReloadData()
	else
		self._titleTxt.text = "排行奖励"
		self._viewTipsTxt.text = "此为全服排名，奖励于活动结束后通过邮件发送，名次按最终结束名次为准！"

		self._scoreGop:SetState(0)
		self._rankGop:SetState(1)

		if self._sacorInfoGo and self._sacorInfoGo.activeSelf then
			self._sacorInfoGo:SetActive(false)
		end

		if self._rankInfoGo and not self._rankInfoGo.activeSelf then
			self._rankInfoGo:SetActive(true)
		end

		if self._curRankDatas == nil or #self._curRankDatas == 0 then
			self._curRankDatas = NumberGameModel.instance:getGameRankAwardList()
		end

		self._rankSR:ReloadData()
	end
end

function NumberRewardView:_updateScoreItems(view, cell, data)
	local scoreTxt = goutil.findChildTextComponent(cell, "scoreTxt")
	local contentGo = goutil.findChild(cell, "subGoodsSR/viewport/content")
	local receiveBtnGo = goutil.findChild(cell, "receiveBtn")
	local receiveTxtGo = goutil.findChild(receiveBtnGo, "receiveTxt")
	local receiveGo = goutil.findChild(cell, "receiveGo")

	scoreTxt.text = data.needScore .. "积分"

	GameUtil.asBtn(receiveBtnGo):RemoveClickListener()

	local arrProxy = MaterialMgr.setCellListByCfg(data.prizeStr, contentGo)

	for _, item in ipairs(arrProxy) do
		Framework.TransformUtil.SetLocalScale(item.view.transform, 0.7, 0.7, 0.7)
	end

	if data.isReceive then
		GameUtil.SetActive(receiveBtnGo, false)
		receiveGo:SetActive(true)
	else
		receiveGo:SetActive(false)
		GameUtil.SetActive(receiveBtnGo, true)

		if data.needScore <= checknumber(self._baseInfo.maxScore) then
			uGuiUtil.setImageGrayState(receiveBtnGo, false)
			uGuiUtil.setTextGrayState(receiveTxtGo, false)
		else
			uGuiUtil.setImageGrayState(receiveBtnGo, true)
			uGuiUtil.setTextGrayState(receiveTxtGo, true)
		end

		local prizeId = data.prizeId

		GameUtil.asBtn(receiveBtnGo):AddClickListener(function()
			self:_onClickReceiveBtn(prizeId)
		end, self)
	end
end

function NumberRewardView:_onClickReceiveBtn(prizeId)
	if self._baseInfo == nil or self._curScoreDatas == nil then
		FloatWordMgr.instance:show("积分不足！")

		return
	end

	local needScore = 0

	prizeId = checknumber(prizeId)

	for i = 1, #self._curScoreDatas do
		if self._curScoreDatas[i] and self._curScoreDatas[i].prizeId == prizeId then
			needScore = self._curScoreDatas[i].needScore

			break
		end
	end

	if needScore <= 0 or needScore > checknumber(self._baseInfo.maxScore) then
		FloatWordMgr.instance:show("积分不足！")

		return
	end

	NumberGameController.instance:csReceiveGameSocrePrizeReq(prizeId)
end

function NumberRewardView:_updateRankItems(view, cell, data)
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local goodsItemList = {
		goutil.findChild(cell, "goodsItem_1"),
		goutil.findChild(cell, "goodsItem_2"),
		goutil.findChild(cell, "goodsItem_3"),
		goutil.findChild(cell, "goodsItem_4"),
		goutil.findChild(cell, "goodsItem_5"),
		goutil.findChild(cell, "goodsItem_6")
	}

	for i = 1, #goodsItemList do
		if goodsItemList[i] then
			MaterialMgr.resetAll(goodsItemList[i])
		end
	end

	rankTxt.text = data.rankDes

	if data.goodsList and #data.goodsList > 0 then
		for i = 1, #data.goodsList do
			local list = string.split(data.goodsList[i], ":")

			if list and #list > 1 and goodsItemList[i] then
				local matLua = MaterialMgr.setCell(list[1], list[2], goodsItemList[i])

				matLua.binder:setNum((checknumber(list[3]) > 0 or nil) and checknumber(list[3]))
			end
		end
	end
end

return NumberRewardView
