-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingDecorateComponent.lua

BuildingDecorateComponent = class("BuildingDecorateComponent", DmBaseUI)

BuildingDecorateComponent:has("_buildingMediator", {
	is = "rw"
})
BuildingDecorateComponent:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingDecorateComponent:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

function BuildingDecorateComponent:initialize(view)
	super.initialize(self, view)
	self:setupView()

	self._roomList = {}
	self._roomHeroList = {}
	self._roomDecorateNodeList = {}
end

function BuildingDecorateComponent:dispose()
	super.dispose(self)
end

function BuildingDecorateComponent:enterWithData(endCallback)
	self._endCallback = endCallback

	self:refreshBuildingList(true)
	self:initBuildingDecorateQueue()
end

function BuildingDecorateComponent:setupView()
	return
end

function BuildingDecorateComponent:adjustLayout(targetFrame)
	return
end

function BuildingDecorateComponent:addBuilding(roomId, id, building)
	self._roomList[roomId] = self._roomList[roomId] or {}
	self._roomList[roomId][id] = building
end

function BuildingDecorateComponent:removeBuilding(roomId, id)
	if self._roomList[roomId] and self._roomList[roomId][id] then
		local building = self._roomList[roomId][id]

		self._roomList[roomId][id] = nil

		building:removeFromParent()
	end
end

function BuildingDecorateComponent:getBuilding(roomId, id)
	if self._roomList[roomId] and self._roomList[roomId][id] then
		return self._roomList[roomId][id]
	end

	return nil
end

function BuildingDecorateComponent:createDecorate(buildingInfo)
	return
end

function BuildingDecorateComponent:refreshBuildingList(isAllRoom)
	local roomList = self._buildingSystem:getRoomList()
	local scheduleList = {}
	local roomId = self._buildingSystem:getShowRoomId() or ""

	if roomId and roomId ~= "" then
		local list = self:refreshRoom(roomId, true)

		for k, v in pairs(list) do
			scheduleList[#scheduleList + 1] = v
		end
	end

	if isAllRoom then
		for k, v in pairs(roomList) do
			if roomId ~= k then
				local list = self:refreshRoom(k, true)

				for kk, vv in pairs(list) do
					scheduleList[#scheduleList + 1] = vv
				end
			end
		end
	end

	if #scheduleList > 0 then
		local loop = cc.Node:create()

		self:getView():addChild(loop)

		local step_index = 1
		local stepFunc

		loop:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.03333333333333333), cc.CallFunc:create(function()
			if step_index > #scheduleList then
				loop:stopAllActions()

				if self._endCallback then
					self._endCallback()

					self._endCallback = nil
				end

				return
			end

			local building = scheduleList[step_index]

			step_index = step_index + 1

			if not DisposableObject:isDisposed(building) and building._view then
				building:enterWithData()
			end
		end))))
	elseif self._endCallback then
		self._endCallback()

		self._endCallback = nil
	end
end

function BuildingDecorateComponent:showAllBuilding()
	for k, v in pairs(self._roomList) do
		for __, build in pairs(v) do
			build:show()
		end
	end
end

