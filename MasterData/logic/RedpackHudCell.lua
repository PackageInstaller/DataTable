-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/RedpackHudCell.lua

module("logic.extensions.groupredpack.view.RedpackHudCell", package.seeall)

local RedpackHudCell = class("RedpackHudCell")

function RedpackHudCell:ctor(mainGo)
	self._mainGo = mainGo
	self._goHead = goutil.findChild(mainGo, "btns/btnRound/goHead")
	self._goClick = goutil.findChild(mainGo, "btns/btnRound")
end

function RedpackHudCell:dispose()
	HeadItemController.instance:resetHeadCell(self._goHead)
	GameUtil.rmClickHandler(self._goClick)
end

function RedpackHudCell:SetGray()
	return
end

function RedpackHudCell:refresh(params)
	HeadItemController.instance:setHeadCellByInfo(self._goHead, params.headInfo)
	GameUtil.addClickHandler(self._goClick, self._onClickGrab, self)

	self._redpackInfo = params
end

function RedpackHudCell:_onClickGrab()
	UIStateManager.instance:push(ViewName.GroupRedpackGrabView)
	UIStateManager.instance:push(ViewName.GroupRedpackPopupView, self._redpackInfo)
end

return RedpackHudCell
