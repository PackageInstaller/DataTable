-- chunkname: @modules/logic/explore/view/ExploreBonusItem.lua

module("modules.logic.explore.view.ExploreBonusItem", package.seeall)

local ExploreBonusItem = class("ExploreBonusItem", ListScrollCell)

function ExploreBonusItem:init(go)
	self._progress = gohelper.findChildImage(go, "bottom/progressbar1/image_progresssilder")
	self._progress2 = gohelper.findChildImage(go, "bottom/progressbar2/image_progresssilder")
	self._bglight = gohelper.findChild(go, "bottom/bg_light")
	self._bgdark = gohelper.findChild(go, "bottom/bg_dark")
	self._point = gohelper.findChildTextMesh(go, "bottom/txt_point")
	self._rewardItem = gohelper.findChild(go, "go_rewarditem")
	self._itemParent = gohelper.findChild(go, "icons")
	self._display = gohelper.findChild(go, "bottom/bg_normal/bg_canget")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
end

function ExploreBonusItem:addEventListeners()
	ExploreController.instance:registerCallback(ExploreEvent.TaskUpdate, self._onUpdateTask, self)
end

function ExploreBonusItem:removeEventListeners()
	ExploreController.instance:unregisterCallback(ExploreEvent.TaskUpdate, self._onUpdateTask, self)
end

function ExploreBonusItem:getAnimator()
	return self._anim
end

function ExploreBonusItem:onUpdateMO(mo)
	self._mo = mo

	local arr = string.splitToNumber(mo.listenerParam, "#")
	local taskList = ExploreConfig.instance:getTaskList(arr[1], arr[2])
	local taskMO = TaskModel.instance:getTaskById(mo.id)

	if taskMO then
		if not taskMO.progress then
			local nowCount = 0
			local fillAmount = 1
			local fillAmount2 = 0
			local isFinish = nowCount >= mo.maxProgress

			if isFinish then
				if self._index == #taskList then
					fillAmount2 = 1
				else
					local nextTaskMo = TaskModel.instance:getTaskById(taskList[self._index + 1].id)

					nowCount = nextTaskMo and nextTaskMo.progress or nowCount
					fillAmount2 = Mathf.Clamp((nowCount - mo.maxProgress) / (taskList[self._index + 1].maxProgress - mo.maxProgress), 0, 0.5)
					fillAmount2 = fillAmount2 * 2
				end
			elseif self._index == 1 then
				fillAmount = nowCount / mo.maxProgress
			else
				fillAmount = Mathf.Clamp((nowCount - taskList[self._index - 1].maxProgress) / (mo.maxProgress - taskList[self._index - 1].maxProgress), 0.5, 1) - 0.5
				fillAmount = fillAmount * 2
			end

			self._progress.fillAmount = fillAmount
			self._progress2.fillAmount = fillAmount2
			self._point.text = mo.maxProgress

			SLFramework.UGUI.GuiHelper.SetColor(self._point, isFinish and "#1e1919" or "#d2c197")

			local rewards = GameUtil.splitString2(mo.bonus, true)

			self._items = self._items or {}

			gohelper.CreateObjList(self, self._setRewardItem, rewards, self._itemParent, self._rewardItem)
			self:_onUpdateTask()
			gohelper.setActive(self._display, mo.display == 1)
			gohelper.setActive(self._bglight, isFinish)
			gohelper.setActive(self._bgdark, not isFinish)
		end
	end
end

function ExploreBonusItem:_setRewardItem(go, data, index)
	self._items[index] = self._items[index] or {}

	local icon = gohelper.findChild(go, "go_icon")
	local hasget = gohelper.findChild(go, "go_receive")

	if not self._items[index].item then
		local itemIcon = IconMgr.instance:getCommonPropItemIcon(icon)

		self._items[index].item = self._items[index].item

		self._items[index].item:setMOValue(data[1], data[2], data[3], nil, true)
		self._items[index].item:setCountFontSize(46)
		self._items[index].item:SetCountBgHeight(31)

		self._items[index].hasget = hasget
	end
end

function ExploreBonusItem:_onUpdateTask()
	local taskMO = TaskModel.instance:getTaskById(self._mo.id)
	local isGet = taskMO and taskMO.finishCount > 0 or false

	for i = 1, #self._items do
		gohelper.setActive(self._items[i].hasget, isGet)
	end
end

function ExploreBonusItem:onDestroy()
	for i = 1, #self._items do
		self._items[i].item:onDestroy()
	end
end

return ExploreBonusItem
