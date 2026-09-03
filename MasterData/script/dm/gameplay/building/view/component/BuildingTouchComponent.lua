-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingTouchComponent.lua

BuildingTouchComponent = class("BuildingTouchComponent", DmBaseUI)

BuildingTouchComponent:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingTouchComponent:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BuildingTouchComponent:has("_buildingMediator", {
	is = "rw"
})

function BuildingTouchComponent:initialize(view)
	super.initialize(self, view)
	self:setupView()
end

function BuildingTouchComponent:dispose()
	super.dispose(self)
end

function BuildingTouchComponent:enterWithData(data)
	self._touchPoint = {}
	self._touchHeroInfo = nil
	self._canTouchScaleSta = false
	self._mapTouchMove = false

	self:initMultiLayer()
end

function BuildingTouchComponent:setupView()
	return
end

function BuildingTouchComponent:adjustLayout(targetFrame)
	return
end

function BuildingTouchComponent:initMultiLayer()
	local multiTouchLayer = self:getView()

	multiTouchLayer:setTouchMode(cc.EVENT_TOUCH_ALL_AT_ONCE)
	multiTouchLayer:setSwallowsTouches(false)
	multiTouchLayer:setTouchEnabled(true)
	multiTouchLayer:onTouch(handler(self, self.onTouchMultiTouchLayer), true, false)
end

function BuildingTouchComponent:onTouchMultiTouchLayer(event)
	if event.name == "began" then
		self:dealOnMultiTouchBegan(event)
	elseif event.name == "moved" then
		self:dealOnMultiTouchMoved(event)
	elseif event.name == "ended" then
		self:dealOnMultiTouchEnded(event)
	end
end

function BuildingTouchComponent:dealOnMultiTouchBegan(event)
	self._touchBeganDistance = -99999
	self._scrollViewPosition = self._buildingMediator:getScrollViewPosition()

	if self._buildingMediator:getActionRuning() then
		return
	end

	local operateInfo = self._buildingSystem:getOperateInfo()

	for k, v in pairs(event.points) do
		if self:getPointById(v.id, self._touchPoint) == nil then
			self._touchPoint[#self._touchPoint + 1] = v
		end
	end

	if #self._touchPoint > 1 then
		if operateInfo or self._touchHeroInfo or self._mapTouchMove then
			self._canTouchScaleSta = false

			return
		end

		self._canTouchScaleSta = true

		local p1 = self:getPointById(0, self._touchPoint)
		local p2 = self:getPointById(1, self._touchPoint)

		if p2 and p1 then
			self._touchBeganDistance = math.floor(cc.pGetDistance(cc.p(p1.x, p1.y), cc.p(p2.x, p2.y)))
		end
	else
		local p1 = self:getPointById(0, self._touchPoint)

		if p1 then
			if operateInfo then
				local buildingId = operateInfo.buildingId
				local pos = operateInfo.pos
				local config = self._buildingSystem:getBuildingConfig(buildingId)
				local operateType = operateInfo.operateType

				if config and config.IsMoved == 1 and self:getClickOnBuildingPosNew(p1, operateType) then
					operateInfo.touchEndPos = cc.p(pos.x, pos.y)
				end
			elseif self._buildingSystem:getMapShowType() == KBuildingMapShowType.kInRoom then
				local roomId = self._buildingSystem:getShowRoomId()
				local info = self:getClickOnHero(roomId, p1)

				if info then
					AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)

					self._touchHeroInfo = info
				end
			end
		end
	end
end

