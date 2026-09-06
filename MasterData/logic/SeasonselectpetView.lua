-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonselectpetView.lua

module("logic.extensions.season.view.SeasonselectpetView", package.seeall)

local SeasonselectpetView = class("SeasonselectpetView", SeasonfmttabextView)

function SeasonselectpetView:ctor()
	SeasonselectpetView.super.ctor(self)
end

function SeasonselectpetView:unbindEvents()
	SeasonselectpetView.super.unbindEvents(self)
	DropHandler.Get(self.dropRight.gameObject):RemoveLuaHandler(self.dropRightHash)
	DropHandler.Get(self.dropBag.gameObject):RemoveLuaHandler(self.dropBagHash)
	self.topFilterView:unbindEvents()
	GameUtil.rmClickHandler(self.btnCancel)
	GameUtil.rmClickHandler(self.btnOK)
	GameUtil.rmClickHandler(self.btnAdd)
end

function SeasonselectpetView:bindEvents()
	SeasonselectpetView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnCancel, self.close, self)
	GameUtil.addClickHandler(self.btnOK, self.onClickOk, self)
	GameUtil.addClickHandler(self.btnAdd, self.onClickAdd, self)

	self.dropRightHash = DropHandler.Get(self.dropRight.gameObject):AddLuaHandler(function(_go, eventData)
		self:_OnDropSeatRight(_go, eventData)
	end)
	self.dropBagHash = DropHandler.Get(self.dropBag.gameObject):AddLuaHandler(function(_go, eventData)
		self:_OnDropSeatBag(_go, eventData)
	end)

	self.topFilterView:bindEvents()
end

function SeasonselectpetView:buildUI()
	SeasonselectpetView.super.buildUI(self)

	self.btnCancel = self:getGo("btnCancel")
	self.btnOK = self:getGo("btnOK")
	self.btnAdd = self:getGo("btnAdd")
	self.txtTitle = self:getTxt("txtTitle")
	self.txtLimit = self:getTxt("txtLimit")
	self.txtPetCount = self:getTxt("txtPetCount")
	self.cellGo = self:getGo("cell")
	self.bagScrollerGo = self:getGo("bagPet/tableview")
	self.rightScrollerGo = self:getGo("tableview")
	self._tableviewBag = self.bagScrollerGo.gameObject:GetComponent("UITableview")
	self._tableviewRight = self.rightScrollerGo.gameObject:GetComponent("UITableview")
	self.bagScrollList = ScrollerList.create(self.bagScrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self.rightScrollList = ScrollerList.create(self.rightScrollerGo, self.cellGo, GameUtil.handler(self._updateCellRight, self), GameUtil.handler(self.clearCell, self))
	self.dropRight = self:getGo("dropRight")
	self.dropBag = self:getGo("dropBag")
	self.dragPetGo = self:getGo("petgo")
	self.dragImageBg = self:getGo("petgo/ImgC_Bg")
	self.dragImage = self:getGo("petgo/ImgC_HeadIcon/con")

	GameUtil.SetActive(self.dropRight, false)
	GameUtil.SetActive(self.dropBag, false)
	GameUtil.SetActive(self.dragPetGo, false)

	local _Nego_Popup = self:getGo("bagPet/popup")

	self._Btn_Attr = goutil.findChild(_Nego_Popup, "Btn_Attr"):GetComponent("UIChangeGroup")
	self._InputC_Search = goutil.findChild(self.mainGO, "bagPet/InputC_Search"):GetComponent("InputField")
	self.btnClear = goutil.findChild(self.mainGO, "bagPet/InputC_Search/BtnClear")
	self._sortButton = self:getBtn("bagPet/btnSort")
	self.topFilterView = BagPetTopFilterView.New()

	self.topFilterView:initGoParams(PetFilterMgr.TYPE_SEASON_BAG, self, self._Btn_Attr, self._sortButton, self._InputC_Search, self.btnClear)
end

function SeasonselectpetView:onExit()
	SeasonselectpetView.super.onExit(self)
	self.bagScrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtBuyPayTime, self.onPayTimeOk, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self.onGetBagInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtBagPetInfo, self.onGetBagInfo, self)
