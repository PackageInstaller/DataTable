-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/cell/integral_drop/ActivityIntegralDropItemCell.lua

module("logic.extensions.welfare.cell.integral_drop.ActivityIntegralDropItemCell", package.seeall)

local M = class("ActivityIntegralDropItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
end

function M:OnDestroy()
	return
end

function M:buildUI()
	self._registry = ViewElementsRegistry.New(self.mainGO)
	self._normalSlideObj = self._registry:findUIElement("item2_419184046")
	self._normalSlideImage = self._registry:findUIElement("item2_-26204872", UIComponentType.Image)
	self._goMarkReach = self._registry:findUIElement("item2_-1534099318")
	self._txtNumRech = goutil.findChildTextComponent(self._goMarkReach, "txtNum")
	self._goMarkUnReach = self._registry:findUIElement("item2_2090983121")
	self._txtNumUnRech = goutil.findChildTextComponent(self._goMarkUnReach, "txtNum")
end

function M:setRewardData(integralDropMo)
	self:refreshSliderAndNum(integralDropMo)
	self:refreshReward(integralDropMo)
end

function M:refreshSliderAndNum(integralDropMo)
	goutil.setActive(self._normalSlideObj, true)

	local curStepIntegral = ActivityIntegralDropController.instance:getCurStepIntegral()
	local integralProcessFull = curStepIntegral >= integralDropMo._score
	local processCell = 0

	if integralProcessFull then
		processCell = 1
		self._txtNumRech.text = integralDropMo._score

		goutil.setActive(self._goMarkReach, true)
		goutil.setActive(self._goMarkUnReach, false)
	elseif curStepIntegral - integralDropMo._preStepIntegral > 0 then
		processCell = (curStepIntegral - integralDropMo._preStepIntegral) / (integralDropMo._score - integralDropMo._preStepIntegral)
		self._txtNumUnRech.text = integralDropMo._score

		goutil.setActive(self._goMarkUnReach, true)
		goutil.setActive(self._goMarkReach, false)
	else
		self._txtNumUnRech.text = integralDropMo._score

		goutil.setActive(self._goMarkUnReach, true)
		goutil.setActive(self._goMarkReach, false)
	end

	self._normalSlideImage.fillAmount = processCell
end

function M:refreshReward(integralDropMo)
	local excelId = ActivityIntegralDropController.instance:getConfigId(integralDropMo._orderId)
	local itemId, itemCount = ActivityIntegralDropConfig.instance:getStepRewardInfoByOrder(excelId, integralDropMo._orderId)
	local numVisible = not ItemUtil.isCharacterById(itemId)
	local itemData = ItemUtil.createItemData({
		itemId = itemId
	})

	itemData:setCount(itemCount)

	local goItemCell = self._registry:findUIElement("rewards_detail_item_2141037416")

	goutil.setActive(goItemCell, true)

	local rewardCell = Astral.LuaComponentContainer.Add(goItemCell, ActivityIntegralRewardCell)

	rewardCell:setStepOrder(integralDropMo._orderId)
	rewardCell:updateData(itemData)
	rewardCell:getComponent("num"):setVisible(numVisible)

	local rewardStatus = ActivityIntegralDropController.instance:getReceivingRewardStatus(integralDropMo._orderId)

	rewardCell:getComponent("reward"):setRewardStatus(rewardStatus)
end

function M:refreshTabRedDot()
	return
end

return M
