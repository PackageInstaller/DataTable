-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryAlbumMediator.lua

GalleryAlbumMediator = class("GalleryAlbumMediator", DmAreaViewMediator, _M)

GalleryAlbumMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryAlbumMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {
	["main.albumBg.cameraBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickCamera"
	}
}
local kNums = 4

function GalleryAlbumMediator:initialize()
	super.initialize(self)
end

function GalleryAlbumMediator:dispose()
	super.dispose(self)
end

function GalleryAlbumMediator:resumeWithData()
	local albumBg = self._main:getChildByFullName("albumBg")

	albumBg:getChildByFullName("cameraBtn"):setPositionY(88)
	albumBg:getChildByFullName("cameraBtn"):setOpacity(255)
	albumBg:getChildByFullName("cameraBtn"):setScale(1)
	self._main:getChildByFullName("animCellClone"):setVisible(false)
	self._tableViewPanel:setVisible(true)
end

function GalleryAlbumMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_DELETE_PHOTO_SUCC, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_TAKE_PHOTO_SUCC, self, self.refreshBySync)
	self:ignoreSafeArea()
end

function GalleryAlbumMediator:setupView()
	self:refreshData()
	self:initWidgetInfo()
	self:initShotView()
	self:initView()
	self:refreshView()
end

function GalleryAlbumMediator:initShotView()
	self._shotMediator:getView():setVisible(true)

	for i = 1, #self._photoList do
		local data = self._photoList[i]
		local path = CommonUtils.getSavePathByName(data.id)

		if not path then
			self._shotMediator:enterWithData({
				takePhoto = true,
				photoData = data
			})
			CommonUtils.captureNode(self._shotMediator:getView(), 0.4, nil, data.id)
		end
	end

	self._shotMediator:getView():setVisible(false)
end

function GalleryAlbumMediator:refreshBySync()
	self:refreshData()
	self:refreshView()
end

function GalleryAlbumMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._emptyTip = self._main:getChildByFullName("emptyTip")
	self._tableViewPanel = self._main:getChildByFullName("tableView")
	self._cellClone = self._main:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._touchLayer = self:getView():getChildByFullName("touchLayer")

	self._touchLayer:setVisible(false)

	local view = self:getInjector():getInstance("GalleryAlbumInfoView")

	view:addTo(self:getView())
	view:setLocalZOrder(-100)

	self._shotMediator = self:getMediatorMap():retrieveMediator(view)

	self._shotMediator:getView():setVisible(false)
	self._emptyTip:setTouchEnabled(true)
	self._emptyTip:addClickEventListener(function(sender)
		self:onClickCamera(sender)
	end)
end

function GalleryAlbumMediator:ignoreSafeArea()
	local image = self:getView():getChildByFullName("main.albumBg")

	AdjustUtils.ignorSafeAreaRectForNode(image, AdjustUtils.kAdjustType.Bottom)
	AdjustUtils.ignorSafeAreaRectForNode(image, AdjustUtils.kAdjustType.Right)
end

function GalleryAlbumMediator:initView()
	local cellWidth = self._cellClone:getContentSize().width
	local cellHeight = self._cellClone:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		if self._cellNum > 1 and idx + 1 == self._cellNum then
			return cellWidth, cellHeight + 60
		end

		return cellWidth, cellHeight
	end

	local function numberOfCellsInTableView(table)
		return self._cellNum
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local panel = self._cellClone:clone()

			panel:setVisible(true)
			panel:setTag(12138)
			panel:addTo(cell)
			panel:setPosition(cc.p(0, 0))
		end

		self:createTeamCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._tableViewPanel:getContentSize())

	self._photoView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._tableViewPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
end

function GalleryAlbumMediator:createTeamCell(cell, index)
	local panel = cell:getChildByTag(12138)

	if self._cellNum > 1 and index == self._cellNum then
		panel:setPositionY(60)
	else
		panel:setPositionY(0)
	end

	local list = self._photoList

	for i = 1, kNums do
		local node = panel:getChildByFullName("node_" .. i)

		node:setVisible(false)

		local heroPanel = node:getChildByFullName("heroPanel")

		heroPanel.path = nil

		local data = list[kNums * (index - 1) + i]

		if data then
			local id = data.id
			local path = CommonUtils.getSavePathByName(id)

			if not path then
				return
			end

			local sprite = cc.Sprite:create(path)

			node:setVisible(true)

			heroPanel.path = path

			heroPanel:removeAllChildren()
			heroPanel:setSwallowTouches(false)
			heroPanel:addTouchEventListener(function(sender, eventType)
				self:onClickHeroIcon(sender, eventType, data)
			end)
			sprite:addTo(heroPanel):center(heroPanel:getContentSize())
		end
	end
