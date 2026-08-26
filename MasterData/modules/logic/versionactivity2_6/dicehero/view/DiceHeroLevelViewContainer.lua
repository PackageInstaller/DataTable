-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroLevelViewContainer.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroLevelViewContainer", package.seeall)

local DiceHeroLevelViewContainer = class("DiceHeroLevelViewContainer", BaseViewContainer)

function DiceHeroLevelViewContainer:buildViews()
	DiceHeroModel.instance.guideChapter = self.viewParam.chapterId

	return {
		DiceHeroLevelView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function DiceHeroLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return DiceHeroLevelViewContainer
