-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tacit/view/TacitTaskItem.lua

module("logic.extensions.tacit.view.TacitTaskItem", package.seeall)

local M = class("TacitTaskItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._canGetRewardGo = registry:findUIElement("tacit_trial_item_-683134516")
	self._isTargetGo = registry:findUIElement("tacit_trial_item_-650761698")
	self._normalHeartGo = registry:findUIElement("tacit_trial_item_-1861081664")
	self._finishHeartGo = registry:findUIElement("tacit_trial_item_-202044701")
	self._imgNormalGo = registry:findUIElement("tacit_trial_item_336567646")
	self._silderGo = registry:findUIElement("tacit_trial_item_-1553227506")
	self._imgValue = registry:findUIElement("tacit_trial_item_-820274334", UIComponentType.Image)
	self._txtValue = registry:findUIElement("tacit_trial_item_-1563033490", UIComponentType.Text)
	self._itemGo = registry:findUIElement("0&rewards_detail_item_2141037416")
	self._itemCell = Astral.LuaComponentContainer.Add(self._itemGo, ItemCell)
	self._finishTaskGo = registry:findUIElement("tacit_trial_item_-1939467199")

	goutil.setActive(self._finishTaskGo, false)

	self._btnJump = ButtonAdapter.Get(registry:findUIElement("tacit_trial_item_-261839848"))

	self._btnJump:AddClickListener(self._clickJump, self)

	self._txtDesc = registry:findUIElement("tacit_trial_item_-1349407834", UIComponentType.Text)
	self._txtNum = registry:findUIElement("tacit_trial_item_-273587734", UIComponentType.Text)
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("tacit_trial_item_-1954692635"))

	self._btnClick:AddClickListener(self._clickSelf, self)
end

function M:setCellData(data, index, curLevel)
	self._data = data
	self._index = index
	self._curLevel = curLevel

	local isFinish = data:getHasFinish()
	local reward = data:getRewardTb()
	local jumpId = data:getJumpId()

	if reward then
		self:_showReward(reward.itemId, reward.num)
	end

	if not isFinish then
		self._imgValue.fillAmount = data:getCurCount() / data:getMaxCount()
		self._txtValue.text = string.format("%s/%s", data:getCurCount(), data:getMaxCount())
	end

	local showJumpBtn = not data:getCanReward() and jumpId > 0 and not isFinish

	self._txtDesc.text = data:getDesc()
	self._txtNum.text = "+" .. data:getTacitExp()

	goutil.setActive(self._canGetRewardGo, not isFinish and data:getCanReward())
	goutil.setActive(self._isTargetGo, data:getIsTarget())
	goutil.setActive(self._normalHeartGo, not isFinish)
	goutil.setActive(self._finishHeartGo, isFinish)
	goutil.setActive(self._finishTaskGo, isFinish)
	goutil.setActive(self._silderGo, not isFinish)
	goutil.setActive(self._btnJump.gameObject, showJumpBtn)
	goutil.setActive(self._imgNormalGo, not data:getIsTarget())
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:_showReward(itemid, number)
	self._itemCell:setShowSelectedEffect(false)
	self._itemCell:updateData(ItemData.New({
		count = number,
		itemId = itemid
	}))
end

function M:_clickSelf()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._data)
	end
end

function M:_clickJump()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, self._data:getJumpId())
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil

	self._btnClick:RemoveClickListener()
	self._btnJump:RemoveClickListener()
end

return M
