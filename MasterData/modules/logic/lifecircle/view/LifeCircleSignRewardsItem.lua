-- chunkname: @modules/logic/lifecircle/view/LifeCircleSignRewardsItem.lua

module("modules.logic.lifecircle.view.LifeCircleSignRewardsItem", package.seeall)

local LifeCircleSignRewardsItem = class("LifeCircleSignRewardsItem", RougeSimpleItemBase)

function LifeCircleSignRewardsItem:onInitView()
	self._gorewards = gohelper.findChild(self.viewGO, "#go_rewards")
	self._gorewardtemplate = gohelper.findChild(self.viewGO, "#go_rewards/#go_reward_template")
	self._goimagestatus = gohelper.findChild(self.viewGO, "#go_rewards/#go_image_status")
	self._goimagestatuslight = gohelper.findChild(self.viewGO, "#go_rewards/#go_image_status_light")
	self._goimportant = gohelper.findChild(self.viewGO, "#go_rewards/#go_important")
	self._txtpointvalue = gohelper.findChildText(self.viewGO, "#go_rewards/#go_important/#txt_pointvalue")
	self._txtpointvalue_normal = gohelper.findChildText(self.viewGO, "#go_rewards/#txt_pointvalue_normal")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LifeCircleSignRewardsItem:addEvents()
	return
end

function LifeCircleSignRewardsItem:removeEvents()
	return
end

local splitToNumber = string.splitToNumber
local split = string.split

function LifeCircleSignRewardsItem:ctor(...)
	self:__onInit()
	LifeCircleSignRewardsItem.super.ctor(self, ...)

	self._rewardItemList = {}
	self._isLastOne = false
end

function LifeCircleSignRewardsItem:onDestroyView()
	LifeCircleSignRewardsItem.super.onDestroyView(self)
	GameUtil.onDestroyViewMemberList(self, "_rewardItemList")
	self:__onDispose()
end

function LifeCircleSignRewardsItem:_editableInitView()
	gohelper.setActive(self._gorewardtemplate, false)
end

function LifeCircleSignRewardsItem:setData(mo)
	LifeCircleSignRewardsItem.super.setData(self, mo)

	local CO = self._mo
	local bonus = CO.bonus

	self._isLastOne = string.nilorempty(bonus)

	local isClaimable = self:isClaimable()
	local isClaimed = self:isClaimed()
	local isHighLight = isClaimable or isClaimed
	local bonusList = self._isLastOne and {} or split(bonus, "|")
	local n = self._isLastOne and 2 or #bonusList

	for i = 1, n do
		local item
		local bonusArr = not self._isLastOne and splitToNumber(bonusList[i], "#") or nil

		if i > #self._rewardItemList then
			item = self:_create_LifeCircleSignRewardsItemItem(i)

			table.insert(self._rewardItemList, item)
		else
			item = self._rewardItemList[i]
		end

		item:onUpdateMO(bonusArr)
		item:setActive(true)
	end

	for i = n + 1, #self._rewardItemList do
		local item = self._rewardItemList[i]

		item:setActive(false)
	end

	self._txtpointvalue.text = self:logindaysid()
	self._txtpointvalue_normal.text = self._isLastOne and luaLang("LifeCircleSignRewardsItemItemLastOnePtValue") or isClaimable and "" or self:logindaysid()

	gohelper.setActive(self._goimportant, isClaimable)
	gohelper.setActive(self._goimagestatus, not isHighLight)
	gohelper.setActive(self._goimagestatuslight, isHighLight)
end

function LifeCircleSignRewardsItem:isLastOne()
	return self._isLastOne
end

function LifeCircleSignRewardsItem:stageid()
	local CO = self._mo

	return CO.stageid
end

function LifeCircleSignRewardsItem:logindaysid()
	return self._mo.logindaysid
end

function LifeCircleSignRewardsItem:_create_LifeCircleSignRewardsItemItem(index)
	local go = gohelper.cloneInPlace(self._gorewardtemplate)
	local item = LifeCircleSignRewardsItemItem.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function LifeCircleSignRewardsItem:_totalLoginDays()
	local p = self:parent()

	return p:totalLoginDays()
end

function LifeCircleSignRewardsItem:onItemClick()
	if self:isClaimable() then
		LifeCircleController.instance:sendSignInTotalRewardRequest(self:stageid())

		return false
	end

	return true
end

function LifeCircleSignRewardsItem:isClaimed()
	if self._isLastOne then
		return false
	end

	local stageid = self:stageid()

	return SignInModel.instance:isClaimedAccumulateReward(stageid)
end

function LifeCircleSignRewardsItem:isClaimable()
	if self._isLastOne then
		return false
	end

	local stageid = self:stageid()

	return LifeCircleController.instance:isClaimableAccumulateReward(stageid)
end

return LifeCircleSignRewardsItem
