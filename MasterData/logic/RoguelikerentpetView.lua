-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikerentpetView.lua

module("logic.extensions.roguelike.view.RoguelikerentpetView", package.seeall)

local RoguelikerentpetView = class("RoguelikerentpetView", ViewComponent)
local filterType = PetFilterMgr.TYPE_ROGUE_LIKE

function RoguelikerentpetView:ctor()
	RoguelikerentpetView.super.ctor(self)
end

function RoguelikerentpetView:unbindEvents()
	RoguelikerentpetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnTip)
	self._inputSearch:RemoveOnValueChanged()
	self._filterButton:RemoveClickListener()
	self._sortButton:RemoveClickListener()
	self._InputC_Search_Clear:RemoveClickListener()

	for i, cell in ipairs(self._cellList) do
		local obj = self._leftDragMap[i]

		DropHandler.Get(cell.gameObject):RemoveLuaHandler(obj.dropHash)
	end
end

function RoguelikerentpetView:bindEvents()
	RoguelikerentpetView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnTip, self.onClickHelp, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._filterButton:AddClickListener(self._onClickFilter, self)
	self._InputC_Search_Clear:AddClickListener(self.onClearSearchClick, self)

	self._leftDragMap = {}

	for i, cell in ipairs(self._cellList) do
		local obj = {}

		obj.dropHash = DropHandler.Get(cell.gameObject):AddLuaHandler(function(_go, eventData)
			self:_onDropDownCell(_go, eventData, cell, i)
		end)
		self._leftDragMap[i] = obj
	end
end

function RoguelikerentpetView:buildUI()
	RoguelikerentpetView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnTip = self:getGo("btnTip")
	self.txtTitle = self:getTxt("info/title/txtTitle")
	self.cell = self:getGo("info/cell")

	GameUtil.SetActive(self.cell, false)

	self.pos = self:getGo("info/pos")
	self.posPlan = self.pos:GetComponent(typeof(TestRecordPos))
	self.tip = self:getGo("info/tip")
	self._cellList = {}

	for i = 1, 3 do
		local cell = self:getGo("info/pos/cell_" .. i)

		table.insert(self._cellList, cell)
	end

	self._inputSearch = self:getInput("petList/InputField")
	self._InputC_Search_Clear = self:getBtn("petList/InputField/btnCancel")
	self._filterButton = self:getBtn("petList/btnFliter")
	self._sortButton = self:getBtn("petList/btnSort")
	self._sortBtnGo = self:getGo("btnSort")
	self.empty = self:getGo("petList/empty")
	self.txtTitlePet = self:getTxt("petList/txtTitle")
	self.tableviewPet = self:getGo("petList/tableview")
	self.pet = self:getGo("petList/pet")
	self._dragObj = self:getGo("dragObj")

	GameUtil.SetActive(self._dragObj, false)

	self.scrollList = ScrollerList.create(self.tableviewPet, self.pet, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))

	self.scrollList:setDragCallBack("top", GameUtil.handler(self._onDragBegin, self), GameUtil.handler(self._onDragMove, self), GameUtil.handler(self._onDragEnd, self))
end

function RoguelikerentpetView:onExit()
	RoguelikerentpetView.super.onExit(self)
	self.scrollList:dispose()
end

function RoguelikerentpetView:onEnter()
	RoguelikerentpetView.super.onEnter(self)

	self._currSearching = nil
	self._activityId = RoguelikeModel.instance:getActivityId()

	local actId = checknumber(self:getFirstParam())

	if actId > 0 then
		self._activityId = actId
	end

	self.addGEvent(self, GlobalNotify.RoguelikeGetInfoRes, self._onRefreshUI, self)
	RoguelikeAgent.instance:sendPM_RoguelikeGetInfoReq(self._activityId)
	self:_onRefreshUI()
end

function RoguelikerentpetView:updateFilterData(starList, jobList, rareList)
	self:_RefreshPetList()
end

function RoguelikerentpetView:_onDragBegin(eventData, data)
	local now = ServerTime.now()
	local cfg = RoguelikeConfig.instance:getRentPetCfg(self._activityId, data.data.petId)
	local releaseTime = cfg.releaseTime
	local timeStart = GameUtil.string2time(releaseTime)

	if now < timeStart then
		return
	end

	GameUtil.SetActive(self._dragObj, true)

	self._dragData = data
	self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()

	MaterialMgr.setIcon(self._dragObj, MatType.Pet, data.data.raceId)