end

function GalleryAlbumMediator:refreshData()
	self._photoList = self._gallerySystem:getAlbumPhotos()
	self._cellNum = math.ceil(#self._photoList / kNums)
end

function GalleryAlbumMediator:refreshView()
	self._emptyTip:setVisible(#self._photoList == 0)
	self._photoView:reloadData()
end

function GalleryAlbumMediator:onClickHeroIcon(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true

		local scale1 = cc.ScaleTo:create(0.1, 0.9)

		sender:getParent():runAction(scale1)
	elseif eventType == ccui.TouchEventType.ended then
		if self._isReturn then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self._touchLayer:setVisible(true)

			local scale3 = cc.ScaleTo:create(0.12, 1)
			local callfunc = cc.CallFunc:create(function()
				local view = self:getInjector():getInstance("GalleryAlbumInfoView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
					photoData = data
				}))

				self._isReturn = true

				self._touchLayer:setVisible(false)
			end)
			local seq = cc.Sequence:create(scale3, callfunc)

			sender:getParent():runAction(seq)
		else
			sender:getParent():stopAllActions()
		end

		sender:getParent():setScale(1)
	elseif eventType == ccui.TouchEventType.canceled then
		sender:getParent():stopAllActions()
		sender:getParent():setScale(1)
	end
end

function GalleryAlbumMediator:onClickCamera(sender)
	self._touchLayer:setVisible(true)

	if sender:getName() == "emptyTip" then
		local scale2 = cc.ScaleTo:create(0.1, 0.9)
		local scale3 = cc.ScaleTo:create(0.15, 1)
		local callfunc = cc.CallFunc:create(function()
			self._touchLayer:setVisible(false)

			local view = self:getInjector():getInstance("GalleryAlbumShotsView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, nil))
		end)
		local seq = cc.Sequence:create(scale2, scale3, callfunc)

		sender:runAction(seq)
	else
		self._tableViewPanel:setVisible(false)
		self:updateAnimPanel()
		self._main:stopAllActions()

		local action = cc.CSLoader:createTimeline("asset/ui/GalleryAlbum.csb")

		self._main:runAction(action)
		action:gotoFrameAndPlay(30, 42, false)
		action:setTimeSpeed(1.1)

		local function onFrameEvent(frame)
			if frame == nil then
				return
			end

			local str = frame:getEvent()

			if str == "EndAnim1" then
				self._touchLayer:setVisible(false)

				local view = self:getInjector():getInstance("GalleryAlbumShotsView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, nil))
			end
		end

		action:clearFrameEventCallFunc()
		action:setFrameEventCallFunc(onFrameEvent)
	end
end

function GalleryAlbumMediator:runStartAnim()
	self._tableViewPanel:setVisible(false)
	self:updateAnimPanel()
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/GalleryAlbum.csb")

	self._main:runAction(action)
	action:gotoFrameAndPlay(0, 30, false)
	action:setTimeSpeed(1.1)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "EndAnim" then
			self._tableViewPanel:setVisible(true)
			self._main:getChildByFullName("animCellClone"):setVisible(false)
		end
	end

	action:clearFrameEventCallFunc()
	action:setFrameEventCallFunc(onFrameEvent)
end

function GalleryAlbumMediator:updateAnimPanel()
	local animClone = self._main:getChildByFullName("animCellClone")

	animClone:setVisible(true)

	local allCells = self._photoView:getContainer():getChildren()

	for i = 1, 2 do
		if allCells[i] then
			for index = 1, kNums do
				local num = kNums * (i - 1) + index
				local node = animClone:getChildByFullName("node_" .. num)

				if node then
					node:setVisible(false)

					local path = allCells[i]:getChildByTag(12138):getChildByFullName("node_" .. index .. ".heroPanel").path

					if path then
						local heroPanel = node:getChildByFullName("heroPanel")

						heroPanel:removeAllChildren()

						local sprite = cc.Sprite:create(path)

						sprite:addTo(heroPanel):center(heroPanel:getContentSize())
						node:setVisible(true)
					end
				end
			end
		else
			for index = 1, kNums do
				local num = kNums * (i - 1) + index
				local node = animClone:getChildByFullName("node_" .. num)

				if node then
					node:setVisible(false)
				end
			end
		end
	end
end
