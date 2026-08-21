-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/WelfareMainViewPresentor.lua

module("logic.extensions.welfare.view.WelfareMainViewPresentor", package.seeall)

local M = class("WelfareMainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Wekfare_wekfare_main_view_copy,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Wekfare),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Com)
	}
end

function M:buildViews()
	local views = {}
	local titleView = TitleView.New():blockOrgBtn(true, false, false)

	titleView:setHideHomeBtn(true)
	table.insert(views, titleView)
	table.insert(views, WelfareMainView.New())

	self._blurView = BlurBgView.New()

	self._blurView:OnlyBlurScene()
	table.insert(views, self._blurView)

	return views
end

function M:getBlurView()
	return self._blurView
end

return M
