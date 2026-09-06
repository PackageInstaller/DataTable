-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/repairchannel/view/RepairChannelDetailView.lua

module("logic.extensions.repairchannel.view.RepairChannelDetailView", package.seeall)

local RepairChannelDetailView = class("RepairChannelDetailView", ViewComponent)
local BranchCellCount = 2

function RepairChannelDetailView:ctor()
	RepairChannelDetailView.super.ctor(self)
end

function RepairChannelDetailView:unbindEvents()
	RepairChannelDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSort)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnClear)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnOneKey)
	self._InputSearch:RemoveOnValueChanged()
end

function RepairChannelDetailView:bindEvents()
	RepairChannelDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickBtnSort, self)
	GameUtil.addClickHandler(self._btnClear, self._onClickBtnClear, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickBtnFilter, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickBtnOneKey, self)
	self._InputSearch:AddOnValueChanged(self._onValueChanged, self)
end

function RepairChannelDetailView:buildUI()
	RepairChannelDetailView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._conPassPrize = self:getGo("passPrize/con")
	self._markGeted = self:getGo("passPrize/markGeted")
	self._btnStart = self:getGo("btnStart")
	self._btnOneKey = self:getGo("btnOneKey")

	local goCellNode = self:getGo("node/tableview/tablecell")
	local goTableviewNode = self:getGo("node/tableview")

	self._tableViewNode = ScrollerList.create(goTableviewNode, goCellNode, GameUtil.handler(self._updateCellNode, self), GameUtil.handler(self._clearCellNode, self))
	self._btnSort = self:getGo("pet/btnSort")
	self._btnFilter = self:getGo("pet/btnFilter")
	self._btnClear = self:getGo("pet/InputSearch/BtnClear")
	self._InputSearch = self:getInput("pet/InputSearch")

	local goTableviewPet = self:getGo("pet/tableviewPet")
	local goCellPet = self:getGo("pet/tablecellPet")

	self._tableViewPet = ScrollerList.create(goTableviewPet, goCellPet, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))
	self._markEmpty = self:getGo("pet/markEmpty")

	local goTableviewSelect = self:getGo("select/tableview")
	local goCellSelect = self:getGo("select/tableview/tablecell")

	self._tableViewSelect = ScrollerList.create(goTableviewSelect, goCellSelect, GameUtil.handler(self._updateCellSelect, self), GameUtil.handler(self._clearCellSelect, self))

	local goTableviewCondition = self:getGo("condition/tableview")
	local goCellCondition = self:getGo("condition/tableview/tablecell")

	self._tableViewCondition = ScrollerList.create(goTableviewCondition, goCellCondition, GameUtil.handler(self._updateCellCondition, self), GameUtil.handler(self._clearCellCondition, self))
	self._txtCondition = self:getTxt("condition/title/txt")
end

function RepairChannelDetailView:onExit()
	RepairChannelDetailView.super.onExit(self)
	MaterialMgr.resetAll(self._conPassPrize)
	self._tableViewNode:dispose()
	self._tableViewPet:dispose()
	self._tableViewSelect:dispose()
	self._tableViewCondition:dispose()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_FMT_RIGHT)

	self._curSortPetMolist = nil
end

function RepairChannelDetailView:onEnter()
	RepairChannelDetailView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_RepairChannelGetInfoRes, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_RepairChannelRepairNodeRes, self._handleRepairSuc, self)

	local param = self:getOpenParam() or {}

	self._activityId = checknumber(param[1])

	if self._activityId == 0 then
		self._activityId = RepairChannelController.instance:getDefaultActivityId() or 0
	end

	self._enterNodeCfg = param[2]
	self._curSelectData = nil

	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_FMT_RIGHT)

	self._curSearchText = nil

	self:_updateUIByCfg()
	self:_refreshPetList(true)
	self:_updateUIByInfo()
	RepairChannelController.instance:getInfo(self._activityId)
end

