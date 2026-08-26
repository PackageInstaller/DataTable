-- chunkname: @modules/logic/fightresistancetip/view/FightResistanceTipView.lua

module("modules.logic.fightresistancetip.view.FightResistanceTipView", package.seeall)

local FightResistanceTipView = class("FightResistanceTipView", BaseView)

function FightResistanceTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goresistance = gohelper.findChild(self.viewGO, "#go_resistance")
	self._scrollresistance = gohelper.findChildScrollRect(self.viewGO, "#go_resistance/#scroll_resistance")
	self._goresistanceitem = gohelper.findChild(self.viewGO, "#go_resistance/#scroll_resistance/viewport/content/#go_resistanceitem")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_resistance/#scroll_resistance/viewport/content")
	self._btnclosedetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closedetail")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_tips/#txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_tips/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightResistanceTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclosedetail:AddClickListener(self._btnclosedetailOnClick, self)
end

function FightResistanceTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclosedetail:RemoveClickListener()
end

function FightResistanceTipView:_btncloseOnClick()
	self:closeThis()
end

function FightResistanceTipView:_btnclosedetailOnClick()
	self:hideDescTip()
end

FightResistanceTipView.Interval = 10
FightResistanceTipView.MaxHeight = 535

function FightResistanceTipView:_editableInitView()
	self.goDetailClose = self._btnclosedetail.gameObject

	gohelper.setActive(self._goresistanceitem, false)
	self:hideDescTip()

	self.rectTrResistance = self._goresistance:GetComponent(gohelper.Type_RectTransform)
	self.rectTrTips = self._gotips:GetComponent(gohelper.Type_RectTransform)
	self.rectTrScrollResistance = self._scrollresistance:GetComponent(gohelper.Type_RectTransform)
	self.rectTrContent = self._gocontent:GetComponent(gohelper.Type_RectTransform)
	self.itemList = {}
	self.rectTrViewGo = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.rectTrView = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.viewWidth = recthelper.getWidth(self.rectTrView)
	self.resistanceWidth = recthelper.getWidth(self.rectTrResistance)
	self.tipWidth = recthelper.getWidth(self.rectTrTips)
end

function FightResistanceTipView:onOpen()
	self.screenPos = self.viewParam.screenPos

	self:buildResistanceList(self.viewParam.resistanceDict)
	self:refreshResistanceItem()
	self:setAnchor()
	self:calculateMaxHeight()
	self:changeScrollHeight()
end

function FightResistanceTipView:buildResistanceList(resistanceDict)
	self.resistanceList = self.resistanceList or {}
	self.resistanceDict = self.resistanceDict or {}

	tabletool.clear(self.resistanceList)
	tabletool.clear(self.resistanceDict)

	if not resistanceDict then
		return
	end

	self:buildResistanceListByReToughness(resistanceDict, FightEnum.Resistance.controlResilience)
	self:buildResistanceListByReToughness(resistanceDict, FightEnum.Resistance.delExPointResilience)
	self:buildResistanceListByReToughness(resistanceDict, FightEnum.Resistance.stressUpResilience)
	self:buildResistanceListByResistanceDict(resistanceDict)
end

function FightResistanceTipView:buildResistanceListByReToughness(resistanceDict, toughnessId)
	local resistanceList = FightEnum.ToughnessToResistance[toughnessId]
	local value = self:getResistanceValue(resistanceDict, toughnessId)

	self.tempResistanceList = self.tempResistanceList or {}

	tabletool.clear(self.tempResistanceList)

	if value and value > 0 then
		table.insert(self.resistanceList, {
			resistanceId = toughnessId,
			value = value
		})

		self.resistanceDict[toughnessId] = true

		for _, resistanceId in ipairs(resistanceList) do
			table.insert(self.tempResistanceList, {
				resistanceId = resistanceId,
				value = self:getResistanceValue(resistanceDict, resistanceId)
			})

			self.resistanceDict[resistanceId] = true
		end

		table.sort(self.tempResistanceList, FightResistanceTipView.sortResistance)

		for _, element in ipairs(self.tempResistanceList) do
			table.insert(self.resistanceList, element)
		end
	end
end