function BuildingTouchComponent:dealOnMultiTouchMoved(event)
	if self._buildingMediator:getActionRuning() then
		return
	end

	local operateInfo = self._buildingSystem:getOperateInfo()

	if #self._touchPoint > 1 then
		if self._canTouchScaleSta then
			local p1 = self:getPointById(0, event.points)
			local p2 = self:getPointById(1, event.points)

			if p2 == nil or p1 == nil or self._touchBeganDistance == -99999 then
				return
			end

			local length = math.floor(cc.pGetDistance(cc.p(p1.x, p1.y), cc.p(p2.x, p2.y)))
			local diffLen = length - self._touchBeganDistance

			if math.abs(diffLen) > 15 then
				if self._buildingSystem:getMapShowType() == KBuildingMapShowType.kAll then
					self._buildingMediator:changeCollectionViewSacleInAll(diffLen, cc.p((p1.x + p2.x) / 2, (p1.y + p2.y) / 2))
				elseif self._buildingSystem:getMapShowType() == KBuildingMapShowType.kInRoom then
					self._buildingMediator:changeCollectionViewSacleInRoom(diffLen, cc.p((p1.x + p2.x) / 2, (p1.y + p2.y) / 2))
				end

				self._touchBeganDistance = length

				self:setPointById(0, self._touchPoint, p1)
				self:setPointById(1, self._touchPoint, p2)
			end
		end
	elseif #self._touchPoint > 0 then
		local pointBegin = self:getPointById(0, self._touchPoint)
		local pointNow = self:getPointById(0, event.points)

		if pointBegin and pointNow and ((pointBegin and pointNow or nil) and cc.pGetDistance(cc.p(pointBegin.x, pointBegin.y), cc.p(pointNow.x, pointNow.y))) > 15 then
			if operateInfo then
				if operateInfo.touchEndPos then
					local decorateComponent = self._buildingMediator._decorateComponent
					local mainComponent = self._buildingMediator._mainComponent
					local posAgo = cc.p(operateInfo.touchEndPos.x, operateInfo.touchEndPos.y)
					local posNew, putSta = self:refresBuildingOnMoved(operateInfo, pointBegin, pointNow)

					if posNew and (posAgo.x ~= posNew.x or posAgo.y ~= posNew.y) then
						AudioEngine:getInstance():playEffect("Se_Click_Move", false)
						decorateComponent:refreshOperateBuildingPos(posNew, putSta)
						mainComponent:refreshLayerBtn()
					end
				end
			elseif self._touchHeroInfo then
				self:refreshHeroOnMoved(pointBegin, pointNow)
			else
				self._mapTouchMove = true

				local scrollPos = cc.p(pointNow.x - pointBegin.x + self._scrollViewPosition.x, pointNow.y - pointBegin.y + self._scrollViewPosition.y)

				self._buildingMediator:setScrollViewPosition(scrollPos)

				local decorateComponent = self._buildingMediator._decorateComponent

				decorateComponent:showAllBuilding()
				decorateComponent:showRoomHeroList()
			end
		end
	end
end