function RepairChannelDetailView:_updateUIByCfg()
	self._actCfg = RepairChannelConfig.instance:getActCfgByActId(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local branchCount = RepairChannelConfig.instance:getBranchCountByActId(self._activityId)

	self._branchNodeCountMap = {}

	for branchId = 1, branchCount do
		local nodeCfgList = RepairChannelConfig.instance:getNodeCfgsByBranchId(self._activityId, branchId) or {}

		self._branchNodeCountMap[branchId] = #nodeCfgList
	end

	self._nodeCfgList = RepairChannelConfig.instance:getNodeCfgListByActId(self._activityId) or {}
	self._nodeConditionIdListMap = {}

	for _, nodeCfg in ipairs(self._nodeCfgList) do
		if not nodeCfg.conditionIds then
			local sortList = {}

			for _, conditionId in ipairs(nodeCfg.conditionIds) do
				table.insert(sortList, conditionId)
			end

			table.sort(sortList, function(a, b)
				local aCount = RepairChannelConfig.instance:getConditionPetCountById(a) or 0
				local bCount = RepairChannelConfig.instance:getConditionPetCountById(b) or 0

				return bCount < aCount
			end)

			self._nodeConditionIdListMap[nodeCfg] = sortList
		end
	end

	self._maxNeedCount = 1
	self._teamList = {}
	self._teamMap = {}

	if branchCount > BranchCellCount then
		printError("分支数量超过预设上限，当前分支数量:", branchCount, "预设上限:", BranchCellCount)
		self:close()

		return
	end
end

function RepairChannelDetailView:_updateUIByInfo()
	self._repairProgressMap = RepairChannelModel.instance:getBranchProgressMap(self._activityId) or {}
end

function RepairChannelDetailView:_handleGetInfo()
	self:_updateUIByInfo()

	if self._enterNodeCfg then
		self:_switchCurSelectData(self._enterNodeCfg, true)
	else
		local firstData

		for _, nodeCfg in ipairs(self._nodeCfgList) do
			local branchId = nodeCfg.branchId
			local nodeId = nodeCfg.nodeId

			if not self._repairProgressMap[branchId] then
				if self._repairProgressMap[branchId] < nodeId then
					firstData = nodeCfg

					break
				end
			end
		end

		if firstData then
			self:_switchCurSelectData(firstData, true)
		else
			self:_switchCurSelectData(self._nodeCfgList[1], true)
		end
	end
end

function RepairChannelDetailView:_handleRepairSuc()
	self:_updateUIByInfo()

	local firstData

	for _, nodeCfg in ipairs(self._nodeCfgList) do
		local branchId = nodeCfg.branchId
		local nodeId = nodeCfg.nodeId

		if not self._repairProgressMap[branchId] then
			if self._repairProgressMap[branchId] < nodeId then
				firstData = nodeCfg

				break
			end
		end
	end

	if firstData then
		self:_switchCurSelectData(firstData, true)
	else
		self:_switchCurSelectData(self._nodeCfgList[#self._nodeCfgList], true)
	end
end

function RepairChannelDetailView:_switchCurSelectData(data, isForce)
	if isForce then
		self._curSelectData = nil
	end

	if self._curSelectData == data then
		return
	end

	self._curSelectData = data
	self._teamMap = self._teamMap or {}

	table.clear(self._teamMap)
	self:_refreshTeamDataList()

	if not self._curSelectData then
		return
	end

	local branchId = data.branchId
	local nodeId = data.nodeId

	if not self._repairProgressMap[branchId] then
		local progress = 0
		local isGeted = nodeId <= progress

		MaterialMgr.resetAll(self._conPassPrize)

		if not data.prize then
			MaterialMgr.setCellByCfg(data.prize, self._conPassPrize)
			goutil.setActive(self._markGeted, isGeted)

			self._txtCondition.text = langPara("修复—%s", data.nodeName or "")
			self._maxNeedCount = self._curSelectData.dispatchNum or 1

			self._tableViewNode:reloadData(self._nodeCfgList)

			local showId = 1

			for i, cfg in ipairs(self._nodeCfgList) do
				if data == cfg then
					showId = i

					break
				end
			end

			self._tableViewNode:MoveCellToBegin(showId - 1)
			self:_refreshPetList(true)
			self:_refreshTeamDataList()
			self:_refreshConditionList()

			local canRepair = not isGeted and nodeId == progress + 1

			goutil.setActive(self._btnStart, canRepair)
			goutil.setActive(self._btnOneKey, canRepair)
		end
	end
end

function RepairChannelDetailView:_refreshTeamDataList()
	self._teamList = self._teamList or {}

	table.clear(self._teamList)

	local curAddCount = 0

	for petId, isSelected in pairs(self._teamMap) do
		if isSelected and curAddCount < self._maxNeedCount then
			curAddCount = curAddCount + 1
			self._teamList[curAddCount] = petId
		end
	end

	for i = curAddCount + 1, self._maxNeedCount do
		self._teamList[i] = 0
	end

	self._tableViewSelect:reloadData(self._teamList)
end

function RepairChannelDetailView:_refreshConditionList()
	if self._curSelectData then
		if not self._curSelectData.conditionIds then
			local conditionIdList = {}

			self._tableViewCondition:reloadData(conditionIdList)
		end
	end
end

function RepairChannelDetailView:_onClickNode(data)
	if not data then
		return
	end

	self:_switchCurSelectData(data)
end

function RepairChannelDetailView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function RepairChannelDetailView:_onClickBtnStart()
	if not self._curSelectData then
		return
	end

	local branchId = self._curSelectData.branchId
	local nodeId = self._curSelectData.nodeId
	local teamIdList = {}

	for _, petId in pairs(self._teamList) do
		if petId and checknumber(petId) ~= 0 then
			table.insert(teamIdList, checknumber(petId))
		end
	end

	if #teamIdList < self._maxNeedCount then
		TipsFacade.instance:openCommonTips(langPara("请至少至少选择%s只精灵", self._maxNeedCount))

		return
	end

	if self._curSelectData then
		if not self._curSelectData.conditionIds then
			local conditionIdList = {}

			for _, conditionId in ipairs(conditionIdList) do
				local resultCount, needCount = self:_checkConditionCount(conditionId)

				if resultCount < needCount then
					TipsFacade.instance:openCommonTips("当前队伍不满足修复条件")

					return
				end
			end

			RepairChannelController.instance:repairNode(self._activityId, branchId, nodeId, teamIdList)
		end
	end
end

function RepairChannelDetailView:_onClickBtnOneKey()
	if not self._curSelectData then
		return
	end

	local curRecommendPetIds = self:_getOneKeyRecommendPetList()

	table.clear(self._teamMap)
	table.clear(self._teamList)

	for index, petmo in ipairs(curRecommendPetIds) do
		if index <= self._maxNeedCount then
			self._teamMap[petmo.petId] = true
		end
	end

	self:rankNow()
	self:_refreshTeamDataList()
	self:_refreshConditionList()

	if #curRecommendPetIds < self._maxNeedCount then
		TipsFacade.instance:openCommonTips("暂无可放入的精灵，可前往召唤或精灵挑战等途径获得")
	end
end

function RepairChannelDetailView:_updateCellNode(view, cell, data)
	local go = cell.gameObject
	local branchId = data.branchId
	local nodeId = data.nodeId

	if not self._repairProgressMap[branchId] then
		local progress = 0
		local isPass = nodeId <= progress
		local isSelect = self._curSelectData == data
		local markSelect = goutil.findChild(go, "markSelect")

		goutil.setActive(markSelect, isSelect)

		for i = 1, BranchCellCount do
			local btnRepair = goutil.findChild(go, string.format("btnRepair%s", i))
			local txt = goutil.findChildTextComponent(btnRepair, "txt")

			txt.text = data.nodeName or ""

			goutil.setActive(btnRepair, i == branchId)
			GameUtil.addClickHandler(btnRepair, GameUtil.handler(self._onClickNode, self, data))
			GameUtil.SetGray(btnRepair, not isPass)
		end
	end
end

function RepairChannelDetailView:_clearCellNode(cell)
	local go = cell.gameObject

	for i = 1, BranchCellCount do
		local btnRepair = goutil.findChild(go, string.format("btnRepair%s", i))

		GameUtil.rmClickHandler(btnRepair)
	end
end

function RepairChannelDetailView:_updateCellSelect(view, cell, data)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local petId = data
	local petMo = BagModel.instance:getPet(petId)

	if petMo then
		local proxy = MaterialMgr.setCellByMo(petMo, con)

		if proxy then
			proxy:setCallBack(function()
				self:_onClickSelectPetCell(petId)
			end)
		end
	else
		MaterialMgr.resetAll(con)
	end
end

function RepairChannelDetailView:_clearCellSelect(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function RepairChannelDetailView:_updateCellCondition(view, cell, data)
	local go = cell.gameObject
	local txtCondition = goutil.findChildTextComponent(go, "txt")
	local conditionId = data
	local conditionDesc = RepairChannelConfig.instance:getConditionDescById(conditionId) or ""
	local resultCount, needCount = self:_checkConditionCount(conditionId)

	txtCondition.text = conditionDesc .. (needCount <= resultCount and string.format("(%s/%s)", resultCount, needCount) or string.format("(<color=red>%s</color>/%s)", resultCount, needCount))
end

function RepairChannelDetailView:_clearCellCondition(cell)
	return
end

function RepairChannelDetailView:_checkConditionCount(conditionId)
	local resultCount = 0
	local needCount = RepairChannelConfig.instance:getConditionPetCountById(conditionId) or 0
	local checkFunc = RepairChannelConfig.instance:getConditionSortCheckFuncById(conditionId)

	self._teamList = self._teamList or {}

	for _, petId in pairs(self._teamList) do
		local petMo = BagModel.instance:getPet(petId)

		if petMo and checkFunc(petMo) then
			resultCount = resultCount + 1
		end
	end

	return resultCount, needCount
end

function RepairChannelDetailView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	local viewPos = uiCamera:ScreenToViewportPoint(pos)

	if viewPos.x < 0.5 and viewPos.y < 0.5 then
		pos.x = pos.x - 50
		pos.y = pos.y + 120
	end

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function RepairChannelDetailView:_onClickBtnClear()
	self._InputSearch:SetText("")
end

function RepairChannelDetailView:_onClickBtnFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_FMT_RIGHT, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function RepairChannelDetailView:updateFilterData(starList, jobList, rareList)
	self:_refreshPetList(true)
end

function RepairChannelDetailView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_FMT_RIGHT, cfg, rare, skinId)
end

function RepairChannelDetailView:_onClickBtnSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnSort)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self._RefreshPetSort, self))
end

