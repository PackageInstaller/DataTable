-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/view/ArenaNewRewardMediator.lua

ArenaNewRewardMediator = class("ArenaNewRewardMediator", DmPopupViewMediator, _M)

ArenaNewRewardMediator:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")

local rankTabData = {
	{
		Desc2 = "ClassArena_UI62",
		Desc1 = "ClassArena_UI23"
	},
	{
		Desc2 = "ClassArena_UI63",
		Desc1 = "ClassArena_UI24"
	}
}
local StageArenaRewardType = {
	SeasonReward = 1,
	RankUpReward = 2
}
local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	},
	["main.onekeyNode.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickOnekey"
	}
}

function ArenaNewRewardMediator:initialize()
	super.initialize(self)
end

function ArenaNewRewardMediator:dispose()
	super.dispose(self)
end

function ArenaNewRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_NEW_ARENA_REWAERD_INFO, self, self.refreshGradeReward)

	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		title = Strings:get("ClassArena_UI22"),
		title1 = Strings:get("ClassArena_UI64"),
		titleDimensions = {
			180,
			85
		}
	})
end

function ArenaNewRewardMediator:enterWithData(data)
	self._curTabType = data.tab or StageArenaRewardType.SeasonReward

	self:initWidgetInfo()
	self:createTabController()
	self:refreshGradeReward()
end

function ArenaNewRewardMediator:resumeWithData()
	self:onClickTab("", self._curTabType)
end

function ArenaNewRewardMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabpanel = self._mainPanel:getChildByFullName("tabpanel")
	self._viewPanel = self._mainPanel:getChildByName("viewPanel")
	self._tableViewLayout = self._viewPanel:getChildByFullName("tableView")
	self._rewardCellPanel = self._viewPanel:getChildByName("rewardCellPanel")

	self._rewardCellPanel:setVisible(false)

	self._rewardCellPanel2 = self._viewPanel:getChildByName("winCellPanel")

	self._rewardCellPanel2:setVisible(false)

	self._rewardSelfInfo = self._viewPanel:getChildByFullName("rewardMyselfInfo")
	self._onkeyBtn = self._mainPanel:getChildByFullName("onekeyNode")
end

function ArenaNewRewardMediator:refreshGradeReward()
	if self._tabBtnWidget then
		self._tabBtnWidget:refreshAllRedPoint()
	end

	self:setOneKeyVisible()
end

function ArenaNewRewardMediator:setOneKeyVisible()
	local hasRedPoint = self._arenaNewSystem:checkNewArenaRewardRedpoint()

	self._onkeyBtn:setGray(not hasRedPoint)

	local redpoint = self._onkeyBtn:getChildByFullName("redPoint")

	redpoint:setVisible(false)
	self._onkeyBtn:setVisible(self._curTabType == StageArenaRewardType.RankUpReward)
end

function ArenaNewRewardMediator:createTabController()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #rankTabData do
		local tabText = Strings:get(rankTabData[i].Desc1)
		local tabTextTranslate = Strings:get(rankTabData[i].Desc2)

		data[#data + 1] = {
			fontSize = 22,
			noWrap = false,
			tabText = tabText,
			tabTextTranslate = tabTextTranslate,
			redPointFunc = function()
				if i == 1 then
					return false
				end

				if i == 2 then
					return self._arenaNewSystem:checkNewArenaRewardRedpoint()
				end

				return false
			end
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 490)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, -5)
	view:setLocalZOrder(1100)
	self._tabBtnWidget:scrollTabPanel(self._curTabType)
end

function ArenaNewRewardMediator:onClickTab(name, tag)
	self._curTabType = tag

	self:refreshRewardView()
	self:refreshRewardSelfView()
	self:setOneKeyVisible()

	if self._curTabType == StageArenaRewardType.RankUpReward then
		local selectTag = self:getSelectTag()

		if selectTag > 3 then
			local space = self._rewardCellPanel2:getContentSize().height
			local minY = self._tableView:minContainerOffset().y
			local offsetY = math.min(minY + space * (selectTag - 3), 0)

			self._tableView:setContentOffset(cc.p(0, offsetY))
		end
	end
end

function ArenaNewRewardMediator:getSelectTag()
	local tag = 0
	local rewardInfo = self._arenaNewSystem:getArenaRewardInfo()

	for i, v in ipairs(self._rewards) do
		if rewardInfo[v.Id] == RTPKGradeRewardState.kCanGet then
			tag = i

			break
		end
	end

	return tag
end

function ArenaNewRewardMediator:refreshRewardSelfView()
	local textName3 = self._rewardSelfInfo:getChildByFullName("text_1")

	if self._curTabType == StageArenaRewardType.SeasonReward then
		local var_14_0 = {}

		var_14_0.Num = self._arenaNewSystem:getArenaNew():getCurRankStr()

		local var_14_1 = Strings:get("ClassArena_UI65", var_14_0)

		if not var_14_1 then
			var_14_1 = Strings:get("ClassArena_UI25")

			local str = var_14_1

			textName3:setString(str)
		end
	end
end

