-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueRectifyRoll.lua

module("logic.extensions.roguelike.flow.work.WorkRogueRectifyRoll", package.seeall)

local M = class("WorkRogueRectifyRoll", WorkRogueRollBase)

function M:onEnter(context)
	local roleDices = RogueMgr.instance:getRogueFlow().judgeMgr:createRectifyDice()

	self._dicePos = RogueMgr.instance:getRogueFlow().model:getPlayerDicePos()

	if roleDices then
		for k, v in pairs(roleDices) do
			print("ROGUE", "整顿 骰子图案", v:getUpPattern())
		end
	else
		print("整顿骰子为空")
	end

	if not RogueMgr.instance:getNeedShowDice() then
		self:onDone(WorkResult.Succeed)

		return
	end

	self._dices = roleDices

	RogueMgr.instance:getRogueFlow().diceMgr:getDiceInst(function(inst)
		self:onGetDiceRes(inst)
	end)
	self:setEvent(true)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_DICE_THROW, self._onDiceThrow, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_DICE_THROW, self._onDiceThrow, self)
	end
end

function M:_onDiceThrow(sender, originPos, endPos)
	originPos = Vector3.New(originPos.x, 0, originPos.y)
	endPos = Vector3.New(endPos.x, 0, endPos.y)

	for k, v in pairs(self._diceRigidbodys) do
		local rigidbody = v.body

		rigidbody.isKinematic = false

		rigidbody:AddTorque(Vector3.Cross(endPos, originPos) * 1000 * math.random(1, 5), UnityEngine.ForceMode.Impulse)

		endPos.y = endPos.y + math.random(3, 8)
		endPos.z = endPos.z + 10 * math.random(1, 5)

		local distance = Vector3.Distance(endPos, originPos)
		local max = 400

		distance = max < distance and max or distance

		rigidbody:AddForce((endPos - originPos).normalized * distance * 10 * rigidbody.mass)
	end

	settimer(0.1, self.checkDiceStop, self, true)
end

function M:onGetDiceRes(asset)
	if self._dices then
		local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr

		for k, v in ipairs(self._dices) do
			local inst = diceMgr:getDiceObj()
			local pos = Vector3.New(self._dicePos.x + (k - #self._dices / 2) * 1.5, self._dicePos.y + 10, self._dicePos.z)

			inst.transform.position = pos

			for i = 1, 6 do
				local child = goutil.findChild(inst, diceMgr:getDiceFaceName(i))

				diceMgr:setDicePattern(child, v:getPatternByIndex(i))
				goutil.setActive(child.gameObject, v:getPatternByIndex(i) ~= RoguelikeConst.DICE_PATTERN.WHITE)
			end

			local rigidbody = inst:GetComponent("Rigidbody")

			rigidbody.isKinematic = true

			table.insert(self._diceRigidbodys, {
				body = rigidbody,
				index = v:getUpIndex(),
				dice = v,
				flyIndex = k
			})
			goutil.setActive(inst, true)
			v:setGo(inst)
			table.insert(self._diceGos, inst)
			table.insert(self._diceRotates, self.DiceRotateMap[v:getUpIndex()])
		end

		self:flyToOrigin()
	end
end

function M:flyToOrigin()
	for k, v in pairs(self._diceGos) do
		local posX = self._dicePos.x - 11 + ((k - 1) % 3 + 1) * 1
		local posY = self._dicePos.y + 0.5 + math.modf((k - 1) / 3)
		local pos = Vector3.New(posX, posY, self._dicePos.z - 5)

		v.transform:DOMove(pos, 0.5):OnComplete(self.onMoveFinish, self)
		v.transform:DOLocalRotate(Vector3.zero, 0.5)
	end
end

function M:getStopOffset()
	return Vector3.New(-4, 0, 0)
end

function M:onExit()
	M.super.onExit(self)
	self:setEvent(false)
end

function M:flyToPos()
	local curProp = RogueMgr.instance:getRogueFlow().model:getSelectProp()

	self._diceIndex = 0

	local count = 0

	for k, v in pairs(self._diceGos) do
		if self._dices[k]:getUpPattern() == curProp then
			local pos = Vector3.New(self._dicePos.x + 12, self._dicePos.y + 0.5, self._dicePos.z + 5)

			v.transform:DOMove(pos, 0.5):OnComplete(self.onMoveFinish, self)
			v.transform:DOLocalRotate(self._diceRotates[k], 0.5)

			count = count + 1
		end
	end

	self._flyCount = count

	if count == 0 then
		self._flyCount = 1

		self:onMoveFinish()
	end
end

return M
