-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/view/DreamChallengeMainMediator.lua

DreamChallengeMainMediator = class("DreamChallengeMainMediator", DmAreaViewMediator, _M)

DreamChallengeMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
DreamChallengeMainMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
DreamChallengeMainMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")

local kBtnHandlers = {
	["main.honourBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickHonourBtn"
	},
	["main.callBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCallBtn"
	},
	["main.infoBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickInfoBtn"
	}
}
local DREAM_REDPOINT_SAVE_KEY = "DREAM_REDPOINT_SAVE_KEY"

function DreamChallengeMainMediator:initialize()
	super.initialize(self)
end

function DreamChallengeMainMediator:dispose()
	super.dispose(self)
end

function DreamChallengeMainMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DREAMCHALLENGE_POINT_RESET, self, self.refreshPointCellByEvent)
end

function DreamChallengeMainMediator:enterWithData(data)
	self:initWigetInfo()
	self:initData(data)
	self:setupTopView()
	self:setMapData(data)
	self:createTreeView()
	self:checkPointPassViewShow()
end

function DreamChallengeMainMediator:initWigetInfo()
	self._view = self:getView()
	self._main = self._view:getChildByName("main")
	self._pointTree = self._main:getChildByName("pointTree")
	self._pointView = self._main:getChildByName("point")
	self._firstNode = self._view:getChildByFullName("firstNode")
	self._secNode = self._view:getChildByFullName("secNode")
	self._showImg = self._main:getChildByName("bg")
	self._plist1 = self._main:getChildByName("plist1")
	self._plist2 = self._main:getChildByName("plist2")
	self._plist3 = self._main:getChildByName("plist3")
	self._animNode = self._main:getChildByName("animNode")
end

function DreamChallengeMainMediator:initData(data)
	self._cacheView = nil
	self._mapId = nil

	if data.mapId then
		self._mapId = data.mapId
	end

	self._pointId = nil

	if data.pointId then
		self._pointId = data.pointId
	end

	self._battleId = nil

	if data.battleId then
		self._battleId = data.battleId
	end

	self._fromBattle = false

	if data.fromBattle then
		self._fromBattle = data.fromBattle
	end

	self._treeNodes = {}
	self._rid = self._developSystem:getPlayer():getRid()
end

function DreamChallengeMainMediator:setupTopView()
	local topInfoNode = self:getView():getChildByFullName("main.topinfo")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Quality")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("DreamChallenge_Title")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local labelWordCount = string.len(config.title) / 3

	self._main:getChildByName("infoBtn"):setPositionX(labelWordCount * 70 + 25)
end

function DreamChallengeMainMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function DreamChallengeMainMediator:setMapData(data)
	if self._fromBattle then
		return
	end

	local mapList = self._dreamSystem:getMapIds()

	for i = 1, #mapList do
		local isShow = self._dreamSystem:checkMapShow(mapList[i])
		local isUnLock = self._dreamSystem:checkMapLock(mapList[i])
		local isPass = self._dreamSystem:checkMapPass(mapList[i])

		if isShow and isUnLock then
			if data.mapId == mapList[i] then
				self._mapId = mapList[i]

				local pointIds = self._dreamSystem:getPointIds(mapList[i])

				self._pointId = pointIds[#pointIds]

				break
			end

			if isPass then
				self._mapId = mapList[i]

				local pointIds = self._dreamSystem:getPointIds(mapList[i])

				self._pointId = pointIds[#pointIds]
			else
				local pointIds = self._dreamSystem:getPointIds(mapList[i])

				for j = 1, #pointIds do
					local isPShow = self._dreamSystem:checkPointShow(mapList[i], pointIds[j])
					local isPPass = self._dreamSystem:checkPointPass(mapList[i], pointIds[j])
					local isPUnLock = self._dreamSystem:checkPointLock(mapList[i], pointIds[j])

					if isPShow and isPUnLock and not isPPass then
						self._mapId = mapList[i]
						self._pointId = pointIds[j]

						break
					end
				end
			end
		end
	end

	if self._mapId == nil or self._pointId == nil then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
	end
end

function DreamChallengeMainMediator:createTreeView()
	if self._pointTree then
		self._pointTree:setScrollBarEnabled(false)
		self._pointTree:removeAllChildren()

		self._tree = Tree:new(self._pointTree)

		local node0 = ccui.Layout:create()

		node0:setContentSize(cc.size(205, 0))
		self._tree:createRoot(node0, "root", 0, true)

		local mapList = self._dreamSystem:getMapIds()

		table.sort(mapList, function(a, b)
			local typeA = ConfigReader:getDataByNameIdAndKey("DreamChallengeMap", a, "DCType") or 2
			local sortA = ConfigReader:getDataByNameIdAndKey("DreamChallengeMap", a, "ListLocationNum")

			if sortA == nil then
				sortA = typeA == 1 and -1 or 9999
			end

			local typeB = ConfigReader:getDataByNameIdAndKey("DreamChallengeMap", b, "DCType") or 2
			local sortB = ConfigReader:getDataByNameIdAndKey("DreamChallengeMap", b, "ListLocationNum")

			if sortB == nil then
				sortB = typeB == 1 and -1 or 9999
			end

			return sortA < sortB
		end)

		local firstNodeIndex = 0

		for i = 1, #mapList do
			local isShow = self._dreamSystem:checkMapShow(mapList[i])

			if isShow then
				local isUnLock = self._dreamSystem:checkMapLock(mapList[i])
				local node = self._firstNode:clone()
				local firstNode = self._tree:addFirstLayer(node, mapList[i], 10, true)

				if firstNode then
					firstNodeIndex = firstNodeIndex + 1

					firstNode:setUserData({
						mapIndex = firstNodeIndex,
						mapId = mapList[i]
					})
					firstNode:registClickEvent(self.onMapCellClick, self)

					if self._mapId ~= mapList[i] then
						firstNode:closeList()
					end

					local redPoint = firstNode:getView():getChildByFullName("redPoint")

					if isUnLock then
						local dreamPointRedStste = CommonUtils.getDataFromLocalByKey(self._rid .. DREAM_REDPOINT_SAVE_KEY)

						if dreamPointRedStste == nil then
							dreamPointRedStste = {
								mapArr = {}
							}
						end

						redPoint:setVisible(true)

						for _, v in pairs(dreamPointRedStste.mapArr) do
							if v == mapList[i] then
								redPoint:setVisible(false)
							end
						end
					else
						redPoint:setVisible(false)
					end

					self._treeNodes[mapList[i]] = {}
					self._treeNodes[mapList[i]].node = firstNode
					self._treeNodes[mapList[i]].child = {}
				end

				self:refreshMapCell(mapList[i])

				if isUnLock then
					local pointIds = self._dreamSystem:getPointIds(mapList[i])

					for j = 1, #pointIds do
						local open = self._dreamSystem:checkPointShow(mapList[i], pointIds[j])

						if open then
							local node1 = self._secNode:clone()
							local secNode = self._tree:addSecondLayer(node1, firstNodeIndex, pointIds[j], 0, true)
							local redPoint = secNode:getView():getChildByFullName("redPoint")

							redPoint:setVisible(false)

							if secNode then
								secNode:setUserData({
									mapIndex = firstNodeIndex,
									mapId = mapList[i],
									pointId = pointIds[j]
								})
								secNode:registClickEvent(self.onPointCellClick, self)

								self._treeNodes[mapList[i]].child[pointIds[j]] = secNode
							end

							self:refreshPointCell(mapList[i], pointIds[j], secNode)
						end
					end
				end
			end
		end
	end

	if self._fromBattle then
		self:onPointClick(self._mapId, self._pointId)
	else
		self:viewShow(self._mapId, self._pointId)
	end

	local touchY = self._treeNodes[self._mapId].node:getPositionY()

	self._tree:jumpToByPos(math.abs(touchY) - 91)
	self:onMapRedpointSet()

	local musicId = self._dreamSystem:getMapBGM(self._mapId)

	AudioEngine:getInstance():playBackgroundMusic(musicId[1])
end

function DreamChallengeMainMediator:checkPointPassViewShow()
	if self._fromBattle and self._dreamSystem:checkPointPass(self._mapId, self._pointId) then
		local data = {
			mapId = self._mapId,
			pointId = self._pointId
		}
		local view = self:getInjector():getInstance("DreamChallengePassView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
	end
end

function DreamChallengeMainMediator:onMapCellClick(data)
	local towerType = ConfigReader:getDataByNameIdAndKey("DreamChallengeMap", data.mapId, "DCType")
	local isLock, tip = self._dreamSystem:checkMapLock(data.mapId)

	if not isLock then
		if towerType == 1 then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("ActivityBlock_UI_8")
			}))
			self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
		else
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = tip
			}))
		end

		return
	end

	self._mapId = data.mapId

	if data.pointId then
		self._pointId = data.pointId
	else
		local ids = self._dreamSystem:getPointIds(self._mapId)

		self._pointId = ids[1]
	end

	self:refreshMapCell(self._mapId)
	self:refreshPointCell(self._mapId, self._pointId)
	self:viewShow(self._mapId, self._pointId)

	local musicId = self._dreamSystem:getMapBGM(self._mapId)

	self:onMapRedpointSet()
	AudioEngine:getInstance():playBackgroundMusic(musicId[1])
