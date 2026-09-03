-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryAlbumShotsMediator.lua

GalleryAlbumShotsMediator = class("GalleryAlbumShotsMediator", DmAreaViewMediator, _M)

GalleryAlbumShotsMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryAlbumShotsMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {
	["movePanel.moveBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickMove"
	},
	["movePanel.deleteBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickDelete"
	},
	["btnPanel.shotBtn"] = {
		clickAudio = "Se_Story_Shutter",
		func = "onClickShot"
	},
	["btnPanel.backGroundBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBackGround"
	},
	["btnPanel.heroBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickHeroes"
	}
}
local scaleLimitMax = 3
local scaleLimitMin = 0.2
local scrollStep = 0.0001
local bgFile = "asset/scene/"

function GalleryAlbumShotsMediator:initialize()
	super.initialize(self)
end

function GalleryAlbumShotsMediator:dispose()
	super.dispose(self)
end

function GalleryAlbumShotsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function GalleryAlbumShotsMediator:enterWithData(data)
	self:initData()
	self:updateData()
	self:initWidgetInfo()
	self:initTouchLayer()
	self:initHeroView()
	self:initBgView()
	self:updateView()

	if data and data.id then
		self._isReturn = true

		self:onClickHeroIcon(nil, ccui.TouchEventType.ended, data.id)
	end

	self:runStartAnim()
	self:setupTopInfoWidget()
end

