-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preview/Character3DPreviewPresentor.lua

module("logic.extensions.charactersystem.view.preview.Character3DPreviewPresentor", package.seeall)

local M = class("Character3DPreviewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Character_3d_preview_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, Character3DPreviewView.New())

	local titleView = TitleView.New()

	titleView:setHideHomeBtn(true)

	local previewType = CharacterPreviewModel.instance:getShowType()

	if previewType == CharacterPreviewModel.PreviewType.MaxLevel then
		titleView:setTitle(lang("character_preview_title"))
		titleView:setReturnClickEvent(self._onClickReturnSceneBtn, self)
	else
		titleView:setTitle(lang("character_skill_preview_title"))
		titleView:setReturnClickEvent(self._onClickReturnViewBtn, self)
	end

	table.insert(views, titleView)

	return views
end

function M:_onClickReturnSceneBtn()
	ViewMgr.instance:close(self:getViewName())
	SceneFace.instance:backScene()
end

function M:_onClickReturnViewBtn()
	ViewMgr.instance:close(self:getViewName(), true)
end

return M
