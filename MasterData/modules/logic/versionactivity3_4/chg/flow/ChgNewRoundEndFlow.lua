-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgNewRoundEndFlow.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgNewRoundEndFlow", package.seeall)

local ChgNewRoundEndFlow = class("ChgNewRoundEndFlow", ChgSimpleFlowSequence)

function ChgNewRoundEndFlow:onStart()
	local endItemList = self:endItemList()
	local allVisitedCheckpointItemList = self:getAllVisitedCheckpointItemList()
	local key2Info = {}

	for _, item in ipairs(endItemList) do
		local mapObj = item:mapObj()
		local key = mapObj:key()

		key2Info[key] = {
			item = item,
			needHP = mapObj:curHP()
		}
	end

	local flyFlow = ChgFlowParallel_Base.New()

	for _, item in ipairs(allVisitedCheckpointItemList) do
		local mapObj = item:mapObj()
		local endKey = mapObj:getTargetKey()
		local addHP = mapObj:getV3a4_AddStartHP()

		if endKey and addHP > 0 then
			local info = key2Info[endKey]
			local endItem = info.item
			local uiFlyingItem = self:getOrCreateUIFlying()

			uiFlyingItem:setIcon(mapObj:iconUrl_fx())
			flyFlow:addWork(ChgDragEnd_UIFlyingWork.s_create(uiFlyingItem, item, endItem, addHP))

			info.needHP = info.needHP - addHP
		end
	end

	flyFlow:registerDoneListener(self.recycleAllUIFlying, self)
	self:addWork(flyFlow)

	local now, max = self.viewContainer:roundNowAndMax()
	local newNow = now + 1
	local isEnddingRound = max < newNow
	local winCnt = 0
	local deadFlow = ChgFlowParallel_Base.New()

	for _, info in pairs(key2Info) do
		if info.needHP <= 0 then
			winCnt = winCnt + 1

			local endItem = info.item

			deadFlow:addWork(ChgPlayAnimWork.s_create(endItem:animatorPlayer(), "dead", AudioEnum3_4.Chg.play_ui_bulaochun_cheng_death))
		end
	end

	self:addWork(deadFlow)

	local isThisRoundSucc = winCnt >= #endItemList

	self.viewContainer:trackFinishRound(isThisRoundSucc)

	if isThisRoundSucc then
		self:addWork(FunctionWork.New(self.setActive_goVictory, self, true))
		self:addWork(DelayWork.New(0.5))

		if not isEnddingRound then
			self:addWork(FunctionWork.New(self.setRound, self, newNow))
			self:addWork(FunctionWork.New(self.setActive_goBgClick, self, true))
		end
	else
		isEnddingRound = true
	end

	if isEnddingRound then
		self:addWork(FunctionWork.New(self.completeGame, self, isThisRoundSucc))
	end
end

return ChgNewRoundEndFlow
