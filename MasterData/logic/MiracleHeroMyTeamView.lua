-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroMyTeamView.lua

module("logic.extensions.miraclehero.view.MiracleHeroMyTeamView", package.seeall)

local MiracleHeroMyTeamView = class("MiracleHeroMyTeamView", ViewComponent)

function MiracleHeroMyTeamView:ctor()
	MiracleHeroMyTeamView.super.ctor(self)
end

function MiracleHeroMyTeamView:unbindEvents()
	MiracleHeroMyTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i = 1, #self._myFormationCellList do
		local cell = self._myFormationCellList[i]

		GameUtil.rmClickHandler(cell.frame)
	end

	for i = 1, #self._switchBtns do
		GameUtil.rmClickHandler(self._switchBtns[i].go)
	end
end

function MiracleHeroMyTeamView:bindEvents()
	MiracleHeroMyTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i = 1, #self._myFormationCellList do
		local cell = self._myFormationCellList[i]

		GameUtil.addClickHandler(cell.frame, GameUtil.handler(self._onClickPet, self, self._myFormationCellList, cell))
	end

	for i = 1, #self._switchBtns do
		GameUtil.addClickHandler(self._switchBtns[i].go, GameUtil.handler(self._onSwitchList, self, i))
	end
end

function MiracleHeroMyTeamView:buildUI()
	MiracleHeroMyTeamView.super.buildUI(self)

	self._btnClose = self:getGo("topleft/btnClose")
	self._myFormationCellList = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("formation/seat" .. i)
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.frame = goutil.findChild(cell.go, "frame")
		cell.rd = goutil.findChild(cell.go, "rd")
		cell.txtLv = goutil.findChildTextComponent(cell.go, "txtLv")
		cell.txtPos = goutil.findChildTextComponent(cell.go, "txtPos")

		BeginDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetBegin(go, data, i)
		end)
		DragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetMoved(go, data)
		end)
		EndDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetEnded(go, data)
		end)
		DropHandler.Get(cell.frame):AddLuaHandler(function(go, eventData)
			self:_OnDropSeat(go, eventData, i)
		end)

		cell.info = nil
		cell.faceId = nil

		table.insert(self._myFormationCellList, cell)
	end

	self._assistCell = {}
	self._assistCell.go = self:getGo("formation/seatAssist")
	self._assistCell.icon = goutil.findChild(self._assistCell.go, "icon")
	self._assistCell.frame = goutil.findChild(self._assistCell.go, "frame")
	self._assistCell.faceId = nil

	DropHandler.Get(self._assistCell.frame):AddLuaHandler(function(go, eventData)
		self:_OnDropAssistSeat(go, eventData)
	end)

	local cellGo = self:getGo("petcell")

	self._tableviewGo = self:getGo("tableview")
	self._tableView = ScrollerList.create(self._tableviewGo, cellGo, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))
	self._tvCom = self._tableviewGo:GetComponent("UITableview")
	self._tableviewGoAssist = self:getGo("tableviewAssist")
	self._tableViewAssist = ScrollerList.create(self._tableviewGoAssist, cellGo, GameUtil.handler(self._updateCellAssist, self), GameUtil.handler(self._clearCellPet, self))
	self._tvComAssist = self._tableviewGoAssist:GetComponent("UITableview")
	self._switchBtns = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("switchBtns/btn_" .. i)
		cell.change = cell.go:GetComponent("UIChangeGroup")
		self._switchBtns[i] = cell
	end

	self._goldBarCon = self:getGo("goldBarCon")
	self._txtSpeed = self:getTxt("curSpeed/txtSpeed")
end

function MiracleHeroMyTeamView:onExit()
	MiracleHeroMyTeamView.super.onExit(self)
	self:saveFormation()

	for i = 1, #self._myFormationCellList do
		uGuiUtil.clearImage(self._myFormationCellList[i].icon)
	end

	uGuiUtil.clearImage(self._assistCell.icon)

	if not self._Character then
		return
	end

	MaterialMgr.clearIcon(self._Character)
	self._tableView:dispose()
	self._tableViewAssist:dispose()
end

