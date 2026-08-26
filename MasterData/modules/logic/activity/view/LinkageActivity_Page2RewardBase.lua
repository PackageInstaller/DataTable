-- chunkname: @modules/logic/activity/view/LinkageActivity_Page2RewardBase.lua

module("modules.logic.activity.view.LinkageActivity_Page2RewardBase", package.seeall)

local LinkageActivity_Page2RewardBase = class("LinkageActivity_Page2RewardBase", RougeSimpleItemBase)

function LinkageActivity_Page2RewardBase:ctor(ctorParam)
	self:__onInit()
	LinkageActivity_Page2RewardBase.super.ctor(self, ctorParam)
end

function LinkageActivity_Page2RewardBase:onDestroyView()
	LinkageActivity_Page2RewardBase.super.onDestroyView(self)
	self:__onDispose()
end

function LinkageActivity_Page2RewardBase:actId()
	local p = self:_assetGetParent()

	return p:actId()
end

function LinkageActivity_Page2RewardBase:isType101RewardCouldGetAnyOne()
	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(self:actId())
end

function LinkageActivity_Page2RewardBase:isType101RewardGet()
	return ActivityType101Model.instance:isType101RewardGet(self:actId(), self._index)
end

function LinkageActivity_Page2RewardBase:isType101RewardCouldGet()
	return ActivityType101Model.instance:isType101RewardCouldGet(self:actId(), self._index)
end

function LinkageActivity_Page2RewardBase:getType101LoginCount()
	return ActivityType101Model.instance:getType101LoginCount(self:actId())
end

function LinkageActivity_Page2RewardBase:getNorSignActivityCo()
	return ActivityConfig.instance:getNorSignActivityCo(self:actId(), self._index)
end

function LinkageActivity_Page2RewardBase:sendGet101BonusRequest(cb, cbObj)
	return Activity101Rpc.instance:sendGet101BonusRequest(self:actId(), self._index, cb, cbObj)
end

function LinkageActivity_Page2RewardBase:claimAll(cb, cbObj)
	return ActivityType101Model.instance:claimAll(self:actId(), cb, cbObj)
end

function LinkageActivity_Page2RewardBase:isActOnLine()
	return ActivityModel.instance:isActOnLine(self:actId())
end

function LinkageActivity_Page2RewardBase:refreshRewardItem(item, itemCo)
	item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	item:setCountFontSize(46)
	item:setHideLvAndBreakFlag(true)
	item:hideEquipLvAndBreak(true)
	item:isShowQuality(false)
	item:customOnClickCallback(function()
		if not self:isActOnLine() then
			GameFacade.showToast(ToastEnum.BattlePass)

			return
		end

		local couldGet = self:isType101RewardCouldGet()

		if couldGet then
			self.claimAll(self, self._onClaimAllCb, self)

			return
		end

		MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
	end)
end

return LinkageActivity_Page2RewardBase
