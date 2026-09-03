-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryMessageMediator.lua

GalleryMessageMediator = class("GalleryMessageMediator", DmAreaViewMediator, _M)

GalleryMessageMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryMessageMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")
GalleryMessageMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")

local kBtnHandlers = {
	descBtn = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onClickShowTips"
	},
	PanelTouch_tip = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickHideTips"
	},
	["main.messageBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickMessage"
	}
}
local kNums = 5

function GalleryMessageMediator:initialize()
	super.initialize(self)
end

function GalleryMessageMediator:dispose()
	super.dispose(self)
end

function GalleryMessageMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MESSAGE_COMPOSE_SUCC, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MESSAGE_LEVELUP_SUCC, self, self.refreshBySync)
end

function GalleryMessageMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:setupView(data)
	self:runStartAnim()
end

function GalleryMessageMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		title = Strings:get("Info_UI01"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function GalleryMessageMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function GalleryMessageMediator:setupView()
	self:initWidgetInfo()
	self:initData()
	self:initView()
	self:refreshBottomTabStatus()
	self:refreshView(true)
end

function GalleryMessageMediator:refreshBySync()
	self:refreshData()
	self:refreshView()
	self:refreshBottomTabStatus()
end

function GalleryMessageMediator:onClickMessage()
	local view = self:getInjector():getInstance("MessageTaskView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}, nil))
end

function GalleryMessageMediator:refreshRewardRedPoint()
	local hasRedPoint = self._taskSystem:hasMessageTaskRedPoint()

	self._rewardBtn:getChildByFullName("redMark"):setVisible(hasRedPoint)
end

function GalleryMessageMediator:initWidgetInfo()
	self._touchLayer = self:getView():getChildByFullName("touchLayer")

	self._touchLayer:setVisible(false)

	self._main = self:getView():getChildByFullName("main")
	self._tableViewPanel = self._main:getChildByFullName("tableView")
	self._cellClone = self._main:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._rewardBtn = self._main:getChildByFullName("messageBtn")

	self._rewardBtn:getChildByFullName("redMark"):setVisible(false)

	self._bottomPanel = self._main:getChildByFullName("bottomPanel")
	self._emptyTips = self._main:getChildByFullName("emptyTips")

	self._emptyTips:setVisible(false)
end

function GalleryMessageMediator:initData()
	self._showList = self._gallerySystem:getMessageList()
	self._sortList = {}
	self._activatedList = {}

	local tempList = {}

	for i = 1, #self._showList do
		local item = self._showList[i]
		local itemId = item:getItemId()
		local hasCount = self:getItemCount(itemId)

		if hasCount > 0 or item:getLevel() > 0 then
			table.insert(tempList, item)
		end
	end

	table.sort(tempList, function(a, b)
		if a:getLevel() > 0 and b:getLevel() == 0 then
			return true
		elseif a:getLevel() == 0 and b:getLevel() > 0 then
			return false
		end

		if a:getLevel() > 0 and b:getLevel() > 0 then
			local aSort = a:getSort() or 0
			local bSort = b:getSort() or 0

			return aSort < bSort
		end

		if a:getLevel() == 0 and b:getLevel() == 0 then
			local aHas = self:getItemCount(a:getItemId())
			local aNeed = a:getComposeNum() or 0
			local aCanActivate = aHas == aNeed and aNeed > 0
			local bHas = self:getItemCount(b:getItemId())
			local bNeed = b:getComposeNum() or 0
			local bCanActivate = bHas == bNeed and bNeed > 0

			if aCanActivate and not bCanActivate then
				return true
			elseif not aCanActivate and bCanActivate then
				return false
			elseif aCanActivate and bCanActivate then
				local aSort = a:getSort() or 0
				local bSort = b:getSort() or 0

				return aSort < bSort
			elseif not aCanActivate and not bCanActivate then
				return bHas < aHas
			end
		end

		return false
	end)

	self._sortList = tempList

	for i = 1, #tempList do
		local item = tempList[i]

		if item:getLevel() > 0 then
			table.insert(self._activatedList, item)
		end
	end

	if #self._sortList == 0 then
		self._emptyTips:setVisible(true)
	end
end

function GalleryMessageMediator:getItemCount(itemId)
	return self._developSystem:getBagSystem():getItemCount(itemId)
end

function GalleryMessageMediator:createTeamCell(cell, index)
	cell:removeAllChildren()

	local list = self._sortList

	for i = 1, kNums do
		local data = list[kNums * (index - 1) + i]

		if data then
			local panel = self._cellClone:clone()

			panel:setVisible(true)
			panel:setTag(i)
			panel:setAnchorPoint(cc.p(0.5, 0.5))

			local bgHero = panel:getChildByFullName("bgHero")
			local path = data:getSmallPic()

			bgHero:loadTexture(path)

			local bg = panel:getChildByFullName("bg")
			local text = panel:getChildByFullName("text")

			text:setString(data:getLevel())

			if data:getLevel() == 0 then
				text:setVisible(false)
				panel:getChildByFullName("levelImage"):setVisible(false)
			else
				text:setVisible(true)
				panel:getChildByFullName("levelImage"):setVisible(true)
			end

			local newPic = panel:getChildByFullName("new"):setVisible(false)
			local unlock = panel:getChildByFullName("unLock"):offset(15, 0)

			unlock:getChildByFullName("touchPanel"):addTouchEventListener(function(sender, eventType)
				self:onClickUnLock(sender, eventType, data:getId())
			end)

			local heroPanel = panel:getChildByFullName("heroPanel")

			heroPanel:setSwallowTouches(false)

			if data:getLevel() > 0 then
				if self._gallerySystem:getMessageSaveNewStatus(data:getId()) == 0 then
					newPic:setVisible(true)
				end

				heroPanel:addTouchEventListener(function(sender, eventType)
					self:onClickHeroIcon(sender, eventType, data)
				end)
			end

			local costNode = panel:getChildByFullName("leftPanel")

			costNode:offset(10, -3)

			local iconpanel = costNode:getChildByName("iconpanel")

			iconpanel:removeAllChildren()

			local icon = IconFactory:createIcon({
				id = data:getItemId()
			}, {
				showAmount = false
			})

			icon:setScale(0.7)
			icon:addTo(iconpanel):center(iconpanel:getContentSize())

			local addPanel = costNode:getChildByName("addImg")
			local hasNum = self._developSystem:getBagSystem():getItemCount(data:getItemId())
			local needNum = data:getComposeNum()
			local progress = costNode:getChildByFullName("progress")

			progress:setString(hasNum .. "/" .. needNum)

			local param = {
				itemId = data:getItemId(),
				hasNum = hasNum,
				needNum = needNum
			}

			if data:getLevel() == 0 and needNum <= hasNum then
				unlock:setVisible(true)

				local anim = cc.MovieClip:create("ur_anime_urequipeff")

				anim:addTo(unlock):setPosition(cc.p(30, 30))
				costNode:setVisible(false)
			elseif data:getLevel() == 0 then
				bgHero:setVisible(false)
				costNode:setVisible(true)
				unlock:setVisible(false)
				bg:loadTexture("kapai_di_2.png", ccui.TextureResType.plistType)
			else
				costNode:setVisible(false)
				unlock:setVisible(false)
			end

			addPanel:getChildByFullName("touchPanel"):addTouchEventListener(function(sender, eventType)
				self:onClickAddImg(sender, eventType, param)
			end)
			panel:addTo(cell)

			local panelWidth = panel:getContentSize().width
			local posX = panelWidth / 2 + (panelWidth - 12) * (i - 1)

			panel:setPosition(cc.p(posX + 25, 115))
		end
	end
end

function GalleryMessageMediator:onClickAddImg(sender, eventType, param)
	if eventType == ccui.TouchEventType.ended then
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))
	end