function RepairChannelDetailView:_onValueChanged()
	if self._InputSearch:GetText() ~= self._curSearchText then
		self._curSearchText = self._InputSearch:GetText()

		self:_refreshPetList(true)
	end
end

function RepairChannelDetailView:onFilter(pet)
	if not pet then
		return false
	end

	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)

	if not petCo then
		return false
	end

	local isHit = false

	isHit = self:_isMatch(petCo, pet.rare, pet.curFaceId)

	if not string.nilorempty(self._curSearchText) then
		local str = StringUtil.RelpaceEscapeChar(self._curSearchText)

		if petCo then
			if not petCo.name then
				local petName = ""
				local count = string.find(petName, str)

				if not count then
					isHit = false
				end
			end
		end
	end

	if isHit then
		if self._curSelectData then
			if not self._curSelectData.conditionIds then
				local conditionIdList = {}
				local isCheckCondition = #conditionIdList > 0

				if isCheckCondition then
					local isMatchCondition = false

					for _, conditionId in ipairs(conditionIdList) do
						local checkFunc = RepairChannelConfig.instance:getConditionSortCheckFuncById(conditionId)

						if checkFunc and checkFunc(pet) then
							isMatchCondition = true

							break
						end
					end

					if not isMatchCondition then
						isHit = false
					end
				end
			end
		end
	end

	return isHit
