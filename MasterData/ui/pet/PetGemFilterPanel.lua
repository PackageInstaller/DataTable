-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemFilterPanel.lua

local strClassName = "PetGemFilterPanel"
local PetGemFilterPanel = Class(strClassName, UIControls.Panel)

function PetGemFilterPanel:ctor()
	self:initUI()
end

function PetGemFilterPanel:initUI()
	self.optionUI = {}

	for i = 1, 10 do
		local option = UIControls.Button(self, self.mPath .. "/PropertiesList/Option" .. i)

		option:addEventClick(Functor(self.onOptionClick, self, i))

		local checkmark = UIControls.Panel(self, self.mPath .. "/PropertiesList/Option" .. i .. "/Background/Checkmark")

		checkmark:setVisible(false)

		local text = UIControls.Label(self, self.mPath .. "/PropertiesList/Option" .. i .. "/Text")

		table.insert(self.optionUI, {
			option = option,
			checkmark = checkmark,
			text = text
		})
	end

	self.titleText = UIControls.Label(self, self.mPath .. "/TitleText")
	self.btnFilter = UIControls.Button(self, self.mPath .. "/BtnFilter")

	self.btnFilter:addEventClick(self.onBtnFilterClick)

	self.imgNone = UIControls.Panel(self, self.mPath .. "/ItemListScroll/ImgNone")
	self.itemListScroll = UIControls.ScrollViewLoopV(self, self.mPath .. "/ItemListScroll")

	self.itemListScroll:addEventCellChanged(self.onGemListChanged)

	self.cells = {}
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function PetGemFilterPanel:setData(level)
	self.curLevel = level
	self.filterList = {}
	self.optionSelectDic = {}
	self.subAttrList, self.subAttrNum = CurAvatar:getAllSubAttrListByLevel(level)

	for i, ui in ipairs(self.optionUI) do
		if self.subAttrList[i] then
			ui.option:setVisible(true)
			ui.checkmark:setVisible(false)
			ui.text:setText(self.subAttrList[i].type_desc)
		else
			ui.option:setVisible(false)
		end
	end

	self.imgNone:setVisible(#self.filterList == 0)
	self.itemListScroll:setTotalCount(#self.filterList)
	self.titleText:setText(string.format(Lang.get(101576), self.subAttrNum))
end

function PetGemFilterPanel:onGemListChanged(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.GridPetGemLoop(sender, "System/Pet/GridPetGem", newIdx)

	if not self.filterList or #self.filterList == 0 then
		return
	end

	if self.filterList[newIdx] ~= nil then
		targetCell:setObj(self.filterList[newIdx])
	end

	self.cells[newIdx] = targetCell
end

function PetGemFilterPanel:onOptionClick(index)
	if not self.optionSelectDic[index] then
		local selectNum = self:getSelectOptionNum()

		if selectNum >= self.subAttrNum then
			MsgManager.notice(Lang.get(101435))

			return
		end

		self.optionSelectDic[index] = true

		self.optionUI[index].checkmark:setVisible(true)
	else
		self.optionSelectDic[index] = false

		self.optionUI[index].checkmark:setVisible(false)
	end
end

function PetGemFilterPanel:getSelectOptionNum()
	local num = 0

	for i, v in pairs(self.optionSelectDic) do
		if v then
			num = num + 1
		end
	end

	return num
end

function PetGemFilterPanel:onBtnFilterClick()
	self.filterList = {}

	local canfilterList = self.mParent:getAllCanFilterGemList()

	for i, gem in pairs(canfilterList) do
		local subAttrs = gem:getSubAttr()

		if self:isInFilterRange(subAttrs) then
			table.insert(self.filterList, gem)
		end
	end

	if #self.filterList == 0 then
		MsgManager.notice(Lang.get(101436))
	end

	self.imgNone:setVisible(#self.filterList == 0)
	self.itemListScroll:setTotalCount(#self.filterList)
end

function PetGemFilterPanel:isInFilterRange(subAttrs)
	for i, v in pairs(self.subAttrList) do
		if self.optionSelectDic[i] then
			local isHave = false

			for _, subAttr in ipairs(subAttrs or {}) do
				if v.id == subAttr.attr_id then
					isHave = true
				end
			end

			if not isHave then
				return false
			end
		end
	end

	return true
end

function PetGemFilterPanel:onBtnConfirmClick()
	self.mParent:finishFilter(self.filterList)
end

return PetGemFilterPanel