end

function RoguelikerentpetView:_onDragMove(eventData, data)
	if self._hasPet then
		return
	end

	if not self._dragObj then
		return
	end

	self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function RoguelikerentpetView:_onDragEnd(eventData, data)
	if not self._dragObj then
		return
	end

	self._dragData = nil

	MaterialMgr.clearIcon(self._dragObj)
	GameUtil.SetActive(self._dragObj, false)
end

function RoguelikerentpetView:_onDropDownCell(_go, eventData, cell, idx)
	if self._dragData then
		self._rentPetId = self._rentPetId or {}

		local petId = self._dragData.data.petId

		self._dragData = nil

		local lastPos = -1

		for i, v in pairs(self._rentPetId) do
			if v == petId then
				TipsFacade.instance:openCommonTips("该精灵已租借")

				return
			end
		end

		local lastPetId = checknumber(self._rentPetId[idx])

		if lastPetId > 0 then
			TipsFacade.instance:openCommonTips("当前位置只能租借一只精灵")

			return
		end

		if lastPos == -1 then
			RoguelikeAgent.instance:sendPM_RoguelikeSetRentPetUsingOrNotReq(self._activityId, petId, true)
		end

		self._rentPetId[idx] = petId

		self:_refreshLeftUI()
	end
end

function RoguelikerentpetView:_RefreshPetList(force)
	self._curViewDatas = {}

	for k, v in pairs(self._allPetDataList) do
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	ArraySort.sortOn(self._curViewDatas, "zdl", ArraySort.DESCENDING)
	self.scrollList:reloadData(self._curViewDatas)
	GameUtil.SetActive(self.empty, #self._curViewDatas == 0)
end

function RoguelikerentpetView:onFilter(data)
	local petCo = data.petCfg
	local isHit = false
	local maxAwaken = CharacterConfig.instance:getMaxAwaken(petCo.raceId)
	local rare = CharacterConfig.instance:getRareByAwakenLv(maxAwaken, petCo.raceId)

	isHit = self:_isMatch(petCo, rare, data.curFaceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function RoguelikerentpetView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(filterType, cfg, rare, skinId)
end

function RoguelikerentpetView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_RefreshPetList()
	end
end

function RoguelikerentpetView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function RoguelikerentpetView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterButton.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, filterType, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function RoguelikerentpetView:onClearSearchClick()
	self._inputSearch.input.text = ""
end

function RoguelikerentpetView:_sendMsg()
	return
end

function RoguelikerentpetView:_onRefreshUI()
	self.txtTitle.text = lang("我的租借")
	self.txtTitlePet.text = lang("可租借精灵列表")

	GameUtil.SetActive(self.tip, true)

	local moList = RoguelikeModel.instance:getRentPetMoList(self._activityId) or {}
	local list = {}
	local now = ServerTime.now()

	for i, mo in ipairs(moList) do
		local skinCfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, mo.curFaceId)
		local temp = {}

		temp.zdl = mo:getFightingPower()
		temp.curFaceId = mo.curFaceId
		temp.data = mo
		temp.skinCfg = skinCfg

		if skinCfg then
			temp.petCfg = MaterialMgr.getMatCfg(MatType.Pet, skinCfg.raceId)
		end

		table.insert(list, temp)
	end

	self._allPetDataList = list

	self:_RefreshPetList()

	local info = RoguelikeModel.instance:getAgentInfo(self._activityId) or {}

	if not info.rentPetId then
		local rentPetId = {}

		self._rentPetId = {}

		for k, v in ipairs(rentPetId) do
			self._rentPetId[k] = v
		end

		self:_refreshLeftUI()
	end
end

function RoguelikerentpetView:_refreshLeftUI()
	for i, cell in ipairs(self._cellList) do
		GameUtil.SetActive(cell, true)
		self:updateCellByOtherInfo(cell, self._rentPetId[i])
	end
end

function RoguelikerentpetView:updateCellByOtherInfo(cell, petId)
	local info = goutil.findChild(cell, "info")
	local empty = goutil.findChild(cell, "empty")

	GameUtil.SetActive(info, false)
	GameUtil.SetActive(empty, false)
	GameUtil.rmClickHandler(cell)

	local btn = goutil.findChild(cell, "info/btn")
	local data = RoguelikeModel.instance:getRentPetMo(self._activityId, petId)

	if data then
		GameUtil.SetActive(info, true)

		local pet = goutil.findChild(info, "pet/con")
		local attr = goutil.findChild(info, "attr/con")
		local txtLevel = goutil.findChildTextComponent(info, "txtLevel")
		local job = goutil.findChild(info, "job")
		local job1 = goutil.findChild(info, "job1")
		local txtRemain = goutil.findChildTextComponent(info, "remain/txt")
		local playerInfo = goutil.findChild(info, "playerInfo")
		local head = goutil.findChild(info, "playerInfo/head")
		local txtName = goutil.findChildTextComponent(info, "playerInfo/txtName")
		local txtUserLevel = goutil.findChildTextComponent(info, "playerInfo/txtLevel")

		txtRemain.text = ""

		local petMo = data
		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
		local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

		GameUtil.setUIImageSpriteIdx(job, firstJobIdx - 1)
		GameUtil.SetActive(job1, false)

		if secondJobIdx > 20 then
			GameUtil.SetActive(job1, true)
			GameUtil.setUIImageSpriteIdx(job1, secondJobIdx - 1 - 20)
		end

		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)

		race = race % 10

		local targetValue = race - 1

		GameUtil.setUIImageSpriteIdx(attr, targetValue)

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(petMo.curFaceId))

		uGuiUtil.setSpriteToImage(pet.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

		txtLevel.text = "Lv." .. petMo.level

		GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickPetCell, self, petMo, data, cell))
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onCancelClick, self, petMo))

		txtRemain.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, petMo.curFaceId)
		txtName.text = ""
		txtUserLevel.text = ""

		GameUtil.SetActive(playerInfo, false)
		GameUtil.SetActive(job, false)
		GameUtil.SetActive(job1, false)
	else
		GameUtil.SetActive(empty, true)
	end
