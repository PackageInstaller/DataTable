-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/AddequipmentHacktoolPanelView.lua

module("logic.extensions.hacktool.view.AddequipmentHacktoolPanelView", package.seeall)

local M = class("AddequipmentHacktoolPanelView", ViewComponent)

function M:ctor()
	self._tempDesc = {}
	self._equipId = {}
	self.set = {}
	self.flag = true
	self.pos = -1
end

function M:destroy()
	return
end

function M:buildUI()
	self._btnClose = self:getBtn("addequipment_hacktool_panel_1043582196")
	self._dropDownEquipPart = self:getUIComponent("addequipment_hacktool_panel_1361215487", UIComponentType.DropdownApapter)
	self._dropDownEquipRare = self:getUIComponent("addequipment_hacktool_panel_-615997089", UIComponentType.DropdownApapter)
	self._btnCreateD6 = self:getBtn("addequipment_hacktool_panel_-978215434")
	self._dropDownEquipName = self:getUIComponent("addequipment_hacktool_panel_-428290306", UIComponentType.DropdownApapter)
	self._txtAtk = self:getText("addequipment_hacktool_panel_599102123")
	self._txtDef = self:getText("addequipment_hacktool_panel_474067986")
	self._btnGetEquip = self:getBtn("addequipment_hacktool_panel_-512565843")
	self._inputAtk = self:getUIComponent("addequipment_hacktool_panel_1200994058", UIComponentType.InputFieldAdapter)
	self._inputDef = self:getUIComponent("addequipment_hacktool_panel_-535700212", UIComponentType.InputFieldAdapter)
	self._inputThird = self:getUIComponent("addequipment_hacktool_panel_1935012965", UIComponentType.InputFieldAdapter)
	self._inputDiceid0 = self:getInput("addequipment_hacktool_panel_714976572")
	self._inputDiceid1 = self:getInput("addequipment_hacktool_panel_-86023785")
	self._inputDiceid2 = self:getInput("addequipment_hacktool_panel_892406321")
	self._inputDiceid3 = self:getInput("addequipment_hacktool_panel_-1067507178")
	self._dropDownDicePart = self:getUIComponent("addequipment_hacktool_panel_-1444822928", UIComponentType.DropdownApapter)
	self._inputDiceId = self:getInput("addequipment_hacktool_panel_-724100468")
	self._btnGetDice = self:getBtn("addequipment_hacktool_panel_-884868056")
	self._dropDownDesc1 = self:getUIComponent("addequipment_hacktool_panel_-1064298862", UIComponentType.DropdownApapter)
	self._slider1 = self:getSlider("addequipment_hacktool_panel_39076576")
	self._dropDownLevel1 = self:getUIComponent("addequipment_hacktool_panel_839118947", UIComponentType.DropdownApapter)
	self._dropDownDesc2 = self:getUIComponent("addequipment_hacktool_panel_-269169485", UIComponentType.DropdownApapter)
	self._slider2 = self:getSlider("addequipment_hacktool_panel_1790161997")
	self._dropDownLevel2 = self:getUIComponent("addequipment_hacktool_panel_1080467372", UIComponentType.DropdownApapter)
	self._dropDownDesc3 = self:getUIComponent("addequipment_hacktool_panel_-1243672525", UIComponentType.DropdownApapter)
	self._slider3 = self:getSlider("addequipment_hacktool_panel_1889521874")
	self._dropDownLevel3 = self:getUIComponent("addequipment_hacktool_panel_320716509", UIComponentType.DropdownApapter)
	self._dropDownDesc4 = self:getUIComponent("addequipment_hacktool_panel_2142426088", UIComponentType.DropdownApapter)
	self._slider4 = self:getSlider("addequipment_hacktool_panel_648755360")
	self._dropDownLevel4 = self:getUIComponent("addequipment_hacktool_panel_-203140940", UIComponentType.DropdownApapter)
	self._dropDownDesc5 = self:getUIComponent("addequipment_hacktool_panel_-1409568486", UIComponentType.DropdownApapter)
	self._slider5 = self:getSlider("addequipment_hacktool_panel_-1061087416")
	self._dropDownLevel5 = self:getUIComponent("addequipment_hacktool_panel_-1630248630", UIComponentType.DropdownApapter)
	self._dropDownDesc6 = self:getUIComponent("addequipment_hacktool_panel_-611861156", UIComponentType.DropdownApapter)
	self._slider6 = self:getSlider("addequipment_hacktool_panel_-1278590469")
	self._dropDownLevel6 = self:getUIComponent("addequipment_hacktool_panel_-284058704", UIComponentType.DropdownApapter)
	self._scrollList = self:getGo("addequipment_hacktool_panel_1408436681")
	self.slider = {
		self._slider1,
		self._slider2,
		self._slider3,
		self._slider4,
		self._slider5,
		self._slider6
	}
	self.dropDownDiceLevel = {
		self._dropDownLevel1,
		self._dropDownLevel2,
		self._dropDownLevel3,
		self._dropDownLevel4,
		self._dropDownLevel5,
		self._dropDownLevel6
	}
	self.dropDownDiceDesc = {
		self._dropDownDesc1,
		self._dropDownDesc2,
		self._dropDownDesc3,
		self._dropDownDesc4,
		self._dropDownDesc5,
		self._dropDownDesc6
	}
	self.inputDice = {
		self._inputDiceid0,
		self._inputDiceid1,
		self._inputDiceid2,
		self._inputDiceid3
	}
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickReturn, self)
	self._btnCreateD6:AddClickListener(self._onClickCreateD6, self)
	self._dropDownEquipPart:AddListener(self._onChangeEquip, self)
	self._dropDownEquipRare:AddListener(self._onChangeEquip, self)
	self._dropDownDicePart:AddListener(self._onChangeDesc, self)
	self._btnGetEquip:AddClickListener(self._onClickGetEquip, self)
	self._btnGetDice:AddClickListener(self._onClickGetDice, self)
	self._inputAtk:AddOnEndEdit(self._onEndEditInputAtk, self)
	self._inputDef:AddOnEndEdit(self._onEndEditInputDef, self)

	for i = 1, 3 do
		self.inputDice[i]:AddOnEndEdit(self._onEndEditInputDice, self)
	end

	for i = 1, 6 do
		self.slider[i]:AddOnValueChanged(self._onSliderChanged, self)
	end

	for i = 1, 6 do
		self.dropDownDiceLevel[i]:AddListener(self._onSliderChanged, self)
	end
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCreateD6:RemoveClickListener()
	self._dropDownEquipPart:RemoveClickListener()
	self._dropDownEquipRare:RemoveClickListener()
	self._btnGetEquip:RemoveClickListener()
	self._dropDownDicePart:RemoveClickListener()
	self._btnGetDice:RemoveClickListener()
	self._inputAtk:RemoveOnEndEdit()
	self._inputDef:RemoveOnEndEdit()

	for i = 1, 3 do
		self.inputDice[i]:RemoveOnEndEdit()
	end

	for i = 1, 6 do
		self.slider[i]:RemoveOnValueChanged()
	end

	for i = 1, 6 do
		self.dropDownDiceLevel[i]:RemoveClickListener()
	end
