-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadViewWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadViewWork", package.seeall)

local FightPreloadViewWork = class("FightPreloadViewWork", BaseWork)

FightPreloadViewWork.ui_chupai_01 = "ui_chupai_01"
FightPreloadViewWork.ui_chupai_02 = "ui_chupai_02"
FightPreloadViewWork.ui_chupai_03 = "ui_chupai_03"
FightPreloadViewWork.ui_chupai_skin01 = "skin/ui_chupai_skin01"
FightPreloadViewWork.ui_chupai_skin03 = "skin/ui_chupai_skin03"
FightPreloadViewWork.ui_kapaituowei = "ui_kapaituowei"
FightPreloadViewWork.ui_dazhaoka = "ui_dazhaoka"
FightPreloadViewWork.ui_effect_dna_c = "ui/viewres/fight/ui_effect_dna_c.prefab"
FightPreloadViewWork.ui2_effect_dna_c = "ui/viewres/fight/fightskin/0002/cardmerging.prefab"
FightPreloadViewWork.ui3_effect_dna_c = "ui/viewres/fight/fightskin/0003/cardmerging.prefab"
FightPreloadViewWork.FightSpriteAssets = "ui/spriteassets/fight.asset"

function FightPreloadViewWork:onStart(context)
	self._loader = SequenceAbLoader.New()

	self._loader:addPath(ResUrl.getSceneUIPrefab("fight", "fightfloat"))
	self._loader:addPath(ResUrl.getSceneUIPrefab("fight", "fightname"))
	self._loader:addPath(ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_01))
	self._loader:addPath(ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_02))
	self._loader:addPath(ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_03))
	self._loader:addPath(ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_skin01))
	self._loader:addPath(ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_skin03))
	self._loader:addPath(ResUrl.getUIEffect(FightPreloadViewWork.ui_dazhaoka))
	self._loader:addPath(FightPreloadViewWork.FightSpriteAssets)
	self._loader:addPath(FightPreloadViewWork.ui_effect_dna_c)
	self._loader:addPath(FightPreloadViewWork.ui2_effect_dna_c)
	self._loader:addPath(FightPreloadViewWork.ui3_effect_dna_c)

	local fightViewSetting = ViewMgr.instance:getSetting(ViewName.FightView)

	self._loader:addPath(fightViewSetting.mainRes)

	for _, one in ipairs(fightViewSetting.otherRes) do
		self._loader:addPath(one)
	end

	local roundViewSetting = ViewMgr.instance:getSetting(ViewName.FightRoundView)

	self._loader:addPath(roundViewSetting.mainRes)

	local skillSelectViewSetting = ViewMgr.instance:getSetting(ViewName.FightSkillSelectView)

	self._loader:addPath(skillSelectViewSetting.mainRes)
	self._loader:setConcurrentCount(10)
	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function FightPreloadViewWork:_onPreloadFinish()
	local assetItemDict = self._loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, assetItem)
	end

	self:onDone(true)
end

function FightPreloadViewWork:_onPreloadOneFail(loader, assetItem)
	logError("战斗资源加载失败：" .. assetItem.ResPath)
end

function FightPreloadViewWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return FightPreloadViewWork
