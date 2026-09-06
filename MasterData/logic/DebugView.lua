-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/DebugView.lua

module("logic.extensions.gm.view.DebugView", package.seeall)

local DebugView = class("DebugView", ViewComponent)

DebugView.TestBattleSkinIdKey = "TestBattleSkinIdKey"
DebugView.TestBattleUISkinIdKey = "TestBattleUISkinIdKey"

function DebugView:ctor()
	DebugView.super:ctor()
end

function DebugView:buildUI()
	self._closeButton = self:getBtn("top/Close")
	self._ourFormIdInput = self:getInput("formationview1/our/formId")
	self._ourFormLevelInput = self:getInput("formationview1/our/InputField")
	self._ourBtnFor = self:getGo("formationview1/our/BtnFor")
	self._ourInputCreep = self:getInput("formationview1/our/InputCreep")
	self._ourBtnCreep = self:getGo("formationview1/our/BtnCreep")
	self._ourMasterIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/masterIdx")
	self._ourSummonIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/summonIdx")
	self._ourElementMasterIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/elementMasterIdx")
	self._ourElementTargetIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/elementTargetIdx")
	self._ourHeroSkillIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/heroSkillIdx")
	self._ourCarriedMasterIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/carriedMasterIdx")
	self._ourCarriedIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/carriedIdx")
	self._ourOracleMasterIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/oracleMasterIdx")
	self._ourOraclePetIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/oraclePetIdx")
	self._ourHeavenAwakenMasterIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/heavenAwakenMasterIdx")
	self._ourHeavenAwakenPetIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/heavenAwakenPetIdx")
	self._ourBookSpiritRaceIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/bookSpiritRaceIdx")
	self._ourSpiritInvocationIdx = self:getInput("formationview1/our/ScrollView/Viewport/Content/spiritInvocationIdx")
	self._enemyFormIdInput = self:getInput("formationview1/enemy/formId")
	self._enemyFormLevelInput = self:getInput("formationview1/enemy/InputField")
	self._enemyBtnFor = self:getGo("formationview1/enemy/BtnFor")
	self._enemyInputCreep = self:getInput("formationview1/enemy/InputCreep")
	self._enemyBtnCreep = self:getGo("formationview1/enemy/BtnCreep")
	self._enemyMasterIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/masterIdx")
	self._enemySummonIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/summonIdx")
	self._enemyElementMasterIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/elementMasterIdx")
	self._enemyElementTargetIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/elementTargetIdx")
	self._enemyHeroSkillIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/heroSkillIdx")
	self._enemyCarriedMasterIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/carriedMasterIdx")
	self._enemyCarriedIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/carriedIdx")
	self._enemyOracleMasterIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/oracleMasterIdx")
	self._enemyOraclePetIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/oraclePetIdx")
	self._enemyHeavenAwakenMasterIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/heavenAwakenMasterIdx")
	self._enemyheavenAwakenPetIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/heavenAwakenPetIdx")
	self._enemyBookSpiritRaceIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/bookSpiritRaceIdx")
	self._enemySpiritInvocationIdx = self:getInput("formationview1/enemy/ScrollView/Viewport/Content/spiritInvocationIdx")
	self.scrollGo = self:getGo("Scroll")
	self.scrollView = self:getGo("Scroll/ScrollView")
	self._cell = self:getGo("Cell")
	self.tableView = ScrollerList.create(self.scrollView, self._cell, GameUtil.handler(self.updateSearchCell, self))
	self._ourFrameArr = {}
	self._enemyFrameArr = {}
	self._ourInBag = {}
	self._ourIdInput = {}
	self._ourLvlInput = {}
	self._enemyInBag = {}
	self._enemyIdInput = {}
	self._enemyLvlInput = {}

	for i = -9, 9 do
		self._ourIdInput[i] = self:getInput("formationview1/our/seat" .. i .. "/idInput")
		self._ourInBag[i] = self:getGo("formationview1/our/seat" .. i .. "/inBagImg")
		self._ourLvlInput[i] = self:getInput("formationview1/our/seat" .. i .. "/InputField")
		self._ourFrameArr[i] = self:getBtn("formationview1/our/seat" .. i .. "/frame")
		self._enemyIdInput[i] = self:getInput("formationview1/enemy/seat" .. i .. "/idInput")
		self._enemyInBag[i] = self:getGo("formationview1/enemy/seat" .. i .. "/inBagImg")
		self._enemyLvlInput[i] = self:getInput("formationview1/enemy/seat" .. i .. "/InputField")
		self._enemyFrameArr[i] = self:getBtn("formationview1/enemy/seat" .. i .. "/frame")

		BeginDragHandler.Get(self._ourFrameArr[i].gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetBegin(go, data, FightModel.TYPE_MY, i)
		end)
		DragHandler.Get(self._ourFrameArr[i].gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetMoved(go, data, FightModel.TYPE_MY, i)
		end)
		EndDragHandler.Get(self._ourFrameArr[i].gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetEnded(go, data, FightModel.TYPE_MY, i)
		end)
		DropHandler.Get(self._ourFrameArr[i].gameObject):AddLuaHandler(function(_go, eventData)
			self:_OnDropSeat(_go, eventData, FightModel.TYPE_MY, i)
		end)
		BeginDragHandler.Get(self._enemyFrameArr[i].gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetBegin(go, data, FightModel.TYPE_ENEMY, i)
		end)
		DragHandler.Get(self._enemyFrameArr[i].gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetMoved(go, data, FightModel.TYPE_ENEMY, i)
		end)
		EndDragHandler.Get(self._enemyFrameArr[i].gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetEnded(go, data, FightModel.TYPE_ENEMY, i)
		end)
		DropHandler.Get(self._enemyFrameArr[i].gameObject):AddLuaHandler(function(_go, eventData)
			self:_OnDropSeat(_go, eventData, FightModel.TYPE_ENEMY, i)
		end)
	end

	self:_addDragDropEvent(self._ourMasterIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourSummonIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourElementMasterIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourElementTargetIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourHeroSkillIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourCarriedMasterIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourCarriedIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourOracleMasterIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourOraclePetIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourHeavenAwakenMasterIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourHeavenAwakenPetIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourBookSpiritRaceIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._ourSpiritInvocationIdx, FightModel.TYPE_MY)
	self:_addDragDropEvent(self._enemyMasterIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemySummonIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemyElementMasterIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemyElementTargetIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemyHeroSkillIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemyCarriedMasterIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemyCarriedIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemyOracleMasterIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemyOraclePetIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemyHeavenAwakenMasterIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemyheavenAwakenPetIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemyBookSpiritRaceIdx, FightModel.TYPE_ENEMY)
	self:_addDragDropEvent(self._enemySpiritInvocationIdx, FightModel.TYPE_ENEMY)

	self._challengeBtn = self:getBtn("formationview1/start")
	self._buffBtn = self:getBtn("buffBtn")
	self._buffPanel = self:getGo("buffPanel")
	self._buffClosePanel = self:getBtn("buffPanel/container/closeBtn")
	self._leftBuffInput = self:getInput("buffPanel/container/leftInput")
	self._rightBuffInput = self:getInput("buffPanel/container/rightInput")
	self._allBuffInput = self:getInput("buffPanel/container/allInput")
	self._Btn_Model = self:getBtn("Btn_Model")
	self._Txt_Model = self:getGo("Btn_Model/Text"):GetComponent(goutil.Type_UIText)
	self._ourModel = self:getGo("formationview1/our/teamName"):GetComponent(goutil.Type_UIText)
	self._enemyModel = self:getGo("formationview1/enemy/teamName"):GetComponent(goutil.Type_UIText)
	self._ourEmptyArr = {}
	self._ourPetArr = {}
	self._ourCanSummon = {}
	self._enemyEmptyArr = {}
	self._enemyPetArr = {}
	self._enemyCanSummon = {}
	self._sceneBtn = self:getBtn("ButtonScene")
	self._sceneName = goutil.findChildTextComponent(self.mainGO, "ButtonScene/Text")
	self._sceneName.text = "default"
	self._sceneList = self:getGo("SceneList")

	self._sceneList:SetActive(false)

	self.scrollList = ScrollerList.create(self:getGo("SceneList/tableview"), self:getGo("SceneList/tablecell"), GameUtil.handler(self.updateSceneCell, self))

	self.scrollList:reloadData(GMBattleSceneConfig.ALL_SCENES_CFG)

	self._isDoingSummon = false
	self._btnSave = self:getBtn("btnSave")
	self._btnClear = self:getBtn("btnClear")
	self._btnBattleUISkin = self:getBtn("btnBattleUISkin")
	self._btnBattleSkin = self:getBtn("btnBattleSkin")
	self._battleSkinListGo = self:getGo("battleSkinList")
	self._battleUISkinListGo = self:getGo("battleUISkinList")

	self._battleSkinListGo:SetActive(false)
	self._battleUISkinListGo:SetActive(false)

	self._battleSkinScrollList = ScrollerList.create(self:getGo("battleSkinList/tableview"), self:getGo("battleSkinList/tablecell"), GameUtil.handler(self._updateBattleSkinCell, self))
	self._battleUISkinScrollList = ScrollerList.create(self:getGo("battleUISkinList/tableview"), self:getGo("battleUISkinList/tablecell"), GameUtil.handler(self._updateBattleUISkinCell, self))
	self._txtBtnBattleSkin = goutil.findChildTextComponent(self.mainGO, "btnBattleSkin/Text")
	self._txtBtnBattleSkin.text = "默认"
	self._txtBtnBattleUISkin = goutil.findChildTextComponent(self.mainGO, "btnBattleUISkin/Text")
	self._txtBtnBattleUISkin.text = "默认"
	self._btnImport = self:getBtn("btnImport")
	self._btnExport = self:getBtn("btnExport")
