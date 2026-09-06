-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/view/TimedialogueView.lua

module("logic.extensions.timecapsule.view.TimedialogueView", package.seeall)

local TimedialogueView = class("TimedialogueView", ViewComponent)

function TimedialogueView:ctor()
	TimedialogueView.super.ctor(self)
end

function TimedialogueView:buildUI()
	TimedialogueView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._dialogGO = self:getGo("dialog")
	self._dialogText = goutil.findChildTextComponent(self.mainGO, "dialog/Text")
	self._role = self:getGo("role")
	self._finger = self:getGo("finger")
	self._nextParagraphBtn = self:getBtn("nextParagraphBtn")
	self._startBtn = self:getBtn("startBtn")
end

function TimedialogueView:bindEvents()
	TimedialogueView.super.bindEvents(self)
	self._nextParagraphBtn:AddClickListener(self._onClickNext, self)
end

function TimedialogueView:unbindEvents()
	TimedialogueView.super.unbindEvents(self)
	self._nextParagraphBtn:RemoveClickListener()
end

function TimedialogueView:destroyUI()
	TimedialogueView.super.destroyUI(self)
end

function TimedialogueView:onEnter()
	TimedialogueView.super.onEnter(self)
	goutil.setActive(self._role, false)
	goutil.setActive(self._finger, false)
	goutil.setActive(self._startBtn.gameObject, false)
	GameUtil.setWidth(self._bg, 0)
	GameUtil.setHeight(self._bg, 0)

	self._playing = false
	self._dialogText.text = ""
	self._dialog = TimeCapsuleConfig.instance:getDialog()
	self._progress = 0
	self._firstParam = self:getFirstParam()

	self:_onClickNext()
end

function TimedialogueView:onEnterFinished()
	TimedialogueView.super.onEnterFinished(self)
end

function TimedialogueView:onExit()
	TimedialogueView.super.onExit(self)

	if self._firstParam and type(self._firstParam) == "function" then
		self._firstParam()
	end
end

function TimedialogueView:onExitFinished()
	TimedialogueView.super.onExitFinished(self)
end

function TimedialogueView:_onClickNext()
	if self._playing then
		removetimer(self._showText, self)

		self._dialogText.text = AssignmentDetailsController.instance:sub(self._dialogAllText.content, 0, self._dialogAllText.maxLength)
		self._playing = false

		return
	end

	for i = self._progress + 1, #self._dialog do
		if self._dialog[i] and self._dialog[i].content ~= "" then
			self:updateText(self._dialog[i])

			self._progress = i

			return
		end
	end

	self:close()
end

function TimedialogueView:updateText(data)
	self._dialogAllText = {
		len = 1,
		content = string.gsub(data.content, "#username#", RoleModel.instance:getUserName())
	}
	self._dialogAllText.maxLength = string.utf8len(self._dialogAllText.content)
	self._dialogAllText.color = {
		index = 1
	}

	local index = 1

	for i = 1, self._dialogAllText.maxLength do
		local c_start, c_ed = string.find(self._dialogAllText.content, "<color=#%w+>", i)

		if c_start then
			local r_start, r_ed = string.find(self._dialogAllText.content, "</color>", i)

			self._dialogAllText.color[index] = {
				c_start = c_start,
				c_ed = c_ed - c_start + 1,
				r_start = r_start,
				r_ed = r_ed - r_start + 1
			}
			index = index + 1
		else
			break
		end
	end

	self._playing = true

	if data.speed == 0 then
		data.speed = 1
	end

	settimer(1 / data.speed, self._showText, self)
end

function TimedialogueView:_showText()
	local len, color, index = #AssignmentDetailsController.instance:sub(self._dialogAllText.content, 1, self._dialogAllText.len + 1), self._dialogAllText.color, self._dialogAllText.color.index

	if self._dialogAllText.color[index] then
		if len >= color[index].c_start and len <= color[index].r_start then
			self._dialogAllText.len = self._dialogAllText.len + color[index].c_ed
			color[index].c_ed = 0
			self._dialogText.text = AssignmentDetailsController.instance:sub(self._dialogAllText.content, 1, self._dialogAllText.len) .. "</color>"
		elseif len >= color[index].r_start then
			self._dialogAllText.len = self._dialogAllText.len + color[index].r_ed
			self._dialogText.text = AssignmentDetailsController.instance:sub(self._dialogAllText.content, 1, self._dialogAllText.len)
			self._dialogAllText.color.index = color.index + 1
		else
			self._dialogText.text = AssignmentDetailsController.instance:sub(self._dialogAllText.content, 1, self._dialogAllText.len)
		end
	else
		self._dialogText.text = AssignmentDetailsController.instance:sub(self._dialogAllText.content, 1, self._dialogAllText.len)
	end

	self._dialogAllText.len = self._dialogAllText.len + 1

	if self._dialogAllText.len > self._dialogAllText.maxLength then
		removetimer(self._showText, self)

		self._playing = false
	end
end

return TimedialogueView