function MiracleHeroMyTeamView:onEnter()
	MiracleHeroMyTeamView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	self:initViewByInfo()
	self.addGEvent(self, GlobalNotify.MiracleHeroUpgradePositionRes, self._handleLevelUp, self)
	self.addGEvent(self, GlobalNotify.MiracleHeroSetFormationRes, self.initViewByInfo, self)

	self._actCfg = MiracleHeroConfig.instance:getActCfg(self._activityId)

	local list = {}
	local tab = {
		showAdd = false,
		id = self._actCfg.costMatType
	}

	table.insert(list, tab)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
end

function MiracleHeroMyTeamView:initViewByInfo()
	for i = 1, #self._myFormationCellList do
		local cell = self._myFormationCellList[i]
		local info = MiracleHeroModel.instance:getPositionMo(self._activityId, i)
		local temInfo = {
			posId = i,
			level = info.level,
			curRace = info.curRace
		}

		cell.info = temInfo
		cell.faceId = self:getFaceId(temInfo.curRace)
	end

	self._curSwitchId = nil
	self._assistId = MiracleHeroModel.instance:getCurAssistId(self._activityId)

	self:updateFormation()
	self:_onSwitchList(1)
end

function MiracleHeroMyTeamView:updateFormation()
	for i = 1, #self._myFormationCellList do
		self:updateSet(i)
	end

	self._assistCell.faceId = self:getAssistFaceId(self._assistId)

	self:_setHead(self._assistCell.icon, self._assistCell.faceId)
	self:_refreshRaceList()
end

function MiracleHeroMyTeamView:_onSwitchList(id)
	if self._curSwitchId ~= id then
		self._curSwitchId = id

		for i = 1, #self._switchBtns do
			local cell = self._switchBtns[i]

			cell.change:SetState(self._curSwitchId == i and 0 or 1)
		end

		goutil.setActive(self._tableviewGo, self._curSwitchId == 1)
		goutil.setActive(self._tableviewGoAssist, self._curSwitchId == 2)
	end
end

function MiracleHeroMyTeamView:getAssistFaceId(assistId)
	local assistCfg = MiracleHeroConfig.instance:getAssistCfg(self._activityId, assistId)

	return checknumber(assistCfg.faceIds)
end

function MiracleHeroMyTeamView:getFaceId(race)
	local petCfg = MiracleHeroConfig.instance:getPetCfg(self._activityId, race)

	return checknumber(petCfg.faceIds)
end

function MiracleHeroMyTeamView:updateSet(posId)
	local cell = self._myFormationCellList[posId]

	if cell and cell.info then
		cell.txtLv.text = string.format("Lv.%s", MiracleHeroConfig.instance:getShowLevel(self._activityId, cell.info.level))
		cell.txtPos.text = string.format("%s号", cell.info.posId)

		local isShowRd = MiracleHeroModel.instance:isAbleLevelUPPos(self._activityId, posId)

		goutil.setActive(cell.rd, isShowRd)
		self:_setHead(cell.icon, cell.faceId)
	end
end

function MiracleHeroMyTeamView:getCurPosIds()
	local posIds = {}

	for i = 1, #self._myFormationCellList do
		local info = self._myFormationCellList[i].info

		if info then
			table.insert(posIds, info.curRace)
		end
	end

	return posIds
end

function MiracleHeroMyTeamView:saveFormation()
	local posIds = self:getCurPosIds()

	MiracleHeroController.instance:sendPM_MiracleHeroSetFormationReq(self._activityId, posIds, self._assistId)
end

function MiracleHeroMyTeamView:_setHead(icon, faceId)
	if icon then
		goutil.setActive(icon, false)

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(faceId))

		if modelCo ~= nil then
			goutil.setActive(icon, true)
			uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		end
	end
end

function MiracleHeroMyTeamView:_resetDragData()
	self._lastPosId = nil
	self._lastRaceId = nil
	self._lastAssistId = nil
	self._dragging = false
end

function MiracleHeroMyTeamView:_OnDragPetBegin(go, data, posId)
	if UGUIToolHelper.IsMultiTouchDown() then
		return
	end

	self:_resetDragData()

	if self._Character == nil then
		self._Character = self:getGo("dragObj")

		GameUtil.SetActive(self._Character, true)
	end

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()

	local cell = self._myFormationCellList[posId]

	MaterialMgr.setIcon(self._Character, MatType.PET_SKIN, cell.faceId)

	self._lastPosId = posId
	self._dragging = true
