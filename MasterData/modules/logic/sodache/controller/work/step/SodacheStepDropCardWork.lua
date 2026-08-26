-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepDropCardWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepDropCardWork", package.seeall)

local SodacheStepDropCardWork = class("SodacheStepDropCardWork", SodacheStepBaseWork)
local showPanelReason = {
	[20] = true
}

function SodacheStepDropCardWork:onWorkStart(context)
	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	local reason = self._stepMo.paramInt[1]

	if not showPanelReason[reason] then
		for i, v in ipairs(self._stepMo.itemRewards) do
			for _, vv in ipairs(v.items) do
				local cardMo = GameUtil.rpcInfoToMo(vv, SodacheItemMo):toCardMo()

				SodacheUtil.showCardToast({
					isGet = self:isGetCard(),
					cardMo = cardMo
				})
			end
		end

		self:onDone(true)

		return
	end

	local items = {}

	for i, v in ipairs(self._stepMo.itemRewards) do
		local arr = GameUtil.rpcInfosToList(v.items, SodacheItemMo)

		for _, vv in ipairs(arr) do
			vv.dropType = v.type
		end

		tabletool.addValues(items, arr)
	end

	table.sort(items, function(a, b)
		local rareA = a.itemCo.quality
		local rareB = b.itemCo.quality

		if rareA ~= rareB then
			return rareB < rareA
		end

		return a.configId < b.configId
	end)

	if #items > 12 then
		if isDebugBuild then
			logError("掉落奖励超过了12，显示不下，直接截断！！！")
		end

		items = {
			unpack(items, 1, 12)
		}
	end

	context.isEventEnd = true

	if #items <= 0 then
		self:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SodacheGetCardView, {
		items = items,
		isGetCard = self:isGetCard()
	})
end

function SodacheStepDropCardWork:isGetCard()
	return true
end

function SodacheStepDropCardWork:_onViewClose(viewName)
	if viewName == ViewName.SodacheGetCardView then
		self:onDone(true)
	end
end

function SodacheStepDropCardWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function SodacheStepDropCardWork:isInsideStep()
	return false
end

return SodacheStepDropCardWork
