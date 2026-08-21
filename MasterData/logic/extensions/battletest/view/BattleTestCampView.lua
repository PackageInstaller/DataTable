-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battletest/view/BattleTestCampView.lua

module("logic.extensions.battletest.view.BattleTestCampView", package.seeall)

local BattleTestCampView = class("BattleTestCampView")
local kRowCount = 5
local kDefaultWidth = 120
local kTitle = {}

table.insert(kTitle, {
	desc = "编号",
	key = "code",
	type = "int"
})
table.insert(kTitle, {
	desc = "等级",
	key = "level",
	isExtra = true,
	type = "int"
})
table.insert(kTitle, {
	desc = "名字",
	key = "name",
	type = "string"
})
table.insert(kTitle, {
	desc = "战斗阵营",
	key = "battleCamp",
	type = "int"
})
table.insert(kTitle, {
	desc = "坐标",
	key = "coordinates",
	isExtra = true,
	type = "string"
})
table.insert(kTitle, {
	desc = "技能",
	key = "skillCodes",
	width = 300,
	type = "string"
})
table.insert(kTitle, {
	desc = "技能升级",
	key = "enhanceCodes",
	width = 400,
	type = "string"
})
table.insert(kTitle, {
	desc = "移动力",
	key = "move",
	type = "int"
})
table.insert(kTitle, {
	desc = "血量",
	key = "maxHp",
	type = "int"
})
table.insert(kTitle, {
	desc = "物理攻击",
	key = "atkPhy",
	type = "int"
})
table.insert(kTitle, {
	desc = "物理防御",
	key = "defPhy",
	type = "int"
})
table.insert(kTitle, {
	desc = "魔法攻击",
	key = "atkMag",
	type = "int"
})
table.insert(kTitle, {
	desc = "魔法防御",
	key = "defMag",
	type = "int"
})
table.insert(kTitle, {
	desc = "灵感",
	key = "inspiration",
	type = "int"
})
table.insert(kTitle, {
	desc = "是否有理智",
	key = "hasSanity",
	type = "int"
})
table.insert(kTitle, {
	desc = "理智",
	key = "sanity",
	type = "int"
})
table.insert(kTitle, {
	desc = "弱点",
	key = "weakPointColor",
	type = "int"
})
table.insert(kTitle, {
	desc = "弱点血量比例",
	key = "weakPointHpRate",
	type = "number"
})
table.insert(kTitle, {
	desc = "AI",
	key = "aiName",
	type = "string"
})

local function loadMonsterConfig(monsterCode)
	if BattleConfigUtil.isMonsterCode(monsterCode) then
		local levelCode = math.floor(monsterCode / 100)

		MonsterConfig.instance:loadLevelMonsterConfig(levelCode)
	end
end

function BattleTestCampView:ctor(mainGO, templatesGO)
	self.mainGO = mainGO
	self.templatesGO = templatesGO
	self._inputRowList = {}
end

function BattleTestCampView:buildUI()
	local goTitleCellTemplate = goutil.findChild(self.templatesGO, "TitleCellTemplate")
	local goInputCellTempalte = goutil.findChild(self.templatesGO, "InputCellTemplate")
	local goRowTemplate = goutil.findChild(self.templatesGO, "RowTemplate")
	local goContent = goutil.findChild(self.mainGO, "Viewport/Content")

	self:_buildTitles(goContent, goRowTemplate, goTitleCellTemplate)
	self:_buildContents(goContent, goRowTemplate, goInputCellTempalte)
end

function BattleTestCampView:destroyUI()
	for _, inputRow in pairs(self._inputRowList) do
		inputRow:destroyUI()
	end

	self.mainGO = nil
	self.templatesGO = nil
	self._inputRowList = nil
end

function BattleTestCampView:setCampData(campData)
	if campData then
		for index, inputRow in pairs(self._inputRowList) do
			inputRow:setRowData(campData[index])
		end
	else
		for index, inputRow in pairs(self._inputRowList) do
			inputRow:setRowData(false)
		end
	end
end

function BattleTestCampView:getCampData()
	local campData = {}

	for index, inputRow in pairs(self._inputRowList) do
		local rowData = inputRow:getRowData()

		campData[index] = rowData
	end

	return campData
end

function BattleTestCampView:isCampDataEmpty(campData)
	if campData then
		for _, rowData in pairs(campData) do
			if rowData then
				return false
			end
		end
	end

	return true
end