end

function DreamChallengeMainMediator:onMapRedpointSet()
	local node = self._treeNodes[self._mapId].node:getView()
	local redPoint = node:getChildByFullName("redPoint")

	if redPoint and redPoint:isVisible() then
		redPoint:setVisible(false)

		local dreamPointRedStste = CommonUtils.getDataFromLocalByKey(self._rid .. DREAM_REDPOINT_SAVE_KEY)

		if dreamPointRedStste == nil then
			dreamPointRedStste = {
				mapArr = {}
			}
		end

		if dreamPointRedStste then
			local existRed = false

			for _, v in pairs(dreamPointRedStste.mapArr) do
				if v == self._mapId then
					existRed = true
				end
			end

			if not existRed then
				table.insert(dreamPointRedStste.mapArr, self._mapId)
				CommonUtils.saveDataToLocalByKey(dreamPointRedStste, self._rid .. DREAM_REDPOINT_SAVE_KEY)
			end
		end
	end
end

function DreamChallengeMainMediator:onPointCellClick(data)
	local towerType = ConfigReader:getDataByNameIdAndKey("DreamChallengeMap", data.mapId, "DCType")
	local isLock, tip = self._dreamSystem:checkMapLock(data.mapId)

	if not isLock then
		if towerType == 1 then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("ActivityBlock_UI_8")
			}))
			self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
		else
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = tip
			}))
		end

		return
	end

	self._mapId = data.mapId
	self._pointId = data.pointId

	local mapIndex = data.mapIndex
	local rootNode = self._tree:getRootNode()
	local firstNode = rootNode:getNodeByIndex(mapIndex)

	firstNode:setUserData({
		mapIndex = mapIndex,
		mapId = self._mapId,
		pointId = self._pointId
	})
	self:refreshPointCell(self._mapId, self._pointId)
	self:viewShow(self._mapId, self._pointId)
end

function DreamChallengeMainMediator:refreshMapCell(mapId)
	local node = self._treeNodes[mapId].node:getView()
	local isLock = self._dreamSystem:checkMapLock(mapId)

	node:getChildByName("Lock"):setVisible(not isLock)

	for key, value in pairs(self._treeNodes) do
		local bgNode = value.node:getView()

		bgNode:getChildByName("Bg"):loadTexture("asset/ui/dreamChallenge/" .. (key == self._mapId and self._dreamSystem:getMapTabImage(key) .. "_on.png" or self._dreamSystem:getMapTabImage(key) .. ".png"), ccui.TextureResType.localType)
	end
end

