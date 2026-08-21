-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsUseItemComp.lua

module("logic.extensions.tooltips.component.ToolTipsUseItemComp", package.seeall)

local M = class("ToolTipsUseItemComp", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._item = nil
	self._maxUseCount = false
	self._isHandleExpireTime = false
	self._title = nil
	self._hint = nil
end

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._btnCancle = self:getBtnByPath("allContent/btnCancel")
	self._btnUse = self:getBtnByPath("allContent/btnUse")
	self._btnMinus = Astral.UILongPressTrigger.Get(self:getGo("health_tips_157882474"))
	self._btnAdd = Astral.UILongPressTrigger.Get(self:getGo("health_tips_750925399"))

	local longPressTriggerCfg = {
		0.6,
		0.2,
		0.01
	}

	self._btnAdd:SetTriggerTime(longPressTriggerCfg)
	self._btnMinus:SetTriggerTime(longPressTriggerCfg)

	self._canvasGroupAdd = goutil.addComponentOnce(self._btnAdd.gameObject, ComponentType.CanvasGroup)
	self._canvasGroupMinus = goutil.addComponentOnce(self._btnMinus.gameObject, ComponentType.CanvasGroup)
	self._txtDetails = self:getText("health_tips_1833674939")
	self._txtTitle = goutil.findChildComponent(self.mainGO.gameObject, "universal_second_tips_common_bg/content/txtTitle", UIComponentType.Text)
	self._txtNowUse = self:getText("health_tips_640780584")
	self._slider = UIComponentType.SliderAdapter(self:getGo("health_tips_-1274195630"))
	self._uiSlider = self:getUIComponent("health_tips_-1274195630", UIComponentType.Slider)
	self._uiSlider.value = 0

	local cellGo = self:getGo("health_tips_266905855")

	self._itemCell = Astral.SimpleLuaComponentContainer.Add(cellGo.transform:GetChild("0").gameObject, ItemCell)

	self._itemCell:setShowTipsPassEvent(false)
	self._itemCell:setShowSelectedEffect(false)
end

function M:destroyUI()
	self._btnCancle = nil
	self._btnUse = nil
	self._btnMinus = nil
	self._btnAdd = nil
	self._txtDetails = nil
	self._slider = nil
	self._uiSlider = nil
	self._itemCell = nil
	self._item = nil
	self._maxUseCount = false
	self._isHandleExpireTime = false
	self._title = nil
	self._hint = nil
end

function M:bindEvents()
	self._btnCancle:AddClickListener(self.onClickCancel, self)
	self._btnUse:AddClickListener(self.onClickUse, self)
	self._btnMinus:AddLongPressListener(self.tryMinusOne, self, nil)
	self._btnAdd:AddLongPressListener(self.onLongPressAdd, self, nil)
	self._slider:AddOnValueChanged(self._onSliderValChanged, self)
end

function M:unbindEvents()
	self._btnCancle:RemoveClickListener()
	self._btnUse:RemoveClickListener()
	self._btnMinus:RemoveLongPressListener()
	self._btnAdd:RemoveLongPressListener()
	self._slider:RemoveOnValueChanged()
end

function M:onEnter()
	local info = self:getFirstParam()

	if not info then
		printWarn("批量使用物品界面参数为空！")

		return
	end

	self:initData(info)
	self:handleOverExpireTime()
	self:setItemInfo()
	self._slider:SetValue(self._minDoubleCount)
end

function M:initData(info)
	self._item = info.item
	self._minDoubleCount = 1
	self._maxUseCount = info.maxUseCount
	self._isHandleExpireTime = info.isHandleExpireTime
	self._title = info.title
	self._hint = info.hint
	self._uiSlider.minValue = self._minDoubleCount
	self._uiSlider.maxValue = self._item:getCount()
end

function M:setItemInfo()
	self._itemCell:updateData(self._item)

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._item:getItemId())

	if self._hint then
		goutil.setActive(self._txtDetails.gameObject, true)

		self._txtDetails.text = lang(self._hint)
	elseif itemCo.titleHint then
		goutil.setActive(self._txtDetails.gameObject, true)

		self._txtDetails.text = lang(itemCo.titleHint)
	elseif itemCo.useDesc then
		goutil.setActive(self._txtDetails.gameObject, true)

		self._txtDetails.text = itemCo.useDesc
	else
		goutil.setActive(self._txtDetails.gameObject, false)
	end

	if self._title then
		self._txtTitle.text = lang(self._title)
	else
		self._txtTitle.text = string.format("使用%s", itemCo.name)
	end

	if not self._maxUseCount then
		self._maxUseCount = itemCo.batchUseLimit and itemCo.batchUseLimit ~= 0 and itemCo.batchUseLimit or 10000
	end
end

function M:updateItemPreUseShow()
	self._txtNowUse.text = self._curUseNum
	self._canvasGroupAdd.alpha = self._uiSlider.value >= self._uiSlider.maxValue and 0.2 or 1
	self._canvasGroupMinus.alpha = self._uiSlider.value <= self._uiSlider.minValue and 0.2 or 1
end

function M:handleOverExpireTime()
	if not self._isHandleExpireTime then
		return false
	end

	local curTime = ServerTime.now() * 1000
	local isOver = self._itemExpireTime ~= 0 and curTime >= self._itemExpireTime

	if isOver then
		FloatWordMgr.instance:show(lang("tip_goods_overdue"))

		return true
	end

	return false
end

function M:_onSliderValChanged(val)
	self._curUseNum = val

	self:updateItemPreUseShow()
end

function M:tryAddOne()
	local itemHas = self._item:getCount()

	if itemHas <= self._curUseNum or self._curUseNum >= self._maxUseCount then
		FloatWordMgr.instance:show(lang("tip_item_use_limit"))

		return
	end

	self._curUseNum = self._curUseNum + 1

	self._slider:SetValue(self._curUseNum)
end

function M:tryMinusOne()
	if self._curUseNum <= 1 then
		return
	end

	self._curUseNum = self._curUseNum - 1

	self._slider:SetValue(self._curUseNum)
end

function M:onClickUse()
	if self:handleOverExpireTime() then
		return
	end

	if self._curUseNum == 0 or self._maxUseCount and self._curUseNum > self._maxUseCount then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.ITEM_USE_EVENT, {
		uuid = self._item:getUuid(),
		type = self._item:getType(),
		subType = self._item:getSubType(),
		itemId = self._item:getItemId(),
		count = self._curUseNum
	})
	self:close()
end

function M:onLongPressAdd()
	self:tryAddOne(true)
end

function M:onClickCancel()
	self:close()
end

return M
