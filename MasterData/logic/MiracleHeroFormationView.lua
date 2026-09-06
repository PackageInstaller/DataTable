-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroFormationView.lua

module("logic.extensions.miraclehero.view.MiracleHeroFormationView", package.seeall)

local MiracleHeroFormationView = class("MiracleHeroFormationView", ViewComponent)

function MiracleHeroFormationView:ctor()
	MiracleHeroFormationView.super.ctor(self)
end

function MiracleHeroFormationView:unbindEvents()
	MiracleHeroFormationView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnPet)

	for i = 1, #self._myFormationCellList do
		local cell = self._myFormationCellList[i]

		GameUtil.rmClickHandler(cell.frame)
	end

	GameUtil.rmClickHandler(self._assistCell.frame)

	for i = 1, #self._enemyFormationCellList do
		local cell = self._enemyFormationCellList[i]

		GameUtil.rmClickHandler(cell.frame)
	end

	for i = 1, #self._switchBtns do
		GameUtil.rmClickHandler(self._switchBtns[i].go)
	end
end

function MiracleHeroFormationView:bindEvents()
	MiracleHeroFormationView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnPet, self._onClickGotoLevelUp, self)

	for i = 1, #self._myFormationCellList do
		local cell = self._myFormationCellList[i]

		GameUtil.addClickHandler(cell.frame, GameUtil.handler(self._onClickPet, self, cell))
	end

	GameUtil.addClickHandler(self._assistCell.frame, GameUtil.handler(self._onClickAssist, self))

	for i = 1, #self._enemyFormationCellList do
		local cell = self._enemyFormationCellList[i]

		GameUtil.addClickHandler(cell.frame, GameUtil.handler(self._onClickEnemyPet, self, cell))
	end

	for i = 1, #self._switchBtns do
		GameUtil.addClickHandler(self._switchBtns[i].go, GameUtil.handler(self._onSwitchList, self, i))
	end
end

function MiracleHeroFormationView:buildUI()
	MiracleHeroFormationView.super.buildUI(self)

	self._btnClose = self:getGo("topleft/btnClose")
	self._btnStart = self:getGo("btnStart")
	self._btnPet = self:getGo("btnPet")
	self._redPointPet = self:getGo("btnPet/redpoint")
	self._enemyFormationCellList = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("enemyForm/seat" .. i)
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.frame = goutil.findChild(cell.go, "frame")
		cell.lv = goutil.findChild(cell.go, "lv")
		cell.txtLv = goutil.findChildTextComponent(cell.lv, "txtLv")
		cell.txtPos = goutil.findChildTextComponent(cell.go, "txtPos")
		cell.petType = goutil.findChild(cell.go, "petType")
		cell.petTypeChange = goutil.findChildComponent(cell.petType, "type", "UIImageSpriteChange")
		cell.info = nil

		table.insert(self._enemyFormationCellList, cell)
	end

	self._enemySpeedChange = self:getGo("enemyForm/speed/isfirst"):GetComponent("UIImageSpriteChange")
	self._enemySpeedTxt = self:getTxt("enemyForm/speed/txt")
	self._myFormationCellList = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("myForm/seat" .. i)
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.frame = goutil.findChild(cell.go, "frame")
		cell.txtLv = goutil.findChildTextComponent(cell.go, "txtLv")
		cell.txtPos = goutil.findChildTextComponent(cell.go, "txtPos")
		cell.petType = goutil.findChild(cell.go, "petType")
		cell.petTypeChange = goutil.findChildComponent(cell.petType, "type", "UIImageSpriteChange")

		BeginDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetBegin(go, data, i)
		end)
		DragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragSeatPetMoved(go, data)
		end)
		EndDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragSeatPetEnded(go, data)
		end)
		DropHandler.Get(cell.frame):AddLuaHandler(function(go, eventData)
			self:_OnDropSeat(go, eventData, i)
		end)

		cell.info = nil
		cell.faceId = nil

		table.insert(self._myFormationCellList, cell)
	end

	self._mySpeedChange = self:getGo("myForm/speed/isfirst"):GetComponent("UIImageSpriteChange")
	self._mySpeedTxt = self:getTxt("myForm/speed/txt")
	self._assistCell = {}
	self._assistCell.go = self:getGo("myForm/seatAssist")
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

	self._vsEffPos = self:getGo("bg/vsEffPos")
