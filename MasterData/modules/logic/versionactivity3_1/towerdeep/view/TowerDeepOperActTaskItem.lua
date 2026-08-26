-- chunkname: @modules/logic/versionactivity3_1/towerdeep/view/TowerDeepOperActTaskItem.lua

module("modules.logic.versionactivity3_1.towerdeep.view.TowerDeepOperActTaskItem", package.seeall)

local TowerDeepOperActTaskItem = class("TowerDeepOperActTaskItem", LuaCompBase)

function TowerDeepOperActTaskItem:init(go, co)
	self.go = go
	self._config = co
	self._txttask = gohelper.findChildText(self.go, "txt_task")
	self._gorewarditem = gohelper.findChild(self.go, "go_rewarditem")
	self._goicon = gohelper.findChild(self.go, "go_rewarditem/go_icon")
	self._gocanget = gohelper.findChild(self.go, "go_rewarditem/go_canget")
	self._goreceive = gohelper.findChild(self.go, "go_rewarditem/go_receive")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "go_rewarditem/btn_click")

	self:_initItem()
	self:addEvents()
end

function TowerDeepOperActTaskItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function TowerDeepOperActTaskItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function TowerDeepOperActTaskItem:_btnclickOnClick()
	if self._config and self._canGetReward then
		TaskRpc.instance:sendFinishTaskRequest(self._config.id)

		return
	end

	if not self._bonus or #self._bonus <= 0 then
		if self._config then
			local taskId = self._config.id

			logError("打开物品详情界面失败:缺少奖励配置 任务Id = " .. tostring(taskId))

			return
		end
	end

	MaterialTipController.instance:showMaterialInfo(self._bonus[1], self._bonus[2])
end

function TowerDeepOperActTaskItem:refresh()
	self._taskMo = TaskModel.instance:getTaskById(self._config.id)

	if self._taskMo then
		local hasFinished = self._taskMo.finishCount > 0

		if self._taskMo then
			if not self._taskMo.progress then
				local progress = 0

				self._canGetReward = self._taskMo and progress >= self._config.maxProgress and self._taskMo.finishCount <= 0

				gohelper.setActive(self._gocanget, self._canGetReward)
				gohelper.setActive(self._goreceive, hasFinished)
			end
		end
	end
end

function TowerDeepOperActTaskItem:_initItem()
	self._txttask.text = string.format(self._config.desc, self._config.maxProgress)
	self._bonus = string.splitToNumber(self._config.bonus, "#")
	self._rewardItem = IconMgr.instance:getCommonItemIcon(self._goicon)

	self._rewardItem:setMOValue(self._bonus[1], self._bonus[2], self._bonus[3], nil, true)
	self._rewardItem:isShowName(false)
end

function TowerDeepOperActTaskItem:destroy()
	self:removeEvents()
end

return TowerDeepOperActTaskItem
