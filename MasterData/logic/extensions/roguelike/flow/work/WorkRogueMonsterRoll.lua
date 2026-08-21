-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueMonsterRoll.lua

module("logic.extensions.roguelike.flow.work.WorkRogueMonsterRoll", package.seeall)

local M = class("WorkRogueMonsterRoll", WorkRogueRollBase)

function M:onEnter(context)
	local isFirst = RogueMgr.instance:getModel():getIsFirstRondRoleIndex()
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()
	local num = 0

	if judgeArchive ~= nil and judgeArchive.enemyId ~= 0 and judgeArchive.enemyFace.num ~= 0 then
		num = judgeArchive.enemyFace.num
	end

	if not isFirst and num == 0 then
		self:onDone(WorkResult.Succeed)

		return
	end

	local judgeMgr = RogueMgr.instance:getRogueFlow().judgeMgr

	if #judgeMgr:getCurRoundCombatDice() ~= 0 then
		self:onDone(WorkResult.Succeed)

		return
	end

	local combatDices = judgeMgr:createMonsterDice()

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_CREATE_COMBAT_DICE, combatDices)

	for k, v in pairs(combatDices) do
		-- block empty
	end

	if not RogueMgr.instance:getNeedShowDice() then
		local featureDice = RogueMgr.instance:getRogueFlow().judgeMgr:getCombatDiceFeatures()

		self:onDone(WorkResult.Succeed)

		return
	end

	self._dicePos = RogueMgr.instance:getRogueFlow().model:getPlayerDicePos()
	self._dices = combatDices

	RogueMgr.instance:getRogueFlow().model:setMonsterDiceItems(self._dices)
	RogueMgr.instance:getRogueFlow().diceMgr:getDiceInst(function(inst)
		self:onGetDiceRes(inst)
	end)
end

function M:onGetDiceRes(asset)
	if self._dices then
		if #self._dices > 0 then
			RogueMgr.instance:getRogueFlow().shieldMgr:createMonsterShield()
		else
			RogueMgr.instance:getRogueFlow().shieldMgr:showDestroyMonsterShieldAni()
		end

		local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr
		local rolePos = RoguelikeController.instance:getRolePos()
		local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

		for k, v in ipairs(self._dices) do
			local inst = diceMgr:getDiceObj(diceMgr:getDiceIndex(v))
			local pos = Vector3.New(rolePos.x + kMapItemSize + (k - #self._dices / 2) * 3.5, 0, rolePos.z + kMapItemSize * 2.5)

			inst.transform.position = pos

			local temp = ""

			for i = 1, 6 do
				local child = goutil.findChild(inst, diceMgr:getDiceFaceName(i))

				diceMgr:setDicePattern(child, v:getUpPattern())
				goutil.setActive(child.gameObject, false)

				temp = temp .. v:getPatternByIndex(i) .. "-"
			end

			local rigidbody = inst:GetComponent("Rigidbody")

			rigidbody.isKinematic = true
			rigidbody.useGravity = false

			goutil.setActive(inst, false)

			local scale = RoguelikeConst.DICE_SCALE

			Astral.TransformUtil.SetLocalScale(inst.transform, scale, scale, scale)
			v:setGo(inst)
			table.insert(self._diceGos, inst)
			table.insert(self._diceRotates, self.DiceRotateMap[v:getUpIndex()])
		end

		self:flyToPos()
	end

	settimer(0.1, self.checkDiceStop, self, true)
end

function M:flyToPos()
	self._diceIndex = 0

	local rolePos = RoguelikeController.instance:getRolePos()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local k = 0

	for i = 1, #self._diceGos do
		k = k + 1

		local v = self._diceGos[i]
		local line = math.modf(k / 5)
		local offset = math.fmod(k, 5)

		if offset == 0 and line > 0 then
			line = line - 1
		end

		offset = offset == 0 and 5 or offset

		local y = (0.5 + line) * RoguelikeConst.DICE_SCALE
		local pos = Vector3.New(rolePos.x + kMapItemSize * 4, y, (-2 + offset) * RoguelikeConst.DICE_SCALE + rolePos.z + kMapItemSize * 1)

		v.transform.localPosition = Vector3.New(pos.x, pos.y + 10, pos.z)

		v.transform:DOMove(pos, 0.5):OnComplete(self.onMoveFinish, self):SetDelay(0.4 + i * 0.04):SetEase(DG.Tweening.Ease.InQuint)
		v.transform:DOLocalRotate(self._diceRotates[k], 0.02)
	end
end

function M:onMoveFinish()
	if not self._diceGos then
		return
	end

	self._diceIndex = self._diceIndex + 1

	local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER__HEAD_DICE, self._diceIndex)

	if self._diceIndex == #self._diceGos or self._diceIndex == self._flyCount then
		self:onDone(WorkResult.Succeed)
	end
end

function M:getStopOffset()
	return Vector3.New(4, 0, 0)
end

return M
