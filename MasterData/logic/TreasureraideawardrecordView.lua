-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideawardrecordView.lua

module("logic.extensions.treasureraider.view.TreasureraideawardrecordView", package.seeall)

local TreasureraideawardrecordView = class("TreasureraideawardrecordView", ViewComponent)

function TreasureraideawardrecordView:ctor()
	TreasureraideawardrecordView.super.ctor(self)
end

function TreasureraideawardrecordView:unbindEvents()
	TreasureraideawardrecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTipEmptyInReward)
	self._emptyTipUiCustonInput:RemoveListener()
end

function TreasureraideawardrecordView:bindEvents()
	TreasureraideawardrecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTipEmptyInReward, self._onClickBtnShowEmptyTips, self)
	self._emptyTipUiCustonInput:AddListener(self._onClickBtnShowEmptyTips, self)
end

function TreasureraideawardrecordView:buildUI()
	TreasureraideawardrecordView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local rewardTableView = self:getGo("reward/tableview")
	local rewardCell = self:getGo("reward/item")

	self._rewardList = ScrollerList.create(rewardTableView, rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._emptyInReward = self:getGo("reward/empty")
	self._btnTipEmptyInReward = self:getGo("reward/empty/btnTip")
	self._tipBubbleInReward = self:getGo("reward/empty/tipBubble")
	self._emptyTipUiCustonInput = UICustomInput.Get(self._tipBubbleInReward)

	local attackRewardTableView = self:getGo("attack/tableview")
	local attackRewardCell = self:getGo("attack/item")

	self._attackRewardList = ScrollerList.create(attackRewardTableView, attackRewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._emptyInAttack = self:getGo("attack/empty")
end

function TreasureraideawardrecordView:onExit()
	TreasureraideawardrecordView.super.onExit(self)
	TreasureRaiderController.instance:unregisterLocalNotify(TreasureRaiderController.TotalResourceAfterGetInfo, self._onGetInfo, self)
	self._rewardList:dispose()
	self._attackRewardList:dispose()
end

function TreasureraideawardrecordView:onEnter()
	TreasureraideawardrecordView.super.onEnter(self)
	TreasureRaiderController.instance:registerLocalNotify(TreasureRaiderController.TotalResourceAfterGetInfo, self._onGetInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	RichManAgent.instance:sendPM_RichManGetTotalResourceReq(self._activityId)
end

function TreasureraideawardrecordView:_onGetInfo(msg)
	if msg.activityId == self._activityId then
		local atkGainDataList = {}

		if not string.nilorempty(msg.atkGainStr) then
			atkGainDataList = string.split(msg.atkGainStr, "#")
		end

		self._attackRewardList:reloadData(atkGainDataList)
		self._attackRewardList:refresh()
		GameUtil.SetActive(self._emptyInAttack, #atkGainDataList == 0)

		local rewardDataList = {}

		if not string.nilorempty(msg.srcGainStr) then
			rewardDataList = string.split(msg.srcGainStr, "#")
		end

		self._rewardList:reloadData(rewardDataList)
		self._rewardList:refresh()
		GameUtil.SetActive(self._emptyInReward, #rewardDataList == 0)
	end
end

function TreasureraideawardrecordView:_updateRewardCell(view, goCell, data)
	MaterialMgr.resetAll(goCell)

	local proxy = MaterialMgr.setCellByCfg(data, goCell)

	if proxy then
		local _, _, num = MaterialMgr.getMatParams(data or "")

		proxy:setNumStr(StringUtil.numberToString(num or 0))
	end
end

function TreasureraideawardrecordView:_clearRewardCell(goCell)
	MaterialMgr.resetAll(goCell)
end

function TreasureraideawardrecordView:_onClickBtnShowEmptyTips(hover)
	if not hover then
		GameUtil.SetActive(self._tipBubbleInReward, not GameUtil.GetActive(self._tipBubbleInReward))
	end
end

return TreasureraideawardrecordView
