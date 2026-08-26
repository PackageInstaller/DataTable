-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadOthersWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadOthersWork", package.seeall)

local FightPreloadOthersWork = class("FightPreloadOthersWork", BaseWork)

FightPreloadOthersWork.ui_effectsmat = "ui/materials/dynamic/ui_effects.mat"
FightPreloadOthersWork.ui_mesh = "ui/viewres/fight/uimesh.prefab"
FightPreloadOthersWork.die_monster = "rolesbuff/die_monster.controller"
FightPreloadOthersWork.die_player = "rolesbuff/die_player.controller"
FightPreloadOthersWork.LvUpEffectPath = "ui/viewres/fight/cardrising.prefab"
FightPreloadOthersWork.LvDownEffectPath = "ui/viewres/fight/carddescending.prefab"
FightPreloadOthersWork.LvUpEffect2Path = "ui/viewres/fight/fightskin/0002/cardrising.prefab"
FightPreloadOthersWork.LvDownEffect2Path = "ui/viewres/fight/fightskin/0002/carddescending.prefab"
FightPreloadOthersWork.LvUpEffect3Path = "ui/viewres/fight/fightskin/0003/cardrising.prefab"
FightPreloadOthersWork.LvDownEffect3Path = "ui/viewres/fight/fightskin/0003/carddescending.prefab"
FightPreloadOthersWork.ClothSkillEffectPath = "ui/viewres/fight/ui_effect_flusheddown.prefab"

function FightPreloadOthersWork:onStart(context)
	self._loader = SequenceAbLoader.New()

	self._loader:addPath(ResUrl.getSceneUIPrefab("fight", "fightfloat"))
	self._loader:addPath(ResUrl.getRoleSpineMat("buff_distort"))
	self._loader:addPath(ResUrl.getRoleSpineMat("buff_ice"))
	self._loader:addPath(ResUrl.getRoleSpineMat("buff_stone"))
	self._loader:addPath(ResUrl.getRoleSpineMat("buff_immune"))
	self._loader:addPath(ResUrl.getRoleSpineMat("charator_globmask_stone"))
	self._loader:addPath(ResUrl.getRoleSpineMat("buff_baoyu"))
	self._loader:addPath(ResUrl.getRoleSpineMatTex("noise_01_manual"))
	self._loader:addPath(ResUrl.getRoleSpineMatTex("noise_02_manual"))
	self._loader:addPath(ResUrl.getRoleSpineMatTex("noise_03_manual"))
	self._loader:addPath(ResUrl.getRoleSpineMatTex("crayonmap1_manual"))
	self._loader:addPath(ResUrl.getRoleSpineMatTex("crayonmap2_manual"))
	self._loader:addPath(ResUrl.getRoleSpineMatTex("textures/stone_manual"))
	self._loader:addPath(FightPreloadOthersWork.ui_effectsmat)
	self._loader:addPath(FightPreloadOthersWork.ui_mesh)
	self._loader:addPath(FightPreloadOthersWork.die_monster)
	self._loader:addPath(FightPreloadOthersWork.die_player)
	self._loader:addPath(FightPreloadOthersWork.LvUpEffectPath)
	self._loader:addPath(FightPreloadOthersWork.LvDownEffectPath)
	self._loader:addPath(FightPreloadOthersWork.ClothSkillEffectPath)
	self._loader:setConcurrentCount(5)
	self._loader:setInterval(0.01)
	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function FightPreloadOthersWork:_onPreloadFinish()
	local assetItemDict = self._loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, assetItem)
	end

	self:onDone(true)
end

function FightPreloadOthersWork:_onPreloadOneFail(loader, assetItem)
	logError("战斗资源加载失败：" .. assetItem.ResPath)
end

function FightPreloadOthersWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return FightPreloadOthersWork