function FightResistanceTipView:buildResistanceListByResistanceDict(resistanceDict)
	self.tempResistanceList = self.tempResistanceList or {}

	tabletool.clear(self.tempResistanceList)

	for resistance, value in pairs(resistanceDict) do
		if value > 0 then
			local resistanceId = FightEnum.Resistance[resistance]

			if resistanceId and not self.resistanceDict[resistanceId] then
				table.insert(self.tempResistanceList, {
					resistanceId = resistanceId,
					value = self:getResistanceValue(resistanceDict, resistanceId)
				})

				self.resistanceDict[resistanceId] = true
			end
		end
	end

	if #self.tempResistanceList > 0 then
		table.sort(self.tempResistanceList, FightResistanceTipView.sortResistance)

		for _, element in ipairs(self.tempResistanceList) do
			table.insert(self.resistanceList, element)
		end
	end
end

function FightResistanceTipView:getResistanceValue(resistanceDict, resistanceId)
	local key = FightHelper.getResistanceKeyById(resistanceId)

	return (key or nil) and (resistanceDict[key] or 0)
end

function FightResistanceTipView:refreshResistanceItem()
	for index, resistance in pairs(self.resistanceList) do
		local resistanceItem = self.itemList[index]

		resistanceItem = resistanceItem or self:createResistanceItem()

		gohelper.setActive(resistanceItem.go, true)

		local attrCo = lua_character_attribute.configDict[resistance.resistanceId]

		UISpriteSetMgr.instance:setBuffSprite(resistanceItem.imageIcon, attrCo.icon)

		resistanceItem.attrCo = attrCo
		resistanceItem.txtName.text = attrCo.name
		resistanceItem.txtValue.text = string.format("%s%%", math.floor(resistance.value / 10))
	end

	for i = #self.resistanceList + 1, #self.itemList do
		gohelper.setActive(self.itemList[i].go, false)
	end

	self._scrollresistance.horizontalNormalizedPosition = 1
end

function FightResistanceTipView:calculateMaxHeight()
	local viewHeight = recthelper.getHeight(self.rectTrViewGo)
	local anchorY = math.abs(recthelper.getAnchorY(self.rectTrResistance))

	self.maxHeight = viewHeight - anchorY - 50
end

function FightResistanceTipView:setAnchor()
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(self.screenPos, self.rectTrView)

	recthelper.setAnchor(self.rectTrResistance, anchorX, anchorY)

	local leftRemainWidth = self.viewWidth - (math.abs(anchorX) + FightResistanceTipView.Interval + self.resistanceWidth)

	if leftRemainWidth >= self.tipWidth then
		recthelper.setAnchor(self.rectTrTips, anchorX - self.resistanceWidth - FightResistanceTipView.Interval, anchorY)
	else
		recthelper.setAnchor(self.rectTrTips, anchorX + FightResistanceTipView.Interval + self.tipWidth, anchorY)
	end
end

function FightResistanceTipView:changeScrollHeight()
	local curHeight = recthelper.getHeight(self.rectTrContent)

	curHeight = math.min(curHeight, self.maxHeight)

	recthelper.setHeight(self.rectTrScrollResistance, curHeight)
end

function FightResistanceTipView:createResistanceItem()
	local item = self:getUserDataTb_()

	item.go = gohelper.cloneInPlace(self._goresistanceitem)
	item.imageIcon = gohelper.findChildImage(item.go, "#image_icon")
	item.txtName = gohelper.findChildText(item.go, "#txt_name")
	item.txtValue = gohelper.findChildText(item.go, "#txt_value")
	item.btnDetails = gohelper.findChildClickWithDefaultAudio(item.go, "#txt_name/icon/#btn_details")

	item.btnDetails:AddClickListener(self.onClickResistanceItem, self, item)
	table.insert(self.itemList, item)

	return item
end

function FightResistanceTipView:onClickResistanceItem(item)
	self:showDescTip()

	local co = item.attrCo

	self._txtname.text = co.name
	self._txtdesc.text = co.desc
end

function FightResistanceTipView:showDescTip()
	gohelper.setActive(self.goDetailClose, true)
	gohelper.setActive(self._gotips, true)
end

function FightResistanceTipView:hideDescTip()
	gohelper.setActive(self.goDetailClose, false)
	gohelper.setActive(self._gotips, false)
end

function FightResistanceTipView.sortResistance(aResistance, bResistance)
	if aResistance.value ~= bResistance.value then
		return aResistance.value > bResistance.value
	end

	local aCo = lua_character_attribute.configDict[aResistance.resistanceId]
	local bCo = lua_character_attribute.configDict[bResistance.resistanceId]

	return aCo.sortId < bCo.sortId
end

function FightResistanceTipView:onClose()
	return
end

function FightResistanceTipView:onDestroyView()
	for _, item in ipairs(self.itemList) do
		item.btnDetails:RemoveClickListener()
	end

	self.itemList = nil
end

return FightResistanceTipView
