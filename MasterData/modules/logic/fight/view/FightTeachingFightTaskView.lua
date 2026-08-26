-- chunkname: @modules/logic/fight/view/FightTeachingFightTaskView.lua

module("modules.logic.fight.view.FightTeachingFightTaskView", package.seeall)

local FightTeachingFightTaskView = class("FightTeachingFightTaskView", FightBaseView)

function FightTeachingFightTaskView:onConstructor(config)
	self.config = config
end

function FightTeachingFightTaskView:onInitView()
	self.gridRoot = gohelper.findChild(self.viewGO, "Target")
	self.itemObj = gohelper.findChild(self.viewGO, "Target/#go_Item")
end

function FightTeachingFightTaskView:addEvents()
	return
end

function FightTeachingFightTaskView:removeEvents()
	return
end

function FightTeachingFightTaskView:onOpen()
	local taskIdList = string.splitToNumber(self.config.battleTasks, "|")
	local taskDescList = string.split(self.config.taskDetail, "|")
	local itemList = self:com_registViewItemList(self.itemObj, FightTeachingFightTaskItemView, self.gridRoot)
	local list = {}

	for i = 1, #taskIdList do
		table.insert(list, {
			taskId = taskIdList[i],
			taskDesc = taskDescList[i]
		})
	end

	itemList:setDataList(list)
end

function FightTeachingFightTaskView:onClose()
	return
end

function FightTeachingFightTaskView:onDestroyView()
	return
end

return FightTeachingFightTaskView
