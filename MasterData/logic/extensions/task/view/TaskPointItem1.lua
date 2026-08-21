-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskPointItem1.lua

module("logic.extensions.task.view.TaskPointItem1", package.seeall)

local M = class("TaskPointItem2")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._btnClick = ButtonAdapter.Get(registry:findUIElement("score_item1_-1442180581"))

	self._btnClick:AddClickListener(self._clickSelf, self)

	self._dottedline = registry:findUIElement("score_item1_1705119823")
	self._solidline = registry:findUIElement("score_item1_-1916117070")
	self._normalBox = registry:findUIElement("score_item1_-1266794750")
	self._lastBox = registry:findUIElement("score_item1_-1197139996")
	self._canGetRewardObj = registry:findUIElement("score_item1_-1328226470")
	self._imgCostIcon = registry:findUIElement("score_item1_-12979843", UIComponentType.Image)
	self._txtCostNum = registry:findUIElement("score_item1_-681384986", UIComponentType.Text)
	self._imgCostIcon2 = registry:findUIElement("score_item1_-990175429", UIComponentType.Image)
	self._txtCostNum2 = registry:findUIElement("score_item1_-924280957", UIComponentType.Text)
	self._finishObj = registry:findUIElement("score_item1_-2044624616")
end

function M:_clickSelf()
	ViewMgr.instance:open(ViewName.RewardPreview, {
		self._data:getRewardId()
	}, self._data:getFinish())
end

function M:setCellData(data, index, islast)
	goutil.setActive(self._normalBox, not islast)
	goutil.setActive(self._lastBox, islast)

	self._curIndex = index
	self._data = data
	self._txtCostNum.text = data:getNeedPoint()
	self._txtCostNum2.text = data:getNeedPoint()

	if not data:getFinish() then
		goutil.setActive(self._canGetRewardObj, data:canGetReward())
		goutil.setActive(self._finishObj, false)
		goutil.setActive(self._imgCostIcon.gameObject, true)
		goutil.setActive(self._txtCostNum.gameObject, true)
		goutil.setActive(self._dottedline, not data:canGetReward())
		goutil.setActive(self._solidline, data:canGetReward())
	else
		goutil.setActive(self._dottedline, false)
		goutil.setActive(self._solidline, true)
		goutil.setActive(self._imgCostIcon.gameObject, false)
		goutil.setActive(self._txtCostNum.gameObject, false)
		goutil.setActive(self._canGetRewardObj, false)
		goutil.setActive(self._finishObj, true)
	end
end

function M:OnDisable()
	return
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil
	self._imgCostIcon = nil
	self._txtCostNum = nil
	self._canGetRewardObj = nil
	self._finishObj = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

return M
