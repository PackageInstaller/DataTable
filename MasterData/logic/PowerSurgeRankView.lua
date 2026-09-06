-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/powersurge/PowerSurgeRankView.lua

module("logic.extensions.bonus.view.powersurge.PowerSurgeRankView", package.seeall)

local PowerSurgeRankView = class("PowerSurgeRankView", ViewComponent)

function PowerSurgeRankView:buildUI()
	PowerSurgeRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._empty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._prize = self:getGo("right/myRank/prize")
	self._comPrize = goutil.findChild(self._prize, "com")
	self._tabCell = self:getGo("tabCell")
	self._leftTabs = self:getGo("leftTabView")
	self._leftTabView = ScrollerList.create(self._leftTabs, self._tabCell, GameUtil.handler(self._updateLeftTabs, self), GameUtil.handler(self._clearLeftTabs, self))
	self._rankCell = self:getGo("right/rankCell")
	self._rankTabs = self:getGo("right/rankListView")
	self._rankTableView = ScrollerList.create(self._rankTabs, self._rankCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function PowerSurgeRankView:bindEvents()
	PowerSurgeRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function PowerSurgeRankView:unbindEvents()
	PowerSurgeRankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PowerSurgeRankView:onEnter()
	PowerSurgeRankView.super.onEnter(self)

	local params = self:getOpenParam()
	local rootId = params and params[1]

	if params then
		if not params[2] then
			local leafId = 1

			self._isOpenSubTab = true

			self:_onClickLeftTab(rootId, leafId)
			GlobalDispatcher:addListener(GlobalNotify.RankDataGet, self._updateRankView, self)
			GlobalDispatcher:addListener(GlobalNotify.PowerSurgeRankDataGetError, self._onError, self)
		end
	end
end

function PowerSurgeRankView:onExit()
	PowerSurgeRankView.super.onExit(self)

	self._firstRootId = nil
	self._curLeafId = nil
	self._curRootId = nil

	self._leftTabView:dispose()
	self._rankTableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.RankDataGet, self._updateRankView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerSurgeRankDataGetError, self._onError, self)
	MaterialMgr.resetAll(self._comPrize)
end

function PowerSurgeRankView:_updateLeftTabs(view, cellGo, data)
	local cell = self:_clearLeftTabs(cellGo)

	if data then
		cell.rootTxtName.text = data.showTab

		cell.rootColor:SetState(self._curRootId == data.rootId and 0 or 1)
		goutil.setActive(cell.rootCell, data.leafId == -1)
		goutil.setActive(cell.rootSelect, self._curRootId == data.rootId)
		GameUtil.addClickHandler(cell.rootCell, GameUtil.handler(self._onClickLeftTab, self, data.rootId, data.leafId))

		cell.leafTxtName.text = data.showTab

		cell.leafColor:SetState(self._curLeafId == data.leafId and 0 or 1)
		goutil.setActive(cell.leafCell, data.leafId ~= -1)
		goutil.setActive(cell.leafSelect, self._curLeafId == data.leafId)
		GameUtil.addClickHandler(cell.leafCell, GameUtil.handler(self._onClickLeftTab, self, data.rootId, data.leafId))
	end
end

