-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/heroshow/HeroShowHeroPicMediator.lua

HeroShowHeroPicMediator = class("HeroShowHeroPicMediator", DmAreaViewMediator, _M)

HeroShowHeroPicMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	backBtn = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickBack"
	},
	screenBtn = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickScreen"
	},
	backBtn_0 = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickBack"
	},
	screenBtn_0 = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickScreen"
	}
}
local kRoleScaleMax = 1.8
local kRoleScaleMin = 0.5
local kRolePosOffset1 = -200
local kRolePosOffset2 = -50
local kRoleRoundOffset = 100

local function formatUnorderTable(unorderTable, compFunc)
	local _tab = {}

	for k, v in pairs(unorderTable) do
		_tab[#_tab + 1] = k
	end

	if compFunc then
		table.sort(_tab, compFunc)
	end

	return _tab
end

function HeroShowHeroPicMediator:initialize()
	super.initialize(self)
end

function HeroShowHeroPicMediator:dispose()
	if self._boardHeroEffect then
		AudioEngine:getInstance():stopEffect(self._boardHeroEffect)
	end

	super.dispose(self)
end

function HeroShowHeroPicMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function HeroShowHeroPicMediator:enterWithData(data)
	self._setHomeBgId = data.setHomeBgId
	self._heroId = data.id
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._model = self._heroData:getModel()

	self:initView()
	self:initHeroView()
	self:addShare()
end

function HeroShowHeroPicMediator:addShare()
	local dispatcher = DmGame:getInstance()
	local view
	local data = {
		enterType = ShareEnterType.KHeroH,
		node = self:getView(),
		preConfig = function()
			view = dispatcher._injector:getInstance("newShareView")

			dispatcher:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				heroId = self._heroId
			}))
		end,
		endConfig = function()
			return
		end
	}

	DmGame:getInstance()._injector:getInstance(ShareSystem):addShare(data)

	local data = {
		enterType = ShareEnterType.KHeroV,
		node = self:getView(),
		preConfig = function()
			self._screenBtn1:setVisible(false)
			self._backBtn1:setVisible(false)
			self._heroSprite:setVisible(false)

			self._heroSpriteTemp = IconFactory:createRoleIconSpriteNew({
				useAnim = false,
				frameId = "bustframe6_5",
				id = self._model
			})

			self._heroSpriteTemp:addTo(self._roleNode):posite(13, -55)
		end,
		endConfig = function()
			self._screenBtn1:setVisible(true)
			self._backBtn1:setVisible(true)

			if self._heroSpriteTemp then
				self._heroSpriteTemp:removeFromParent()

				self._heroSpriteTemp = nil
			end

			self._heroSprite:setVisible(true)
		end
	}

	DmGame:getInstance()._injector:getInstance(ShareSystem):addShare(data)
	self:setShareVisible()
end

function HeroShowHeroPicMediator:addShareTest()
	local data = {
		enterType = ShareEnterType.KHeroHTest,
		node = self:getView(),
		preConfig = function()
			self._screenBtn:setVisible(false)
			self._backBtn:setVisible(false)
		end,
		endConfig = function()
			self._screenBtn:setVisible(true)
			self._backBtn:setVisible(true)
		end
	}

	DmGame:getInstance()._injector:getInstance(ShareSystem):addShare(data)

	local data = {
		enterType = ShareEnterType.KHeroVTest,
		node = self:getView(),
		preConfig = function()
			self._screenBtn1:setVisible(false)
			self._backBtn1:setVisible(false)
		end,
		endConfig = function()
			self._screenBtn1:setVisible(true)
			self._backBtn1:setVisible(true)
		end
	}

	DmGame:getInstance()._injector:getInstance(ShareSystem):addShare(data)
end

function HeroShowHeroPicMediator:setShareVisible()
	DmGame:getInstance()._injector:getInstance(ShareSystem):setShareVisible({
		enterType = ShareEnterType.KHeroH,
		node = self:getView(),
		status = not self._needBtnHide and not self._viewState
	})
	DmGame:getInstance()._injector:getInstance(ShareSystem):setShareVisible({
		enterType = ShareEnterType.KHeroV,
		node = self:getView(),
		status = not self._needBtnHide and self._viewState
	})