end

function SeasonselectpetView:onEnter()
	SeasonselectpetView.super.onEnter(self)

	self.isCanDragTab = false

	self:showTabs()

	self._dragging = false
	self.isBuyAndUse = false
	self.tempPetIdList = {}
	self.limitRightCount = checknumber(SeasonConfig.instance:getCommonValue("TEAM_PACKAGE_NUM"))
	self.teamAdjustTimes = checknumber(SeasonConfig.instance:getCommonValue("TEAM_ADJUST_TIMES"))

	self.topFilterView:initCallBack(GameUtil.handler(self.onRefreshList, self))
	self:onGetBagInfo()
	self:onRefreshUI()
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtBuyPayTime, self.onPayTimeOk, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self.onGetBagInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtBagPetInfo, self.onGetBagInfo, self)

	if self.rightPetList == nil or #self.rightPetList == 0 then
		SeasonController.instance:sendGetAllTeamInfo()
	end

	SeasonController.instance:sendGetAllPetListInfo()
end

function SeasonselectpetView:checkBossFight()
	return
end

function SeasonselectpetView:_onClickJumpOtherTab(idx)
	if self.draging then
		return
	end

	if FastFormation.instance.isLocking then
		return
	end

	local teamMo = SeasonTeamsModel.instance:getTeam(idx)

	if teamMo and teamMo:isServerLocked() then
		TipsFacade.instance:openCommonTips(lang("当前小队被锁定，不能进行调整"))

		return
	end

	local isNotToChange = self:getIsNotToChange()

	if not isNotToChange then
		TipsFacade.instance:openPopupWindow(lang("tip"), lang("当前小队已经被调整，需要先保存信息"), function()
			self:trySendSave(true, idx)
		end)

		return
	end

	self.customFmtMo:jumpToTabIndex(idx)
end

function SeasonselectpetView:_onTabChange()
	SeasonselectpetView.super._onTabChange(self)
	self:onGetBagInfo()
	self:onRefreshUI()
end

function SeasonselectpetView:onPayTimeOk()
	self:onGetBagInfo()
	self:onRefreshUI()

	if self.isBuyAndUse then
		self:realSendMsg(self.tempPetIdList, true)
	end

	self.isBuyAndUse = false
	self.tempPetIdList = {}
end

function SeasonselectpetView:onGetBagInfo()
	local curTab = self.customFmtMo:getCurFormTab()

	self.teamMo = SeasonTeamsModel.instance:getTeam(curTab)
	self.bagPetList = {}
	self.rightPetList = {}
	self.rcdRightMap = {}
	self.canNotUpMap = {}
	self.adjustTimes = 0
	self.payTimes = 0

	local teamName = ""

	if self.teamMo then
		for i, mo in ipairs(self.teamMo:getPetMoList() or {}) do
			table.insert(self.rightPetList, mo)

			self.rcdRightMap[mo.petId] = mo
		end

		teamName = self.teamMo.teamName
		self.adjustTimes = self.teamMo.adjustTimes
		self.payTimes = self.teamMo.payTimes
	end

	self.rcdCount = #self.rightPetList
	self.totalBuyTime = #SeasonConfig.instance:getModePveTimeCostList()
	self.txtTitle.text = langPara("编辑【%s】精灵", teamName)

	for i, v in ipairs(SeasonPetsModel.instance:getSeasonBagPetList() or {}) do
		table.insert(self.bagPetList, v)
	end

	self.topFilterView:reloadData(self.bagPetList)
end