function GalleryAlbumShotsMediator:initData()
	self._bgIndex = 1
	self._bgList = self._gallerySystem:getAlbumBackgrounds()
	self._order = 0
	self._heroList = {}

	local ids = self._heroSystem:getOwnHeroIds()

	for i = 1, #ids do
		self._heroList[#self._heroList + 1] = ids[i].roleModel
	end

	self._idMap = {}
	self._addHeroes = {}

	for i = 1, #self._heroList do
		self._idMap[self._heroList[i]] = {
			isAdd = false,
			scale = 1,
			order = 1,
			position = {
				568,
				320
			},
			anchor = {
				0.5,
				0.5
			}
		}
	end

	self._photoData = {
		backGround = self._bgList[self._bgIndex],
		heroes = {}
	}
	self._showHero = false
	self._showBg = false
	self._selectHeroId = ""
	self._heroesNum = 0
	self._touchPointsCache = {}
	self._soundId = nil
end

function GalleryAlbumShotsMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._maskPanel = self:getView():getChildByFullName("maskPanel")

	self._maskPanel:setVisible(false)

	self._photoImg = self._main:getChildByName("photoImg")
	self._backGroundPanel = self:getView():getChildByFullName("btnPanel.backGroundPanel")
	self._heroesPanel = self:getView():getChildByFullName("btnPanel.heroesPanel")
	self._movePanel = self:getView():getChildByFullName("movePanel")

	self._movePanel:setVisible(false)
	self._movePanel:getChildByFullName("moveBtn"):setSwallowTouches(false)
	self:ignoreSafeArea()

	local view = self:getInjector():getInstance("GalleryAlbumInfoView")

	view:addTo(self:getView())
	view:setLocalZOrder(-100)

	self._shotMediator = self:getMediatorMap():retrieveMediator(view)

	self._shotMediator:getView():setVisible(false)
end

function GalleryAlbumShotsMediator:initTouchLayer()
	self._touchLayer = cc.Layer:create()

	self._touchLayer:addTo(self._main)
	self._touchLayer:setSwallowsTouches(true)
	self._touchLayer:setTouchEnabled(true)
	self._touchLayer:setTouchMode(cc.EVENT_TOUCH_ALL_AT_ONCE)
	self._touchLayer:onTouch(function(event)
		self:onClickTouchLayer(event)
	end, true, false)
end

function GalleryAlbumShotsMediator:initShotView()
	self._shotMediator:getView():setVisible(true)

	local data = self._photoData

	self._shotMediator:enterWithData({
		takePhoto = true,
		photoData = data
	})
	CommonUtils.captureNode(self._shotMediator:getView(), 0.4, nil, self._photoData.id)
end

function GalleryAlbumShotsMediator:ignoreSafeArea()
	local btnPanel = self:getView():getChildByFullName("btnPanel")

	AdjustUtils.ignorSafeAreaRectForNode(btnPanel, AdjustUtils.kAdjustType.Right)
end

function GalleryAlbumShotsMediator:initHeroView()
	self._heroesPanel:setVisible(self._showHero)

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return 80, 100
	end

	local function numberOfCellsInTableView(table)
		return #self._heroList
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createTeamCell(cell, idx + 1)

		return cell
	end

	local width = self._heroesPanel:getContentSize().width
	local height = self._heroesPanel:getContentSize().height
	local tableView = cc.TableView:create(cc.size(width - 40, height))

	self._heroView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(cc.p(20, 2))
	self._heroesPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()
end

function GalleryAlbumShotsMediator:createTeamCell(cell, index)
	cell:removeAllChildren()

	local id = self._heroList[index]
	local layer = ccui.Layout:create()

	layer:setAnchorPoint(cc.p(0, 0))
	layer:addTo(cell)
	layer:setTouchEnabled(true)
	layer:setContentSize(cc.size(80, 100))
	layer:addTouchEventListener(function(sender, eventType)
		self:onClickHeroIcon(sender, eventType, id)
	end)
	layer:setSwallowTouches(false)

	local sprite = cc.Sprite:create("asset/heroRect/heroIconRect/kazu_bg_ka_bai.png")

	sprite:setScale(0.5)

	local heroImg = IconFactory:createRoleIconSpriteNew({
		id = id
	})

	heroImg = IconFactory:addStencilForIcon(heroImg, 1, cc.size(125, 138))

	heroImg:addTo(sprite):center(sprite:getContentSize())
	heroImg:offset(-2, 3)
	layer:addChild(sprite)
	sprite:setPosition(40, 50)

	local selectImg = ccui.Scale9Sprite:createWithSpriteFrameName("yizhuang_icon_ixuanzhong.png", cc.rect(13, 13, 13, 13))

	selectImg:setContentSize(cc.size(70, 78))
	selectImg:addTo(layer):center(layer:getContentSize())
	selectImg:offset(-1, 1)
	selectImg:setVisible(self._idMap[id].isAdd)
end

function GalleryAlbumShotsMediator:initBgView()
	self._backGroundPanel:setVisible(self._showBg)

	local function scrollViewDidScroll(view)
		self._isReturn1 = false
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return 150, 100
	end

	local function numberOfCellsInTableView(table)
		return #self._bgList
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		cell:removeAllChildren()

		local index = idx + 1
		local layer = ccui.Layout:create()

		layer:setAnchorPoint(cc.p(0, 0))
		layer:addTo(cell)
		layer:setContentSize(cc.size(150, 110))
		layer:setTouchEnabled(true)
		layer:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				self._isReturn1 = true
			elseif eventType == ccui.TouchEventType.ended and self._isReturn1 then
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

				self._bgIndex = index

				local offsetX = self._bgView:getContentOffset().x

				self._bgView:reloadData()
				self._bgView:setContentOffset(cc.p(offsetX, 0))
				self:updateView()

				self._photoData.backGround = self._bgList[self._bgIndex]
			end
		end)
		layer:setSwallowTouches(false)

		local sprite = ccui.ImageView:create(bgFile .. "s_" .. self._bgList[index])

		sprite:setScale(0.5)
		sprite:addTo(layer):center(layer:getContentSize())

		local selectImg = ccui.ImageView:create("album_bg_xz.png", 1)

		selectImg:addTo(layer):center(layer:getContentSize())
		selectImg:setVisible(self._bgIndex == index)

		return cell
	end

	local width = self._backGroundPanel:getContentSize().width
	local height = self._backGroundPanel:getContentSize().height
	local tableView = cc.TableView:create(cc.size(width - 40, height))

	self._bgView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(cc.p(20, 1))
	self._backGroundPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()