end

function HeroShowHeroPicMediator:initView()
	self._main = self:getView():getChildByFullName("main")
	self._bg = self._main:getChildByFullName("bg")
	self._roleNode = self._main:getChildByFullName("roleNode")
	self._screenBtn = self:getView():getChildByFullName("screenBtn")
	self._backBtn = self:getView():getChildByFullName("backBtn")
	self._screenBtn1 = self:getView():getChildByFullName("screenBtn_0")
	self._backBtn1 = self:getView():getChildByFullName("backBtn_0")

	self._screenBtn1:setVisible(false)
	self._backBtn1:setVisible(false)

	self._backBtnPos = cc.p(self._backBtn:getPositionX(), self._backBtn:getPositionY())
	self._screenBtnPos = cc.p(self._screenBtn:getPositionX(), self._screenBtn:getPositionY())

	if self._setHomeBgId then
		self:initBg()
	else
		self:refreshBg()
	end

	self._needBtnHide = false

	self:initMultiTouchLayer()
end

function HeroShowHeroPicMediator:refreshBg()
	local heroData = self._heroSystem:getHeroInfoById(self._heroId)
	local bgPanel = self._main:getChildByFullName("bg")

	bgPanel:stopAllActions()
	bgPanel:removeAllChildren()

	if self._heroData then
		local var_18_0 = GameStyle:getHeroPartyByHeroInfo(self._heroData)

		if not var_18_0 then
			var_18_0 = GameStyle:getHeroPartyBg(heroData.party)

			local bgAnim = var_18_0

			bgAnim:addTo(self._bg)
			bgPanel:runAction(cc.ScaleTo:create(0.2, 1))
		end
	end
end

function HeroShowHeroPicMediator:initBg()
	self._switchBgTag = -999

	local flashPanel = self._bg

	flashPanel:removeAllChildren()

	local timeTable = ConfigReader:getDataByNameIdAndKey("HomeBackground", self._setHomeBgId, "Loop")
	local keyTab = formatUnorderTable(timeTable, function(a, b)
		local aParts = string.split(a, ":", nil, true)
		local bParts = string.split(b, ":", nil, true)
		local aStamp = TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = aParts[1],
			min = aParts[2],
			sec = aParts[3]
		})
		local bStamp = TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = bParts[1],
			min = bParts[2],
			sec = bParts[3]
		})

		return aStamp < bStamp
	end)
	local curTimeStamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
	local switchBgTag = #keyTab

	local function comp(switchTime, realTime)
		local parts = string.split(switchTime, ":", nil, true)
		local switchTimeStemp = TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = parts[1],
			min = parts[2],
			sec = parts[3]
		})

		return switchTimeStemp <= realTime
	end

	for k, v in ipairs(keyTab) do
		if not comp(keyTab[k], curTimeStamp) then
			switchBgTag = k - 1

			break
		end
	end

	if switchBgTag < 1 then
		switchBgTag = #keyTab
	end

	if switchBgTag == self._switchBgTag then
		return
	end

	self._switchBgTag = switchBgTag

	local tabValue = timeTable[keyTab[self._switchBgTag]]
	local BGBackgroundId = tabValue.BG
	local imageInfo = ConfigReader:getRecordById("BackGroundPicture", BGBackgroundId)
	local winSize = cc.Director:getInstance():getWinSize()

	if imageInfo.Picture and imageInfo.Picture ~= "" then
		local bgImage = ccui.ImageView:create("asset/scene/" .. imageInfo.Picture .. ".jpg")

		bgImage:addTo(self._bg)

		if winSize.height < 641 then
			bgImage:setScale(winSize.width / 1386)
		end
	end

	local flashId = imageInfo.Flash1

	if flashId and flashId ~= "" then
		local mc = cc.MovieClip:create(flashId)

		mc:addTo(flashPanel):center(flashPanel:getContentSize())
		self:setClimateScene(mc)

		if winSize.height < 641 then
			mc:setScale(winSize.width / 1386)
		end

		local extFlashId = imageInfo.Flash2

		if extFlashId and extFlashId ~= "" then
			local extMc = cc.MovieClip:create(extFlashId)

			if extMc then
				extMc:addTo(flashPanel):center(flashPanel:getContentSize())
				extMc:setScale(winSize.width / 1386)
			end
		end
	end

	if imageInfo.Extra and imageInfo.Extra ~= "" then
		local extraView = cc.CSLoader:createNode("asset/ui/" .. imageInfo.Extra .. ".csb")

		extraView:addTo(flashPanel):center(flashPanel:getContentSize())

		if winSize.height < 641 then
			extraView:setScale(winSize.width / 1386)
		end
	end
