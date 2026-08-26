-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseSelfTaskItem.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseSelfTaskItem", package.seeall)

local CruiseSelfTaskItem = class("CruiseSelfTaskItem", LuaCompBase)
local waitOpenTime = 0.33

function CruiseSelfTaskItem:init(go, index, isOpen)
	self.go = go
	self._index = index
	self._goflower1 = gohelper.findChild(go, "#image_flower1")
	self._goflower2 = gohelper.findChild(go, "#image_flower2")
	self._goflower3 = gohelper.findChild(go, "#image_flower3")
	self._txtnum = gohelper.findChildText(go, "txt_num")
	self._txtdesc = gohelper.findChildText(go, "txt_desc")
	self._btnwenhao = gohelper.findChildButtonWithAudio(go, "txt_desc/btn_wenhao")
	self._gorewarditem = gohelper.findChild(go, "scroll_Reward/Viewport/Content/go_rewarditem")
	self._btnget = gohelper.findChildButtonWithAudio(go, "go_btn/btn_get")
	self._btnunderway = gohelper.findChildButtonWithAudio(go, "go_btn/btn_underway")
	self._btngo = gohelper.findChildButtonWithAudio(go, "go_btn/btn_go")
	self._gofinished = gohelper.findChild(go, "go_btn/btn_finished")

	gohelper.setActive(self._gorewarditem, false)

	if isOpen then
		gohelper.setActive(self.go, false)

		local delayTime = waitOpenTime + 0.03 * self._index

		TaskDispatcher.runDelay(self._onInFinished, self, delayTime)
	else
		self:_onInFinished()
	end

	self._actId = VersionActivity3_2Enum.ActivityId.CruiseSelfTask
	self._rewardItems = {}

	self:addEvents()
end

function CruiseSelfTaskItem:_onInFinished()
	gohelper.setActive(self.go, true)
end