end

function RepairChannelDetailView:_refreshPetList(isForce)
	if isForce then
		self._curShowPetList = nil
	end

	self._curShowPetList = self._curShowPetList or self:_getCurShowPetList()

	self:rankNow()
end

function RepairChannelDetailView:_getCurShowPetList()
	local petList = BagPetsController.instance:getBagPets()
	local showList = {}

	for _, pet in ipairs(petList) do
		if self:onFilter(pet) then
			table.insert(showList, pet)
		end
	end

	return showList
end

function RepairChannelDetailView:_RefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())
	self:rankNow()
end

function RepairChannelDetailView:rankNow()
	if FormationController.instance:checkCanSort(self._curShowPetList) then
		local names, opt = self:GetSortParms()

		ArraySort.sortOn(self._curShowPetList, names, opt)
		goutil.setActive(self._markEmpty, #self._curShowPetList <= 0)
		self._tableViewPet:reloadData(self._curShowPetList)
	end
end

function RepairChannelDetailView:GetSortParms()
	local parm1 = {}
	local parm2 = {}
	local sortName
	local sortValue = BagModel.instance:GetSortState()

	for k, v in ipairs(sortValue) do
		local vArr = BagModel.SORT_VALUE[k]

		if vArr[v + 1] ~= -1 then
			table.insert(parm1, BagModel.SORT_NAME[k])
			table.insert(parm2, vArr[v + 1])
		end
	end

	return parm1, parm2
end

function RepairChannelDetailView:_updateCellPet(view, cell, data)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local markSelected = goutil.findChild(go, "selected")
	local proxy = MaterialMgr.setCellByMo(data, con)
	local petId = data.petId

	if proxy then
		proxy.binder:showStarByCustom(data.awakeLevel)
		proxy:setCallBack(function()
			self:_onClickSelectPetCell(petId)
		end)
	end

	if not self._teamMap[petId] then
		local isSelected = false

		goutil.setActive(markSelected, isSelected)
	end
end

function RepairChannelDetailView:_clearCellPet(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function RepairChannelDetailView:_onClickSelectPetCell(petId)
	if not self._teamMap[petId] then
		if self._teamMap[petId] then
			self._teamMap[petId] = nil
		else
			local curCount = 0

			for _, isSelected in pairs(self._teamMap) do
				if isSelected then
					curCount = curCount + 1
				end
			end

			if curCount >= self._maxNeedCount then
				TipsFacade.instance:openCommonTips(lang("已达到最大选择数量"))

				return
			end

			self._teamMap[petId] = true
		end

		self:_refreshPetList()
		self:_refreshTeamDataList()
		self:_refreshConditionList()
	end
end

function RepairChannelDetailView:_getOneKeyRecommendPetList()
	if self._curSelectData then
		if not self._nodeConditionIdListMap[self._curSelectData] then
			local conditionIdList = {}
			local sortFuncList = {}

			for _, conditionId in ipairs(conditionIdList) do
				local checkFunc = RepairChannelConfig.instance:getConditionSortCheckFuncById(conditionId)

				if checkFunc then
					table.insert(sortFuncList, checkFunc)
				end
			end

			self._curSortPetMolist = self._curSortPetMolist or {}

			table.clear(self._curSortPetMolist)

			if not self._curShowPetList then
				local petList = {}

				for _, pet in ipairs(petList) do
					table.insert(self._curSortPetMolist, pet)
				end

				local needCountMap = {}

				for _, conditionId in ipairs(conditionIdList) do
					needCountMap[conditionId] = RepairChannelConfig.instance:getConditionPetCountById(conditionId) or 0
				end

				local curResultCountMap = {}

				for _, conditionId in ipairs(conditionIdList) do
					curResultCountMap[conditionId] = 0
				end

				local curResultMoMap = {}
				local funcParms = {}

				for _, checkFunc in ipairs(sortFuncList) do
					table.insert(funcParms, function(pet)
						return checkFunc(pet) and 0 or 1
					end)
				end

				local sortParms = {}

				for i = 1, #funcParms do
					table.insert(sortParms, ArraySort.NUMERIC)
				end

				ArraySort.sortOn(self._curSortPetMolist, funcParms, sortParms)

				local recommendList = {}

				for _, petMo in ipairs(self._curSortPetMolist) do
					local petId = petMo.petId

					for _id, checkFunc in ipairs(sortFuncList) do
						if not curResultMoMap[petId] and checkFunc(petMo) then
							local conditionId = conditionIdList[_id]

							if not needCountMap[conditionId] then
								if not curResultCountMap[conditionId] then
									local curCount = 0

									if curCount < needCountMap[conditionId] then
										table.insert(recommendList, petMo)

										curResultCountMap[conditionId] = curCount + 1
										curResultMoMap[petId] = petMo

										break
									end
								end
							end
						end
					end

					if #recommendList >= self._maxNeedCount then
						break
					end
				end

				if #recommendList < self._maxNeedCount then
					local startId = #recommendList + 1

					for i = startId, self._maxNeedCount do
						local petMo = self._curSortPetMolist[i]

						if petMo then
							table.insert(recommendList, petMo)
						end
					end
				end

				return recommendList
			end
		end
	end
end

return RepairChannelDetailView