end

function HeroShowHeroPicMediator:setClimateScene(node)
	local settingModel = self:getInjector():getInstance(SettingSystem):getSettingModel()
	local weathData = settingModel:getWeatherData()
	local climateDay = GameStyle:getClimateById(weathData.conditionIdDay)

	if Climate2LayerName[climateDay] then
		local layer = node:getChildByName(Climate2LayerName[climateDay])

		if layer then
			local climateMc = cc.MovieClip:create(Climate2MCName[climateDay])

			climateMc:addTo(layer)
		end
	end
end

function HeroShowHeroPicMediator:initHeroView()
	local heroSprite, _, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = self._model
	})

	heroSprite:addTo(self._roleNode):posite(0, -200)

	self._heroSprite = heroSprite

	if spineani then
		spineani:registerSpineEventHandler(handler(self, self.spineAnimEvent), sp.EventType.ANIMATION_COMPLETE)

		self._sharedSpine = spineani
	else
		self._sharedSpine = nil
	end

	self._roleAnim = heroSprite
	self._roleDeviation = picInfo.Deviation
	self._roleScale = 1
	self._roleRawDeviation = {
		picInfo.Deviation[1],
		picInfo.Deviation[2]
	}

	local surfaceId = self._heroData:getSurfaceId()

	if surfaceId then
		self._touchTimes = 0
		self._isRoleTouch = {
			value = false
		}
		self._isRoleTouchRange = {
			value = false
		}

		local surfaceData = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "ClickAction")
		local num = #surfaceData + 1

		for i = 1, num do
			local _info = surfaceData[i]
			local touchPanel = ccui.Layout:create()

			touchPanel:setAnchorPoint(cc.p(0.5, 0.5))

			local size = heroSprite:getContentSize()

			if GameConfigs.HERO_TOUCHVIEW_DEBUG then
				touchPanel:setBackGroundColorType(1)
				touchPanel:setBackGroundColor(cc.c3b(255, 0, 0))
				touchPanel:setBackGroundColorOpacity(180)
			end

			local function touchBeganFun(sender, touchflag)
				if not self._inTouchScaleSta and not touchflag.value then
					touchflag.value = true
					self._roleMoveBeganPos = nil
				end
			end

			local function touchMovedFun(sender, touchflag)
				if self._inTouchScaleSta or not touchflag.value then
					return
				end

				self._isRoleMove = true

				if not self._roleMoveBeganPos then
					local beganPos = sender:getTouchBeganPosition()
					local movedPos = sender:getTouchMovePosition()
					local delta = math.abs(cc.pDistanceSQ(beganPos, movedPos))

					if delta > 100 then
						self._roleMoveBeganPos = movedPos
						self._isRoleTouch.value = self._isRoleTouch.value or true

						local deltaX = movedPos.x - beganPos.x
						local deltaY = movedPos.y - beganPos.y

						if self._viewState then
							local posX = self._roleAnim:getPositionX()
							local posY = self._roleAnim:getPositionY()

							posX = posX + deltaY
							posY = posY - deltaX

							self:dealRolePosition(posX, posY)
						else
							local posX = self._roleAnim:getPositionX()
							local posY = self._roleAnim:getPositionY()

							posX = posX + deltaX
							posY = posY + deltaY

							self:dealRolePosition(posX, posY)
						end
					end

					self._isRoleMove = false
				end
			end

			local function touchCanceledFun(sender, touchflag)
				if touchflag.value then
					touchflag.value = false
				end

				if self._isRoleTouch.value then
					self._isRoleTouch.value = false
				end
			end

			local function touchEndFunc(sender, touchflag)
				if touchflag.value then
					touchflag.value = false
				end

				if self._isRoleTouch.value then
					self._isRoleTouch.value = false
				end
			end

			local function touchActionFunc()
				if self._sharedSpine and self._sharedSpine:hasAnimation(_info.action) then
					self._sharedSpine:playAnimation(0, _info.action, true)
				end

				self._touchTimes = self._touchTimes + 1

				if self._touchTimes > 1 then
					-- block empty
				end

				if self._boardHeroEffect then
					return
				end

				local soundId = AudioTimerSystem:getHeroTouchSoundByPart(self._heroId, _info.part, self._touchTimes)
				local isExistStr = Strings:get(ConfigReader:getDataByNameIdAndKey("Sound", soundId, "CueName"))

				if isExistStr and isExistStr ~= "Voice_Default" then
					local trueSoundId

					self._boardHeroEffect, trueSoundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
						self._boardHeroEffect = nil
					end)
					self._lastClickSound = soundId
				end
			end

			touchPanel:setTouchEnabled(true)

			if _info and _info.point then
				local point = _info.point

				if point[1] == "all" then
					touchPanel:setContentSize(cc.size(size.width / 2 * picInfo.zoom, size.height * picInfo.zoom))
					touchPanel:setPosition(size.width / 2 + picInfo.Deviation[1], size.height / 2 + picInfo.Deviation[2])
				else
					touchPanel:setContentSize(cc.size(_info.range[1] * picInfo.zoom, _info.range[2] * picInfo.zoom))
					touchPanel:setPosition(cc.p(_info.point[1] * picInfo.zoom + picInfo.Deviation[1] + size.width / 2, _info.point[2] * picInfo.zoom + picInfo.Deviation[2]))
				end

				touchPanel:addTouchEventListener(function(sender, eventType)
					if eventType == ccui.TouchEventType.began then
						touchBeganFun(sender, self._isRoleTouch)
					end

					if eventType == ccui.TouchEventType.canceled then
						touchCanceledFun(sender, self._isRoleTouch)
					end

					if eventType == ccui.TouchEventType.moved then
						touchMovedFun(sender, self._isRoleTouch)
					end

					if eventType == ccui.TouchEventType.ended then
						touchEndFunc(sender, self._isRoleTouch)
						touchActionFunc()
					end
				end)
			else
				touchPanel:setContentSize(cc.size(size.width, size.height))
				touchPanel:setPosition(size.width / 2 + picInfo.Deviation[1], size.height / 2 + picInfo.Deviation[2])
				touchPanel:addTouchEventListener(function(sender, eventType)
					if eventType == ccui.TouchEventType.began then
						touchBeganFun(sender, self._isRoleTouchRange)
					end

					if eventType == ccui.TouchEventType.canceled then
						touchCanceledFun(sender, self._isRoleTouchRange)
					end

					if eventType == ccui.TouchEventType.moved then
						touchMovedFun(sender, self._isRoleTouchRange)
					end

					if eventType == ccui.TouchEventType.ended then
						touchEndFunc(sender, self._isRoleTouchRange)
					end
				end)
			end

			touchPanel:addTo(heroSprite, num + 1 - i)
		end
	end
