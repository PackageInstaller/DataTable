-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinean/view/DivineAnPopView.lua

module("logic.extensions.divinean.view.DivineAnPopView", package.seeall)

local DivineAnPopView = class("DivineAnPopView", InfinitefuturepopView)

function DivineAnPopView:checkHaveGet(getObj, index)
	local haveGet = index < InfinitefutureModel.instance.curStageId

	getObj:SetActive(haveGet)

	return haveGet
end

function DivineAnPopView:_reloadFinish()
	local curIndex = InfinitefutureModel.instance.curStageId

	if curIndex > 0 then
		self._tableview:MoveCellToCenter(curIndex - 1)
	end
end

return DivineAnPopView
