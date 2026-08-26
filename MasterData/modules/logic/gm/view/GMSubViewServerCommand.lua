-- chunkname: @modules/logic/gm/view/GMSubViewServerCommand.lua

module("modules.logic.gm.view.GMSubViewServerCommand", package.seeall)

local GMSubViewServerCommand = class("GMSubViewServerCommand", GMSubViewBase)

function GMSubViewServerCommand:ctor()
	self.tabName = "GM命令"
end

function GMSubViewServerCommand:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewServerCommand:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewServerCommand:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 1
	self.tabIndex = 1

	GMRpc.instance:sendGmModuleRequest(self._onMsg, self)
end

function GMSubViewServerCommand:_onMsg(cmd, resultCode, msg)
	if resultCode == 0 then
		self.allModules = msg.modules

		table.sort(self.allModules, function(a, b)
			return a.order > b.order
		end)

		local lastSelectModule = PlayerPrefsHelper.getString("GMSubViewServerCommand_lastSelectModule", "")

		for i, v in ipairs(self.allModules) do
			if v.name == lastSelectModule then
				self.tabIndex = i

				break
			end
		end

		self:buildUI()
	end
end

function GMSubViewServerCommand:clearAllUI()
	self.lineIndex = 1

	for _, buttonComp in ipairs(self._buttons) do
		buttonComp:RemoveClickListener()
	end

	for _, inputTextComp in ipairs(self._inputTexts) do
		inputTextComp:RemoveOnValueChanged()
	end

	for _, toggleComp in ipairs(self._toggles) do
		toggleComp:RemoveOnValueChanged()
	end

	for _, sliderComp in ipairs(self._sliders) do
		sliderComp:RemoveOnValueChanged()
	end

	for _, dropDownComp in ipairs(self._dropDowns) do
		dropDownComp:RemoveOnValueChanged()
	end

	for k, v in pairs(self._horizontalGroups) do
		gohelper.destroy(v)
	end

	for k, v in pairs(self._goTitles) do
		gohelper.destroy(v)
	end

	tabletool.clear(self._buttons)
	tabletool.clear(self._inputTexts)
	tabletool.clear(self._toggles)
	tabletool.clear(self._sliders)
	tabletool.clear(self._dropDowns)
	tabletool.clear(self._horizontalGroups)
	tabletool.clear(self._goTitles)
end

function GMSubViewServerCommand:buildUI()
	self:clearAllUI()

	self.initUIDone = false

	local names = {}

	for i, v in ipairs(self.allModules) do
		names[i] = v.name
	end

	local drop = self.addDropDown(self, self:getLineGroup(), "选择模块", names, self.onModuleSelect, self)

	drop:SetValue(self.tabIndex - 1)

	local commands = self.allModules[self.tabIndex].cmds

	table.sort(commands, function(a, b)
		local countA = PlayerPrefsHelper.getNumber("GMSubViewServerCommand_count#" .. a.name, 0)
		local countB = PlayerPrefsHelper.getNumber("GMSubViewServerCommand_count#" .. b.name, 0)

		if countA == countB then
			return a.order > b.order
		end

		return countB < countA
	end)
	self:addTitleSplitLine("后端指令")

	for i, v in ipairs(commands) do
		self:addLineIndex()

		local allParamTxt = {}

		for index, vv in ipairs(v.params) do
			self:addLabel(self:getLineGroup(), vv.desc)

			local input = self:addInputText(self:getLineGroup())
			local lastInput = PlayerPrefsHelper.getString("GMSubViewServerCommand_lastInput_" .. v.name .. "_" .. index, "")

			input:SetText(lastInput)
			table.insert(allParamTxt, input)
		end

		local desc = v.desc

		if string.nilorempty(desc) then
			desc = v.name
		end

		local ret = self.addButton(self, self:getLineGroup(), desc, self.onCommandClick, self)

		ret[1]:AddClickListener(self.onCommandClick, self, {
			cmd = v.name,
			paramInput = allParamTxt
		})
	end

	if self._content then
		local y = PlayerPrefsHelper.getNumber("GMSubViewServerCommand_contentY", 0)

		recthelper.setAnchorY(self._content.transform, y)
	end

	self.initUIDone = true
end

function GMSubViewServerCommand:onModuleSelect(value)
	if not self.initUIDone then
		return
	end

	if self.tabIndex == value + 1 then
		return
	end

	self.tabIndex = value + 1

	PlayerPrefsHelper.setString("GMSubViewServerCommand_lastSelectModule", self.allModules[self.tabIndex].name)
	self:buildUI()
end

function GMSubViewServerCommand:onCommandClick(data)
	local strs = {}

	table.insert(strs, data.cmd)

	for index, v in ipairs(data.paramInput) do
		local txt = v:GetText()

		if string.nilorempty(txt) then
			GameFacade.showToastString("参数不能为空！")

			return
		end

		table.insert(strs, txt)
		PlayerPrefsHelper.setString("GMSubViewServerCommand_lastInput_" .. v.name .. "_" .. index, txt)
	end

	GMRpc.instance:sendGMRequest(table.concat(strs, " "))

	local count = PlayerPrefsHelper.getNumber("GMSubViewServerCommand_count#" .. data.cmd, 0)

	PlayerPrefsHelper.setNumber("GMSubViewServerCommand_count#" .. data.cmd, count + 1)
end

function GMSubViewServerCommand:onClose()
	if self._content then
		local y = recthelper.getAnchorY(self._content.transform)

		PlayerPrefsHelper.setNumber("GMSubViewServerCommand_contentY", y)
	end

	GMSubViewServerCommand.super.onClose(self)
end

return GMSubViewServerCommand