end

function HeroShowHeroPicMediator:dealRoleScale(changeScale)
	if changeScale < kRoleScaleMin then
		changeScale = kRoleScaleMin
	end

	if changeScale > kRoleScaleMax then
		changeScale = kRoleScaleMax
	end

	self._roleAnim:setScale(changeScale)

	self._roleScale = changeScale
	self._roleDeviation[1] = self._roleRawDeviation[1] * changeScale
	self._roleDeviation[2] = self._roleRawDeviation[2] * changeScale
end

function HeroShowHeroPicMediator:dealRolePosition(targetX, targetY)
	local roleSize = self._roleAnim:getContentSize()
	local halfRoleSize = cc.size(roleSize.width / 2 * self._roleScale, roleSize.height / 2 * self._roleScale)

	if not targetX then
		::label_33_0::

		local posX = self._roleAnim:getPositionX()

		if not targetY then
			::label_33_1::

			local posY = self._roleAnim:getPositionY()

			if self._viewState then
				local tmpX = posX + self._roleDeviation[1]
				local tmpY = posY + self._roleDeviation[2]
				local absX = math.abs(tmpX)
				local absY = math.abs(tmpY)

				if absX - halfRoleSize.width + kRoleRoundOffset > self._winSize.height / 2 then
					posX = tmpX / absX * (self._winSize.height / 2 + halfRoleSize.width - kRoleRoundOffset) - self._roleDeviation[1]
				end

				if absY - halfRoleSize.height + kRoleRoundOffset > self._winSize.width / 2 then
					posY = tmpY / absY * (self._winSize.width / 2 + halfRoleSize.height - kRoleRoundOffset) - self._roleDeviation[2]
				end

				self._roleAnim:setPosition(cc.p(posX, posY))
			else
				local tmpX = posX + self._roleDeviation[1]
				local tmpY = posY + self._roleDeviation[2]
				local absX = math.abs(tmpX)
				local absY = math.abs(tmpY)

				if absX - halfRoleSize.width + kRoleRoundOffset > self._winSize.width / 2 then
					posX = tmpX / absX * (self._winSize.width / 2 + halfRoleSize.width - kRoleRoundOffset) - self._roleDeviation[1]
				end

				if absY - halfRoleSize.height + kRoleRoundOffset > self._winSize.height / 2 then
					posY = tmpY / absY * (self._winSize.height / 2 + halfRoleSize.height - kRoleRoundOffset) - self._roleDeviation[2]
				end

				self._roleAnim:setPosition(cc.p(posX, posY))
			end
		end
	end
