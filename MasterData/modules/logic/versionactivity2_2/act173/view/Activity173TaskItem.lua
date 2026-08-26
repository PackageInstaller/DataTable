-- chunkname: @modules/logic/versionactivity2_2/act173/view/Activity173TaskItem.lua

module("modules.logic.versionactivity2_2.act173.view.Activity173TaskItem", package.seeall)

local Activity173TaskItem = class("Activity173TaskItem", LuaCompBase)
local TaskFinishedColor = "#392E0F"
local TaskFinishedAlpha = 0.5
local TaskUnfinishedColor = "#392E0F"
local TaskUnfinishedAlpha = 1
local TaskUnfinishedProgressColor = "#A5471B"
local TaskFinishedProgressColor = "#392E0F"

function Activity173TaskItem:ctor(go)
	Activity173TaskItem.super.ctor(self)

	self.go = go
	self._txtTitle = gohelper.findChildText(self.go, "Title/#txt_Title")
	self._txtDescr = gohelper.findChildText(self.go, "#txt_Descr")
	self._txtNum = gohelper.findChildText(self.go, "image_NumBG/txt_Num")
	self._txtProgress = gohelper.findChildText(self.go, "#txt_Num")
	self._goClaim = gohelper.findChild(self.go, "#go_Claim")
	self._goGet = gohelper.findChild(self.go, "#go_Get")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "#btn_click")
	self._simageHeadIcon = gohelper.findChildSingleImage(self.go, "#simage_HeadIcon")
	self._btnjump = gohelper.findChildButtonWithAudio(self.go, "#btn_jump")

	self:addEvents()
end

function Activity173TaskItem:init(config)
	self._config = config

	self:initTaskDesc()
	self:initReward()
end

function Activity173TaskItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function Activity173TaskItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnjump:RemoveClickListener()
end

function Activity173TaskItem:_btnclickOnClick()
	if self._config and self._canGetReward then
		TaskRpc.instance:sendFinishTaskRequest(self._config.id, self._onFinishedTask, self)

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

function Activity173TaskItem:_btnjumpOnClick()
	if self._config and self._config.jumpId ~= 0 then
		JumpController.instance:jump(self._config.jumpId)
	end
end

function Activity173TaskItem:initTaskDesc()
	self._txtDescr.text = self._config.desc
	self._txtTitle.text = self._config.name
end

function Activity173TaskItem:initReward()
	self._bonus = string.splitToNumber(self._config.bonus, "#")

	if not self._bonus[3] then
		self._txtNum.text = luaLang("multiple") .. self._bonus[3]

		self:initOrRefreshProgress()

		local isPortraitReward = self:checkIsPortraitReward(self._bonus)

		if isPortraitReward and self._simageHeadIcon then
			self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageHeadIcon)

			self._liveHeadIcon:setLiveHead(tonumber(self._bonus[2]))
		end
	end
end

function Activity173TaskItem:refresh()
	self._taskMo = TaskModel.instance:getTaskById(self._config.id)

	if self._taskMo then
		local hasFinished = self._taskMo.finishCount > 0

		if self._taskMo then
			if not self._taskMo.progress then
				local progress = 0

				self._canGetReward = self._taskMo and progress >= self._config.maxProgress and self._taskMo.finishCount <= 0

				gohelper.setActive(self._goClaim, self._canGetReward)
				gohelper.setActive(self._goGet, hasFinished)
				gohelper.setActive(self._btnjump.gameObject, not hasFinished)
				self:initOrRefreshTaskContentColor(hasFinished)
				self:initOrRefreshProgress(hasFinished, progress)
			end
		end
	end
end

function Activity173TaskItem:initOrRefreshTaskContentColor(hasFinished)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtDescr, (hasFinished or nil) and (TaskFinishedColor or TaskUnfinishedColor))
	ZProj.UGUIHelper.SetColorAlpha(self._txtDescr, (hasFinished or nil) and (TaskFinishedAlpha or TaskUnfinishedAlpha))
end

function Activity173TaskItem:initOrRefreshProgress(hasFinished, progress)
	progress = Activity173Controller.numberDisplay(progress or 0)

	local maxProgress = Activity173Controller.numberDisplay(self._config.maxProgress)

	if hasFinished then
		if not TaskFinishedProgressColor then
			local progressColor = TaskUnfinishedProgressColor

			self._txtProgress.text = string.format("<%s>%s</color>/%s", progressColor, progress, maxProgress)

			SLFramework.UGUI.GuiHelper.SetColor(self._txtProgress, (hasFinished or nil) and (TaskFinishedColor or TaskUnfinishedColor))
			ZProj.UGUIHelper.SetColorAlpha(self._txtProgress, (hasFinished or nil) and (TaskFinishedAlpha or TaskUnfinishedAlpha))
		end
	end
end

function Activity173TaskItem:checkIsPortraitReward(bonus)
	local bonusType = bonus[1]
	local bonusId = bonus[2]

	if bonusType == MaterialEnum.MaterialType.Item then
		local config = ItemModel.instance:getItemConfig(bonusType, bonusId)

		if config and config.subType == ItemEnum.SubType.Portrait then
			return true
		end
	end
end

function Activity173TaskItem:_onFinishedTask()
	self:refresh()
end

function Activity173TaskItem:destroy()
	self:removeEvents()
end

return Activity173TaskItem
