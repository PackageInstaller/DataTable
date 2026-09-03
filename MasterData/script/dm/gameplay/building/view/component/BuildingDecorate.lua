-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingDecorate.lua

BuildingDecorate = class("BuildingDecorate", DmBaseUI)

BuildingDecorate:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingDecorate:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local buildingZorder = {
	kEffect = 20,
	kResouse = 50,
	kTime = 80,
	kName = 30,
	kBuildAnim = 70,
	kUnder = 0,
	kLvUp = 40,
	kSkin = 10,
	kTurn = 60
}

function BuildingDecorate:initialize(view)
	super.initialize(self, view)
	self:setupView()

	self._createSta = false
	self._isInRoom = true
end

function BuildingDecorate:dispose()
	super.dispose(self)
end

function BuildingDecorate:enterWithData()
	self._skinId = ""
	self._createSta = true

	self:refreshView()
	self:refreshActive()
	self:refreshRotate(self._buildingSystem:getBuildingRevert(self._roomId, self._id))
end

function BuildingDecorate:setBuildingInfo(roomId, buildingId, id)
	self._roomId = roomId
	self._buildingId = buildingId
	self._id = id

	local centerPos = self._buildingSystem:getBuildCenterPos(self._buildingId)

	self._centerNode:setPositionX(centerPos.x)
end

function BuildingDecorate:setIsInRoom(inRoom)
	self._isInRoom = inRoom
end

function BuildingDecorate:setupView()
	local view = self:getView()

	self._rotateNode = cc.Node:create():addTo(view, buildingZorder.kSkin)
	self._buildingImg = ccui.ImageView:create()

	self._buildingImg:setAnchorPoint(0.5, 0)
	self._rotateNode:addChild(self._buildingImg, 0)

	self._heroPutNode = cc.Node:create():addTo(self._rotateNode, 1)
	self._resourceNode = cc.Node:create():addTo(view, buildingZorder.kResouse)
	self._resourceAnimNode = cc.Node:create():addTo(view, buildingZorder.kResouse)
	self._centerNode = cc.Node:create():addTo(self._rotateNode, 1)
end

function BuildingDecorate:adjustLayout(targetFrame)
	return
end

function BuildingDecorate:refreshView()
	self:refreshSkin()
end

function BuildingDecorate:hide(isFadeOut)
	local view = self:getView()

	view:setVisible(false)
	view:setOpacity(255)

	if isFadeOut then
		view:setVisible(true)

		local fadeOut = cc.FadeOut:create(KBUILDING_FADE_TIME)

		view:runAction(fadeOut)
	end
end

function BuildingDecorate:show(isFadeIn)
	local view = self:getView()

	view:setVisible(true)
	view:setOpacity(255)

	if isFadeIn then
		local fadeIn = cc.FadeIn:create(KBUILDING_FADE_TIME)

		view:runAction(fadeIn)
	end
end

function BuildingDecorate:isVisible()
	local view = self:getView()

	return view:isVisible()
end

function BuildingDecorate:refreshSkin(skinId)
	if not self._createSta then
		return
	end

	skinId = skinId or self._buildingSystem:getBuildingSkinId(self._roomId, self._buildingId, self._id)

	if skinId and skinId ~= "" and self._skinId ~= skinId then
		self._skinId = skinId

		local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)
		local villageEffect = skinConfig.VillageEffect
		local offset = skinConfig.BuildDeviation

		if self._rotateNode:getChildByName("villageEffect") then
			self._rotateNode:removeChildByName("villageEffect")
		end

		local skinpath = skinConfig.Resource

		self._buildingImg:loadTexture("asset/ui/building/" .. skinpath .. ".png")

		if villageEffect and villageEffect ~= "" then
			self._buildingImg:setVisible(false)

			local buildAnim = cc.MovieClip:create(villageEffect)

			self._rotateNode:addChild(buildAnim, 0)
			buildAnim:setName("villageEffect")
			buildAnim:setPosition(cc.p(offset[1], offset[2]))
			self._buildingImg:setPosition(cc.p(offset[1], offset[2]))
		else
			self._buildingImg:setVisible(true)
			self._buildingImg:setPosition(cc.p(offset[1], offset[2]))
		end

		self:updateOffsetX(self._buildingId)

		local imgHeight = self._buildingImg:getContentSize().height

		self._resourceNode:setPosition(cc.p(0, imgHeight))
		self._resourceAnimNode:setPosition(cc.p(0, imgHeight))

		local polygonId = skinConfig.Response
		local buildPolygonCsb = cc.CSLoader:createNode("asset/ui/" .. polygonId .. ".csb")

		if buildPolygonCsb then
			local buildPolygonPosList = {}
			local children = buildPolygonCsb:getChildByFullName("buildModel"):getChildren()

			for k, v in pairs(children) do
				buildPolygonPosList[k] = cc.p(v:getPosition())
			end

			local shape = ccui.HittingPolygon:create(buildPolygonPosList)

			self._buildingImg:setHittingShape(shape)
		end
	end
