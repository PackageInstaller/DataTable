-- chunkname: @modules/logic/fight/view/FightSkillSelectViewContainer.lua

module("modules.logic.fight.view.FightSkillSelectViewContainer", package.seeall)

local FightSkillSelectViewContainer = class("FightSkillSelectViewContainer", BaseViewContainer)

function FightSkillSelectViewContainer:buildViews()
	return {
		FightSkillSelectView.New(),
		FightSkillSelectOutline.New()
	}
end

function FightSkillSelectViewContainer:openFightFocusView(entityId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if episodeCo and episodeCo.type == DungeonEnum.EpisodeType.Cachot then
		local controller = V1a6_CachotHeroGroupController.instance

		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = V1a6_CachotHeroGroupModel.instance:getCurGroupMO(),
			setEquipInfo = {
				controller.getFightFocusEquipInfo,
				controller
			},
			entityId = entityId
		})

		return
	end

	if episodeCo and episodeCo.type == DungeonEnum.EpisodeType.Rouge then
		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = RougeHeroGroupModel.instance:getCurGroupMO(),
			entityId = entityId,
			balanceHelper = RougeHeroGroupBalanceHelper
		})

		return
	end

	ViewMgr.instance:openView(ViewName.FightFocusView, {
		entityId = entityId
	})
end

return FightSkillSelectViewContainer
