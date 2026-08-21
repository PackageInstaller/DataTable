-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/view/newview/ClimbingTowerBrightView.lua

module("logic.extensions.climbingtower.view.newview.ClimbingTowerBrightView", package.seeall)

local M = class("ClimbingTowerBrightView", ViewComponent)
local dotPosBegin = 22
local mapPosBegin = -1624
local startDotList = 685
local startMapList = -939
local oneSnap = 142
local scaleTime = 0.2
local moveTime = 0.3
local fixedTime = 0.4

function M:buildUI()
	self._animSwitch = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._climbingPreview = self:getGo("4&climbing_tower_preview_panel_298865838")
	self._climbingBrightPanel = self:getGo("1&climbing_tower_tooling_face_panel_1854280810")
	self._leftBrightPanelGo = self:getGo("1&climbing_tower_tooling_face_panel_-1483015854")
	self._leftBrightLoopList = LoopListHelper.New(self:getGo("1&climbing_tower_tooling_face_panel_1867189586"))

	self._leftBrightLoopList:InitListView(0, self._onTabCellBrightUpdate, self)

	self._layout = self:getGo("1&8&title_view_-478490097")
	self._btnReturn = self:getBtn("1&8&title_view_-878360263")
	self._layout1 = self:getGo("1&9&title_view_-478490097")
	self._btnReturn1 = self:getBtn("1&9&title_view_-878360263")
	self._home = self:getBtn("1&8&title_view_1398742689")
	self._home1 = self:getBtn("1&9&title_view_1398742689")
	self._darkProgressTxt = self:getText("1&climbing_tower_tooling_face_panel_-42725801")
	self._btnBrightToDark = self:getBtn("1&climbing_tower_tooling_face_panel_1947117704")
	self._brightProgressTxt = self:getText("1&climbing_tower_tooling_face_panel_1730167181")
	self._btnBrightRewardView = self:getBtn("1&4&com_btn_2_-31477526")
	self._darkLock = self:getGo("1&climbing_tower_tooling_face_panel_290442803")
	self._darkText = self:getText("1&climbing_tower_tooling_face_panel_192498206")
	self._rightBrightPanelGo = self:getGo("1&climbing_tower_tooling_face_panel_1694249436")
	self._txtNumberBright = self:getText("1&climbing_tower_tooling_face_panel_-1707505512")
	self._txtNameBright = self:getText("1&climbing_tower_tooling_face_panel_-2059599759")
	self._txtInfo = self:getUIComponent("1&climbing_tower_tooling_face_panel_350764963", UIComponentType.TextMeshProUGUI)
	self._btnDungeonFight = self:getBtn("1&6&btn_middle_-31477526")
	self._normalFightGo = self:getGo("1&6&btn_middle_-1257425071")
	self._noFightGo = self:getGo("1&6&btn_middle_1210645110")
	self._dangerRanl = self:getGo("1&2&instance_danger_-1654566369")
	self._goDungeonRewardLst = self:getGo("1&climbing_tower_tooling_face_panel_138133091")
	self._goRewardItemPrefab = self:getGo("1&0&rewards_detail_item_2141037416")

	goutil.setActive(self._goRewardItemPrefab.gameObject, false)

	self._goDungonEnemyLst = self:getGo("1&climbing_tower_tooling_face_panel_564758106")
	self._goEnemyItemPrefab = self:getGo("1&5&hero_item_1481649446")

	goutil.setActive(self._goEnemyItemPrefab.gameObject, false)

	self._sliderRectTransform = self:getRectTransform("4&climbing_tower_preview_panel_464946348")
	self._sliderProgress = self:getSlider("4&climbing_tower_preview_panel_1454383408")
	self._dsGo = self:getRectTransform("4&climbing_tower_preview_panel_2018259560")
	self._scrollRect = self:getScrollRect("4&climbing_tower_preview_panel_2018259560")
	self._scrollRect1 = self._dsGo.gameObject:GetComponent(UIComponentType.ScrollRect)
	self._dotLoopList = LoopListHelper.New(self._dsGo.gameObject)

	self._dotLoopList:InitListView(0, self._onDotCell, self)
	self._dotLoopList:AddBeginDragListener(self.onBeignDrag, self)
	self._dotLoopList:AddDragListener(self.onDrag, self)
	self._dotLoopList:AddEndDragListener(self.onEndDrag, self)
	self._scrollRect:AddOnValueChanged(self.afterDragMove, self)

	self._posYGroup = self:getGo("4&climbing_tower_preview_panel_-556705276")

	local mapDsGo = self:getGo("4&climbing_tower_preview_panel_584480240")

	self._mapScrollRect = mapDsGo:GetComponent(UIComponentType.ScrollRect)
	self._mapLoopList = LoopListHelper.New(mapDsGo)

	self._mapLoopList:InitListView(0, self._onMapCell, self)

	self._v2 = Vector2.New(0, 0)
	self.startPos = 0
	self._canFollower = false
	self._small = Vector3.New(1, 1, 1)
	self._big = Vector3.New(2, 2, 1)
	self._first = 1
