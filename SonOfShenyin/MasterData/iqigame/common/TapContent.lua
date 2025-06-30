-- chunkname: @IQIGame\\Common\\TapContent.lua

TapContent = {}

function TapContent:New(count)
	local tc = {}

	tc.count = count

	setmetatable(tc, {
		__index = TapContent
	})

	return tc
end

function TapContent:Init(root, onToggleChange, repeatedly, updateItem, RepeatedCall, TagDesTable)
	self.tapCount = 0
	self.CurToogle = nil
	self.toggleList = {}
	self.root = root
	self.onToggleChange = onToggleChange
	self.updateItem = updateItem
	self.repeatedlyList = repeatedly
	self.TagDesTable = TagDesTable
	self.RepeatedCall = RepeatedCall

	self:InitPanel()
	self:BindEvent()
end

function TapContent:InitFold(root, onToggleChange, repeatedly, updateItem, TagArr, CurTapContent, Part_tagbtnBtn, TagDesTable)
	self.tapCount = 0
	self.CurToogle = nil
	self.toggleList = {}
	self.root = root
	self.onToggleChange = onToggleChange
	self.updateItem = updateItem
	self.repeatedlyList = repeatedly
	self.tapShow = false
	self.TagArr = TagArr
	self.CurTapContent = CurTapContent
	self.TagDesTable = TagDesTable
	self.Part_tagbtnButton = Part_tagbtnBtn:GetComponent("Button")

	function self.RepeatedCall()
		self:OnClicktagbtn()
	end

	self.Part_tagbtnButton.onClick:AddListener(self.RepeatedCall)
	self:InitPanel()
	self:BindEvent()
end

function TapContent:InitDropdown(root, onToggleChange, DropdownBtn, TargetScale, updateItem)
	self.tapCount = 0
	self.CurToogle = nil
	self.toggleList = {}
	self.DropdownBtnMark = false
	self.DropdownTagName = {}
	self.root = root
	self.onToggleChange = onToggleChange
	self.DropdownBtn = DropdownBtn
	self.TargetScale = TargetScale
	self.InitDropdownMark = false
	self.UpArr = self.DropdownBtn.transform:Find("UpArr")
	self.DownArr = self.DropdownBtn.transform:Find("DownArr")
	self.CurChooseDes = self.DropdownBtn.transform:Find("Des"):GetComponent("Text")
	self.updateItem = updateItem

	self:InitPanel()
	self:BindEvent()
end

function TapContent:AddTagDesTable(TagDesTable)
	self.TagDesTable = TagDesTable
end

function TapContent:OnClicktagbtn(_self, go)
	self.tapShow = not self.tapShow

	local localScale_y, localRotation_z

	if self.tapShow == false then
		localScale_y = 1
		localRotation_z = 180
	else
		localRotation_z = 0
		localScale_y = 0
	end

	self.TagArr.gameObject.transform.rotation = Quaternion.Euler(0, 0, localRotation_z)
	self.CurTapContent.gameObject.transform.localScale = Vector3.New(1, localScale_y, 1)
end

function TapContent:RestTagArr()
	self.tapShow = false

	self:OnClicktagbtn()
end

function TapContent:InitPanel()
	if self.count then
		self:InitItems()

		return
	end

	local count = self.root.transform.childCount

	for i = 1, count do
		local child = self.root.transform:GetChild(i - 1)

		if child then
			self:AddItem(child.gameObject)
		end
	end
end

function TapContent:InitItems()
	local trans = self.root.transform:GetChild(0)

	if trans then
		local prefab = trans.gameObject

		prefab.name = 1

		prefab:SetActive(true)
		self:AddItem(prefab)

		for i = 2, self.count do
			local child = newObject(prefab)

			child.transform:SetParent(self.root.transform)

			child.transform.localScale = Vector3.one
			child.transform.localPosition = Vector3.zero
			child.name = i

			self:AddItem(child)
		end
	end
end

function TapContent:AddItem(item)
	local toggle = item:GetComponent("Toggle")

	if toggle then
		self.tapCount = self.tapCount + 1

		table.insert(self.toggleList, toggle)
	end

	if self.TagDesTable and self.TagDesTable[self.tapCount] then
		local targetGraphicText = toggle.targetGraphic.gameObject.transform:Find("Text"):GetComponent("Text")
		local graphicText = toggle.graphic.gameObject.transform:Find("Text"):GetComponent("Text")

		targetGraphicText.text = self.TagDesTable[self.tapCount]
		graphicText.text = self.TagDesTable[self.tapCount]
	end

	if self.DropdownBtn then
		local name = toggle.targetGraphic.gameObject.transform:Find("des"):GetComponent("Text").text

		self.DropdownTagName[toggle.name] = name
	end

	if self.updateItem then
		self.updateItem(item)
	end
end

function TapContent:DetectionSemblanceTable(name)
	if self.semblanceTable == nil then
		return false
	end

	for i = 1, #self.semblanceTable do
		if name == self.semblanceTable[i] then
			return true
		end
	end

	return false
end