function CruiseSelfTaskItem:addEvents()
	self._btnwenhao:AddClickListener(self._btnwenhaoOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btnunderway:AddClickListener(self._btnunderwayOnClick, self)
	self._btngo:AddClickListener(self._btngoOnClick, self)
end

function CruiseSelfTaskItem:removeEvents()
	self._btnwenhao:RemoveClickListener()
	self._btnget:RemoveClickListener()
	self._btnunderway:RemoveClickListener()
	self._btngo:RemoveClickListener()
end

function CruiseSelfTaskItem:_btnwenhaoOnClick()
	CruiseController.instance:openCruiseSelfTaskHeroTypeTipView()
end

function CruiseSelfTaskItem:_btngetOnClick()
	if not self._isCanGet then
		return
	end

	Activity216Rpc.instance:sendFinishAct216TaskRequest(self._actId, self._taskId)
end

function CruiseSelfTaskItem:_btnunderwayOnClick()
	return
end

function CruiseSelfTaskItem:_btngoOnClick()
	if self._isCanGet or self._isFinished then
		return
	end

	if self._taskConfig.jumpId == 0 then
		return
	end

	GameFacade.jump(self._taskConfig.jumpId)
end

function CruiseSelfTaskItem:refresh(taskId, index)
	self._index = index or self._index

	gohelper.setSibling(self.go, self._index)

	local isOnlyOneTask, taskIds = Activity216Model.instance:getOnlyOneTask(taskId)

	self._taskId = not isOnlyOneTask and taskId or taskIds[1]
	self._taskMO = Activity216Model.instance:getTaskInfo(self._taskId)
	self._taskConfig = Activity216Config.instance:getTaskCO(self._taskId)

	self:_refreshBtnState()
	self:_refreshContent()
	self:_refreshTaskRewards()
end

function CruiseSelfTaskItem:_refreshContent()
	local showFlowerIndex = math.random(1, 3)

	for i = 1, 3 do
		gohelper.setActive(self["_goflower" .. tostring(i)], showFlowerIndex == i)
	end

	local isOnlyOneTask, taskIds, onlyOneTaskIndex = Activity216Model.instance:getOnlyOneTask(self._taskId)

	gohelper.setActive(self._btnwenhao.gameObject, false)

	if isOnlyOneTask then
		local onlyOneTaskCo = Activity216Config.instance:getOnlyOneTasksCO(onlyOneTaskIndex)
		local desc = onlyOneTaskCo.desc
		local needShowProgress = not self._isCanGet and not self._isFinished

		for _, taskId in ipairs(taskIds) do
			local taskMO = Activity216Model.instance:getTaskInfo(taskId)
			local taskCO = Activity216Config.instance:getTaskCO(taskId)

			if needShowProgress then
				if not string.format("(%d/%d)", (taskMO or nil) and (taskMO.progress or 0), taskCO.maxProgress) then
					local curProgress = ""

					desc = string.gsub(desc, tostring(taskId), curProgress)
				end
			end
		end

		self._txtdesc.text = desc

		gohelper.setActive(self._btnwenhao.gameObject, onlyOneTaskCo.tips == 1)

		if needShowProgress and onlyOneTaskCo.tips ~= 1 then
			local taskMo = Activity216Model.instance:getTaskInfo(taskIds[1])
			local taskCO = Activity216Config.instance:getTaskCO(taskIds[1])

			if taskMo then
				if not taskMo.progress then
					local curProgress = 0

					self._txtnum.text = string.format("(%d/%d)", curProgress, taskCO.maxProgress)

					gohelper.setActive(self._txtnum.gameObject, needShowProgress)
				end
			end
		else
			gohelper.setActive(self._txtnum.gameObject, false)
		end
	elseif self._taskMO then
		if not self._taskMO.progress then
			local curProgress = 0

			self._txtnum.text = string.format("(%d/%d)", curProgress, self._taskConfig.maxProgress)
			self._txtdesc.text = self._taskConfig.desc

			gohelper.setActive(self._txtnum.gameObject, true)
		end
	end
end

function CruiseSelfTaskItem:_refreshBtnState()
	self._isFinished = Activity216Model.instance:isTaskFinished(self._taskId, self._actId)

	gohelper.setActive(self._gofinished, self._isFinished)

	self._isCanGet = Activity216Model.instance:isTaskCanGet(self._taskId, self._actId)

	gohelper.setActive(self._btnget, self._isCanGet)
	gohelper.setActive(self._btnunderway.gameObject, not self._isFinished and not self._isCanGet and self._taskConfig.jumpId == 0)
	gohelper.setActive(self._btngo.gameObject, not self._isFinished and not self._isCanGet and self._taskConfig.jumpId ~= 0)
end

function CruiseSelfTaskItem:_refreshTaskRewards()
	for _, v in pairs(self._rewardItems) do
		gohelper.setActive(v.go, false)
	end

	local rewards = string.split(self._taskConfig.bonus, "|")

	for i = 1, #rewards do
		if not self._rewardItems[i] then
			self._rewardItems[i] = {}
			self._rewardItems[i].go = gohelper.cloneInPlace(self._gorewarditem)
			self._rewardItems[i].itemRoot = gohelper.findChild(self._rewardItems[i].go, "go_icon")
			self._rewardItems[i].item = IconMgr.instance:getCommonPropItemIcon(self._rewardItems[i].itemRoot)
			self._rewardItems[i].gocanget = gohelper.findChild(self._rewardItems[i].go, "go_canget")
			self._rewardItems[i].btnclick = gohelper.findChildButtonWithAudio(self._rewardItems[i].go, "btn_click")

			self._rewardItems[i].btnclick:AddClickListener(self._btngetOnClick, self)

			self._rewardItems[i].goreceive = gohelper.findChild(self._rewardItems[i].go, "go_receive")
			self._rewardItems[i].gorare = gohelper.findChild(self._rewardItems[i].go, "go_rare")
		end

		gohelper.setActive(self._rewardItems[i].go, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItems[i].item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._rewardItems[i].item:setScale(0.5)
		self._rewardItems[i].item:setCountFontSize(46)
		self._rewardItems[i].item:setHideLvAndBreakFlag(true)
		gohelper.setActive(self._rewardItems[i].gocanget, self._isCanGet)
		gohelper.setActive(self._rewardItems[i].btnclick.gameObject, self._isCanGet)
		gohelper.setActive(self._rewardItems[i].goreceive, self._isFinished)
	end
end

function CruiseSelfTaskItem:destroy()
	if self._rewardItems then
		for _, v in pairs(self._rewardItems) do
			v.btnclick:RemoveClickListener()
		end

		self._rewardItems = nil
	end

	TaskDispatcher.cancelTask(self._onInFinished, self)
	self:removeEvents()
end

return CruiseSelfTaskItem