end

function DebugView:_addDragDropEvent(inputAdt)
	DropHandler.Get(inputAdt.gameObject):AddLuaHandler(function(_go, eventData)
		self:_OnDropUpInput(_go, eventData, inputAdt)
	end)
end

function DebugView:_OnDropUpInput(go, eventData, inputAdt, type, idx)
	if self.lastIdx then
		inputAdt.input.text = self.lastIdx
	end
end

function DebugView:updateSceneCell(view, cell, data, tag)
	local txt = goutil.findChildTextComponent(cell, "Text")

	txt.text = data

	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(cell, function()
		BattleModel.instance.testBattleSceneName = data

		self._sceneList:SetActive(false)

		self._sceneName.text = data
	end)
end

function DebugView:_OnDragPetBegin(go, data, type, idx)
	if self._Character == nil then
		self._Character = self:getGo("dragObj")

		GameUtil.SetActive(self._Character, true)
	end

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()
	self.lastType = nil
	self.lastIdx = nil

	local tem = FightModel.instance:getData(type, idx)

	if checknumber(tem.curFace) > 0 then
		self.lastType = type
		self.lastIdx = idx

		MaterialMgr.setIcon(self._Character, 100, tem.curFace)
	end
end

function DebugView:_OnDragPetMoved(go, data)
	if not self._Character then
		return
	end

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function DebugView:_OnDragPetEnded(go, data)
	if not self._Character then
		return
	end

	MaterialMgr.clearIcon(self._Character)
end

function DebugView:_OnDropSeat(go, eventData, type, idx)
	if self.lastIdx and self.lastType then
		FightModel.instance:changeIdxA2B(self.lastType, self.lastIdx, type, idx)
		self:_updateSeat(self.lastType, self.lastIdx)
		self:_updateSeat(type, idx)
	end
end

function DebugView:onExit()
	self.unregisterLocalNotify(self, FightModel.EVENT_IDX_UPDATE, self._onIdxUpdate, self)
	self.unregisterLocalNotify(self, FightModel.EVENT_SUMMON_UPDATE, self._onUpdateSummon, self)
	self.tableView:dispose()
	self.scrollList:dispose()
	self:_onStartChallenge(true)
	self._battleSkinScrollList:dispose()
	self._battleUISkinScrollList:dispose()
end

function DebugView:onEnter()
	self:_setDefaultFmt()

	self._ourFormIdInput.input.text = "10"

	self:_onOurFormIdValueChange(self._ourFormIdInput.input.text)

	self._enemyFormIdInput.input.text = "10"

	self:_onEnemyFormIdValueChange(self._enemyFormIdInput.input.text)

	self._battleModel = ""
	self._Txt_Model.text = "模式"
	self.currIdInput = nil

	self.registerLocalNotify(self, FightModel.EVENT_IDX_UPDATE, self._onIdxUpdate, self)
	self.registerLocalNotify(self, FightModel.EVENT_SUMMON_UPDATE, self._onUpdateSummon, self)

	self._testBattleSkinId = GameUtil.getUserData(DebugView.TestBattleSkinIdKey) or 0
	self._testBattleUISkinId = GameUtil.getUserData(DebugView.TestBattleUISkinIdKey) or 0

	self:_reloadBattleConfigs()
end