end

function M:onBeignDrag()
	if self._isRewardList then
		self._canFollower = false
		self._moveHeadAndTail = false
		self.startPos = self._dotLoopList:GetLoopListView().ContainerTrans.anchoredPosition3D.x
	end
end

function M:onDrag()
	if self._isRewardList then
		self:startOn()
	end
end

function M:onEndDrag()
	if self._isRewardList then
		self.startPos = self._dotLoopList:GetLoopListView().ContainerTrans.anchoredPosition3D.x
		self._canFollower = true
	end
end

function M:afterDragMove()
	if self._isRewardList and self._canFollower or self._moveHeadAndTail and self._isRewardList then
		self:startOn()
	end
end

function M:destroyUI()
	self._leftBrightLoopList:Dispose()

	self._leftBrightLoopList = nil

	self._dotLoopList:RemoveDragListener(self.onBeignDrag, self)
	self._dotLoopList:RemoveDragListener(self.onDrag, self)
	self._dotLoopList:RemoveEndDragListener(self.onEndDrag, self)
	self._scrollRect:RemoveOnValueChanged()
	self._dotLoopList:Dispose()

	self._dotLoopList = nil

	self._mapLoopList:Dispose()

	self._mapLoopList = nil
	self._rightBrightPanelGo = nil
	self._txtNumberBright = nil
	self._txtNameBright = nil
	self._txtInfo = nil
	self._btnDungeonFight = nil
	self._dangerRanl = nil
	self._goDungeonRewardLst = nil
	self._goRewardItemPrefab = nil
end

