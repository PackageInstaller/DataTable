-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskItem1.lua

module("logic.extensions.task.view.TaskItem1", package.seeall)

local M = class("TaskItem1")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._txtDesc = registry:findUIElement("task_item1_copy_1494711985", UIComponentType.Text)
	self._txtProcess = registry:findUIElement("task_item1_copy_758126167", UIComponentType.Text)
	self._btnGo = ButtonAdapter.Get(registry:findUIElement("task_item1_copy_780930644"))

	self._btnGo:AddClickListener(self._clickGo, self)

	self._btnGet = ButtonAdapter.Get(registry:findUIElement("task_item1_copy_417702616"))

	self._btnGet:AddClickListener(self._clickGet, self)

	self._txtScore = registry:findUIElement("task_item1_copy_615871166", UIComponentType.Text)
	self._finishObj = registry:findUIElement("task_item1_copy_1335415353")
	self._imgIcon = registry:findUIElement("task_item1_copy_1940925573", UIComponentType.Image)
end

function M:_showReward(itemid, number)
	self._itemCell:setShowSelectedEffect(false)
	self._itemCell:updateData(ItemData.New({
		count = number,
		itemId = itemid
	}))
end

function M:_clickGet()
	if self._data:canGetReward() and not self._data:getIsFinish() then
		-- block empty
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

	if data:getIcon() and not string.nilorempty(data:getIcon()) then
		IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Task, data:getIcon())
	end

	self._txtProcess.text = self:_getProcessDesc(data:getCurCount(), data:getMaxCount())
	self._txtScore.text = data:getPoint()
end

function M:_getProcessDesc(curCount, maxCount)
	local colorStr = "FFFFFF"

	colorStr = tonumber(curCount) < tonumber(maxCount) and "ff3e48" or "00FF0C"

	return string.format("<color=#%s>%s</color>/%s", colorStr, tonumber(curCount) > tonumber(maxCount) and maxCount or curCount, maxCount)
end

function M:OnDisable()
	return
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil

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