function BuildingDecorateComponent:refreshRoom(roomId, schedule)
	local view = self:getView()
	local room = self._buildingSystem:getRoom(roomId)
	local scheduleList = {}

	if room then
		local buildingList = room:getBuildingList()
		local placedBuildings = room:getPlacedBuildings()

		for k, v in pairs(placedBuildings) do
			local buildingData = buildingList[k]
			local showSta = self:getBuildingShowSta(buildingData._configId)

			if showSta and not self:getBuilding(roomId, k) then
				local node = cc.Node:create():addTo(view)
				local buildingDecorate = self:getInjector():instantiate("BuildingDecorate", {
					view = node
				})

				buildingDecorate:changeResourseScale(self._buildingSystem:getBuildResourceScale())

				node.__mediator = buildingDecorate

				buildingDecorate:setBuildingInfo(roomId, buildingData._configId, k)

				if schedule then
					scheduleList[#scheduleList + 1] = buildingDecorate
				else
					buildingDecorate:enterWithData()
				end

				self:addBuilding(roomId, k, buildingDecorate)
			end

			self:refreshBuilding(roomId, k)
		end
	end

	return scheduleList
end

function BuildingDecorateComponent:refreshRoomActivate(roomId)
	if self._roomList[roomId] then
		for k, v in pairs(self._roomList[roomId]) do
			v:refreshActive()
		end
	end
end

function BuildingDecorateComponent:autoShow(cell, row)
	return
end

function BuildingDecorateComponent:autoHide(cell, row)
	return
end

function BuildingDecorateComponent:refreshBuilding(roomId, id)
	local building = self:getBuilding(roomId, id)

	if building then
		local configId = building._buildingId

		if self:getBuildingShowSta(configId) then
			local buildingData = self._buildingSystem:getBuildingData(roomId, id)
			local cellPos = buildingData:getPos()

			self:refreshBuildingPos(building, cellPos)
			building:hideUnder()
			building:hideTurn()
			building:stopActionBrightness()
			building:hideName()
			building:show()
			building:refreshRotate(buildingData._revert)
		else
			building:hide()
		end
	end
end

function BuildingDecorateComponent:showBuyingBuilding()
	local view = self:getView()
	local info = self._buildingSystem:getOperateInfo()
	local roomId = info.roomId
	local buildingId = info.buildingId
	local pos = info.pos
	local node = cc.Node:create():addTo(view)

	node:setName("BuyingBuilding")

	local buildingDecorate = self:getInjector():instantiate("BuildingDecorate", {
		view = node
	})

	node.__mediator = buildingDecorate

	buildingDecorate:setBuildingInfo(roomId, buildingId)
	buildingDecorate:enterWithData()
	self:refreshBuildingPos(buildingDecorate, pos)

	if self._buildingSystem:getBuildCanTouchMove(info.buildingId) then
		buildingDecorate:showUnder(true)
	end

	if self._buildingSystem:getBuildCanTurn(info.buildingId) then
		buildingDecorate:showTurn()
	end

	buildingDecorate:showName()
	buildingDecorate:runActionBrightness()
end

function BuildingDecorateComponent:getBuyingBuilding()
	local view = self:getView()

	return view:getChildByName("BuyingBuilding")
end

function BuildingDecorateComponent:refreshOperateBuildingPos(pos, canPutSta)
	local building = self:getBuyingBuilding()

	building = building or self:getWarehouseBuilding()
	building = building or self:getOperationBuilding()

	if building and building.__mediator then
		self:refreshBuildingPos(building.__mediator, pos)
		building.__mediator:refreshUnder(canPutSta)
	end
end

function BuildingDecorateComponent:refreshOperateBuildingRevert()
	local building = self:getBuyingBuilding()

	building = building or self:getWarehouseBuilding()
	building = building or self:getOperationBuilding()

	if building and building.__mediator then
		local info = self._buildingSystem:getOperateInfo()

		building.__mediator:refreshRotate(info.revert)
	end
end

function BuildingDecorateComponent:removeBuyingBuilding()
	local building = self:getBuyingBuilding()

	if building then
		building:removeFromParent()
	end
end

function BuildingDecorateComponent:showWarehouseBuilding()
	local view = self:getView()
	local info = self._buildingSystem:getOperateInfo()
	local roomId = info.roomId
	local buildingId = info.buildingId
	local id = info.id
	local pos = info.pos
	local node = cc.Node:create():addTo(view)

	node:setName("WarehouseBuilding")

	local buildingDecorate = self:getInjector():instantiate("BuildingDecorate", {
		view = node
	})

	node.__mediator = buildingDecorate

	buildingDecorate:setBuildingInfo(roomId, buildingId, id)
	buildingDecorate:enterWithData()
	self:refreshBuildingPos(buildingDecorate, pos)
	buildingDecorate:showUnder(true)
	buildingDecorate:showName()
	buildingDecorate:runActionBrightness()

	if self._buildingSystem:getBuildCanTurn(info.buildingId) then
		buildingDecorate:showTurn()
	end
end

function BuildingDecorateComponent:getWarehouseBuilding()
	local view = self:getView()

	return view:getChildByName("WarehouseBuilding")
end

function BuildingDecorateComponent:removeWarehouseBuilding()
	local building = self:getWarehouseBuilding()

	if building then
		building:removeFromParent()
	end
end

function BuildingDecorateComponent:refreshBuildingPos(building, pos)
	local tileMapComponent = self._buildingMediator._tiledMapComponent
	local roomId = building._roomId
	local posNew = tileMapComponent:getBuildingMapPos(roomId, pos)

	posNew.x = posNew.x + KBUILDING_TILEMAP_CELL_OFFSET.x
	posNew.y = posNew.y + KBUILDING_TILEMAP_CELL_OFFSET.y

	building:getView():setPosition(posNew)

	local buildingId = building._buildingId
	local centerPos = self._buildingSystem:getBuildCenterPos(buildingId)
	local zorder = math.floor(posNew.y + centerPos.y)

	building:getView():setLocalZOrder(10000 - zorder)
end

function BuildingDecorateComponent:showOperationBuilding()
	local info = self._buildingSystem:getOperateInfo()

	if info and info.buildingId and info.roomId and info.id then
		local roomId = info.roomId
		local id = info.id
		local building = self._roomList[roomId][id]

		building:getView():setName("BuildingOperation")

		if self._buildingSystem:getBuildCanTouchMove(info.buildingId) then
			building:showUnder(true)
		end

		if self._buildingSystem:getBuildCanTurn(info.buildingId) then
			building:showTurn()
		end

		building:runActionBrightness()
		building:showName()
	end
end

function BuildingDecorateComponent:removeOperationBuilding()
	local building = self:getOperationBuilding()

	if building then
		building:setName("")
	end
end

function BuildingDecorateComponent:getOperationBuilding()
	local view = self:getView()

	return view:getChildByName("BuildingOperation")
end

function BuildingDecorateComponent:refreshBuildingCd(roomResList)
	roomResList = roomResList or {}

	local roomList = self._buildingSystem:getRoomList()
	local timeNow = self._gameServerAgent:remoteTimestamp()

	for k, v in pairs(roomList) do
		local buildingList = v:getBuildingList()
		local placedBuildings = v:getPlacedBuildings()
		local resList = roomResList[k]

		for kk, vv in pairs(placedBuildings) do
			local building = self:getBuilding(k, kk)

			if building then
				building:refreshCdNode()
				building:updateResouseNum()
				building:refreshLvUpImg()

				if resList and resList[kk] and resList[kk] > 0 then
					local buildWorldPos = building._resourceNode:convertToWorldSpace(cc.p(0, 0))
					local lootWidget = self._buildingMediator._lootComponent

					if lootWidget then
						local lootInfo = building:getLootInfo(resList[kk]) or {}
						local var_30_0 = {
							numLab = lootInfo.numLab
						}

						var_30_0.type = lootInfo.type or KBuildingType.kExpOre

						lootWidget:dropLoot(cc.p(buildWorldPos.x, buildWorldPos.y), var_30_0)
					end
				end
			end
		end
	end

	if self._buildingDecorateQueue then
		self._buildingDecorateQueue:update()
	end
end

function BuildingDecorateComponent:refreshBuildingResouse(roomId, id)
	if self._roomList[roomId] and self._roomList[roomId][id] then
		self._roomList[roomId][id]:updateResouseNum()
	end
end

function BuildingDecorateComponent:getBuildingShowSta(buildingId)
	if self._buildingSystem._mapShowType == KBuildingMapShowType.kInRoom then
		return true
	else
		return self._buildingSystem:getBuildingShowInAll(buildingId)
	end
end

function BuildingDecorateComponent:refreshBuildingLvInfo(roomId, id)
	local building = self:getBuilding(roomId, id)

	if building then
		building:refreshName()
	end
end

function BuildingDecorateComponent:refreshHeroList(sync)
	local roomList = self._buildingSystem:getRoomList()
	local scheduleList = {}
	local roomId = self._buildingSystem:getShowRoomId() or ""

	if roomId and roomId ~= "" then
		local list = self:refreshRoomHeroList(roomId, not sync)

		for k, v in pairs(list) do
			scheduleList[#scheduleList + 1] = v
		end
	end

	for k, v in pairs(roomList) do
		if roomId ~= k then
			local list = self:refreshRoomHeroList(k, not sync)

			for kk, vv in pairs(list) do
				scheduleList[#scheduleList + 1] = vv
			end
		end
	end

	if #scheduleList > 0 then
		local loop = cc.Node:create()

		self:getView():addChild(loop)

		local step_index = 1
		local stepFunc

		loop:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.03333333333333333), cc.CallFunc:create(function()
			if step_index > #scheduleList then
				loop:stopAllActions()

				return
			end

			local building = scheduleList[step_index]

			step_index = step_index + 1

			if not DisposableObject:isDisposed(building) and building._view then
				building:enterWithData()
			end
		end))))
	end