end

function MiracleHeroMyTeamView:_OnDragPetCellBegin(go, data, cellData)
	if UGUIToolHelper.IsMultiTouchDown() then
		return
	end

	local drag = math.abs(data.delta.y) > math.abs(data.delta.x) and self._tvCom:GetScrollRect().horizontal or math.abs(data.delta.y) < math.abs(data.delta.x) and self._tvCom:GetScrollRect().vertical

	self._tvCom:GetScrollRect():OnBeginDrag(data)
	self._tvCom:OnBeginDrag(data)

	if not drag then
		return
	end

	self:_resetDragData()

	if not cellData.isUnlock then
		return
	end

	self._dragging = true

	local raceId = cellData.raceId

	if self._Character == nil then
		self._Character = self:getGo("dragObj")

		GameUtil.SetActive(self._Character, true)
	end

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()

	local faceId = self:getFaceId(raceId)

	MaterialMgr.setIcon(self._Character, MatType.PET_SKIN, faceId)

	self._lastRaceId = raceId
end

function MiracleHeroMyTeamView:_OnDragAssistBegin(go, data, cellData)
	if UGUIToolHelper.IsMultiTouchDown() then
		return
	end

	local drag = math.abs(data.delta.y) > math.abs(data.delta.x) and self._tvComAssist:GetScrollRect().horizontal or math.abs(data.delta.y) < math.abs(data.delta.x) and self._tvComAssist:GetScrollRect().vertical

	self._tvComAssist:GetScrollRect():OnBeginDrag(data)
	self._tvComAssist:OnBeginDrag(data)

	if not drag then
		return
	end

	self:_resetDragData()

	if not cellData.isUnlock then
		return
	end

	self._dragging = true

	local assistId = cellData.assistId

	if self._Character == nil then
		self._Character = self:getGo("dragObj")

		GameUtil.SetActive(self._Character, true)
	end

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()

	local faceId = self:getAssistFaceId(assistId)

	MaterialMgr.setIcon(self._Character, MatType.PET_SKIN, faceId)

	self._lastAssistId = assistId
end

function MiracleHeroMyTeamView:_OnDragPetMoved(go, data)
	if not self._Character then
		return
	end

	if self._dragging then
		self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()
	else
		if GameUtil.GetActive(self._tableviewGoAssist) then
			self._tvComAssist:GetScrollRect():OnDrag(data)
		end

		if GameUtil.GetActive(self._tableviewGo) then
			self._tvCom:GetScrollRect():OnDrag(data)
		end
	end
end

function MiracleHeroMyTeamView:_OnDragPetEnded(go, data)
	if not self._Character then
		return
	end

	MaterialMgr.clearIcon(self._Character)

	if not self._dragging then
		-- block empty
	end

	if self._tvCom and self._tvCom:GetScrollRect() and data then
		self._tvCom:GetScrollRect():OnEndDrag(data)
		self._tvCom:OnEndDrag(data)
	end

	if self._tvComAssist and self._tvComAssist:GetScrollRect() and data then
		self._tvComAssist:GetScrollRect():OnEndDrag(data)
		self._tvComAssist:OnEndDrag(data)
	end

	self._dragging = false
	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function MiracleHeroMyTeamView:_OnDropSeat(go, data, posId)
	if self._lastPosId or self._lastRaceId then
		if not self._lastRaceId then
			local setRaceId = self._myFormationCellList[self._lastPosId].info.curRace
			local posIds = self:getCurPosIds()
			local newPosIds, result = MiracleHeroModel.instance:switchRaceIdOnFormation(self._activityId, posIds, setRaceId, posId)

			if result == MiracleHeroModel.SwitchRaceResult.existSameElement then
				TipsFacade.instance:openCommonTips(lang("只能替换相同属性的精灵"))

				return
			end

			for i = 1, #self._myFormationCellList do
				local cell = self._myFormationCellList[i]

				cell.info.curRace = newPosIds[i]
				cell.faceId = self:getFaceId(cell.info.curRace)

				self:_setHead(cell.icon, cell.faceId)
			end

			self:_refreshRaceList()
		end
	end
end

