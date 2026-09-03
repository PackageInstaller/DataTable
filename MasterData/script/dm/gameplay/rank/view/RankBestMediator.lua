-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rank/view/RankBestMediator.lua

RankBestMediator = class("RankBestMediator", PopupViewMediator)

RankBestMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
RankBestMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
RankBestMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
RankBestMediator:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")

local rankPowerType = {
	[RankType.kClub] = Strings:get("Strenghten_Text9"),
	[RankType.kCombat] = Strings:get("HEROS_UI49") .. ":",
	[RankType.kBlockStar] = Strings:get("RANK_UI6") .. ":",
	[RankType.KPetWorldScore] = Strings:get("Petrace_Daily_Point") .. ":",
	[RankType.kCrusade] = Strings:get("Crusade_UI14") .. ":",
	[RankType.kMap] = Strings:get("EXPLORE_UI46") .. ":",
	[RankType.kArena] = Strings:get("RANK_WeeklyHonor") .. ":",
	[RankType.kClubBoss] = Strings:get("Rank_ClubBoss_01") .. ":",
	[RankType.kCollection] = Strings:get("RANK_Price_UI1") .. ":"
}
local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickBack"
	}
}

function RankBestMediator:initialize()
	super.initialize(self)
end

function RankBestMediator:dispose()
	self._rankSystem:cleanUpRankList()
	super.dispose(self)
end

function RankBestMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dailyReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RANK_GOT_REWARD_SUCC, self, self.setRewardView)
	self:getView():getChildByFullName("main.titleNode.bg_hw")

	local titleText1 = self:getView():getChildByFullName("main.titleNode.Text_1")
	local titleText2 = self:getView():getChildByFullName("main.titleNode.Text_2")

	titleText1:setString(Strings:get("RANK_TITLENO1"))
	titleText2:setString(Strings:get("UITitle_EN_Lianjiezherikan"))
end

function RankBestMediator:enterWithData(data)
	self.allRankData = self._rankSystem:getAllRankData()
	self._curClubId = data.index
	self._nextClubId = data.nextIndex

	self:refreshData()
	self:initWidgetInfo()
	self:refreshView()
end

function RankBestMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._roleNode = self._mainPanel:getChildByFullName("viewPanel.roleNode")
	self._clonePanel = self:getView():getChildByFullName("clonePanel")

	self._clonePanel:setVisible(false)

	local remoteTimestamp = self._gameServerAgent:remoteTimestamp()
	local date = TimeUtil:localDate("*t", remoteTimestamp)

	if date.month >= 10 then
		if not date.month then
			local month = "0" .. date.month

			if date.day >= 10 then
				if not date.day then
					local day = "0" .. date.day
					local week = date.wday == 1 and 7 or date.wday - 1
					local dateText = self._mainPanel:getChildByFullName("dateMonth")

					dateText:setString(month .. "/" .. day)

					local dateyear = self._mainPanel:getChildByFullName("dateyear")

					dateyear:setString(Strings:get("RANK_DATAUI", {
						year = date.year,
						week = GameStyle:intNumToWeekString(week)
					}))

					self._viewPanel = self._mainPanel:getChildByFullName("viewPanel")
					self._tableView = self._viewPanel:getChildByFullName("tableView")

					self:setBestTableView()

					local titleText1 = self._mainPanel:getChildByFullName("titleNode.Text_1")
					local titleText1_frame_w = titleText1:getContentSize().width
					local titleText1_text_w = titleText1:getAutoRenderSize().width

					print("getAutoRenderSize = " .. titleText1_text_w .. ", getTextAreaSize = " .. titleText1:getTextAreaSize().width)

					if titleText1_frame_w < titleText1_text_w then
						titleText1_text_w = titleText1_frame_w
					end

					local lineImage = self._mainPanel:getChildByFullName("main_bg_0")

					lineImage:setPositionX(titleText1_text_w + 60)
					dateText:setPositionX(titleText1_text_w + 70)
					dateyear:setPositionX(titleText1_text_w + 70)
				end
			end
		end
	end
