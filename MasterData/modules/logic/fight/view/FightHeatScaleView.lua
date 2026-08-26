-- chunkname: @modules/logic/fight/view/FightHeatScaleView.lua

module("modules.logic.fight.view.FightHeatScaleView", package.seeall)

local FightHeatScaleView = class("FightHeatScaleView", FightHeatScaleBaseView)
local ChangeType = {
	Add = 1,
	Subtract = 2
}

function FightHeatScaleView:getPosList(go, count)
	local posList = self:getUserDataTb_()

	for i = 1, count do
		local pos = gohelper.findChild(go, "pos" .. i)

		table.insert(posList, pos.transform)
	end

	return posList
end

function FightHeatScaleView:initView(viewGo, teamType)
	FightHeatScaleView.super.initView(self, viewGo, teamType)

	self.viewTr = self.viewGo.transform
	self.root = gohelper.findChild(self.viewGo, "root")
	self.animator = self.root:GetComponent(gohelper.Type_Animator)
	self.goNormal = gohelper.findChild(self.root, "go_normal")
	self.goSp = gohelper.findChild(self.root, "go_sp")

	gohelper.setActive(self.goNormal, true)
	gohelper.setActive(self.goSp, false)

	self.fillMountImage1 = gohelper.findChildImage(self.goNormal, "#go_gemfg")
	self.fillMountImage2 = gohelper.findChildImage(self.goSp, "#go_gemfg")
	self.txtValue = gohelper.findChildText(self.root, "mask/#txt_num")
	self.goAddItemContainer = gohelper.findChild(self.root, "addItemContainer")
	self.goAddItem = gohelper.findChild(self.goAddItemContainer, "addItem")

	gohelper.setActive(self.goAddItem, false)

	self.addItemPool = {}
	self.addItemList = {}
	self.addItemTweenIdList = {}
	self.addValueQueue = {}
	self.txtValue1 = gohelper.findChildText(self.root, "#num/#txt_num")
	self.txtValueAdd = gohelper.findChildText(self.root, "#num/#txt_num_add")
	self.txtValueSub = gohelper.findChildText(self.root, "#num/#txt_num_subtract")
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGo, "clickarea")
	self.maxValue = 0
	self.tweenValue = 0
	self.preValue = 0
	self.lastPlayedAddItemTime = 0
	self.updateHandle = UpdateBeat:CreateListener(self._onFrame, self)

	UpdateBeat:AddListener(self.updateHandle)
end

function FightHeatScaleView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.HeatScale_MaxValueChange, self.onMaxValueChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.HeatScale_ValueChange, self.onValueChange, self)
	self.addClickCb(self, self.click, self.onClick, self)
end

FightHeatScaleView.AnchorMinAndMax = FightCommonTipController.Pivot.TopRight
FightHeatScaleView.Pivot = FightCommonTipController.Pivot.CenterRight
FightHeatScaleView.offsetX = -80

function FightHeatScaleView:onClick()
	local screenPos = recthelper.uiPosToScreenPos(self.viewTr)
	local desc = self:getDesc()
	local title = self:getTitle()

	FightCommonTipController.instance:openCommonView(title, desc, screenPos, FightHeatScaleView.AnchorMinAndMax, FightHeatScaleView.Pivot, FightHeatScaleView.offsetX)
end

function FightHeatScaleView:onOpen()
	self:refreshValue()
end

function FightHeatScaleView:refreshValue()
	self.maxValue = self:getMaxValue()

	local curValue = self:getCurValue()

	self.preValue = curValue

	self:directUpdateValue(curValue)
end

FightHeatScaleView.StartFillMount = 0.2
FightHeatScaleView.EndFillMount = 0.82

function FightHeatScaleView:getFillMount(floatValue)
	local len = FightHeatScaleView.EndFillMount - FightHeatScaleView.StartFillMount

	len = len * floatValue

	local fillMount = FightHeatScaleView.StartFillMount + len

	return math.min(fillMount, FightHeatScaleView.EndFillMount)
end

function FightHeatScaleView:directUpdateValue(value)
	self.tweenValue = value

	local floatValue = value / self.maxValue
	local fillAmount = self:getFillMount(floatValue)

	self.fillMountImage1.fillAmount = fillAmount
	self.fillMountImage2.fillAmount = fillAmount
	self.txtValue.text = value
	self.txtValue1.text = value
	self.txtValueAdd.text = value
	self.txtValueSub.text = value
end

function FightHeatScaleView:getCurValue()
	local heatScale = FightDataHelper.getHeatScale(self.teamType)

	return (heatScale or nil) and (heatScale.value or 0)
end

function FightHeatScaleView:getMaxValue()
	local heatScale = FightDataHelper.getHeatScale(self.teamType)

	return (heatScale or nil) and (heatScale.max or 0)
end

function FightHeatScaleView:onMaxValueChange()
	self:refreshValue()
end

FightHeatScaleView.SubTweenDuration = 0.8
FightHeatScaleView.QueueMaxCount = 20
FightHeatScaleView.AddTweenDuration = 0.6
FightHeatScaleView.Interval = 0.15
FightHeatScaleView.ItemHeight = 14

