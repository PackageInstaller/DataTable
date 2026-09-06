-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandVerifyFormView.lua

module("logic.extensions.newhandwelfare.view.NewHandVerifyFormView", package.seeall)

local NewHandVerifyFormView = class("NewHandVerifyFormView", ViewComponent)

function NewHandVerifyFormView:ctor()
	NewHandVerifyFormView.super.ctor(self)
end

function NewHandVerifyFormView:buildUI()
	NewHandVerifyFormView.super.buildUI(self)

	self._petCol = self:getGo("petCol")
	self._petCells = {}
	self._selectPetIdxs = {}
	self._skinIds = {}

	for teamIndex = 1, self._petCol.transform.childCount do
		local mainGo = self._petCol.transform:GetChild(teamIndex - 1).gameObject
		local teamId = checknumber(string.match(mainGo.name, "team_([0-9]+)"))
		local cell = {}

		cell._mainGo = mainGo
		cell._pets = GameUtil.getChildren(mainGo)
		cell._imgSelects = {}
		self._skinIds[teamId] = {}

		for index, petGo in ipairs(cell._pets) do
			cell._imgSelects[petGo] = petGo.transform:GetChild(0).gameObject
			self._skinIds[teamId][index] = petGo.name
		end

		self._petCells[teamId] = cell
		self._selectPetIdxs[teamId] = Mathf.Min(1, #cell._pets)
	end

	local teamScrView = self:getGo("teamCol/scrView")
	local teamScrCell = self:getGo("teamCol/scrCell")

	self._teamScrollerList = ScrollerList.create(teamScrView, teamScrCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))

	self._teamScrollerList:setCenterMode(true)

	local tabScrView = self:getGo("collectCol/tabCol/scrView")
	local tabScrCell = self:getGo("collectCol/tabCol/scrCell")

	self._tabScrollerList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	local taskScrView = self:getGo("collectCol/taskCol/scrView")
	local taskScrCell = self:getGo("collectCol/taskCol/scrCell")

	self._taskScrollerList = ScrollerList.create(taskScrView, taskScrCell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._txtLeftTime = self:getTxt("leftTime/txt")
	self._txtMaxZdl = self:getTxt("maxZdl/txt")
	self._btnVerify = self:getGo("btnVerify")
	self._petInfo = self:getGo("petInfo")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
end

function NewHandVerifyFormView:bindEvents()
	NewHandVerifyFormView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClikBtnTip, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClikBtnBuff, self)
	GameUtil.addClickHandler(self._btnVerify, self._onClikBtnVerify, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
end

function NewHandVerifyFormView:unbindEvents()
	NewHandVerifyFormView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnVerify)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
end

function NewHandVerifyFormView:onEnter()
	NewHandVerifyFormView.super.onEnter(self)

	self._periodId = NewhandwelfareModel.instance:getPeriodId()

	if self._periodId <= 0 then
		self:close()

		return
	end

	self._teamIndex = self._teamIndex or 1
	self._destTime = NewhandwelfareModel.instance:getHandTimeActEndTime()

	self.addGEvent(self, GlobalNotify.HandleNewHandWelfareGetBoundInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandleNewHandWelfareSubmitFormZdlRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandleNewHandWelfareGainBoundPrizeRes, self._onUpdate, self)
	NewhandwelfareController.instance:sendNewHandWelfareGetBoundInfoReq()
	settimer(1, self._onTickingLeftTime, self, true)
	self:_onTickingLeftTime()
end

function NewHandVerifyFormView:onExit()
	NewHandVerifyFormView.super.onExit(self)
	removetimer(self._onTickingLeftTime, self)
	self:_onClearTeamCol()
	self:_onClearPetCol()
	self:_onClearTaskCol()
end

function NewHandVerifyFormView:_onTickingLeftTime()
	local left = self._destTime - ServerTime.nowServerLook()
	local formatTime = MmUtil.FormatTimeWords(left)

	self._txtLeftTime.text = string.format("剩余时间：%s", formatTime)
