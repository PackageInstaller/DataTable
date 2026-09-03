-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceRewardMediator.lua

WorldPeaceRewardMediator = class("WorldPeaceRewardMediator", DmPopupViewMediator, _M)

WorldPeaceRewardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WorldPeaceRewardMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

function WorldPeaceRewardMediator:initialize()
	super.initialize(self)
end

function WorldPeaceRewardMediator:dispose()
	super.dispose(self)
end

function WorldPeaceRewardMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")

	bindWidget(self, "main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:find("ClubMapBoss_Reward_Rank")
	})

	self._cellClone = self._main:getChildByName("cellclone")
	self._rewardBtn = self:bindWidget("main.btn_get", OneLevelMainButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickGetRankReward, self)
		}
	})
end

function WorldPeaceRewardMediator:enterWithData(data)
	self._worldPeace = self._worldPeaceSystem:getWorldPeace()

	local player = self._developSystem:getPlayer()
	local data = self._worldPeace:getMemberDataByRid(player:getRid())

	if data then
		self._myRank = data.rank or -1
	end

	self._rewardList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapInnerReward", "content")

	self:setupView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORLDPEACE_GET_REWARD_SUCC, self, self.onGetRewardCallback)
end

function WorldPeaceRewardMediator:setupView()
	self:createTableView()
	self:refreshMySelfView()
	self:refreshButtonStatus()
	self:refreshRedPoint()
end

function WorldPeaceRewardMediator:refreshRedPoint()
	local node = RedPoint:createDefaultNode()
	local redPoint = RedPoint:new(node, self._rewardBtn:getButton(), function()
		return self._worldPeaceSystem:hasRewardGetByType(WPRewardType.kMemberHurt)
	end)

	redPoint:posite(195, 55)
end

function WorldPeaceRewardMediator:createTableView()
	local size = self._cellClone:getContentSize()
	local tableView = cc.TableView:create(cc.size(716, 260))

	local function scrollViewDidScroll(table)
		return
	end

	local function numberOfCells(view)
		return #self._rewardList
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return size.width, size.height
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local cloneCell = self._cellClone:clone()

			cloneCell:setVisible(true)
			cloneCell:addTo(cell):setTag(111):posite(0, 0)
		end

		self:updateCell(cell:getChildByTag(111), idx + 1)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(self._main):posite(218, 190)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)

	self._tableView = tableView

	self._tableView:reloadData()
end

function WorldPeaceRewardMediator:updateCell(cell, index)
	local rewardId = self._rewardList[index]
	local reward = ConfigReader:getDataByNameIdAndKey("RankReward", rewardId, "Reward") or ""
	local rank = ConfigReader:getDataByNameIdAndKey("RankReward", rewardId, "Rank") or {}
	local bg = index % 2 == 0 and "bd_bg_xxt_2.png" or "bd_bg_xxt_1.png"

	cell:getChildByFullName("Image_bg1"):loadTexture(bg, 1)

	local rankText = cell:getChildByName("Text_rank")

	if rank[1] == rank[2] then
		rankText:setString(rank[1])
	else
		rankText:setString(rank[1] .. "-" .. rank[2])
	end

	local rewardNode = cell:getChildByName("reward")
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", reward, "Content")

	rewardNode:removeAllChildren()

	for i = 1, #rewards do
		local icon = IconFactory:createRewardIcon(rewards[i], {
			isWidget = true
		})

		icon:addTo(rewardNode):posite(28 + (i - 1) * 80 - (#rewards - 1) * 40, 30):setScaleNotCascade(0.5)
		icon:setScale(0.45)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
	end

	cell:getChildByName("Image_self"):setVisible(false)
end

function WorldPeaceRewardMediator:refreshMySelfView()
	local cell = self._cellClone
	local myRank = self._myRank
	local rankText = cell:getChildByName("Text_rank")

	rankText:setString(myRank)

	if myRank <= 0 then
		rankText:setString(Strings:get("StagePractice_Text19"))
	end

	local reward = self:getRewardByRank(myRank)
	local rewardNode = cell:getChildByName("reward")

	rewardNode:removeAllChildren()
	rewardNode:stopAllActions()

	if reward then
		local rewards = ConfigReader:getDataByNameIdAndKey("Reward", reward, "Content")

		for i = 1, #rewards do
			rewardNode:runAction(DelayAction:create(function()
				local icon = IconFactory:createRewardIcon(rewards[i], {
					showAmount = true,
					isWidget = true
				})

				icon:addTo(rewardNode):posite(28 + (i - 1) * 80 - (#rewards - 1) * 40, 30):setScaleNotCascade(0.5)
				icon:setScale(0.45)
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
					needDelay = true
				})
			end, 0.1 * (i - 1)))
		end
	end
end

function WorldPeaceRewardMediator:getRewardByRank(myRank)
	for i, v in pairs(self._rewardList) do
		local reward = ConfigReader:getDataByNameIdAndKey("RankReward", v, "Reward") or ""
		local rank = ConfigReader:getDataByNameIdAndKey("RankReward", v, "Rank") or {}

		if tonumber(rank[1]) == tonumber(rank[2]) then
			if myRank == tonumber(rank[1]) then
				return reward
			end
		elseif myRank >= tonumber(rank[1]) and myRank <= tonumber(rank[2]) then
			return reward
		end
	end
end

function WorldPeaceRewardMediator:refreshButtonStatus()
	local status = self._worldPeace:getRewardStatusByType(WPRewardType.kMemberHurt)

	if status == 2 then
		self._rewardBtn:setGray(true)
		self._rewardBtn:setButtonName(Strings:get("ClubMapBoss_Result_btn3"))
	elseif status == 0 then
		self._rewardBtn:setVisible(false)
	else
		self._rewardBtn:setGray(false)
		self._rewardBtn:setButtonName(Strings:get("ClubMapBoss_Result_btn2"))
	end
end

function WorldPeaceRewardMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function WorldPeaceRewardMediator:onClickGetRankReward(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local status = self._worldPeace:getRewardStatusByType(WPRewardType.kMemberHurt)

		if status == 0 then
			return
		end

		if status == 2 then
			return
		end

		self._worldPeaceSystem:requestReward(WPRewardType.kMemberHurt)
	end
end

function WorldPeaceRewardMediator:onGetRewardCallback(event)
	local response = event:getData()
	local rewards = response.data.rewards
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 200
	}, {
		rewards = rewards
	}))
	self:refreshButtonStatus()
end