end

function RankBestMediator:setBestTableView()
	self.isMove = false

	local listLocator = self._tableView
	local clonePanel = self._clonePanel
	local viewSize = listLocator:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self.allRankData
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, index)
		local viewSize = clonePanel:getContentSize()

		return viewSize.width - 4, viewSize.height
	end

	local function cellAtIndex(tableView, index)
		index = index + 1

		local cell = tableView:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local realCell = clonePanel:clone()

			realCell:setPosition(0, 0)
			realCell:setVisible(true)
			realCell:setSwallowTouches(false)
			realCell:setName("realCell")
			cell:addChild(realCell)
		end

		local data = self.allRankData[index]

		self:updataCell(cell, data, index)

		return cell
	end

	local function onScroll()
		self.isMove = true
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
	tableView:setPosition(listLocator:getPosition())
	tableView:setDelegate()
	listLocator:getParent():addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:reloadData()

	self.bestTableView = tableView
end

function RankBestMediator:updataCell(cell, data, index)
	local rankType = data.AppID
	local realCell = cell:getChildByFullName("realCell")

	cell.rankType = rankType

	local mask = realCell:getChildByFullName("mask")
	local rankName_bg = mask:getChildByFullName("rankName_bg")
	local roleNode = mask:getChildByFullName("roleNode")
	local rankNull = mask:getChildByFullName("rankNull")
	local clubNull = mask:getChildByFullName("clubNull")
	local club_layer = mask:getChildByFullName("club_layer")
	local name_bg = mask:getChildByFullName("name_bg")

	roleNode:removeAllChildren()
	roleNode:setVisible(false)
	club_layer:removeAllChildren()
	club_layer:setVisible(false)
	rankNull:setVisible(false)
	clubNull:setVisible(false)
	name_bg:setVisible(false)

	for i = 1, 6 do
		rankName_bg:getChildByFullName("text" .. i):setString("")

		if i == 4 then
			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(56, 56, 85, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(83, 57, 90, 255)
				}
			}

			rankName_bg:getChildByFullName("text" .. i):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
				x = -1,
				y = -1
			}))
		end
	end

	local name_lbl = name_bg:getChildByFullName("name_lbl")
	local power_num = name_bg:getChildByFullName("power_num")
	local power_lbl = name_bg:getChildByFullName("power_lbl")
	local nameBg = name_bg:getChildByFullName("name_bg")
	local combatBg = name_bg:getChildByFullName("combat_bg")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		power_lbl:setFontName("CustomFont_FZYH_M")
		power_lbl:setFontSize(22)
		power_lbl:setPositionY(32)
	end

	local function switchTabView(response)
		if response.resCode ~= GS_SUCCESS then
			return
		end

		if tolua.isnull(rankName_bg) then
			return
		end

		local rankTitleName = Strings:get(self.allRankData[index].Desc3)

		rankTitleName = string.split(rankTitleName, "/")

		local lb = response.data.lb
		local rankName_bg_4 = rankName_bg:getChildByFullName("rankName_bg_4")
		local rankName_bg_5 = rankName_bg:getChildByFullName("rankName_bg_5")

		rankName_bg_4:setVisible(not (#rankTitleName > 4))
		rankName_bg_5:setVisible(#rankTitleName > 4)

		for i = 1, #rankTitleName do
			local text = rankName_bg:getChildByFullName("text" .. i)

			text:setString(rankTitleName[i])

			if i == 3 and #rankTitleName == 3 or i == 5 and #rankTitleName == 5 then
				text:setString("")

				text = rankName_bg:getChildByFullName("text" .. i + 1)

				text:setString(rankTitleName[i])
			end

			if getCurrentLanguage() ~= GameLanguageType.CN then
				text:setFontSize(35)
			end
		end

		if #lb > 0 then
			name_bg:setVisible(true)
			name_lbl:setString(lb[1].nickname)
			power_num:setString(lb[1].value)
			power_lbl:setString(rankPowerType[rankType])

			if rankType == RankType.kClub or rankType == RankType.kClubBoss then
				name_lbl:setString(lb[1].clubName)

				local headIcon = IconFactory:createClubIcon({
					clipType = 4,
					id = lb[1].headImg
				})

				headIcon.backImg:setVisible(false)
				headIcon.icon:setScale(1)
				headIcon:addTo(club_layer):posite(club_layer:getContentSize().width / 2, club_layer:getContentSize().height / 2 + 20)
				club_layer:setVisible(true)
			else
				local roleModel = lb[1].surfaceId and ConfigReader:getDataByNameIdAndKey("Surface", lb[1].surfaceId, "Model") or ConfigReader:requireDataByNameIdAndKey("HeroBase", lb[1].board, "RoleModel")
				local img, jsonPath = IconFactory:createRoleIconSpriteNew({
					frameId = "bustframe4_8",
					id = roleModel
				})

				img:addTo(roleNode):posite(-40, 210)
				img:setScale(1)
				roleNode:setVisible(true)
			end
		elseif rankType == RankType.kClub or rankType == RankType.kClubBoss then
			clubNull:setVisible(true)
			club_layer:setVisible(true)
		else
			rankNull:setVisible(true)
		end

		local nameWidth = name_lbl:getContentSize().width
		local nameBgWidth = nameWidth < 179 and 179 or nameWidth

		nameBg:setContentSize(cc.size(nameBgWidth + 20, nameBg:getContentSize().height))
		name_lbl:setPositionX(nameBg:getPositionX() - nameBg:getContentSize().width / 2)

		local allWidth = power_num:getContentSize().width + power_lbl:getContentSize().width
		local bgWidth = allWidth < 180 and 180 or allWidth

		combatBg:setContentSize(cc.size(bgWidth + 15, combatBg:getContentSize().height))

		local centerX = combatBg:getPositionX() - combatBg:getContentSize().width / 2

		power_lbl:setPositionX(centerX - allWidth / 2)
		power_num:setPositionX(power_lbl:getPositionX() + power_lbl:getContentSize().width)
	end

	local sendData = {
		rankStart = 1,
		rankEnd = 1,
		type = rankType
	}

	self._rankSystem:requestRankData(sendData, switchTabView)
	realCell:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self.isMove = false
		elseif eventType == ccui.TouchEventType.moved then
			-- block empty
		elseif eventType == ccui.TouchEventType.ended then
			if self.isMove then
				return
			end

			self._rankSystem:tryEnterRank({
				blockUI = true,
				ignoreClean = true,
				index = self.allRankData[index].AppID
			})
		end
	end)
	self:setRewardRedPoint(cell, rankType)
end

function RankBestMediator:refreshData()
	self._rankList = self._rankSystem:getRankListByType(self._curClubId) or {}
	self._clubRankList = self._rankSystem:getRankListByType(RankType.kClub) or {}
end

function RankBestMediator:refreshView()
	return
end

function RankBestMediator:onClickBack()
	self:close()
end

function RankBestMediator:dailyReset()
	self:close()
end

function RankBestMediator:setRewardRedPoint(cell)
	local panel = cell
	local status = self._rankSystem:getRewardRedPointByRankType(cell.rankType)
	local redPoint = panel:getChildByName("redPoint")

	if not redPoint then
		redPoint = RedPoint:createDefaultNode()

		redPoint:addTo(panel):posite(320, 450)
		redPoint:setLocalZOrder(99901)
		redPoint:setName("redPoint")
		redPoint:setScale(1)
	end

	redPoint:setVisible(status)
end

function RankBestMediator:setRewardView()
	self.bestTableView:reloadData()
end
