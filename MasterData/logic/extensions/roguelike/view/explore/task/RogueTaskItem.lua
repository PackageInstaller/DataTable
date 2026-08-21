-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/task/RogueTaskItem.lua

module("logic.extensions.roguelike.view.explore.task.RogueTaskItem", package.seeall)

local M = class("RogueTaskItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._animation = self._go:GetComponent(ComponentType.Animation)
	self._canvasGroup = goutil.addComponentOnce(self._go, ComponentType.CanvasGroup)
	self._txtDesc = registry:findUIElement("rungroup_task_item_2022707781", UIComponentType.Text)
	self._txtProcess = registry:findUIElement("rungroup_task_item_-1256803307", UIComponentType.Text)
	self._btnGo = ButtonAdapter.Get(registry:findUIElement("rungroup_task_item_1525735424"))

	self._btnGo:AddClickListener(self._clickGo, self)

	self._btnGet = ButtonAdapter.Get(registry:findUIElement("rungroup_task_item_-1236421347"))

	self._btnGet:AddClickListener(self._clickGet, self)

	self._finishObj = registry:findUIElement("rungroup_task_item_-1909289467")
	self._itemGo = {
		registry:findUIElement("0&rewards_detail_item_2141037416"),
		registry:findUIElement("1&rewards_detail_item_2141037416")
	}
	self._itemCell = {}

	for i = 1, #self._itemGo do
		local itemCell = Astral.LuaComponentContainer.Add(self._itemGo[i], ItemCell)

		table.insert(self._itemCell, itemCell)
	end
end

function M:_showReward(index, itemid, number)
	if index <= #self._itemCell then
		self._itemCell[index]:setShowSelectedEffect(false)
		self._itemCell[index]:updateData(ItemData.New({
			count = number,
			itemId = itemid
		}))
	end
end

function M:_clickGet()
	if self._data:canGetReward() and not self._data:getIsFinish() then
		RoguelikeAgent.instance:sendTakeRewardRequest({
			self._data:getTaskId()
		})
	end
end

function M:setGotoClick(clickGoto, clickGotoHandler)
	self._clickGotoFun = clickGoto
	self._clickGotoHandle = clickGotoHandler
end

function M:_clickGo()
	local jumpId = self._data:getJumpId()

	if not string.nilorempty(jumpId) then
		if not SystemJumpController.instance:canJump(tonumber(jumpId), true) then
			return
		end

		if self._clickGotoFun then
			self._clickGotoFun(self._clickGotoHandle)
		end

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, tonumber(jumpId))
	end
end

function M:getIndex()
	return self._curIndex
end

function M:setCellData(data, index)
	self._curIndex = index
	self._data = data
	self._txtDesc.text = data:getShowDesc()

	if data:getIsFinish() then
		goutil.setActive(self._btnGo.gameObject, false)
		goutil.setActive(self._btnGet.gameObject, false)
		goutil.setActive(self._finishObj, true)
	else
		if data:canGetReward() then
			goutil.setActive(self._btnGo.gameObject, false)
			goutil.setActive(self._btnGet.gameObject, true)
		else
			goutil.setActive(self._btnGo.gameObject, data:canJump())
			goutil.setActive(self._btnGet.gameObject, false)
		end

		goutil.setActive(self._finishObj, false)
	end

	self._txtProcess.text = self:_getProcessDesc(data:getCurCount(), data:getMaxCount())

	local rewardList = data:getRewardList()
	local len = #rewardList

	for i = 1, 2 do
		goutil.setActive(self._itemGo[i], i <= len)

		if i <= len then
			self:_showReward(i, rewardList[i].itemId, rewardList[i].num)
		end
	end
end

function M:_getProcessDesc(curCount, maxCount)
	local colorStr = "FFFFFF"

	colorStr = tonumber(curCount) < tonumber(maxCount) and "ff3e48" or "00FF0C"

	return string.format("<color=#%s>%s</color>/%s", colorStr, tonumber(curCount) > tonumber(maxCount) and maxCount or curCount, maxCount)
end

function M:OnDisable()
	return
end

function M:playOpenAni()
	self:playAniByName("rungroup_task_item_open")
end

function M:playAniByName(aniName)
	self._animation:Stop()
	self._animation:Play(aniName)
end

function M:StopAni()
	self._animation:Stop()
end

function M:setAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil
	self._animation = nil
	self._canvasGroup = nil

	self._btnGo:RemoveClickListener()

	self._btnGo = nil

	self._btnGet:RemoveClickListener()

	self._btnGet = nil
	self._txtDesc = nil
	self._txtProcess = nil
	self._itemGo = nil
	self._itemCell = nil
	self._finishObj = nil
end

return M
