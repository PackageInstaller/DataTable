-- chunkname: @modules/logic/gm/view/command/GMSubViewServerCommand.lua

module("modules.logic.gm.view.command.GMSubViewServerCommand", package.seeall)

local GMSubViewServerCommand = class("GMSubViewServerCommand", GMSubViewBase)
local extendCmds = {
	学院版指挥部 = CollegeGMExtend,
	连线三消 = MatchGameGMExtend
}

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

		local allNames = {}

		table.sort(self.allModules, function(a, b)
			return a.order > b.order
		end)

		local lastSelectModule = PlayerPrefsHelper.getString("GMSubViewServerCommand_lastSelectModule", "")

		for i, v in ipairs(self.allModules) do
			if v.name == lastSelectModule then
				self.tabIndex = i
			end

			allNames[v.name] = true
		end

		for k, v in pairs(extendCmds) do
			if not allNames[k] then
				local module = GMModule_pb.GmModule()

				module.name = k
				module.order = -1

				table.insert(self.allModules, module)

				if k == lastSelectModule then
					self.tabIndex = #self.allModules
				end
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

	local extendObj = self:getExtendObj()

	if extendObj then
		self:addTitleSplitLine("前端指令")
		extendObj:initUI()
	end

	if #commands > 0 then
		self:addTitleSplitLine("后端指令")

		for i, v in ipairs(commands) do
			self:addLineIndex()

			local allParamTxt = {}

			for index, vv in ipairs(v.params) do
				self:addLabel(self:getLineGroup(), vv.desc)

				local lastInput = PlayerPrefsHelper.getString("GMSubViewServerCommand_lastInput_" .. v.name .. "_" .. index, "")

				if string.nilorempty(lastInput) and extendObj then
					lastInput = extendObj:getDefaultVal(v.name, index)
				end

				local input = self:callExtendFunc("getInput", v.name, index, lastInput)

				table.insert(allParamTxt, input)

				if index % 3 == 0 then
					self:addLineIndex()
				end
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
	end

	if self._content and not self._isSetContentY then
		self._isSetContentY = true

		ZProj.UGUIHelper.RebuildLayout(self._content.transform)

		local y = PlayerPrefsHelper.getNumber("GMSubViewServerCommand_contentY", 0)

		recthelper.setAnchorY(self._content.transform, y)
	end

	self.initUIDone = true
end

function GMSubViewServerCommand:getInput(name, index, lastInput)
	local input = self:addInputText(self:getLineGroup())

	input:SetText(lastInput)

	return input
end

function GMSubViewServerCommand:getText(input)
	return input:GetText()
end

function GMSubViewServerCommand:onModuleSelect(value)
	if not self.initUIDone then
		return
	end

	if self.tabIndex == value + 1 then
		return
	end

	self.tabIndex = value + 1

	PlayerPrefsHelper.setString("GMSubViewServerCommand_lastSelectModule", self:getCurModuleName())
	self:buildUI()
end

function GMSubViewServerCommand:onCommandClick(data)
	local strs = {}

	table.insert(strs, data.cmd)

	local extendObj = self:getExtendObj()

	for index, v in ipairs(data.paramInput) do
		local txt = self:callExtendFunc("getText", v)

		if string.nilorempty(txt) then
			GameFacade.showToastString("参数不能为空！")

			return
		end

		table.insert(strs, txt)
		PlayerPrefsHelper.setString("GMSubViewServerCommand_lastInput_" .. data.cmd .. "_" .. index, txt)
	end

	local cmd = table.concat(strs, " ")

	GMRpc.instance:sendGMRequest(cmd)
	GameFacade.showToast(ToastEnum.IconId, cmd)

	local count = PlayerPrefsHelper.getNumber("GMSubViewServerCommand_count#" .. data.cmd, 0)

	PlayerPrefsHelper.setNumber("GMSubViewServerCommand_count#" .. data.cmd, count + 1)

	if extendObj then
		extendObj:onCommandClick(data.cmd)
	end
end

function GMSubViewServerCommand:getCurModuleName()
	return self.allModules[self.tabIndex].name
end

function GMSubViewServerCommand:getExtendObj()
	local moduleName = self.allModules[self.tabIndex].name

	self._extendObjs = self._extendObjs or {}
	self._extendObjs[moduleName] = self._extendObjs[moduleName] or extendCmds[moduleName] and extendCmds[moduleName].New(self) or nil

	return self._extendObjs[moduleName]
end

function GMSubViewServerCommand:callExtendFunc(funcName, ...)
	local extendObj = self:getExtendObj()

	return extendObj and extendObj[funcName] and extendObj[funcName](extendObj, ...) or self[funcName](self, ...)
end

function GMSubViewServerCommand:onClose()
	if self._content then
		local y = recthelper.getAnchorY(self._content.transform)

		PlayerPrefsHelper.setNumber("GMSubViewServerCommand_contentY", y)
	end

	GMSubViewServerCommand.super.onClose(self)
end

return GMSubViewServerCommand
