-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/BranchUnlockTipsViewPresentor.lua

module("logic.extensions.dungeon.view.mainline.BranchUnlockTipsViewPresentor", package.seeall)

local M = class("BranchUnlockTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Instance_branch_unlock_tips,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Plot)
	}
end

function M:buildViews()
	local views = {}

	self._theTipsView = BranchUnlockTipsView.New()

	table.insert(views, self._theTipsView)
	table.insert(views, BlurBgView.New())

	return views
end

function M:onClickOutside()
	if self._theTipsView then
		self._theTipsView:_onClickCancel()
	else
		ViewMgr.instance:close(self:getViewName())
	end
end

return M
