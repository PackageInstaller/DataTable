-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/HurtDataCollision.lua

module("logicscene.scene.battle.skills.hurts.HurtDataCollision", package.seeall)

local HurtDataCollision = class("HurtDataCollision", HurtDataBase)

function HurtDataCollision:ctor()
	HurtDataCollision.super.ctor(self)

	self.skill = nil
	self.collision = nil
	self.targetData = nil
end

function HurtDataCollision:generateFromCharactorResult(result)
	self.isHit = result.isHit
	self.isImmunity = result.isImmunity
	self.isBlock = result.isBlock
	self.isCritical = result.isCritical
	self.isSkillEffected = result.isSkillEffected

	if self.isSkillEffected then
		if not self.skill:isShowDamageHud(self.target) then
			self._showDamageText = self.collision:getDamgePercent() > 0

			if self._showDamageText then
				self.skill:markShowDamageHud(self.target)
			end
		else
			self._showDamageText = false
		end
	else
		self._showDamageText = false
	end

	self:generateFromResultNum(result.targetNum)
end

function HurtDataCollision:generateFromResultNum(targetNum)
	local targetData = self.targetData
	local damageRate = self.collision:getDamgePercent()
	local records = targetData.records
	local isLast = self.collision:isLastCollision()

	self:_calculateDamages(targetNum, damageRate, records, isLast)
	self:_calculateVigours(targetNum, damageRate, records, isLast)
	self:_calculateAttackerVigours(damageRate, isLast)

	local totalIndex, totalNum = self:_getCollisionDamageIndex()
	local isLastDamage = totalNum <= totalIndex

	if targetNum.attackHps then
		local hasDamage = #targetNum.attackHps > 0

		if isLastDamage or not hasDamage and isLast then
			self:generateAfterHurtEvtsFromResultNum(targetNum)
		end
	end
end

function HurtDataCollision:_calculateVigours(targetNum, damageRate, records, isLast)
	if damageRate <= 0 or not targetNum.attackVigours then
		return
	end

	local vigoursCnt = #targetNum.attackVigours

	if vigoursCnt == 0 then
		return
	end

	local pool = HurtEvtsPool.instance

	records.vigours = records.vigours or {}

	for i = 1, vigoursCnt do
		if not records.vigours[i] then
			local record = 0
			local invalidCheck

			if targetNum.attackVigours[i] > 0 then
				if record >= targetNum.attackVigours[i] then
					invalidCheck = true
				end
			elseif targetNum.attackVigours[i] < 0 and record <= targetNum.attackVigours[i] then
				invalidCheck = true
			end

			if not invalidCheck then
				local vigour = 0

				if isLast then
					vigour = targetNum.attackVigours[i] - record
					records.vigours[i] = targetNum.attackVigours[i]
				else
					vigour = math.min(targetNum.attackVigours[i] - record, math.floor(targetNum.attackVigours[i] * damageRate))
					records.vigours[i] = record + vigour
				end

				self.vigourEvts = self.vigourEvts or {}

				table.insert(self.vigourEvts, pool:getVigourEvt(vigour))
			end
		end
	end
end

function HurtDataCollision:_calculateAttackerVigours(damageRate, isLast)
	if not self.skill then
		return
	end

	if damageRate <= 0 or not self.skill.resumeVigours then
		return
	end

	local pool = HurtEvtsPool.instance

	self.skill.resumeRecords = self.skill.resumeRecords or 0

	local vigour = 0

	if self.skill.resumeRecords < self.skill.resumeVigours then
		if isLast then
			vigour = self.skill.resumeVigours - self.skill.resumeRecords
			self.skill.resumeRecords = self.skill.resumeVigours
		else
			vigour = math.min(self.skill.resumeVigours - self.skill.resumeRecords, math.floor(self.skill.resumeVigours * damageRate))
			self.skill.resumeRecords = self.skill.resumeRecords + vigour
		end
	end

	if vigour ~= 0 then
		self.vigourEvts = self.vigourEvts or {}

		table.insert(self.vigourEvts, pool:getAttackerVigourEvt(vigour))
	end
end