function PowerSurgeRankView:_clearLeftTabs(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.rootCell = goutil.findChild(cell.go, "rootCell")
	cell.rootSelect = goutil.findChild(cell.rootCell, "imgSelected")
	cell.rootTxtName = goutil.findChildTextComponent(cell.rootCell, "txtName")
	cell.rootColor = goutil.findChildComponent(cell.rootCell, "txtName", "UITextColorChange")

	GameUtil.rmClickHandler(cell.rootCell)

	cell.leafCell = goutil.findChild(cell.go, "leafCell")
	cell.leafSelect = goutil.findChild(cell.leafCell, "imgSelected")
	cell.leafTxtName = goutil.findChildTextComponent(cell.leafCell, "txtName")
	cell.leafColor = goutil.findChildComponent(cell.leafCell, "txtName", "UITextColorChange")

	GameUtil.rmClickHandler(cell.leafCell)

	return cell
end

function PowerSurgeRankView:_getCurTabDataList()
	if not self._curTabDataList then
		self._firstRootId = -1
		self._curTabDataList = {}

		local rootDataList = {
			{
				showTab = "战力榜单",
				rootType = 1,
				rootId = 0,
				leafId = -1,
				leafDataList = {},
				params = {}
			}
		}

		for i, rootData in ipairs(rootDataList) do
			rootData.rootId = i

			if rootData.rootType == 1 then
				local actCfg = PowerSurgeConfig.instance:getOpenActivityCfg()
				local actId = actCfg and actCfg.activityId

				if actId then
					local cfgs = PowerSurgeConfig.instance:getRankCfgs(actId)

					if cfgs then
						rootData.params = {
							actId
						}

						for _i, cfg in ipairs(cfgs) do
							table.insert(rootData.leafDataList, {
								leafType = 1,
								showTab = cfg.zoneName,
								rootId = rootData.rootId,
								leafId = cfg.id
							})
						end
					end

					self._curTabDataList[rootData.rootId] = rootData

					if self._firstRootId == -1 then
						self._firstRootId = rootData.rootId
					end
				end
			end
		end
	end

	return self._curTabDataList
end

function PowerSurgeRankView:_getCurShowTabDataList()
	local tabDataList = self:_getCurTabDataList()
	local showDataList = {}

	if self._isOpenSubTab then
		for k, data in pairs(tabDataList) do
			table.insert(showDataList, data)

			if data.rootId == self._curRootId then
				for leafI, leafData in ipairs(data.leafDataList) do
					table.insert(showDataList, leafData)
				end
			end
		end
	else
		showDataList = tabDataList
	end

	return showDataList
end

function PowerSurgeRankView:_updateLeftTab()
	local dataList = self:_getCurShowTabDataList()

	self._leftTabView:reloadData(dataList)
end

function PowerSurgeRankView:_onClickLeftTab(rootId, leafId)
	if self._curRootId == rootId then
		if leafId == -1 then
			self._isOpenSubTab = not self._isOpenSubTab

			self:_updateLeftTab()
		elseif leafId ~= self._curLeafId then
			self._curLeafId = leafId

			self:_updateRightData()
			self:_updateLeftTab()
		end
	else
		local curTabDataList = self:_getCurTabDataList()
		local newRootData = curTabDataList[rootId]

		if newRootData then
			self._curRootId = rootId
			self._curLeafId = leafId

			if self._curLeafId == -1 then
				self._curLeafId = 1
				self._isOpenSubTab = true
			end

			self:_updateRightData()
			self:_updateLeftTab()
		elseif not self._curRootId then
			self._curRootId = self._firstRootId
			self._curLeafId = 1
			self._isOpenSubTab = true

			self:_updateRightData()
			self:_updateLeftTab()
		end
	end
end

function PowerSurgeRankView:_updateRightData()
	local rootData = self._curTabDataList[self._curRootId]
	local leafData = rootData and rootData.leafDataList[self._curLeafId]

	if rootData and leafData then
		if rootData.rootType == 1 then
			ZdlRampageAgent.instance:sendPM_ZdlRampageCompetitionRankReq(rootData.params[1], self._curLeafId)
		end
	else
		self:_resetRightView()
	end
end

function PowerSurgeRankView:_updateRankView()
	self._dealType = -1
	self._dealParams = {}

	local rankList = {}
	local myRank = -1
	local prizeStr = ""
	local rootData = self._curTabDataList[self._curRootId]
	local leafData = rootData and rootData.leafDataList[self._curLeafId]

	if rootData and leafData and rootData.rootType == 1 then
		local rankMo = RankModel.instance:getRankMo(GameEnum.RankType.PowerSurgeRank, self._curLeafId)

		if rankMo then
			rankList = rankMo.rankInfos
			myRank = rankMo.myRank
			prizeStr = PowerSurgeConfig.instance:getRankPrizeByRank(rootData.params[1], rankMo.myRank)
			self._dealType = 1
			self._dealParams = {
				rootData.params[1]
			}
		end
	end

	self._rankTableView:reloadData(rankList)
	goutil.setActive(self._empty, #rankList == 0)

	self._txtMyRank.text = myRank == -1 and "未上榜" or myRank

	if string.nilorempty(prizeStr) then
		goutil.setActive(self._prize, false)
	else
		goutil.setActive(self._prize, true)
		MaterialMgr.resetAll(self._comPrize)
		MaterialMgr.setCellListByCfg(prizeStr, self._comPrize)
	end
end

function PowerSurgeRankView:_onError(status)
	self:_resetRightView()
end

function PowerSurgeRankView:_resetRightView()
	self._rankTableView:reloadData({})

	self._txtMyRank.text = "未上榜"

	goutil.setActive(self._prize, false)
	goutil.setActive(self._empty, true)
end

function PowerSurgeRankView:_updateRankCell(view, cellGo, data)
	local cell = self:_clearRankCell(cellGo)

	if data then
		HeadItemController.instance:setHeadCellByInfo(cell.headIcon, data.headInfo, true)

		cell.txtRank.text = data.rank
		cell.txtName.text = data.headInfo.userName
		cell.txtArea.text = data.headInfo.areaName
		cell.txtAddPower.text = data.value

		if self._dealType == 1 then
			local prizeStr = PowerSurgeConfig.instance:getRankPrizeByRank(self._dealParams[1], data.rank)

			MaterialMgr.setCellListByCfg(prizeStr, cell.prizeCom)
		end
	end
end

function PowerSurgeRankView:_clearRankCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.txtRank = goutil.findChildTextComponent(cell.go, "txtRank")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtArea = goutil.findChildTextComponent(cell.go, "txtArea")
	cell.txtAddPower = goutil.findChildTextComponent(cell.go, "addPower/txt")
	cell.prizeCom = goutil.findChild(cell.go, "prizeList")

	MaterialMgr.resetAll(cell.prizeCom)

	cell.headIcon = goutil.findChild(cell.go, "imgIcon")

	HeadItemController.instance:resetHeadCell(cell.headIcon)

	return cell
end

return PowerSurgeRankView
