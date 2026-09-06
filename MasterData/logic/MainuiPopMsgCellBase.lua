-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainuiPopMsgCellBase.lua

module("logic.extensions.mainui.view.MainuiPopMsgCellBase", package.seeall)

local MainuiPopMsgCellBase = class("MainuiPopMsgCellBase")

function MainuiPopMsgCellBase:ctor(mainGO, params)
	self.mainGO = mainGO
	self._params = params
	self._info = params.info
end

function MainuiPopMsgCellBase:startup()
	self:_buildUI()
	self:_onEnter()
	self:_bindEvents()
end

function MainuiPopMsgCellBase:dispose()
	self:_onExit()
	self:_unbindEvents()
	goutil.destroy(self.mainGO)
end

function MainuiPopMsgCellBase:_unbindEvents()
	return
end

function MainuiPopMsgCellBase:_bindEvents()
	return
end

function MainuiPopMsgCellBase:_buildUI()
	return
end

function MainuiPopMsgCellBase:_onExit()
	return
end

function MainuiPopMsgCellBase:_onEnter()
	return
end

function MainuiPopMsgCellBase:_setTextOrDisable(txt, content, condition)
	if condition == nil then
		condition = not string.nilorempty(content)
	end

	if not goutil.isNil(txt) then
		if condition then
			txt.text = content

			GameUtil.SetActive(txt, true)
		else
			GameUtil.SetActive(txt, false)
		end
	end
end

function MainuiPopMsgCellBase:_closeSelf()
	GlobalDispatcher:dispatch(GlobalNotify.PopupMsgReqDestroySelf, self._params)
end

return MainuiPopMsgCellBase
