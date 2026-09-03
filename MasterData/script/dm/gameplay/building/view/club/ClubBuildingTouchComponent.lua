-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/club/ClubBuildingTouchComponent.lua

ClubBuildingTouchComponent = class("ClubBuildingTouchComponent", BuildingTouchComponent)

function ClubBuildingTouchComponent:initialize(view)
	super.initialize(self, view)
	self:setupView()
end

function ClubBuildingTouchComponent:dispose()
	super.dispose(self)
end

function ClubBuildingTouchComponent:enterWithData(data)
	super.enterWithData(self, data)
end

function ClubBuildingTouchComponent:onTouchMultiTouchLayer(event)
	if event.name == "began" then
		self:dealOnMultiTouchBegan(event)
	elseif event.name == "moved" then
		self:dealOnMultiTouchMoved(event)
	elseif event.name == "ended" then
		self:dealOnMultiTouchEnded(event)
	end
end

function ClubBuildingTouchComponent:dealOnMultiTouchBegan(event)
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
		self._touchHeroInfo = nil
	end
end

function ClubBuildingTouchComponent:dealOnMultiTouchEnded(event)
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

		if pointNow and self._buildingSystem:getMapShowType() == KBuildingMapShowType.kAll then
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
				-- block empty
			else
				self._buildingMediator:moveToRoom(self._buildingSystem:getShowRoomId(), 0.2)
			end
		end
	end
end
