-- chunkname: @modules/common/work/SpineDissolveWork.lua

module("modules.common.work.SpineDissolveWork", package.seeall)

local SpineDissolveWork = class("SpineDissolveWork", BaseWork)
local AnimatorPaths = {
	[FightEnum.DissolveType.Player] = {
		duration = 1.67,
		path = FightPreloadOthersWork.die_player
	},
	[FightEnum.DissolveType.Monster] = {
		duration = 1.67,
		path = FightPreloadOthersWork.die_monster
	},
	[FightEnum.DissolveType.ZaoWu] = {
		duration = 1.67,
		path = "rolesbuff/die_zaowu.controller"
	},
	[FightEnum.DissolveType.Abjqr4] = {
		duration = 3,
		path = "rolesbuff/die_monster_670401_abjqr4.controller"
	}
}

function SpineDissolveWork:onStart(context)
	self.context = context

	local skil_spine_action_config = lua_skin_spine_action.configDict[self.context.dissolveEntity:getMO().skin]

	if skil_spine_action_config then
		::label_1_0::

		local var_1_0 = skil_spine_action_config.die

		if skil_spine_action_config.die then
			local dead_ani = skil_spine_action_config.die.dieAnim

			if string.nilorempty(dead_ani) then
				self:_playDissolve()
			else
				self._ani_path = dead_ani
				self._animationLoader = MultiAbLoader.New()

				self._animationLoader:addPath(FightHelper.getEntityAniPath(dead_ani))
				self._animationLoader:startLoad(self._onAnimationLoaded, self)
			end
		end
	end
end

function SpineDissolveWork:_onAnimationLoaded()
	local assetItem = self._animationLoader:getFirstAssetItem()

	if not assetItem then
		logError(string.format("配置死亡动画 '%s' 不存在，皮肤id : %s ", self._ani_path, self.context.dissolveEntity:getMO().skin))

		return self:_playDissolve()
	end

	local path = ResUrl.getEntityAnim(self._ani_path)
	local animInst = assetItem:GetResource(path)

	animInst.legacy = true
	self._animStateName = animInst.name
	self._animCompList = {}

	local entity = self.context.dissolveEntity
	local animComp = gohelper.onceAddComponent(entity.spine:getSpineGO(), typeof(UnityEngine.Animation))

	table.insert(self._animCompList, animComp)

	animComp.enabled = true
	animComp.clip = animInst

	animComp:AddClip(animInst, self._animStateName)

	local state = animComp.this:get(self._animStateName)

	if state then
		state.speed = FightModel.instance:getSpeed()
	end

	animComp:Play()
	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)
	TaskDispatcher.runDelay(self._afterPlayDissolve, self, animInst.length / FightModel.instance:getSpeed())
end

function SpineDissolveWork:_onUpdateSpeed()
	for _, animComp in ipairs(self._animCompList) do
		local state = animComp.this:get(self._animStateName)

		if state then
			state.speed = FightModel.instance:getSpeed()
		end
	end
end

function SpineDissolveWork:_clearAnim()
	if self._animCompList then
		for _, animComp in ipairs(self._animCompList) do
			if not gohelper.isNil(animComp) then
				if animComp:GetClip(self._animStateName) then
					animComp:RemoveClip(self._animStateName)
				end

				if animComp.clip and animComp.clip.name == self._animStateName then
					animComp.clip = nil
				end

				animComp.enabled = false
			end
		end

		self._animCompList = nil
	end
end

function SpineDissolveWork:_playDissolve()
	local animatorParam = AnimatorPaths[self.context.dissolveType]
	local animatorPath = animatorParam and animatorParam.path

	if animatorPath then
		self._animatorLoader = MultiAbLoader.New()

		self._animatorLoader:addPath(animatorPath)
		self._animatorLoader:startLoad(self._onAnimatorLoaded, self)
	else
		logError(self.context.dissolveEntity:getMO():getEntityName() .. "没有配置死亡消融动画 type = " .. (self.context.dissolveType or "nil"))
	end
end

function SpineDissolveWork:_onAnimatorLoaded()
	local assetItem = self._animatorLoader:getFirstAssetItem()

	self:_reallyPlayDissolve(assetItem)
end

function SpineDissolveWork:_reallyPlayDissolve(assetItem)
	local var_7_0 = self.context.dissolveEntity

	if self.context.dissolveEntity then
		var_7_0 = self.context.dissolveEntity.spine

		if self.context.dissolveEntity.spine then
			local spineObj = self.context.dissolveEntity.spine:getSpineGO()

			if not spineObj then
				self:_afterPlayDissolve()

				return
			end

			local animatorInst = assetItem:GetResource()
			local animatorComp = gohelper.onceAddComponent(spineObj, typeof(UnityEngine.Animator))

			animatorComp.enabled = true
			animatorComp.runtimeAnimatorController = animatorInst
			animatorComp.speed = FightModel.instance:getSpeed()

			local animatorParam = AnimatorPaths[self.context.dissolveType]

			if animatorParam then
				if not animatorParam.duration then
					local animationLength = 1.67

					TaskDispatcher.runDelay(self._afterPlayDissolve, self, animationLength / FightModel.instance:getSpeed())
				end
			end
		end
	end
end

function SpineDissolveWork:_afterPlayDissolve()
	self:_clearAnim()
	self:onDone(true)
end

function SpineDissolveWork:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)
	self:_clearAnim()
	TaskDispatcher.cancelTask(self._afterPlayDissolve, self)

	if self._animationLoader then
		self._animationLoader:dispose()

		self._animationLoader = nil
	end

	if self._animatorLoader then
		self._animatorLoader:dispose()

		self._animatorLoader = nil
	end
end

return SpineDissolveWork