end

function BuildingDecorate:updateOffsetX(buildingId)
	local config = self._buildingSystem:getBuildingConfig(buildingId)

	if config then
		local space = config.Space

		if space[1] ~= space[2] and not self._isInRoom then
			self._buildingImg:setPositionX(self._buildingImg:getPositionX() + (space[2] - space[1]) * 40)
		end
	end
end

function BuildingDecorate:refreshRotate(sta)
	if sta then
		self._rotateNode:setScaleX(-1)
	else
		self._rotateNode:setScaleX(1)
	end

	self:refreshTurnPos()
end

function BuildingDecorate:showUnder(sta)
	if not self._createSta then
		return
	end

	local underNode = self._rotateNode:getChildByName("Under")

	if not underNode then
		underNode = cc.Node:create()

		underNode:setName("Under")
		self._rotateNode:addChild(underNode, -1)

		if self._buildingId then
			local size = self._buildingSystem:getBuildingWidth(self._buildingId)
			local greenUnder = BuildingMapBuildUnder:createGreen(size.width, size.height, KBUILDING_Tiled_CELL_SIZE)

			greenUnder:addTo(underNode):setName("greenUnder")

			local redUnder = BuildingMapBuildUnder:createRed(size.width, size.height, KBUILDING_Tiled_CELL_SIZE)

			redUnder:addTo(underNode):setName("redUnder")

			local arrow = BuildingMapBuildArrow:create(size.width, size.height)

			arrow:addTo(underNode):setName("arrow")
			arrow:setPosition(cc.p(0, 0))
		end
	end

	self:refreshUnder(sta)
	underNode:setVisible(true)
end

function BuildingDecorate:refreshUnder(sta)
	if not self._createSta then
		return
	end

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

function BuildingDecorate:hideUnder()
	if self._rotateNode:getChildByName("Under") then
		self._rotateNode:getChildByName("Under"):setVisible(false)
	end
end

function BuildingDecorate:showTurn()
	if not self._createSta then
		return
	end

	local view = self:getView()
	local turnImg = view:getChildByName("TurnImg")

	if not turnImg then
		turnImg = ccui.ImageView:create("chengjian_btn_fanzhuan.png", ccui.TextureResType.plistType)

		view:addChild(turnImg, buildingZorder.kTurn)
		turnImg:setName("TurnImg")
		turnImg:setScale(1.538)
		turnImg:setTouchEnabled(true)
		turnImg:addClickEventListener(function()
			self:onClickTurn()
		end)
	end

	turnImg:setVisible(true)
	self:refreshTurnPos()
end

function BuildingDecorate:refreshTurnPos()
	if not self._createSta then
		return
	end

	local view = self:getView()
	local turnImg = view:getChildByName("TurnImg")
	local imgHeight = self._buildingImg:getContentSize().height

	if turnImg then
		turnImg:setPosition(cc.p(self._centerNode:getPositionX() * self._rotateNode:getScaleX(), imgHeight + 70))
	end

	local nameNode = view:getChildByName("BuildingNameNode")

	if nameNode then
		nameNode:setPosition(cc.p(self._centerNode:getPositionX() * self._rotateNode:getScaleX(), imgHeight - 30))
	end
end

function BuildingDecorate:hideTurn()
	if not self._createSta then
		return
	end

	local view = self:getView()
	local turnImg = view:getChildByName("TurnImg")

	if turnImg then
		turnImg:setVisible(false)
	end
end