function M:bindEvents()
	self._btnDungeonFight:AddClickListener(self._onClickDungeonFight, self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnBrightRewardView:AddClickListener(self._onClickRewardView, self)
	self._btnReturn1:AddClickListener(self._onClickRewardRetrun, self)
	self._btnBrightToDark:AddClickListener(self._onClickToDark, self)
	self._home:AddClickListener(self._onClickHome, self)
	self._home1:AddClickListener(self._onClickHome, self)
end

function M:unbindEvents()
	self._btnDungeonFight:RemoveClickListener()
	self._btnReturn:RemoveClickListener()
	self._btnBrightRewardView:RemoveClickListener()
	self._btnReturn1:RemoveClickListener()
	self._btnBrightToDark:RemoveClickListener()
	self._home:RemoveClickListener()
	self._home1:RemoveClickListener()
end

function M:onEnter(reasonTyp)
	GlobalDispatcher:addEventListener(EventType.ENTERY_BREIGHT, self._onInit, self)

	local clearCount = ClimbingTowerModel.instance:getClearDungeonCount()
	local isShowBright = ClimbingTowerController.instance:getIsShowBrightPanel()
	local darkRound = ClimbingTowerDarkModel.instance:getDarkRound()
	local darkRoundCO = ClimbingTowerConfig.instance:getDarkRoundCO(darkRound)

	if clearCount < self:getDarkSideUnLockCondition() or isShowBright or not darkRoundCO or darkRoundCO and darkRoundCO:isExpired() then
		self:_onInit()
	end
end

function M:getDarkSideUnLockCondition()
	if self:getConst("DarkTowerUnlockCondition") then
		return self:getConst("DarkTowerUnlockCondition").numValue
	else
		return 0
	end
end

function M:getConst(key)
	local data = ClimbingTowerConfig.instance:getConfigList(ConfigName.ClimbTowerConst)
	local temp

	for k, v in pairs(data) do
		if v.key == key then
			return v
		end
	end
end

function M:_onInit()
	goutil.setActive(self._sliderRectTransform.gameObject, false)

	self._scrollRect1.enabled = false
	self._mapScrollRect.enabled = false

	goutil.setActive(self._climbingBrightPanel.gameObject, true)
	goutil.setActive(self._climbingPreview.gameObject, true)
	goutil.setActive(self._leftBrightPanelGo.gameObject, true)
	goutil.setActive(self._layout.gameObject, true)
	goutil.setActive(self._layout1.gameObject, false)
	goutil.setActive(self._rightBrightPanelGo.gameObject, true)
	self:_setEvent(true)
	self:_setDefaultSelectTab(1)

	self._isRewardList = false
	self._posList = self:getPosList()
	self._towerId2Cell = {}
	self._towerDotCell = {}

	local clearCount = ClimbingTowerModel.instance:getClearDungeonCount()

	self._maxStorey = ClimbingTowerConfig.instance:getBrightSideMaxStorey()

	if clearCount >= self._maxStorey then
		self:_setDefaultSelectTab(self._maxStorey)

		self._lastTabTowerId = self._maxStorey
	else
		self:_setDefaultSelectTab(clearCount > 0 and clearCount + 1 or 1)

		self._lastTabTowerId = clearCount > 0 and clearCount + 1 or 1
	end

	self:refreshBrightLeftList()
	settimer(0, self.setDefaultTabFunc, self, false)

	self._brightProgressTxt.text = clearCount .. "/" .. self._maxStorey

	local darkRound = ClimbingTowerDarkModel.instance:getDarkRound()
	local darkRoundCO = ClimbingTowerConfig.instance:getDarkRoundCO(darkRound)

	if darkRoundCO then
		local clearCountDark = ClimbingTowerDarkModel.instance:getClearDungeonCount(darkRound)
		local maxStoreyDark = darkRoundCO:getDungeonCount()

		self._darkProgressTxt.text = clearCountDark .. "/" .. maxStoreyDark
	end

	self:setDarkLock()
end

function M:setDarkLock()
	local clearCount = ClimbingTowerModel.instance:getClearDungeonCount()
	local darkRound = ClimbingTowerDarkModel.instance:getDarkRound()
	local darkRoundCO = ClimbingTowerConfig.instance:getDarkRoundCO(darkRound)

	if clearCount < self:getDarkSideUnLockCondition() or not darkRoundCO then
		goutil.setActive(self._darkLock.gameObject, true)

		self._darkText.text = string.format(lang("tip_dark_can_not_enter"), self:getDarkSideUnLockCondition())
	elseif darkRoundCO and darkRoundCO:isExpired() then
		goutil.setActive(self._darkLock.gameObject, true)

		self._darkText.text = ""
	else
		goutil.setActive(self._darkLock.gameObject, false)
		goutil.setActive(self._darkProgressTxt.gameObject, true)
	end
end

function M:onExit(reasonTyp)
	GlobalDispatcher:removeEventListener(EventType.ENTERY_BREIGHT, self._onInit, self)
	self:_doKill()
	self:_setEvent(false)

	self._isRewardList = false

	removetimer(self.setDefaultTabFunc, self)

	self._towerId2Cell = {}
	self._towerDotCell = {}
	self._maxStorey = 0

	self:setLastTabCell(nil)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	end
end

function M:_onClickReturn()
	GlobalDispatcher:dispatchEvent(EventType.ENTERY_ISSHOWBRIGHT, false)
	self:back()
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.ENTERY_ISSHOWBRIGHT, false)
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:getPosList()
	local tablet = {}
	local childCount = self._posYGroup.transform.childCount

	for i = 0, childCount - 1 do
		local tr = self._posYGroup.transform:GetChild(i).gameObject.transform

		tablet[i + 1] = tr.localPosition.y
	end

	return tablet
end

