-- chunkname: @modules/logic/survival/view/map/SurvivalSmallMapView.lua

module("modules.logic.survival.view.map.SurvivalSmallMapView", package.seeall)

local SurvivalSmallMapView = class("SurvivalSmallMapView", BaseView)
local itemSize = 115
local minScaleValue = 0.5
local maxScaleValue = 1.5
local v2zero = Vector2()

function SurvivalSmallMapView:onInitView()
	self._goscroll = gohelper.findChild(self.viewGO, "container")
	self._scroll = self._goscroll:GetComponent(gohelper.Type_LimitedScrollRect)
	self._mapRoot = gohelper.findChild(self.viewGO, "container/#go_map").transform
	self._gomapItem = gohelper.findChild(self.viewGO, "container/#go_map/mapitems/#go_mapitem")
	self._gowarmItem = gohelper.findChild(self.viewGO, "container/#go_map/warming/#go_warning")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._slider = gohelper.findChildSlider(self.viewGO, "Right/#go_mapSlider")
	self._btnup = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_up")
	self._btndown = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_down")
end

function SurvivalSmallMapView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnup:AddClickListener(self.setScaleByBtn, self, 1)
	self._btndown:AddClickListener(self.setScaleByBtn, self, -1)
	self._slider:AddOnValueChanged(self.onSliderValueChange, self)

	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self._scroll.gameObject)

	self._touchEventMgr:SetIgnoreUI(true)
	self._touchEventMgr:SetOnMultiDragCb(self.onScaleHandler, self)
	self._touchEventMgr:SetScrollWheelCb(self.onMouseScrollWheelChange, self)
end

function SurvivalSmallMapView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnup:RemoveClickListener()
	self._btndown:RemoveClickListener()
	self._slider:RemoveOnValueChanged()

	if self._touchEventMgr then
		TouchEventMgrHepler.remove(self._touchEventMgr)

		self._touchEventMgr = nil
	end
end

function SurvivalSmallMapView:onOpen()
	if BootNativeUtil.isMobilePlayer() then
		TaskDispatcher.runRepeat(self._checkMultDrag, self, 0, -1)
	end

	self._scale = 1

	self._slider:SetValue((1 - minScaleValue) / (maxScaleValue - minScaleValue))
	gohelper.setActive(self._gomapItem, false)

	local mapCo = SurvivalMapModel.instance:getCurMapCo()

	self._mapCo = mapCo

	recthelper.setWidth(self._mapRoot, (self._mapCo.maxX - self._mapCo.minX + 2) * itemSize)
	recthelper.setHeight(self._mapRoot, (self._mapCo.maxY - self._mapCo.minY + 2) * itemSize)

	self._allItemDatas = {}

	for k, blockCo in pairs(mapCo.allBlocks) do
		local pos = blockCo.pos

		table.insert(self._allItemDatas, {
			pos = pos,
			blockCo = blockCo,
			hightValue = tabletool.indexOf(mapCo.allHightValueNode, pos)
		})

		for i, exPos in ipairs(blockCo.exNodes) do
			table.insert(self._allItemDatas, {
				pos = exPos,
				blockCo = blockCo,
				hightValue = tabletool.indexOf(mapCo.allHightValueNode, exPos)
			})
		end
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local allUnits = sceneMo.units

	table.sort(allUnits, SurvivalSceneMo.sortUnitMo)

	local find = false

	for _, unitMo in ipairs(allUnits) do
		find = false

		for _, data in ipairs(self._allItemDatas) do
			if data.pos == unitMo.pos then
				find = true
				data.unitMos = data.unitMos or {}

				table.insert(data.unitMos, unitMo)

				break
			end
		end

		if not find then
			table.insert(self._allItemDatas, {
				walkable = false,
				hightValue = false,
				pos = unitMo.pos,
				unitMos = {
					unitMo
				}
			})
		end
	end

	find = false

	for _, data in ipairs(self._allItemDatas) do
		if data.pos == sceneMo.player.pos then
			data.unitMos = nil
			data.unitMo = sceneMo.player
			find = true

			break
		end
	end

	if not find then
		table.insert(self._allItemDatas, {
			walkable = false,
			hightValue = false,
			pos = sceneMo.player.pos,
			unitMo = sceneMo.player
		})
	end

	local scrollTrans = self._goscroll.transform
	local scrollWidth = recthelper.getWidth(scrollTrans)
	local scrollHeight = recthelper.getHeight(scrollTrans)
	local x, y = self:hexToRectPos(sceneMo.player.pos.q, sceneMo.player.pos.r)

	x = -x + scrollWidth / 2 - itemSize / 2
	y = -y + scrollHeight / 2 - itemSize / 2

	recthelper.setAnchor(self._mapRoot, x, y)

	local exitPos = sceneMo.exitPos

	for _, data in ipairs(self._allItemDatas) do
		local dis = SurvivalHelper.instance:getDistance(data.pos, exitPos)

		data.isInRain = dis > sceneMo.circle
	end

	self._allMulIcons = {}
	self._curCreateIndex = 0

	TaskDispatcher.runRepeat(self.frameToCreateItems, self, 0)
	self:createWarmItems()
