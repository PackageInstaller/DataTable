-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanmusicendView.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanmusicendView", package.seeall)

local SixartdaoguanmusicendView = class("SixartdaoguanmusicendView", ViewComponent)

function SixartdaoguanmusicendView:ctor()
	SixartdaoguanmusicendView.super.ctor(self)
end

function SixartdaoguanmusicendView:unbindEvents()
	SixartdaoguanmusicendView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function SixartdaoguanmusicendView:bindEvents()
	SixartdaoguanmusicendView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function SixartdaoguanmusicendView:buildUI()
	SixartdaoguanmusicendView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._cellconGo = self:getGo("cellcon")
	self._cellGo = self:getGo("cell")
	self._singleLine = self:getGo("cellcon"):GetComponent(ComponentType.UILayoutSingleLine)

	goutil.setActive(self._cellGo, false)

	self._cells = {}
end

function SixartdaoguanmusicendView:onExit()
	SixartdaoguanmusicendView.super.onExit(self)
	self:_destroyCells()
end

function SixartdaoguanmusicendView:onEnter()
	SixartdaoguanmusicendView.super.onEnter(self)

	self._result = SixartdaoguanModel.instance:getBattleResultMsg()

	self:_prepareData()
	self:_updateUI()
end

function SixartdaoguanmusicendView:_onClickbtnSure()
	BattleFacade.instance:endBattle()
end

function SixartdaoguanmusicendView:_updateUI()
	self._condition2Pass = self:_updatePets()

	self:_updateCondition(1)
	self:_updateCondition(2)
end

function SixartdaoguanmusicendView:_updatePets()
	self:_destroyCells()

	local stageCfg = SixartdaoguanConfig.instance:getStageCfg(self._result.activityId, self._result.challengeId, self._result.stageId)

	self._creepsMasterId = stageCfg.creepsMasterId
	self._creepsCfgs = SixartdaoguanConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self._raceId2RoundNum = {}

	local cfgMusicPetDeadCount = 0

	for k, v in pairs(self._creepsCfgs) do
		self._raceId2RoundNum[v.raceId] = checknumber(v.paramStr)

		if self._raceId2RoundNum[v.raceId] > 0 then
			cfgMusicPetDeadCount = cfgMusicPetDeadCount + 1
		end
	end

	if not self._result.deadEnemyIds then
		local deadEnemyIds = {}

		if not self._result.activeEnemyIds then
			local activeEnemyIds = {}
			local deadCnt = #deadEnemyIds
			local list = {}

			table.insertto(list, deadEnemyIds)
			table.insertto(list, activeEnemyIds)

			local hasMusicPetList = {}
			local musicPetDeadCount = 0

			for i, v in ipairs(list) do
				local cfg = self._creepsCfgs[v]

				if checknumber(cfg.paramStr) > 0 then
					table.insert(hasMusicPetList, v)
				end
			end

			for i, v in ipairs(hasMusicPetList) do
				local go = goutil.cloneAndSetParent(self._cellGo, self._cellconGo.transform)
				local isDead = i <= deadCnt

				if isDead then
					musicPetDeadCount = musicPetDeadCount + 1
				end

				self:_updateCell(go, v, isDead)
				goutil.setActive(go, true)
				table.insert(self._cells, go)
			end

			self._singleLine:Layout()

			return musicPetDeadCount == cfgMusicPetDeadCount
		end
	end
end

function SixartdaoguanmusicendView:_updateCell(cell, petId, isDead)
	local goItem = goutil.findChild(cell.gameObject, "item")
	local imgChangeDescBg = goutil.findChild(cell.gameObject, "descBg"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "descBg/txtDesc")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local petMo = self:_createPetMo(petId)

	MaterialMgr.setCellByData(MatType.Pet, petMo, goItem)
	imgChangeDescBg:SetState(isDead and 0 or 1)

	txtDesc.text = isDead and "已击败" or "未击败"
	txtNum.text = self._raceId2RoundNum[petMo.raceId] or 0
end

function SixartdaoguanmusicendView:_createPetMo(petId)
	local creepCfg = SixartdaoguanConfig.instance:getCreepsCfg(self._creepsMasterId, petId)
	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(creepCfg)

	return fPowerPet:toBaseBagPetMo()
end

function SixartdaoguanmusicendView:_destroyCells()
	for i, v in ipairs(self._cells) do
		goutil.destroy(v)
	end

	self._cells = {}
end

function SixartdaoguanmusicendView:_updateCondition(index)
	local go = self:getGo("condition" .. index)

	if go then
		local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
		local imgNotReachedGo = goutil.findChild(go, "imgNotReached")
		local imgReachedGo = goutil.findChild(go, "imgReached")
		local isRead = false

		if index == 1 then
			txtDesc.text = "成功破阵"
			isRead = self._enemyPetNum == self._deadEnemyNums
		elseif index == 2 then
			txtDesc.text = "限定回合内击杀带音符的精灵"
			isRead = self._result.win and self._condition2Pass
		end

		goutil.setActive(imgNotReachedGo, not isRead)
		goutil.setActive(imgReachedGo, isRead)
	end
end

function SixartdaoguanmusicendView:_prepareData()
	local stageCfg = SixartdaoguanConfig.instance:getStageCfg(self._result.activityId, self._result.challengeId, self._result.stageId)

	self._creepsMasterId = stageCfg.creepsMasterId
	self._creepsCfgs = SixartdaoguanConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self._enemyPetNum = table.nums(self._creepsCfgs)

	if self._result.deadEnemyIds then
		self._deadEnemyNums = #self._result.deadEnemyIds or 0
	end
end

return SixartdaoguanmusicendView
