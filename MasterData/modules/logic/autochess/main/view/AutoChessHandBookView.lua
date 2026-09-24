-- chunkname: @modules/logic/autochess/main/view/AutoChessHandBookView.lua

module("modules.logic.autochess.main.view.AutoChessHandBookView", package.seeall)

local AutoChessHandBookView = class("AutoChessHandBookView", BaseView)
local tabIdx = {
	leader = 2,
	mutation = 3,
	chess = 1
}

function AutoChessHandBookView:onInitView()
	self._goTagContent = gohelper.findChild(self.viewGO, "#scroll_tag/viewport/#go_TagContent")
	self._goTagItem = gohelper.findChild(self.viewGO, "#scroll_tag/viewport/#go_TagContent/#go_TagItem")
	self._scrollbook = gohelper.findChildScrollRect(self.viewGO, "#scroll_book")
	self._scrollLeader = gohelper.findChildScrollRect(self.viewGO, "#scroll_Leader")
	self._scrollMutation = gohelper.findChildScrollRect(self.viewGO, "#scroll_Mutation")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessHandBookView:onClickChessTabClick(tabIdx)
	if self._curTab == tabIdx then
		return
	end

	self._curTab = tabIdx

	self.anim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(self._delaySwitch, self, 0.16)
end

function AutoChessHandBookView:_delaySwitch()
	self:refreshTabsView()
	self:refreshTagView()
end

function AutoChessHandBookView:_editableInitView()
	self.tabItemMap = {}

	for _, type in pairs(tabIdx) do
		local item = self:getUserDataTb_()
		local go = gohelper.findChild(self.viewGO, "#scroll_tab/viewport/content/" .. type)

		item.goSelect = gohelper.findChild(go, "go_Select")

		local btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

		self.addClickCb(self, btnClick, self.onClickChessTabClick, self, type)

		self.tabItemMap[type] = item
	end

	self._defaultTab = tabIdx.chess
	self._defaultTagIdx = 1
	self._curTab = self._defaultTab
	self._curTagIdx = self._defaultTagIdx
	self._tagIdMap = {}
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.actId = Activity182Model.instance:getCurActId()
	self.chessCfgRaceListMap = AutoChessConfig.instance:getChessCfgRaceListMap()

	table.sort(self.chessCfgRaceListMap, self.chessCfgSortFunc)
end

function AutoChessHandBookView:onOpen()
	self:refreshTabsView()
	self:createTagItems()
	self:refreshTagView()
end

function AutoChessHandBookView:refreshTabsView()
	for type, item in pairs(self.tabItemMap) do
		gohelper.setActive(item.goSelect, type == self._curTab)
	end
end