end

function SurvivalSmallMapView:createWarmItems()
	local mapCo = SurvivalMapModel.instance:getCurMapCo()
	local exitPos = mapCo.exitPos
	local dis = 0
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local shrinkInfoMo = sceneMo.safeZone[1]

	if shrinkInfoMo and shrinkInfoMo.round ~= 1 then
		dis = shrinkInfoMo.finalCircle
	end

	if dis <= 0 then
		return
	end

	for q = -dis, dis do
		for r = -dis, dis do
			for s = -dis, dis do
				if q + r + s == 0 and (math.abs(q) == dis or math.abs(r) == dis or math.abs(s) == dis) then
					self:createWarmItem(q, r, s, dis, exitPos)
				end
			end
		end
	end
end

function SurvivalSmallMapView:createWarmItem(q, r, s, dis, exitPos)
	local item = gohelper.cloneInPlace(self._gowarmItem)

	gohelper.setActive(item, true)

	local x, y = self:hexToRectPos(q + exitPos.q, r + exitPos.r)

	transformhelper.setLocalPos(item.transform, x, y, 0)

	local isShowDir = {}

	isShowDir[0] = q == dis or s == -dis
	isShowDir[1] = s == -dis or r == dis
	isShowDir[2] = r == dis or q == -dis
	isShowDir[3] = q == -dis or s == dis
	isShowDir[4] = s == dis or r == -dis
	isShowDir[5] = r == -dis or q == dis

	for i = 0, 5 do
		local dirGo = gohelper.findChild(item, tostring(i))

		gohelper.setActive(dirGo, isShowDir[i])
	end
end

function SurvivalSmallMapView:frameToCreateItems()
	for i = 1, 50 do
		self._curCreateIndex = self._curCreateIndex + 1

		local data = self._allItemDatas[self._curCreateIndex]

		if not data then
			TaskDispatcher.cancelTask(self.frameToCreateItems, self)

			if #self._allMulIcons > 0 then
				TaskDispatcher.runRepeat(self.autoSwitchIcon, self, 1)
			end

			break
		end

		self:createItem(data)
	end
end

function SurvivalSmallMapView:autoSwitchIcon()
	for _, data in ipairs(self._allMulIcons) do
		ZProj.TweenHelper.DoFade(data.icon, 1, 0, 0.2)
	end

	TaskDispatcher.runDelay(self.autoSwitchIcon2, self, 0.2)
end

function SurvivalSmallMapView:autoSwitchIcon2()
	for _, data in ipairs(self._allMulIcons) do
		data.curIndex = data.curIndex + 1

		if data.curIndex > #data.list then
			data.curIndex = 1
		end

		UISpriteSetMgr.instance:setSurvivalSprite(data.icon, data.list[data.curIndex])
		ZProj.TweenHelper.DoFade(data.icon, 0, 1, 0.2)
	end
end

function SurvivalSmallMapView:onClickModalMask()
	self:closeThis()
end

local unitTypeToIconName = {
	[SurvivalEnum.UnitType.Treasure] = "survival_smallmap_block_3_5",
	[SurvivalEnum.UnitType.Exit] = "survival_smallmap_block_3_8",
	[SurvivalEnum.UnitType.Door] = "survival_smallmap_block_3_9"
}
local blockToIconName = {
	[SurvivalEnum.UnitSubType.Miasma] = "survival_smallmap_block_5_2",
	[SurvivalEnum.UnitSubType.Morass] = "survival_smallmap_block_5_2",
	[SurvivalEnum.UnitSubType.Magma] = "survival_smallmap_block_5_2",
	[SurvivalEnum.UnitSubType.Ice] = "survival_smallmap_block_5_2",
	[SurvivalEnum.UnitSubType.Water] = "survival_smallmap_block_5_2"
}

