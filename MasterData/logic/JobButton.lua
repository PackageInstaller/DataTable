-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/view/JobButton.lua

module("logic.extensions.petshandbook.view.JobButton", package.seeall)

local JobButton = class("JobButton")

function JobButton:ctor(container)
	self._container = container.gameObject
	self._callBack = nil
	self._jobType = -1
	self._select = false

	self:_onBuildUI()
	self:_onEvent()
end

function JobButton:_onBuildUI()
	self._jobBtn = Framework.ButtonAdapter.GetFrom(self._container, "Button")
	self._btnBg = goutil.findChild(self._container, "Img_BG")
end

function JobButton:_onEvent()
	self._jobBtn:AddClickListener(self._onClick, self)
end

function JobButton:_unEvent()
	self._jobBtn:RemoveClickListener()
end

function JobButton:setCallBack(func)
	self._callBack = func
end

function JobButton:setJobType(type)
	self._jobType = type
end

function JobButton:setBtnNormal(type)
	if self._jobType ~= type then
		self._select = false
	end

	self._btnBg.gameObject:SetActive(false)
end

function JobButton:_onClick()
	if self._callBack then
		self._callBack(self._jobType, self._select)
	end

	self._select = not self._select

	self._btnBg:SetActive(self._select)
end

return JobButton