function BuildingTouchComponent:dealOnMultiTouchEnded(event)
	if self._buildingMediator:getActionRuning() then
		self._touchPoint = {}

		return
	end

	local operateInfo = self._buildingSystem:getOperateInfo()

	if #self._touchPoint > 1 and self._canTouchScaleSta then
		self._canTouchScaleSta = false

		local p1 = self:getPointById(0, self._touchPoint)
		local p2 = self:getPointById(1, self._touchPoint)

		self._touchPoint = {}

		if self._touchBeganDistance ~= -99999 then
			if self._buildingSystem:getMapShowType() == KBuildingMapShowType.kAll then
				if self._buildingMediator._collectionViewScale > self._buildingMediator._minCollectionViewScale then
					local firstRoomId = self._buildingSystem:getFristRoomId()

					self._buildingMediator:enterRoomByPos(cc.p((p1.x + p2.x) / 2, (p1.y + p2.y) / 2), firstRoomId)
				end
			elseif self._buildingSystem:getMapShowType() == KBuildingMapShowType.kInRoom and self._buildingMediator._collectionViewScale < KBUILDING_MAP_INROOM_SCALE then
				self._buildingMediator:enterShowAll()
			end
		end
	elseif #self._touchPoint > 0 then
		self._mapTouchMove = false

		local pointBegin = self:getPointById(0, self._touchPoint)
		local pointNow = self:getPointById(0, event.points)

		self._touchPoint = {}

		local distance = 0

		if pointBegin and pointNow then
			distance = cc.pGetDistance(cc.p(pointBegin.x, pointBegin.y), cc.p(pointNow.x, pointNow.y))
		end

		if operateInfo then
			if operateInfo.touchEndPos then
				operateInfo.pos = cc.p(operateInfo.touchEndPos.x, operateInfo.touchEndPos.y)
			end

			if distance <= 15 and operateInfo.operateType == KBuildingOperateType.kMove then
				self._buildingMediator:onMoveBuildingFinsh()
			end

			operateInfo.touchEndPos = nil
		elseif self._touchHeroInfo then
			self:refreshHeroOnEnd()

			self._touchHeroInfo = nil
		elseif pointNow and self._buildingSystem:getMapShowType() == KBuildingMapShowType.kAll then
			if distance <= 15 then
				self._buildingMediator:enterRoomByPos(pointNow)
			end
		elseif self._buildingSystem:getMapShowType() == KBuildingMapShowType.kInRoom then
			local tiledMapComponent = self._buildingMediator._tiledMapComponent

			if distance > 50 and pointNow and pointBegin then
				local roomId = tiledMapComponent:getRoomIdMoveTo(pointBegin, pointNow)

				if roomId and (self._buildingSystem:getRoomOpenSta(roomId) or self._buildingSystem:canUnlockRoom(roomId)) then
					self._buildingMediator:moveToRoom(roomId, 0.3)
				else
					if roomId then
						local _, des = self._buildingSystem:getRoomOpenSta(roomId)

						self:dispatch(ShowTipEvent({
							duration = 0.5,
							tip = des
						}))
					end

					self._buildingMediator:moveToRoom(self._buildingSystem:getShowRoomId(), 0.2)
				end
			elseif distance <= 15 and pointNow then
				local roomId = self._buildingSystem:getShowRoomId()

				if not self._buildingSystem:getRoomOpenSta(roomId) then
					AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
					self._buildingMediator:showUnlockRoom(roomId)
				else
					local decorateComponent = self._buildingMediator._decorateComponent
					local id = decorateComponent:getOnClickBuildId(roomId, pointNow)

					if id then
						local buildingUi = decorateComponent:getBuilding(roomId, id)

						if buildingUi and buildingUi._createSta then
							AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

							local buildingData = self._buildingSystem:getBuildingData(roomId, id)

							if buildingData:getResouseNum() > 0 then
								self._buildingSystem:sendOneKeyCollectRes("main")
							else
								local putHeroList = buildingData._putHeroList

								if #putHeroList <= 0 then
									if self._buildingSystem:getBuildingActive(roomId, id) then
										self._buildingMediator:onMoveBuilding(roomId, id)
									else
										self._buildingMediator:onActiveBuilding(roomId, id)
									end
								end
							end
						end
					end
				end
			else
				self._buildingMediator:moveToRoom(self._buildingSystem:getShowRoomId(), 0.2)
			end
		end
	end
end

function BuildingTouchComponent:getPointById(id, points)
	for k, v in pairs(points) do
		if v.id == id then
			v.x = math.floor(v.x)
			v.y = math.floor(v.y)

			return v
		end
	end

	return nil
end

function BuildingTouchComponent:setPointById(id, points, point)
	for k, v in pairs(points) do
		if v.id == id then
			v.x = point.x
			v.y = point.y
		end
	end
end

function BuildingTouchComponent:getContainPosSta(posList, pos)
	for k, v in pairs(posList) do
		if v.x == pos.x and v.y == pos.y then
			return true
		end
	end

	return false
end

function BuildingTouchComponent:getClickOnBuildingPos(roomId, buildingId, buildingPos, worldPos, revert)
	local tiledMapComponent = self._buildingMediator._tiledMapComponent
	local tiledPos = tiledMapComponent:getRoomTiledPos(roomId, worldPos)

	if tiledPos then
		local roomPos = self._buildingSystem:tiledPosToRoomPos(roomId, tiledPos)
		local posList = self._buildingSystem:getBuildingPosList(buildingId, buildingPos, revert)

		if self:getContainPosSta(posList, roomPos) then
			return true
		end
	end

	return false