function BuildingDecorate:onClickTurn()
	AudioEngine:getInstance():playEffect("Se_Click_Move", false)

	local info = self._buildingSystem:getOperateInfo()
	local revert = info.revert

	info.revert = not revert

	self:dispatch(Event:new(BUILDING_EVT_OPERATE_BUILD_REVERT_REFRESH))
end

function BuildingDecorate:showName()
	if not self._createSta then
		return
	end

	local view = self:getView()
	local nameNode = view:getChildByName("BuildingNameNode")

	if not nameNode then
		nameNode = cc.CSLoader:createNode("asset/ui/BuildingNameNode.csb")

		nameNode:setName("BuildingNameNode")
		view:addChild(nameNode, buildingZorder.kName)
	end

	self:refreshName()
end

function BuildingDecorate:refreshName()
	if not self._createSta then
		return
	end

	local view = self:getView()
	local nameNode = view:getChildByName("BuildingNameNode")

	if nameNode then
		nameNode:setVisible(true)

		local namelabel = nameNode:getChildByName("namelabel")
		local config = self._buildingSystem:getBuildingConfig(self._buildingId)

		if config and config.Name then
			local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
			local nameDes = Strings:get(config.Name)

			if buildingData and buildingData._type ~= KBuildingType.kDecorate then
				local level = buildingData._level
				local desLv = Strings:get("Building_UI_Name", {
					num = level
				})

				nameDes = nameDes .. desLv
			end

			namelabel:setString(nameDes)
		end
	end

	self:refreshTurnPos()
end

function BuildingDecorate:hideName()
	local view = self:getView()

	if view:getChildByName("BuildingNameNode") then
		view:getChildByName("BuildingNameNode"):setVisible(false)
	end
end

function BuildingDecorate:refreshActive()
	if not self._createSta then
		return
	end

	local view = self:getView()
	local activeSta = self._buildingSystem:getBuildingActive(self._roomId, self._id)
	local gary = not activeSta

	self._buildingImg:setGray(gary)

	if view:getChildByName("villageEffect") then
		view:getChildByName("villageEffect"):setGray(gary)
	end
end

function BuildingDecorate:refreshCdNode(endTime)
	if not self._createSta then
		return
	end

	local view = self:getView()
	local cdNode = view:getChildByName("Cd_Node")
	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)

	if buildingData then
		local timeNow = self._gameServerAgent:remoteTimestamp()
		local endTime = buildingData._finishAnimTime

		if endTime <= timeNow then
			self:hideCdNode()
		else
			self:showBuildAnim()
		end
	else
		self:hideCdNode()
	end
end

function BuildingDecorate:hideCdNode()
	local view = self:getView()

	if view:getChildByName("Cd_Node") then
		view:getChildByName("Cd_Node"):setVisible(false)
	end

	self:hideBuildAnim()
end

