-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/view/SpecialtrainingItem.lua

module("logic.extensions.specialtraining.view.SpecialtrainingItem", package.seeall)

local M = class("SpecialtrainingItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._canvasGroup = goutil.addComponentOnce(self._mainGo, ComponentType.CanvasGroup)
	self._txtContent = self._registry:getUIComponent("special_training_task_item_-1199505363", UIComponentType.TextMeshProUGUI)
	self._txtProcess = self._registry:getText("special_training_task_item_456865392")
	self._btnGoTo = self._registry:getBtn("special_training_task_item_892020778")
	self._btnGet = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("2&btn_left_-1571983320"), CommButton)
	self._lockGo = self._registry:getGo("special_training_task_item_-1972808742")
	self._receivedGo = self._registry:getGo("special_training_task_item_607929199")
	self._canGetGo = self._registry:getGo("special_training_task_item_869261863")
	self._itemGo = {
		self._registry:getGo("0&rewards_detail_item_2141037416"),
		self._registry:getGo("1&rewards_detail_item_2141037416")
	}
	self._itemCell = {}

	for i = 1, #self._itemGo do
		local itemCell = Astral.LuaComponentContainer.Add(self._itemGo[i], ItemCell)

		table.insert(self._itemCell, itemCell)
	end

	self._leftGo = self._registry:getGo("special_training_task_item_1238446264")
	self._leftLightGo = self._registry:getGo("special_training_task_item_1638509796")
	self._left2Go = self._registry:getGo("special_training_task_item_1150583200")
	self._left2LightGo = self._registry:getGo("special_training_task_item_814218254")
	self._rightGo = self._registry:getGo("special_training_task_item_447310400")
	self._rightLightGo = self._registry:getGo("special_training_task_item_-983331898")
	self._midleGo = self._registry:getGo("special_training_task_item_653984238")
	self._midleState1Go = self._registry:getGo("special_training_task_item_643660245")
	self._midleTxt1 = self._registry:getText("special_training_task_item_1737884372")
	self._midleState2Go = self._registry:getGo("special_training_task_item_-1707358631")
	self._midleTxt2 = self._registry:getText("special_training_task_item_-1391008799")

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnGoTo:AddClickListener(self._onClickGoTo, self)
end

function M:_unbindEvents()
	self._btnGet:RemoveClickListener()
	self._btnGoTo:RemoveClickListener()
end

function M:_onClickGet()
	local taskId = self._taskMo:getTaskId()

	printWarn("======taskId=====", taskId)
	SpecialtrainingAgent.instance:sendGrowthTaskRewardRequest(taskId)
end

function M:_onClickGoTo()
	local jumpId = self._taskMo:getJumpId()

	printWarn("======jumpId=====", jumpId, self._taskMo:getTaskId())
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, tonumber(jumpId))
end

function M:updateData(data, clickStageIndex, itemIndex, isFirstItem, isLastItem)
	self._taskMo = data
	self._txtContent.text = self._taskMo:getShowDesc()
	self._txtProcess.text = string.format("(%s/%s)", self._taskMo:getCurCount(), self._taskMo:getMaxCount())

	local canGet = self._taskMo:canGetReward()
	local isFinish = self._taskMo:getIsFinish()
	local preTaskId = self._taskMo:getPreTask()
	local preTaskMo = SpecialtrainingModel.instance:getTaskMo(preTaskId)

	if preTaskMo then
		local stageIndex = SpecialtrainingModel.instance:getCurrentStageIndex()
		local stageId = self._taskMo:getStageId()
		local stageIdPre = preTaskMo:getStageId()
		local isSame = stageId == stageIdPre

		if stageIndex < clickStageIndex then
			goutil.setActive(self._lockGo, true)
		else
			goutil.setActive(self._lockGo, isSame and not preTaskMo:getIsFinish())
		end
	else
		goutil.setActive(self._lockGo, false)
	end

	goutil.setActive(self._canGetGo, canGet and not isFinish and not self._lockGo.activeSelf)
	goutil.setActive(self._btnGoTo.gameObject, not canGet and self._taskMo:getJumpId() ~= "" and not self._lockGo.activeSelf)
	goutil.setActive(self._receivedGo, isFinish)

	self._canvasGroup.alpha = isFinish and 0.5 or 1
	self._midleTxt1.text = itemIndex
	self._midleTxt2.text = itemIndex

	goutil.setActive(self._leftGo, isFirstItem)
	goutil.setActive(self._left2Go, not isFirstItem)
	goutil.setActive(self._rightGo, isLastItem)
	goutil.setActive(self._leftLightGo, not self._lockGo.activeSelf)
	goutil.setActive(self._midleState1Go, self._lockGo.activeSelf)
	goutil.setActive(self._midleState2Go, not self._lockGo.activeSelf)
	goutil.setActive(self._rightLightGo, not self._lockGo.activeSelf)
	goutil.setActive(self._left2LightGo, not self._lockGo.activeSelf)

	local rewardList = self._taskMo:getRewardList()
	local len = #rewardList

	for i = 1, 2 do
		goutil.setActive(self._itemGo[i], i <= len)

		if i <= len then
			self:_showReward(i, rewardList[i].itemId, rewardList[i].num)
		end
	end
end

function M:_showReward(index, itemid, number)
	if index <= #self._itemCell then
		self._itemCell[index]:setShowSelectedEffect(false)
		self._itemCell[index]:updateData(ItemUtil.createItemData({
			itemId = itemid,
			count = number
		}))
	end
end

function M:OnDestroy()
	self:_unbindEvents()
end

return M