function MiracleHeroMyTeamView:_OnDropAssistSeat(go, data)
	if self._lastAssistId and self._lastAssistId ~= self._assistId then
		self._assistId = self._lastAssistId
		self._assistCell.faceId = self:getAssistFaceId(self._assistId)

		self:_setHead(self._assistCell.icon, self._assistCell.faceId)
		self:_refreshRaceList()
	end
end

function MiracleHeroMyTeamView:_onClickPet(myFormationCellList, cell)
	local infoList = {}

	for i, v in ipairs(self._myFormationCellList) do
		table.insert(infoList, v.info)
	end

	if cell and cell.info and #infoList > 0 then
		UIStateManager.instance:open(ViewName.MiracleHeroLevelUpView, self._activityId, infoList, cell.info)
	end
end

function MiracleHeroMyTeamView:_onClickPetCell(cellData)
	if not cellData.isUnlock then
		TipsFacade.instance:openCommonTips(lang("通关对应章节挑战后，可解锁相应卡片哦~"))
	end

	local raceId = cellData.raceId
	local info = {
		raceId = raceId,
		actId = self._activityId
	}

	UIStateManager.instance:open(ViewName.MiracleHeroPettipsView, info)
end

function MiracleHeroMyTeamView:_onClickAssistCell(cellData)
	if not cellData.isUnlock then
		TipsFacade.instance:openCommonTips(lang("通关对应章节挑战后，可解锁相应卡片哦~"))
	end

	local assistId = cellData.assistId
	local info = {
		assistId = assistId,
		actId = self._activityId
	}

	UIStateManager.instance:open(ViewName.MiracleHeroPettipsView, info)
end

function MiracleHeroMyTeamView:_handleLevelUp()
	for i = 1, #self._myFormationCellList do
		local cell = self._myFormationCellList[i]

		if cell.info then
			local posInfo = MiracleHeroModel.instance:getPositionMo(self._activityId, i)

			cell.info.level = posInfo.level
			cell.txtLv.text = string.format("Lv.%s", MiracleHeroConfig.instance:getShowLevel(self._activityId, cell.info.level))
			self._txtSpeed.text = MiracleHeroModel.instance:getMyTeamTotalSpeed(self._activityId, self:getCurPosIds())

			local isShowRd = MiracleHeroModel.instance:isAbleLevelUPPos(self._activityId, i)

			goutil.setActive(cell.rd, isShowRd)
		end
	end
end

function MiracleHeroMyTeamView:_updateCellPet(view, cellGo, cellData)
	local cell = self:_clearCellPet(cellGo)

	if cellData then
		local raceId = cellData.raceId

		self._beginDragHandleHash[cell.frame] = BeginDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetCellBegin(go, data, cellData)
		end)
		self._dragHandleHash[cell.frame] = DragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetMoved(go, data)
		end)
		self._endDragHandleHash[cell.frame] = EndDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetEnded(go, data)
		end)

		local skinId = self:getFaceId(raceId)
		local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
		local showRaceId = petSkinCfg.raceId
		local proxy = MaterialMgr.setCell(MatType.Pet, showRaceId, cell.con)

		if proxy then
			proxy:setAutoTips(false)
			proxy.binder:setSkin(skinId)
		end

		goutil.setActive(cell.markOnForm, cellData.isOnForm)
		goutil.setActive(cell.markLock, not cellData.isUnlock)
		GameUtil.addClickHandler(cell.frame, GameUtil.handler(self._onClickPetCell, self, cellData))
	end
end

function MiracleHeroMyTeamView:_updateCellAssist(view, cellGo, cellData)
	local cell = self:_clearCellPet(cellGo)

	if cellData then
		local assistId = cellData.assistId

		self._beginDragHandleHash[cell.frame] = BeginDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragAssistBegin(go, data, cellData)
		end)
		self._dragHandleHash[cell.frame] = DragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetMoved(go, data)
		end)
		self._endDragHandleHash[cell.frame] = EndDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetEnded(go, data)
		end)

		local skinId = self:getAssistFaceId(assistId)
		local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
		local showRaceId = petSkinCfg.raceId
		local proxy = MaterialMgr.setCell(MatType.Pet, showRaceId, cell.con)

		if proxy then
			proxy:setAutoTips(false)
			proxy.binder:setSkin(skinId)
		end

		goutil.setActive(cell.markOnForm, self._assistId == assistId)
		goutil.setActive(cell.markLock, not cellData.isUnlock)
		GameUtil.addClickHandler(cell.frame, GameUtil.handler(self._onClickAssistCell, self, cellData))
	end
