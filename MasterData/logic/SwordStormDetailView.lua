-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/view/SwordStormDetailView.lua

module("logic.extensions.swordstorm.view.SwordStormDetailView", package.seeall)

local SwordStormDetailView = class("SwordStormDetailView", ViewComponent)

function SwordStormDetailView:ctor()
	SwordStormDetailView.super.ctor(self)
end

function SwordStormDetailView:unbindEvents()
	SwordStormDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function SwordStormDetailView:bindEvents()
	SwordStormDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function SwordStormDetailView:buildUI()
	SwordStormDetailView.super.buildUI(self)

	self._btnChallenge = self:getGo("btnChallenge")
	self._btnClose = self:getGo("btnClose")

	local formationGo = self:getGo("formation")

	self._formationGos = {}

	for i = 1, 9 do
		local cell = {}

		cell.go = goutil.findChild(formationGo, "cell_" .. i)
		cell.con = goutil.findChild(cell.go, "con")
		self._formationGos[i] = cell
	end

	self._tableview = self:getGo("info/tableview")
	self._tablecell = self:getGo("info/tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemCell = self:getGo("itemCell")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._txtName = self:getTxt("txtName")
end

function SwordStormDetailView:onExit()
	SwordStormDetailView.super.onExit(self)
	self._tableList:dispose()

	for k, v in pairs(self._itemListDir) do
		v:dispose()
	end

	self._itemListDir = {}
end

function SwordStormDetailView:onEnter()
	SwordStormDetailView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._phaseId = checknumber(params[2])
	self._stageId = checknumber(params[3])

	local stageCfg = SwordStormConfig.instance:getStageCfg(self._activityId, self._phaseId, self._stageId)
	local creepCfg = SwordStormConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)

	for i, v in pairs(self._formationGos) do
		GameUtil.SetActive(v.go, false)
		MaterialMgr.resetAll(v.con)
	end

	for i, v in ipairs(creepCfg) do
		if self._formationGos[v.posId] then
			local cell = self._formationGos[v.posId]

			GameUtil.SetActive(cell.go, true)

			local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, cell.con)

			if proxy then
				proxy.binder:setAutoTips(false)
				proxy.binder:setCallBack(function()
					self:showMaxLvlPetTips(v.raceId)
				end)
			end
		end
	end

	local creepsCfgs = SwordStormConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)

	self._txtName.text = creepsCfgs[1].creepsName
	self._itemListDir = {}
	self._txtDesc.text = stageCfg.ruleDesc

	local conditionCfgs = SwordStormConfig.instance:getConditionPlanCfgs(stageCfg.conditionPlanId)

	self._tableList:reloadData(conditionCfgs)
end

function SwordStormDetailView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local starChange = goutil.findChildComponent(go, "star", ComponentType.UIImageSpriteChange)
	local itemTableview = goutil.findChild(go, "itemTableview")
	local itemTableList = self._itemListDir[go]

	if not itemTableList then
		itemTableList = ScrollerList.create(itemTableview, self._itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		self._itemListDir[go] = itemTableList
	end

	local isComplete = SwordStormModel.instance:getConditionComplete(self._activityId, self._phaseId, self._stageId, data.conditionId)
	local prizeList = {}
	local prizeArray = string.split(data.prize, "#")

	for i, v in ipairs(prizeArray) do
		table.insert(prizeList, {
			prize = v,
			isComplete = isComplete
		})
	end

	itemTableList:reloadData(prizeList)

	if isComplete == true then
		starChange:SetState(0)
	else
		starChange:SetState(1)
	end

	txtDesc.text = SwordStormController.instance:getConditionDesc(data.conditionPlanId, data.conditionId)
end

function SwordStormDetailView:_clearCell(cell)
	local go = cell.gameObject

	if self._itemListDir[go] then
		self._itemListDir[go]:dispose()

		self._itemListDir[go] = nil
	end
end

function SwordStormDetailView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local gain = goutil.findChild(go, "gain")

	MaterialMgr.setCellByCfg(data.prize, con)
	GameUtil.SetActive(gain, data.isComplete)
end

function SwordStormDetailView:_clearItemCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function SwordStormDetailView:_onClickChallenge()
	SwordStormController.instance:openNormalMissionView(self._activityId, self._phaseId, self._stageId)
	self:close()
end

function SwordStormDetailView:showMaxLvlPetTips(raceId, lvl, awakenLv, skinId)
	local co = MaterialMgr.getMatCfg(MatType.Pet, raceId)

	if co then
		if checknumber(lvl) > 0 then
			-- block empty
		else
			lvl = co.maxLv
		end

		local zdl = 0

		if lvl == co.maxLv then
			zdl = FightingPowerFormula.instance:getPetMaxFightingPower(raceId)
		else
			local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, lvl, awakenLv, skinId)

			if tmpMo then
				zdl = tmpMo:getFightingPower()
			end
		end

		local curFaceId = checknumber(skinId)

		if curFaceId == 0 then
			curFaceId = checknumber(raceId)
		end

		local petMo = {
			raceId = raceId,
			level = lvl,
			name = co.name,
			_curZdl = zdl,
			curFaceId = curFaceId
		}

		petMo.awakenLv = awakenLv and awakenLv or CharacterConfig.instance:getMaxAwaken(raceId)

		CommonTipsMgr.instance:showPetTips(petMo, true)
	end
end

return SwordStormDetailView