end

function M:_onSliderChanged()
	for i = 1, 6 do
		local value = string.format("%.0f", (self.slider[i]:GetValue() + self.dropDownDiceLevel[i].dropdown.value) * 10)

		self:_updateValue(self.dropDownDiceDesc[i], value, self._dropDownDicePart.dropdown.value + 1, false)
	end
end

function M:_updateValue(dropdownApapter, value, part, isPanel1)
	self.pos = dropdownApapter.dropdown.value

	dropdownApapter.dropdown:ClearOptions()

	if isPanel1 then
		local t = UnityEngine.UI.Dropdown.OptionData.New("")

		dropdownApapter.dropdown.options:Add(t)
	end

	self:_onChangeDescByPart(dropdownApapter, part, value)

	self.pos = -1
end

function M:_onEndEditInputDice()
	for i = 1, #self.inputDice do
		local text = self.inputDice[i]:GetText()
		local value = string.split(text, "#")

		if text ~= "" and text ~= "0" and #value ~= 3 then
			printWarn("TCL--: 116 AddequipmentHacktoolPanelView-value", i, text, value)
			FloatWordMgr.instance:show("输入词条id#词条等级#取值")

			return
		end
	end
end

function M:_onEndEditInputAtk()
	local inputAtk = tonumber(self._inputAtk:GetText())

	self._inputAtk:SetText(self:_checkEndEditValue(inputAtk, "atk"))
end

function M:_onEndEditInputDef()
	local inputDef = tonumber(self._inputDef:GetText())

	self._inputDef:SetText(self:_checkEndEditValue(inputDef, "def"))
end

function M:_checkEndEditValue(inputField, attr)
	local cfg = EquipmentConfig.instance:getConfigList(ConfigName.EquipmentAttr)
	local index = self._dropDownEquipName.dropdown.value + 1
	local id = self._equipId[index][1]
	local temp = ""

	for i, v in pairs(cfg) do
		if v.id == id then
			temp = v[4]
		end
	end

	self._attrs = {}

	for word in string.gmatch(temp, "%d+:%[%d+,%d+,%d+") do
		local t = {}

		for k in string.gmatch(word, "%d+") do
			table.insert(t, k)
		end

		table.insert(self._attrs, t)
	end

	self._txtAtk.text = AttributeDefineConfig.instance:getAttributePartDefineCO(tonumber(self._attrs[1][1])).name
	self._txtDef.text = AttributeDefineConfig.instance:getAttributePartDefineCO(tonumber(self._attrs[2][1])).name

	if attr == "atk" then
		return self:_checkValue(inputField, self._attrs[1])
	elseif attr == "def" then
		return self:_checkValue(inputField, self._attrs[2])
	end