function BattleTestCampView:_buildTitles(goContent, goRowTemplate, goTitleCellTemplate)
	local goTitle = goutil.clone(goRowTemplate, "title")

	goutil.addChildToParent(goTitle, goContent)

	for _, titleCell in pairs(kTitle) do
		local goTitleCell = goutil.clone(goTitleCellTemplate, titleCell.key)

		RectTransformUtils.SetWidth(goTitleCell.transform, titleCell.width or kDefaultWidth)

		local txtTitle = goutil.findChildTextComponent(goTitleCell, "Text")

		txtTitle.text = titleCell.desc

		goutil.addChildToParent(goTitleCell, goTitle)
	end
end

function BattleTestCampView:_buildContents(goContent, goRowTemplate, goInputCellTempalte)
	local inputRowList = self._inputRowList

	for i = 1, kRowCount do
		local goRow = goutil.clone(goRowTemplate, string.format("content%s", i))
		local inputRow = BattleTestCampView.InputRow.New(goRow)

		inputRow:buildInputRow(goInputCellTempalte)
		goutil.addChildToParent(goRow, goContent)

		inputRowList[i] = inputRow
	end
end

BattleTestCampView.InputRow = class("BattleTestCampView_InputRow")

function BattleTestCampView.InputRow:ctor(mainGO)
	self.mainGO = mainGO
	self._inputFieldList = {}
end

function BattleTestCampView.InputRow:destroyUI()
	for _, inputField in pairs(self._inputFieldList) do
		inputField:RemoveOnEndEdit()
	end

	self.mainGO = nil
	self._inputFieldList = nil
end

function BattleTestCampView.InputRow:setRowData(rowData)
	if rowData then
		local inputFieldList = self._inputFieldList

		for index, titleCell in pairs(kTitle) do
			local inputField = inputFieldList[index]
			local value = rowData[titleCell.key]

			if value then
				inputField:SetText(value)
			end

			if index == 1 then
				loadMonsterConfig(value)
			end
		end
	else
		local inputFieldList = self._inputFieldList

		for index, _ in pairs(kTitle) do
			local inputField = inputFieldList[index]

			inputField:SetText("")
		end
	end
end

function BattleTestCampView.InputRow:getRowData()
	local inputFieldList = self._inputFieldList

	if string.nilorempty(inputFieldList[1]:GetText()) then
		return false
	end

	local rowData = {}

	for i, inputField in pairs(inputFieldList) do
		local titleCell = kTitle[i]
		local value = inputField:GetText()

		if titleCell.type == "int" then
			rowData[titleCell.key] = checkint(value)
		elseif titleCell.type == "number" then
			rowData[titleCell.key] = checknumber(value)
		else
			rowData[titleCell.key] = value
		end
	end

	return rowData
end

function BattleTestCampView.InputRow:buildInputRow(goInputCellTempalte)
	local mainGO = self.mainGO
	local inputFieldList = self._inputFieldList

	for index, titleCell in pairs(kTitle) do
		local goInputCell = goutil.clone(goInputCellTempalte, titleCell.key)

		RectTransformUtils.SetWidth(goInputCell.transform, titleCell.width or kDefaultWidth)

		local inputField = Astral.InputFieldAdapter.Get(goInputCell)

		if index == 1 then
			inputField:AddOnEndEdit(self._onEndEditCode, self)
		elseif index == 2 then
			inputField:AddOnEndEdit(self._onEndEditLevel, self)
		end

		goutil.addChildToParent(goInputCell, mainGO)

		inputFieldList[index] = inputField
	end
end

function BattleTestCampView.InputRow:_onEndEditCode(value)
	self:_updateAllField()
end

function BattleTestCampView.InputRow:_onEndEditLevel(value)
	self:_updateAllField()
end

function BattleTestCampView.InputRow:_updateAllField()
	local inputFieldList = self._inputFieldList
	local code = checkint(inputFieldList[1]:GetText())
	local level = checkint(inputFieldList[2]:GetText())

	if code == 0 then
		return
	end

	loadMonsterConfig(code)

	local entityCO = BattleConfigUtil.getEntityConfig(code)

	if not entityCO then
		printError("找不到对应编号角色或者怪物的数据，请检查配置, code=", code)

		return
	end

	local configFormula = BattleConfigUtil.isCharacterCode(code) and BattleTestFormula.characterConfigFormula or BattleTestFormula.monsterConfigFormula

	if level <= 0 then
		level = configFormula.level(entityCO)

		inputFieldList[2]:SetText(level)
	end

	for index, titleCell in pairs(kTitle) do
		if not titleCell.isExtra then
			local inputField = inputFieldList[index]
			local defaultValue = configFormula[titleCell.key](entityCO, level)

			inputField:SetText(defaultValue)
		end
	end
end

return BattleTestCampView
