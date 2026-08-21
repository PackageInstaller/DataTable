-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/BattleExplainTipsPresentor.lua

module("logic.extensions.guide.view.BattleExplainTipsPresentor", package.seeall)

local M = class("BattleExplainTipsPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Battle_Explain_Tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BattleExplainTips.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
