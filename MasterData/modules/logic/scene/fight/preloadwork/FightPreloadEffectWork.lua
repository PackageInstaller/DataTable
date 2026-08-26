-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadEffectWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadEffectWork", package.seeall)

local FightPreloadEffectWork = class("FightPreloadEffectWork", BaseWork)

FightPreloadEffectWork.buff_chuchang = "buff/buff_chuchang"
FightPreloadEffectWork.buff_siwang = "buff/buff_siwang_role"
FightPreloadEffectWork.buff_siwang_monster = "buff/buff_siwang_monster"
FightPreloadEffectWork.buff_zhunbeigongji = "buff/buff_zhunbeigongji"
FightPreloadEffectWork.scene_mask_default = "buff/scene_mask_default"

function FightPreloadEffectWork:onStart(context)
	if FightEffectPool.isForbidEffect then
		self:onDone(true)

		return
	end

	self._concurrentCount = 10
	self._loadingCount = 0
	self._effectWrapList = {}
	self._needPreloadList = {}

	self:_addPreloadEffect(FightHelper.getEffectUrlWithLod(FightPreloadEffectWork.buff_chuchang))
	self:_addPreloadEffect(FightHelper.getEffectUrlWithLod(FightPreloadEffectWork.buff_siwang))
	self:_addPreloadEffect(FightHelper.getEffectUrlWithLod(FightPreloadEffectWork.buff_siwang_monster))
	self:_addPreloadEffect(FightHelper.getEffectUrlWithLod(FightPreloadEffectWork.buff_zhunbeigongji))
	self:_addPreloadEffect(FightHelper.getEffectUrlWithLod(FightPreloadEffectWork.scene_mask_default))

	local mySideMOList = FightDataHelper.entityMgr:getMyNormalList()

	for _, entityMO in ipairs(mySideMOList) do
		local skin = entityMO.skin
		local spineActionDict = skin and lua_skin_spine_action.configDict[skin]

		if spineActionDict then
			local born = spineActionDict[SpineAnimState.born]

			if born and not string.nilorempty(born.effect) then
				local effectList = string.split(born.effect, "#")

				for index, effectPath in ipairs(effectList) do
					self:_addPreloadEffect(FightHelper.getEffectUrlWithLod(effectPath))
				end
			end
		end

		local luXiCo = lua_fight_luxi_skin_effect.configDict[skin]
		local bornCo = luXiCo and luXiCo[SpineAnimState.born]

		if bornCo then
			local effectList = string.split(bornCo.effect, "#")

			for _, effectPath in ipairs(effectList) do
				self:_addPreloadEffect(FightHelper.getEffectUrlWithLod(effectPath))
			end
		end
	end

	local enemySideMOList = FightDataHelper.entityMgr:getEnemyNormalList()

	for _, entityMO in ipairs(enemySideMOList) do
		local skinCO = FightConfig.instance:getSkinCO(entityMO.skin)

		if skinCO and not string.nilorempty(skinCO.effect) then
			local effectArr = string.split(skinCO.effect, "#")

			for i, v in ipairs(effectArr) do
				local a = FightHelper.getEffectUrlWithLod(v)

				self:_addPreloadEffect(FightHelper.getEffectUrlWithLod(v))
			end
		end

		local monsterCO = lua_monster.configDict[entityMO.modelId]

		if monsterCO and not string.nilorempty(monsterCO.effect) then
			local effectArr = string.split(monsterCO.effect, "#")

			for i, v in ipairs(effectArr) do
				local a = FightHelper.getEffectUrlWithLod(v)

				self:_addPreloadEffect(FightHelper.getEffectUrlWithLod(v))
			end
		end
	end

	self:_startPreload()
end

function FightPreloadEffectWork:_addPreloadEffect(path, side)
	if (isDebugBuild or SLFramework.FrameworkSettings.IsEditor) and not string.match(path, "^effects/prefabs/buff/") then
		logError(path .. " 预加载资源需要放在 Assets/ZResourcesLib/effects/prefabs/buff 目录下。")
	end

	if FightEffectPool.hasLoaded(path) then
		return
	end

	if side == nil then
		table.insert(self._needPreloadList, {
			path = path,
			side = FightEnum.EntitySide.BothSide
		})
	end

	if side == FightEnum.EntitySide.MySide or side == FightEnum.EntitySide.BothSide then
		table.insert(self._needPreloadList, {
			path = path,
			side = FightEnum.EntitySide.MySide
		})
	end

	if side == FightEnum.EntitySide.EnemySide or side == FightEnum.EntitySide.BothSide then
		table.insert(self._needPreloadList, {
			path = path,
			side = FightEnum.EntitySide.EnemySide
		})
	end
end

function FightPreloadEffectWork:_startPreload()
	self._loadingCount = math.min(self._concurrentCount, #self._needPreloadList)

	if self._loadingCount > 0 then
		for i = 1, self._loadingCount do
			local last = table.remove(self._needPreloadList, #self._needPreloadList)
			local effect = FightEffectPool.getEffect(last.path, last.side, self._onPreloadOneFinish, self, nil, true)

			table.insert(self._effectWrapList, effect)
		end
	else
		self:onDone(true)
	end
end

function FightPreloadEffectWork:_onPreloadOneFinish(effectWrap, success)
	if not success then
		logError("战斗特效加载失败：" .. effectWrap.path)
	end

	self._loadingCount = self._loadingCount - 1

	FightEffectPool.returnEffect(effectWrap)

	if self._loadingCount <= 0 then
		TaskDispatcher.runDelay(self._startPreload, self, 0.01)
	end
end

function FightPreloadEffectWork:clearWork()
	TaskDispatcher.cancelTask(self._startPreload, self, 0.01)

	if self._effectWrapList then
		for _, effectWrap in ipairs(self._effectWrapList) do
			effectWrap:setCallback(nil, nil)
		end
	end

	self._effectWrapList = nil
end

return FightPreloadEffectWork
