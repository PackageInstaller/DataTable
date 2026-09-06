-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingKnockoutMainView.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingKnockoutMainView", package.seeall)

local YoungChampionKingKnockoutMainView = class("YoungChampionKingKnockoutMainView", ViewComponent)

function YoungChampionKingKnockoutMainView:ctor()
	YoungChampionKingKnockoutMainView.super.ctor(self)
end

function YoungChampionKingKnockoutMainView:unbindEvents()
	YoungChampionKingKnockoutMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function YoungChampionKingKnockoutMainView:bindEvents()
	YoungChampionKingKnockoutMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function YoungChampionKingKnockoutMainView:buildUI()
	YoungChampionKingKnockoutMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goldBarCon = self:getGo("goldBarCon")
	self._bg = self:getGo("bg")
	self.container = self:getGo("container")
	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function YoungChampionKingKnockoutMainView:onExit()
	YoungChampionKingKnockoutMainView.super.onExit(self)
	self._tableview:dispose()
end

function YoungChampionKingKnockoutMainView:onEnter()
	YoungChampionKingKnockoutMainView.super.onEnter(self)

	self._activityId = YoungChampionKingModel.instance:getCurActId()

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._enterRoundId = checknumber(params[2])

	self.addGEvent(self, GlobalNotify.PM_YCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_YCKGetInfoRes, self._handleGetInfo, self)
	YoungChampionKingController.instance:sendPM_YCKGetInfoReq(self._activityId)
end

function YoungChampionKingKnockoutMainView:_handleGetInfo()
	self:_updateUIByCfg()
end

function YoungChampionKingKnockoutMainView:_onStepChange(newStepId)
	YoungChampionKingController.instance:sendPM_YCKGetInfoReq(self._activityId)
end

function YoungChampionKingKnockoutMainView:_updateUIByCfg()
	self._actCfg = YoungChampionKingConfig.instance:getActCfg(self._activityId)

	local btn_list = {
		{
			showAdd = true,
			id = self._actCfg.guessItem
		},
		{
			showAdd = true,
			id = self._actCfg.exchangeItem
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)

	self._selectRootId = nil
	self._selectLeafId = nil
	self._isUnfold = false

	self:_initTabDataList()

	local curStepId = YoungChampionKingModel.instance:getCurStepId()
	local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)
	local playerRoundId = YoungChampionKingModel.instance:getPlayerRoundId()

	if playerRoundId < curRoundId then
		self:_onClickTab(2)
	else
		self:_onClickTab(1)
	end
end

function YoungChampionKingKnockoutMainView:_initTabDataList()
	self._tabDataList = self._tabDataList or {
		[YoungChampionKingEnum.War_Zone_Start_Round_Id] = {
			{
				params = "",
				tabName = "我的赛程",
				viewname = ViewName.YoungChampionKingKnockoutRoomView,
				leafDataList = {}
			},
			{
				tabName = "比赛赛程",
				viewname = ViewName.YoungChampionKingKnockout8playerView,
				params = YoungChampionKingEnum.Common_Knockout_128To64_Id,
				leafDataList = {}
			}
		},
		[YoungChampionKingEnum.Champion_Start_Round_Id] = {
			{
				params = "",
				tabName = "我的赛程",
				viewname = ViewName.YoungChampionKingKnockoutRoomView,
				leafDataList = {}
			},
			{
				params = "",
				viewname = "",
				tabName = "比赛赛程",
				leafDataList = {
					{
						tabName = "16进4",
						viewname = ViewName.YoungChampionKingKnockout4playerView,
						params = YoungChampionKingEnum.Common_Knockout_16To8_Id
					},
					{
						tabName = "4强",
						viewname = ViewName.YoungChampionKingKnockout4playerView,
						params = YoungChampionKingEnum.Common_Knockout_4To2_Id
					},
					{
						tabName = "季军",
						viewname = ViewName.YoungChampionKingFinalsView,
						params = YoungChampionKingEnum.Third_Place_Match_Round_Id
					},
					{
						tabName = "冠军",
						viewname = ViewName.YoungChampionKingFinalsView,
						params = YoungChampionKingEnum.Final_Match_Round_Id
					}
				}
			}
		}
	}

	if not self._tabDataList[self._enterRoundId] then
		local curTabDataList = {}
		local curTabDataMap = {}

		for i, data in ipairs(curTabDataList) do
			data.rootId = i
			data.leafId = 0
			data.isExistLeaf = #data.leafDataList > 0
			curTabDataMap[data.rootId] = curTabDataMap[data.rootId] or {}
			curTabDataMap[data.rootId][data.leafId] = data

			for k, leafData in ipairs(data.leafDataList) do
				leafData.rootId = i
				leafData.leafId = k
				leafData.isExistLeaf = false
				curTabDataMap[leafData.rootId][leafData.leafId] = leafData
			end
		end

		self._curTabDataMap = curTabDataMap
	end
