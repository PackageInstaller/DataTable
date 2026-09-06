-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilybossbattlesuccessView.lua

module("logic.extensions.family.view.FamilybossbattlesuccessView", package.seeall)

local FamilybossbattlesuccessView = class("FamilybossbattlesuccessView", TableViewComponent)
local UnityTime = UnityEngine.Time
local math_min = math.min

function FamilybossbattlesuccessView:ctor()
	FamilybossbattlesuccessView.super.ctor(self)
end

function FamilybossbattlesuccessView:_getPath()
	return {
		cellPath = "part2/right/reward/itemReward",
		viewPath = "part2/right/reward/rewardList"
	}
end

function FamilybossbattlesuccessView:buildUI()
	FamilybossbattlesuccessView.super.buildUI(self)

	self.btnClose = self:getBtn("btnClose")
	self.targetGo = self:getGo("part2/right/target")
	self.rewardGo = self:getGo("part2/right/reward")
	self.fillImg = self:getGo("part2/right/target/fillImg"):GetComponent("Image")
	self.damageNumText = goutil.findChildTextComponent(self.mainGO, "part2/right/target/damageNumText")
	self.boxNumText = goutil.findChildTextComponent(self.mainGO, "part2/right/target/boxNumText")
	self.animShowGo = self:getGo("part1/animShow")
	self.txtContinue = self:getGo("txtContinue")
	self.dialogbox = self:getGo("part1/dialogbox")
	self.dialogTxt = self:getGo("part1/dialogbox/txt"):GetComponent(goutil.Type_UIText)
	self.roleModel = self:getGo("part1/roleModel")
	self.roleModel.transform.localPosition = Vector3.New(-1500, -228, 0)

	GameUtil.SetActive(self.txtContinue, false)
	GameUtil.SetActive(self.targetGo, false)
	GameUtil.SetActive(self.rewardGo, false)
	GameUtil.SetActive(self.dialogbox, false)

	self._raycast = self:getBtn("part2/right/reward/rewardList/Nego_Viewport/raycast")
end

function FamilybossbattlesuccessView:bindEvents()
	FamilybossbattlesuccessView.super.bindEvents(self)
	self._raycast:AddClickListener(self._onClickraycast, self)
end

function FamilybossbattlesuccessView:unbindEvents()
	FamilybossbattlesuccessView.super.unbindEvents(self)
	self._raycast:RemoveClickListener()
end

function FamilybossbattlesuccessView:destroyUI()
	FamilybossbattlesuccessView.super.destroyUI(self)
end

function FamilybossbattlesuccessView:onEnter()
	FamilybossbattlesuccessView.super.onEnter(self)

	self._tweenDelta = 0
	self._delayFinishTime = 0

	GameUtil.SetActive(self._tableview.gameObject, false)

	self.isShowAllReward = false
	self.canCliclClose = false

	self.btnClose:AddClickListener(self.onClickClose, self)
	self:part1Move()
end

function FamilybossbattlesuccessView:onEnterFinished()
	FamilybossbattlesuccessView.super.onEnterFinished(self)
	self:_showRoleModel()
end

function FamilybossbattlesuccessView:onExit()
	FamilybossbattlesuccessView.super.onExit(self)
	removetimer(self._tweenStrengthNum, self)

	local jumpBossId = 1

	if FamilyModel.instance.bossClgEndData then
		jumpBossId = FamilyModel.instance.bossClgEndData.bossId
	end

	if FamilyModel.instance:isInFamily() then
		-- block empty
	end

	FamilyModel.instance.bossClgEndData = false
	FamilyModel.instance.bossChangeSetId = false

	self:_resetRoleModel()
	self:stopFill()
	self:stopRoleMove()
	self:stopPart1Move()
	removetimer(self._showRoleModel, self)
	self.btnClose:RemoveClickListener()
end

function FamilybossbattlesuccessView:onExitFinished()
	FamilybossbattlesuccessView.super.onExitFinished(self)
end

