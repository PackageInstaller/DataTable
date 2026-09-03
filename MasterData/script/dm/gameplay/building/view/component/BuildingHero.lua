-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingHero.lua

BuildingHero = class("BuildingHero", DmBaseUI)

BuildingHero:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingHero:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BuildingHero:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local heroZorder = {
	KUi = 3,
	kSkin = 1,
	kUnder = 0
}
local heroMoveDir = {
	kRight = 1,
	kDown = 4,
	kLeft = 3,
	kUp = 2
}
local heroDirScale = {
	1,
	-1,
	-1,
	1
}
local heroMoveTime = 2.5
local moveActionTag = 90960
local heroAnimSize = cc.size(100, 150)

function BuildingHero:initialize(view)
	super.initialize(self, view)
	self:setupView()

	self._baseNode = cc.Node:create()
	self._createSta = false

	self:getView():addChild(self._baseNode)
end

function BuildingHero:dispose()
	super.dispose(self)
end

function BuildingHero:enterWithData()
	self._currentState = nil
	self._heroDir = heroMoveDir.kRight
	self._prayNextTime = 0
	self._prayEndTime = 0
	self._heroRotate = 0
	self._standTime = self._gameServerAgent:remoteTimeMillis() + self:getIdelTime()
	self._walkEndTime = 0
	self._scale = 0.9
	self._pos = cc.p(0, 0)
	self._heroOffset = cc.p(0, 0)
	self._putOnId = ""

	self:resetRandomPos()
	self:initHeroAnim()

	self._createSta = true

	self:switchHeroSta(KBuildingHeroActionSta.kIdel)
end

function BuildingHero:setHeroInfo(roomId, heroId, buildingMediator)
	self._roomId = roomId
	self._room = self._buildingSystem:getRoom(self._roomId)
	self._heroId = heroId
	self._buildingMediator = buildingMediator
end

function BuildingHero:setupView()
	return
end

function BuildingHero:adjustLayout(targetFrame)
	return
end

function BuildingHero:initHeroAnim()
	local modelid = IconFactory:getRoleModelByKey("HeroBase", self._heroId)
	local hero = self._developSystem._heroSystem:getHeroById(self._heroId)
	local isAwaken = false

	if hero then
		modelid = hero:getModel()
		isAwaken = hero:getAwakenStar() > 0
	end

	local surfaceMap = self._buildingSystem:getHeroSufaceMap()

	if surfaceMap[self._heroId] and not self._buildingSystem:isSelfBuilding() then
		modelid = ConfigReader:getDataByNameIdAndKey("Surface", surfaceMap[self._heroId].surfaceId, "Model")

		if modelid then
			local pathPrefix = "asset/anim/"
			local resId = ConfigReader:getDataByNameIdAndKey("RoleModel", modelid, "Model")
			local jsonPath = pathPrefix .. resId .. ".skel"

			if not cc.FileUtils:getInstance():isFileExist(jsonPath) then
				local surfaceId = ConfigReader:requireDataByNameIdAndKey("HeroBase", self._heroId, "SurfaceList")[1]

				modelid = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "Model")
			end

			if surfaceMap[self._heroId].awakenLevel then
				isAwaken = surfaceMap[self._heroId].awakenLevel > 0
			end
		end
	end

	self._animNode = RoleFactory:createHeroAnimation(modelid, isAwaken and "stand1" or "stand")

	self._animNode:setScale(self._scale)
	self._baseNode:addChild(self._animNode, heroZorder.kSkin)
	self:resetHeightOffset()

	self._rotateNode = cc.Node:create():addTo(self._baseNode, heroZorder.kUnder)
end

function BuildingHero:resetRandomPos()
	local pos = self:getRandomPos()

	if pos then
		self._pos = cc.p(pos.x, pos.y)

		self._room:setHeroPutPos(self._heroId, pos)
		self:show()

		local tileMapComponent = self._buildingMediator._tiledMapComponent
		local posNew = tileMapComponent:getBuildingMapPos(self._roomId, pos)

		posNew.x = posNew.x + KBUILDING_TILEMAP_CELL_OFFSET.x
		posNew.y = posNew.y + KBUILDING_TILEMAP_CELL_OFFSET.y

		self:getView():setPosition(posNew)
		self:setHeroZorder()
	else
		self:hide()

		self._pos = nil

		self._room:setHeroPutPos(self._heroId, nil)
	end
end

function BuildingHero:switchHeroSta(sta)
	if not self._createSta then
		return
	end

	if self._baseNode:isVisible() == false then
		sta = KBuildingHeroActionSta.kIdel
	end

	self._currentState = sta

	self:playAnimation(self._currentState)
	self:setHeroRotate(0)
	self._baseNode:stopActionByTag(moveActionTag)

	if sta == KBuildingHeroActionSta.kIdel then
		-- block empty
	elseif sta == KBuildingHeroActionSta.kMove then
		self:heroMove()
	else
		self._heroDir = heroMoveDir.kRight

		self._animNode:setScaleX(self._scale * heroDirScale[self._heroDir])
	end

	self:setHeroZorder()
	self:updateOnlineTime()