function DebugView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._challengeBtn:AddClickListener(self._onStartChallenge, self)
	self._ourFormIdInput:AddOnValueChanged(self._onOurFormIdValueChange, self)
	self._enemyFormIdInput:AddOnValueChanged(self._onEnemyFormIdValueChange, self)
	self._buffBtn:AddClickListener(self._onBuffPanel, self)
	self._buffClosePanel:AddClickListener(self._onBuffPanelClose, self)
	self._Btn_Model:AddClickListener(self._onSelectModel, self)
	GameUtil.addClickHandler(self._ourBtnFor, GameUtil.handler(self.onGetMyFormation, self, self._ourIdInput, self._ourLvlInput, FightModel.TYPE_MY))
	GameUtil.addClickHandler(self._enemyBtnFor, GameUtil.handler(self.onGetMyFormation, self, self._enemyIdInput, self._enemyLvlInput, FightModel.TYPE_ENEMY))
	GameUtil.addClickHandler(self._ourBtnCreep, GameUtil.handler(self.onMyCreep, self, self._ourIdInput, self._ourLvlInput))
	GameUtil.addClickHandler(self._enemyBtnCreep, GameUtil.handler(self.onEnemyCreep, self, self._enemyIdInput, self._enemyLvlInput))

	for i = -9, 9 do
		local function onOurIdInputValue(value)
			self:_onOurIdInputValue(i, value, FightModel.TYPE_MY)
		end

		self._ourIdInput[i]:AddOnValueChanged(onOurIdInputValue)
		GameUtil.addClickHandler(self._ourIdInput[i].input, function()
			self.scrollGo:SetActive(false)

			self.currIdInput = self._ourIdInput[i]
		end)

		local function onOurLvlInputValue(value)
			self:_onOurLvlInputValue(i, value, FightModel.TYPE_MY)
		end

		self._ourLvlInput[i]:AddOnValueChanged(onOurLvlInputValue)

		local function onEnemyIdInputValue(value)
			self:_onEnemyIdInputValue(i, value, FightModel.TYPE_ENEMY)
		end

		self._enemyIdInput[i]:AddOnValueChanged(onEnemyIdInputValue)
		GameUtil.addClickHandler(self._enemyIdInput[i].input, function()
			self.scrollGo:SetActive(false)

			self.currIdInput = self._enemyIdInput[i]
		end)

		local function onEnemyLvlInputValue(value)
			self:_onEnemyLvlInputValue(i, value, FightModel.TYPE_ENEMY)
		end

		self._enemyLvlInput[i]:AddOnValueChanged(onEnemyLvlInputValue)

		local function onOurFrame()
			self:openEditPanel(FightModel.TYPE_MY, i)
		end

		self._ourFrameArr[i]:AddClickListener(onOurFrame)

		local function onEnemyFrame()
			self:openEditPanel(FightModel.TYPE_ENEMY, i)
		end

		self._enemyFrameArr[i]:AddClickListener(onEnemyFrame)
	end

	self._sceneBtn:AddClickListener(function()
		self._sceneList:SetActive(not self._sceneList.activeSelf)
	end)
	self._btnSave:AddClickListener(self._onClickbtnSave, self)
	self._btnClear:AddClickListener(self._onClickbtnClear, self)
	self._btnBattleUISkin:AddClickListener(self._onClickbtnBattleUISkin, self)
	self._btnBattleSkin:AddClickListener(self._onClickbtnBattleSkin, self)
	self._btnImport:AddClickListener(self._onClickbtnImport, self)
	self._btnExport:AddClickListener(self._onClickbtnExport, self)
end

function DebugView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._buffBtn:RemoveClickListener()
	self._buffClosePanel:RemoveClickListener()
	self._ourFormIdInput:RemoveOnValueChanged()
	self._Btn_Model:RemoveClickListener()
	self._sceneBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._ourBtnFor)
	GameUtil.rmClickHandler(self._enemyBtnFor)
	self._btnSave:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	self._btnBattleUISkin:RemoveClickListener()
	self._btnBattleSkin:RemoveClickListener()
	self._btnImport:RemoveClickListener()
	self._btnExport:RemoveClickListener()
end

function DebugView:getMyEquipStr(petMo)
	local res = {}

	for k, tem in pairs(petMo.equipments or {}) do
		local id = tem.id
		local cfgId = checknumber(tem.defineId)
		local lvl = checknumber(tem.lv)

		if checknumber(id) > 0 then
			local equip = PetEquipModel.instance:GetEquipInfo(id)

			if equip then
				local str = equip:getDefineId() .. ":" .. equip.starCount

				table.insert(res, str)
			end
		end
	end

	return (table.concat(res, "#"))
end

