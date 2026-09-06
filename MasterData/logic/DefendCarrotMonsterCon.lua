-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotMonsterCon.lua

module("logic.extensions.defendcarrot.model.DefendCarrotMonsterCon", package.seeall)

local DefendCarrotMonsterCon = class("DefendCarrotMonsterCon", DefendCarrotUnitCon)

function DefendCarrotMonsterCon:ctor(container)
	DefendCarrotMonsterCon.super.ctor(self, container)

	self._isMirror = false
end

function DefendCarrotMonsterCon:buildUI()
	DefendCarrotMonsterCon.super.buildUI(self)

	if self.container then
		self._sldHP = Framework.SliderAdapter.GetFrom(self.container, "sldHP")
		self._roleCon = goutil.findChild(self.container, "roleCon")
		self._fire = goutil.findChild(self.container, "fire")

		GameUtil.SetActive(self._fire, false)

		self._statusFrozen = goutil.findChild(self.container, "status/statusFrozen")
		self._statusBurning = goutil.findChild(self.container, "status/statusBurning")
		self._statusSlowDown = goutil.findChild(self.container, "status/statusSlowDown")
	end
end

function DefendCarrotMonsterCon:beDamage(damValue)
	self:refreshHP()
end

function DefendCarrotMonsterCon:refreshHP()
	if self._unit then
		local hp = math.floor(self._unit:getCurHp())
		local maxHp = math.floor(self._unit:getHpMax())

		if maxHp <= hp then
			goutil.setActive(self._sldHP.gameObject, false)
		else
			self._sldHP:SetValue(hp / maxHp)
			goutil.setActive(self._sldHP.gameObject, true)
		end
	end
end

function DefendCarrotMonsterCon:updateUI()
	if self._unit then
		self:updatePosition(self._unit.position.x, self._unit.position.y)
		self:refreshHP()
		goutil.setActive(self.container, true)

		local monsterCfg = self._unit:getMonsterCfg()

		if monsterCfg then
			self._isMirror = monsterCfg.isMirror or false

			if self._roleCon then
				if self._role then
					RoleObjectPool.instance:removeRole(self._role)
				end

				local resPath = monsterCfg.resPath

				if not monsterCfg.locPos then
					if not monsterCfg.locScale then
						local locScale = 1

						self._role = RoleObjectPool.instance:addSpineToParent(self._role, resPath, self._roleCon, locScale, function()
							self:playAnimation(self._roleCon, monsterCfg.idleAni, true)
						end, monsterCfg.locPos[1], monsterCfg.locPos[2])
					end
				end
			end

			GameUtil.setLocalPos(self._sldHP.gameObject, 0, monsterCfg.hpPosY, 0)
		end

		self:updateDirection(true)
		self:updateStatus()
	else
		self:reset()
	end
end

function DefendCarrotMonsterCon:updateFireUI(id)
	GameUtil.SetActive(self._fire, self._unit.id == id)
end

function DefendCarrotMonsterCon:reset()
	DefendCarrotMonsterCon.super.reset(self)

	if self._role then
		RoleObjectPool.instance:removeRole(self._role)
	end

	self._role = nil
	self._isMirror = false

	GameUtil.SetActive(self._fire, false)
end

function DefendCarrotMonsterCon:playAnimation(go, animName, loop, callBack)
	if not go then
		return
	end

	self._graphic = go:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	if self._trackEntry then
		DefendCarrotMonsterCon._callBackMap[self._trackEntry] = nil
		self._trackEntry = nil
	end

	local graphic = self._graphic

	if graphic then
		local sk = graphic.skeletonDataAsset

		if sk ~= nil then
			local data = sk:GetAnimationStateData()
			local skd = data.SkeletonData
			local ani = skd:FindAnimation(animName)

			if ani ~= nil then
				graphic:Initialize(true)

				graphic.startingAnimation = animName

				local trackEntry = graphic.AnimationState:SetAnimation(0, animName, loop)

				graphic:Update(0)

				DefendCarrotMonsterCon._callBackMap = DefendCarrotMonsterCon._callBackMap or {}
				DefendCarrotMonsterCon._callBackMap[trackEntry] = callBack
				trackEntry.Complete = trackEntry.Complete + DefendCarrotMonsterCon.onAniComplete
				self._trackEntry = trackEntry
			end
		end
	end
end

function DefendCarrotMonsterCon.onAniComplete(trackEntry)
	GameUtil.callBack(DefendCarrotMonsterCon._callBackMap[trackEntry])

	DefendCarrotMonsterCon._callBackMap[trackEntry] = nil
	trackEntry.Complete = trackEntry.Complete - DefendCarrotMonsterCon.onAniComplete
end

function DefendCarrotMonsterCon:updateDirection(isRight)
	if self._roleCon then
		if self._isMirror then
			isRight = not isRight
		end

		if isRight then
			GameUtil.setLocalScale(self._roleCon, -1, 1, 1)
		else
			GameUtil.setLocalScale(self._roleCon, 1, 1, 1)
		end
	end
end

function DefendCarrotMonsterCon:updateStatus()
	if self._unit then
		local isFrozen = self._unit:checkHasStatus(DefendCarrotEnum.StatusType.Frozen)
		local isBurning = self._unit:checkHasStatus(DefendCarrotEnum.StatusType.Burning)
		local isSlowDown = self._unit:checkHasStatus(DefendCarrotEnum.StatusType.SlowDown)

		goutil.setActive(self._statusFrozen, isFrozen)
		goutil.setActive(self._statusBurning, isBurning)
		goutil.setActive(self._statusSlowDown, isSlowDown)
	end
end

return DefendCarrotMonsterCon