end

function BuildingHero:updateHeroSta()
	if not self._createSta then
		return
	end

	if self._baseNode:isVisible() == false then
		return
	end

	local curTime = self._gameServerAgent:remoteTimeMillis()

	if self._currentState == KBuildingHeroActionSta.kIdel then
		if curTime > self._standTime then
			if self:getPraySta() then
				self:switchHeroSta(KBuildingHeroActionSta.kPray)
			else
				self._walkEndTime = curTime + self:getStateTime(KBuildingHeroActionSta.kMove)

				self:switchHeroSta(KBuildingHeroActionSta.kMove)
			end
		end
	elseif self._currentState == KBuildingHeroActionSta.kPray and curTime > self._prayEndTime then
		self._walkEndTime = curTime + self:getStateTime(KBuildingHeroActionSta.kMove)

		self:switchHeroSta(KBuildingHeroActionSta.kMove)
	end
end

function BuildingHero:afterMoveAction()
	if self:getPraySta() then
		self:switchHeroSta(KBuildingHeroActionSta.kPray)
	elseif self._gameServerAgent:remoteTimeMillis() > self._walkEndTime then
		self._standTime = self._gameServerAgent:remoteTimeMillis() + self:getIdelTime()

		self:switchHeroSta(KBuildingHeroActionSta.kIdel)
	else
		self:heroMove()
	end
end

