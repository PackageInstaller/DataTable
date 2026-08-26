-- chunkname: @modules/logic/survival/view/shelter/SurvivalDecreeVoteItem.lua

module("modules.logic.survival.view.shelter.SurvivalDecreeVoteItem", package.seeall)

local SurvivalDecreeVoteItem = class("SurvivalDecreeVoteItem", SurvivalDecreeItem)

function SurvivalDecreeVoteItem:onUpdateMO(mo)
	self.mo = mo

	local isLocked = false
	local isEmpty = mo == nil or mo:isCurPolicyEmpty()
	local isShowHas = not isLocked and not isEmpty
	local isShowAdd = not isLocked and isEmpty

	gohelper.setActive(self.goHas, isShowHas)
	gohelper.setActive(self.goAdd, isShowAdd)
	gohelper.setActive(self.goLocked, isLocked)
	gohelper.setActive(self.goAnnouncement, false)

	if isShowHas then
		self:refreshHas(true)
	end
end

function SurvivalDecreeVoteItem:refreshHas(isFinish)
	gohelper.setActive(self.btnVote, false)
	gohelper.setActive(self.goFinished, false)
	gohelper.setActive(self.goAnnouncement, true)

	local list = self.mo:getCurPolicyGroup():getPolicyList()

	for i = 1, math.max(#list, #self.itemList) do
		local item = self:getItem(i)

		self:updateDescItem(item, list[i], isFinish)
	end

	recthelper.setHeight(self.goDescer.transform, 381)
end

return SurvivalDecreeVoteItem
