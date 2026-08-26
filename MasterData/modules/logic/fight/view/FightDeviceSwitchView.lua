-- chunkname: @modules/logic/fight/view/FightDeviceSwitchView.lua

module("modules.logic.fight.view.FightDeviceSwitchView", package.seeall)

local FightDeviceSwitchView = class("FightDeviceSwitchView", BaseView)
local TipDefaultInterval = 20

function FightDeviceSwitchView:onInitView()
	self.viewRect = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.halfViewWidth = recthelper.getWidth(self.viewRect) * 0.5
	self.cardItemList = {}
	self.goCardLayout = gohelper.findChild(self.viewGO, "card_layout")
	self.rectCardLayout = self.goCardLayout:GetComponent(gohelper.Type_RectTransform)
	self.bgClick = gohelper.findChildClick(self.viewGO, "bg_mask")

	self.bgClick:AddClickListener(self.onClickBgMask, self)

	self.goDescTip = gohelper.findChild(self.viewGO, "card_layout/desctip")
	self.descTipWidth = recthelper.getWidth(self.goDescTip.transform)

	gohelper.setActive(self.goDescTip, false)

	self.goTipBlock = gohelper.findChild(self.viewGO, "card_layout/tip_block")
	self.tipBlockClick = gohelper.getClickWithDefaultAudio(self.goTipBlock)

	self.addClickCb(self, self.tipBlockClick, self.onClickTipBlock, self)
	gohelper.setActive(self.goTipBlock, false)

	self.descTipItemList = {}

	table.insert(self.descTipItemList, self:createDescTipItem(self.goDescTip))
end

function FightDeviceSwitchView:createDescTipItem(goDescTip)
	local descTipItem = self:getUserDataTb_()

	descTipItem.goDescTip = goDescTip
	descTipItem.rectDescTip = goDescTip:GetComponent(gohelper.Type_RectTransform)
	descTipItem.txtTitle = gohelper.findChildText(goDescTip, "#txt_title")
	descTipItem.txtDesc = gohelper.findChildText(goDescTip, "#txt_desc")
	descTipItem.txtCostPower = gohelper.findChildText(goDescTip, "grid/#txt_energy")
	descTipItem.txtAddExPoint = gohelper.findChildText(goDescTip, "grid/#txt_tongdiao")
	descTipItem.imageEnergyIcon = gohelper.findChildImage(goDescTip, "grid/#txt_energy/icon")

	return descTipItem
end

function FightDeviceSwitchView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_SwitchGroup, self.onSwitchGroup, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_LongPressSwitchCardItem, self.onLongPressSwitchCardItem, self)
end

function FightDeviceSwitchView:removeEvents()
	return
end

function FightDeviceSwitchView:onClickTipBlock()
	self:hideDescTip()
end

function FightDeviceSwitchView:onClickBgMask()
	self:closeThis()
end

function FightDeviceSwitchView:onSwitchGroup(uid, index)
	if uid ~= self.uid then
		return
	end

	if self.selectIndex == index then
		return
	end

	self:closeThis()
end

function FightDeviceSwitchView:updateData()
	self.uid = self.viewParam
	self.deviceInfo = FightDataHelper.getClientDeviceInfo(self.uid)
	self.selectIndex = self.deviceInfo.clientIndex
end

function FightDeviceSwitchView:onUpdateParam()
	self:hideDescTip()
	self:updateData()
	self:refreshDeviceArea()
end

function FightDeviceSwitchView:onOpen()
	self:hideDescTip()
	self:updateData()
	self:refreshDeviceArea()
end

local LeftPivot = Vector2(1, 1)
local RightPivot = Vector2(0, 1)
local LeftAnchor = -TipDefaultInterval
local RightAnchor = TipDefaultInterval
local LeftMinAndMax = Vector2(0, 1)
local RightMinAndMax = Vector2(1, 1)