function DreamChallengeMainMediator:refreshPointCell(mapId, pointId)
	local showImg = self._dreamSystem:getPointShowImg(self._mapId, self._pointId)

	self._showImg:loadTexture("asset/scene/" .. showImg, ccui.TextureResType.localType)

	for i, v in pairs(self._treeNodes[mapId].child) do
		local view = v:getView()

		view:getChildByName("guang"):setVisible(i == self._pointId)
	end

	local node = self._treeNodes[mapId].child[pointId]:getView()
	local pointName = self._dreamSystem:getPointName(pointId)

	self._plist1:setVisible(false)
	self._plist2:setVisible(false)
	self._plist3:setVisible(false)
	self._animNode:removeAllChildren()

	local challengeType = DataReader:getDataByNameIdAndKey("DreamChallengePoint", self._pointId, "MissionPicType")

	if kDreamChallengeType.kTwo == challengeType then
		local anim = cc.MovieClip:create("yinghua_CX_yinghuazhixia")

		anim:addTo(self._animNode, 1)
	else
		self._plist1:setVisible(true)
		self._plist2:setVisible(true)
		self._plist3:setVisible(true)
	end

	local pic = self._dreamSystem:getPointTabImage(mapId, pointId)

	node:getChildByName("bg"):loadTexture("asset/ui/dreamChallenge/" .. pic, ccui.TextureResType.localType)

	local lock = self._dreamSystem:checkPointLock(mapId, pointId)
	local lockTag = node:getChildByName("lock")

	lockTag:setVisible(not lock)

	local isPass = self._dreamSystem:checkPointPass(mapId, pointId)

	node:getChildByName("gou"):setVisible(isPass)
end

function DreamChallengeMainMediator:refreshPointCellByEvent(event)
	local data = event:getData()
	local mapId = data.mapId
	local pointId = data.pointId
	local node = self._treeNodes[mapId].child[pointId]:getView()
	local lock = self._dreamSystem:checkPointLock(mapId, pointId)
	local lockTag = node:getChildByName("lock")

	lockTag:setVisible(not lock)

	local isPass = self._dreamSystem:checkPointPass(mapId, pointId)

	node:getChildByName("gou"):setVisible(isPass)
end

function DreamChallengeMainMediator:onClickCallBtn()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("DreamChallenge_Function_Not_Open")
	}))
end

function DreamChallengeMainMediator:onClickHonourBtn()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("DreamChallenge_Function_Not_Open")
	}))
end

function DreamChallengeMainMediator:onClickInfoBtn()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Dream_Challenge_Rule", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = {
			time = TimeUtil:getSystemResetDate()
		}
	}))
end

function DreamChallengeMainMediator:viewShow(mapId, pointId)
	if self._cacheView then
		self._cacheView:removeFromParent()

		self._cacheView = nil
	end

	local view = self:getInjector():getInstance("DreamChallengeDetailView")

	if view then
		view:addTo(self._pointView):center(self._pointView:getContentSize())
		AdjustUtils.adjustLayoutUIByRootNode(view)
		view:setLocalZOrder(2)

		local mediator = self:getMediatorMap():retrieveMediator(view)

		if mediator then
			view.mediator = mediator

			mediator:setupView(self, {
				mapId = mapId,
				pointId = pointId
			})
		end

		self._cacheView = view
	end
end

function DreamChallengeMainMediator:onPointClick(mapId, pointId)
	if self._cacheView then
		self._cacheView:removeFromParent()

		self._cacheView = nil
	end

	local function enterPoint(mapId, pointId)
		local view = self:getInjector():getInstance("DreamChallengePointView")

		if view then
			local showImg = self._dreamSystem:getPointMapShowImg(self._mapId, self._pointId)

			self._showImg:loadTexture("asset/scene/" .. showImg, ccui.TextureResType.localType)
			view:addTo(self._pointView):center(self._pointView:getContentSize())
			AdjustUtils.adjustLayoutUIByRootNode(view)
			view:setLocalZOrder(2)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				view.mediator = mediator

				mediator:setupView(self, {
					mapId = mapId,
					pointId = pointId
				})
			end

			self._cacheView = view
		end
	end

	local function checkGuide(guideName)
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local guideAgent = storyDirector:getStoryAgent()

		guideAgent:setSkipCheckSave(false)
		guideAgent:trigger(guideName, nil, function()
			enterPoint(mapId, pointId)
		end)
	end

	local guideData = ConfigReader:getDataByNameIdAndKey("DreamChallengePoint", pointId, "StoryLink")

	if guideData then
		local scriptName = guideData.enter

		if self._fromBattle and self._dreamSystem:checkPointPass(mapId, pointId) then
			scriptName = guideData["end"]
		end

		if type(scriptName) == "table" and #scriptName > 0 then
			checkGuide(scriptName)
		else
			enterPoint(mapId, pointId)
		end
	else
		enterPoint(mapId, pointId)
	end
end