end

function BuildingDecorateComponent:instantiateBuildingHero(node)
	return self:getInjector():instantiate("BuildingHero", {
		view = node
	})
end

function BuildingDecorateComponent:refreshRoomHeroList(roomId, schedule)
	self._roomHeroList[roomId] = self._roomHeroList[roomId] or {}

	local view = self:getView()
	local room = self._buildingSystem:getRoom(roomId)
	local heroList = room:getHeroList()
	local scheduleList = {}

	for k, v in pairs(heroList) do
		if not self._roomHeroList[roomId][v] then
			local node = cc.Node:create():addTo(view)
			local buildingHero = self:instantiateBuildingHero(node)

			node.__mediator = buildingHero

			buildingHero:setHeroInfo(roomId, v, self._buildingMediator)
			self:addHero(roomId, v, buildingHero)

			if schedule then
				scheduleList[#scheduleList + 1] = buildingHero
			else
				buildingHero:enterWithData()
			end
		end
	end

	local idList = room:getHeroIdList()

	for k, v in pairs(self._roomHeroList[roomId]) do
		if not idList[k] then
			self:deleteHero(roomId, k)
		end
	end

	return scheduleList
end

function BuildingDecorateComponent:getRoomHero(roomId, heroId)
	if self._roomHeroList[roomId] then
		return self._roomHeroList[roomId][heroId]
	end
end

function BuildingDecorateComponent:showRoomHeroList()
	local roomId = self._buildingSystem:getShowRoomId()

	for k, v in pairs(self._roomHeroList) do
		for kk, vv in pairs(v) do
			if k == roomId then
				vv:checkPosChanged()
			end

			vv:show()
		end
	end
end

function BuildingDecorateComponent:hideRoomHeroList()
	for k, v in pairs(self._roomHeroList) do
		for kk, vv in pairs(v) do
			vv:hide()
		end
	end
end

function BuildingDecorateComponent:hideOtherRoomHeroList(isFadeout)
	local roomId = self._buildingSystem:getShowRoomId()

	for k, v in pairs(self._roomHeroList) do
		for kk, vv in pairs(v) do
			if k ~= roomId then
				vv:hide(isFadeout)
			end
		end
	end
end

function BuildingDecorateComponent:scheduleAddHero(heroList)
	return
end

function BuildingDecorateComponent:addHero(roomId, heroId, hero)
	self._roomHeroList[roomId] = self._roomHeroList[roomId] or {}
	self._roomHeroList[roomId][heroId] = hero
end

function BuildingDecorateComponent:deleteHero(roomId, heroId)
	if self._roomHeroList[roomId] and self._roomHeroList[roomId][heroId] then
		local buildingHero = self._roomHeroList[roomId][heroId]

		self._roomHeroList[roomId][heroId] = nil

		buildingHero:removeFromParent()
	end
end

function BuildingDecorateComponent:refreshHeroCd(roomId, heroId)
	for k, v in pairs(self._roomHeroList) do
		for kk, vv in pairs(v) do
			vv:updateOnlineTime()
			vv:updateHeroSta()
		end
	end
end

function BuildingDecorateComponent:initRankBtn()
	local view = self:getView()
	local res = "asset/ui/building/phb_entrance.png"
	local btn = ccui.Button:create(res, res)

	btn:addTo(view):posite(KBUILDING_RANK_BTN_MAP_POS.x, KBUILDING_RANK_BTN_MAP_POS.y)
	btn:setLocalZOrder(10000 - KBUILDING_RANK_BTN_MAP_POS.y)
	btn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._buildingMediator:onClickRankBtn()
		end
	end)
