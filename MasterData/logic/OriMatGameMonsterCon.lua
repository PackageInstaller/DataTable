-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameMonsterCon.lua

module("logic.extensions.orimatgame.model.OriMatGameMonsterCon", package.seeall)

local OriMatGameMonsterCon = class("OriMatGameMonsterCon", OriMatGameUnitCon)

function OriMatGameMonsterCon:ctor(container)
	OriMatGameMonsterCon.super.ctor(self, container)

	self._isMirror = false
	self._timeScale = 1
	self._spineCtrl = SimpleSpineCtrl.New()
end

function OriMatGameMonsterCon:buildUI()
	OriMatGameMonsterCon.super.buildUI(self)

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

function OriMatGameMonsterCon:beDamage(damValue)
	self:refreshHP()
end

function OriMatGameMonsterCon:refreshHP()
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

function OriMatGameMonsterCon:updateUI()
	if self._unit then
		self:updatePosition(self._unit.position.x, self._unit.position.y)
		self:refreshHP()
		goutil.setActive(self.container, true)

		local monsterCfg = self._unit:getMonsterCfg()

		if monsterCfg then
			self._isMirror = monsterCfg.isMirror or false

			if self._roleCon then
				self._spineCtrl:onClear()

				if self._role then
					RoleObjectPool.instance:removeRole(self._role)
				end

				local resPath = monsterCfg.resPath

				if not monsterCfg.locPos then
					if not monsterCfg.locScale then
						local locScale = 1

						local function loadedCallBack(go)
							self._spineCtrl:onInit(go)
							self._spineCtrl:playAnimation({
								isLoop = true,
								animName = monsterCfg.idleAni
							})
							self:setTimeScale(self._timeScale)
						end

						self._role = RoleObjectPool.instance:addSpineToParent(self._role, resPath, self._roleCon, locScale, loadedCallBack, monsterCfg.locPos[1], monsterCfg.locPos[2])
					end
				end
			end

			GameUtil.setLocalPos(self._sldHP.gameObject, 0, monsterCfg.hpPosY, 0)
		end

		self:updateDirection(true)
		self:updateStatus()

		if OriMatGameGameController.instance then
			local speedRate = OriMatGameGameController.instance:getGameSpeedRate()

			self:setTimeScale(speedRate)
		end
	else
		self:reset()
	end
end

function OriMatGameMonsterCon:updateFireUI(id)
	GameUtil.SetActive(self._fire, self._unit.id == id)
end

function OriMatGameMonsterCon:reset()
	OriMatGameMonsterCon.super.reset(self)

	self._timeScale = 1

	self:setTimeScale(self._timeScale)
	self._spineCtrl:onClear()

	if self._role then
		RoleObjectPool.instance:removeRole(self._role)
	end

	self._role = nil
	self._isMirror = false

	GameUtil.SetActive(self._fire, false)
end

function OriMatGameMonsterCon:setTimeScale(value)
	self._timeScale = value

	self._spineCtrl:setTimeScale(value)
end

function OriMatGameMonsterCon.onAniComplete(trackEntry)
	GameUtil.callBack(OriMatGameMonsterCon._callBackMap[trackEntry])

	OriMatGameMonsterCon._callBackMap[trackEntry] = nil
	trackEntry.Complete = trackEntry.Complete - OriMatGameMonsterCon.onAniComplete
end

function OriMatGameMonsterCon:updateDirection(isRight)
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

function OriMatGameMonsterCon:updateStatus()
	if self._unit then
		local isFrozen = self._unit:checkHasStatus(OriMatGameEnum.StatusType.Frozen)
		local isBurning = self._unit:checkHasStatus(OriMatGameEnum.StatusType.Burning)
		local isSlowDown = self._unit:checkHasStatus(OriMatGameEnum.StatusType.SlowDown)

		goutil.setActive(self._statusFrozen, isFrozen)
		goutil.setActive(self._statusBurning, isBurning)
		goutil.setActive(self._statusSlowDown, isSlowDown)
	end
end

return OriMatGameMonsterCon