function FightHeatScaleView:onValueChange()
	local curValue = self:getCurValue()
	local offsetValue = curValue - self.preValue

	self.preValue = curValue

	if offsetValue > 0 then
		self.changeType = ChangeType.Add

		self:interruptionSubAnim()
		self:addOffsetToQueue(offsetValue)
		self:tryPopOffsetValue()
		self:directUpdateValue(curValue)
		AudioMgr.instance:trigger(320009)
	else
		self.changeType = ChangeType.Subtract

		self:interruptionAddAnim()

		self.valueChangeTweenId = ZProj.TweenHelper.DOTweenFloat(self.tweenValue, curValue, FightHeatScaleView.SubTweenDuration, self.onValueFrameCallback, self.onValueDone, self)

		self.animator:Play("subtract", 0, 0)
		AudioMgr.instance:trigger(320010)
	end
end

function FightHeatScaleView:onValueFrameCallback(value)
	value = math.floor(value)

	self:directUpdateValue(value)
end

function FightHeatScaleView:onValueDone()
	self.valueChangeTweenId = nil

	self:directUpdateValue(self:getCurValue())
end

function FightHeatScaleView:interruptionAddAnim()
	self.animator:Play("idle", 0, 0)
	tabletool.clear(self.addValueQueue)
	self:clearAddItemTween()

	for _, addItem in ipairs(self.addItemList) do
		self:recycleAddItem(addItem)
	end

	tabletool.clear(self.addItemList)
end

function FightHeatScaleView:interruptionSubAnim()
	self.animator:Play("idle", 0, 0)
	self:clearValueChangeTween()
end

function FightHeatScaleView:addOffsetToQueue(offsetValue)
	if #self.addValueQueue >= FightHeatScaleView.QueueMaxCount then
		table.remove(self.addValueQueue, 1)
	end

	table.insert(self.addValueQueue, offsetValue)
end

function FightHeatScaleView:tryPopOffsetValue()
	local time = Time.time

	if time - self.lastPlayedAddItemTime < FightHeatScaleView.Interval then
		return
	end

	if #self.addValueQueue <= 0 then
		return
	end

	local value = table.remove(self.addValueQueue, 1)

	self:playAddAnim(value)

	self.lastPlayedAddItemTime = time
end

function FightHeatScaleView:playAddAnim(offsetValue)
	local addItem = self:getAddItem()

	addItem.txtNum.text = string.format("%+d", offsetValue)

	table.insert(self.addItemList, 1, addItem)
	gohelper.setActive(addItem.go, true)
	recthelper.setAnchor(addItem.rectTr, 0, 0)
	addItem.animator:Play("active", 0, 0)

	local posY = self:getAddItemPosY(5)
	local tweenId = ZProj.TweenHelper.DOAnchorPosY(addItem.rectTr, posY, FightHeatScaleView.AddTweenDuration, self.onAddItemTweenDone, self, addItem)

	gohelper.setActive(addItem.goArrow, FightDataHelper.entityMgr:checkSideHasBuffAct(FightEnum.EntitySide.MySide, FightEnum.BuffActId.HeatScaleAddFix))
	table.insert(self.addItemTweenIdList, tweenId)
end

function FightHeatScaleView:onAddItemTweenDone(addItem)
	tabletool.removeValue(self.addItemList, addItem)
	self:recycleAddItem(addItem)
end

function FightHeatScaleView:getAddItemPosY(index)
	return (index - 1) * FightHeatScaleView.ItemHeight
end

function FightHeatScaleView:getAddItem()
	local addItem = table.remove(self.addItemPool)

	if not addItem then
		addItem = self:getUserDataTb_()
		addItem.go = gohelper.cloneInPlace(self.goAddItem)
		addItem.rectTr = addItem.go:GetComponent(gohelper.Type_RectTransform)
		addItem.animator = addItem.go:GetComponent(gohelper.Type_Animator)
		addItem.txtNum = gohelper.findChildText(addItem.go, "#txt_num")
		addItem.goArrow = gohelper.findChild(addItem.go, "#go_arrow")

		gohelper.setActive(addItem.goArrow, false)
	end

	return addItem
end

function FightHeatScaleView:recycleAddItem(addItem)
	gohelper.setActive(addItem.go, false)
	gohelper.setActive(addItem.goArrow, false)
	table.insert(self.addItemPool, addItem)
end

function FightHeatScaleView:clearAddItemTween()
	for _, tweenId in ipairs(self.addItemTweenIdList) do
		ZProj.TweenHelper.KillById(tweenId)
	end

	tabletool.clear(self.addItemTweenIdList)
end

function FightHeatScaleView:_onFrame()
	self:tryPopOffsetValue()
end

function FightHeatScaleView:clearValueChangeTween()
	if self.valueChangeTweenId then
		ZProj.TweenHelper.KillById(self.valueChangeTweenId)

		self.valueChangeTweenId = nil
	end
end

function FightHeatScaleView:getDesc()
	return FightConfig.instance:getJGZDesc()
end

function FightHeatScaleView:getTitle()
	return FightConfig.instance:getJGZTitle()
end

function FightHeatScaleView:destroy()
	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)
	end

	self:interruptionAddAnim()
	self:interruptionSubAnim()
	FightHeatScaleView.super.destroy(self)
end

return FightHeatScaleView
