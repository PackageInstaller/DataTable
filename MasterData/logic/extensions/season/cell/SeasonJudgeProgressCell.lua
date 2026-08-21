-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/cell/SeasonJudgeProgressCell.lua

module("logic.extensions.season.cell.SeasonJudgeProgressCell", package.seeall)

local M = class("SeasonJudgeProgressCell", SimpleCellComponent)
local kTextReceiveColor = "#000000"
local kTextNotReceiveColor = "#B6B7B7"

function M:ctor(container)
	self.super.ctor(self, container)

	self._preUniqueId = nil
	self._preCanReceive = false
	self._playReceiveSFX = false
	self._receiveHandler = Handler.New()
	self._showMoreReward = false
	self._goRewards = {}
end

function M:buildUI()
	self._textProgress = goutil.findChildTextComponent(self._go, "txtProgress")
	self._goImg1 = goutil.findChild(self._go, "img1")
	self._goImg2 = goutil.findChild(self._go, "img2")
	self._transfGroup = goutil.findChildComponent(self._go, "rewardGroup", UIComponentType.RectTransform)
	self._goBackpackItem = goutil.findChild(self._go, "rewardGroup/backpack_item")
	self._btnMore = UIComponentType.ButtonAdapter(goutil.findChild(self._go, "rewardGroup/btnOpen"))
	self._goUp = goutil.findChild(self._go, "rewardGroup/btnOpen/img1")
	self._goDown = goutil.findChild(self._go, "rewardGroup/btnOpen/img2")
	self._uiParticle = goutil.findChild(self._goImg1.gameObject, "UIParticle2")

	table.insert(self._goRewards, self._goBackpackItem)
end

function M:bindEvents()
	self._btnMore:AddClickListener(self._onClickMore, self)
end

function M:unbindEvents()
	self._btnMore:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	self._receiveHandler:clear()

	self._receiveHandler = nil
end

function M:_setData(taskProgressCO, preProgressCO, isReceived, finishedTaskNum)
	self._isReceived = isReceived
	self._progressCO = taskProgressCO
	self._preProgressCO = preProgressCO
	self._finishedTaskNum = finishedTaskNum

	if self._progressCO == nil then
		self._isCanReceive = false
		self._rewardCO = nil
	else
		self._isCanReceive = finishedTaskNum >= self._progressCO.count and not self._isReceived or false
		self._rewardCO = RewardConfig.instance:getRewardCfgByCode(self._progressCO.reward) or nil
	end

	self._finished = self._isReceived or self._isCanReceive or false
	self._playReceiveSFX = false

	local uniqueId = self:_getUniqueId()

	if self._preUniqueId and self._preUniqueId == uniqueId and self._preCanReceive == false and self._isCanReceive then
		self._playReceiveSFX = true
	end

	self._preCanReceive = self._isCanReceive
	self._preUniqueId = uniqueId
end

function M:_refreshUI()
	local hasCO = self._progressCO ~= nil
	local cellProgress = 0

	if hasCO then
		self._textProgress.text = self._progressCO.count

		goutil.setActive(self._goLine, self._isReceived or self._isCanReceive)

		local preProgressCount = self._preProgressCO and self._preProgressCO.count or 0

		cellProgress = (self._finishedTaskNum - preProgressCount) / (self._progressCO.count - preProgressCount)
		self._imgLine.fillAmount = cellProgress

		self:_refreshRewards()
	end

	local color = self._finished and parsecolor(kTextReceiveColor) or parsecolor(kTextNotReceiveColor)

	self._textProgress.color = color

	goutil.setActive(self._goImg1, self._finished)
	goutil.setActive(self._goImg2, not self._finished)
	goutil.setActive(self._go, hasCO)
	goutil.setActive(self._goLine, hasCO and cellProgress > 0 or false)
	goutil.setActive(self._golineBg, hasCO)
	goutil.setActive(self._uiParticle, self._playReceiveSFX)
	self:_updateMoreReward(false)
end

function M:_refreshRewards()
	while #self._goRewards < #self._rewardCO.reward do
		local go = goutil.cloneAndSetParent(self._goBackpackItem, self._transfGroup)

		table.insert(self._goRewards, go)
	end

	for index, goItem in ipairs(self._goRewards) do
		Astral.LuaComponentContainer.Remove(goItem, SeasonJudgeRewardCell)

		local cell = Astral.LuaComponentContainer.Add(goItem, SeasonJudgeRewardCell)
		local reward = self._rewardCO.reward[index]

		if reward then
			local itemData = ItemUtil.createItemData({
				itemId = reward.code,
				count = reward.num
			})
			local receiveState = self:_getReceiveState()

			cell:updateData(itemData)
			cell:getComponent("normal"):setClickListener(function()
				self:_onClickCell(reward)
			end)
			cell:getComponent("reward"):setRewardStatus(receiveState)
		end
	end

	goutil.setActive(self._btnMore.gameObject, #self._rewardCO.reward > 1)
end

function M:_updateMoreReward(showMoreReward)
	self._showMoreReward = showMoreReward

	for index, go in ipairs(self._goRewards) do
		goutil.setActive(go, index == 1 or self._showMoreReward)
	end

	goutil.setActive(self._goUp.gameObject, not self._showMoreReward)
	goutil.setActive(self._goDown.gameObject, self._showMoreReward)
end

function M:_getReceiveState()
	local receiveItemState = CommEnum.RewardEnum.CanNotGot

	if self._isReceived then
		receiveItemState = CommEnum.RewardEnum.HasGot
	elseif self._isCanReceive then
		receiveItemState = CommEnum.RewardEnum.CanGot
	end

	return receiveItemState
end

function M:_onClickMore()
	self:_updateMoreReward(not self._showMoreReward)
end

function M:_onClickCell(reward)
	if self._isCanReceive then
		self:_receiveAllReward()
	else
		local itemData = ItemUtil.createItemData({
			itemId = reward.code,
			count = reward.num
		})

		GlobalDispatcher:dispatchEvent(itemData:getItemMarkType(), itemData, self._go, nil, true)
	end
end

function M:_receiveAllReward()
	self._receiveHandler:call()
end

function M:_getUniqueId()
	return self._progressCO and string.format("%s_%s", self._progressCO.id, self._progressCO.label) or nil
end

function M:setLineGo(goLine, golineBg)
	self._goLine = goLine
	self._golineBg = golineBg
	self._imgLine = goLine:GetComponent(UIComponentType.Image)
end

function M:setClickReceiveCallBack(callBackFun, callBackObj)
	self._receiveHandler:setListener(callBackFun, callBackObj)
end

function M:canReceive()
	return self._isCanReceive
end

function M:getId()
	return self._progressCO and self._progressCO.id or 0
end

return M
