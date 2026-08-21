-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsCharacterSkillDetailViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsCharacterSkillDetailViewPresentor", package.seeall)

local M = class("ToolTipsCharacterSkillDetailViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_skill_detail_tips_copy,
		ViewlibResPath.BuffDetailItem1,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Authority)
	}
end

function M:buildViews()
	local views = {}

	self._clickView = ToolTipsPointerDownHandlerComp.New()

	table.insert(views, self._clickView)

	self._viewTips = ToolTipsCharacterSkillComp.New()

	table.insert(views, self._viewTips)
	table.insert(views, ToolTipsFixTipsPosComp.New())

	return views
end

function M:_onCloseAnimationDone()
	if self._clickView._isDraging then
		self._clickView:simulateCloseWhenDraging()
	else
		M.super._onCloseAnimationDone(self)
	end
end

function M:closeWhenDragEnd()
	M.super._onCloseAnimationDone(self)
end

function M:getSelfWidth()
	return self._viewTips:getSelfWidth()
end

function M:getSelfHeight()
	return self._viewTips:getSelfHeight()
end

return M