function SeasonselectpetView:onRefreshUI()
	self.topFilterView:reloadData(self.bagPetList)
	self.rightScrollList:reloadData(self.rightPetList)

	self.txtPetCount.text = langPara("上限数量:%s/%s", #self.rightPetList, self.limitRightCount)

	local total = self.teamAdjustTimes + self.payTimes

	self.txtLimit.text = langPara("调整次数：%s/%s", math.max(0, total - self.adjustTimes), self.teamAdjustTimes)
end

function SeasonselectpetView:onRefreshList(list)
	local temp = {}

	for i, v in ipairs(list) do
		table.insert(temp, v)
	end

	for i, tMo in ipairs(SeasonTeamsModel.instance:getTeams()) do
		if tMo.teamId ~= self.teamMo.teamId then
			for i, mo in ipairs(tMo:getPetMoList() or {}) do
				table.insert(temp, mo)

				self.canNotUpMap[mo.petId] = tMo.teamId
			end
		end
	end

	self.bagScrollList:reloadData(temp)
end

function SeasonselectpetView:clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)

	local dragTrigger = Framework.UIDragTrigger.Get(con)

	dragTrigger:RemoveDragListener()
	dragTrigger:RemoveBeginDragListener()
	dragTrigger:RemoveEndDragListener()
end