end

function M:_checkValue(attr, tab)
	if attr == nil then
		FloatWordMgr.instance:show("请输入数字")

		return tab[3]
	elseif attr < tonumber(tab[2]) or attr > tonumber(tab[3]) then
		local mid = (tab[2] + tab[3]) / 2

		if attr < mid then
			return tab[2]
		else
			return tab[3]
		end
	else
		local fmt = "%." .. tab[4] .. "f"

		return string.format(fmt, attr)
	end
end

function M:_onChangeEquip()
	self:_getEquipId()

	local selectedPart = self._dropDownEquipPart.dropdown.value + 1

	self._dropDownEquipName.dropdown:ClearOptions()

	for i, v in pairs(self._equipId) do
		local t = UnityEngine.UI.Dropdown.OptionData.New(v[2])

		self._dropDownEquipName.dropdown.options:Add(t)
	end

	self._dropDownEquipName.dropdown.value = -1

	if self._dropDownEquipRare.dropdown.value == 0 then
		return
	end

	self:_onEndEditInputAtk()
	self:_onEndEditInputDef()
end

function M:_onChangeDesc()
	for i = 1, 6 do
		self.dropDownDiceDesc[i].dropdown:ClearOptions()

		local value = string.format("%.0f", (self.slider[i]:GetValue() + self.dropDownDiceLevel[i].dropdown.value) * 10)

		self:_onChangeDescByPart(self.dropDownDiceDesc[i], self._dropDownDicePart.dropdown.value + 1, value)
	end
end

function M:_getEquipId()
	self._tempName = BackpackConfig.instance:getConfigList(ConfigName.ItemEquip)

	local selectedPart = self._dropDownEquipPart.dropdown.value + 1
	local selectedRare = self._dropDownEquipRare.dropdown.value + 2

	self._equipId = {}

	for i, v in pairs(self._tempName) do
		local id = v.id
		local part = v.part
		local rare = v.quality
		local name = v.name

		if part == selectedPart and rare == selectedRare then
			table.insert(self._equipId, {
				id,
				name
			})
		end
	end
end

function M:_insertValue(str, value)
	local pos = string.find(str, "%%")
	local v = string.format("%.0f", value)

	if pos == nil then
		return str .. v
	else
		return str:sub(1, pos - 1) .. v .. "%"
	end
end

function M:_getTempDesc()
	self.flag = false

	for i, v in pairs(self.dropDownDiceDesc) do
		self:_onChangeDescByPart(v, self._dropDownDicePart.dropdown.value + 1, 0)
	end

	self.flag = true
end

function M:_onChangeDescByPart(dropdownApapter, part, value)
	self._tempDesc = {}

	local dice = EquipmentConfig.instance:getConfigList(ConfigName.DiceAttr)

	for i, v in pairs(dice) do
		local id = v.id
		local dicePart = v.part
		local diceDesc = v.desc

		if part == dicePart then
			table.insert(self._tempDesc, {
				id,
				diceDesc
			})
		end
	end

	if self.flag == false then
		return
	end

	for i, v in pairs(self._tempDesc) do
		local k = self:_insertValue(v[2], value)
		local t = UnityEngine.UI.Dropdown.OptionData.New(k)

		dropdownApapter.dropdown.options:Add(t)
	end

	dropdownApapter.dropdown.value = -1
	dropdownApapter.dropdown.value = self.pos
end

function M:_onClickReturn()
	for i, v in pairs(self.set) do
		if v ~= nil then
			self.set[i][2]:onClickDelete()
		end
	end

	self:back()
end

function M:_checkId(id, part)
	for i, v in pairs(self.set) do
		if v[1] == id and v[2].part == part then
			return self.set[i][2]
		end
	end

	return nil
end