function HurtDataCollision:_getCollisionDamageIndex()
	local totalIndex = 0
	local totalNum = 0

	if self.skill then
		totalIndex = self.skill:getDamageCollisionCount(self.target)
		totalNum = self.collision:getDamgeCount()
	end

	return totalIndex, totalNum
end

function HurtDataCollision:_calculateDamages(targetNum, damageRate, records, isLast)
	if damageRate <= 0 or not targetNum.attackHps then
		return
	end

	local damagesCnt = #targetNum.attackHps

	if damagesCnt == 0 then
		return
	end

	local pool = HurtEvtsPool.instance

	records.damages = records.damages or {}

	if self.skill and not self.skill:isCollisionCounted(self.collision.collisionCo.index, self.target) then
		self.skill:countCollision(self.collision.collisionCo.index, self.target)
	end

	local totalIndex, totalNum = self:_getCollisionDamageIndex()
	local damageTotalCount = self.collision:getDamgeTotalCount()

	for i = 1, damagesCnt do
		if not records.damages[i] then
			local record = 0
			local invalidCheck

			if targetNum.attackHps[i] > 0 then
				if record > targetNum.attackHps[i] then
					invalidCheck = true
				end
			elseif targetNum.attackHps[i] < 0 and record < targetNum.attackHps[i] then
				invalidCheck = true
			end

			if not invalidCheck then
				local damage = 0

				if isLast then
					damage = targetNum.attackHps[i] - record
					records.damages[i] = targetNum.attackHps[i]
				else
					damage = targetNum.attackHps[i] > 0 and math.min(targetNum.attackHps[i] - record, math.floor(targetNum.attackHps[i] * damageRate)) or math.max(targetNum.attackHps[i] - record, math.floor(targetNum.attackHps[i] * damageRate))
					records.damages[i] = record + damage
				end

				local totalDamage

				if totalNum > 1 then
					totalDamage = records.damages[i]
				end

				if self.skill then
					self.skill.damageCollisionTotalCnt = self.skill.damageCollisionTotalCnt + 1
				end

				self.damageEvts = self.damageEvts or {}

				table.insert(self.damageEvts, pool:getDamageEvt(damage, self._showDamageText, totalDamage, self.skill.damageCollisionTotalCnt, damageTotalCount, self))
			end
		end
	end
end

function HurtDataCollision:_handleHurtEffect()
	if self.isSkillEffected then
		if self.collision.collisionCo.hitEffect then
			self.target.battleEffects:playEffect(self.collision.collisionCo.hitEffect)
		end

		if self.collision.collisionCo.cData and not goutil.isNil(self.collision.collisionCo.cData.shakeCamera) then
			self.collision.collisionCo.cData.shakeCamera:SetActive(true)
			pcall(self.collision.collisionCo.cData.ShakeCamera, self.collision.collisionCo.cData)
		end
	end
end

function HurtDataCollision:_handleControls()
	if self.isSkillEffected then
		if self.skill then
			local hitTake = self.skill:getHitAnimationPath()

			if hitTake then
				self.target:onAnimation(hitTake)

				return
			end
		end

		HurtDataCollision.super._handleControls(self)
	end
end

function HurtDataCollision:_onTarget()
	if self.skill and self.skill.isSummonSkillId and (self.target.attrs:isSummonedCharacter() or self.target.attrs:isDoppelganger()) then
		if self.collision:isLastCollision() then
			self.target:onSummoned(true)
		end

		return
	end

	if self.skill and self.skill.isDoppelgangerSkillId and self.target.attrs:isDoppelganger() then
		if self.collision:isLastCollision() then
			self.target:onDoppelgangered(true)
		end

		return
	end

	if self.skill and self.skill.isHeavenAwakenSkillId and self.target.attrs:isTJSummonedCharacter() then
		if self.collision:isLastCollision() then
			self.target:onTJSummoned(true)
		end

		return
	end

	HurtDataCollision.super._onTarget(self)
end

function HurtDataCollision:_handleSound()
	if self.collision then
		local hitSound = self.collision:getHitSound()

		if not string.nilorempty(hitSound) then
			AudioPlayerEx.instance:playEffectByEvtName(hitSound, UnityEngine.Time.timeScale)
		end
	end
end

return HurtDataCollision