function SeasonselectpetView:_updateCellRight(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local txt = goutil.findChildTextComponent(cell, "btn/txt")
	local btn = goutil.findChild(cell, "btn")

	GameUtil.SetActive(btn, false)

	local proxy = MaterialMgr.setCellByMo(data, con)

	if proxy then
		proxy.binder:setClickCallBack(function()
			SeasonPetsModel.instance:calcPetAttr(data, self.teamMo)
			CommonTipsMgr.instance:showPetTips(data)
		end)
	end

	local dragTrigger = Framework.UIDragTrigger.Get(con)

	dragTrigger:RemoveDragListener()
	dragTrigger:RemoveBeginDragListener()
	dragTrigger:RemoveEndDragListener()
	dragTrigger:AddBeginDragListener(self._OnDragPetBeginRight, self, data)
	dragTrigger:AddDragListener(self._OnDragPetMovedRight, self, data)
	dragTrigger:AddEndDragListener(self._OnDragPetEndedRight, self, data)
end

function SeasonselectpetView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local txt = goutil.findChildTextComponent(cell, "btn/txt")
	local btn = goutil.findChild(cell, "btn")

	GameUtil.SetActive(btn, false)

	local proxy = MaterialMgr.setCellByMo(data, con)

	if proxy then
		proxy.binder:setClickCallBack(function()
			local idx = checknumber(self.canNotUpMap[data.petId])

			SeasonPetsModel.instance:calcPetAttr(data, (idx > 0 or nil) and SeasonTeamsModel.instance:getTeam(idx))
			CommonTipsMgr.instance:showPetTips(data)
		end)
		proxy.binder:setGray(false)
	end

	local dragTrigger = Framework.UIDragTrigger.Get(con)

	dragTrigger:RemoveDragListener()
	dragTrigger:RemoveBeginDragListener()
	dragTrigger:RemoveEndDragListener()

	if not self.canNotUpMap[data.petId] then
		dragTrigger:AddBeginDragListener(self._OnDragPetBeginBag, self, data)
		dragTrigger:AddDragListener(self._OnDragPetMovedBag, self, data)
		dragTrigger:AddEndDragListener(self._OnDragPetEndedBag, self, data)
	else
		GameUtil.SetActive(btn, true)

		txt.text = self.canNotUpMap[data.petId]

		if proxy then
			proxy.binder:setGray(true)
		end
	end
end

function SeasonselectpetView:_OnDragPetBeginRight(data, petMo)
	self:onBeginDrag(data, petMo, self._tableviewRight, self.dropBag)
end

function SeasonselectpetView:_OnDragPetMovedRight(data, petMo)
	self:onMoveDrag(data, petMo, self._tableviewRight)
end

function SeasonselectpetView:_OnDragPetEndedRight(data, petMo)
	self:onEndDrag(data, petMo, self._tableviewRight)
end

function SeasonselectpetView:_OnDragPetBeginBag(data, petMo)
	self:onBeginDrag(data, petMo, self._tableviewBag, self.dropRight)
end

function SeasonselectpetView:_OnDragPetMovedBag(data, petMo)
	self:onMoveDrag(data, petMo, self._tableviewBag)
end

function SeasonselectpetView:_OnDragPetEndedBag(data, petMo)
	self:onEndDrag(data, petMo, self._tableviewBag)
end

function SeasonselectpetView:onBeginDrag(data, petMo, tableView, dropGo)
	local drag = math.abs(data.delta.y) > math.abs(data.delta.x) and tableView:GetScrollRect().horizontal or math.abs(data.delta.y) < math.abs(data.delta.x) and tableView:GetScrollRect().vertical

	if drag then
		self._dragging = true

		self:showDragPet(petMo, dropGo)
	else
		self._dragging = nil

		tableView:GetScrollRect():OnBeginDrag(data)
		tableView:OnBeginDrag(data)
	end
end

function SeasonselectpetView:onMoveDrag(data, petMo, tableView)
	if self._dragging then
		self.dragPetGo.transform.position = uGuiUtil.GetTouchWorldPosition()
	else
		tableView:GetScrollRect():OnDrag(data)
	end
end

function SeasonselectpetView:onEndDrag(data, petMo, tableView)
	if self._dragging then
		self:hideDragPet()
	elseif tableView and tableView:GetScrollRect() and data then
		tableView:GetScrollRect():OnEndDrag(data)
		tableView:OnEndDrag(data)
	end
end

function SeasonselectpetView:showDragPet(petMo, dropGo)
	self:hideDragPet()
	GameUtil.SetActive(self.dragPetGo, true)

	self.dragPetGo.transform.position = uGuiUtil.GetTouchWorldPosition()

	local rare = CharacterConfig.instance:getRareByAwakenLv(petMo.awakeLevel, petMo.raceId)

	GameUtil.setUIImageSpriteIdx(self.dragImageBg, rare + 1)
	MaterialMgr.setIcon(self.dragImage, MatType.PET_SKIN, petMo.curFaceId)
	GameUtil.SetActive(dropGo, true)

	self.curDrapPetMo = petMo
end

function SeasonselectpetView:hideDragPet()
	MaterialMgr.clearIcon(self.dragImage)
	GameUtil.SetActive(self.dragPetGo, false)
	GameUtil.SetActive(self.dropRight, false)
	GameUtil.SetActive(self.dropBag, false)

	self.curDrapPetMo = nil
end

function SeasonselectpetView:petMoChangePos(fromList, toList)
	if self.curDrapPetMo ~= nil then
		local pos1 = table.indexof(toList, self.curDrapPetMo)

		if pos1 == false then
			table.insert(toList, self.curDrapPetMo)
		end

		local posIdx = table.indexof(fromList, self.curDrapPetMo)

		if posIdx ~= false then
			table.remove(fromList, posIdx)
		end

		self:onRefreshUI()
	end

	self:hideDragPet()
end

function SeasonselectpetView:_OnDropSeatBag(go, eventData)
	self:petMoChangePos(self.rightPetList, self.bagPetList)
end

function SeasonselectpetView:_OnDropSeatRight(go, eventData)
	if #self.rightPetList < self.limitRightCount then
		self:petMoChangePos(self.bagPetList, self.rightPetList)
	else
		TipsFacade.instance:openCommonTips(lang("小队精灵不能超过上限"))
	end
end

function SeasonselectpetView:onClickOk()
	if self.teamMo and self.teamMo:isServerLocked() then
		TipsFacade.instance:openCommonTips(lang("当前小队被锁定，不能进行调整"))

		return
	end

	self:trySendSave(false)
end

function SeasonselectpetView:getChangeInfo()
	local petIdList = {}
	local isSame = true
	local map = {}

	for i, mo in ipairs(self.rightPetList) do
		table.insert(petIdList, mo.petId)

		map[mo.petId] = true
	end

	for k, v in pairs(self.rcdRightMap) do
		if map[k] == nil then
			isSame = false
		end
	end

	return isSame, petIdList
end

function SeasonselectpetView:getIsNotToChange()
	local isSame, petIdList = self:getChangeInfo()
	local count = #petIdList

	if isSame and count == self.rcdCount then
		return true
	end

	return false
end

function SeasonselectpetView:trySendSave(isChangeTab, tabIdx)
	self.tempIdx = tabIdx

	local isSame, petIdList = self:getChangeInfo()
	local count = #petIdList

	if isSame and count == self.rcdCount then
		if not isChangeTab then
			self:close()
		elseif checknumber(tabIdx) > 0 then
			self.customFmtMo:jumpToTabIndex(tabIdx)
		end
	elseif isSame then
		if count > self.rcdCount then
			local key = "SeasonselectpetView_TOG"

			if not GameUtil.getUserDayData(key) then
				local function funcTog()
					GameUtil.saveUserDayData(key, true)
				end

				local togText = lang("今日不再提示")

				TipsFacade.instance:openPopupWindowNoCancelWithTog(lang("tip"), lang("小队背包新增精灵，不消耗此次次数"), function()
					self:realSendMsg(petIdList, isChangeTab)
				end, funcTog, nil, togText, UnityEngine.TextAnchor.MiddleCenter)
			else
				self:realSendMsg(petIdList, isChangeTab)
			end
		else
			self:checkCostThenSendMsg(petIdList, isChangeTab)
		end
	else
		self:checkCostThenSendMsg(petIdList, isChangeTab)
	end
end

function SeasonselectpetView:checkCostThenSendMsg(petIdList, isChangeTab)
	if self.adjustTimes < self.teamAdjustTimes + self.payTimes then
		TipsFacade.instance:openPopupWindow(lang("tip"), lang("当前出现精灵变更，需要消耗次数，该次数使用完毕后将用代币购买"), function()
			self:realSendMsg(petIdList, isChangeTab)
		end)
	else
		local time = self.payTimes + 1
		local costCfg = SeasonConfig.instance:getModePveTimeCost(time)

		if costCfg then
			local cost = costCfg.cost
			local type, id, num = MaterialMgr.getMatParams(cost)
			local name = MaterialMgr.getMaterialsName(type, id)
			local content = langPara("当前出现精灵变更，需要消耗次数，是否确认花费%sx%s购买小队调整次数？", name, num)

			TipsFacade.instance:openPopupCostMatViewNew(type, id, num, content, function()
				self.isBuyAndUse = true
				self.tempPetIdList = petIdList

				local curTab = self.customFmtMo:getCurFormTab()

				SeasonController.instance:sendBuyPayTime(curTab)
			end)
		else
			TipsFacade.instance:openCommonTips(lang("没有可以购买的次数了"))
		end
	end
end

function SeasonselectpetView:onClickAdd()
	if self.adjustTimes < self.teamAdjustTimes + self.payTimes then
		TipsFacade.instance:openCommonTips(lang("当前还有剩余次数，不需要购买"))
	else
		local time = self.payTimes + 1
		local costCfg = SeasonConfig.instance:getModePveTimeCost(time)

		if costCfg then
			local cost = costCfg.cost
			local type, id, num = MaterialMgr.getMatParams(cost)
			local name = MaterialMgr.getMaterialsName(type, id)
			local content = langPara("是否确认花费%sx%s购买小队调整次数", name, num)

			TipsFacade.instance:openPopupCostMatViewNew(type, id, num, content, function()
				local curTab = self.customFmtMo:getCurFormTab()

				SeasonController.instance:sendBuyPayTime(curTab)
			end)
		else
			TipsFacade.instance:openCommonTips(lang("没有可以购买的次数了"))
		end
	end
end

function SeasonselectpetView:realSendMsg(petIdList, isChangeTab)
	local curTab = self.customFmtMo:getCurFormTab()

	SeasonController.instance:sendSaveTeamBagPet(curTab, petIdList)

	if not isChangeTab then
		self:close()
	elseif checknumber(self.tempIdx) > 0 then
		self.customFmtMo:jumpToTabIndex(self.tempIdx)
	end

	self.tempIdx = nil
end

return SeasonselectpetView