function SurvivalSmallMapView:createItem(data)
	local pos = data.pos
	local item = gohelper.cloneInPlace(self._gomapItem)

	if SurvivalMapModel.instance:isInFog2(pos) then
		gohelper.setActive(item, false)

		return
	end

	gohelper.setActive(item, true)

	local x, y = self:hexToRectPos(pos.q, pos.r)

	transformhelper.setLocalPos(item.transform, x, y, 0)

	local block = gohelper.findChildImage(item, "#image_block")
	local icon = gohelper.findChildImage(item, "#image_icon")
	local hero = gohelper.findChild(item, "#go_hero")
	local imgHero = gohelper.findChildImage(item, "#go_hero")
	local rain = gohelper.findChild(item, "#go_rain")
	local multiple = gohelper.findChild(item, "#go_multiple")
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local co = sceneMo:getBlockCoByPos(pos)

	if co and blockToIconName[co.subType] then
		UISpriteSetMgr.instance:setSurvivalSprite(block, blockToIconName[co.subType])
	else
		UISpriteSetMgr.instance:setSurvivalSprite(block, data.hightValue and "survival_smallmap_block_4" or "survival_smallmap_block_0")
	end

	local walkable = data.walkable or co and co.subType ~= SurvivalEnum.UnitSubType.Block or true

	if data.unitMo then
		local isShowHero = data.unitMo.id == 0

		gohelper.setActive(hero, isShowHero)

		if isShowHero then
			local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
			local cardPath = lua_survival_role.configDict[survivalShelterRoleMo.roleId].mapHead

			UISpriteSetMgr.instance:setSurvivalSprite2(imgHero, cardPath)
		end

		gohelper.setActive(rain, data.isInRain)

		local iconList = {}

		if data.unitMos then
			for _, unitMo in ipairs(data.unitMos) do
				table.insert(iconList, self:getIcon(unitMo))
			end
		end

		gohelper.setActive(icon, #iconList > 0 or not walkable)
		gohelper.setActive(multiple, #iconList > 1)

		if #iconList > 1 then
			table.insert(self._allMulIcons, {
				curIndex = 1,
				icon = icon,
				list = iconList
			})
		end

		if iconList[1] then
			UISpriteSetMgr.instance:setSurvivalSprite(icon, iconList[1])
		elseif not walkable then
			UISpriteSetMgr.instance:setSurvivalSprite(icon, "survival_smallmap_block_2")
		end
	end
end

function SurvivalSmallMapView:getIcon(unitMo)
	if not unitMo then
		return
	end

	local unitType = unitMo.unitType
	local subType = unitMo.co.subType

	if unitMo.visionVal == 8 then
		return "survival_smallmap_block_3_10"
	elseif unitType == SurvivalEnum.UnitType.NPC then
		return subType == 53 and "survival_smallmap_block_3_13" or "survival_smallmap_block_3_2"
	elseif unitType == SurvivalEnum.UnitType.Search then
		local isSearched = unitMo:isSearched()

		if subType == 392 then
			return isSearched and "survival_smallmap_block_3_16" or "survival_smallmap_block_3_15"
		else
			return isSearched and "survival_smallmap_block_3_4" or "survival_smallmap_block_3_3"
		end
	elseif unitType == SurvivalEnum.UnitType.Battle then
		local isElite = subType == 41 or subType == 43
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local roleLevel = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo.level
		local fightLv = unitMo.co.fightLevel
		local canSkip = unitMo.co.skip == 1 and fightLv <= roleLevel

		if canSkip then
			return isElite and "survival_smallmap_block_3_12" or "survival_smallmap_block_3_11"
		else
			return isElite and "survival_smallmap_block_3_7" or "survival_smallmap_block_3_6"
		end
	elseif unitType == SurvivalEnum.UnitType.Task then
		if subType == 77 then
			return "survival_smallmap_block_3_17"
		else
			return "survival_smallmap_block_3_1"
		end
	else
		return unitTypeToIconName[unitType]
	end
end

function SurvivalSmallMapView:hexToRectPos(q, r)
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(q, r)

	return (x - self._mapCo.minX + 0.5) * itemSize, (z - self._mapCo.minY + 0.5) * itemSize
end

function SurvivalSmallMapView:onScaleHandler(isEnLarger, delta)
	self.startDragPos = nil

	self:setScale(self._scale * (1 + delta * 0.01))
end

function SurvivalSmallMapView:onMouseScrollWheelChange(deltaData)
	self:setScale(self._scale * (1 + deltaData))
end

function SurvivalSmallMapView:onSliderValueChange()
	self:setScale(minScaleValue + (maxScaleValue - minScaleValue) * self._slider:GetValue(), true)
end

function SurvivalSmallMapView:setScaleByBtn(delta)
	self:setScale(self._scale + delta * 0.1)
end

function SurvivalSmallMapView:setScale(scale, noSetSlider)
	scale = Mathf.Clamp(scale, minScaleValue, maxScaleValue)

	if scale == self._scale then
		return
	end

	if not noSetSlider then
		self._slider:SetValue((scale - minScaleValue) / (maxScaleValue - minScaleValue))
	end

	local x, y = transformhelper.getLocalPos(self._mapRoot)

	x = x / self._scale * scale
	y = y / self._scale * scale
	self._scale = scale

	transformhelper.setLocalPosXY(self._mapRoot, x, y)
	transformhelper.setLocalScale(self._mapRoot, self._scale, self._scale, 1)

	self._scroll.velocity = v2zero
end

function SurvivalSmallMapView:setCanScroll(canScroll)
	if self._canScroll == nil then
		self._canScroll = true
	end

	if canScroll ~= self._canScroll then
		self._canScroll = canScroll

		if gohelper.isNil(self._scroll) then
			return
		end

		if not canScroll then
			self._scroll:StopMovement()

			self._scroll.velocity = v2zero
		end

		self._scroll.horizontal = canScroll
		self._scroll.vertical = canScroll
	end
end

function SurvivalSmallMapView:_checkMultDrag()
	self:setCanScroll(UnityEngine.Input.touchCount <= 1)
end

function SurvivalSmallMapView:onDestroyView()
	TaskDispatcher.cancelTask(self.frameToCreateItems, self)
	TaskDispatcher.cancelTask(self._checkMultDrag, self)
	TaskDispatcher.cancelTask(self.autoSwitchIcon, self)
	TaskDispatcher.cancelTask(self.autoSwitchIcon2, self)
end

return SurvivalSmallMapView