function M:refreshBrightLeftList()
	self._dungeonMoLst = {}

	local cfgBrightSideLst = ClimbingTowerConfig.instance:getConfigList(ConfigName.LightMoonTower)
	local len = cfgBrightSideLst and #cfgBrightSideLst or 0

	if len > 0 then
		for _, cfg in ipairs(cfgBrightSideLst) do
			local storeyId = cfg.id
			local dungeonId = cfg.dungeon
			local mo = ClimbingTowerModel.instance:getDungeonMoById(dungeonId)

			if mo then
				self._dungeonMoLst[storeyId] = mo
			else
				len = len - 1

				printError(string.format("无法找到[%s][%s]的明面塔数据", storeyId, dungeonId))
			end
		end
	end

	self._leftBrightLoopList:ClearCells()
	self._leftBrightLoopList:SetListItemCount(len, true)
	self._leftBrightLoopList:RefreshAllShownItem()
	self._dotLoopList:SetListItemCount(len, true)
	self._dotLoopList:RefreshAllShownItem()

	local n = math.ceil(len / 10)

	self._mapLoopList:SetListItemCount(n + 2, true)
	self._mapLoopList:RefreshAllShownItem()
end

function M:_onTabCellBrightUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._dungeonMoLst[curIndex]
	local item = self._leftBrightLoopList:NewListViewItem("climbing_tower_tab")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, ClimbingTowerSideTabCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, ClimbingTowerSideTabCell)
	end

	shower:setData(data)
	shower:setHandler(self)

	local defaultTab = self._defaultSelectTab

	if defaultTab and curIndex == defaultTab then
		self:onEntryBrightTabClick1(shower)
	end

	local showSelect = self._lastTabTowerId and self._lastTabTowerId == data:getTowerCfgId()

	shower:setSelected(showSelect)

	self._towerId2Cell[data:getTowerCfgId()] = shower

	return item
end

function M:_setDefaultSelectTab(val)
	self._defaultSelectTab = val
end

function M:getDefaultSelectTab()
	return self._defaultSelectTab or 1
end

function M:setDefaultTabFunc()
	local curCount = self:getDefaultSelectTab()

	self._leftBrightLoopList:MoveToItemIndex(curCount - 1, 0)

	local destinationDot = startDotList - (curCount - 1) * oneSnap
	local destinationMap = startMapList - (curCount - 1) * oneSnap

	if Mathf.Abs(destinationMap - self._dotLoopList:GetLoopListView().ContainerTrans.anchoredPosition3D.x) > oneSnap * 20 and self._first == 1 then
		self._first = 100

		self._dotLoopList:GetLoopListView().ContainerTrans:DOAnchorPosX(destinationDot, 1.3):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
		self._mapLoopList:GetLoopListView().ContainerTrans:DOAnchorPosX(destinationMap, 1.3):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	else
		self._dotLoopList:GetLoopListView().ContainerTrans.anchoredPosition3D = Vector2.New(destinationDot, 0)
		self._mapLoopList:GetLoopListView().ContainerTrans.anchoredPosition3D = Vector2.New(destinationMap, 0)
	end

	self:_setDefaultSelectTab(nil)
end

function M:getLastTabCell()
	return self._towerId2Cell[self._lastTabTowerId]
end

function M:setLastTabCell(tab)
	self._lastTabTowerId = tab and tab:getTowerCfgId() or nil

	if self._lastTabTowerId then
		-- block empty
	end

	self._lastTabDungeonId = tab and tab:getDungeonId() or nil
end

function M:onEntryBrightTabClick1(tabCell)
	if self:getLastTabCell() then
		self:getLastTabCell():setSelected(false)
	end

	tabCell:setSelected(true)
	self:setLastTabCell(tabCell)

	local dungeonId = tabCell:getDungeonId()

	self:_refreshDungeonInfoPanel(dungeonId)
	goutil.setActive(self._rightBrightPanelGo.gameObject, true)
end