function BuildingDecorate:updateResouseNum()
	if not self._createSta then
		return
	end

	local view = self:getView()
	local mySelf = self

	local function createResouseUi(buildInfo)
		local resouseUi = cc.CSLoader:createNode("asset/ui/BuildingCollectTips.csb")

		if resouseUi then
			resouseUi:setName("ResouseUi")
			self._resourceNode:addChild(resouseUi, 1)
			resouseUi:getChildByFullName("iconBg.icon"):setContentSize(cc.size(56, 56))

			if buildInfo._type == KBuildingType.kGoldOre then
				resouseUi:getChildByFullName("iconBg.icon"):loadTexture("icon_jb.png", ccui.TextureResType.plistType)
				self:setupClickEnvs()
			elseif buildInfo._type == KBuildingType.kCrystalOre then
				resouseUi:getChildByFullName("iconBg.icon"):loadTexture("icon_shuijing_1.png", ccui.TextureResType.plistType)
			elseif buildInfo._type == KBuildingType.kExpOre then
				resouseUi:getChildByFullName("iconBg.icon"):loadTexture("icon_jingyan.png", ccui.TextureResType.plistType)
			elseif buildInfo._type == KBuildingType.kMainCity then
				resouseUi:getChildByFullName("iconBg.icon"):loadTexture("zc_icon_rl.png", ccui.TextureResType.plistType)
			end

			local resouseType = buildInfo._type
			local clickPanel = resouseUi:getChildByFullName("iconBg")

			clickPanel:addClickEventListener(function()
				if buildInfo._type == KBuildingType.kMainCity then
					AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
					self:onClickDailyGift()
				else
					if resouseType == KBuildingType.kGoldOre then
						AudioEngine:getInstance():playEffect("Se_Click_Coin", false)
					elseif resouseType == KBuildingType.kCrystalOre then
						AudioEngine:getInstance():playEffect("Se_Click_Jingsha", false)
					elseif resouseType == KBuildingType.kExpOre then
						AudioEngine:getInstance():playEffect("Se_Click_Bottle", false)
					end

					local params = {}

					params.roomId = mySelf._roomId
					params.buildId = mySelf._id

					mySelf._buildingSystem:sendOneKeyCollectRes("main")
				end
			end)
		end

		return resouseUi
	end

	local resouseUi = self._resourceNode:getChildByName("ResouseUi")
	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)

	if buildingData then
		if buildingData._type == KBuildingType.kMainCity then
			local activitySystem = self._buildingSystem:getInjector():getInstance(ActivitySystem)
			local showSta = activitySystem:hasRedPointForActivity(DailyGift)

			if showSta then
				resouseUi = resouseUi or createResouseUi(buildingData)

				if resouseUi then
					resouseUi:setVisible(false)
				end

				return
			end
		else
			local resouseNum = buildingData:getResouseNum()

			if resouseNum and resouseNum > 0 then
				resouseUi = resouseUi or createResouseUi(buildingData)

				if resouseUi then
					resouseUi:setVisible(true)
				end

				return
			end
		end
	end

	if resouseUi then
		resouseUi:setVisible(false)
	end
end

function BuildingDecorate:getLootInfo(num)
	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)

	if buildingData then
		local animName
		local outLineColor = cc.c4b(51, 24, 20, 219.29999999999998)
		local lineGradiantVec2
		local lineGradiantDir = {
			x = 0,
			y = -1
		}

		if buildingData._type == KBuildingType.kGoldOre then
			animName = "jibi_lingquziyuan"
			lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 99, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 253, 227, 255)
				}
			}
		elseif buildingData._type == KBuildingType.kCrystalOre then
			animName = "shuijing_lingquziyuan"
			lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(223, 145, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(240, 227, 255, 255)
				}
			}
		elseif buildingData._type == KBuildingType.kExpOre then
			animName = "pingzi_lingquziyuan"
			lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(242, 185, 124, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 255, 227, 255)
				}
			}
		end

		local numLab = cc.Label:createWithTTF(num or 0, TTF_FONT_FZYH_M, 25)

		numLab:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
		numLab:enableOutline(outLineColor, 2)

		local lootInfo = {}

		lootInfo.numLab = numLab
		lootInfo.type = buildingData._type

		return lootInfo
	end
end

local actionTag = 99898

function BuildingDecorate:runActionBrightness()
	if not self._createSta then
		return
	end

	local view = self:getView()
	local sequence1 = cc.Sequence:create(BrightnessTo:create(1, -50), BrightnessTo:create(1, 0))
	local action1 = cc.RepeatForever:create(sequence1)

	action1:setTag(actionTag)
	self._buildingImg:stopActionByTag(actionTag)
	self._buildingImg:runAction(action1)

	local villageEffect = self._rotateNode:getChildByName("villageEffect")

	if villageEffect then
		local sequence2 = cc.Sequence:create(BrightnessTo:create(1, -50), BrightnessTo:create(1, 0))
		local action2 = cc.RepeatForever:create(sequence2)

		action2:setTag(actionTag)
		villageEffect:stopActionByTag(actionTag)
		villageEffect:runAction(action2)
	end
end

function BuildingDecorate:stopActionBrightness()
	local view = self:getView()

	self._buildingImg:stopActionByTag(actionTag)
	self._buildingImg:setBrightness(0)

	local villageEffect = self._rotateNode:getChildByName("villageEffect")

	if villageEffect then
		villageEffect:stopActionByTag(actionTag)
		villageEffect:setBrightness(0)
	end
end

function BuildingDecorate:removeFromParent()
	self:getView():removeFromParent()

	self._view = nil
end