function BuildingHero:heroMove()
	self._baseNode:stopActionByTag(moveActionTag)

	local posInfoList = self._room:getHeroCanGoPos(self._pos)

	if #posInfoList > 0 then
		for k, v in pairs(posInfoList) do
			if v.dir == self._heroDir then
				posInfoList[#posInfoList + 1] = v
				posInfoList[#posInfoList + 1] = v
				posInfoList[#posInfoList + 1] = v

				break
			end
		end

		local index = math.random(1, #posInfoList)
		local posTo = posInfoList[index].pos

		self._heroDir = posInfoList[index].dir

		self._animNode:setScaleX(self._scale * heroDirScale[self._heroDir])

		local startTime = app.getTime()
		local updateTime = startTime
		local posNow = self:getPosition(self._pos)
		local posNext = self:getPosition(posTo)

		self._pos = cc.p(posTo.x, posTo.y)

		self._room:setHeroPutPos(self._heroId, cc.p(self._pos.x, self._pos.y))

		local offset = cc.p(posNext.x - posNow.x, posNext.y - posNow.y)
		local view = self:getView()
		local action = schedule(self._baseNode, function()
			local timeNow = app.getTime()
			local timeEnd = timeNow

			if timeNow - startTime > heroMoveTime then
				timeEnd = startTime + heroMoveTime
			end

			local timeOffset = timeEnd - updateTime

			updateTime = timeEnd

			local timePercent = timeOffset / heroMoveTime
			local moveOffset = cc.p(offset.x * timePercent, offset.y * timePercent)
			local positionX = view:getPositionX()
			local positionY = view:getPositionY()

			view:setPosition(cc.p(positionX + moveOffset.x, positionY + moveOffset.y))
			self:setHeroZorder()

			if timeNow - startTime >= heroMoveTime then
				self._baseNode:stopActionByTag(moveActionTag)
				self:afterMoveAction()
			end
		end, 0)

		action:setTag(moveActionTag)
	else
		self:switchHeroSta(KBuildingHeroActionSta.kIdel)
	end
end

function BuildingHero:hide(isFadeOut)
	if self._currentState == KBuildingHeroActionSta.kMove or self._currentState == KBuildingHeroActionSta.kPray then
		self:switchHeroSta(KBuildingHeroActionSta.kIdel)
		self:setRoomPosition(self._pos)
	end

	self._baseNode:setOpacity(255)
	self._baseNode:setVisible(false)

	if isFadeOut then
		self._baseNode:setVisible(true)

		local fadeOut = cc.FadeOut:create(KBUILDING_FADE_TIME)

		self._baseNode:runAction(fadeOut)
	end
end

function BuildingHero:show(isFadeIn)
	self._baseNode:setOpacity(255)
	self._baseNode:setVisible(true)
	self:updateHeroSta()

	if isFadeIn then
		local fadeIn = cc.FadeIn:create(KBUILDING_FADE_TIME)

		self._baseNode:runAction(fadeIn)
	end
end

function BuildingHero:playLiftAction()
	self:switchHeroSta(KBuildingHeroActionSta.kLife)
	self:showHeightOffset()
end

function BuildingHero:resetAction()
	self:switchHeroSta(KBuildingHeroActionSta.kIdel)
	self:resetHeightOffset()
end

function BuildingHero:getRandomPos()
	local room = self._room
	local useList = room:getCanPutHeroPosList()
	local index = math.random(1, #useList)

	return useList[index]
end

function BuildingHero:playAnimation(name)
	self._currentState = name

	local hero = self._developSystem._heroSystem:getHeroById(self._heroId)
	local isAwaken = not not (hero and hero:getAwakenStar() > 0)
	local surfaceMap = self._buildingSystem:getHeroSufaceMap()

	if (surfaceMap[self._heroId] and not self._buildingSystem:isSelfBuilding() and surfaceMap[self._heroId].awakenLevel or nil) and surfaceMap[self._heroId].awakenLevel > 0 and name == KBuildingHeroActionSta.kIdel then
		name = "stand1"
	end

	self._animNode:playAnimation(0, name, true)
end

function BuildingHero:setRoomPosition(pos, offset)
	offset = offset or cc.p(0, 0)

	local posNew = self:getPosition(pos)

	self:getView():setPosition(posNew)

	self._pos = cc.p(pos.x, pos.y)

	self._room:setHeroPutPos(self._heroId, pos)

	self._heroOffset = cc.p(offset.x, offset.y)

	self:setHeroZorder()
end

function BuildingHero:setBuildPosition(pos, offset)
	offset = offset or cc.p(0, 0)

	self:getView():setPosition(offset)

	self._pos = cc.p(0, 0)

	self._room:setHeroPutPos(self._heroId, pos)

	self._heroOffset = cc.p(offset.x, offset.y)

	self:setHeroZorder()
end

function BuildingHero:getPosition(pos)
	local tileMapComponent = self._buildingMediator._tiledMapComponent
	local posNew = tileMapComponent:getBuildingMapPos(self._roomId, pos)

	posNew.x = posNew.x + KBUILDING_TILEMAP_CELL_OFFSET.x
	posNew.y = posNew.y + KBUILDING_TILEMAP_CELL_OFFSET.y

	return posNew
end

function BuildingHero:setHeroZorder()
	local zorder = 99999

	if self._currentState == KBuildingHeroActionSta.kLife then
		-- block empty
	end

	if self._currentState ~= KBuildingHeroActionSta.kIdel and self._currentState ~= KBuildingHeroActionSta.kMove then
		if self._currentState == KBuildingHeroActionSta.kPray then
			local posY = math.floor(self:getView():getPositionY() + KBUILDING_Tiled_CELL_SIZE.height / 2)

			zorder = 10000 - posY
		else
			local posY = self._heroOffset.y

			zorder = 1000 - posY
		end

		local view = self:getView()

		view:setLocalZOrder(zorder)
	end
end

function BuildingHero:setOnBuildingId(id)
	self._putOnId = id
end

function BuildingHero:removeFromParent()
	self._room:setHeroPutPos(self._heroId, nil)
	self:getView():removeFromParent()

	self._view = nil
end

function BuildingHero:setHeroRotate(rotate)
	if not self._createSta then
		return false
	end

	rotate = rotate or 0
	self._heroRotate = rotate

	self._animNode:setRotation(rotate)
end

function BuildingHero:checkPosChanged()
	if self._currentState == KBuildingHeroActionSta.kIdel then
		if not self._pos then
			self:resetRandomPos()
		else
			local building = self._room:getBuildingByPos(self._pos)

			if building then
				self:resetRandomPos()
			end
		end
	end
end

function BuildingHero:getClickOnHeroAnim(worldPos)
	if not self._createSta then
		return false
	end

	if self._currentState == KBuildingHeroActionSta.kIdel or self._currentState == KBuildingHeroActionSta.kMove or self._currentState == KBuildingHeroActionSta.kPray then
		local pos = self:getView():convertToWorldSpace(cc.p(0, 0))

		pos.y = pos.y + 10

		if worldPos.x >= pos.x - heroAnimSize.width / 2 * self._scale and worldPos.x <= pos.x + heroAnimSize.width / 2 * self._scale and worldPos.y >= pos.y and worldPos.y <= pos.y + heroAnimSize.height * self._scale then
			return true
		end
	end

	return false
end

function BuildingHero:getIdelTime()
	local timeList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Static_Time", "content")

	if timeList and #timeList > 0 then
		local index = math.random(1, #timeList)

		return timeList[index] * 1000
	end

	return 2000
end

function BuildingHero:getStateTime(sta)
	local afkAction = ConfigReader:getDataByNameIdAndKey("HeroLove", self._heroId, "AfkAction")

	if afkAction and afkAction[sta] then
		local info = afkAction[sta]
		local minNum = info[2]
		local maxNum = info[3]
		local time = math.random(minNum, maxNum)

		return time * 1000
	end

	return 10000
end

function BuildingHero:getPraySta()
	local curTime = self._gameServerAgent:remoteTimeMillis()
	local interactive_Pray = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Interactive_Pray", "content") or {}

	if interactive_Pray[self._roomId] and curTime > self._prayNextTime then
		local paryBuildInfo = interactive_Pray[self._roomId]
		local builingList = {}
		local range = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_MainCity_ActionRange", "content") or 1

		for x = -range, range do
			for y = -range, range do
				if x ~= 0 and y ~= 0 then
					local rangePos = cc.p(self._pos.x + x, self._pos.y + y)
					local building = self._room:getBuildingByPos(rangePos)

					if building then
						builingList[building._configId] = true
					end
				end
			end
		end

		for k, v in pairs(paryBuildInfo) do
			local info = v
			local id = v[1]

			if builingList[id] then
				self._prayEndTime = curTime + info[2] * 1000
				self._prayNextTime = self._prayEndTime + info[3] * 1000

				return true
			end
		end
	end

	return false
end

function BuildingHero:updateOnlineTime()
	if not self._createSta then
		return
	end

	if self._baseNode:isVisible() == false then
		return
	end

	if self._currentState == KBuildingHeroActionSta.kIdel or self._currentState == KBuildingHeroActionSta.kPray or self._currentState == KBuildingHeroActionSta.kMove then
		if self._heroId and self._buildingSystem:getHeroCanEvent(self._heroId) then
			self:showAfkEventType(self:getNextEventType())
		else
			self:hideAfkEventType()
		end
	else
		self:hideAfkEventType()
	end
end

function BuildingHero:getNextEventType()
	local heroSystem = self._developSystem._heroSystem

	return heroSystem:getHeroById(self._heroId):getNextEventType()
end

function BuildingHero:showAfkEventType(eventtype)
	if not self._heroMenuList then
		self:initHeroMenuList()
	end

	for k, v in pairs(self._heroMenuList) do
		v:setVisible(false)
	end

	if self._heroMenuList[eventtype] then
		self._heroMenuList[eventtype]:setVisible(true)
	end
end

function BuildingHero:hideAfkEventType()
	if self._heroMenuList then
		for k, v in pairs(self._heroMenuList) do
			v:setVisible(false)
		end
	end
end

function BuildingHero:initHeroMenuList()
	self._heroMenuList = {}

	local btnNode = cc.CSLoader:createNode("asset/ui/BuildingHeroMenu.csb")

	self._baseNode:addChild(btnNode, heroZorder.KUi)
	btnNode:setPosition(cc.p(0, 250))

	local giftBtn = btnNode:getChildByName("giftbtn")
	local hugbtn = btnNode:getChildByName("hugbtn")

	self._heroMenuList.gift = giftBtn
	self._heroMenuList.hug = hugbtn

	giftBtn:addClickEventListener(function()
		self._buildingSystem:tryEnterAfkGift(self._heroId, 3)
	end)
	hugbtn:addClickEventListener(function()
		self._buildingSystem:tryEnterAfkGift(self._heroId, 2)
	end)
end

function BuildingHero:showHeightOffset()
	self._animNode:setPositionY(80)
end

function BuildingHero:resetHeightOffset()
	self._animNode:setPosition(cc.p(0, KBUILDING_Tiled_CELL_SIZE.height / 2))
end

function BuildingHero:showUnder(sta)
	local underNode = self._rotateNode:getChildByName("Under")

	if not underNode then
		underNode = cc.Node:create()

		underNode:setName("Under")
		self._rotateNode:addChild(underNode, -1)

		local size = cc.size(1, 1)
		local greenUnder = BuildingMapBuildUnder:createGreen(size.width, size.height, KBUILDING_Tiled_CELL_SIZE)

		greenUnder:addTo(underNode):setName("greenUnder")

		local redUnder = BuildingMapBuildUnder:createRed(size.width, size.height, KBUILDING_Tiled_CELL_SIZE)

		redUnder:addTo(underNode):setName("redUnder")
	end

	self:refreshUnder(sta)
	underNode:setVisible(true)
end

function BuildingHero:refreshUnder(sta)
	local underNode = self._rotateNode:getChildByName("Under")

	if underNode then
		local greenUnder = underNode:getChildByName("greenUnder")

		if greenUnder then
			greenUnder:setVisible(sta)
		end

		local redUnder = underNode:getChildByName("redUnder")

		if redUnder then
			redUnder:setVisible(not sta)
		end
	end
end

function BuildingHero:hideUnder()
	if self._rotateNode:getChildByName("Under") then
		self._rotateNode:getChildByName("Under"):setVisible(false)
	end
end
