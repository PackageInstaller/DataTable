-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlematchsuccesView.lua

module("logic.extensions.lotusbattle.view.LotusbattlematchsuccesView", package.seeall)

local LotusbattlematchsuccesView = class("LotusbattlematchsuccesView", ViewComponent)

function LotusbattlematchsuccesView:ctor()
	LotusbattlematchsuccesView.super.ctor(self)
end

function LotusbattlematchsuccesView:unbindEvents()
	LotusbattlematchsuccesView.super.unbindEvents(self)
end

function LotusbattlematchsuccesView:bindEvents()
	LotusbattlematchsuccesView.super.bindEvents(self)
end

function LotusbattlematchsuccesView:buildUI()
	LotusbattlematchsuccesView.super.buildUI(self)

	self._myHeadGo = self:getGo("myHead")
	self._otherHeadGo = self:getGo("otherHead")
	self._txtOtherName = self:getTxt("txtOtherName")
	self._txtMyName = self:getTxt("txtMyName")
end

function LotusbattlematchsuccesView:onExit()
	LotusbattlematchsuccesView.super.onExit(self)
end

function LotusbattlematchsuccesView:onEnter()
	LotusbattlematchsuccesView.super.onEnter(self)
	self:_updateUI()
end

function LotusbattlematchsuccesView:_updateUI()
	local info = LotusbattleModel.instance:getMatchPlayerInfo()

	if not info then
		self:close()

		return
	end

	self:_setOtherInfo(info)
	self:_setMyInfo()
end

function LotusbattlematchsuccesView:_setMyInfo()
	HeadItemController.instance:setMyHeadCell(self._myHeadGo)

	self._txtMyName.text = RoleModel.instance:getUserName()
end

function LotusbattlematchsuccesView:_setOtherInfo(info)
	local headInfo = info.opHeadInfo

	HeadItemController.instance:setHeadCellByInfo(self._otherHeadGo, headInfo)

	self._txtOtherName.text = headInfo.userName
end

return LotusbattlematchsuccesView