end

function MiracleHeroMyTeamView:_clearCellPet(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.frame = goutil.findChild(cell.go, "frame")
	self._beginDragHandleHash = self._beginDragHandleHash or {}

	local beginHandle = self._beginDragHandleHash[cell.frame]

	if beginHandle then
		BeginDragHandler.Get(cell.frame):RemoveLuaHandler(beginHandle)

		self._beginDragHandleHash[cell.frame] = nil
	end

	self._dragHandleHash = self._dragHandleHash or {}

	local dragHandle = self._dragHandleHash[cell.frame]

	if dragHandle then
		DragHandler.Get(cell.frame):RemoveLuaHandler(dragHandle)

		self._dragHandleHash[cell.frame] = nil
	end

	self._endDragHandleHash = self._endDragHandleHash or {}

	local endHandle = self._endDragHandleHash[cell.frame]

	if endHandle then
		EndDragHandler.Get(cell.frame):RemoveLuaHandler(endHandle)

		self._endDragHandleHash[cell.frame] = nil
	end

	cell.con = goutil.findChild(cell.go, "con")

	MaterialMgr.resetAll(cell.con)

	cell.markOnForm = goutil.findChild(cell.go, "markOnForm")
	cell.markLock = goutil.findChild(cell.go, "markLock")

	GameUtil.rmClickHandler(cell.frame)

	return cell
end

function MiracleHeroMyTeamView:_refreshRaceList()
	local petCfgs = MiracleHeroConfig.instance:getPetCfgs(self._activityId)
	local petDataList = {}

	self._curRaceIdsOnForm = self:getCurPosIds()

	for _, cfg in pairs(petCfgs) do
		local data = {
			isOnForm = false,
			isUnlock = false,
			raceId = cfg.raceId
		}

		data.isOnForm = table.indexof(self._curRaceIdsOnForm, data.raceId)

		local unlockItemId = checknumber(cfg.unlockItemId)

		if unlockItemId > 0 then
			if MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, unlockItemId) > 0 then
				data.isUnlock = true
			end

			table.insert(petDataList, data)
		elseif unlockItemId < 0 then
			-- block empty
		else
			data.isUnlock = true

			table.insert(petDataList, data)
		end
	end

	table.sort(petDataList, function(a, b)
		if a.isUnlock and not b.isUnlock then
			return true
		elseif not a.isUnlock and b.isUnlock then
			return false
		elseif a.isOnForm and not b.isOnForm then
			return true
		elseif not a.isOnForm and b.isOnForm then
			return false
		else
			return a.raceId < b.raceId
		end
	end)
	self._tableView:reloadData(petDataList)

	local assistCfgs = MiracleHeroConfig.instance:getAssistCfgs(self._activityId)
	local assistDataList = {}

	for _, cfg in pairs(assistCfgs) do
		local data = {
			isOnForm = false,
			isUnlock = false,
			assistId = cfg.assistId
		}

		data.isOnForm = cfg.assistId == self._assistId

		local unlockItemId = checknumber(cfg.unlockItemId)

		if unlockItemId > 0 then
			if MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, unlockItemId) > 0 then
				data.isUnlock = true
			end
		elseif unlockItemId < 0 then
			-- block empty
		else
			data.isUnlock = true
		end

		table.insert(assistDataList, data)
	end

	table.sort(assistDataList, function(a, b)
		if a.isUnlock and not b.isUnlock then
			return true
		elseif not a.isUnlock and b.isUnlock then
			return false
		elseif a.isOnForm and not b.isOnForm then
			return true
		elseif not a.isOnForm and b.isOnForm then
			return false
		else
			return a.assistId < b.assistId
		end
	end)
	self._tableViewAssist:reloadData(assistDataList)

	self._txtSpeed.text = MiracleHeroModel.instance:getMyTeamTotalSpeed(self._activityId, self:getCurPosIds())
end

return MiracleHeroMyTeamView
