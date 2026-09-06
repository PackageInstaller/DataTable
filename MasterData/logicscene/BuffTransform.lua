-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffTransform.lua

module("logicscene.scene.battle.skills.buffs.BuffTransform", package.seeall)

local BuffTransform = class("BuffTransform", BuffBase)

function BuffTransform:ctor(buffCo, unit, modelId, effId)
	if checknumber(effId) == 0 then
		effId = 162
	end

	self._effId = effId
	self._isAddCount = false
	self._modelPath = nil

	BuffTransform.super.ctor(self, buffCo, unit)

	self._modelId = modelId

	local modelCo = CharacterConfig.instance:getModelCo(modelId)

	if modelCo then
		self._modelPath = GameUrl.getSpineUrl(modelCo.resName)
	end
end

function BuffTransform:_buildEffects()
	self.addEffectCo = self:_buildEffectByEffId(self._effId)
end

function BuffTransform:autoRemoveOnDead()
	if not self._startTransformed then
		return false
	end

	return BuffTransform.super.autoRemoveOnDead(self)
end

function BuffTransform:onBuffBegin()
	self.isRunning = true

	if self._modelPath and not self._unit.attrs:isDead() then
		self._isAddCount = true

		self._unit.attrs:setIsTransforming(true)

		BattleModel.instance.transformingCount = BattleModel.instance.transformingCount + 1
	end

	self._transformNeedTick = true
	self._transformFailedTime = 3

	self:_startTransform()
end

function BuffTransform:_createBeginEffect()
	self:_destroyBeginEffect()

	if self.addEffectCo then
		self.addEffectCo.isHit = true
		self.addEffectCo.follow = 1
		self._effectBegin = self._unit.battleEffects:playEffect(self.addEffectCo, self._onBeginEffectPlayFinish, self._onBeginEffectLoaded, self)

		if self._effectBegin then
			if self._isPause then
				self._effectBegin:pause()
			else
				self._effectBegin:resume()
			end
		end
	end
end

function BuffTransform:update(deltaTime)
	self:_startTransform(deltaTime)

	if self._transformNeedTick and deltaTime then
		self._transformFailedTime = self._transformFailedTime - deltaTime

		if self._transformFailedTime <= 0 then
			self:_transformFailed()
		end
	end
end

function BuffTransform:onBuffEnd()
	if self._resLoader then
		self._resLoader:clear()

		self._resLoader = nil
	end

	if self._isAddCount then
		self._unit.attrs:setIsTransforming(false)

		BattleModel.instance.transformingCount = BattleModel.instance.transformingCount - 1
	end

	self._isAddCount = false

	BuffTransform.super.onBuffEnd(self)
end

function BuffTransform:_onBeginEffectPlayFinish()
	self._effectBegin = nil

	if self.isRunning then
		self._effectLoaded = true

		self:_finishTransform()
	end
end

function BuffTransform:getBuffId()
	return UnitCompBuffList.TransformId
end

function BuffTransform:_onModelLoaded()
	if self.isRunning then
		self._unit:load(self._modelPath, self._onSpineLoaded, self)
	end
end

function BuffTransform:_onSpineLoaded()
	self._modelLoaded = true

	self:_finishTransform()
end

function BuffTransform:_finishTransform()
	if self.isRunning and self._modelLoaded and self._effectLoaded then
		self._unit.unitUI:updateUIInfo()

		if self._isAddCount then
			self._unit.attrs:setIsTransforming(false)

			BattleModel.instance.transformingCount = BattleModel.instance.transformingCount - 1
		end

		self._isAddCount = false
		self._modelPath = nil
	end
end

function BuffTransform:_startTransform(deltaTime)
	if self.isRunning and not self._startTransformed and self._unit.battleFlow:isIdle(self._unit) then
		self:_createBeginEffect()

		if self._modelPath then
			self._startTransformed = true
			self._transformNeedTick = false
			self._resLoader = MultiResLoader.New()

			self._resLoader:addResPath(self._modelPath)
			self._resLoader:load(self._onModelLoaded, nil, self)
		end
	end
end

function BuffTransform:isCustomBuff()
	return true
end

function BuffTransform:_transformFailed()
	if self._isAddCount then
		self._unit.attrs:setIsTransforming(false)

		BattleModel.instance.transformingCount = BattleModel.instance.transformingCount - 1
	end

	self._isAddCount = false
end

return BuffTransform