end

function GalleryAlbumShotsMediator:updateView()
	local icon = self._bgList[self._bgIndex]

	self._photoImg:loadTexture(bgFile .. icon)
end

function GalleryAlbumShotsMediator:updateHeroes()
	self._photoImg:removeAllChildren()

	self._addHeroes = {}

	for id, value in pairs(self._idMap) do
		if value.isAdd then
			local img = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe9",
				id = id
			})

			img:addTo(self._photoImg)
			img:setAnchorPoint(value.anchor[1], value.anchor[2])
			img:setPosition(cc.p(value.position[1], value.position[2]))
			img:setLocalZOrder(value.order)
			img:setScale(value.scale)
			img:setSwallowTouches(true)
			img:setTouchEnabled(true)
			img:addTouchEventListener(function(sender, eventType)
				self:onClickAddHero(sender, eventType, id)
			end)

			self._addHeroes[id] = img
		end
	end
end

function GalleryAlbumShotsMediator:updateData()
	self._scale = nil
	self._distance = nil
	self._photoData.heroes = {}

	for id, object in pairs(self._addHeroes) do
		self._photoData.heroes[id] = {
			order = object:getLocalZOrder(),
			position = {
				object:getPositionX(),
				object:getPositionY()
			},
			scale = object:getScale(),
			anchor = {
				object:getAnchorPoint().x,
				object:getAnchorPoint().y
			}
		}
		self._idMap[id].scale = object:getScale()
		self._idMap[id].position = {
			object:getPositionX(),
			object:getPositionY()
		}
		self._idMap[id].anchor = {
			object:getAnchorPoint().x,
			object:getAnchorPoint().y
		}
	end
end

function GalleryAlbumShotsMediator:checkHeroesNum(id)
	self._heroesNum = 0

	for i, v in pairs(self._photoData.heroes) do
		if id ~= i then
			self._heroesNum = self._heroesNum + 1
		end
	end
end

function GalleryAlbumShotsMediator:onClickBack()
	if self._soundId then
		AudioEngine:getInstance():stopEffect(self._soundId)
	end

	self:dismiss()
end

function GalleryAlbumShotsMediator:onClickMove()
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:get("Source_General_Unknown")
	}))
end

function GalleryAlbumShotsMediator:onClickDelete()
	if self._selectHeroId ~= "" then
		self._idMap[self._selectHeroId].isAdd = not self._idMap[self._selectHeroId].isAdd
		self._idMap[self._selectHeroId].position = {
			568,
			320
		}
		self._idMap[self._selectHeroId].anchor = {
			0.5,
			0.5
		}
		self._idMap[self._selectHeroId].scale = 1

		self._heroView:reloadData()

		local offsetX = self._heroView:getContentOffset().x

		self._heroView:setContentOffset(cc.p(offsetX, 0))
		self:updateHeroes()
		self:updateData()

		self._selectHeroId = ""

		self._movePanel:changeParent(self:getView())
		self._movePanel:setVisible(false)
	end
end

function GalleryAlbumShotsMediator:onClickShot()
	local currentTimeStamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()

	self._photoData.id = "GALLERY_" .. math.floor(currentTimeStamp) .. ".jpg"

	self:initShotView()
	self._maskPanel:setVisible(true)

	local maskImage = self:getView():getChildByName("maskImage")
	local fadeIn = cc.FadeIn:create(0.2)
	local fadeOut = cc.FadeOut:create(0.2)
	local func = cc.CallFunc:create(function()
		maskImage:setOpacity(0)
		self._maskPanel:setVisible(false)
		self._shotMediator:getView():setVisible(false)

		local view = self:getInjector():getInstance("GalleryAlbumInfoView")

		self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil, {
			photoData = self._photoData
		}))
	end)
	local seq = cc.Sequence:create(fadeIn, fadeOut, func)

	maskImage:runAction(seq)