function FamilybossbattlesuccessView:onClickClose()
	if not self.canCliclClose then
		return
	end

	if not self.isShowAllReward then
		if self.myDamageList and self.myDamageList[#self.myDamageList] then
			self:forceStopDamageAnim(self.myDamageList[#self.myDamageList])
		else
			self:forceStopDamageAnim(0)
		end
	else
		BattleController.instance:endBattle()
	end
end

function FamilybossbattlesuccessView:part1Move()
	self:stopPart1Move()

	local function moveFinish()
		self:stopPart1Move()
		self:initDamageData()

		self.canCliclClose = true
	end

	self.moveYId = TweenLite.begin(self, self.animShowGo, TweenLite.AnimType.PosY, 79, 239, 0.4, moveFinish)
end

function FamilybossbattlesuccessView:stopPart1Move()
	if self.moveYId then
		TweenLite.stop(self.moveYId)

		self.moveYId = nil
	end
end

function FamilybossbattlesuccessView:initDamageData()
	local data = FamilyModel.instance.bossClgEndData

	if data then
		GameUtil.SetActive(self.targetGo, true)

		local cfg = FamilyConfig.instance:getBossPrizeStrategy(data.bossId)
		local damage = checknumber(data.damage)
		local list = {}
		local rewardList = {}
		local max = 0
		local boxCount = 0

		self.needDamage = false

		local lastDamageNum = 0
		local damageList = {}

		for k, v in pairs(cfg) do
			table.insert(damageList, v.interval)

			lastDamageNum = math.max(lastDamageNum, v.interval)

			if damage >= v.interval then
				boxCount = boxCount + 1
				max = math.max(max, v.interval)

				table.insert(list, v.interval)
				table.insert(rewardList, v.reward)
			end
		end

		table.sort(damageList, function(a, b)
			return a < b
		end)

		for i, interval in ipairs(damageList) do
			if not self.needDamage and damage < interval then
				self.needDamage = interval
			end
		end

		self.needDamage = self.needDamage or damageList[#damageList]

		table.sort(list, function(a, b)
			return a < b
		end)

		if max < damage then
			if #list >= #damageList then
				list[#list] = damage
			else
				table.insert(list, damage)
			end
		end

		table.remove(list, 1)
		table.remove(damageList, 1)

		self.index = 0
		self.rewardList = rewardList
		self.myDamageList = list
		self.needDamageList = damageList
		self.boxCount = boxCount

		self:enterDamageAnim(boxCount)
	end
end

function FamilybossbattlesuccessView:enterDamageAnim()
	self.index = self.index + 1

	local index = self.index
	local data1 = self.myDamageList[index]
	local data2 = self.myDamageList[index + 1]

	if not data1 then
		self:forceStopDamageAnim(self.myDamageList[index - 1])

		return
	end

	if not data2 then
		self:startFill(0.3, data1, self.needDamageList[index])

		return
	end

	self.boxNumText.text = math.min(self.boxCount, index)

	local stepTime = 1 / self.boxCount

	self:startFill(1 - (self.index - 1) * stepTime, data1, self.needDamageList[index])
end

function FamilybossbattlesuccessView:forceStopDamageAnim(damage)
	if damage == nil then
		damage = 0
	end

	if not self.needDamage then
		local maxNum = 1

		self:_updateFinished()
		self:stopFill()

		self.fillImg.fillAmount = damage / maxNum
		self.boxNumText.text = self.boxCount or 1
		self.damageNumText.text = damage .. "/" .. maxNum

		self:showRewardItems()
	end
end

function FamilybossbattlesuccessView:showRewardItems()
	local data = FamilyModel.instance.bossClgEndData

	if not data then
		return
	end

	GameUtil.SetActive(self._tableview.gameObject, true)

	local items = MaterialFacade.instance:getItemsByChangeSetId(data.changeSetId) or {}

	self._curViewDatas = {}

	for i, mo in ipairs(items) do
		local matType = mo.type
		local rank = 999

		if matType == MatType.Diamond then
			rank = 1
		elseif matType == MatType.Item then
			rank = 2
		end

		table.insert(self._curViewDatas, {
			num = mo.num,
			rank = rank,
			materialType = mo.type,
			id = mo.id
		})
	end

	table.sort(self._curViewDatas, function(a, b)
		return a.rank < b.rank
	end)
	GameUtil.SetActive(self.rewardGo, true)
	self:reloadData()
	GameUtil.SetActive(self.txtContinue, true)

	self.isShowAllReward = true
end

function FamilybossbattlesuccessView:_cellSize()
	return 100, 100
end

function FamilybossbattlesuccessView:_updateCell(view, cell, data)
	local model = MaterialMgr.getModel(data.materialType, data.id)

	proxy = MaterialMgr.setCellByData(data.materialType, model, cell.gameObject)

	proxy.binder:setNum(data.num)
end

function FamilybossbattlesuccessView:_clearTableview(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function FamilybossbattlesuccessView:startFill(time, toNum, endNum)
	time = math.max(time, 0.5)

	self:stopFill()

	local function endFunc()
		self:enterDamageAnim()
	end

	self:_popStrength(time, toNum, endNum)
	settimer(0, self._tweenStrengthNum, self)

	self.fillImg.fillAmount = 0
	self.fillId = TweenLite.begin(self, self.fillImg.gameObject, TweenLite.AnimType.FillAmount, 0, toNum / endNum, time, endFunc)
end

function FamilybossbattlesuccessView:stopFill()
	if self.fillId then
		TweenLite.stop(self.fillId)

		self.fillId = nil
	end

	removetimer(self._tweenStrengthNum, self)
end

function FamilybossbattlesuccessView:_tweenStrengthNum()
	if self._currStrength < self._destStrength then
		self:_updateNumber()
	else
		self:_updateFinished()
	end
end

function FamilybossbattlesuccessView:_updateFinished()
	self._tweenDelta = 0
	self._delayFinishTime = self._delayFinishTime + UnityTime.deltaTime

	removetimer(self._tweenStrengthNum, self)
end

function FamilybossbattlesuccessView:_updateNumber()
	self._tweenDelta = self._tweenDelta + UnityTime.deltaTime
	self._delayFinishTime = 0

	if self._tweenDelta >= 0.05 then
		self._tweenDelta = self._tweenDelta - 0.05
		self._currStrength = self:_getCurrNum()

		if self._currStrength >= self._destStrength then
			self._currStrength = self._destStrength
		end

		self:_updateText()
	end
end

function FamilybossbattlesuccessView:_getCurrNum()
	local usetime = UnityEngine.Time.time - self._fillNumStartTime
	local ratio = math_min(usetime / self._fillNumAniTime, 1)
	local curr_value = 0 + (self._fillNumEndValue - 0) * ratio

	return curr_value > 1 and math.floor(curr_value) or checknumber(string.format("%.2f", curr_value))
end

function FamilybossbattlesuccessView:_updateText()
	self.damageNumText.text = self._currStrength .. "/" .. self._fillNumEndValue
end

function FamilybossbattlesuccessView:_popStrength(time, damage, endNum)
	self._fillNumAniTime = time + 0.5
	self._fillNumEndValue = endNum
	self._fillNumStartTime = UnityTime.time
	self._currStrength = 0
	self._destStrength = damage
end

function FamilybossbattlesuccessView:isHasLihui(raceId)
	local petCfg = CharacterConfig.instance:getPetCo(raceId)
	local modelCfg = CharacterConfig.instance:getModelCo(checknumber(petCfg.faceIds))
	local bustName = modelCfg.bustName

	return not string.nilorempty(bustName)
end

function FamilybossbattlesuccessView:getRaceId()
	local units = BattleModel.instance:getUnits()

	if not units or #units == 0 then
		return
	end

	local lihuiUnits = {}

	for i, v in ipairs(units) do
		local raceId = v.attrs:getOriginRaceId()

		if self:isHasLihui(raceId) then
			table.insert(lihuiUnits, v)
		end
	end

	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	if #lihuiUnits > 0 then
		printInfo("1左侧参加随机的精灵个数：", #lihuiUnits)

		local randomNum = math.random(1, #lihuiUnits)

		return lihuiUnits[randomNum].attrs:getOriginRaceId()
	else
		printInfo("2左侧参加随机的精灵个数：", #units)

		local randomNum = math.random(1, #units)

		return units[randomNum].attrs:getOriginRaceId()
	end
end

function FamilybossbattlesuccessView:_getSkinIdByHurtValue()
	local leftTeamId = BattleModel.instance:getLeftTeamId()
	local playerDatas = BattleStatisticsDataModel.instance:getStatistics(leftTeamId)
	local hightHurtData = playerDatas[1]

	for i, v in pairs(playerDatas) do
		if Mathf.Abs(hightHurtData.damage) < Mathf.Abs(v.damage) then
			hightHurtData = v
		end
	end

	local scene = SceneMgr.instance:getCurScene()
	local unit = scene.unitFactory:getUnit(hightHurtData.teamId, hightHurtData.charactorId)

	return unit.attrs:getOriginSkinId(), unit.attrs:getOriginRaceId()
end

function FamilybossbattlesuccessView:_showRoleModel()
	removetimer(self._showRoleModel, self)

	local skinId, raceId = self:_getSkinIdByHurtValue()

	skinId = checknumber(skinId)

	if skinId == 0 then
		return
	end

	self:showDialogTxt(skinId)
	self:startRoleMove()

	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	local isAuto = true
	local callback

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self.roleModel, scale, callback, isAuto, x, y)
end

function FamilybossbattlesuccessView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function FamilybossbattlesuccessView:startRoleMove()
	self:stopRoleMove()

	local function moveFinish()
		self:stopRoleMove()
	end

	self.moveRoleId = TweenLite.begin(self, self.roleModel, TweenLite.AnimType.PosX, nil, -312, 0.5, moveFinish)
end

function FamilybossbattlesuccessView:stopRoleMove()
	if self.moveRoleId then
		TweenLite.stop(self.moveRoleId)

		self.moveRoleId = nil
	end
end

function FamilybossbattlesuccessView:showDialogTxt(raceId)
	self.dialogbox:SetActive(false)

	if not raceId or raceId == 0 then
		return
	end

	self.dialogTxt.text = ""

	local isPerfectWin = BattleSettlementModel.instance:isPerfectWin()

	self:_updateBubble(isPerfectWin and PetCvController.instance:playPetCv(raceId, GameEnum.PetCvType.BattlePerfect) or PetCvController.instance:playPetCv(raceId, GameEnum.PetCvType.BattleWin))
	self.dialogbox:SetActive(not string.nilorempty(self.dialogTxt.text))
end

function FamilybossbattlesuccessView:_updateBubble(word)
	word = word or ""
	self.dialogTxt.text = word
end

function FamilybossbattlesuccessView:_onClickraycast()
	self:onClickClose()
end

return FamilybossbattlesuccessView
