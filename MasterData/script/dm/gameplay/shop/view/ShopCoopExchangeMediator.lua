-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopCoopExchangeMediator.lua

require("dm.gameplay.shop.view.component.ShopItem")

ShopCoopExchangeMediator = class("ShopCoopExchangeMediator", DmAreaViewMediator, _M)

ShopCoopExchangeMediator:has("_activitySystem", {
	is = "rw"
}):injectWith("ActivitySystem")
ShopCoopExchangeMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function ShopCoopExchangeMediator:initialize()
	super.initialize(self)
end

function ShopCoopExchangeMediator:dispose()
	super.dispose(self)
end

function ShopCoopExchangeMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()
end

function ShopCoopExchangeMediator:mapEventListeners()
	return
end

function ShopCoopExchangeMediator:onRemove()
	super.onRemove(self)
end

function ShopCoopExchangeMediator:enterWithData(data)
	self:initView()
	self:initData(data)
	self:setupView()
	self:setupTopView()
	self:playBackgroundMusic()
end

function ShopCoopExchangeMediator:playBackgroundMusic()
	local bgm = self._activity:getBgm1()

	if bgm then
		AudioEngine:getInstance():playBackgroundMusic(bgm)
	end
end

function ShopCoopExchangeMediator:initView()
	self._cloneCell = self:getView():getChildByFullName("cellClone")
	self._listView = self:getView():getChildByFullName("main.scrollView")

	self._listView:setScrollBarEnabled(false)

	self._currencyBars = {}
	self._currencyBars[1] = self:getView():getChildByFullName("main.currency1")
	self._currencyBars[2] = self:getView():getChildByFullName("main.currency2")
	self._currencyBars[3] = self:getView():getChildByFullName("main.currency3")
	self._currencyBars[4] = self:getView():getChildByFullName("main.currency4")
end

function ShopCoopExchangeMediator:initData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._activityConfig = self._activity:getActivityConfig()
	self._taskList = self:getCostSortExchangeList()
end

function ShopCoopExchangeMediator:getCostSortExchangeList()
	local list = self._activity:getCostSortExchangeList()

	table.sort(list, function(a, b)
		if a.amount == 0 then
			return false
		end

		if b.amount == 0 then
			return true
		end

		local aOwn = self:isHasOwnItem(a)
		local bOwn = self:isHasOwnItem(b)

		if aOwn == 1 then
			return false
		end

		if bOwn == 1 then
			return true
		end

		local aCost = a.config.Cost[1].amount
		local bCost = b.config.Cost[1].amount

		if aCost == bCost then
			return a.index < b.index
		else
			return bCost < aCost
		end
	end)

	return list
end

function ShopCoopExchangeMediator:isHasOwnItem(data)
	local own = 0
	local config = data.config
	local targetList = ConfigReader:getDataByNameIdAndKey("Reward", config.Target, "Content")

	if targetList and targetList[1] and targetList[1].type == RewardType.kBackground then
		local player = self._developSystem:getPlayer()
		local background = player:getBackground()

		if background[targetList[1].code] then
			own = 1
		end
	end

	return own
end