end

function MiracleHeroFormationView:onExit()
	MiracleHeroFormationView.super.onExit(self)
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
	self:_removeVsEffect()
	RedPointController.instance:unregRedPoint(self._redPointPet)
end

function MiracleHeroFormationView:onEnter()
	MiracleHeroFormationView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._stageCfg = params[1]
	self._activityId = checknumber(self._stageCfg.activityId)

	self:initViewByCfg()
	self:initViewByInfo()
	self:_loadVsEffect()
	self.addGEvent(self, GlobalNotify.MiracleHeroSetFormationRes, self.initViewByInfo, self)
	RedPointController.instance:regRedPoint(self._redPointPet, RedPointModel.ID_MIRACLE_HERO_PET_LEVEL_UP)
end

function MiracleHeroFormationView:initViewByCfg()
	local cfgs = MiracleHeroConfig.instance:getCreepsCfg(self._activityId, self._stageCfg.creepsMasterId)

	for i = 1, #self._enemyFormationCellList do
		self._enemyFormationCellList[i].info = nil
	end

	for i, v in ipairs(cfgs) do
		self._enemyFormationCellList[v.posId].info = v
	end

	for i = 1, #self._enemyFormationCellList do
		local cell = self._enemyFormationCellList[i]

		if cell.info then
			GameUtil.SetActive(cell.go, true)

			cell.txtLv.text = string.format("Lv.%s", cell.info.lv)

			local faceId = MiracleHeroConfig.instance:getRaceFaceId(self._activityId, cell.info.raceId)

			self:_setHead(cell.icon, faceId)

			local petCfg = MiracleHeroConfig.instance:getPetCfg(self._activityId, cell.info.raceId)
			local cfg = MiracleHeroConfig.instance:getRaceType(petCfg.elementId)

			cell.petTypeChange:SetState(petCfg.elementId - 1)
			goutil.setActive(cell.petType, true)
			goutil.setActive(cell.lv, true)
		else
			GameUtil.SetActive(cell.go, false)

			cell.txtLv.text = ""

			self:_setHead(cell.icon, 0)
			goutil.setActive(cell.petType, false)
			goutil.setActive(cell.lv, false)
		end
	end
end

function MiracleHeroFormationView:initViewByInfo()
	for i = 1, #self._myFormationCellList do
		local cell = self._myFormationCellList[i]
		local info = MiracleHeroModel.instance:getPositionMo(self._activityId, i)

		cell.info = {
			posId = i,
			level = info.level,
			curRace = info.curRace
		}
	end

	self._assistId = MiracleHeroModel.instance:getCurAssistId(self._activityId)
	self._curSwitchId = nil

	self:_onSwitchList(1)
	self:updateFormation()
end

function MiracleHeroFormationView:updateFormation()
	for i = 1, #self._myFormationCellList do
		local cell = self._myFormationCellList[i]

		if cell and cell.info then
			cell.txtLv.text = string.format("Lv.%s", MiracleHeroConfig.instance:getShowLevel(self._activityId, cell.info.level))
			cell.txtPos.text = string.format("%s号", cell.info.posId)
			cell.faceId = MiracleHeroConfig.instance:getRaceFaceId(self._activityId, cell.info.curRace)

			self:_setHead(cell.icon, cell.faceId)

			local petCfg = MiracleHeroConfig.instance:getPetCfg(self._activityId, cell.info.curRace)
			local cfg = MiracleHeroConfig.instance:getRaceType(petCfg.elementId)

			cell.petTypeChange:SetState(petCfg.elementId - 1)
		end
	end

	self._assistCell.faceId = MiracleHeroConfig.instance:getAssistFaceId(self._activityId, self._assistId)

	self:_setHead(self._assistCell.icon, self._assistCell.faceId)
	self:_refreshRaceList()
	self:_updateSpeed()
