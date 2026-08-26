-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_HeroGroupPresetFightView.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_HeroGroupPresetFightView", package.seeall)

local V3a9_BossRush_HeroGroupPresetFightView = class("V3a9_BossRush_HeroGroupPresetFightView", HeroGroupPresetFightView)

function V3a9_BossRush_HeroGroupPresetFightView:onInitView()
	self._btnmodifyname = gohelper.findChildButtonWithAudio(self.viewGO, "container/btnContain/horizontal/#drop_herogroup/#btn_changename")
	self._btnchangeteam = gohelper.findChildButtonWithAudio(self.viewGO, "container/btnContain/horizontal/#drop_herogroup/#btn_changeteam")
	self._txtherogroupname = gohelper.findChildText(self.viewGO, "container/btnContain/horizontal/#drop_herogroup/Label")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_HeroGroupPresetFightView:onOpen()
	local stage, actId = V3a9_BossRushModel.instance:getEnterActStage()

	self._stage = stage
	self._actId = actId
	self._stageMo = V3a9_BossRushModel.instance:getStageMo(actId, stage)

	V3a9_BossRush_HeroGroupPresetFightView.super.onOpen(self)
end

function V3a9_BossRush_HeroGroupPresetFightView:_changeTeam()
	if self._stageMo:isChallenge() then
		GameFacade.showToast(ToastEnum.BossRushHeroGroupCantEdit)

		return
	end

	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()
	local param = {
		showType = HeroGroupPresetEnum.ShowType.Fight,
		heroGroupTypeList = {
			heroGroupType
		}
	}

	HeroGroupPresetController.instance:openHeroGroupPresetTeamView(param)
end

return V3a9_BossRush_HeroGroupPresetFightView
