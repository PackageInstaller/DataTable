-- chunkname: @modules/logic/partygame/view/carddrop/CardDropFloatController.lua

module("modules.logic.partygame.view.carddrop.CardDropFloatController", package.seeall)

local CardDropFloatController = class("CardDropFloatController")

function CardDropFloatController:init(floatPrefab, goParent)
	self.floatPrefab = floatPrefab
	self.goParent = goParent
	self.rectParent = goParent:GetComponent(gohelper.Type_RectTransform)
	self.typeItemPool = {}
	self.typeGoDict = {}
	self.floatingItemDict = {}

	self:initPrefab(CardDropEnum.FloatType.Damage, gohelper.findChild(floatPrefab, "damage"))
	self:initPrefab(CardDropEnum.FloatType.CriticalDamage, gohelper.findChild(floatPrefab, "crit_damage"))
	self:initPrefab(CardDropEnum.FloatType.Restrain, gohelper.findChild(floatPrefab, "restrain"))
	self:initPrefab(CardDropEnum.FloatType.Heal, gohelper.findChild(floatPrefab, "heal"))

	self.updateHandle = UpdateBeat:CreateListener(self.frameUpdate, self)

	UpdateBeat:AddListener(self.updateHandle)

	self._inited = true
end

function CardDropFloatController:initPrefab(type, typeGo)
	self.typeGoDict[type] = typeGo
end

function CardDropFloatController:getTypeItem(type)
	local pool = self.typeItemPool[type]

	if not pool then
		pool = {}
		self.typeItemPool[type] = pool
	end

	local item = table.remove(pool)

	if item then
		return item
	end

	item = CardDropFloatItem.New()

	local go = self.typeGoDict[type]

	if not go then
		logError("type go is Nil : " .. tostring(type))

		go = self.typeGoDict[CardDropEnum.FloatType.Damage]
	end

	local itemGo = gohelper.clone(self.typeGoDict[type], self.goParent)

	item:init(itemGo, type)

	return item
end

function CardDropFloatController:floatDamage(uid, type, damage)
	if not self._inited then
		logError("float cleared")

		return
	end

	local floatItem = self:getTypeItem(type)
	local initAnchorX, initAnchorY = self:getAnchorPos(uid)
	local anchorY = initAnchorY + self:getFloatItemAnchorOffset(0)

	floatItem:showDamage(damage, initAnchorX, initAnchorY)

	local keyUid = tostring(uid)
	local floatingItemList = self.floatingItemDict[keyUid]

	if not floatingItemList then
		floatingItemList = {}
		self.floatingItemDict[keyUid] = floatingItemList
	end

	local existLen = #floatingItemList

	for i, existFloatItem in ipairs(floatingItemList) do
		existFloatItem:tweenAnchorY(initAnchorY + self:getFloatItemAnchorOffset(existLen - i + 1))
	end

	table.insert(floatingItemList, floatItem)
end

function CardDropFloatController:frameUpdate()
	if not self.floatingItemDict then
		return
	end

	for _, floatingItemList in pairs(self.floatingItemDict) do
		for index = #floatingItemList, 1, -1 do
			local floatItem = floatingItemList[index]

			if floatItem:checkFloatDone() then
				table.remove(floatingItemList, index)
				self:recycleFloatItem(floatItem)
			end
		end
	end
end

function CardDropFloatController:recycleFloatItem(floatItem)
	if not floatItem then
		return
	end

	floatItem:hide()
	table.insert(self.typeItemPool[floatItem.type], floatItem)
end

function CardDropFloatController:getAnchorPos(uid)
	local entity = CardDropGameController.instance:getEntity(uid)

	if not entity then
		return 0, 0
	end

	local screenPos = entity:getScreenPos()
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(screenPos, self.rectParent)

	return anchorX, anchorY + CardDropEnum.FloatItemInitOffsetY
end

function CardDropFloatController:getFloatItemAnchorOffset(index)
	return index * CardDropEnum.FloatItemHeight
end

function CardDropFloatController:clear()
	UpdateBeat:RemoveListener(self.updateHandle)

	self.updateHandle = nil

	for _, pool in pairs(self.typeItemPool) do
		for _, floatItem in ipairs(pool) do
			floatItem:destroy()
		end

		tabletool.clear(pool)
	end

	tabletool.clear(self.typeItemPool)

	self.typeItemPool = nil

	for _, floatingItemList in pairs(self.floatingItemDict) do
		for _, floatItem in ipairs(floatingItemList) do
			floatItem:destroy()
		end

		tabletool.clear(floatingItemList)
	end

	tabletool.clear(self.floatingItemDict)

	self.floatingItemDict = nil

	tabletool.clear(self.typeGoDict)

	self.typeGoDict = nil
	self.floatPrefab = nil
	self._inited = nil
end

CardDropFloatController.instance = CardDropFloatController.New()

return CardDropFloatController