end

function YoungChampionKingKnockoutMainView:_getCurShowDataList()
	local dataList = {}

	for rootId, leafMap in pairs(self._curTabDataMap) do
		for leafId, data in pairs(leafMap) do
			if leafId == 0 then
				table.insert(dataList, data)
			elseif self._isUnfold and rootId == self._selectRootId then
				table.insert(dataList, data)
			end
		end
	end

	table.sort(dataList, function(a, b)
		if a.rootId ~= b.rootId then
			return a.rootId < b.rootId
		else
			return a.leafId < b.leafId
		end
	end)

	return dataList
end

function YoungChampionKingKnockoutMainView:_getCurDataList()
	self._tabDataList = self._tabDataList or {
		[YoungChampionKingEnum.War_Zone_Start_Round_Id] = {
			{
				params = "",
				viewname = "",
				tabName = "我的赛程",
				leafDataList = {}
			},
			{
				params = "",
				tabName = "比赛赛程",
				viewname = ViewName.YoungChampionKingKnockout8playerView,
				leafDataList = {}
			}
		},
		[YoungChampionKingEnum.Champion_Start_Round_Id] = {
			{
				params = "",
				viewname = "",
				tabName = "我的赛程",
				leafDataList = {}
			},
			{
				params = "",
				viewname = "",
				tabName = "比赛赛程",
				leafDataList = {
					{
						params = "",
						tabName = "16进4",
						viewname = ViewName.YoungChampionKingKnockout4playerView
					},
					{
						params = "",
						tabName = "4强",
						viewname = ViewName.YoungChampionKingKnockout4playerView
					},
					{
						params = "",
						viewname = "",
						tabName = "冠军"
					},
					{
						params = "",
						viewname = "",
						tabName = "季军"
					}
				}
			}
		}
	}

	if not self._tabDataList[self._enterRoundId] then
		local curTabList = {}
		local dataList = {}

		for i, data in ipairs(curTabList) do
			data.rootId = i
			data.leafId = 0
			data.isExistLeaf = #data.leafDataList > 0

			table.insert(dataList, data)

			if self._isUnfold and i == self._selectRootId then
				for k, leafData in ipairs(data.leafDataList) do
					leafData.rootId = i
					leafData.leafId = k
					leafData.isExistLeaf = false

					table.insert(dataList, leafData)
				end
			end
		end

		return dataList
	end
end

function YoungChampionKingKnockoutMainView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if data.leafId == 0 then
		if data.rootId == self._selectRootId then
			cell.imgChange:SetState(1)
			cell.txtChange:SetState(3)
		else
			cell.imgChange:SetState(0)
			cell.txtChange:SetState(2)
		end

		cell.subImgChange:SetState(2)
	else
		cell.imgChange:SetState(2)

		if data.leafId == self._selectLeafId then
			cell.subImgChange:SetState(1)
			cell.txtChange:SetState(1)
		else
			cell.subImgChange:SetState(0)
			cell.txtChange:SetState(0)
		end
	end

	cell.txt.text = data.tabName

	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickTab, self, data.rootId, data.leafId))

	if data.viewname ~= ViewName.YoungChampionKingKnockoutRoomView and self:_checkDataOpen(data) then
		RedPointController.instance:regRedPoint(cell.redpoint, RedPointModel.ID_YOUNG_CHAMPION_KING_GAIN_COIN)

		return
	end