function BuildingDecorate:refreshLvUpImg()
	if not self._createSta then
		return
	end

	local view = self:getView()
	local lvUpImg = view:getChildByName("LvUpImg")

	if self._buildingSystem:getBuildingCanLvUp(self._roomId, self._id) then
		if not lvUpImg then
			lvUpImg = cc.MovieClip:create("anim_ziyuantisheng")

			view:addChild(lvUpImg, buildingZorder.kLvUp)
			lvUpImg:setName("LvUpImg")

			local imgHeight = self._buildingImg:getContentSize().height

			lvUpImg:setPosition(cc.p(0, imgHeight / 2))
			lvUpImg:gotoAndPlay(0)
		end

		lvUpImg:setVisible(true)
	else
		self:hideLvUpImg()
	end
end

function BuildingDecorate:hideLvUpImg()
	local view = self:getView()
	local lvUpImg = view:getChildByName("LvUpImg")

	if lvUpImg then
		lvUpImg:setVisible(false)
	end
end

function BuildingDecorate:showBuildAnim()
	local view = self:getView()
	local buildAnimNode = view:getChildByName("buildAnimNode")

	if not buildAnimNode then
		buildAnimNode = cc.Node:create()

		buildAnimNode:setName("buildAnimNode")
		view:addChild(buildAnimNode, buildingZorder.kBuildAnim)

		local skinId = self._buildingSystem:getBuildingSkinId(self._roomId, self._buildingId, self._id)
		local specialEffectsPosition = ConfigReader:getDataByNameIdAndKey("VillageBuildingSurface", skinId, "SpecialEffectsPosition")

		if specialEffectsPosition and #specialEffectsPosition > 0 then
			for k, v in pairs(specialEffectsPosition) do
				for kk, vv in pairs(v) do
					local animName = kk .. "_xiaoguaijianzao"
					local anim = cc.MovieClip:create(animName)

					buildAnimNode:addChild(anim)
					anim:setPosition(cc.p(vv[1], vv[2]))
					anim:gotoAndPlay(1)
				end
			end
		end
	end

	buildAnimNode:setVisible(true)
end

function BuildingDecorate:hideBuildAnim()
	local view = self:getView()
	local buildAnimNode = view:getChildByName("buildAnimNode")

	if buildAnimNode then
		buildAnimNode:setVisible(false)
	end
end

function BuildingDecorate:onClickDailyGift()
	local activitySystem = self._buildingSystem:getInjector():getInstance(ActivitySystem)
	local showSta = activitySystem:hasRedPointForActivity(DailyGift)

	if showSta then
		local view = self:getInjector():getInstance("DailyGiftView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view))
	end
end

function BuildingDecorate:changeResourseScale(scale)
	self._resourceNode:setScale(scale or 1)
	self._resourceAnimNode:setScale(scale or 1)
end

function BuildingDecorate:hideResoure()
	self._resourceNode:setVisible(false)
end

function BuildingDecorate:showResoure()
	self._resourceNode:setVisible(true)
end

function BuildingDecorate:isTouchOnBuilding(worldPt)
	if not self._createSta then
		return false
	end

	if self:isVisible() == false then
		return false
	end

	if not worldPt then
		return false
	end

	local hitingShape = self._buildingImg:getHittingShape()

	if not hitingShape then
		return false
	end

	local camera = cc.Camera:getVisitingCamera()

	if self._buildingImg:hitTest(worldPt, camera, nil) then
		local rectangle = self._buildingImg:getClippingEffectiveRect()

		if cc.rectContainsPoint(rectangle, worldPt) then
			return true
		end
	end

	return false
end

function BuildingDecorate:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local roomId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_RoomId").content or ""
	local itemId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_ItemId1").content or ""
	local sequence = cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local resouseUi = self._resourceNode:getChildByName("ResouseUi")
		local buildingData = self._buildingSystem:getBuildingData(roomId, itemId)
		local coinCharge = resouseUi:getChildByFullName("iconBg.icon")

		if coinCharge then
			storyDirector:setClickEnv("BuildingDecorate.coinCharge", coinCharge, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

				local params = {}

				params.roomId = roomId
				params.buildId = itemId

				self._buildingSystem:sendOneKeyCollectRes("main")
			end)
		end

		storyDirector:notifyWaiting("enter_BuildingDecorate_view")
	end))

	self:getView():runAction(sequence)
end