end

function BuildingDecorateComponent:getRoomDecorateNode(roomId, pos)
	self._roomDecorateNodeList[roomId] = self._roomDecorateNodeList[roomId] or {}

	local x = pos.x
	local y = pos.y
	local list = self._roomDecorateNodeList[roomId]

	list[x] = list[x] or {}

	local decorateNode = list[x][y]

	if not decorateNode then
		local area = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "Area")
		local view = self:getView()

		decorateNode = cc.Node:create():addTo(view)

		local tileMapComponent = self._buildingMediator._tiledMapComponent
		local posNew = tileMapComponent:getBuildingMapPos(roomId, pos)

		posNew.x = posNew.x + KBUILDING_TILEMAP_CELL_OFFSET.x
		posNew.y = posNew.y + KBUILDING_TILEMAP_CELL_OFFSET.y

		decorateNode:setPosition(posNew)

		local zroder = self._buildingSystem:getZorderByPos(roomId, pos)

		decorateNode:setLocalZOrder(zroder)
	end

	return decorateNode
end

function BuildingDecorateComponent:refreshBuildResourceSacle()
	local scale = self._buildingSystem:getBuildResourceScale()

	for _, v in pairs(self._roomList) do
		for __, build in pairs(v) do
			build:changeResourseScale(scale)
			build:showResoure()
		end
	end

	if self._buildingSystem._mapShowType == KBuildingMapShowType.kInRoom then
		if self._buildingDecorateQueue then
			self._buildingDecorateQueue:show()
		end
	elseif self._buildingDecorateQueue then
		self._buildingDecorateQueue:hide()
	end
