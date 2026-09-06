-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgTeamView.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgTeamView", package.seeall)

local NuoYaSisterClgTeamView = class("NuoYaSisterClgTeamView", ViewComponent)

function NuoYaSisterClgTeamView:ctor()
	NuoYaSisterClgTeamView.super.ctor(self)
end

function NuoYaSisterClgTeamView:unbindEvents()
	NuoYaSisterClgTeamView.super.unbindEvents(self)
	InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):RemoveLuaHandler(self._onInputSearchValueChangedHandler)
end

function NuoYaSisterClgTeamView:bindEvents()
	NuoYaSisterClgTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnBag, self._onClickBag, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._Btn_Attr, self._onClickAttr, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._btnClear, self._onClickClear, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	self._onInputSearchValueChangedHandler = InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):AddLuaHandler(function(go, text)
		self:_onSearchTextChanged(text)
	end)
end

function NuoYaSisterClgTeamView:buildUI()
	NuoYaSisterClgTeamView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnBag = self:getGo("btnBag")
	self._btnBuff = self:getGo("btnBuff")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._Nego_Right = self:getGo("Nego_Right")
	self._petTableView = self:getGo("Nego_Right/petTableView")
	self._Btn_Attr = self:getGo("Nego_Right/Nego_Popup/Btn_Attr")
	self._InputC_Search = goutil.findChild(self._Nego_Right, "InputC_Search"):GetComponent("InputField")
	self._btnClear = goutil.findChild(self._Nego_Right, "InputC_Search/BtnClear")
	self._btnSort = self:getGo("Nego_Right/btnSort")
	self._petTableCell = self:getGo("petTableCell")
	self._petTableList = ScrollerList.create(self._petTableView, self._petTableCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._teamTableview = self:getGo("teamTableview")
	self._teamInfoCell = self:getGo("teamInfoCell")
	self._teamTableList = ScrollerList.create(self._teamTableview, self._teamInfoCell, GameUtil.handler(self._updateTeamInfoCell, self), GameUtil.handler(self._clearTeamInfoCell, self))
	self._teamCell = self:getGo("teamCell")
end

function NuoYaSisterClgTeamView:onExit()
	NuoYaSisterClgTeamView.super.onExit(self)

	for i, v in pairs(self._teamPetTableListMap) do
		v:dispose()
	end

	self._teamPetTableListMap = {}

	self._teamTableList:dispose()
	self._petTableList:dispose()
	NuoYaSisterClgModel.instance:saveTempSelectTeam(self._selectTeamPet)
end

function NuoYaSisterClgTeamView:onEnter()
	NuoYaSisterClgTeamView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_NuoYaSisterExtremeClgInfoRes, self._PM_NuoYaSisterExtremeClgInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_NuoYaSisterExtremeClgSeletPetRes, self._PM_NuoYaSisterExtremeClgSeletPetRes, self)
	self.addGEvent(self, GlobalNotify.NuoYaSisterExtremeClgRemoveTeamPet, self._onRemovePetByDetail, self)

	self._activityId = self:getFirstParam()
	self._activityCfg = NuoYaSisterClgConfig.instance:getActivityCfg(self._activityId)
	self._SearchText = ""
	self._selectTeamId = 1
	self._teamPetTableListMap = {}

	self:_initAllPetList()
	self:_refreshView()
end

function NuoYaSisterClgTeamView:_refreshView()
	self:_refreshTeamList()
	self:_refreshPetList()
end

function NuoYaSisterClgTeamView:_refreshTeamList()
	local list = NuoYaSisterClgConfig.instance:getExtremeClgTypes(self._activityId)

	self._teamTableList:reloadData(list)
end

