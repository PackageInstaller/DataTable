-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/permanentrecharge/StoreRechargeViewItem.lua

module("logic.extensions.store.view.permanentrecharge.StoreRechargeViewItem", package.seeall)

local M = class("StoreRechargeViewItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._data = nil
	self._goRewards = {}
	self._rewardItems = {}

	self:_buildUI()
end

function M:_buildUI()
	self._txtNum = goutil.findChildComponent(self._mainGo, "txtNum", UIComponentType.Text)
	self._goRewards[1] = goutil.findChild(self._mainGo, "rewardGroup/backpack_item1")
	self._rewardItems[1] = Astral.LuaComponentContainer.Add(self._goRewards[1], StoreItemCell)
	self._goRewards[2] = goutil.findChild(self._mainGo, "rewardGroup/reward/backpack_item2")
	self._rewardItems[2] = Astral.LuaComponentContainer.Add(self._goRewards[2], StoreItemCell)
	self._goRewards[3] = goutil.findChild(self._mainGo, "rewardGroup/reward/backpack_item3")
	self._rewardItems[3] = Astral.LuaComponentContainer.Add(self._goRewards[3], StoreItemCell)
	self._btnUnSatisfy = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "btnUnable"))

	self._btnUnSatisfy:AddClickListener(self._onClickUnSatisfy, self)

	self._goHasGet = goutil.findChild(self._mainGo, "stateDone")
	self._goGet = goutil.findChild(self._mainGo, "stateReceive")
	self._btnGetReward = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "stateReceive/btnReceive"))

	self._btnGetReward:AddClickListener(self._onClickGetReward, self)
end

function M:setMo(storeRechargeMo)
	self._storeRechargeMo = storeRechargeMo

	self:_refreshStatusGo()
	self:_refreshReward()

	self._txtNum.text = self._storeRechargeMo:getCredit()
end

function M:_refreshReward()
	local rewardList = self._storeRechargeMo:getRewards()

	for i = 1, 3 do
		local reward = rewardList[i]

		goutil.setActive(self._goRewards[i], reward ~= nil)

		if reward then
			local itemData = ItemUtil.createItemData({
				itemId = reward.code,
				count = reward.num
			})

			self._rewardItems[i]:updateData(itemData)
		end
	end
end

function M:_refreshStatusGo()
	local status = self._storeRechargeMo:getItemStatus()
	local itemStatus = StoreEnum.StoreRechargeStatus

	goutil.setActive(self._goHasGet, status == itemStatus.hasGet)
	goutil.setActive(self._goGet, status == itemStatus.canGet)
	goutil.setActive(self._btnUnSatisfy.gameObject, status == itemStatus.unsatisfied)
end

function M:_onClickUnSatisfy()
	FloatWordMgr.instance:show(lang("tip_store_recharge_not_enough"))
end

function M:_onClickGetReward()
	StoreRechargeAgent.instance:sendReceiveAccumulateRequest(self._storeRechargeMo:getId())
end

function M:OnDestroy()
	self._equipDiceIconItem = nil

	self._btnUnSatisfy:RemoveClickListener()
	self._btnGetReward:RemoveClickListener()
end

return M