end

function GalleryMessageMediator:onClickUnLock(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		local parent = sender:getParent()
		local scale1 = cc.ScaleTo:create(0.1, 0.9)

		parent:runAction(scale1)
	elseif eventType == ccui.TouchEventType.ended then
		local parent = sender:getParent()

		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		local scale3 = cc.ScaleTo:create(0.12, 1)
		local callfunc = cc.CallFunc:create(function()
			self._gallerySystem:requestMessageCompose(data, function()
				local view = self:getInjector():getInstance("GalleryMessageUnlockView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					unlockId = data
				}))
			end)
		end)
		local seq = cc.Sequence:create(scale3, callfunc)

		parent:runAction(seq)
	elseif eventType == ccui.TouchEventType.canceled then
		local parent = sender:getParent()

		parent:stopAllActions()
		parent:setScale(1)
	end
end

function GalleryMessageMediator:refreshBottomTabStatus()
	local colectText = self._bottomPanel:getChildByFullName("colectText")
	local currentScoreText = self._bottomPanel:getChildByFullName("currentScoreText")
	local targetScoreText = self._bottomPanel:getChildByFullName("targetScoreText")
	local loadingNode = self._bottomPanel:getChildByFullName("loadingNode")
	local loadingBar = loadingNode:getChildByName("loading")
	local allCount = self._gallerySystem:getMessageCount()
	local currentMessage = 0

	for i = 1, #self._showList do
		local data = self._showList[i]

		if data:getLevel() > 0 then
			currentMessage = currentMessage + 1
		end
	end

	if allCount ~= 0 then
		loadingNode:setVisible(true)
		colectText:setVisible(true)
		currentScoreText:setVisible(true)
		targetScoreText:setVisible(true)

		local rate = currentMessage / allCount

		currentScoreText:setString("" .. currentMessage)
		targetScoreText:setString("/" .. allCount)
		loadingBar:setPercent(rate * 100)
	else
		loadingNode:setVisible(false)
		colectText:setVisible(false)
		currentScoreText:setVisible(false)
		targetScoreText:setVisible(false)
	end