end

function BuildingTouchComponent:getClickOnBuildingPosNew(worldPos, operateType)
	local decorateComponent = self._buildingMediator._decorateComponent

	return decorateComponent:isTouchOnOperateBuilding(operateType, worldPos)
end

function BuildingTouchComponent:refresBuildingOnMoved(buildingInfo, worldPosBegin, worldPosEnd)
	local roomId = buildingInfo.roomId
	local tiledMapComponent = self._buildingMediator._tiledMapComponent
	local tiledPosNow = tiledMapComponent:getRoomTiledPos(roomId, worldPosEnd)

	if tiledPosNow then
		local buildingId = buildingInfo.buildingId
		local tiledPosBegin = tiledMapComponent:getRoomTiledPos(roomId, worldPosBegin)
		local roomPosNow = self._buildingSystem:tiledPosToRoomPos(roomId, tiledPosNow)

		if self._buildingSystem:getBuildingInRoomSta(roomId, buildingId, roomPosNow, buildingInfo.revert) then
			local outPos
			local putSta = self._buildingSystem:getBuildingCanChangeToPos(roomId, buildingId, roomPosNow, (buildingInfo.id and buildingInfo.operateType == KBuildingOperateType.kMove or nil) and self._buildingSystem:getMapBuildingPosList(roomId, buildingInfo.id), buildingInfo.revert)

			buildingInfo.touchEndPos = cc.p(roomPosNow.x, roomPosNow.y)

			return roomPosNow, putSta
		end
	end
end

function BuildingTouchComponent:canCellPutHero(touchHeroInfo)
	local hero = touchHeroInfo.hero
	local posNow = hero._pos
	local heroId = hero._heroId
	local roomId = self._buildingSystem:getShowRoomId()
	local room = self._buildingSystem:getRoom(roomId)
	local building = room:getBuildingByPos(posNow)

	local function canPutToBuild(id)
		local building = room:getBuildingById(id)

		if building and building:canPutHeroSta() then
			local buildingUi = self._buildingMediator._decorateComponent:getBuilding(roomId, id)
			local buildingId = building._configId
			local config = self._buildingSystem:getBuildingConfig(buildingId)

			if config.UseType and config.UseType ~= "" and buildingUi then
				return true
			end
		end

		return false
	end

	if building then
		return canPutToBuild(building._id)
	elseif room:getHeroIdByPos(heroId, posNow) then
		return false
	end

	return true
end

function BuildingTouchComponent:getClickOnHero(roomId, worldPos)
	local tiledMapComponent = self._buildingMediator._tiledMapComponent
	local decorateComponent = self._buildingMediator._decorateComponent
	local tiledPos = tiledMapComponent:getRoomTiledPos(roomId, worldPos)
	local room = self._buildingSystem:getRoom(roomId)

	if tiledPos then
		local roomPos = self._buildingSystem:tiledPosToRoomPos(roomId, tiledPos)

		if room then
			local ___id = decorateComponent:getOnClickBuildId(roomId, worldPos)
			local building = self._buildingSystem:getBuildingData(roomId, ___id)

			if building then
				local heroId = building:getHeroId()

				if heroId then
					local buildHero = decorateComponent:getRoomHero(roomId, heroId)
					local info = {}

					info.hero = buildHero
					info.roomPos = cc.p(buildHero._pos.x, buildHero._pos.y)
					info.beginRoomPos = cc.p(roomPos.x, roomPos.y)
					info.id_build = building._id

					buildHero:getView():changeParent(decorateComponent:getView())
					buildHero:setRoomPosition(cc.p(roomPos.x, roomPos.y))
					buildHero:playLiftAction()
					building:removePutHero(heroId)

					if self._heroPickUpEffect then
						AudioEngine:getInstance():stopEffect(self._heroPickUpEffect)
					end

					local audioName = "Voice_" .. heroId .. "_06"

					self._heroPickUpEffect = AudioEngine:getInstance():playRoleEffect(audioName, false)

					return info
				end
			end
		end
	end

	if room then
		local heroList = room._heroPosList

		for k, v in pairs(heroList) do
			local decorateComponent = self._buildingMediator._decorateComponent
			local buildHero = decorateComponent:getRoomHero(roomId, k)

			if buildHero:getClickOnHeroAnim(worldPos) then
				local info = {}

				info.hero = buildHero
				info.roomPos = cc.p(v.x, v.y)
				info.beginRoomPos = cc.p(v.x, v.y)

				buildHero:playLiftAction()
				buildHero:showUnder(true)

				if self._heroPickUpEffect then
					AudioEngine:getInstance():stopEffect(self._heroPickUpEffect)
				end

				local audioName = "Voice_" .. buildHero._heroId .. "_06"

				self._heroPickUpEffect = AudioEngine:getInstance():playRoleEffect(audioName, false)

				return info
			end
		end
	end

	return nil
