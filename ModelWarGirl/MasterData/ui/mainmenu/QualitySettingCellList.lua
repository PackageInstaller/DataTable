-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\QualitySettingCellList.lua

local strClassName = "QualitySettingCellList"
local QualitySettingCellList = Class(strClassName, UIControls.Child)

function QualitySettingCellList:ctor(...)
	self:initUI()
end

function QualitySettingCellList:initUI(...)
	self.nameTxt = UIControls.Label(self, "TextTitle")
	self.toggleList = {}

	for i = 1, 4 do
		local toggle = UIControls.Toggle(self, "Option" .. i, "Text")

		toggle.index = i

		toggle:addEventValueChanged(self._onToggleChanged)
		table.insert(self.toggleList, toggle)
	end
end

function QualitySettingCellList:setListSetting(name, callback, elemCount, elemNames)
	self.nameTxt:setText(name or "")

	self.changeCallback = callback
	self.maxElemCount = elemCount

	for i = 1, 4 do
		self.toggleList[i]:setVisible(i <= elemCount)

		if elemNames[i] then
			self.toggleList[i]:setText(elemNames[i])
		end
	end
end

function QualitySettingCellList:selectList(index)
	self.curSelectIndex = index

	self:_refreshToggles()
end

function QualitySettingCellList:_onToggleChanged(sender, isOn)
	if isOn then
		local selectIndex = sender.index

		if self.curSelectIndex == selectIndex then
			return
		end

		self.curSelectIndex = selectIndex

		self:_refreshToggles()

		if self.changeCallback then
			self.changeCallback(selectIndex)
		end
	end
end

function QualitySettingCellList:_refreshToggles()
	for i = 1, self.maxElemCount do
		local toggle = self.toggleList[i]

		toggle:setOnVoidUnChange(self.curSelectIndex == toggle.index)
		toggle:setEnable(self.curSelectIndex ~= toggle.index)
	end
end

return QualitySettingCellList