function AutoChessHandBookView:createTagItems()
	if self._curTab == tabIdx.chess then
		local chessTabDataList = {}

		for _, chessData in ipairs(lua_auto_chess_translate.configList) do
			chessTabDataList[#chessTabDataList + 1] = chessData
		end

		self._chessTabGoList = self:getUserDataTb_()

		gohelper.CreateObjList(self, self.createChessTagItem, chessTabDataList, self._goTagContent, self._goTagItem)
	end
end

function AutoChessHandBookView:createChessTagItem(itemGo, chessData, index)
	self._chessTabGoList[index] = itemGo

	local textTypeName = gohelper.findChildText(itemGo, "txt_Type")

	textTypeName.text = chessData.name
	self._tagIdMap[index] = chessData.id

	local imageTagBg = gohelper.findChildImage(itemGo, "image_Type")

	SLFramework.UGUI.GuiHelper.SetColor(imageTagBg, chessData.color)

	local selectGo = gohelper.findChild(itemGo, "go_Select")

	gohelper.setActive(selectGo, self._curTagIdx == index)

	local btnTabClick = gohelper.findChildButtonWithAudio(itemGo, "btn_Click")

	self.addClickCb(self, btnTabClick, self.onClickTagItem, self, index)
end

function AutoChessHandBookView:onClickTagItem(index)
	if index == self._curTagIdx then
		return
	end

	self._curTagIdx = index

	for idx, tabItemGo in ipairs(self._chessTabGoList) do
		local selectGo = gohelper.findChild(tabItemGo, "go_Select")

		gohelper.setActive(selectGo, idx == index)
	end

	self:refreshTagView()
end

function AutoChessHandBookView:refreshTagView()
	gohelper.setActive(self._goTagContent, self._curTab == tabIdx.chess)
	self:refreshHandBookItems()
end

function AutoChessHandBookView:refreshHandBookItems()
	if self._curTab == tabIdx.chess then
		if not self.chessModel then
			self:buildChessScrollView()
		end

		local moList = {}
		local race = self._tagIdMap[self._curTagIdx]

		for _, config in ipairs(self.chessCfgRaceListMap[race]) do
			moList[#moList + 1] = {
				type = AutoChessCard.ShowType.HandBook,
				itemId = config.id
			}
		end

		self.chessModel:setList(moList)
	elseif self._curTab == tabIdx.leader then
		if not self.leaderModel then
			self:buildLeaderScrollView()

			local list = {}

			for _, config in ipairs(lua_auto_chess_master.configList) do
				if config.illustrationShow == 1 then
					list[#list + 1] = {
						leaderId = config.id,
						type = AutoChessLeaderCard.ShowType.HandBook
					}
				end
			end

			self.leaderModel:setList(list)
		end
	elseif self._curTab == tabIdx.mutation and not self.mutatiomModel then
		self:buildMutationScrollView()

		local mutationCfgs = lua_auto_chess_mutation.configList
		local list = {}

		for _, config in ipairs(mutationCfgs) do
			if config.activityId == self.actId and config.isOnline then
				list[#list + 1] = config
			end
		end

		table.sort(list, function(a, b)
			return a.sequence < b.sequence
		end)
		self.mutatiomModel:setList(list)
	end

	gohelper.setActive(self._scrollbook, self._curTab == tabIdx.chess)
	gohelper.setActive(self._scrollLeader, self._curTab == tabIdx.leader)
	gohelper.setActive(self._scrollMutation, self._curTab == tabIdx.mutation)
end

function AutoChessHandBookView.chessCfgSortFunc(chessCfgA, chessCfgB)
	if chessCfgA and chessCfgB then
		if chessCfgA.levelFromMall == chessCfgB.levelFromMall then
			return chessCfgA.id < chessCfgB.id
		else
			return chessCfgA.levelFromMall > chessCfgB.levelFromMall
		end
	end

	return false
end

function AutoChessHandBookView:onDestroyView()
	TaskDispatcher.cancelTask(self._delaySwitch, self)
end

function AutoChessHandBookView:buildChessScrollView()
	self.chessModel = ListScrollModel.New()

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_book"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = AutoChessStrEnum.ResPath.ChessCard
	scrollParam.cellClass = AutoChessHandbookChessItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 520
	scrollParam.cellHeight = 690
	scrollParam.cellSpaceH = 40
	scrollParam.cellSpaceV = 75
	scrollParam.startSpace = 50

	local view = LuaListScrollView.New(self.chessModel, scrollParam)

	self:addChildView(view)
end

function AutoChessHandBookView:buildLeaderScrollView()
	self.leaderModel = ListScrollModel.New()

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_Leader"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = AutoChessStrEnum.ResPath.LeaderCard
	scrollParam.cellClass = AutoChessHandbookLeaderItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 520
	scrollParam.cellHeight = 690
	scrollParam.cellSpaceH = 40
	scrollParam.cellSpaceV = 75
	scrollParam.startSpace = 50

	local view = LuaListScrollView.New(self.leaderModel, scrollParam)

	self:addChildView(view)
end

function AutoChessHandBookView:buildMutationScrollView()
	self.mutatiomModel = ListScrollModel.New()

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_Mutation"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_Mutation/Viewport/Content/Item"
	scrollParam.cellClass = AutoChessHandbookMutationItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1400
	scrollParam.cellHeight = 181
	scrollParam.cellSpaceV = 40
	scrollParam.startSpace = 44

	local view = LuaListScrollView.New(self.mutatiomModel, scrollParam)

	self:addChildView(view)
end

return AutoChessHandBookView