end

function BuildingTouchComponent:refreshHeroOnMoved(worldPosBegin, worldPosEnd)
	local roomId = self._buildingSystem:getShowRoomId()
	local tiledMapComponent = self._buildingMediator._tiledMapComponent
	local tiledPosNow = tiledMapComponent:getRoomTiledPos(roomId, worldPosEnd)

	if tiledPosNow then
		local hero = self._touchHeroInfo.hero
		local posAgo = hero._pos
		local roomPosNow = self._buildingSystem:tiledPosToRoomPos(roomId, tiledPosNow)
		local posNow = cc.p(roomPosNow.x, roomPosNow.y)
		local area = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "Area")

		if posNow.x >= 0 and posNow.x <= area[1] and posNow.y >= 0 and posNow.y <= area[2] and (posNow.x ~= posAgo.x or posNow.y ~= posAgo.y) then
			hero:setRoomPosition(posNow)

			self._touchHeroInfo.movedSta = true

			if self:canCellPutHero(self._touchHeroInfo) then
				hero:showUnder(true)
			else
				hero:showUnder(false)
			end
		end
	end
end

function BuildingTouchComponent:refreshHeroOnEnd()
	local hero = self._touchHeroInfo.hero
	local posNow = hero._pos
	local heroId = hero._heroId
	local roomId = self._buildingSystem:getShowRoomId()
	local room = self._buildingSystem:getRoom(roomId)
	local decorateComponent = self._buildingMediator._decorateComponent

	local function canPutToBuild(id)
		local building = room:getBuildingById(id)

		if building and building:canPutHeroSta() then
			local buildingUi = decorateComponent:getBuilding(roomId, id)
			local buildingId = building._configId
			local config = self._buildingSystem:getBuildingConfig(buildingId)

			if config.UseType and config.UseType ~= "" and buildingUi then
				local buildingPos = building._pos
				local offset, rotate = building:getHeroPutOffset()
				local heroPutNode = buildingUi._heroPutNode

				hero:getView():changeParent(heroPutNode)
				hero:resetHeightOffset()
				hero:switchHeroSta(config.UseType)
				hero:setBuildPosition(cc.p(buildingPos.x, buildingPos.y), offset)
				hero:setHeroRotate(rotate)
				building:addPutHero(hero._heroId, offset)

				return true
			end
		end

		return false
	end

	local function resetHeroAction(info)
		local id = info.id_build

		if not canPutToBuild(id) then
			hero:setRoomPosition(info.roomPos)
			hero:resetAction()
		end
	end

	local building = room:getBuildingByPos(posNow)

	if not self._touchHeroInfo.movedSta then
		resetHeroAction(self._touchHeroInfo)
	elseif building then
		if not canPutToBuild(building._id) then
			resetHeroAction(self._touchHeroInfo)
		end
	elseif room:getHeroIdByPos(heroId, posNow) then
		resetHeroAction(self._touchHeroInfo)
	else
		hero:setRoomPosition(hero._pos)
		hero:resetAction()
	end

	hero:hideUnder()
end