function TapContent:BindEvent()
	for i = 1, self.tapCount do
		self.toggleList[i].isOn = false

		UGUIUtil.AddToggleGo(self.toggleList[i].gameObject, function(go, isOn)
			if isOn == true then
				if self:DetectionSemblanceTable(go.gameObject.name) then
					return
				end

				if self:IsRepeatedlyList(go) == false and self.CurToogle and go.gameObject.name == self.CurToogle.gameObject.name then
					if self.RepeatedCall then
						self.RepeatedCall()
					end

					return
				end

				if self.RepeatedCall then
					self.RepeatedCall()
				end

				self:ClickEvent()
			end
		end)
	end

	if self.DropdownBtn then
		local button = self.DropdownBtn:GetComponent("Button")

		button.onClick:AddListener(function()
			self:OnDropdownBtnClick()
		end)
	end
end

function TapContent:IsRepeatedlyList(go)
	if self.repeatedlyList then
		for i = 1, #self.repeatedlyList do
			if go.gameObject.name == self.repeatedlyList[i] then
				return true
			end
		end
	end

	return false
end

function TapContent:OnResetDropdownBtnClick()
	self.DropdownBtnMark = false

	self.UpArr.gameObject:SetActive(self.DropdownBtnMark)
	self.DownArr.gameObject:SetActive(not self.DropdownBtnMark)

	local y = self.DropdownBtnMark and 1 or 0

	self.TargetScale.transform.localScale = Vector3.New(1, y, 1)
end

function TapContent:OnDropdownBtnClick()
	self.DropdownBtnMark = not self.DropdownBtnMark

	self.UpArr.gameObject:SetActive(self.DropdownBtnMark)
	self.DownArr.gameObject:SetActive(not self.DropdownBtnMark)

	local y = self.DropdownBtnMark and 1 or 0

	self.TargetScale.transform.localScale = Vector3.New(1, y, 1)
end

function TapContent:ToggleSetItemIsOn()
	local toggle = self.toggleList[1]

	if toggle then
		toggle.group:SetAllTogglesOff()
	end

	for i = 1, self.tapCount do
		local toggle = self.toggleList[i]
		local targetGraphic = toggle.targetGraphic
		local graphic = toggle.graphic

		targetGraphic.gameObject:SetActive(true)
		graphic.gameObject:SetActive(false)
	end

	self.CurToogle = nil
end

function TapContent:ToggleSetOneItemIsOn(i)
	local toggle = self.toggleList[i]

	if toggle then
		toggle.group:SetAllTogglesOff()
	end

	local targetGraphic = toggle.targetGraphic
	local graphic = toggle.graphic

	targetGraphic.gameObject:SetActive(true)
	graphic.gameObject:SetActive(false)
end

function TapContent:ToggleEvent(name, InitDropdownMark)
	self.semblanceTable = {}
	self.CurChooseName = name

	if InitDropdownMark then
		self.InitDropdownMark = InitDropdownMark
	end

	local index = 0
	local _toggle

	for i = 1, self.tapCount do
		local toggle = self.toggleList[i]

		if toggle.name == name then
			_toggle = toggle
		elseif toggle.isOn then
			table.insert(self.semblanceTable, toggle.name)

			toggle.isOn = false
		end
	end

	if _toggle == nil then
		return
	end

	if _toggle.isOn == true then
		index = index + 1

		if index > 1 then
			return
		end

		self:ClickEvent()
	else
		_toggle.isOn = true
	end
end

function TapContent:ClickEvent()
	self.semblanceTable = {}

	for i = 1, self.tapCount do
		local toggle = self.toggleList[i]
		local targetGraphic = toggle.targetGraphic
		local graphic = toggle.graphic
		local isOn = toggle.isOn and toggle.gameObject.activeSelf == true

		if isOn then
			self.CurToogle = toggle
		end

		if targetGraphic then
			targetGraphic.gameObject:SetActive(not isOn)
		end

		if graphic then
			graphic.gameObject:SetActive(isOn)
		end

		if isOn and self.onToggleChange then
			self.onToggleChange(toggle.name, isOn, toggle)

			if self.DropdownBtn then
				self:UpdateDropdownTagName(toggle.name)
			end
		end
	end
end

function TapContent:UpdateDropdownTagName(toggle_name)
	for i, v in pairs(self.DropdownTagName) do
		if i == toggle_name then
			self.CurChooseDes.text = v

			break
		end
	end

	if self.InitDropdownMark then
		self.InitDropdownMark = false

		return
	end

	self:OnDropdownBtnClick()
end

function TapContent:SetEnabled(value)
	for i = 1, self.tapCount do
		self.toggleList[i].enabled = value
	end
end

function TapContent:UpdateItemText(textList)
	local length = math.min(#textList, self.tapCount)

	for i = 1, length do
		local label = self.toggleList[i].targetGraphic.transform:GetChild(0)
		local label1 = self.toggleList[i].graphic.transform:GetChild(0)

		if label then
			label.gameObject:GetComponent("Text").text = textList[i]
		end

		if label1 then
			label1.gameObject:GetComponent("Text").text = textList[i]
		end
	end
end

function TapContent:InitTagDes()
	return
end