end

function YoungChampionKingKnockoutMainView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.imgChange = goutil.findChildComponent(cell.go, "bg", "UIImageSpriteChange")
	cell.subImgChange = goutil.findChildComponent(cell.go, "subBg", "UIImageSpriteChange")
	cell.txtChange = goutil.findChildComponent(cell.go, "txt", "UITextColorChange")
	cell.btn = goutil.findChild(cell.go, "btn")
	cell.redpoint = goutil.findChild(cell.go, "redpoint")
	cell.txt = goutil.findChildTextComponent(cell.go, "txt")

	GameUtil.rmClickHandler(cell.btn)
	goutil.setActive(cell.redpoint, false)
	goutil.setActive(cell.goTag, false)
	RedPointController.instance:unregRedPoint(cell.redpoint)

	return cell
end

function YoungChampionKingKnockoutMainView:_onClickTab(rootId, leafId)
	if rootId == self._selectRootId and leafId == self._selectLeafId then
		return
	end

	local lastLeaftId = self._selectLeafId
	local lastRootId = self._selectRootId
	local clickRootId = rootId
	local clickLeafId = leafId or 0
	local isClickRoot = clickLeafId == 0

	if clickRootId ~= self._selectRootId then
		clickLeafId = 0
	end

	local clickData = self._curTabDataMap[clickRootId][clickLeafId]

	if clickData.isExistLeaf then
		clickLeafId = 1
		clickData = self._curTabDataMap[clickRootId][1]
	end

	if not self:_checkDataOpen(clickData) then
		TipsFacade.instance:openCommonTips("阶段未开始")

		return
	end

	local isNeedReload = false
	local isNeedOpenNewView = false

	if isClickRoot then
		if clickRootId ~= self._selectRootId then
			self._selectRootId = clickRootId
			self._selectLeafId = clickLeafId
			self._isUnfold = true
			isNeedReload = true
			isNeedOpenNewView = true
		else
			self._isUnfold = not self._isUnfold
			isNeedReload = true
		end
	else
		self._selectLeafId = clickLeafId
		isNeedReload = true
		isNeedOpenNewView = true
	end

	if isNeedOpenNewView then
		if YoungChampionKingModel.instance:getUserIdIsReady(RoleModel.instance:getUserId()) then
			local tips = "确定退出准备，离开房间？"

			TipsFacade.instance:openPopupWindowWithX("提示", tips, function()
				self:showTabAt(self.container)
				self:showTabAt(self.container, clickData.viewname, clickData.params)
			end, function()
				self._selectLeafId = lastLeaftId
				self._selectRootId = lastRootId
				isNeedReload = false
			end)

			return
		else
			self:showTabAt(self.container)
			self:showTabAt(self.container, clickData.viewname, clickData.params)
		end
	end

	if isNeedReload then
		self._tableview:reloadData(self:_getCurShowDataList())
	end
end

function YoungChampionKingKnockoutMainView:_checkDataOpen(clickData)
	if clickData then
		local curStepId = YoungChampionKingModel.instance:getCurStepId()
		local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)
		local roundId = checknumber(clickData.params)

		if roundId > 0 then
			if roundId <= curRoundId then
				return true
			else
				return false
			end
		end

		return true
	end
end

function YoungChampionKingKnockoutMainView:_onClickClose()
	if YoungChampionKingModel.instance:getUserIdIsReady(RoleModel.instance:getUserId()) then
		local tips = "确定退出准备，离开房间？"

		TipsFacade.instance:openPopupWindowWithX("提示", tips, function()
			self:close()
		end)

		return
	else
		self:close()
	end
end

return YoungChampionKingKnockoutMainView