function ShopCoopExchangeMediator:setupTopView()
	local topInfoNode = self:getView():getChildByFullName("main.topInfo")

	topInfoNode:setLocalZOrder(999)

	local config = {
		style = 1,
		currencyInfo = {},
		title = Strings:get(self._activity:getTitle()),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
	self:refreshTopCost()
end

function ShopCoopExchangeMediator:refreshTopCost()
	local config = self._activityConfig.ResourceBanner

	for i = 1, 4 do
		if config[i] then
			local cost = {}

			cost.code = config[i]
			cost.type = 2
			cost.amount = 1

			self._currencyBars[i]:setVisible(true)

			local iconNode = self._currencyBars[i]:getChildByFullName("icon_node")

			iconNode:removeAllChildren()

			local iconPic = IconFactory:createRewardIcon(cost, {
				showAmount = false,
				notShowQulity = true,
				isWidget = false
			})

			iconPic:setScale(0.3)

			if iconPic then
				iconPic:addTo(iconNode)
			end

			local addBtn = self._currencyBars[i]:getChildByFullName("Image_1")

			addBtn:setVisible(false)

			local textBg = self._currencyBars[i]:getChildByFullName("text_bg")
			local textNode = self._currencyBars[i]:getChildByFullName("text_bg.text")
			local strNode = self._currencyBars[i]:getChildByFullName("text_bg.str")
			local count = self._developSystem:getBagSystem():getItemCount(config[i])

			textNode:setVisible(false)
			strNode:setString(tostring(count))
			textNode:setPositionX(15)
		else
			self._currencyBars[i]:setVisible(false)
		end
	end
end

function ShopCoopExchangeMediator:setupView()
	local timeLab = self:getView():getChildByFullName("main.timeInfo.timeDi.time")
	local startTime = self._activity:getStartTime() / 1000
	local endTime = self._activity:getEndTime() / 1000
	local startDate = TimeUtil:localDate("%Y.%m.%d", startTime)
	local endDate = TimeUtil:localDate("%Y.%m.%d", endTime)

	timeLab:setString(startDate .. "-" .. endDate)

	local infoLab = self:getView():getChildByFullName("main.timeInfo.info")

	infoLab:setString(Strings:get(self._activity:getDesc()))

	local modelId = self._activityConfig.ModelId
	local modelOffset = self._activityConfig.ModelIdOffset
	local rolePanel = self:getView():getChildByFullName("main.talkPanel.rolePanel")

	rolePanel:removeAllChildren()

	local standRole = self:getView():getChildByFullName("main.talkPanel.Image_19")
	local talkNode = self:getView():getChildByFullName("main.talkPanel.Image_20")

	if modelId then
		standRole:setVisible(false)
		rolePanel:setVisible(true)

		local heroSprite = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = modelId
		})

		heroSprite:addTo(rolePanel)
		heroSprite:setPosition(cc.p(modelOffset.pos[1], modelOffset.pos[2]))
		heroSprite:setScale(modelOffset.scale)
		heroSprite:setTouchEnabled(false)
	else
		standRole:setVisible(true)
		rolePanel:setVisible(false)
	end

	local function nodeSparkle(node, delay1, delay2)
		node:stopAllActions()
		node:setOpacity(255)

		local showTalkIdx
		local text = node:getChildByFullName("Text_talk")

		local function talk()
			for i = 1, 10 do
				if showTalkIdx then
					local idx = math.random(#self._activityConfig.BubleDesc)

					if showTalkIdx ~= idx then
						showTalkIdx = idx

						break
					end
				else
					showTalkIdx = math.random(#self._activityConfig.BubleDesc)

					break
				end
			end

			text:setString(Strings:get(self._activityConfig.BubleDesc[showTalkIdx]))
		end

		talk()

		local talkAinm = cc.CallFunc:create(talk)
		local delay1 = cc.DelayTime:create(delay1)
		local fadeOut = cc.FadeOut:create(0.2)
		local delay2 = cc.DelayTime:create(delay2)
		local fadeIn = cc.FadeIn:create(0.2)
		local action = cc.RepeatForever:create(cc.Sequence:create(delay1, fadeOut, talkAinm, delay2, fadeIn))

		node:runAction(action)
	end

	nodeSparkle(talkNode, 3, 5)
	self:createTableView()
end

function ShopCoopExchangeMediator:createTableView()
	self._listView:removeAllChildren()

	local size = self._cloneCell:getContentSize()
	local listSize = self._listView:getContentSize()
	local tableView = cc.TableView:create(listSize)
	local num1 = math.floor(listSize.width / size.width)
	local num2 = math.ceil(#self._taskList / 2)
	local kNums = math.max(num1, num2)

	local function numberOfCells(view)
		return math.ceil(#self._taskList / 4)
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return listSize.width, size.height
	end

	local function cellAtIndex(table, idx)
		local bar = table:dequeueCell()

		if bar == nil then
			bar = cc.TableViewCell:new()
		else
			bar:removeAllChildren()
		end

		for i = 1, 4 do
			local itemIdx = idx * 4 + i

			if itemIdx <= #self._taskList then
				local itemCell = self._cloneCell:clone()

				itemCell:setSwallowTouches(false)
				itemCell:setPosition(cc.p(8 + (size.width + 30) * (i - 1), 0))
				bar:addChild(itemCell, 0, i)
				self:updataCell(itemCell, itemIdx)
			end
		end

		return bar
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:addTo(self._listView)
	tableView:reloadData()
	tableView:setBounceable(false)

	self._tableView = tableView
end

function ShopCoopExchangeMediator:updataCell(cell, index)
	local mainView = cell:getChildByName("cell")
	local maskView = cell:getChildByName("mask")
	local data = self._taskList[index]
	local config = data.config
	local haveAmount = self._activity:getExchangeAmount(data.id)
	local enoughAmount = self._activity:getExchangeCountById(data.id)
	local rewardPanel = mainView:getChildByName("money_layout")
	local costItem = config.Cost[1]

	if costItem then
		local costNum = rewardPanel:getChildByName("money")

		costNum:setString(tostring(costItem.amount))

		local costIcon = rewardPanel:getChildByName("money_icon")
		local icon = IconFactory:createRewardIcon(costItem, {
			showAmount = false,
			notShowQulity = true,
			isWidget = true
		})

		icon:setSwallowTouches(true)
		icon:addTo(costIcon, -1):center(costIcon:getContentSize())
		icon:setScale(0.4)
	end

	local targetPanel = mainView:getChildByName("icon_layout")

	targetPanel:removeAllChildren()

	local targetList = ConfigReader:getDataByNameIdAndKey("Reward", config.Target, "Content")
	local icon = IconFactory:createRewardIcon(targetList[1], {
		showAmount = true,
		isWidget = true
	})

	icon:addTo(targetPanel, -1):posite(45, 45):setScaleNotCascade(90 / icon:getContentSize().width)
	IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), targetList[1], {
		touchDisappear = true,
		swallowTouches = false
	})
	icon:setTouchEnabled(haveAmount > 0)

	local num = mainView:getChildByName("goods_num")

	num:setVisible(false)

	local targetName = mainView:getChildByName("goods_name")

	targetName:setString(RewardSystem:getName(targetList[1]))

	if targetList[1].type == RewardType.kEquip or targetList[1].type == RewardType.kEquipExplore then
		local config = ConfigReader:getRecordById("HeroEquipBase", targetList[1].code)

		GameStyle:setRarityText(targetName, config.Rareity)
	else
		local quality = RewardSystem:getQuality(targetList[1])

		GameStyle:setQualityText(targetName, quality)
	end

	local times = config.Times

	maskView:setVisible(haveAmount <= 0)

	local leaveText = mainView:getChildByFullName("info_panel.limit")

	leaveText:setString(Strings:get("Activity_NewExchange_LeaveTimes", {
		curTime = haveAmount,
		totalTime = times
	}))

	local own = self:isHasOwnItem(data)

	maskView:getChildByName("Image_104"):loadTexture("sd_lb_sq.png", 1)

	if own == 1 then
		maskView:setVisible(true)

		if haveAmount > 0 then
			maskView:getChildByName("Image_104"):loadTexture("shop_img_yyy.png", 1)
		end
	end

	local touchPanel = mainView:getChildByName("touchPanel")

	touchPanel:setLocalZOrder(10)
	touchPanel:setSwallowTouches(false)

	local touchMoveTimes = 0

	touchPanel:setTouchEnabled(haveAmount > 0 and own == 0)
	touchPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			touchMoveTimes = 0
		elseif eventType == ccui.TouchEventType.moved then
			touchMoveTimes = touchMoveTimes + 1
		elseif eventType == ccui.TouchEventType.ended and touchMoveTimes <= 10 then
			if icon.isReturn then
				return
			end

			local view = self:getInjector():getInstance("ShopCoopExchangeBuyView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				activity = self._activity,
				itemData = data,
				callback = function(activityId, id, count)
					if self._curCount == 0 then
						AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
						self:getEventDispatcher():dispatchEvent(ShowTipEvent({
							tip = Strings:get("VT_Exchange_Lack_Tips")
						}))

						return
					end

					local data = {
						doActivityType = 101,
						exchangeId = id,
						exchangeAmount = count
					}

					AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

					local outSelf = self

					self._activitySystem:requestDoActivity2(activityId, data, function(response)
						if response.resCode == GS_SUCCESS then
							local rewards = response.data.reward

							if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
								return
							end

							if rewards then
								local view = self:getInjector():getInstance("getRewardView")

								self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
									maskOpacity = 0
								}, {
									needClick = true,
									rewards = rewards
								}))
							end

							outSelf._taskList = self._activity:getCostSortExchangeList()

							outSelf._tableView:reloadData()
							outSelf:refreshTopCost()
						else
							outSelf:dismiss()
						end
					end)
				end
			}))
		end
	end)
end

function ShopCoopExchangeMediator:onClickBack()
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end
