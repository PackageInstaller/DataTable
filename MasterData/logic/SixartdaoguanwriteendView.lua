-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanwriteendView.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanwriteendView", package.seeall)

local SixartdaoguanwriteendView = class("SixartdaoguanwriteendView", ViewComponent)

function SixartdaoguanwriteendView:ctor()
	SixartdaoguanwriteendView.super.ctor(self)
end

function SixartdaoguanwriteendView:unbindEvents()
	SixartdaoguanwriteendView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function SixartdaoguanwriteendView:bindEvents()
	SixartdaoguanwriteendView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function SixartdaoguanwriteendView:buildUI()
	SixartdaoguanwriteendView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtRead = self:getTxt("txtRead")
	self._cellconGo = self:getGo("cellcon")
	self._cellGo = self:getGo("cell")
	self._singleLine = self:getGo("cellcon"):GetComponent(ComponentType.UILayoutSingleLine)

	goutil.setActive(self._cellGo, false)

	self._txtNotKillGo = self:getGo("txtNotKill")
	self._cells = {}
end

function SixartdaoguanwriteendView:onExit()
	SixartdaoguanwriteendView.super.onExit(self)
	self:_destroyCells()
end

function SixartdaoguanwriteendView:onEnter()
	SixartdaoguanwriteendView.super.onEnter(self)

	self._result = SixartdaoguanModel.instance:getBattleResultMsg()

	self:_updateUI()
end

function SixartdaoguanwriteendView:_updateUI()
	self:_updatePets()
	self:_updateDesc()
end

function SixartdaoguanwriteendView:_updatePets()
	self:_destroyCells()

	if not self._result.killList then
		local killList = {}
		local isNotKill = #killList <= 0

		goutil.setActive(self._txtNotKillGo, isNotKill)

		if isNotKill then
			return
		end

		local stageCfg = SixartdaoguanConfig.instance:getStageCfg(self._result.activityId, self._result.challengeId, self._result.stageId)

		self._creepsMasterId = stageCfg.creepsMasterId
		self._creepsCfgs = SixartdaoguanConfig.instance:getCreepsCfgs(self._creepsMasterId)

		for i, raceId in ipairs(killList) do
			local go = goutil.cloneAndSetParent(self._cellGo, self._cellconGo.transform)

			self:_updateCell(go, raceId)
			goutil.setActive(go, true)
			table.insert(self._cells, go)
		end

		self._singleLine:Layout()
	end
end

function SixartdaoguanwriteendView:_updateCell(cell, raceId)
	local goItem = goutil.findChild(cell.gameObject, "item")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local petMo = self:_createPetMo(raceId)

	MaterialMgr.setCellByData(MatType.Pet, petMo, goItem)

	local creepCfg = SixartdaoguanConfig.instance:getCreepsCfgByRaceId(self._creepsMasterId, raceId)

	txtDesc.text = creepCfg.paramStr
end

function SixartdaoguanwriteendView:_onClickbtnSure()
	BattleFacade.instance:endBattle()
end

function SixartdaoguanwriteendView:_updateDesc()
	local stageCfg = SixartdaoguanConfig.instance:getStageCfg(self._result.activityId, self._result.challengeId, self._result.stageId)

	if not self._result.killList then
		local creepsCfgs = SixartdaoguanConfig.instance:getCreepsCfgs(stageCfg.creepsMasterId)
		local raceId2Word = {}
		local strList = {}

		for i, v in pairs(creepsCfgs) do
			raceId2Word[v.raceId] = v.paramStr
		end

		for i, v in ipairs(stageCfg.killRaceIds) do
			table.insert(strList, raceId2Word[v])
		end

		local isRead = false

		if #stageCfg.killRaceIds == #self._result.killList then
			isRead = true

			for i, v in ipairs(stageCfg.killRaceIds) do
				if v ~= self._result.killList[i] then
					isRead = false

					break
				end
			end
		end

		self._txtRead.text = isRead and "已完成" or "未完成"
		self._txtDesc.text = table.concat(strList, "")
	end
end

function SixartdaoguanwriteendView:_createPetMo(raceId)
	local creepCfg = SixartdaoguanConfig.instance:getCreepsCfgByRaceId(self._creepsMasterId, raceId)
	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(creepCfg)

	return fPowerPet:toBaseBagPetMo()
end

function SixartdaoguanwriteendView:_destroyCells()
	for i, v in ipairs(self._cells) do
		goutil.destroy(v)
	end

	self._cells = {}
end

return SixartdaoguanwriteendView