function FightDeviceSwitchView:onLongPressSwitchCardItem(cardItem)
	if not cardItem then
		self:hideDescTip()

		return
	end

	local groupSkillInfo = cardItem:getGroupInfo()

	if not groupSkillInfo then
		self:hideDescTip()

		return
	end

	gohelper.setActive(self.goTipBlock, true)
	gohelper.setAsLastSibling(self.goTipBlock)

	local cardLayoutAnchorX = recthelper.getAnchorX(self.rectCardLayout)
	local leftRemainWidth = self.halfViewWidth + cardLayoutAnchorX - self.selectDeviceWidth * 0.5 - math.abs(TipDefaultInterval)
	local isLeft = leftRemainWidth > self.descTipWidth
	local preHeight = 0

	for index, skillInfo in ipairs(groupSkillInfo.skills) do
		local descTipItem = self.descTipItemList[index]

		if not descTipItem then
			descTipItem = self:createDescTipItem(gohelper.cloneInPlace(self.goDescTip))

			table.insert(self.descTipItemList, descTipItem)
		end

		gohelper.setActive(descTipItem.goDescTip, true)
		FightDeviceCardTipView.refreshContent(skillInfo, cardItem:getUid(), descTipItem.txtTitle, descTipItem.txtDesc, descTipItem.txtCostPower, descTipItem.txtAddExPoint, descTipItem.imageEnergyIcon)

		if isLeft then
			descTipItem.rectDescTip.pivot = LeftPivot
			descTipItem.rectDescTip.anchorMin = LeftMinAndMax
			descTipItem.rectDescTip.anchorMax = LeftMinAndMax

			recthelper.setAnchorX(descTipItem.rectDescTip, LeftAnchor)
		else
			descTipItem.rectDescTip.pivot = RightPivot
			descTipItem.rectDescTip.anchorMin = RightMinAndMax
			descTipItem.rectDescTip.anchorMax = RightMinAndMax

			recthelper.setAnchorX(descTipItem.rectDescTip, RightAnchor)
		end

		recthelper.setAnchorY(descTipItem.rectDescTip, -preHeight)
		ZProj.UGUIHelper.RebuildLayout(descTipItem.rectDescTip)

		preHeight = preHeight + recthelper.getHeight(descTipItem.rectDescTip)

		gohelper.setAsLastSibling(descTipItem.goDescTip)
	end

	for i = #groupSkillInfo.skills + 1, #self.descTipItemList do
		gohelper.setActive(self.descTipItemList[i].goDescTip, false)
	end
end

function FightDeviceSwitchView:hideDescTip()
	for _, descTipItem in ipairs(self.descTipItemList) do
		gohelper.setActive(descTipItem.goDescTip, false)
	end

	gohelper.setActive(self.goTipBlock, false)
end

function FightDeviceSwitchView:refreshCurSelectDeviceInfo()
	local groupSkillList = self.deviceInfo.skills
	local index = 0
	local width = 0

	for groupSkillIndex, groupSkill in ipairs(groupSkillList) do
		if groupSkillIndex ~= self.selectIndex then
			index = index + 1

			local cardItem = self.cardItemList[index]

			if not cardItem then
				cardItem = FightDeviceSwitchCardItem.Create(self.goCardLayout)

				table.insert(self.cardItemList, cardItem)
			end

			cardItem:show()
			cardItem:refreshUI(self.uid, groupSkillIndex, groupSkill)
			cardItem:setAnchorX(width)

			width = width + FightDeviceHelper.getDeviceInfoWidth(self.deviceInfo, groupSkillIndex)
		end
	end

	self.selectDeviceWidth = width

	recthelper.setWidth(self.rectCardLayout, width)

	for i = index + 1, #self.cardItemList do
		self.cardItemList[i]:hide()
	end
end

FightDeviceSwitchView.OffsetX = 90

function FightDeviceSwitchView:updateCardLayoutPos()
	local curSelectDeviceCardItem = self.deviceArea:getCardItem(self.deviceInfo.uid)

	if curSelectDeviceCardItem then
		local rectTr = curSelectDeviceCardItem:getRectTr()

		if rectTr then
			local anchorX = recthelper.rectToRelativeAnchorPos2(rectTr.position, self.viewRect)

			anchorX = anchorX + FightDeviceSwitchView.OffsetX

			recthelper.setAnchorX(self.rectCardLayout, anchorX)
		end
	end
end

function FightDeviceSwitchView:refreshDeviceArea()
	if self.deviceArea then
		self.deviceArea:refreshUI()
		self.deviceArea:setDeviceCardItemActive(self.uid)
		self:refreshCurSelectDeviceInfo()
		self:updateCardLayoutPos()

		return
	end

	self.deviceArea = FightDeviceArea.Create(self.viewGO, FightDeviceArea.ViewType.FightSwitchView)

	self.deviceArea:setLoadDoneCallback(self.onDeviceAreaLoadDone, self)
	self.deviceArea:setDeviceCardItemCls(FightDeviceSwitchPlayCardItem)
	self.deviceArea:startLoad()
end

function FightDeviceSwitchView:onDeviceAreaLoadDone()
	local anchor, scale = FightPlayCardLayoutHelper.getAnchorPosAndScale(FightPlayCardLayoutHelper.PlayCardOperateType.DeviceCard)

	self.deviceArea:setDeviceAreaAnchor(anchor.x, anchor.y)
	self.deviceArea:setDeviceAreaScale(scale)
	self.deviceArea:setLineActive(false)
	self.deviceArea:setDeviceCardItemActive(self.uid)
	self:refreshCurSelectDeviceInfo()
	self:updateCardLayoutPos()

	local goDeviceArea = self.deviceArea:getGoDeviceArea()

	gohelper.setSibling(goDeviceArea, 1)
end

function FightDeviceSwitchView:onDestroyView()
	if self.bgClick then
		self.bgClick:RemoveClickListener()

		self.bgClick = nil
	end

	for _, cardItem in ipairs(self.cardItemList) do
		cardItem:dispose()
	end

	if self.deviceArea then
		self.deviceArea:dispose()

		self.deviceArea = nil
	end
end

return FightDeviceSwitchView