end

function NewHandVerifyFormView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function NewHandVerifyFormView:_onUpdateData()
	self._teamIdList = NewhandwelfareConfig.instance:getBondTeamIdsInPeriod(self._periodId)
	self._teamIndex = Mathf.Min(self._teamIndex, #self._teamIdList)
	self._taskInfoLists = {}
	self._bondPrizeTypes = self._bondPrizeTypes or {}

	for teamIndex, teamId in pairs(self._teamIdList) do
		for _, type in ipairs(NewhandwelfareEnum.BondPrizeTypeList) do
			local cfg = NewhandwelfareConfig.instance:getBondPrizeCfg(self._periodId, teamId, type)

			if cfg then
				self._taskInfoLists[teamIndex] = self._taskInfoLists[teamIndex] or {}
				self._taskInfoLists[teamIndex][type] = {}
				self._bondPrizeTypes[teamIndex] = self._bondPrizeTypes[teamIndex] or type

				for _, data in ipairs(cfg) do
					local info = {}

					info.prizeId = data.prizeId
					info.state = self:_getTaskState(data.prizeId)

					table.insert(self._taskInfoLists[teamIndex][type], info)
				end
			end
		end
	end
end

function NewHandVerifyFormView:_onUpdateUI()
	local teamId = checknumber(self._teamIdList[self._teamIndex])
	local maxZdl = NewhandwelfareModel.instance:getTeamMaxZdl(teamId)

	self._txtMaxZdl.text = string.format("历史最高战力：%s", maxZdl)

	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	else
		MaterialMgr.resetAll(self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	GameUtil.SetActive(self._petInfo, skinId > 0)
	self:_onUpdateTeamColUI()
	self:_onUpdatePetColUI()
	self:_onUpdateTaskColUI()
end

function NewHandVerifyFormView:_getTaskState(prizeId)
	local isHasGain = self:_isHasGainPrizeOfTask(prizeId)

	if isHasGain then
		return GameEnum.PrizeState.IsHasGain
	end

	local isEnough = self:_isEnoughProgressOfTask(prizeId)

	if not isEnough then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function NewHandVerifyFormView:_isCanGainOfTask(prizeId)
	return self:_getTaskState(prizeId) == GameEnum.PrizeState.IsCanGet
end

function NewHandVerifyFormView:_isHasGainPrizeOfTask(prizeId)
	return NewhandwelfareModel.instance:isHasGainPrizeInTeam(prizeId)
end

function NewHandVerifyFormView:_isEnoughProgressOfTask(prizeId)
	return NewhandwelfareModel.instance:isEnoughPrizeInTeam(prizeId)
end

function NewHandVerifyFormView:_onUpdateTeamColUI()
	self._teamScrollerList:reloadData(self._teamIdList)
end

function NewHandVerifyFormView:_onClearTeamCol()
	self._teamScrollerList:dispose()
end

function NewHandVerifyFormView:_updateTeamCell(view, cell, teamId, tag)
	local data = NewhandwelfareConfig.instance:getBondTeamData(teamId)
	local index = cell.data
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")

	txtName.text = data.name

	GameUtil.SetActive(imgSelected, self._teamIndex == index)
	GameUtil.addClickHandler(mainGo, function()
		if self._teamIndex ~= index then
			self._teamIndex = index

			self:_onUpdateUI()
		end
	end)
end

function NewHandVerifyFormView:_clearTeamCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function NewHandVerifyFormView:_onUpdatePetColUI()
	local curTeamId = self._teamIdList[self._teamIndex]

	for teamId, cell in pairs(self._petCells) do
		if curTeamId == teamId then
			GameUtil.SetActive(cell._mainGo, true)
			self:_updatePetCell(cell, teamId)
		else
			self:_clearPetCell(cell)
			GameUtil.SetActive(cell._mainGo, false)
		end
	end
end

function NewHandVerifyFormView:_onClearPetCol()
	for _, cell in pairs(self._petCells) do
		self:_clearPetCell(cell)
	end
end

function NewHandVerifyFormView:_updatePetCell(cell, teamId)
	local selectPetIdx = self._selectPetIdxs[teamId]

	for petIdx, petGo in ipairs(cell._pets) do
		local imgSelect = cell._imgSelects[petGo]

		GameUtil.SetActive(imgSelect, selectPetIdx == petIdx)
		GameUtil.addClickHandler(petGo, function()
			if selectPetIdx ~= petIdx then
				self._selectPetIdxs[teamId] = petIdx

				self:_onUpdateUI()
			end
		end)
	end
end

function NewHandVerifyFormView:_clearPetCell(cell)
	for petIdx, petGo in ipairs(cell._pets) do
		GameUtil.rmClickHandler(petGo)
	end
end

function NewHandVerifyFormView:_onUpdateTaskColUI()
	if not self._taskInfoLists[self._teamIndex] then
		local typeList = {}

		for idx, prizeType in ipairs(NewhandwelfareEnum.BondPrizeTypeList) do
			local infoList = self._taskInfoLists[self._teamIndex][prizeType]

			if #infoList > 0 then
				table.insert(typeList, prizeType)
			end
		end

		local curPrizeType = self._bondPrizeTypes[self._teamIndex]

		if curPrizeType and table.indexof(typeList, curPrizeType) == false or curPrizeType == nil then
			self._bondPrizeTypes[self._teamIndex] = #typeList > 0 and typeList[1]
			curPrizeType = self._bondPrizeTypes[self._teamIndex]
		end

		if curPrizeType then
			if not self._taskInfoLists[self._teamIndex][curPrizeType] then
				local taskInfoList = {}

				table.sort(taskInfoList, function(infoA, infoB)
					if infoA.state == infoB.state then
						return infoA.prizeId < infoB.prizeId
					else
						return infoA.state < infoB.state
					end
				end)
				self._tabScrollerList:reloadData(typeList)
				self._taskScrollerList:reloadData(taskInfoList)

				local isNeedVerify = false

				for _, prizeType in pairs(typeList) do
					if prizeType == NewhandwelfareEnum.BondPrizeType_Verify then
						isNeedVerify = true

						break
					end
				end

				GameUtil.SetActive(self._btnVerify, isNeedVerify)
			end
		end
	end
end

function NewHandVerifyFormView:_onClearTaskCol()
	self._tabScrollerList:dispose()
	self._taskScrollerList:dispose()
end

function NewHandVerifyFormView:_updateTabCell(view, cell, prizeType, tag)
	local isCanGet = false

	if not self._taskInfoLists[self._teamIndex][prizeType] then
		for _, info in ipairs(self._taskInfoLists[self._teamIndex][prizeType]) do
			if info.state == GameEnum.PrizeState.IsCanGet then
				isCanGet = true

				break
			end
		end

		local mainGo = cell.gameObject
		local redPoint = goutil.findChild(mainGo, "redPoint")
		local txtName = goutil.findChildTextComponent(mainGo, "txtName")
		local UIChangeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)

		txtName.text = NewhandwelfareEnum.BondPrizeTypeNames[prizeType]

		GameUtil.SetActive(redPoint, isCanGet)
		UIChangeGroup:SetState(self._bondPrizeTypes[self._teamIndex] == prizeType and 1 or 0)
		GameUtil.addClickHandler(mainGo, function()
			if self._bondPrizeTypes[self._teamIndex] ~= prizeType then
				self._bondPrizeTypes[self._teamIndex] = prizeType

				self:_onUpdateUI()
			end
		end)
	end
end

function NewHandVerifyFormView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")

	GameUtil.SetActive(redPoint, false)
	GameUtil.rmClickHandler(mainGo)
end

function NewHandVerifyFormView:_updateTaskCell(view, cell, info, tag)
	local prizeId = info.prizeId
	local state = info.state
	local data = NewhandwelfareConfig.instance:getBondPrizeData(self._periodId, prizeId)
	local prizeType = data.type
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local notEnough = goutil.findChild(mainGo, "notEnough")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local itemScrCell = goutil.findChild(mainGo, "itemScrCell")

	txtTitle.text = data.desc

	if itemScrView and itemScrCell then
		local prizeStrArr = string.split(data.prize, "#")

		self._itemScrollerListDic = self._itemScrollerListDic or {}

		if not self._itemScrollerListDic[mainGo] then
			local itemScrollerList = ScrollerList.create(itemScrView, itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollerListDic[mainGo] = itemScrollerList

			itemScrollerList:reloadData(prizeStrArr)
			itemScrollerList:dragNotifyParent()
		end
	end

	GameUtil.SetActive(btnReceive, state == GameEnum.PrizeState.IsCanGet)
	GameUtil.SetActive(btnGoto, false)
	GameUtil.SetActive(notEnough, false)

	if state == GameEnum.PrizeState.IsNotEnough then
		if prizeType == NewhandwelfareEnum.BondPrizeType_Verify then
			GameUtil.SetActive(btnGoto, true)
		else
			GameUtil.SetActive(btnGoto, not string.nilorempty(data.jumpStr))
		end

		GameUtil.SetActive(notEnough, not GameUtil.GetActive(btnGoto))
	end

	GameUtil.SetActive(receivedGo, state == GameEnum.PrizeState.IsHasGain)
	GameUtil.addClickHandler(btnGoto, function()
		if prizeType == NewhandwelfareEnum.BondPrizeType_Verify then
			self:_onClikBtnVerify()
		elseif not string.nilorempty(data.jumpStr) then
			GotoMgr.gotoByString(data.jumpStr)
		end
	end)
	GameUtil.addClickHandler(btnReceive, function()
		local result = GameEnum.ResultCode.Success
		local tips = ""

		if self:_isHasGainPrizeOfTask(prizeId) then
			result = GameEnum.ResultCode.IsHasGain
			tips = "已领取"
		elseif not self:_isEnoughProgressOfTask(prizeId) then
			result = GameEnum.ResultCode.NotEnoughProgress
			tips = "未满足要求"
		end

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		NewHandWelfareAgent.instance:sendNewHandWelfareGainBoundPrizeReq(prizeId)
	end)
end

function NewHandVerifyFormView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")

	if self._itemScrollerListDic then
		if self._itemScrollerListDic then
			self._itemScrollerListDic:dispose()

			self._itemScrollerListDic[mainGo] = nil
		end

		GameUtil.rmClickHandler(btnGoto)
		GameUtil.rmClickHandler(btnReceive)
	end
end

function NewHandVerifyFormView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function NewHandVerifyFormView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function NewHandVerifyFormView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function NewHandVerifyFormView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function NewHandVerifyFormView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function NewHandVerifyFormView:_getSkinId()
	local teamId = self._teamIdList[self._teamIndex]
	local index = checknumber(self._selectPetIdxs[teamId])

	return checknumber(self._skinIds[teamId][index])
end

function NewHandVerifyFormView:_onClikBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function NewHandVerifyFormView:_onClikBtnBuff()
	local tabInfo = self:_getCurTabInfo()

	if tabInfo then
		if not tabInfo.phaseId then
			local phaseId = 0

			UIStateManager.instance:push(ViewName.JudgmentDragonClgStageResultView, self._activityId, phaseId)
		end
	end
end

function NewHandVerifyFormView:_onClikBtnVerify()
	if not self._teamIdList[self._teamIndex] then
		if self._teamIdList[self._teamIndex] > 0 then
			NewhandwelfareController.instance:enterFormationAsNewHand(self._teamIdList[self._teamIndex])
		end
	end
end

return NewHandVerifyFormView
