-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dialogue/view/DialogueView.lua

module("logic.extensions.dialogue.view.DialogueView", package.seeall)

local DialogueView = class("DialogueView", ViewComponent)

function DialogueView:buildUI()
	DialogueView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._dialogGO = self:getGo("dialog")
	self._dialogText = goutil.findChildTextComponent(self.mainGO, "dialog/Text")
	self._role = self:getGo("dialog/role"):GetComponent(typeof(UnityEngine.UI.Image))
	self._roleName = self:getTxt("dialog/role/Image/Text")
	self._finger = self:getGo("finger")
	self._nextParagraphBtn = self:getBtn("nextParagraphBtn")
end

function DialogueView:bindEvents()
	DialogueView.super.bindEvents(self)
	self._nextParagraphBtn:AddClickListener(self._onClickNextParagraph, self)
end

function DialogueView:unbindEvents()
	DialogueView.super.unbindEvents(self)
	self._nextParagraphBtn:RemoveClickListener()
end

function DialogueView:onEnter()
	DialogueView.super.onEnter(self)

	local openParams = self:getOpenParam()

	self._endFunction = openParams[3]
	self._dialog = DialogueConfig.instance:getDialogById(tonumber(openParams[1]))
	self._progress = 0
	self._lightList = openParams[2]
	self._lightList_parent = self:getGo("light").transform
	self._lightList_clickParent = self:getGo("lightClick").transform
	self._playing = false
	self._dialogText.text = ""
	self._lightCloneList = {}
	self._lightClickCloneList = {}

	self:_onClickNextParagraph()
end

function DialogueView:onEnterFinished()
	DialogueView.super.onEnterFinished(self)
	GameUtil.SetActive(ViewMgr.instance._grayMaskGO, false)
end

function DialogueView:onExit()
	DialogueView.super.onExit(self)
	uGuiUtil.clearImage(self._role.gameObject)
	removetimer(self._showText, self)
end

function DialogueView:_onClickNextParagraph()
	if self._playing then
		if self._skip then
			removetimer(self._showText, self)

			self._dialogText.text = AssignmentDetailsController.instance:sub(self._dialogAllText.content, 0, self._dialogAllText.maxLength)
			self._playing = false

			return
		else
			return
		end
	end

	for i = self._progress + 1, #self._dialog do
		if self._dialog[i] and self._dialog[i].desc ~= "" then
			self:updateText(self._dialog[i])

			self._progress = i

			if self._dialog[i].next ~= 0 then
				self._dialog = DialogueConfig.instance:getDialogById(self._dialog[i].next)
				self._progress = 0
			end

			return
		end
	end

	self:close()
end

function DialogueView:close()
	DialogueView.super.close(self)

	if self._endFunction then
		self._endFunction(self._dialog[1].id)
	end
end

function DialogueView:updateText(data)
	self._dialogAllText = {
		len = 1,
		content = string.gsub(data.desc, "#username#", RoleModel.instance:getUserName())
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
	self._skip = data.skip

	if data.speed == 0 then
		data.speed = 1
	end

	settimer(1 / data.speed, self._showText, self)
	uGuiUtil.setSpriteToImage(self._role.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getDialog(data.path), function()
		self._role:SetNativeSize()
	end)

	self._roleName.text = data.name

	if data.textPos then
		local x, y, z, scale = data.textPos[1], data.textPos[2], data.textPos[3], data.textPos[4]

		GameUtil.setLocalPos(self._dialogGO, x, y, z)

		if scale then
			GameUtil.setLocalScale(self._dialogText, scale, scale, scale)
		end
	end

	goutil.setActive(self._finger, data.fingerPos)

	if data.fingerPos then
		local x, y, z = data.fingerPos[1], data.fingerPos[2], data.fingerPos[3]

		GameUtil.setLocalPos(self._finger, x, y, z)
	end

	if data.lightKey and self._lightList then
		for index, value in ipairs(data.lightKey) do
			if value > 100 then
				local id = value % 100

				self._lightClickCloneList[id] = goutil.clone(self._lightList[id][1])

				if self._lightList[id].func then
					local btn = Framework.ButtonAdapter.Get(self._lightClickCloneList[id].gameObject)

					btn:AddClickListener(function()
						self:close()
						self._lightList[id].func(self._lightList[id].handler_obj)
					end)
				end

				goutil.addChildToParent(self._lightClickCloneList[id], self._lightList_clickParent)
				goutil.destroy(self._lightCloneList[value])
			elseif value > 0 then
				self._lightCloneList[value] = goutil.clone(self._lightList[value][1])

				goutil.addChildToParent(self._lightCloneList[value], self._lightList_parent)
				goutil.destroy(self._lightClickCloneList[value])
			else
				goutil.destroy(self._lightCloneList[value])
				goutil.destroy(self._lightClickCloneList[value])
			end
		end
	end

	if data.bgPos then
		local x, y, z = data.bgPos[1], data.bgPos[2], data.bgPos[3]

		GameUtil.setLocalPos(self._bg, x, y, z)
	end

	if data.bgWH then
		local width, height = data.bgWH[1], data.bgWH[2]

		GameUtil.setWidth(self._bg, width)
		GameUtil.setHeight(self._bg, height)
	else
		GameUtil.setWidth(self._bg, 0)
		GameUtil.setHeight(self._bg, 0)
	end

	goutil.setActive(self._nextParagraphBtn.gameObject, self._lightList_clickParent.childCount == 0)
end

function DialogueView:_showText()
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

return DialogueView
