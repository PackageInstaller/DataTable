-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/bag/BagItemIconHandler.lua

BagItemIconHandler = class("BagItemIconHandler", _G.DisposableObject, _M)

BagItemIconHandler:has("_entryId", {
	is = "rw"
})

function BagItemIconHandler:initialize(itemCellNode, bagSystem, itemCellTop)
	super.initialize(self)

	self._bagSystem = bagSystem
	self._itemCellTop = itemCellTop

	local pancel = self._pancel

	if pancel == nil then
		pancel = cc.Node:create()

		pancel:setName("pancel")
		pancel:addTo(itemCellNode, 1, 1):center(itemCellNode:getContentSize())

		self._pancel = pancel
	end
end

function BagItemIconHandler:decorateWithData(entryId)
	self._entryId = entryId

	local entry = self._bagSystem:getEntryById(entryId)
	local pancel = self._pancel

	pancel:removeAllChildren(true)

	if entry then
		local item = entry.item
		local page = item:getType()
		local subType = item:getSubType()
		local icon

		if ItemPages.kEquip == page and (subType == ItemTypes.K_EQUIP_NEW or subType == ItemTypes.K_EQUIP_NEW_ITEM) then
			icon = self:getEquipIcon(item, pancel)
		elseif ItemPages.kTsoul == page then
			icon = self:getTSoulIcon(item, pancel)
		else
			local addFragamentCanCompEffect = false
			local rarity
			local itemShine = item:getIsShineInBag()

			if page == ItemPages.kFragament and subType == ItemTypes.K_HERO_F then
				local heroSystem = self._bagSystem:getDevelopSystem():getHeroSystem()

				if heroSystem:checkHeroCanComp(item:getTargetId()) then
					addFragamentCanCompEffect = true
					itemShine = true
				end
			end

			icon = IconFactory:createIcon({
				id = item:getConfigId(),
				amount = entry.count,
				scaleRatio = (ItemTypes.K_EQUIP_EXP == subType or ItemTypes.K_EQUIP_STAREXP == subType or ItemTypes.K_EQUIP_STARITEM == subType or nil) and 0.8,
				rarity = rarity,
				lock = not entry.unlock
			}, {
				showAmount = true,
				shine = itemShine,
				showLock = item:getCanLock()
			})

			if addFragamentCanCompEffect == true then
				local anim = cc.MovieClip:create("dh_zhaohuantishi")

				anim:addEndCallback(function()
					anim:stop()
				end)
				anim:addTo(icon):posite(23, 15)

				local debrisIcon = icon:getChildByName("debrisIcon")

				if debrisIcon ~= nil then
					debrisIcon:setVisible(false)
				end
			end
		end

		icon:setName("icon")
		icon:setPosition(cc.p(0, 0))
		icon:addTo(pancel, 1, 1)
	end
end

function BagItemIconHandler:getEquipIcon(item, pancel)
	local equipData = item:getEquipData()
	local isConsumeEquip = equipData:getPosition() == HeroEquipType.kStarItem
	local star = isConsumeEquip and 1 or equipData:getStar()
	local icon = IconFactory:createEquipIcon({
		id = equipData:getEquipId(),
		level = equipData:getLevel(),
		star = star,
		rarity = equipData:getRarity(),
		lock = not equipData:getUnlock()
	})
	local heroId = equipData:getHeroId()

	if heroId ~= "" then
		local itemCellTop = self._itemCellTop:clone()

		itemCellTop:setVisible(true)
		itemCellTop:setName("itemCellTop")
		itemCellTop:addTo(pancel, 2, 2):center(pancel:getContentSize())

		local heroNode = itemCellTop:getChildByFullName("heroIcon")
		local heroInfo = {
			id = IconFactory:getRoleModelByKey("HeroBase", heroId)
		}
		local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

		headImgName:setScale(0.2)

		headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(31, 31))

		headImgName:addTo(heroNode):center(heroNode:getContentSize())
		icon:setColor(cc.c3b(131, 131, 131))
	end

	return icon
end

function BagItemIconHandler:getTSoulIcon(item, pancel)
	local icon = IconFactory:createTSoulIcon({
		id = item:getConfigId(),
		level = item:getLevel(),
		lock = item:getLock()
	})
	local heroId = item:getHeroId()

	if heroId ~= "" then
		local itemCellTop = self._itemCellTop:clone()

		itemCellTop:setVisible(true)
		itemCellTop:setName("itemCellTop")
		itemCellTop:addTo(pancel, 2, 2):center(pancel:getContentSize())

		local heroNode = itemCellTop:getChildByFullName("heroIcon")
		local heroInfo = {
			id = IconFactory:getRoleModelByKey("HeroBase", heroId)
		}
		local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

		headImgName:setScale(0.2)

		headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(31, 31))

		headImgName:addTo(heroNode):center(heroNode:getContentSize())
		icon:setColor(cc.c3b(131, 131, 131))
	end

	return icon
end

function BagItemIconHandler:getCellNode()
	if self._pancel then
		return self._pancel:getParent()
	end

	return nil
end
