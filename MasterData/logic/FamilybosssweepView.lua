-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilybosssweepView.lua

module("logic.extensions.family.view.FamilybosssweepView", package.seeall)

local FamilybosssweepView = class("FamilybosssweepView", ViewComponent)

function FamilybosssweepView:ctor()
	FamilybosssweepView.super.ctor(self)
end

function FamilybosssweepView:buildUI()
	FamilybosssweepView.super.buildUI(self)

	self.closeBtn = self:getBtn("closeBtn")
	self.sweepBtn = self:getBtn("okBtn")
	self.lastHurtNumText = goutil.findChildTextComponent(self.mainGO, "lastHurtNumText")
	self.lasetRewardNumText = goutil.findChildTextComponent(self.mainGO, "lasetRewardNumText")
end

function FamilybosssweepView:bindEvents()
	FamilybosssweepView.super.bindEvents(self)
end

function FamilybosssweepView:unbindEvents()
	FamilybosssweepView.super.unbindEvents(self)
end

function FamilybosssweepView:destroyUI()
	FamilybosssweepView.super.destroyUI(self)
end

function FamilybosssweepView:onEnter()
	FamilybosssweepView.super.onEnter(self)

	self.currBossId = self:getFirstParam()

	if not self.currBossId then
		self:close()

		return
	end

	self.closeBtn:AddClickListener(self.onClickClose, self)
	self.sweepBtn:AddClickListener(self.onClickSweep, self)
	self:initView()
end

function FamilybosssweepView:onEnterFinished()
	FamilybosssweepView.super.onEnterFinished(self)
end

function FamilybosssweepView:onExit()
	FamilybosssweepView.super.onExit(self)
	self.closeBtn:RemoveClickListener()
	self.sweepBtn:RemoveClickListener()
end

function FamilybosssweepView:onExitFinished()
	FamilybosssweepView.super.onExitFinished(self)
end

function FamilybosssweepView:onClickClose()
	self:close()
end

function FamilybosssweepView:onClickSweep()
	local leftTime = FamilyModel.instance:getBossChallegenLeftTime(self.currBossId)

	if leftTime <= 0 then
		FloatWordMgr.instance:show("扫荡次数不足")

		return
	end

	FamilyController.instance:sendSweepBossReq(self.currBossId)
	self:close()
end

function FamilybosssweepView:initView()
	local data = FamilyModel.instance:getUnlockedBossInfo(self.currBossId)

	if data then
		local endTime = checknumber(data.endTimeMillis)

		if endTime == -1 or endTime <= ServerTime.nowMs() then
			self:close()

			return
		end

		local lastDamage = checknumber(data.lastDamage)
		local list = FamilyConfig.instance:getBossPrizeStrategy(self.currBossId)
		local boxCount = 0

		if list and table.nums(list) > 0 then
			for i, v in pairs(list) do
				if lastDamage >= v.interval then
					boxCount = boxCount + 1
				end
			end
		end

		self.lastHurtNumText.text = lastDamage
		self.lasetRewardNumText.text = boxCount
	end
end

return FamilybosssweepView
