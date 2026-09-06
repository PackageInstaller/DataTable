-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/TipMulBtnViewPresentor.lua

module("logic.extensions.tips.view.TipMulBtnViewPresentor", package.seeall)

local TipMulBtnViewPresentor = class("TipMulBtnViewPresentor", TipsViewPresentorBase)

function TipMulBtnViewPresentor:ctor()
	TipMulBtnViewPresentor.super.ctor(self)
end

function TipMulBtnViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TipMulBtnViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/tipmulbtn.prefab"
	}
end

function TipMulBtnViewPresentor:buildViews()
	local views = {}
	local view = TipMulBtnView.New()

	table.insert(views, view)

	return views
end

function TipMulBtnViewPresentor:onClickOutside()
	ViewMgr.instance:close(ViewName.tipMulBtnView)
end

return TipMulBtnViewPresentor