end

function MiracleHeroFormationView:_resetDragData()
	self._lastPosId = nil
	self._lastRaceId = nil
	self._lastAssistId = nil
	self._dragging = false
end

function MiracleHeroFormationView:_getBattleViewName()
	return ViewName.MiracleHeroBattleView
end

function MiracleHeroFormationView:_onClickStart()
	self:close()

	local battleViewName = self:_getBattleViewName()

	MiracleHeroController.instance:sendPM_MiracleHeroChallengeReq(self._activityId, self._stageCfg.challengeId, self._stageCfg.stageId, self:getCurPosIds(), self._assistId, battleViewName)
end

function MiracleHeroFormationView:_onClickEnemyPet(cell)
	if cell and cell.info then
		local info = {
			raceId = cell.info.raceId,
			actId = self._activityId
		}

		UIStateManager.instance:open(ViewName.MiracleHeroPettipsView, info)
	end
end

function MiracleHeroFormationView:_onClickPet(cell)
	if cell and cell.info then
		local info = {
			raceId = cell.info.curRace,
			actId = self._activityId
		}

		UIStateManager.instance:open(ViewName.MiracleHeroPettipsView, info)
	end

	if self._curSwitchId ~= 1 then
		self._curSwitchId = 1

		self:_refreshRaceList()
	end
end

function MiracleHeroFormationView:_onClickAssist()
	local info = {
		assistId = self._assistId,
		actId = self._activityId
	}

	UIStateManager.instance:open(ViewName.MiracleHeroPettipsView, info)

	if self._curSwitchId == 1 then
		self._curSwitchId = 2

		self:_refreshRaceList()
	end
end

function MiracleHeroFormationView:_onClickPetCell(raceId)
	local info = {
		raceId = raceId,
		actId = self._activityId
	}

	UIStateManager.instance:open(ViewName.MiracleHeroPettipsView, info)
end

function MiracleHeroFormationView:_onClickAssistCell(assistId)
	local info = {
		assistId = assistId,
		actId = self._activityId
	}

	UIStateManager.instance:open(ViewName.MiracleHeroPettipsView, info)
end

function MiracleHeroFormationView:_OnDragPetBegin(go, data, posId)
	self:_resetDragData()

	if self._Character == nil then
		self._Character = self:getGo("dragObj")

		GameUtil.SetActive(self._Character, true)
	end

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()

	local cell = self._myFormationCellList[posId]

	self:_setHead(self._Character, cell.faceId)

	self._lastPosId = posId
	self._dragging = true
end

function MiracleHeroFormationView:_OnDragPetCellBegin(go, data, raceId)
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

	if self._Character == nil then
		self._Character = self:getGo("dragObj")

		GameUtil.SetActive(self._Character, true)
	end

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()

	local faceId = MiracleHeroConfig.instance:getRaceFaceId(self._activityId, raceId)

	MaterialMgr.setIcon(self._Character, MatType.PET_SKIN, faceId)

	self._lastRaceId = raceId
	self._dragging = true
end

function MiracleHeroFormationView:_OnDragAssistBegin(go, data, assistId)
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

	if self._Character == nil then
		self._Character = self:getGo("dragObj")

		GameUtil.SetActive(self._Character, true)
	end

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()

	local faceId = MiracleHeroConfig.instance:getAssistFaceId(self._activityId, assistId)

	MaterialMgr.setIcon(self._Character, MatType.PET_SKIN, faceId)

	self._lastAssistId = assistId
	self._dragging = true
end

function MiracleHeroFormationView:_OnDragPetMoved(go, data)
	if self._dragging and self._Character then
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

