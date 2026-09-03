-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingDecorateQueue.lua

BuildingDecorateQueue = class("BuildingDecorateQueue", DmBaseUI)

BuildingDecorateQueue:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingDecorateQueue:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

function BuildingDecorateQueue:initialize(view)
	super.initialize(self, view)
end

function BuildingDecorateQueue:dispose()
	super.dispose(self)
end

function BuildingDecorateQueue:enterWithData()
	self._animShowSta = true

	self:setupView()
	self:hide()
	self:update()
end

function BuildingDecorateQueue:setupView()
	local view = self:getView()

	self._animNode1 = view:getChildByFullName("anim1")
	self._animNode2 = view:getChildByFullName("anim2")
	self._timeNode1 = view:getChildByFullName("timeNode1")
	self._timeNode2 = view:getChildByFullName("timeNode2")
	self._timeLabel1 = self._timeNode1:getChildByFullName("time")
	self._timeLabel2 = self._timeNode2:getChildByFullName("time")

	local icon = view:getChildByFullName("icon")

	icon:setTouchEnabled(true)
	icon:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onClickShowQueue()
		end
	end)
end

function BuildingDecorateQueue:adjustLayout(targetFrame)
	return
end

function BuildingDecorateQueue:refreshView()
	if not self._animShowSta then
		return
	end

	local timeNow = self._gameServerAgent:remoteTimestamp()
	local index = 1

	for k, v in pairs(self._buildingSystem:getWorkers()) do
		local animNode = self:getView():getChildByFullName("anim" .. index)
		local timeNode = self:getView():getChildByFullName("timeNode" .. index)

		if animNode and timeNode then
			local timeLab = timeNode:getChildByFullName("time")
			local time = v / 1000 - timeNow

			if time >= 0 then
				local t1, t2 = self._buildingSystem:getTimeText(time)

				timeLab:setString(t2)
				timeNode:setVisible(true)

				if not animNode:getChildByFullName("xian") then
					animNode:removeAllChildren()

					local anim = cc.MovieClip:create("xian_xiaoguaijianzao")

					animNode:addChild(anim)
					anim:setScale(0.7)
					anim:gotoAndPlay(1)
					anim:setName("xian")
				end
			else
				timeNode:setVisible(false)

				if not animNode:getChildByFullName("build") then
					animNode:removeAllChildren()

					local anim = cc.MovieClip:create("build_xiaoguaijianzao")

					animNode:addChild(anim)
					anim:gotoAndPlay(1)
					anim:setScale(0.7)
					anim:setName("build")
				end
			end
		end

		index = index + 1
	end
end

function BuildingDecorateQueue:hide()
	self._animNode1:setVisible(false)
	self._animNode2:setVisible(false)
	self._timeNode1:setVisible(false)
	self._timeNode2:setVisible(false)

	self._animShowSta = false
end

function BuildingDecorateQueue:show()
	self._animNode1:setVisible(true)
	self._animNode2:setVisible(true)
	self._timeNode1:setVisible(true)
	self._timeNode2:setVisible(true)

	self._animShowSta = true

	self:update()
end

function BuildingDecorateQueue:update()
	self:refreshView()
end

function BuildingDecorateQueue:onClickShowQueue()
	if self._buildingSystem._mapShowType == KBuildingMapShowType.kInRoom and self._buildingSystem:isSelfBuilding() and self._buildingSystem:getShowRoomId() == "Room2" then
		local view = self._buildingSystem:getInjector():getInstance("BuildingQueueBuyView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		})

		self._buildingSystem:dispatch(event)
	end
end
