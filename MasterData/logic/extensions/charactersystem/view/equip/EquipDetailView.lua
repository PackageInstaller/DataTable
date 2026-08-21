-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipDetailView.lua

module("logic.extensions.charactersystem.view.equip.EquipDetailView", package.seeall)

local M = class("EquipDetailView", ViewComponent)

function M:buildUI()
	local imageGo = self:getGo("9&left_equip_show_1433712717")

	self._equipModelComponent = Astral.LuaComponentContainer.Add(imageGo, EquipModelComponent)

	local equipDetailGo = self:getGo("10&backpack_equip_detail_tips_copy_154087081")

	self._equipDetailComp = Astral.LuaComponentContainer.Add(equipDetailGo, EquipDetailInfoComponent)

	self._equipDetailComp:buildUI()
	self._equipDetailComp:setShowAddValue(true)
	self._equipDetailComp:setShowDice(false)

	self._goDicePos = self:getGo("9&left_equip_show_-607703290")
	self._goDice = self:getGo("9&left_equip_show_880822175")

	goutil.setActive(self._goDice, false)

	self._pos = {}
	self._posGoList = {}

	for i = 1, EquipEnum.MaxDiceCount do
		local pos = {}
		local go = goutil.findChild(self._goDicePos, "pos" .. i)

		goutil.setActive(go, false)

		for j = 1, i do
			pos[j] = goutil.findChild(go, "p" .. j)
		end

		self._pos[i] = pos
		self._posGoList[i] = go
	end
end

function M:bindEvents()
	self._equipDetailComp:bindEvents()
	GlobalDispatcher:addEventListener(EventType.EQUIP_INTESIFY_DETAIL_UPDATE, self._handleUpdateView, self)
end

function M:unbindEvents()
	self._equipDetailComp:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.EQUIP_INTESIFY_DETAIL_UPDATE, self._handleUpdateView, self)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.EQUIP_INFO_REFRESH, self._onEquipInfoChanged, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._onEquipInfoChanged, self)
	else
		GlobalDispatcher:removeEventListener(EventType.EQUIP_INFO_REFRESH, self._onEquipInfoChanged, self)
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._onEquipInfoChanged, self)
	end
end

function M:onEnter()
	self:_setEvent(true)
	self._equipModelComponent:onEnter()
end

function M:onExit()
	self:_setEvent(false)
	self._equipModelComponent:onExit()
end

function M:destroyUI()
	self._equipModelComponent:OnDestroy()
end

function M:_onEquipInfoChanged(e)
	if self._tabIndex ~= EquipEnum.IntensifyViewPage.Detail or not self._equipmentData then
		return
	end

	self._equipmentData = ItemModel.instance:getItemDataByUuid(self._equipmentData:getUuid())

	self:_refreshDetailView()
end

function M:_handleUpdateView(e, equipmentData, tabIndex)
	self._tabIndex = tabIndex

	if self._tabIndex ~= EquipEnum.IntensifyViewPage.Detail then
		return
	end

	self._equipmentData = equipmentData

	self:_refreshModelView()
	self:_refreshDiceView()
	self:_refreshDetailView()
end

function M:_refreshDetailView()
	self._equipDetailComp:setEquipData(self._equipmentData)
end

function M:_refreshModelView()
	self._equipModelComponent:setEquipData(self._equipmentData)
	self._equipModelComponent:setModelPos(EquipUtil.EquipIntensifyModelPos)
	self._equipModelComponent:refreshView()
end

function M:_refreshDiceView()
	if not self._diceItemList then
		self._diceItemList = {}
	end

	local totalNum = self._equipmentData:getExtraDiceAttrNum()

	if self._equipmentData:hasOriginalD6() then
		totalNum = totalNum + 1
	end

	for i = 1, EquipEnum.MaxDiceCount do
		goutil.setActive(self._posGoList[i], i == totalNum)
	end

	local enhances = {}
	local diceList = self._equipmentData:getAllDiceAttr()
	local unlockLevelList = EquipmentConfig.instance:getConstNumList("DiceAttrUnlockLevels")
	local index = 1

	for i = index, totalNum do
		if not self._diceItemList[i] then
			local itemGo = goutil.clone(self._goDice)
			local item = Astral.LuaComponentContainer.Add(itemGo, EquipDetailViewDiceItem)

			self._diceItemList[i] = item
		end

		local diceAttrMO = diceList[i]

		if diceAttrMO then
			self._diceItemList[i]:setData(EquipEnum.DiceStatus.Unlock, diceAttrMO)

			if diceAttrMO:isEnhanced() then
				local enhanceType = diceAttrMO:getEnhanceType()

				if enhances[enhanceType] then
					table.insert(enhances[enhanceType], index)
				else
					enhances[enhanceType] = {
						index
					}
				end
			end
		else
			local unlockLevel = self._equipmentData:hasOriginalD6() and unlockLevelList[i - 1] or unlockLevelList[i]

			self._diceItemList[i]:setData(EquipEnum.DiceStatus.Lock, diceAttrMO, unlockLevel)
		end

		self._diceItemList[index]:closeEnhanceAni()
		self._diceItemList[index]:setVisible(true)
		self._diceItemList[index]:setPos(self._pos[totalNum][i])

		index = index + 1
	end

	for _, v in pairs(enhances) do
		local enhanceNum = #v

		if enhanceNum and enhanceNum > 1 then
			for k, itemIndex in ipairs(v) do
				local itemView = self._diceItemList[itemIndex]

				itemView:playEnhanceAni()
			end
		end
	end

	for i = index, #self._diceItemList do
		self._diceItemList[i]:setVisible(false)
	end
end

return M