function NuoYaSisterClgTeamView:_updateTeamInfoCell(view, cell, data, tag)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")
	local petTableView = goutil.findChild(go, "tableview")
	local btnShow = goutil.findChild(go, "btnShow")
	local txtNames = goutil.findChild(go, "name")
	local txtCount = goutil.findChildTextComponent(go, "txtCount")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local emptyGo = goutil.findChild(go, "empty")
	local petTableList = self._teamPetTableListMap[go]

	if not petTableList and self._teamCell and petTableView then
		self._teamPetTableListMap[go] = ScrollerList.create(petTableView, self._teamCell, GameUtil.handler(self._updateTeamPetCell, self), GameUtil.handler(self._clearTeamPetCell, self))
		petTableList = self._teamPetTableListMap[go]
	end

	local teamList = self:_getTeamList(data.typeId)
	local resultList = {}

	for i, v in ipairs(teamList) do
		table.insert(resultList, {
			teamId = data.typeId,
			petMo = v
		})
	end

	GameUtil.SetActive(emptyGo, #resultList <= 0)

	txtCount.text = langPara("%d/%d", #resultList, self._activityCfg.petLimit)

	for i = #resultList + 1, 5 do
		table.insert(resultList, {
			teamId = data.typeId
		})
	end

	petTableList:reloadData(resultList)

	for i = 1, txtNames.transform.childCount do
		local nameGo = goutil.findChild(txtNames, "txtName_" .. i)

		GameUtil.SetActive(nameGo, i == data.typeId)
	end

	GameUtil.SetActive(imgSelect, data.typeId == self._selectTeamId)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickTeamSelect(data.typeId)
	end)
	GameUtil.addClickHandler(btnShow, function()
		self:_onClickShowTeamPet(data.typeId)
	end)
end

function NuoYaSisterClgTeamView:_clearTeamInfoCell(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")
	local petTableView = goutil.findChild(go, "tableview")
	local btnShow = goutil.findChild(go, "btnShow")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtCount = goutil.findChildTextComponent(go, "txtCount")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local petTableList = self._teamPetTableListMap[go]

	if petTableList then
		petTableList:dispose()

		self._teamPetTableListMap[go] = nil
	end
end

function NuoYaSisterClgTeamView:_updateTeamPetCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(go)

	if data.petMo then
		local proxy = MaterialMgr.setCellByMo(data.petMo, con)

		if proxy then
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				self:_onClickTeamPet(data)
			end)
		end
	else
		GameUtil.addClickHandler(go, function()
			self:_onClickTeamPet(data)
		end, self)
	end
end

function NuoYaSisterClgTeamView:_clearTeamPetCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function NuoYaSisterClgTeamView:_refreshPetList()
	self:setCurViewDatas()

	if FormationController.instance:checkCanSort(self._curViewDatas) then
		local names, opt = BagModel.instance:GetSortParms()

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._petTableList:reloadData(self._curViewDatas)
end

function NuoYaSisterClgTeamView:getAllShowPetList()
	return self._allPetList or {}
end

function NuoYaSisterClgTeamView:_initAllPetList()
	self._selectTeamPet = NuoYaSisterClgModel.instance:getTempSelectTeam() or {}
	self._selectTeamPetList = {}

	for i, v in pairs(self._selectTeamPet) do
		self._selectTeamPetList[i] = self._selectTeamPetList[i] or {}

		for k, petMo in pairs(v) do
			table.insert(self._selectTeamPetList[i], petMo)
		end
	end

	local list = NuoYaSisterClgConfig.instance:getExtremeClgTypes(self._activityId)

	for i, v in ipairs(list) do
		local teamInfo = NuoYaSisterClgModel.instance:getTeamInfo(self._activityId, v.typeId)

		if teamInfo and teamInfo.pets then
			self._selectTeamPet[v.typeId] = {}

			for j, petId in ipairs(teamInfo.pets) do
				local petMo = BagPetsController.instance:getPet(petId)

				self:_addTeamPet(v.typeId, petMo)
			end
		end
	end

	NuoYaSisterClgModel.instance:resetTeamInfoMap(self._activityId)

	self._allPetList = BagPetsController.instance:getFightBagPet()
end

function NuoYaSisterClgTeamView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local isHit = false

	isHit = self:_isMatch(petCo, pet.rare, pet.curFaceId)

	if not string.nilorempty(self._SearchText) then
		local str = StringUtil.RelpaceEscapeChar(self._SearchText)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function NuoYaSisterClgTeamView:setCurViewDatas()
	self._curViewDatas = {}

	local pets = self:getAllShowPetList()

	for k, v in pairs(pets) do
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end
end

function NuoYaSisterClgTeamView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_FMT_RIGHT, cfg, rare, skinId)
end