function M:onEntryBrightTabClick(tabCell)
	self:_doKill()

	self._isDotSlider = true
	self._isMapSlider = true

	if self._lastTabTowerId and self._lastTabTowerId == tabCell:getTowerCfgId() then
		return
	end

	if self:getLastTabCell() then
		self:getLastTabCell():setSelected(false)
	end

	tabCell:setSelected(true)
	self:setLastTabCell(tabCell)

	local dungeonId = tabCell:getDungeonId()

	self:_refreshDungeonInfoPanel(dungeonId)
	goutil.setActive(self._rightBrightPanelGo.gameObject, true)
	self._dotLoopList:RefreshAllShownItem()

	local curCount = self._lastTabTowerId
	local destinationDot = startDotList - (curCount - 1) * oneSnap
	local destinationMap = startMapList - (curCount - 1) * oneSnap

	self._dotLoopList:GetLoopListView().ContainerTrans:DOAnchorPosX(destinationDot, fixedTime):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
		self._isDotSlider = false
	end, self)
	self._mapLoopList:GetLoopListView().ContainerTrans:DOAnchorPosX(destinationMap, fixedTime):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
		self._isMapSlider = false
	end, self)
end

function M:startOn()
	local curPos = self._dotLoopList:GetLoopListView().ContainerTrans.anchoredPosition3D.x
	local offsetX = curPos - self.startPos

	self.startPos = curPos

	local posX = self._mapLoopList:GetLoopListView().ContainerTrans.anchoredPosition3D.x + offsetX

	self._v2:Set(posX, 0)

	self._mapLoopList:GetLoopListView().ContainerTrans.anchoredPosition3D = self._v2
end

function M:_onDotCell(curIndex)
	curIndex = curIndex + 1

	local data = self._dungeonMoLst[curIndex]
	local item = self._dotLoopList:NewListViewItem("item")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, ClimbingTowerBrightDotCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, ClimbingTowerBrightDotCell)
	end

	local motable = {}

	motable.dungeonData = data
	motable.dotPos = self:_getDotPos(data:getTowerCfgId())
	motable.lastone = curIndex == self._maxStorey
	motable.isrewardView = self._isRewardList

	shower:updateData(motable)
	shower:setHandler(self)

	local showSelect = self._lastTabTowerId and self._lastTabTowerId == data:getTowerCfgId()

	shower:setSelected(showSelect and not self._isRewardList)

	local curShowId = self._lastTabTowerId

	if curIndex ~= self._maxStorey then
		if curIndex + 1 == curShowId and not self._isRewardList then
			local pos = self:_getDotPos(curIndex + 1)
			local ptable = {
				isnextSelect = true,
				pos = pos
			}

			shower:setSelectedState(ptable)
		else
			local pos = self:_getDotPos(curIndex + 1)
			local ptable = {
				isnextSelect = false,
				pos = pos
			}

			shower:setSelectedState(ptable)
		end
	else
		shower:setSelectedState()
	end

	self._towerDotCell[data:getTowerCfgId()] = shower

	return item
end

function M:_getDotPos(id)
	local cfgBrightSideLst = ClimbingTowerConfig.instance:getConfigList(ConfigName.LightMoonTower)
	local info = cfgBrightSideLst[id]

	if info then
		local dosPos = self._posList[info.dotPos] and self._posList[info.dotPos] or self._posList[1]

		return dosPos
	end

	return nil
end

function M:_onMapCell(curIndex)
	local item = self._mapLoopList:NewListViewItem("map")

	return item
end

function M:_refreshDungeonInfoPanel(dungeonId)
	local dungeonMo = ClimbingTowerModel.instance:getDungeonMoById(dungeonId)

	self._txtNumberBright.text = dungeonMo:getIndex()
	self._txtNameBright.text = dungeonMo:getName()
	self._txtInfo.text = StringUtil.replaceTMPBlackBlock(dungeonMo:getDesc())

	local scoreRate = DungeonModel.instance:getDungeonScoreRate(dungeonId, DungeonExtension_pb.BattleTeamType.TEAM_MAINLINE) * 1000
	local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, dungeonMo:getScoreGroup())

	DifficultyUtil.setDifficultyFlag(self._dangerRanl, scoreCO)
	goutil.setActive(self._normalFightGo, not dungeonMo:getIsLock())
	goutil.setActive(self._noFightGo, dungeonMo:getIsLock())
	self:_refreshRewardPanel(dungeonMo)
	self:_refreshEnemyPanel(dungeonMo)
end