function DebugView:getMyRuneSuit(petMo)
	local res = {}
	local suitId = -1

	if petMo.runeSuit then
		suitId = petMo.runeSuit.runeSuitId

		local isMyRuneSuit = petMo.isMyPackPet

		if isMyRuneSuit then
			local suitMo = RuneModel.instance:getSuitMo(suitId)

			if suitMo then
				for k, v in pairs(suitMo.slots) do
					local mo = v:getRuneMo()
					local fid = mo:getDefineId()
					local lvl = mo.level

					table.insert(res, fid .. ":" .. lvl)
				end
			end
		end
	end

	return (#res > 0 and suitId > 0 or nil) and suitId .. "_" .. table.concat(res, "#")
end

function DebugView:onGetMyFormation(arr, lvArr, ftype)
	local team = FormationNewModel.instance:GetCurTeam()

	if team then
		local from = team:GetCurFormation()

		if from then
			local pos = from:GetPositions()

			for i = 1, 9 do
				local petId = pos[i]

				self.notShowList = true

				if checknumber(petId) > 0 then
					local petMo = BagPetsController.instance:getPet(petId)
					local curFaceId = checknumber(petMo.curFaceId)
					local creep = FightModel.instance:getData(ftype, i, curFaceId)

					creep.level = checknumber(petMo.level)
					creep.talentLevel = checknumber(petMo.talentLevel)
					creep.awakenLv = checknumber(petMo.awakenLv)
					creep.equipment = self:getMyEquipStr(petMo)
					creep.runeSuit = self:getMyRuneSuit(petMo)
					creep.extProperties = ""
					creep.myPetId = petId
				else
					local creep = FightModel.instance:getData(ftype, i)

					FightModel.instance:clearCreepData(creep, i, 0)
				end

				self:_updateSeat(ftype, i)

				self.notShowList = nil
			end
		end
	end
end

function DebugView:onSetForStr(ftype, text, arr, lvArr)
	local str = text
	local tem = string.split(str, " ")
	local type = checknumber(tem[1])
	local id = checknumber(tem[#tem])
	local cfg

	if type == 1 then
		cfg = ChallengeConfig.instance:getCreepCfg(id)
	elseif type == 2 then
		cfg = CopyConfig.instance:getTeamPets(id)
	elseif type == 3 then
		cfg = WTowerConfig.instance:getCrpCfg(id)
	elseif type == 4 then
		cfg = ExpeditionConfig.instance:getCreepCfg(id)
	elseif type == 5 then
		cfg = KingWayConfig.instance:GetWayCreepsCfg(id)
	elseif type == 6 then
		cfg = NinePlaceConfig.instance:getPetsCfg(id)
	elseif type == 7 then
		cfg = LegendConfig.instance:getLegendChallengeCreepsCfgList(id)
	end

	if cfg then
		for i = 1, 9 do
			local creep = FightModel.instance:createEmptyData(i, 0)

			FightModel.instance:setData(ftype, i, creep)

			local icon

			if ftype == FightModel.TYPE_MY then
				icon = goutil.findChild(self:getGo("formationview1/our/seat" .. i), "icon")

				self:_setHead(icon, 0)
			else
				icon = goutil.findChild(self:getGo("formationview1/enemy/seat" .. i), "icon")
			end

			self:_setHead(icon, 0)
			arr[i]:SetText("")
			lvArr[i]:SetText("")
		end

		for k, v in pairs(cfg) do
			local posId = v.posId
			local creep = FightModel.instance:getData(ftype, posId, v.raceId)

			creep.level = checknumber(v.lv)
			creep.talentLevel = checknumber(v.talentLv)
			creep.awakenLv = checknumber(v.awakenLv)
			creep.equipment = v.equipment or ""
			creep.runeSuit = v.runeSuitSeq or ""
			creep.extProperties = v.extproperties or ""
			creep.onlyUseExtProperties = checkbool(cfg.onlyUseExtProperties)

			if v.extBuffs then
				creep.extBuffs = v.extBuffs
			end

			local icon

			self.notShowList = true

			self:_setHead(ftype == FightModel.TYPE_MY and goutil.findChild(self:getGo("formationview1/our/seat" .. posId), "icon") or goutil.findChild(self:getGo("formationview1/enemy/seat" .. posId), "icon"), creep.curFace)
			arr[posId]:SetText(creep.curFace)
			lvArr[posId]:SetText(creep.level)
		end
	end

	self.notShowList = nil

	self.scrollGo:SetActive(false)
end

function DebugView:onMyCreep(arr, lvArr)
	local text = self._ourInputCreep.input.text

	self:onSetForStr(FightModel.TYPE_MY, text, arr, lvArr)
end

function DebugView:onEnemyCreep(arr, lvArr)
	local text = self._enemyInputCreep.input.text

	self:onSetForStr(FightModel.TYPE_ENEMY, text, arr, lvArr)
end

function DebugView:_onUpdateSummon(data)
	local idx = data.idx
	local type = data.type
	local id = data.id

	for i = 1, 9 do
		if type == FightModel.TYPE_MY then
			if i == idx then
				self._ourIdInput[idx].input.text = "" .. id
				self._ourLvlInput[idx].input.text = ""
			else
				self._ourIdInput[idx].input.text = ""
				self._ourLvlInput[idx].input.text = ""
			end
		elseif i == idx then
			self._enemyIdInput[idx].input.text = "" .. id
			self._enemyLvlInput[idx].input.text = ""
		else
			self._enemyIdInput[idx].input.text = ""
			self._enemyLvlInput[idx].input.text = ""
		end
	end
end

function DebugView:_onIdxUpdate(data)
	local idx = data.idx
	local type = data.type

	self:_updateSeat(type, idx)
end

function DebugView:_updateSeat(type, idx)
	local creep = FightModel.instance:getData(type, idx)

	if type == FightModel.TYPE_MY then
		self._ourIdInput[idx].input.text = "" .. creep.curFace
		self._ourLvlInput[idx].input.text = "" .. creep.level

		GameUtil.SetActive(self._ourInBag[idx], creep.myPetId > 0)
	else
		self._enemyIdInput[idx].input.text = "" .. creep.curFace
		self._enemyLvlInput[idx].input.text = "" .. creep.level

		GameUtil.SetActive(self._enemyInBag[idx], creep.myPetId > 0)
	end
end

function DebugView:openEditPanel(type, idx)
	local tbl, creep

	if type == FightModel.TYPE_MY then
		local curFace = checknumber(self._ourIdInput[idx].input.text)

		creep = FightModel.instance:getData(type, idx, curFace)
		creep.level = checknumber(self._ourLvlInput[idx].input.text)
		tbl = self._ourPetArr
	else
		local curFace = checknumber(self._enemyIdInput[idx].input.text)

		creep = FightModel.instance:getData(type, idx, curFace)
		creep.level = checknumber(self._enemyLvlInput[idx].input.text)
		tbl = self._enemyPetArr
	end

	creep.creepsId = idx % FightModel.CREEPS_ID_LIMIT
	creep.posId = idx

	if creep.level == 0 then
		creep.level = 100
	end

	local editPanel = self._viewPresentor._views[2]

	if tbl[idx] ~= nil then
		editPanel:onShowPanel(type, idx)
	elseif creep.raceId ~= 0 then
		editPanel:onShowPanel(type, idx)
	end
end

function DebugView:_openSummonPanel(type, idx)
	local tbl, sumTb

	if type == FightModel.TYPE_MY then
		tbl = self._ourPetArr
		sumTb = self._ourCanSummon
	else
		tbl = self._enemyPetArr
		sumTb = self._enemyCanSummon
	end

	local summonPanel = self._viewPresentor._views[3]

	if tbl[idx] ~= nil then
		-- block empty
	else
		summonPanel:onShowPanel(type, idx, sumTb)
	end
end

function DebugView:_onClickClose()
	BattleModel.instance.testBattleSceneName = nil

	UIStateManager.instance:pop()
end

function DebugView:_onClickbtnSave()
	self:_onStartChallenge(true)
end

function DebugView:_onClickbtnClear()
	FightModel.instance:clearFmt()
	self:_setFmt(FightModel.TYPE_MY)
	self:_setFmt(FightModel.TYPE_ENEMY)
end

function DebugView:_onOurFormIdValueChange(id)
	self._ourModel.text = ""

	local formationCo = BattleConfig.instance:getFormationCo(checknumber(id))

	if formationCo then
		self._ourModel.text = formationCo.name
		self._ourEmptyArr = {}
		self._ourPetArr = {}

		for i = 1, 9 do
			local go = self:getGo("formationview1/our/seat" .. i).gameObject
			local img = goutil.findChildImageComponent(go, "frame")

			if table.indexof(formationCo.posList, i) then
				Framework.ColorUtil.SetImageColor(img, "#FFFFFFFF")
				go:SetActive(true)

				self._ourPetArr[i] = go
			else
				Framework.ColorUtil.SetImageColor(img, "#FFFF00FF")
				go:SetActive(false)

				self._ourEmptyArr[i] = go
			end
		end
	end
end

function DebugView:updateSearchCell(view, cell, data)
	local desc = goutil.findChild(cell, "Desc"):GetComponent("Text")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Desc")

	desc.text = data.search_name or data.ViewName

	btn:AddClickListener(function()
		self:_clickItem(data)
	end, self)
end

function DebugView:_clickItem(data)
	self.scrollGo:SetActive(false)

	self.notShowList = true

	if self.currIdInput then
		self.currIdInput:SetText(data.id)
	end

	self.notShowList = nil
end

function DebugView:_hideOrShowAllSeat(tbl, isShow)
	for k, go in pairs(tbl) do
		go:SetActive(isShow)
	end
end

function DebugView:_onEnemyFormIdValueChange(id)
	self._enemyModel.text = ""

	local formationCo = BattleConfig.instance:getFormationCo(checknumber(id))

	if formationCo then
		self._enemyModel.text = formationCo.name
		self._enemyEmptyArr = {}
		self._enemyPetArr = {}

		for i = 1, 9 do
			local go = self:getGo("formationview1/enemy/seat" .. i).gameObject
			local img = goutil.findChildImageComponent(go, "frame")

			if table.indexof(formationCo.posList, i) then
				Framework.ColorUtil.SetImageColor(img, "#FFFFFFFF")
				go:SetActive(true)

				self._enemyPetArr[i] = go
			else
				Framework.ColorUtil.SetImageColor(img, "#FFFF00FF")
				go:SetActive(false)

				self._enemyEmptyArr[i] = go
			end
		end
	end
end

function DebugView:_checkCanSummon(tbl, empty, isOur)
	if self._isDoingSummon == false then
		self._isDoingSummon = true

		self:_hideOrShowAllSeat(empty, false)

		local arr

		for k, go in pairs(tbl) do
			local txt = Framework.InputFieldAdapter.GetFrom(go, "idInput")
			local raceId = checknumber(txt.input.text)
			local petCO = CharacterConfig.instance:getPetCo(raceId)

			if petCO ~= nil and PetSkinConfig.instance:checkHasJob(raceId, GameEnum.CareerType.Zhaohuanshi) then
				self:_hideOrShowAllSeat(empty, true)

				arr = arr or {}

				local marr
				local tem = {}

				tem[raceId] = marr

				table.insert(arr, tem)
			end
		end

		if isOur then
			self._ourCanSummon = arr
		else
			self._enemyCanSummon = arr
		end

		local pets = {}

		if arr ~= nil then
			for i, ttt in pairs(arr) do
				for mid, v in pairs(ttt) do
					for a, m in pairs(v) do
						for k, id in pairs(m.petRaceArr) do
							table.insert(pets, id)
						end
					end
				end
			end
		end

		for i, go in pairs(empty) do
			local txt = Framework.InputFieldAdapter.GetFrom(go, "idInput")
			local raceId = checknumber(txt.input.text)
			local petCO = CharacterConfig.instance:getPetCo(raceId)

			if petCO ~= nil then
				if TableUtil.isHad(pets, raceId) then
					-- block empty
				else
					txt.input.text = ""
				end
			else
				txt.input.text = ""
			end
		end

		self._isDoingSummon = false
	end
end

function DebugView:_setHead(icon, value)
	icon.gameObject:SetActive(false)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(value))

	if modelCo ~= nil then
		icon.gameObject:SetActive(true)
		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
	end

	return nil
end

function DebugView:_onOurIdInputValue(idx, value, type)
	local icon = goutil.findChild(self:getGo("formationview1/our/seat" .. idx), "icon")
	local creep = FightModel.instance:getData(type, idx, value)

	creep.creepsId = idx % FightModel.CREEPS_ID_LIMIT
	creep.posId = idx

	self:_setHead(icon, creep.curFace)
	self:_checkCanSummon(self._ourPetArr, self._ourEmptyArr, true)

	if not self._isSetDefault and self.notShowList == nil then
		self.scrollGo:SetActive(true)

		local ret = GMModel.instance:searchPetByStr(value)

		self.tableView:reloadData(ret)
	end

	self.notShowList = nil
end

function DebugView:_onOurLvlInputValue(idx, value, type)
	local creep = FightModel.instance:getData(type, idx)

	creep.level = checknumber(value)
end

function DebugView:_onEnemyIdInputValue(idx, value, type)
	local icon = goutil.findChild(self:getGo("formationview1/enemy/seat" .. idx), "icon")
	local creep = FightModel.instance:getData(type, idx, value)

	creep.creepsId = idx % FightModel.CREEPS_ID_LIMIT
	creep.posId = idx

	self:_setHead(icon, creep.curFace)
	self:_checkCanSummon(self._enemyPetArr, self._enemyEmptyArr, false)

	if not self._isSetDefault and self.notShowList == nil then
		self.scrollGo:SetActive(true)

		local ret = GMModel.instance:searchPetByStr(value)

		self.tableView:reloadData(ret)
	end

	self.notShowList = nil
end

function DebugView:_onEnemyLvlInputValue(idx, value, type)
	local creep = FightModel.instance:getData(type, idx)

	creep.level = checknumber(value)
end

function DebugView:_OnMenuCloseModel()
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnPopupClick, self._OnMenuClickModel, self)
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseModel, self)
end