end

function HeroShowHeroPicMediator:checkSoundUnlock(soundId)
	local sound = {}

	sound.config = ConfigReader:getRecordById("Sound", soundId)

	function sound:setUnlock(unlock)
		return
	end

	function sound:getUnlockDesc()
		return self.config.UnlockDesc
	end

	function sound:getUnlockCondition()
		if not self.config.Unlock then
			return self.config.Unlock
		end
	end

	return self._heroSystem:getSoundUnlock(self._heroData, sound)
end

function HeroShowHeroPicMediator:onClickBack()
	self:dismiss()
end

function HeroShowHeroPicMediator:onClickScreen()
	if not self._needBtnHide then
		local isClick = true

		if self._lastViewState ~= nil then
			self._viewState = self._lastViewState
			self._lastViewState = nil
			isClick = false
		end

		if not self._viewState then
			self._viewState = true

			self._main:setRotation(-90)
			self._multiTouchLayer:setRotation(-90)
			self._screenBtn1:setVisible(true)
			self._backBtn1:setVisible(true)
			self._screenBtn:setVisible(false)
			self._backBtn:setVisible(false)
			self._bg:setScale(1.63)

			if isClick then
				self._roleAnim:setPosition(cc.p(0, kRolePosOffset2))
				self:dealRoleScale(1)
			end
		else
			self._viewState = false

			self._main:setRotation(0)
			self._multiTouchLayer:setRotation(0)
			self._screenBtn1:setVisible(false)
			self._backBtn1:setVisible(false)
			self._screenBtn:setVisible(true)
			self._backBtn:setVisible(true)
			self._bg:setScale(1)

			if isClick then
				self._roleAnim:setPosition(cc.p(0, kRolePosOffset1))
				self:dealRoleScale(1)
			end
		end
	else
		self._screenBtn1:setVisible(false)
		self._backBtn1:setVisible(false)
		self._screenBtn:setVisible(false)
		self._backBtn:setVisible(false)

		self._lastViewState = not self._viewState
	end

	self:setShareVisible()
end

function HeroShowHeroPicMediator:spineAnimEvent(event)
	if event.type == "complete" and event.animation ~= "animation" and self._sharedSpine then
		if event.animation == spineTouchEventName then
			spineTouchEventTag = false
		end

		self._sharedSpine:playAnimation(0, "animation", true)
	end
end

function HeroShowHeroPicMediator:initMultiTouchLayer()
	self._touchPoint = {}

	if not self._multiTouchLayer then
		local director = cc.Director:getInstance()
		local winSize = director:getWinSize()
		local multiTouchLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 0))

		multiTouchLayer:setContentSize(cc.size(winSize.width, winSize.height))
		multiTouchLayer:setTouchMode(cc.EVENT_TOUCH_ALL_AT_ONCE)
		multiTouchLayer:setSwallowsTouches(false)
		multiTouchLayer:setVisible(true)
		multiTouchLayer:setTouchEnabled(true)
		multiTouchLayer:onTouch(handler(self, self.onTouchMultiTouchLayer), true, false)
		multiTouchLayer:addTo(self._main)

		self._winSize = winSize
		self._multiTouchLayer = multiTouchLayer
	end