function ArenaNewRewardMediator:refreshRewardView()
	self._tableViewLayout:removeAllChildren()

	self._rewards = self._arenaNewSystem:getAllRewardConfig()

	local viewSize = self._tableViewLayout:getContentSize()
	local tableView = cc.TableView:create(viewSize)
	local kCellHeight = self._rewardCellPanel:getContentSize().height

	local function numberOfCells(view)
		return #self._rewards
	end

	local function cellSize(table, idx)
		return viewSize.width, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setContentSize(cc.size(viewSize.width, kCellHeight))
		end

		local index = idx + 1

		self:addRankAwardPanel(cell, index)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(self._tableViewLayout)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()

	self._tableView = tableView
end

function ArenaNewRewardMediator:addRankAwardPanel(cell, idx)
	cell:removeAllChildren()

	local rewardData = self._rewards[idx]

	if self._curTabType == StageArenaRewardType.SeasonReward then
		if not rewardData.SeasonReward then
			local reward = rewardData.FirstReward
			local rank = table.copy(rewardData.RankRange, {})

			if self._curTabType == StageArenaRewardType.SeasonReward then
				local var_19_1 = self._rewardCellPanel:clone()

				if not var_19_1 then
					var_19_1 = self._rewardCellPanel2:clone()

					local panel = var_19_1

					panel:setVisible(true)
					panel:addTo(cell):posite(0, 0)

					local bg1 = panel:getChildByName("Image_bg1")
					local bg2 = panel:getChildByName("Image_bg2")
					local rankNum = panel:getChildByName("rankNum")
					local rankIcon = panel:getChildByName("rankIcon")
					local iconPanel = panel:getChildByName("icon")

					rankIcon:ignoreContentAdaptWithSize(true)
					bg1:setVisible(idx % 2 == 0)
					bg2:setVisible(idx % 2 ~= 0)

					if self._curTabType == StageArenaRewardType.RankUpReward and rewardData.FirstRewardType == 2 then
						rank[1] = rank[2]
					end

					rankIcon:setVisible(false)
					rankNum:setVisible(false)

					local randDes = ""

					if idx <= 3 and rank[1] == rank[2] then
						rankIcon:loadTexture(RankTopImage[idx], 1)
						rankIcon:setVisible(true)
					elseif rank[1] == rank[2] then
						rankNum:setVisible(true)

						randDes = Strings:get("StageArena_PopUpUI17", {
							num = rank[1]
						})

						rankNum:setString(randDes)
					else
						rankNum:setVisible(true)

						randDes = Strings:get("StageArena_PopUpUI17", {
							num = rank[1] .. "-" .. rank[2]
						})

						rankNum:setString(randDes)
					end

					local rewards = ConfigReader:getDataByNameIdAndKey("Reward", reward, "Content") or {}
					local length = #rewards
					local x = self._curTabType == StageArenaRewardType.SeasonReward and 340 or 440

					iconPanel:setPositionX(x)

					for i = 1, length do
						local icon = IconFactory:createRewardIcon(rewards[i], {
							showAmount = true,
							isWidget = true
						})

						icon:addTo(iconPanel)
						icon:setScale(0.65)
						icon:setPosition(cc.p(iconPanel:getContentSize().width / 2 + (i - 1) * 105, iconPanel:getContentSize().height / 2 - 7))
						IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
							needDelay = true
						})
					end

					if self._curTabType == StageArenaRewardType.RankUpReward then
						local btnGet = panel:getChildByName("rewardFinishBtn")
						local notGetText = panel:getChildByName("ranktext1")
						local recivedText = panel:getChildByName("Image_87")
						local rewardInfo = self._arenaNewSystem:getArenaRewardInfo()
						local state = rewardInfo[rewardData.Id]

						btnGet:setVisible(state == RTPKGradeRewardState.kCanGet)
						notGetText:setVisible(state == RTPKGradeRewardState.kCanNotGet)
						recivedText:setVisible(state == RTPKGradeRewardState.kHadGet)

						if state == RTPKGradeRewardState.kCanGet then
							btnGet:addTouchEventListener(function(sender, eventType)
								if eventType == ccui.TouchEventType.ended then
									local data = {
										oneKey = 0,
										rewardId = rewardData.Id
									}

									self._arenaNewSystem:requestGetChessArenaReward(data, function()
										if checkDependInstance(self) then
											self._tableView:updateCellAtIndex(idx - 1)
										end
									end, true)
								end
							end)
						end
					end
				end
			end
		end
	end
end

function ArenaNewRewardMediator:onClickOnekey()
	local hasRedPoint = self._arenaNewSystem:checkNewArenaRewardRedpoint()

	if not hasRedPoint then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI24")
		}))

		return
	end

	self._arenaNewSystem:requestGetChessArenaReward({
		oneKey = 1,
		rewardId = ""
	}, function()
		if checkDependInstance(self) then
			local offset = self._tableView:getContentOffset()

			self._tableView:reloadData()
			self._tableView:setContentOffset(offset)
		end
	end, true)
end

function ArenaNewRewardMediator:onClickClose()
	self:close()
end
