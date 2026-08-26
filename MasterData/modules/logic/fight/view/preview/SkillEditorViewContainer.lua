-- chunkname: @modules/logic/fight/view/preview/SkillEditorViewContainer.lua

module("modules.logic.fight.view.preview.SkillEditorViewContainer", package.seeall)

local SkillEditorViewContainer = class("SkillEditorViewContainer", BaseViewContainer)

function SkillEditorViewContainer:buildViews()
	local scrollParamHero = ListScrollParam.New()

	scrollParamHero.scrollGOPath = "selectHeros/scroll"
	scrollParamHero.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParamHero.prefabUrl = "selectHeros/scroll/hero"
	scrollParamHero.cellClass = SkillEditorHeroSelectItem
	scrollParamHero.scrollDir = ScrollEnum.ScrollDirV
	scrollParamHero.lineCount = 6
	scrollParamHero.cellWidth = 220
	scrollParamHero.cellHeight = 90
	scrollParamHero.cellSpaceH = 30
	scrollParamHero.cellSpaceV = 10
	scrollParamHero.startSpace = 0

	local scrollParamBuff = ListScrollParam.New()

	scrollParamBuff.scrollGOPath = "selectBuff/scroll"
	scrollParamBuff.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParamBuff.prefabUrl = "selectBuff/scroll/item"
	scrollParamBuff.cellClass = SkillEditorBuffSelectItem
	scrollParamBuff.scrollDir = ScrollEnum.ScrollDirV
	scrollParamBuff.lineCount = 6
	scrollParamBuff.cellWidth = 220
	scrollParamBuff.cellHeight = 90
	scrollParamBuff.cellSpaceH = 30
	scrollParamBuff.cellSpaceV = 10
	scrollParamBuff.startSpace = 0

	local scrollParamScene = ListScrollParam.New()

	scrollParamScene.scrollGOPath = "selectScene/scroll"
	scrollParamScene.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParamScene.prefabUrl = "selectScene/scroll/scene"
	scrollParamScene.cellClass = SkillEditorSceneSelectItem
	scrollParamScene.scrollDir = ScrollEnum.ScrollDirV
	scrollParamScene.lineCount = 6
	scrollParamScene.cellWidth = 220
	scrollParamScene.cellHeight = 90
	scrollParamScene.cellSpaceH = 30
	scrollParamScene.cellSpaceV = 10
	scrollParamScene.startSpace = 0

	local scrollParamAutoPlaySkill = ListScrollParam.New()

	scrollParamAutoPlaySkill.scrollGOPath = "autoPlaySkill/scroll"
	scrollParamAutoPlaySkill.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParamAutoPlaySkill.prefabUrl = "autoPlaySkill/scroll/item"
	scrollParamAutoPlaySkill.cellClass = SkillEditorAutoPlaySkillItem
	scrollParamAutoPlaySkill.scrollDir = ScrollEnum.ScrollDirV
	scrollParamAutoPlaySkill.lineCount = 4
	scrollParamAutoPlaySkill.cellWidth = 240
	scrollParamAutoPlaySkill.cellHeight = 100
	scrollParamAutoPlaySkill.cellSpaceH = 10
	scrollParamAutoPlaySkill.cellSpaceV = 10
	scrollParamAutoPlaySkill.startSpace = 0

	local scrollParamAutoPlaySkillSelect = ListScrollParam.New()

	scrollParamAutoPlaySkillSelect.scrollGOPath = "autoPlaySkill/selectScroll"
	scrollParamAutoPlaySkillSelect.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParamAutoPlaySkillSelect.prefabUrl = "autoPlaySkill/selectScroll/item"
	scrollParamAutoPlaySkillSelect.cellClass = SkillEditorAutoPlaySkillSelectItem
	scrollParamAutoPlaySkillSelect.scrollDir = ScrollEnum.ScrollDirV
	scrollParamAutoPlaySkillSelect.lineCount = 4
	scrollParamAutoPlaySkillSelect.cellWidth = 240
	scrollParamAutoPlaySkillSelect.cellHeight = 100
	scrollParamAutoPlaySkillSelect.cellSpaceH = 10
	scrollParamAutoPlaySkillSelect.cellSpaceV = 10
	scrollParamAutoPlaySkillSelect.startSpace = 0
	self.leftSkillEditorSideView = SkillEditorSideView.New(FightEnum.EntitySide.EnemySide)
	self.rightSkillEditorSideView = SkillEditorSideView.New(FightEnum.EntitySide.MySide)

	return {
		SkillEditorSkillSelectTargetView.New(FightEnum.EntitySide.MySide),
		SkillEditorSkillSelectTargetView.New(FightEnum.EntitySide.EnemySide),
		SkillEditorSkillSelectOutline.New(),
		self.leftSkillEditorSideView,
		self.rightSkillEditorSideView,
		SkillEditorView.New(),
		SkillEditorSceneSelectView.New(),
		SkillEditorHeroSelectView.New(),
		SkillEditorBuffSelectView.New(),
		SkillEditorActionSelectView.New(),
		FightViewSkillFrame.New(true),
		LuaListScrollView.New(SkillEditorHeroSelectModel.instance, scrollParamHero),
		LuaListScrollView.New(SkillEditorBuffSelectModel.instance, scrollParamBuff),
		LuaListScrollView.New(SkillEditorSceneSelectModel.instance, scrollParamScene),
		LuaListScrollView.New(SkillEditorToolAutoPlaySkillModel.instance, scrollParamAutoPlaySkill),
		LuaListScrollView.New(SkillEditorToolAutoPlaySkillSelectModel.instance, scrollParamAutoPlaySkillSelect),
		SkillEditorStanceSelectView.New(),
		SkillEditorCharacterSkinSelectView.New(),
		SkillEditorMulSkillView.New(),
		SkillEditorToolsAutoPlaySkillView.New()
	}
end

return SkillEditorViewContainer