function NuoYaSisterClgTeamView:_getPosAndSizeDelta(go)
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

function NuoYaSisterClgTeamView:updateFilterData(starList, jobList, rareList)
	self:_refreshPetList()
end

function NuoYaSisterClgTeamView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	for i = 1, 2 do
		local teamTagGo = goutil.findChild(go, "top/teamSetCell_" .. i)

		GameUtil.SetActive(teamTagGo, self:_isInTeamByRace(i, data) == true)
	end

	local proxy = MaterialMgr.setCellByMo(data, con)

	if proxy then
		proxy.binder:setCallBack(function()
			self:_onClickPet(data)
		end)
	end
end

function NuoYaSisterClgTeamView:_clearPetCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function NuoYaSisterClgTeamView:_addTeamPet(teamId, petMo)
	self._selectTeamPet[teamId] = self._selectTeamPet[teamId] or {}
	self._selectTeamPet[teamId][petMo.raceId] = petMo
	self._selectTeamPetList[teamId] = self._selectTeamPetList[teamId] or {}

	local isFind = false

	for i, v in ipairs(self._selectTeamPetList[teamId]) do
		if petMo.raceId == v.raceId then
			isFind = true

			break
		end
	end

	if not isFind then
		table.insert(self._selectTeamPetList[teamId], 1, petMo)
	end
end

function NuoYaSisterClgTeamView:_removePet(teamId, petMo)
	self._selectTeamPet[teamId] = self._selectTeamPet[teamId] or {}
	self._selectTeamPet[teamId][petMo.raceId] = nil
	self._selectTeamPetList[teamId] = self._selectTeamPetList[teamId] or {}

	local findIndex = 0

	for i, v in ipairs(self._selectTeamPetList[teamId]) do
		if petMo.raceId == v.raceId then
			findIndex = i

			break
		end
	end

	if findIndex > 0 then
		table.remove(self._selectTeamPetList[teamId], findIndex)
	end
end

function NuoYaSisterClgTeamView:_isInTeam(teamId, petMo)
	self._selectTeamPet[teamId] = self._selectTeamPet[teamId] or {}

	if self._selectTeamPet[teamId] and self._selectTeamPet[teamId][petMo.raceId] and self._selectTeamPet[teamId][petMo.raceId].petId == petMo.petId then
		return true
	else
		return false
	end
end

function NuoYaSisterClgTeamView:_isInTeamByRace(teamId, petMo)
	self._selectTeamPet[teamId] = self._selectTeamPet[teamId] or {}

	if self._selectTeamPet[teamId] and self._selectTeamPet[teamId][petMo.raceId] then
		return true
	else
		return false
	end
end

function NuoYaSisterClgTeamView:_getTeamList(teamId)
	return self._selectTeamPetList[teamId] or {}
end

function NuoYaSisterClgTeamView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnSort.gameObject)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self._refreshPetSort, self))
end

function NuoYaSisterClgTeamView:_refreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())
	self:_rankNow()
end

function NuoYaSisterClgTeamView:_rankNow()
	if FormationController.instance:checkCanSort(self._curViewDatas) then
		local names, opt = BagModel.instance:GetSortParms()

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._petTableList:reloadData(self._curViewDatas)
end