end

function GalleryAlbumShotsMediator:onClickBackGround()
	self._showBg = not self._showBg

	self._backGroundPanel:setVisible(self._showBg)
end

function GalleryAlbumShotsMediator:onClickHeroes()
	self._showHero = not self._showHero

	self._heroesPanel:setVisible(self._showHero)
end

function GalleryAlbumShotsMediator:onClickHeroIcon(sender, eventType, id)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		if self._soundId then
			AudioEngine:getInstance():stopEffect(self._soundId)
		end

		self:checkHeroesNum(id)

		if self._heroesNum >= self._gallerySystem:getAlbumPhotoHeroesLimit() then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("GALLERY_UI26", {
					num = self._gallerySystem:getAlbumPhotoHeroesLimit()
				})
			}))
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			return
		end

		self._selectHeroId = ""

		self._movePanel:changeParent(self:getView())
		self._movePanel:setVisible(false)

		self._idMap[id].isAdd = not self._idMap[id].isAdd

		local offsetX = self._heroView:getContentOffset().x

		self._heroView:reloadData()
		self._heroView:setContentOffset(cc.p(offsetX, 0))

		if self._idMap[id].isAdd then
			self._order = self._order + 1
			self._idMap[id].order = self._order

			local heroId = string.split(id, "_")[2]

			self._soundId = AudioEngine:getInstance():playEffect("Voice_" .. heroId .. "_23", false)
		else
			self._idMap[id].scale = 1
			self._idMap[id].anchor = {
				0.5,
				0.5
			}
			self._idMap[id].position = {
				568,
				320
			}

			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		end

		self:updateHeroes()
		self:updateData()
	end
end

function GalleryAlbumShotsMediator:getPointById(id, points)
	for k, v in pairs(points) do
		if v.id == id then
			v.x = math.floor(v.x)
			v.y = math.floor(v.y)

			return v
		end
	end

	return nil
end

