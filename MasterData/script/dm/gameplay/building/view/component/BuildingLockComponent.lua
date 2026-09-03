-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingLockComponent.lua

BuildingLockComponent = class("BuildingLockComponent", DmBaseUI)

BuildingLockComponent:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingLockComponent:has("_buildingMediator", {
	is = "rw"
})

function BuildingLockComponent:initialize(view)
	super.initialize(self, view)
	self:setupView()
end

function BuildingLockComponent:dispose()
	super.dispose(self)
end

function BuildingLockComponent:enterWithData()
	self:refreshView()
end

function BuildingLockComponent:refreshView()
	self:refreshRoofFirst()
	self:refreshRoomLock()
end

function BuildingLockComponent:setupView()
	return
end

function BuildingLockComponent:adjustLayout(targetFrame)
	return
end

function BuildingLockComponent:refreshRoofFirst()
	local openSta = true

	for k, v in pairs(KBUILDING_MAP_FIR_ROOF_OPEN_CONDITION) do
		if not self._buildingSystem:getRoomOpenSta(v) then
			openSta = false

			break
		end
	end

	local view = self:getView()
	local nodeRooFirst = view:getChildByName("nodeRooFirst")

	if not openSta then
		if not nodeRooFirst then
			local node = cc.Node:create():addTo(view, 2)

			node:setName("nodeRooFirst")
			node:setPosition(KBUILDING_ROOF_FIRST_POS)

			local resPath = "building_resRoof_1_"

			for i = 1, 18 do
				for j = 1, 13 do
					local resPathN = resPath .. i .. "_" .. j .. ".png"
					local image = ccui.ImageView:create(resPathN, ccui.TextureResType.plistType)

					image:setAnchorPoint(0, 0)
					image:setPosition(cc.p((i - 1) * 200, (j - 1) * 200))
					node:addChild(image)
				end
			end
		end
	elseif nodeRooFirst then
		nodeRooFirst:removeFromParent(true)
	end
end

function BuildingLockComponent:refreshRoomLock()
	local view = self:getView()
	local tiledMapComponent = self._buildingMediator._tiledMapComponent

	if not tiledMapComponent._tiledMapList then
		for k, v in pairs(tiledMapComponent._tiledMapList) do
			local lockKey = "lockRoom_" .. k
			local imageLock = view:getChildByName(lockKey)

			if self._buildingSystem:getRoomOpenSta(k) then
				if imageLock then
					imageLock:removeFromParent()
				end
			else
				if not imageLock then
					local tiledMap = v:getView()
					local image = ccui.ImageView:create("chengjian_btn_suo_2.png", ccui.TextureResType.plistType)

					image:setAnchorPoint(0.5, 0.5)
					image:setPosition(tiledMap:getPosition())
					image:setName(lockKey)
					view:addChild(image)

					imageLock = image

					local label = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 24)

					label:setTextColor(cc.c3b(255, 255, 255))
					label:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
					label:setDimensions(240, 0)
					label:setAnchorPoint(0.5, 1)
					label:setAlignment(1, 0)
					label:addTo(image):center(image:getContentSize()):offset(0, 0 - image:getContentSize().height / 2 - 15)
					label:setName("lockDes")
				end

				local lockDes = imageLock:getChildByName("lockDes")

				if self._buildingSystem:canUnlockRoom(k) then
					lockDes:setVisible(false)
					imageLock:loadTexture("chengjian_btn_suo_2.png", ccui.TextureResType.plistType)
				else
					imageLock:loadTexture("chengjian_btn_suo_1.png", ccui.TextureResType.plistType)
					lockDes:setVisible(true)

					local scale = self._buildingSystem:getBuildResourceScale()
					local _, des = self._buildingSystem:getRoomOpenSta(k)

					lockDes:setVisible(true)
					lockDes:setString(des)
					lockDes:setScale(scale)
				end
			end
		end
	end
end

function BuildingLockComponent:hideRoomLockDes()
	local view = self:getView()
	local tiledMapComponent = self._buildingMediator._tiledMapComponent

	if not tiledMapComponent._tiledMapList then
		for k, v in pairs(tiledMapComponent._tiledMapList) do
			local lockKey = "lockRoom_" .. k
			local imageLock = view:getChildByName(lockKey)

			if imageLock then
				local lockDes = imageLock:getChildByName("lockDes")

				if lockDes then
					lockDes:setVisible(false)
				end
			end
		end
	end
end

function BuildingLockComponent:showRoomLockImage(status)
	local view = self:getView()
	local tiledMapComponent = self._buildingMediator._tiledMapComponent

	if not tiledMapComponent._tiledMapList then
		for k, v in pairs(tiledMapComponent._tiledMapList) do
			local lockKey = "lockRoom_" .. k
			local imageLock = view:getChildByName(lockKey)

			if imageLock then
				imageLock:setVisible(status)
			end
		end
	end
end
