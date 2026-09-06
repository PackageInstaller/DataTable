-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/view/NoteView.lua

module("logic.extensions.timecapsule.view.NoteView", package.seeall)

local NoteView = class("NoteView", ViewComponent)

function NoteView:ctor()
	NoteView.super.ctor(self)
end

function NoteView:buildUI()
	NoteView.super.buildUI(self)

	self._numberText = goutil.findChildTextComponent(self.mainGO, "number/Text")
	self._nameText = goutil.findChildTextComponent(self.mainGO, "name/Text")
	self._timeText = goutil.findChildTextComponent(self.mainGO, "time/Text")
	self._contentView = self:getGo("contentView")
	self._contentText = goutil.findChildTextComponent(self.mainGO, "contentView/Viewport/content")
	self._closeBtn = self:getBtn("closeBtn")
end

function NoteView:bindEvents()
	NoteView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function NoteView:unbindEvents()
	NoteView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function NoteView:destroyUI()
	NoteView.super.destroyUI(self)
end

function NoteView:onEnter()
	NoteView.super.onEnter(self)

	local firstParam = self:getFirstParam()

	if type(firstParam) == "table" then
		self._numberText.text = firstParam.duoDuoHao
		self._nameText.text = firstParam.name
		self._timeText.text = firstParam.time
		self._contentText.text = firstParam.content

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._contentView:GetComponent(goutil.Type_RectTransform))

		return
	end

	local noteInfo = TimeCapsuleConfig.instance:getNoteById(self:getFirstParam())

	self._numberText.text = noteInfo.duoDuoHao
	self._nameText.text = noteInfo.name
	self._timeText.text = noteInfo.time
	self._contentText.text = noteInfo.content
end

function NoteView:onEnterFinished()
	NoteView.super.onEnterFinished(self)
end

function NoteView:onExit()
	NoteView.super.onExit(self)

	local _openParam = self:getOpenParam()

	if _openParam[2] then
		_openParam[2]()
	end
end

function NoteView:onExitFinished()
	NoteView.super.onExitFinished(self)
end

return NoteView