function M:_clearRewardLstPrefab()
	local childCount = self._goDungeonRewardLst.transform.childCount

	if childCount > 1 then
		for i = 1, childCount - 1 do
			goutil.destroy(self._goDungeonRewardLst.transform:GetChild(i).gameObject, true)
		end
	end

	local childCount = self._goDungonEnemyLst.transform.childCount

	if childCount > 1 then
		for i = 1, childCount - 1 do
			goutil.destroy(self._goDungonEnemyLst.transform:GetChild(i).gameObject, true)
		end
	end
end

function M:_refreshRewardPanel(dungeonMo)
	self:_clearRewardLstPrefab()

	local count = 0
	local maxCount = 4
	local _tmpTable = {}

	for i, reward in ipairs(dungeonMo:getAllFirstPassReward()) do
		table.insert(_tmpTable, ItemUtil.createItemData({
			itemId = reward.code,
			count = reward.num
		}))
	end

	if #_tmpTable > 0 then
		table.sort(_tmpTable, ItemUtil.commonSortFunc)

		for _, _itemData in ipairs(_tmpTable) do
			local obj = goutil.cloneAndSetParent(self._goRewardItemPrefab, self._goDungeonRewardLst.transform)

			obj:SetActive(true)

			local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
			local _rewardStatus = dungeonMo:hasPassed() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot
			local rewardData = RewardData.New({
				code = _itemData:getItemId(),
				count = _itemData:getCount(),
				rewardStatus = _rewardStatus,
				itemSign = CommEnum.BackPackItemSignTyp.First,
				clickCallBack = self._onClickMoreReward,
				clickCallBackObj = self
			})

			objBeh:updateData(rewardData)
			objBeh:getComponent("reward"):setRewardStatus(_rewardStatus)

			count = count + 1

			if maxCount <= count then
				return
			end
		end
	end

	if maxCount <= count then
		return
	end

	_tmpTable = {}

	for i, code in ipairs(dungeonMo:getImportantPassReward()) do
		table.insert(_tmpTable, ItemUtil.createItemData({
			itemId = code
		}))
	end

	if #_tmpTable > 0 then
		table.sort(_tmpTable, ItemUtil.commonSortFunc)

		for _, _itemData in ipairs(_tmpTable) do
			local obj = goutil.cloneAndSetParent(self._goRewardItemPrefab, self._goDungeonRewardLst.transform)

			obj:SetActive(true)

			local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
			local rewardData = RewardData.New({
				code = _itemData:getItemId(),
				rewardStatus = CommEnum.RewardEnum.CanNotGot,
				clickCallBack = self._onClickMoreReward,
				clickCallBackObj = self
			})

			objBeh:updateData(rewardData)
			objBeh:getComponent("reward"):setRewardStatus(CommEnum.RewardEnum.CanNotGot)

			count = count + 1

			if maxCount <= count then
				return
			end
		end
	end

	_tmpTable = {}

	if dungeonMo:hasPassed() and count == 0 then
		for i, reward in ipairs(dungeonMo:getAllFirstPassReward()) do
			table.insert(_tmpTable, ItemUtil.createItemData({
				itemId = reward.code,
				count = reward.num
			}))
		end

		if #_tmpTable > 0 then
			table.sort(_tmpTable, ItemUtil.commonSortFunc)

			for _, _itemData in ipairs(_tmpTable) do
				local obj = goutil.cloneAndSetParent(self._goRewardItemPrefab, self._goDungeonRewardLst.transform)

				obj:SetActive(true)

				local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
				local _rewardStatus = dungeonMo:hasPassed() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot
				local rewardData = RewardData.New({
					code = _itemData:getItemId(),
					count = _itemData:getCount(),
					rewardStatus = _rewardStatus,
					itemSign = CommEnum.BackPackItemSignTyp.Get,
					clickCallBack = self._onClickMoreReward,
					clickCallBackObj = self
				})

				objBeh:updateData(rewardData)
				objBeh:getComponent("reward"):setRewardStatus(_rewardStatus)

				count = count + 1

				if maxCount <= count then
					return
				end
			end
		end
	end
end

function M:_onClickMoreReward()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click, nil, nil, nil)
	ViewMgr.instance:open(ViewName.DungeonRewardDetailView, self._lastTabDungeonId)

	return false