function MiracleHeroFormationView:_OnDragSeatPetMoved(go, data)
	if not self._Character then
		return
	end

	self:_OnDragPetMoved(go, data)
end

function MiracleHeroFormationView:_OnDragPetEnded(go, data)
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

	if self._Character then
		MaterialMgr.clearIcon(self._Character)

		self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()
	end
end

function MiracleHeroFormationView:_OnDragSeatPetEnded(go, data)
	if not self._Character then
		return
	end

	self:_OnDragPetEnded(go, data)
end

function MiracleHeroFormationView:_OnDropSeat(go, data, posId)
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
				cell.faceId = MiracleHeroConfig.instance:getRaceFaceId(self._activityId, cell.info.curRace)

				self:_setHead(cell.icon, cell.faceId)

				local petCfg = MiracleHeroConfig.instance:getPetCfg(self._activityId, cell.info.curRace)

				if petCfg then
					local cfg = MiracleHeroConfig.instance:getRaceType(petCfg.elementId)

					cell.petTypeChange:SetState(petCfg.elementId - 1)
				end
			end

			self:_refreshRaceList()
		end
	end
end

function MiracleHeroFormationView:_OnDropAssistSeat(go, data)
	if self._lastAssistId and self._lastAssistId ~= self._assistId then
		self._assistId = self._lastAssistId
		self._assistCell.faceId = MiracleHeroConfig.instance:getAssistFaceId(self._activityId, self._assistId)

		self:_setHead(self._assistCell.icon, self._assistCell.faceId)
		self:_refreshRaceList()
	end
end

function MiracleHeroFormationView:_setHead(icon, faceId)
	if icon then
		goutil.setActive(icon, false)

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(faceId))

		if modelCo ~= nil then
			goutil.setActive(icon, true)
			uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		end
	end
end

function MiracleHeroFormationView:getCurPosIds()
	local posIds = {}

	for i = 1, #self._myFormationCellList do
		local info = self._myFormationCellList[i].info

		if info then
			table.insert(posIds, info.curRace)
		end
	end

	return posIds
end

function MiracleHeroFormationView:saveFormation()
	local posIds = self:getCurPosIds()

	MiracleHeroController.instance:sendPM_MiracleHeroSetFormationReq(self._activityId, posIds, self._assistId)
end

function MiracleHeroFormationView:_updateCellPet(view, cellGo, raceId)
	local cell = self:_clearCellPet(cellGo)

	if raceId then
		self._beginDragHandleHash[cell.frame] = BeginDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetCellBegin(go, data, raceId)
		end)
		self._dragHandleHash[cell.frame] = DragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetMoved(go, data)
		end)
		self._endDragHandleHash[cell.frame] = EndDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetEnded(go, data)
		end)

		local skinId = MiracleHeroConfig.instance:getRaceFaceId(self._activityId, raceId)
		local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
		local showRaceId = petSkinCfg.raceId
		local proxy = MaterialMgr.setCell(MatType.Pet, showRaceId, cell.con)

		if proxy then
			proxy:setAutoTips(false)
			proxy.binder:setSkin(skinId)
		end

		goutil.setActive(cell.markOnForm, table.indexof(self._curRaceIdsOnForm, raceId))
		GameUtil.addClickHandler(cell.frame, GameUtil.handler(self._onClickPetCell, self, raceId))
	end
end