function M:_onClickGetEquip()
	self:_getEquipId()
	self:_onSliderChanged()
	self:_onEndEditInputAtk()
	self:_onEndEditInputDef()

	local index = self._dropDownEquipName.dropdown.value + 1
	local data = {
		cmd = GameEnum.GMCmdEnum.AddCustomizedEquip,
		value = {
			extraDiceAttrs = "",
			originDiceAttr = "",
			extraDiceAttrNum = 0,
			level = 50,
			itemId = self._equipId[index][1],
			attrs = {}
		}
	}
	local attrs = tostring(self._attrs[1][1]) .. ":" .. self._inputAtk:GetText()

	attrs = attrs .. "," .. tostring(self._attrs[2][1]) .. ":" .. self._inputDef:GetText()
	attrs = "{" .. attrs .. "}"
	data.value.attrs = attrs
	data.value.originDiceAttr = self.inputDice[1]:GetText()

	local extraDiceAttrNum = 0
	local extraDiceAttrs = ""
	local isStart = false

	for i = 2, #self.inputDice do
		if self.inputDice[i]:GetText() ~= "" then
			extraDiceAttrNum = extraDiceAttrNum + 1

			if not isStart then
				extraDiceAttrs = "\"" .. self.inputDice[i]:GetText() .. "\""
				isStart = true
			else
				extraDiceAttrs = extraDiceAttrs .. "," .. "\"" .. self.inputDice[i]:GetText() .. "\""
			end
		end
	end

	data.value.extraDiceAttrs = extraDiceAttrs ~= "" and "[" .. extraDiceAttrs .. "]" or ""
	data.value.extraDiceAttrNum = extraDiceAttrNum

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_getDiceId(part)
	local itemDice = BackpackConfig.instance:getConfigList(ConfigName.ItemDice)

	for i, v in pairs(itemDice) do
		if v.part == part then
			return v.id
		end
	end

	return nil
end

function M:_onClickGetDice()
	self:_getTempDesc()

	local part = self._dropDownDicePart.dropdown.value + 1
	local dice = {}

	for i = 1, 6 do
		local index = self.dropDownDiceDesc[i].dropdown.value + 1

		dice[tostring(i)] = {
			id = self._tempDesc[index][1],
			level = self.dropDownDiceLevel[i].dropdown.value + 1,
			value = string.format("%.2f", (self.slider[i]:GetValue() + self.dropDownDiceLevel[i].dropdown.value) / 10)
		}
	end

	local data = {
		cmd = GameEnum.GMCmdEnum.AddCustomizedDice,
		value = {}
	}

	data.value.attrs = dice
	data.value.itemId = self:_getDiceId(part)

	HackToolAgent.instance:sendGmRequest(data)
end

local Item = class("Item")

function Item:ctor(go, addEquip)
	self.equip = addEquip
	self.dice = {}
	self.go = go
	self.id = go.transform:Find("Id"):GetComponent("Text")
	self.btnLoad = go.transform:Find("Load"):GetComponent("ButtonAdapter")

	self.btnLoad:AddClickListener(self.onClickLoad, self)

	self.btnDelete = go.transform:Find("Delete"):GetComponent("ButtonAdapter")

	self.btnDelete:AddClickListener(self.onClickDelete, self)
end

function Item:SetId(k)
	self.id.text = k
end

function Item:onClickLoad()
	self.equip._inputDiceId:SetText(self.id.text)

	self.equip._dropDownDicePart.dropdown.value = self.part

	for i = 1, 6 do
		self.equip.dropDownDiceDesc[i].dropdown.value = self.dice[i].index
		self.equip.dropDownDiceLevel[i].dropdown.value = self.dice[i].level - 1

		self.equip.slider[i]:SetValue(self.dice[i].value)
	end
end

function Item:onClickDelete()
	for i, v in pairs(self.equip.set) do
		if v[1] == self.id.text then
			self.equip.set[i] = nil
		end
	end

	self.btnLoad:RemoveClickListener()
	self.btnDelete:RemoveClickListener()
	goutil.destroy(self.go, false)
end

function M:_onClickCreateD6()
	local inputId = self._inputDiceId:GetText()

	if #inputId < 5 then
		FloatWordMgr.instance:show("输入的ID位数不足5位")

		return
	end

	for i, v in pairs(self.set) do
		if inputId == v[1] then
			FloatWordMgr.instance:show("ID重复或其他错误")

			return
		end
	end

	self:_getTempDesc()

	local go = self:getResInstance(ResName.Hacktool_record_d6)
	local item = Item.New(go, self)

	item.part = self._dropDownDicePart.dropdown.value

	item:SetId(inputId)

	for i = 1, 6 do
		local pos = self.dropDownDiceDesc[i].dropdown.value + 1

		item.dice[i] = {
			id = self._tempDesc[pos][1],
			index = self.dropDownDiceDesc[i].dropdown.value,
			level = self.dropDownDiceLevel[i].dropdown.value + 1,
			value = self.slider[i]:GetValue()
		}
	end

	table.insert(self.set, {
		inputId,
		item
	})

	local tempGo = goutil.addChildToParent(item.go, self._scrollList)
end

return M