function NuoYaSisterClgTeamView:_onClickAttr()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._Btn_Attr.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_FMT_RIGHT, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function NuoYaSisterClgTeamView:_onClickSure()
	local teamPetList = {}
	local isFull = true
	local isHavePet = true

	for i = 1, 2 do
		teamPetList[i] = self:_getTeamList(i)

		if #teamPetList[i] < self._activityCfg.petLimit then
			isFull = false
		end

		if #teamPetList[i] <= 0 then
			isHavePet = false
		end
	end

	if not isHavePet then
		FloatWordMgr.instance:show(lang("两支队伍至少各上1只精灵才能进入挑战"))

		return
	end

	local content = lang("进入关卡后不可修改精灵，是否进入")

	TipsFacade.instance:openPopupWindow(lang("提示"), (isFull == false or nil) and lang("精灵编队未满员，将会影响整体实力，进入关卡后不可再编队，是否确认进入"), function()
		NuoYaSisterClgController.instance:sendPM_NuoYaSisterExtremeClgSeletPetReq(self._activityId, teamPetList)
	end)
end

function NuoYaSisterClgTeamView:_onClickBuff()
	UIStateManager.instance:push(ViewName.NuoYaSisterClgBuffView, self._activityId)
end

function NuoYaSisterClgTeamView:_onClickBag()
	UIStateManager.instance:push(ViewName.PetView)
end

function NuoYaSisterClgTeamView:_onSearchTextChanged(text)
	if text ~= self._SearchText then
		self._SearchText = text

		self:_refreshPetList()
	end
end

function NuoYaSisterClgTeamView:_onClickClear()
	self._InputC_Search.text = ""
end

function NuoYaSisterClgTeamView:_onClickPet(petMo)
	local isInAnyTeam = 0

	for i = 1, 2 do
		if self:_isInTeamByRace(i, petMo) then
			isInAnyTeam = i

			break
		end
	end

	if isInAnyTeam == 0 then
		if #self:_getTeamList(self._selectTeamId) < self._activityCfg.petLimit then
			self:_addTeamPet(self._selectTeamId, petMo)
		else
			FloatWordMgr.instance:show(lang("队伍已满"))
		end
	elseif isInAnyTeam > 0 and not self:_isInTeamByRace(self._selectTeamId, petMo) then
		if self._selectTeamId == isInAnyTeam then
			FloatWordMgr.instance:show(lang("不可上阵相同精灵"))
		else
			FloatWordMgr.instance:show(lang("已经在别的队伍中"))
		end
	elseif self:_isInTeamByRace(self._selectTeamId, petMo) then
		self:_removePet(self._selectTeamId, petMo)
	end

	self:_refreshView()
end

function NuoYaSisterClgTeamView:_onClickTeamPet(petInfo)
	local petMo = petInfo.petMo

	if petMo and petInfo.teamId == self._selectTeamId then
		self:_removePet(petInfo.teamId, petMo)
	else
		self._selectTeamId = petInfo.teamId
	end

	self:_refreshView()
end

function NuoYaSisterClgTeamView:_onClickTeamSelect(teamId)
	self._selectTeamId = teamId

	self:_refreshTeamList()
end

function NuoYaSisterClgTeamView:_onClickShowTeamPet(teamId)
	local petList = self:_getTeamList(teamId)

	UIStateManager.instance:push(ViewName.NuoYaSisterClgTeamPetView, self._activityId, teamId, petList)
end

function NuoYaSisterClgTeamView:_onRemovePetByDetail(teamId, petId)
	local petMo = BagPetsController.instance:getPet(petId)

	self:_removePet(teamId, petMo)
	self:_refreshView()
end

function NuoYaSisterClgTeamView:_PM_NuoYaSisterExtremeClgInfoRes()
	local isTeam = NuoYaSisterClgModel.instance:IsInitTeam(self._activityId)

	if isTeam then
		self:close()
		UIStateManager.instance:push(ViewName.NuoYaSisterClgExtremeView, self._activityId)
	end
end

function NuoYaSisterClgTeamView:_PM_NuoYaSisterExtremeClgSeletPetRes()
	self:close()
	UIStateManager.instance:push(ViewName.NuoYaSisterClgExtremeView, self._activityId)
end

return NuoYaSisterClgTeamView