function MiracleHeroFormationView:_updateCellAssist(view, cellGo, assistId)
	local cell = self:_clearCellPet(cellGo)

	if assistId then
		self._beginDragHandleHash[cell.frame] = BeginDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragAssistBegin(go, data, assistId)
		end)
		self._dragHandleHash[cell.frame] = DragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetMoved(go, data)
		end)
		self._endDragHandleHash[cell.frame] = EndDragHandler.Get(cell.frame):AddLuaHandler(function(go, data)
			self:_OnDragPetEnded(go, data)
		end)

		local skinId = MiracleHeroConfig.instance:getAssistFaceId(self._activityId, assistId)
		local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
		local showRaceId = petSkinCfg.raceId
		local proxy = MaterialMgr.setCell(MatType.Pet, showRaceId, cell.con)

		if proxy then
			proxy:setAutoTips(false)
			proxy.binder:setSkin(skinId)
		end

		goutil.setActive(cell.markOnForm, self._assistId == assistId)
		GameUtil.addClickHandler(cell.frame, GameUtil.handler(self._onClickAssistCell, self, assistId))
	end
end

function MiracleHeroFormationView:_clearCellPet(cellGo)
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

	GameUtil.rmClickHandler(cell.frame)

	return cell
end

function MiracleHeroFormationView:_refreshRaceList()
	if self._curSwitchId == 1 then
		local unLockIds = MiracleHeroModel.instance:getCurUnlockRaceId(self._activityId)

		self._curRaceIdsOnForm = self:getCurPosIds()

		table.sort(unLockIds, function(a, b)
			local posIdA = table.indexof(self._curRaceIdsOnForm, a)
			local posIdB = table.indexof(self._curRaceIdsOnForm, b)

			if posIdA and not posIdB then
				return true
			elseif not posIdA and posIdB then
				return false
			else
				return a < b
			end
		end)
		self._tableView:reloadData(unLockIds)
	else
		local unlockAssistIds = MiracleHeroModel.instance:getCurUnlockAssistId(self._activityId)

		table.sort(unlockAssistIds, function(a, b)
			if a == self._assistId and b ~= self._assistId then
				return true
			elseif a ~= self._assistId and b == self._assistId then
				return false
			else
				return a < b
			end
		end)
		self._tableViewAssist:reloadData(unlockAssistIds)
	end
end

function MiracleHeroFormationView:_onSwitchList(id)
	if self._curSwitchId ~= id then
		self._curSwitchId = id

		for i = 1, #self._switchBtns do
			local cell = self._switchBtns[i]

			cell.change:SetState(self._curSwitchId == i and 0 or 1)
		end

		goutil.setActive(self._tableviewGo, self._curSwitchId == 1)
		goutil.setActive(self._tableviewGoAssist, self._curSwitchId == 2)
		self:_refreshRaceList()
	end
end

function MiracleHeroFormationView:_updateSpeed()
	local mySpeed = MiracleHeroModel.instance:getMyTeamTotalSpeed(self._activityId, self:getCurPosIds())
	local enemySpeed = MiracleHeroModel.instance:getenemyTeamTotalSpeed(self._activityId, self._stageCfg.creepsMasterId)
	local isFirst = enemySpeed <= mySpeed

	self._mySpeedTxt.text = mySpeed

	self._mySpeedChange:SetState(isFirst and 0 or 1)

	self._enemySpeedTxt.text = enemySpeed

	self._enemySpeedChange:SetState(isFirst and 1 or 0)
end

function MiracleHeroFormationView:_loadVsEffect()
	local path = "fx_ui_zhanqianzhunbei/fx_ui_zhanqianzhunbei_vs.prefab"
	local effect = UIEffectManager.instance:playEffect(self, path, self._vsEffPos.transform, 0, 0, true, false)

	effect:setParent(self._vsEffPos.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	effect.hideEffWhileNotOnTop = false
	self._vsEffect = effect
end

function MiracleHeroFormationView:_removeVsEffect()
	if self._vsEffect then
		UIEffectManager.instance:stopEffect(self._vsEffect)

		self._vsEffect = nil
	end
end

function MiracleHeroFormationView:_onClickGotoLevelUp()
	self:_jumpToMyTeamView(self._activityId)
end

function MiracleHeroFormationView:_jumpToMyTeamView(...)
	UIStateManager.instance:push(ViewName.MiracleHeroMyTeamView, ...)
end

return MiracleHeroFormationView
