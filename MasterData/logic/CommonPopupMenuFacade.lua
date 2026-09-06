-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/popupmenu/facade/CommonPopupMenuFacade.lua

module("logic.extensions.common.popupmenu.facade.CommonPopupMenuFacade", package.seeall)

local CommonPopupMenuFacade = class("CommonPopupMenuFacade", BaseFacade)

CommonPopupMenuFacade.OnPopupClick = "CommonPopupMenuFacade.OnPopupClick"
CommonPopupMenuFacade.OnViewClose = "CommonPopupMenuFacade.OnViewClose"

function CommonPopupMenuFacade:ctor()
	NotifyDispatcher.extend(self)
end

function CommonPopupMenuFacade:OpenView(...)
	local viewMgr = ViewMgr.instance
	local viewName = ViewName.commonPopupMenu

	if viewMgr:isOpen(viewName) then
		viewMgr:close(viewName)
	end

	viewMgr:open(viewName, ...)
end

function CommonPopupMenuFacade:_CloseView()
	self:dispatch(CommonPopupMenuFacade.OnViewClose)
end

function CommonPopupMenuFacade:_ClickPopup(id)
	self:dispatch(CommonPopupMenuFacade.OnPopupClick, id)
end

function CommonPopupMenuFacade:popupMenu(pos, list, selectCallBack, handler, closeCallBack)
	local viewClose, onSelected

	function viewClose()
		self:removeListener(CommonPopupMenuFacade.OnViewClose, viewClose)
		self:removeListener(CommonPopupMenuFacade.OnPopupClick, onSelected)

		if handler ~= nil then
			GameUtil.callBack(closeCallBack, handler)
		else
			GameUtil.callBack(closeCallBack)
		end
	end

	function onSelected(idx)
		if handler ~= nil then
			GameUtil.callBack(selectCallBack, handler, idx)
		else
			GameUtil.callBack(selectCallBack, idx)
		end
	end

	self:addListener(CommonPopupMenuFacade.OnViewClose, viewClose)
	self:addListener(CommonPopupMenuFacade.OnPopupClick, onSelected)
	self:OpenView(pos, list)
end

CommonPopupMenuFacade.instance = CommonPopupMenuFacade.New()

return CommonPopupMenuFacade