end

function GalleryMessageMediator:initView()
	local width, height = self._tableViewPanel:getContentSize().width, self._cellClone:getContentSize().height

	local function scrollViewDidScroll(view)
		if DisposableObject:isDisposed(self) then
			return
		end

		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return width + 12, height
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._sortList / kNums)
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createTeamCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._tableViewPanel:getContentSize())

	self._heroView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._tableViewPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)

	self._tipsPanel = self._main:getChildByName("tipsPanel")

	self._tipsPanel:setVisible(false)

	self._tipsTouchPanel = self:getView():getChildByName("PanelTouch_tip")

	self._tipsTouchPanel:setVisible(false)

	local tips = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Info_RuleText", "content")

	tips = tips[1].Desc

	local space = 18

	if getCurrentLanguage() ~= GameLanguageType.CN then
		space = 13

		self._tipsPanel:setContentSize(cc.size(400, 230))
	end

	local panelSize = self._tipsPanel:getContentSize()

	for i = 1, #tips do
		local str = Strings:get(tips[i])
		local text = ccui.Text:create(str, TTF_FONT_FZYH_M, 18)

		text:setLineSpacing(space)
		text:getVirtualRenderer():setMaxLineWidth(380)
		text:addTo(self._tipsPanel):setTag(i)
		text:setAnchorPoint(cc.p(0, 1))

		local prewText = self._tipsPanel:getChildByTag(i - 1)

		if prewText then
			local topPosY = prewText:getPositionY() - prewText:getContentSize().height

			text:setPosition(cc.p(10, topPosY - space))
		else
			text:setPosition(cc.p(10, panelSize.height - 15))
		end
	end
end

function GalleryMessageMediator:refreshData()
	self:initData()
end

function GalleryMessageMediator:refreshView(hideReload)
	self._heroView:stopScroll()
	self._heroView:reloadData()
	self:refreshRewardRedPoint()
end

function GalleryMessageMediator:refreshTabStatus()
	for i = 1, #self._tabCache do
		self._tabCache[i][1]:setVisible(self._tabType ~= i)
		self._tabCache[i][2]:setVisible(self._tabType == i)
	end
end

function GalleryMessageMediator:onClickHeroIcon(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		local parent = sender:getParent()

		self._isReturn = true

		local scale1 = cc.ScaleTo:create(0.1, 0.9)

		parent:runAction(scale1)
	elseif eventType == ccui.TouchEventType.ended then
		local parent = sender:getParent()

		if self._isReturn then
			AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)
			self._touchLayer:setVisible(true)

			local scale3 = cc.ScaleTo:create(0.12, 1)
			local callfunc = cc.CallFunc:create(function()
				local view = self:getInjector():getInstance("GalleryMessageInfoView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
					id = data:getId(),
					ids = self._activatedList
				}))
				self._gallerySystem:setMessageSaveNewStatus(data:getId(), true)
				self:refreshBySync()

				self._isReturn = true

				self._touchLayer:setVisible(false)
			end)
			local seq = cc.Sequence:create(scale3, callfunc)

			parent:runAction(seq)
		else
			parent:stopAllActions()
			parent:setScale(1)
		end
	elseif eventType == ccui.TouchEventType.canceled then
		local parent = sender:getParent()

		parent:stopAllActions()
		parent:setScale(1)
	end
end

function GalleryMessageMediator:onClickShowTips(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._tipsPanel:setVisible(true)
		self._tipsTouchPanel:setVisible(true)
	end
end

function GalleryMessageMediator:onClickHideTips(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._tipsPanel:setVisible(false)
		self._tipsTouchPanel:setVisible(false)
	end
end

function GalleryMessageMediator:runStartAnim()
	self._main:stopAllActions()
	self._tableViewPanel:stopAllActions()
	self._main:setPosition(cc.p(1380, -404))
	self._main:setRotation(-15)

	local rotate = cc.RotateTo:create(0.3, 0)
	local moveto1 = cc.MoveTo:create(0.2, cc.p(500, 320))
	local moveto2 = cc.MoveTo:create(0.1, cc.p(568, 320))
	local seq = cc.Sequence:create(moveto1, moveto2)
	local spawn = cc.Spawn:create(rotate, seq)

	self._main:runAction(spawn)
	self._tableViewPanel:setOpacity(0)
	self._tableViewPanel:setPosition(cc.p(140, 80))

	local delay = cc.DelayTime:create(0.2)
	local moveto = cc.MoveTo:create(0.3, cc.p(140, 49))
	local fadeIn = cc.FadeIn:create(0.2)
	local callback = cc.CallFunc:create(function()
		self._heroView:reloadData()
	end)

	spawn = cc.Spawn:create(moveto, fadeIn, callback)

	local endCallFunc = cc.CallFunc:create(function()
		return
	end)

	seq = cc.Sequence:create(delay, spawn, endCallFunc)

	self._tableViewPanel:runAction(seq)
end