end

function BuildingDecorateComponent:hideBuildResource()
	local scale = self._buildingSystem:getBuildResourceScale()

	for _, v in pairs(self._roomList) do
		for __, build in pairs(v) do
			build:hideResoure()
		end
	end
end

function BuildingDecorateComponent:hideOtherRoomBuilding(isFadeOut)
	local roomId = self._buildingSystem:getShowRoomId()

	for k, v in pairs(self._roomList) do
		for __, build in pairs(v) do
			if k ~= roomId then
				build:hide(isFadeOut)
			end
		end
	end
end

function BuildingDecorateComponent:getOnClickBuildId(roomId, worldPt)
	local building

	if roomId and roomId ~= "" then
		local buildingAll = self._roomList[roomId]

		if buildingAll then
			for k, v in pairs(buildingAll) do
				if building ~= nil then
					if building:getView():getPositionY() > v:getView():getPositionY() then
						local touchSta = v:isTouchOnBuilding(worldPt)

						if touchSta then
							building = v
						end
					end
				end
			end
		end
	end

	if building then
		return building._id
	end
end

function BuildingDecorateComponent:isTouchOnOperateBuilding(operateType, worldPt)
	local building

	if operateType == KBuildingOperateType.kMove then
		local node = self:getOperationBuilding()

		if node then
			building = node.__mediator
		end
	elseif operateType == KBuildingOperateType.kRecycle then
		local node = self:getWarehouseBuilding()

		if node then
			building = node.__mediator
		end
	elseif operateType == KBuildingOperateType.kBuy then
		local node = self:getBuyingBuilding()

		if node then
			building = node.__mediator
		end
	end

	if building then
		return building:isTouchOnBuilding(worldPt)
	end
end

function BuildingDecorateComponent:initBuildingDecorateQueue()
	local view = self:getView()
	local buildingDecorate = self:getInjector():getInstance("BuildingDecorateQueue")

	self._buildingDecorateQueue = self:getInjector():instantiate("BuildingDecorateQueue", {
		view = buildingDecorate
	})

	buildingDecorate:addTo(view):posite(KBUILDING_DECORATE_QUEUE_MAP_POS.x, KBUILDING_DECORATE_QUEUE_MAP_POS.y)
	buildingDecorate:setLocalZOrder(10000 - KBUILDING_DECORATE_QUEUE_MAP_POS.y + 100)
	self._buildingDecorateQueue:enterWithData()
end
