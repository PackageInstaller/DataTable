-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkTaskCellView.lua

module("logic.extensions.elementspark.view.ElementSparkTaskCellView", package.seeall)

local ElementSparkTaskCellView = class("ElementSparkTaskCellView", EventTaskGroupChildView)

function ElementSparkTaskCellView:_onClickBtnGo(data)
	if ElementSparkController.instance:isResultTime() then
		FloatWordMgr.instance:show("公示阶段，无法跳转")

		return
	end

	ElementSparkTaskCellView.super._onClickBtnGo(self, data)
end

return ElementSparkTaskCellView
