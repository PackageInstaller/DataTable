-- chunkname: @modules/logic/fight/view/FightTeachingFightTaskItemView.lua

module("modules.logic.fight.view.FightTeachingFightTaskItemView", package.seeall)

local FightTeachingFightTaskItemView = class("FightTeachingFightTaskItemView", FightBaseView)

function FightTeachingFightTaskItemView:onInitView()
	self.animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self.darkRoot = gohelper.findChild(self.viewGO, "#txt_Target0")
	self.lightRoot = gohelper.findChild(self.viewGO, "#txt_Target")
	self.darkText = gohelper.findChildText(self.viewGO, "#txt_Target0")
	self.lightText = gohelper.findChildText(self.viewGO, "#txt_Target")
end

function FightTeachingFightTaskItemView:addEvents()
	self:com_registFightEvent(FightEvent.TaskDataUpdate, self.onTaskDataUpdate)
end

function FightTeachingFightTaskItemView:removeEvents()
	return
end

function FightTeachingFightTaskItemView:onTaskDataUpdate()
	local isFinished = self.taskData.status == FightTaskBoxData.TaskStatus.Finished

	if self.lastStatus ~= FightTaskBoxData.TaskStatus.Finished and isFinished then
		self.animator:Play("finish", 0, 0)
	end

	gohelper.setActive(self.darkRoot, not isFinished)
	gohelper.setActive(self.lightRoot, isFinished)

	self.lastStatus = self.taskData.status

	local paramList = {}

	if self.taskData.values[1] then
		table.insert(paramList, self.taskData.values[1].progress)
	end

	local desc = self.taskDesc

	desc = isFinished and string.gsub(desc, "▩1%%s", "<color=#E99B56>▩1%%s</color>") or string.gsub(desc, "▩1%%s", "<color=#D97373>▩1%%s</color>")
	self.darkText.text = GameUtil.getSubPlaceholderLuaLang(desc, paramList)
	self.lightText.text = GameUtil.getSubPlaceholderLuaLang(desc, paramList)
end

function FightTeachingFightTaskItemView:onRefreshItemData(data)
	self.taskId = data.taskId
	self.taskDesc = data.taskDesc
	self.taskData = FightDataHelper.fieldMgr.fightTaskBox.tasks[self.taskId]

	self:onTaskDataUpdate()
	gohelper.setActive(self.darkRoot, self.taskData.status ~= FightTaskBoxData.TaskStatus.Finished)
	gohelper.setActive(self.lightRoot, self.taskData.status == FightTaskBoxData.TaskStatus.Finished)
end

function FightTeachingFightTaskItemView:onClose()
	return
end

function FightTeachingFightTaskItemView:onDestroyView()
	return
end

return FightTeachingFightTaskItemView
