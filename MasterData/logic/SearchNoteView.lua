-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/view/SearchNoteView.lua

module("logic.extensions.timecapsule.view.SearchNoteView", package.seeall)

local SearchNoteView = class("SearchNoteView", ViewComponent)

function SearchNoteView:ctor()
	SearchNoteView.super.ctor(self)
end

function SearchNoteView:buildUI()
	SearchNoteView.super.buildUI(self)

	self._input = self:getInput("input")
	self._closeBtn = self:getBtn("close")
	self._enterBtn = self:getBtn("enter")
end

function SearchNoteView:bindEvents()
	SearchNoteView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._enterBtn:AddClickListener(self._onClickEnter, self)
end

function SearchNoteView:unbindEvents()
	SearchNoteView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._enterBtn:RemoveClickListener()
end

function SearchNoteView:destroyUI()
	SearchNoteView.super.destroyUI(self)
end

function SearchNoteView:onEnter()
	SearchNoteView.super.onEnter(self)

	self._firstParam = self:getFirstParam()
end

function SearchNoteView:onEnterFinished()
	SearchNoteView.super.onEnterFinished(self)
end

function SearchNoteView:onExit()
	SearchNoteView.super.onExit(self)

	if self._firstParam and type(self._firstParam) == "function" then
		self._firstParam()
	end
end

function SearchNoteView:onExitFinished()
	SearchNoteView.super.onExitFinished(self)
end

function SearchNoteView:_onClickEnter()
	local duoDuoHao = self._input:GetText()

	if duoDuoHao and duoDuoHao ~= "" then
		TimeCapsuleAgent.instance:sendPM_TCSearchDesireReq(tonumber(duoDuoHao), function(msg)
			self:close()

			local noteInfo = {
				duoDuoHao = msg.duoDuoHao,
				name = msg.playerName,
				time = msg.desireTime,
				content = msg.desireContent
			}

			UIStateManager.instance:push(ViewName.NoteView, noteInfo)
		end)
	end
end

return SearchNoteView
