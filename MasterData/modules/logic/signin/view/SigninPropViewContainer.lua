-- chunkname: @modules/logic/signin/view/SigninPropViewContainer.lua

module("modules.logic.signin.view.SigninPropViewContainer", package.seeall)

local SigninPropViewContainer = class("SigninPropViewContainer", BaseViewContainer)

function SigninPropViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SigninPropItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 270
	scrollParam.cellHeight = 250
	self._scrollView = LuaMixScrollView.New(CommonPropListModel.instance, scrollParam)

	self._scrollView:setDynamicGetItem(self._dynamicGetItem, self)
	table.insert(views, SigninPropView.New())
	table.insert(views, self._scrollView)

	return views
end

function SigninPropViewContainer:_dynamicGetItem(mo)
	if not mo then
		return
	end

	if mo.getApproach == MaterialEnum.GetApproach.MonthCard then
		return "signinitemicon", SigninPropItem, self._viewSetting.otherRes[1]
	else
		return "commonitemicon", CommonPropListItem, self._viewSetting.otherRes[2]
	end
end

return SigninPropViewContainer