end

function M:_refreshEnemyPanel(dungeonMo)
	local monsterConf = BattleConfig.instance:getBattleLevelCO(dungeonMo:getDungeonBattleCode())

	if not monsterConf then
		return
	end

	local showMonsters = {}

	for _, group in pairs(monsterConf.monsterGroupList) do
		if group.refreshType ~= 4 then
			for _, monster in pairs(group.monsterList) do
				local monsterCO = monsterConf.monsters[monster.monsterId]

				if (monsterCO.battleCamp == BattleEnum.MonsterCampType.NORMAL or monsterCO.battleCamp == BattleEnum.MonsterCampType.FRIEND) and not TableUtil.contains(showMonsters, monsterCO) then
					table.insert(showMonsters, monsterCO)
				end
			end
		end
	end

	table.sort(showMonsters, MainlineDungeonUtil.sortMonster)

	for i, v in ipairs(showMonsters) do
		local obj = goutil.clone(self._goEnemyItemPrefab.gameObject)

		obj:SetActive(true)

		local objBeh = Astral.LuaComponentContainer.Add(obj, MainlineMonsterHeadCell)

		goutil.addChildToParent(obj, self._goDungonEnemyLst.transform)
		objBeh:setShowMonsterStatus(true)
		objBeh:setMonsterCode(v)
	end
end

function M:_onClickDungeonFight()
	local dungeonId = self._lastTabDungeonId
	local dungeonMo = ClimbingTowerModel.instance:getDungeonMoById(dungeonId)

	if dungeonMo:getIsLock() then
		if enableLog then
			printWarn("is lock", dungeonId)
		end

		FloatWordMgr.instance:show(lang("tip_teaching_lock"))

		return
	end

	BattleCalculateModel.instance:setDefaultItemMoList(dungeonMo:getPointCost())

	local info = {}

	info.dungeonCode = dungeonId
	info.afflatusBuff = false
	info.isShowPlot = true
	info.multiCount = 1
	info.gamePlay = BattleEnum.GamePlayType.NORMAL

	if enableLog then
		printWarn("startDungeonBattle", dungeonId)
	end

	self:_startFight(info)
end

function M:_startFight(info)
	local dungeonId = self._lastTabDungeonId
	local dungeonMo = ClimbingTowerModel.instance:getDungeonMoById(dungeonId)

	if not dungeonMo:getIsPlotNode() then
		local scoreRate = DungeonModel.instance:getDungeonScoreRate(dungeonId) * 1000
		local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, dungeonMo:getScoreGroup())

		if not DungeonController.instance:tryOpenDangerTips(scoreCO, info) then
			self:_goFight(false, info)
		end
	else
		self:_goFight(false, info)
	end
end

function M:_goFight(_, info)
	GlobalDispatcher:dispatchEvent(EventType.ENTERY_ISSHOWBRIGHT, true)
	SceneFace.instance:exitScene()
	DungeonController.instance:startDungeonBattle(info)
end

function M:_onClickRewardView()
	self._moveHeadAndTail = false

	self:_doKill()
	goutil.setActive(self._leftBrightPanelGo.gameObject, false)
	goutil.setActive(self._layout.gameObject, false)
	goutil.setActive(self._layout1.gameObject, true)
	goutil.setActive(self._rightBrightPanelGo.gameObject, false)

	local curCount = self._lastTabTowerId

	self.startPos = self._dotLoopList:GetLoopListView().ContainerTrans.anchoredPosition3D.x

	self._climbingPreview.transform:DOScale(self._small, scaleTime):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
		if curCount >= 6 and curCount <= self._maxStorey - 6 then
			self._scrollRect1.enabled = true
			self._isRewardList = true

			self._dotLoopList:RefreshAllShownItem()
			self:_setSlider()
		end
	end, self)

	if curCount < 6 then
		self._dotLoopList:GetLoopListView().ContainerTrans:DOAnchorPosX(dotPosBegin, moveTime):SetEase(DG.Tweening.Ease.Linear):OnUpdate(function()
			self:startOn()
		end, self):SetAutoKill(true):OnComplete(function()
			self._moveHeadAndTail = true
			self._scrollRect1.enabled = true
			self._isRewardList = true

			self._dotLoopList:RefreshAllShownItem()
			self:_setSlider()
		end, self)
	elseif curCount > self._maxStorey - 6 and (not (self._maxStorey - 10 < 0) or true) then
		local dotPosEnd = -(self._maxStorey - 10) * oneSnap + 9

		self._dotLoopList:GetLoopListView().ContainerTrans:DOAnchorPosX(dotPosEnd, moveTime):SetEase(DG.Tweening.Ease.Linear):OnUpdate(function()
			self:startOn()
		end, self):SetAutoKill(true):OnComplete(function()
			self._moveHeadAndTail = true
			self._scrollRect1.enabled = true
			self._isRewardList = true

			self._dotLoopList:RefreshAllShownItem()
			self:_setSlider()
		end, self)
	end