function GalleryAlbumShotsMediator:onClickTouchLayer(event)
	if self._selectHeroId == "" then
		self._touchPointsCache = {}

		return
	end

	self._addHeroes[self._selectHeroId]:setTouchEnabled(true)

	if event.name == "began" then
		for k, v in pairs(event.points) do
			local targetPos = self._touchLayer:getParent():convertToWorldSpace(cc.p(v.x, v.y))
			local pos = self._addHeroes[self._selectHeroId]:getParent():convertToNodeSpace(targetPos)
			local isCantion = cc.rectContainsPoint(self._addHeroes[self._selectHeroId]:getBoundingBox(), cc.p(pos.x, pos.y))

			if (v.id == 1 or v.id == 0) and isCantion then
				self._touchPointsCache[tostring(v.id)] = {
					x = v.x,
					y = v.y,
					id = v.id
				}
			end
		end

		if table.nums(self._touchPointsCache) ~= 2 then
			self._isMultiTouch = false

			return
		end

		self._addHeroes[self._selectHeroId]:setTouchEnabled(false)

		local p1 = cc.p(self._touchPointsCache["0"].x, self._touchPointsCache["0"].y)
		local p2 = cc.p(self._touchPointsCache["1"].x, self._touchPointsCache["1"].y)
		local middlePoint = cc.pMidpoint(p1, p2)
		local sender = self._addHeroes[self._selectHeroId]
		local pos = sender:convertToNodeSpace(middlePoint)
		local aX = 0.5 * pos.x / (sender:getContentSize().width / 2)
		local aY = 0.5 * pos.y / (sender:getContentSize().height / 2)

		sender:setAnchorPoint(cc.p(aX, aY))

		local posCur = sender:getParent():convertToNodeSpace(middlePoint)

		sender:setPosition(posCur)

		self._distance = cc.pGetDistance(p1, p2)
		self._scale = self._addHeroes[self._selectHeroId]:getScale()
	elseif event.name == "moved" then
		if table.nums(self._touchPointsCache) ~= 2 then
			self._isMultiTouch = false

			return
		end

		local p1 = self:getPointById(0, event.points)
		local p2 = self:getPointById(1, event.points)

		p1 = p1 or cc.p(self._touchPointsCache["0"].x, self._touchPointsCache["0"].y)
		p2 = p2 or cc.p(self._touchPointsCache["1"].x, self._touchPointsCache["1"].y)

		if not self._distance then
			self._isMultiTouch = true

			return
		end

		self._addHeroes[self._selectHeroId]:setTouchEnabled(false)

		local length = cc.pGetDistance(cc.p(p1.x, p1.y), cc.p(p2.x, p2.y))
		local diff = length - self._distance

		diff = math.floor(diff)

		if math.abs(diff) > 5 then
			local newScale = self._scale + diff * scrollStep

			if newScale >= scaleLimitMax then
				newScale = scaleLimitMax
			end

			if newScale <= scaleLimitMin then
				newScale = scaleLimitMin
			end

			self._addHeroes[self._selectHeroId]:setScale(newScale)

			self._isMultiTouch = true
			self._scale = newScale
		end
	elseif event.name == "ended" then
		for k, v in pairs(event.points) do
			if (v.id == 1 or v.id == 0) and self._touchPointsCache[tostring(v.id)] then
				self._touchPointsCache[tostring(v.id)] = nil
			end
		end

		self._addHeroes[self._selectHeroId]:setTouchEnabled(true)

		if self._isMultiTouch then
			self:updateData()
		end
	end
end

function GalleryAlbumShotsMediator:refreshScaleNum(length)
	local newScale = self._scale * length / self._distance

	if newScale >= scaleLimitMax then
		newScale = scaleLimitMax
	end

	if newScale <= scaleLimitMin then
		newScale = scaleLimitMin
	end

	return newScale
end

function GalleryAlbumShotsMediator:onClickAddHero(sender, eventType, id)
	if eventType == ccui.TouchEventType.began then
		self._selectHeroId = id

		self._movePanel:changeParent(sender)
		self._movePanel:setVisible(true)

		local posX = sender:getContentSize().width / 2
		local posY = sender:getContentSize().height / 2

		self._movePanel:setPosition(cc.p(posX, posY))

		local beganPos = sender:getTouchBeganPosition()

		self._isMove = false

		local pos = sender:convertToNodeSpace(beganPos)
		local aX = 0.5 * pos.x / (sender:getContentSize().width / 2)
		local aY = 0.5 * pos.y / (sender:getContentSize().height / 2)

		sender:setAnchorPoint(cc.p(aX, aY))

		local pos = sender:getParent():convertToNodeSpace(beganPos)

		sender:setPosition(pos)
	elseif eventType == ccui.TouchEventType.moved then
		self._isMove = true

		local movedPos = sender:getTouchMovePosition()
		local pos = sender:getParent():convertToNodeSpace(movedPos)

		sender:setPosition(pos)
	elseif eventType == ccui.TouchEventType.ended and self._isMove then
		local endPostion = sender:getTouchEndPosition()
		local pos = sender:getParent():convertToNodeSpace(endPostion)

		sender:setPosition(pos)
		self:updateData()
	end
end

function GalleryAlbumShotsMediator:runStartAnim()
	local btnPanel = self:getView():getChildByFullName("btnPanel")

	btnPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/GalleryAlbumShots.csb")

	btnPanel:runAction(action)
	action:gotoFrameAndPlay(0, 35, false)
	action:setTimeSpeed(1.6)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "EndAnim" then
			-- block empty
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function GalleryAlbumShotsMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end