function DebugView:_OnMenuClickModel(id)
	if id == 1 then
		self._Txt_Model.text = "无动作模式"
		self._battleModel = ""
	elseif id == 2 then
		self._Txt_Model.text = "动作模式"
		self._battleModel = "ACTION"
	end
end

function DebugView:_onSelectModel()
	CommonPopupMenuFacade.instance:addListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseModel, self)
	CommonPopupMenuFacade.instance:addListener(CommonPopupMenuFacade.OnPopupClick, self._OnMenuClickModel, self)

	local t = {}
	local temp_t = {
		value = 1,
		name = "无动作模式"
	}

	table.insert(t, temp_t)

	temp_t = {
		value = 2,
		name = "动作模式"
	}

	table.insert(t, temp_t)
	CommonPopupMenuFacade.instance:OpenView(self._Btn_Model.transform.position, t)
end

function DebugView:_onStartChallenge(isOnlySave)
	local ourOracleMasterId = checknumber(self._ourOracleMasterIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourOraclePetId = checknumber(self._ourOraclePetIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourCarriedMasterId = checknumber(self._ourCarriedMasterIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourCarriedId = checknumber(self._ourCarriedIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourMasterId = checknumber(self._ourMasterIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourSummonId = checknumber(self._ourSummonIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourElementMasterId = checknumber(self._ourElementMasterIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourElementTargetId = checknumber(self._ourElementTargetIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourHeroSkillPosId = checknumber(self._ourHeroSkillIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourHeavenAwakenMasterId = checknumber(self._ourHeavenAwakenMasterIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourHeavenAwakenSummonPetId = checknumber(self._ourHeavenAwakenPetIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourBookSpiritRaceId = checknumber(self._ourBookSpiritRaceIdx.input.text) % FightModel.RACEID_LIMIT
	local ourSpiritInvocationPetId = checknumber(self._ourSpiritInvocationIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local ourHeroSkillId = ""
	local formIdA = checknumber(self._ourFormIdInput.input.text)
	local formationCo = BattleConfig.instance:getFormationCo(checknumber(formIdA))

	if formationCo == nil then
		return nil
	end

	local customMasterA = GMExtension_pb.PM_CustomCreepsMaster()

	customMasterA.creepsMasterId = 1
	customMasterA.creepsMasterName = " "

	for k, v in pairs(formationCo.posList) do
		local skinId = checknumber(self._ourIdInput[v].input.text)

		if skinId == 0 then
			skinId = checknumber(self._ourFormLevelInput.input.text)
		end

		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
		local petCO = CharacterConfig.instance:getPetCo((cfg or nil) and checknumber(cfg.raceId))

		if petCO ~= nil then
			local creep = FightModel.instance:getData(FightModel.TYPE_MY, v, skinId)

			creep.creepsId = v % FightModel.CREEPS_ID_LIMIT
			creep.level = checknumber(self._ourLvlInput[v].input.text)

			if creep.level == 0 then
				creep.level = 100
			end

			creep.posId = v
			creep.summonedCreepsId = ""

			if checknumber(creep.creepsId) == ourMasterId then
				creep.summonedCreepsId = ourSummonId .. ""
			end

			creep.summonMasterId = ""

			if checknumber(creep.creepsId) == ourSummonId then
				creep.summonMasterId = ourMasterId .. ""
			end

			creep.carriedPetId = 0

			if checknumber(creep.creepsId) == ourCarriedMasterId then
				creep.carriedPetId = ourCarriedId
			end

			creep.carriedMasterId = 0

			if checknumber(creep.creepsId) == ourCarriedId then
				creep.carriedMasterId = ourCarriedMasterId
			end

			creep.oraclePetId = 0

			if checknumber(creep.creepsId) == ourOracleMasterId then
				creep.oraclePetId = ourOraclePetId
			end

			creep.oracleMasterId = 0

			if checknumber(creep.creepsId) == ourOraclePetId then
				creep.oracleMasterId = ourOracleMasterId
			end

			creep.elementalMasterId = ""

			if checknumber(creep.creepsId) == ourElementMasterId then
				creep.elementalMasterId = ourElementMasterId .. ""
			end

			creep.elementalTargetId = ""

			if checknumber(creep.posId) == ourElementTargetId then
				creep.elementalTargetId = ourElementTargetId .. ""
			end

			if checknumber(creep.creepsId) == ourHeroSkillPosId and cfg.heroSkillId > 0 then
				ourHeroSkillId = cfg.heroSkillId .. ""
			end

			if checknumber(creep.creepsId) == ourHeavenAwakenSummonPetId then
				creep.posId = -math.abs(creep.posId)
			end

			creep.bookSpiritRaceId = 0

			if ourBookSpiritRaceId > 0 then
				local bookSpiritSkinId = checknumber(self._ourIdInput[v].input.text)

				if bookSpiritSkinId == 0 then
					bookSpiritSkinId = checknumber(self._ourFormLevelInput.input.text)
				end

				local bookSpiritCfg = PetSkinConfig.instance:getPetSkinCfg(bookSpiritSkinId)

				if ContractConfig.instance:getBookSpiritCfgs((bookSpiritCfg or nil) and checknumber(bookSpiritCfg.raceId)) ~= nil then
					creep.bookSpiritRaceId = ourBookSpiritRaceId
				end
			end

			table.insert(customMasterA.creeps, creep)
		end
	end

	for v = -9, 0 do
		local skinId = checknumber(self._ourIdInput[v].input.text)

		if skinId == 0 then
			skinId = checknumber(self._ourFormLevelInput.input.text)
		end

		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
		local petCO = CharacterConfig.instance:getPetCo((cfg or nil) and checknumber(cfg.raceId))

		if petCO ~= nil then
			local creep = FightModel.instance:getData(FightModel.TYPE_MY, v, skinId)

			creep.creepsId = v % FightModel.CREEPS_ID_LIMIT
			creep.level = checknumber(self._ourLvlInput[v].input.text)

			if creep.level == 0 then
				creep.level = 100
			end

			creep.posId = v
			creep.carriedPetId = 0

			if checknumber(creep.creepsId) == ourCarriedMasterId then
				creep.carriedPetId = ourCarriedId
			end

			creep.carriedMasterId = 0

			if checknumber(creep.creepsId) == ourCarriedId then
				creep.carriedMasterId = ourCarriedMasterId
			end

			creep.oraclePetId = 0

			if checknumber(creep.creepsId) == ourOracleMasterId then
				creep.oraclePetId = ourOraclePetId
			end

			creep.oracleMasterId = 0

			if checknumber(creep.creepsId) == ourOraclePetId then
				creep.oracleMasterId = ourOracleMasterId
			end

			table.insert(customMasterA.creeps, creep)
		end
	end

	customMasterA.spiritInvocationPetId = ourSpiritInvocationPetId
	customMasterA.btlItems = " "
	customMasterA.heroSkill = ourHeroSkillId
	customMasterA.extProperties = " "
	customMasterA.extBuffs = self._leftBuffInput.input.text

	if ourHeavenAwakenMasterId > 0 and ourHeavenAwakenSummonPetId > 0 then
		customMasterA.heavenAwakenMasterId = ourHeavenAwakenMasterId
		customMasterA.heavenAwakenSummonPetId = ourHeavenAwakenSummonPetId
	end

	local enemyOracleMasterId = checknumber(self._enemyOracleMasterIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemyOraclePetId = checknumber(self._enemyOraclePetIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemyCarriedMasterId = checknumber(self._enemyCarriedMasterIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemyCarriedId = checknumber(self._enemyCarriedIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemyMasterId = checknumber(self._enemyMasterIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemySummonId = checknumber(self._enemySummonIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemyElementMasterId = checknumber(self._enemyElementMasterIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemyElementTargetId = checknumber(self._enemyElementTargetIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemyroSkillPosId = checknumber(self._enemyHeroSkillIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemyBookSpiritRaceId = checknumber(self._enemyBookSpiritRaceIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemyroSkillId = ""
	local enemyHeavenAwakenMasterId = checknumber(self._enemyHeavenAwakenMasterIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemyHeavenAwakenSummonPetId = checknumber(self._enemyheavenAwakenPetIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local enemySpiritInvocationPetId = checknumber(self._enemySpiritInvocationIdx.input.text) % FightModel.CREEPS_ID_LIMIT
	local formIdB = checknumber(self._enemyFormIdInput.input.text)

	formationCo = BattleConfig.instance:getFormationCo(checknumber(formIdB))

	local customMasterB = GMExtension_pb.PM_CustomCreepsMaster()

	customMasterB.creepsMasterId = 2
	customMasterB.creepsMasterName = " "

	for k, v in pairs(formationCo.posList) do
		local skinId = checknumber(self._enemyIdInput[v].input.text)

		if skinId == 0 then
			skinId = checknumber(self._enemyFormLevelInput.input.text)
		end

		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
		local petCO = CharacterConfig.instance:getPetCo((cfg or nil) and checknumber(cfg.raceId))

		if petCO ~= nil then
			local creep = FightModel.instance:getData(FightModel.TYPE_ENEMY, v, skinId)

			creep.creepsId = v % FightModel.CREEPS_ID_LIMIT
			creep.level = checknumber(self._enemyLvlInput[v].input.text)

			if creep.level == 0 then
				creep.level = 100
			end

			creep.posId = v
			creep.summonedCreepsId = ""

			if checknumber(creep.creepsId) == enemyMasterId then
				creep.summonedCreepsId = enemySummonId .. ""
			end

			creep.summonMasterId = ""

			if checknumber(creep.creepsId) == enemySummonId then
				creep.summonMasterId = enemyMasterId .. ""
			end

			creep.carriedMasterId = 0

			if checknumber(creep.creepsId) == enemyCarriedId then
				creep.carriedMasterId = enemyCarriedMasterId
			end

			creep.carriedPetId = 0

			if checknumber(creep.creepsId) == enemyCarriedMasterId then
				creep.carriedPetId = enemyCarriedId
			end

			creep.oraclePetId = 0

			if checknumber(creep.creepsId) == enemyOracleMasterId then
				creep.oraclePetId = enemyOraclePetId
			end

			creep.oracleMasterId = 0

			if checknumber(creep.creepsId) == enemyOraclePetId then
				creep.oracleMasterId = enemyOracleMasterId
			end

			creep.elementalMasterId = ""

			if checknumber(creep.creepsId) == enemyElementMasterId then
				creep.elementalMasterId = enemyElementMasterId .. ""
			end

			creep.elementalTargetId = ""

			if checknumber(creep.creepsId) == enemyElementTargetId then
				creep.elementalTargetId = enemyElementTargetId .. ""
			end

			if checknumber(creep.creepsId) == enemyroSkillPosId and cfg.heroSkillId > 0 then
				enemyroSkillId = cfg.heroSkillId .. ""
			end

			if checknumber(creep.creepsId) == enemyHeavenAwakenSummonPetId then
				creep.posId = -math.abs(creep.posId)
			end

			creep.bookSpiritRaceId = 0

			if enemyBookSpiritRaceId > 0 then
				local bookSpiritSkinId = checknumber(self._enemyIdInput[v].input.text)

				if bookSpiritSkinId == 0 then
					bookSpiritSkinId = checknumber(self._enemyFormLevelInput.input.text)
				end

				local bookSpiritCfg = PetSkinConfig.instance:getPetSkinCfg(bookSpiritSkinId)

				if ContractConfig.instance:getBookSpiritCfgs((bookSpiritCfg or nil) and checknumber(bookSpiritCfg.raceId)) ~= nil then
					creep.bookSpiritRaceId = enemyBookSpiritRaceId
				end
			end

			table.insert(customMasterB.creeps, creep)
		end
	end

	for v = -9, 0 do
		local skinId = checknumber(self._enemyIdInput[v].input.text)

		if skinId == 0 then
			skinId = checknumber(self._enemyFormLevelInput.input.text)
		end

		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
		local petCO = CharacterConfig.instance:getPetCo((cfg or nil) and checknumber(cfg.raceId))

		if petCO ~= nil then
			local creep = FightModel.instance:getData(FightModel.TYPE_ENEMY, v, skinId)

			creep.creepsId = v % FightModel.CREEPS_ID_LIMIT
			creep.level = checknumber(self._enemyLvlInput[v].input.text)

			if creep.level == 0 then
				creep.level = 100
			end

			creep.posId = v
			creep.carriedMasterId = 0

			if checknumber(creep.creepsId) == enemyCarriedId then
				creep.carriedMasterId = enemyCarriedMasterId
			end

			creep.carriedPetId = 0

			if checknumber(creep.creepsId) == enemyCarriedMasterId then
				creep.carriedPetId = enemyCarriedId
			end

			creep.oraclePetId = 0

			if checknumber(creep.creepsId) == enemyOracleMasterId then
				creep.oraclePetId = enemyOraclePetId
			end

			creep.oracleMasterId = 0

			if checknumber(creep.creepsId) == enemyOraclePetId then
				creep.oracleMasterId = enemyOracleMasterId
			end

			table.insert(customMasterB.creeps, creep)
		end
	end

	customMasterB.spiritInvocationPetId = enemySpiritInvocationPetId
	customMasterB.btlItems = " "
	customMasterB.heroSkill = enemyroSkillId
	customMasterB.extProperties = " "
	customMasterB.extBuffs = self._rightBuffInput.input.text

	if self._allBuffInput.input.text ~= "" then
		customMasterA.extBuffs = self._allBuffInput.input.text
		customMasterB.extBuffs = self._allBuffInput.input.text
	end

	if enemyHeavenAwakenMasterId > 0 and enemyHeavenAwakenSummonPetId > 0 then
		customMasterB.heavenAwakenMasterId = enemyHeavenAwakenMasterId
		customMasterB.heavenAwakenSummonPetId = enemyHeavenAwakenSummonPetId
	end

	FightModel.instance:saveMasterData(FightModel.TYPE_MY, customMasterA)
	FightModel.instance:saveMasterData(FightModel.TYPE_ENEMY, customMasterB)
	FightModel.instance:saveFmt()

	if not isOnlySave then
		if self._testBattleSkinId > 0 then
			BattleModel.instance.testBattleSkinId = self._testBattleSkinId

			GameUtil.saveUserData(DebugView.TestBattleSkinIdKey, self._testBattleSkinId)
		end

		if self._testBattleUISkinId > 0 then
			BattleModel.instance.testBattleUISkinId = self._testBattleUISkinId

			GameUtil.saveUserData(DebugView.TestBattleUISkinIdKey, self._testBattleUISkinId)
		end

		GMAgent.instance:sendPM_CustomBattleReq(customMasterA, customMasterB, " ", self._battleModel)
	end
end

function DebugView:_onBuffPanel()
	self._buffPanel:SetActive(true)
end

function DebugView:_onBuffPanelClose()
	self._buffPanel:SetActive(false)
end

function DebugView:_setDefaultFmt()
	self._isSetDefault = true

	FightModel.instance:loadCacheFmt()
	self:_setFmtFormModel()

	self._isSetDefault = false
end

function DebugView:_setFmt(type)
	for i = -9, 9 do
		local data = FightModel.instance:getData(type, i)

		if type == FightModel.TYPE_MY then
			self._ourIdInput[i]:SetText(data.curFace)
			self._ourLvlInput[i]:SetText(data.level)
			GameUtil.SetActive(self._ourInBag[i], data.myPetId > 0)
			self:_fixPosIdxTxt(self._ourOracleMasterIdx, data.oracleMasterId)
			self:_fixPosIdxTxt(self._ourOraclePetIdx, data.oraclePetId)
			self:_fixPosIdxTxt(self._ourCarriedMasterIdx, data.carriedMasterId)
			self:_fixPosIdxTxt(self._ourCarriedIdx, data.carriedPetId)
			self:_fixPosIdxTxt(self._ourMasterIdx, data.summonMasterId)
			self:_fixPosIdxTxt(self._ourSummonIdx, data.summonedCreepsId)
			self:_fixPosIdxTxt(self._ourElementMasterIdx, data.elementalMasterId)
			self:_fixPosIdxTxt(self._ourElementTargetIdx, data.elementalTargetId)
			self:_fixRaceIdTxt(self._ourBookSpiritRaceIdx, data.bookSpiritRaceId)
		else
			self._enemyIdInput[i]:SetText(data.curFace)
			self._enemyLvlInput[i]:SetText(data.level)
			GameUtil.SetActive(self._enemyInBag[i], data.myPetId > 0)
			self:_fixPosIdxTxt(self._enemyOracleMasterIdx, data.oracleMasterId)
			self:_fixPosIdxTxt(self._enemyOraclePetIdx, data.oraclePetId)
			self:_fixPosIdxTxt(self._enemyCarriedMasterIdx, data.carriedMasterId)
			self:_fixPosIdxTxt(self._enemyCarriedIdx, data.carriedPetId)
			self:_fixPosIdxTxt(self._enemyMasterIdx, data.summonMasterId)
			self:_fixPosIdxTxt(self._enemySummonIdx, data.summonedCreepsId)
			self:_fixPosIdxTxt(self._enemyElementMasterIdx, data.elementalMasterId)
			self:_fixPosIdxTxt(self._enemyElementTargetIdx, data.elementalTargetId)
			self:_fixRaceIdTxt(self._enemyBookSpiritRaceIdx, data.bookSpiritRaceId)
		end
	end
end

function DebugView:_setMaster(type)
	local data = FightModel.instance:getMasterData(type)

	if data then
		if type == FightModel.TYPE_MY then
			self:_fixPosIdxTxt(self._ourHeavenAwakenMasterIdx, data.heavenAwakenMasterId)
			self:_fixPosIdxTxt(self._ourHeavenAwakenPetIdx, data.heavenAwakenSummonPetId)
			self:_fixPosIdxTxt(self._ourSpiritInvocationIdx, data.spiritInvocationPetId)
		else
			self:_fixPosIdxTxt(self._enemyHeavenAwakenMasterIdx, data.heavenAwakenMasterId)
			self:_fixPosIdxTxt(self._enemyheavenAwakenPetIdx, data.heavenAwakenSummonPetId)
			self:_fixPosIdxTxt(self._enemySpiritInvocationIdx, data.spiritInvocationPetId)
		end
	end
end

function DebugView:_fixPosIdxTxt(inputAdt, id)
	if checknumber(id) ~= 0 then
		inputAdt.input.text = checknumber(id) > 9 and checknumber(id) - FightModel.CREEPS_ID_LIMIT .. "" or id .. ""
	end
end

function DebugView:_fixRaceIdTxt(inputAdt, raceId)
	if checknumber(raceId) ~= 0 then
		inputAdt.input.text = raceId .. ""
	end
end

function DebugView:_onClickbtnBattleUISkin()
	self._battleUISkinListGo:SetActive(not self._battleUISkinListGo.activeSelf)
end

function DebugView:_onClickbtnBattleSkin()
	self._battleSkinListGo:SetActive(not self._battleSkinListGo.activeSelf)
end

function DebugView:_updateBattleSkinCell(view, cell, data)
	local txt = goutil.findChildTextComponent(cell, "Text")

	txt.text = data.name

	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(cell, function()
		self._testBattleSkinId = data.id

		self._battleSkinListGo:SetActive(false)

		self._txtBtnBattleSkin.text = data.name
	end)
end

function DebugView:_updateBattleUISkinCell(view, cell, data)
	local txt = goutil.findChildTextComponent(cell, "Text")

	txt.text = data.name

	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(cell, function()
		self._testBattleUISkinId = data.id

		self._battleUISkinListGo:SetActive(false)

		self._txtBtnBattleUISkin.text = data.name
	end)
end

function DebugView:_reloadBattleConfigs()
	local uiskinCfgs = BattleStartAnimConfig.instance:getBattleUISkinCfgs()

	self._battleUISkinScrollList:reloadData(uiskinCfgs)

	local backgroudskinCfgs = BattleStartAnimConfig.instance:getBattleBackgroundSkinCfgs()

	self._battleSkinScrollList:reloadData(backgroudskinCfgs)

	if self._testBattleSkinId > 0 then
		self._txtBtnBattleSkin.text = backgroudskinCfgs[self._testBattleSkinId].name
	end

	if self._testBattleUISkinId > 0 then
		self._txtBtnBattleUISkin.text = uiskinCfgs[self._testBattleUISkinId].name
	end
end

function DebugView:_setFmtFormModel()
	self:_setFmt(FightModel.TYPE_MY)
	self:_setFmt(FightModel.TYPE_ENEMY)
	self:_setMaster(FightModel.TYPE_MY)
	self:_setMaster(FightModel.TYPE_ENEMY)
end

function DebugView:_onClickbtnImport()
	if Framework.OSDef.isEditor then
		local assetPath = UnityEngine.Application.dataPath
		local path = assetPath:sub(1, assetPath:len() - 16) .. "gmFmt.txt"
		local file = io.open(path, "r")

		if file then
			local str = file:read("*a")

			file:close()

			if string.nilorempty(str) then
				printError(path .. "  文本里面必须有内容")

				return
			end

			FightModel.instance:importFormation(str)
			self:_setFmtFormModel()
		else
			printError(path .. " 没这个文件啊，先导进来")
		end
	else
		FloatWordMgr.instance:show("只能编辑器用哦")
	end
end

function DebugView:_onClickbtnExport()
	local txt = FightModel.instance:exportFormation()

	if Framework.OSDef.isEditor then
		local assetPath = UnityEngine.Application.dataPath
		local dir = assetPath:sub(1, assetPath:len() - 16)
		local path = dir .. "gmFmt.txt"

		Framework.FileUtils.Instance:WriteFile(txt, path)
		UnityEngine.Application.OpenURL(dir)
		printError("如果需要让别人布你的阵容，就把 " .. path .. " 拷贝给对方")
	else
		Clipboard.copy(txt)
		FloatWordMgr.instance:show("复制到剪贴板了")
	end
end

return DebugView