end

function RoguelikerentpetView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local lock = goutil.findChild(cell, "lock")

	MaterialMgr.setCellByMo(data.data, con)

	local now = ServerTime.now()
	local cfg = RoguelikeConfig.instance:getRentPetCfg(self._activityId, data.data.petId)
	local releaseTime = cfg.releaseTime
	local timeStart = GameUtil.string2time(releaseTime)

	GameUtil.SetActive(lock, now < timeStart)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickPetTips, self, data))
end

function RoguelikerentpetView:clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function RoguelikerentpetView:onClickPetTips(data)
	local petId = data.data.petId
	local now = ServerTime.now()
	local cfg = RoguelikeConfig.instance:getRentPetCfg(self._activityId, petId)
	local releaseTime = cfg.releaseTime
	local timeStart = GameUtil.string2time(releaseTime)

	if now < timeStart then
		local startDate = GameUtil.time2date(timeStart)
		local timeStr = string.format("%d月%d日 %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min)

		TipsFacade.instance:openCommonTips(langPara("该精灵%s后开放租借使用", timeStr))

		return
	end

	self._rentPetId = self._rentPetId or {}

	local lastPos = -1

	for i, v in pairs(self._rentPetId) do
		if v == petId then
			lastPos = i

			TipsFacade.instance:openCommonTips("该精灵已租借")

			break
		end
	end

	if lastPos == -1 then
		local has = true

		for i = 1, 3 do
			local last = checknumber(self._rentPetId[i])

			if last == 0 then
				has = false

				RoguelikeAgent.instance:sendPM_RoguelikeSetRentPetUsingOrNotReq(self._activityId, petId, true)

				self._rentPetId[i] = petId

				break
			end
		end

		if has then
			TipsFacade.instance:openCommonTips("当前已无租借空位，先去取消租借吧~")
		else
			self:_refreshLeftUI()
		end
	end
end

function RoguelikerentpetView:onClickPetCell(petMo, data, cell)
	local goOrPos

	CommonTipsMgr.instance:showPetTips(petMo)
end

function RoguelikerentpetView:_onCancelClick(petMo)
	self._rentPetId = self._rentPetId or {}

	local petId = petMo.petId
	local lastPos = -1

	for i, v in pairs(self._rentPetId) do
		if v == petId then
			self._rentPetId[i] = 0
			lastPos = i

			break
		end
	end

	RoguelikeAgent.instance:sendPM_RoguelikeSetRentPetUsingOrNotReq(self._activityId, petId, false)
	self:_refreshLeftUI()
end

function RoguelikerentpetView:onClickHelp()
	TipsFacade.instance:openRulesView("RoguelikerentpetView_rule")
end

return RoguelikerentpetView