end

function M:_onClickRewardRetrun()
	self:_doKill()

	self._scrollRect1.enabled = false
	self._isRewardList = false
	self._moveHeadAndTail = false

	goutil.setActive(self._leftBrightPanelGo.gameObject, true)
	goutil.setActive(self._layout.gameObject, true)
	goutil.setActive(self._layout1.gameObject, false)
	goutil.setActive(self._rightBrightPanelGo.gameObject, true)

	local curCount = self._lastTabTowerId
	local destinationDot = startDotList - (curCount - 1) * oneSnap
	local destinationMap = startMapList - (curCount - 1) * oneSnap

	self._climbingPreview.transform:DOScale(self._big, scaleTime):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
		return
	end, self)
	self._dotLoopList:GetLoopListView().ContainerTrans:DOAnchorPosX(destinationDot, scaleTime):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
		self._dotLoopList:RefreshAllShownItem()
		goutil.setActive(self._sliderRectTransform.gameObject, false)
	end, self)
	self._mapLoopList:GetLoopListView().ContainerTrans:DOAnchorPosX(destinationMap, scaleTime):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
		return
	end, self)
end

function M:_doKill()
	self._climbingPreview.transform:DOKill(false)
	self._dotLoopList:GetLoopListView().ContainerTrans:DOKill(false)
	self._mapLoopList:GetLoopListView().ContainerTrans:DOKill(false)
end

local firstSliderPos = 45
local startSliderPosX = 80

function M:_setSlider()
	goutil.setActive(self._sliderRectTransform.gameObject, true)

	local width = (self._maxStorey - 1) * oneSnap + startSliderPosX

	RectTransformUtils.SetWidth(self._sliderRectTransform, width)

	local clearCount = ClimbingTowerModel.instance:getClearDungeonCount()
	local progress = 0

	if clearCount == 1 then
		progress = firstSliderPos / width
	elseif clearCount > 1 then
		progress = (1 - firstSliderPos / width) / (self._maxStorey - 1) * (clearCount - 1) + firstSliderPos / width
	end

	self._sliderProgress:SetValue(progress)
end

function M:_onClickToDark()
	local clearCount = ClimbingTowerModel.instance:getClearDungeonCount()
	local darkRound = ClimbingTowerDarkModel.instance:getDarkRound()
	local darkRoundCO = ClimbingTowerConfig.instance:getDarkRoundCO(darkRound)

	if clearCount >= self:getDarkSideUnLockCondition() and darkRoundCO and not darkRoundCO:isExpired() then
		ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)

		if self._animSwitch then
			self._animSwitch:StopTimelineAni()
			self._animSwitch:PlayAniByName("dituqiehuan01")
		end

		GlobalDispatcher:dispatchEvent(EventType.ENTERY_DARKSIDE)
		goutil.setActive(self._climbingBrightPanel.gameObject, false)
		settimer(35 * Time.deltaTime, self._toOther, self, false)
	elseif darkRoundCO and darkRoundCO:isExpired() then
		FloatWordMgr.instance:show(lang("tip_dark_not_work"))
	else
		FloatWordMgr.instance:show(string.format(lang("tip_dark_can_not_enter"), self:getDarkSideUnLockCondition()))
	end
end

function M:_toOther()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
	goutil.setActive(self._climbingPreview.gameObject, false)
end

return M
