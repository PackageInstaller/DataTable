-- chunkname: @modules/logic/versionactivity2_7/v2a7_selfselectsix_1/view/V2a7_SelfSelectSix_PickChoiceViewContainer.lua

module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PickChoiceViewContainer", package.seeall)

local V2a7_SelfSelectSix_PickChoiceViewContainer = class("V2a7_SelfSelectSix_PickChoiceViewContainer", BaseViewContainer)

function V2a7_SelfSelectSix_PickChoiceViewContainer:buildViews()
	local views = {}
	local mixScrollParam = MixScrollParam.New()

	mixScrollParam.scrollGOPath = "#scroll_rule"
	mixScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	mixScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	mixScrollParam.cellClass = V2a7_SelfSelectSix_PickChoiceItem
	mixScrollParam.scrollDir = ScrollEnum.ScrollDirV
	mixScrollParam.lineCount = 1
	mixScrollParam.startSpace = 0
	mixScrollParam.endSpace = 30
	self._csScrollView = LuaMixScrollView.New(V2a7_SelfSelectSix_PickChoiceListModel.instance, mixScrollParam)

	table.insert(views, V2a7_SelfSelectSix_PickChoiceView.New())
	table.insert(views, self._csScrollView)

	return views
end

return V2a7_SelfSelectSix_PickChoiceViewContainer