end

function HeroShowHeroPicMediator:onTouchMultiTouchLayer(event)
	if event.name == "began" then
		self:dealOnMultiTouchBegan(event)
	elseif event.name == "moved" then
		self:dealOnMultiTouchMoved(event)
	elseif event.name == "ended" then
		self:dealOnMultiTouchEnded(event)
	end
end

function HeroShowHeroPicMediator:dealOnMultiTouchBegan(event)
	self._touchBeganDistance = -99999

	for k, v in pairs(event.points) do
		if self:getPointById(v.id, self._touchPoint) == nil then
			self._touchPoint[#self._touchPoint + 1] = v
		end
	end

	if #self._touchPoint > 1 then
		self._inTouchScaleSta = true

		local p1 = self:getPointById(0, self._touchPoint)
		local p2 = self:getPointById(1, self._touchPoint)

		if p2 and p1 then
			self._touchBeganDistance = math.floor(cc.pGetDistance(cc.p(p1.x, p1.y), cc.p(p2.x, p2.y)))
		end
	else
		local p1 = self:getPointById(0, self._touchPoint)

		if p1 then
			self._touchOnePoint = p1
		end
	end
end

function HeroShowHeroPicMediator:dealOnMultiTouchMoved(event)
	if #self._touchPoint > 1 then
		if self._inTouchScaleSta then
			local p1 = self:getPointById(0, event.points)
			local p2 = self:getPointById(1, event.points)

			if p2 == nil or p1 == nil or self._touchBeganDistance == -99999 then
				return
			end

			local length = math.floor(cc.pGetDistance(cc.p(p1.x, p1.y), cc.p(p2.x, p2.y)))
			local diffLen = math.abs(length - self._touchBeganDistance)

			if diffLen > 15 then
				local changeScale = length / self._touchBeganDistance * self._roleAnim:getScale()

				self:dealRoleScale(changeScale)

				self._touchBeganDistance = length

				self:dealRolePosition()
				self:setPointById(0, self._touchPoint, p1)
				self:setPointById(1, self._touchPoint, p2)
			end
		end
	elseif self._inTouchScaleSta then
		self._inTouchScaleSta = flase
	end
end

function HeroShowHeroPicMediator:dealOnMultiTouchEnded(event)
	if #self._touchPoint > 1 and self._inTouchScaleSta then
		self._inTouchScaleSta = false

		local p1 = self:getPointById(0, self._touchPoint)
		local p2 = self:getPointById(1, self._touchPoint)

		self._touchPoint = {}

		if self._touchBeganDistance ~= -99999 then
			-- block empty
		end
	elseif #self._touchPoint > 0 then
		if self._isRoleMove or self._isRoleTouch.value then
			-- block empty
		else
			local p1 = self:getPointById(0, self._touchPoint)
			local p2 = self._touchOnePoint

			if p1 and p2 then
				local delta = cc.pGetDistance(cc.p(p1.x, p1.y), cc.p(p2.x, p2.y))

				if math.abs(delta) < 15 then
					self._needBtnHide = not self._needBtnHide

					self:onClickScreen()
				end
			end
		end

		self._touchPoint = {}
		self._touchOnePoint = nil
	else
		self._inTouchScaleSta = false
		self._touchPoint = {}
		self._touchOnePoint = nil
	end
end

function HeroShowHeroPicMediator:getPointById(id, points)
	for k, v in pairs(points) do
		if v.id == id then
			v.x = math.floor(v.x)
			v.y = math.floor(v.y)

			return v
		end
	end

	return nil
end

function HeroShowHeroPicMediator:setPointById(id, points, point)
	for k, v in pairs(points) do
		if v.id == id then
			v.x = point.x
			v.y = point.y
		end
	end
end

function HeroShowHeroPicMediator:getContainPosSta(posList, pos)
	for k, v in pairs(posList) do
		if v.x == pos.x and v.y == pos.y then
			return true
		end
	end

	return false
end
