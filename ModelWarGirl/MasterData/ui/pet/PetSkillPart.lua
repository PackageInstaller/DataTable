-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetSkillPart.lua

local ResSkillConfig = require("ClientData/ResSkillConfig")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local ResPetAmulet = require("ClientData/ResPetAmulet")
local ResPetMisc = require("ClientData/ResPetMisc")
local strClassName = "PetSkillPart"
local PetSkillPart = Class(strClassName, UIControls.Panel)

function PetSkillPart:ctor()
	self:initUI()
end

function PetSkillPart:initUI()
	self.skillPanel = {}

	for i = 1, 2 do
		local btnSkill = UIControls.Button(self, self.mPath .. "/Skill0" .. i)

		btnSkill:addEventClick(Functor(self.onSkillClick, self, i))

		local itemNode = UIControls.Panel(self, self.mPath .. "/Skill0" .. i .. "/ItemNode")
		local textTitle = UIControls.Label(self, self.mPath .. "/Skill0" .. i .. "/TextTitle")
		local textInfo

		if UIControls.checkControlFunc(self, self.mPath .. "/Skill0" .. i .. "/ScrollRect/Content/TextInfo") then
			textInfo = UIControls.Label(self, self.mPath .. "/Skill0" .. i .. "/ScrollRect/Content/TextInfo")
		else
			textInfo = UIControls.Label(self, self.mPath .. "/Skill0" .. i .. "/TextInfo")
		end

		local iconNew = UIControls.Image(self, self.mPath .. "/Skill0" .. i .. "/IconNew")
		local textEnNum, textEnSpeedNum

		if UIControls.checkControlFunc(self, self.mPath .. "/Skill0" .. i .. "/TextEnNum") then
			textEnNum = UIControls.Label(self, self.mPath .. "/Skill0" .. i .. "/TextEnNum")
			textEnSpeedNum = UIControls.Label(self, self.mPath .. "/Skill0" .. i .. "/TextEnNum2")
		end

		table.insert(self.skillPanel, {
			btnSkill = btnSkill,
			itemNode = itemNode,
			textTitle = textTitle,
			textInfo = textInfo,
			iconNew = iconNew,
			textEnSpeedNum = textEnSpeedNum,
			textEnNum = textEnNum
		})
	end

	self.skillCells = {}
end

function PetSkillPart:setSkill(pet, wearAmuletStarUpRed)
	self.pet = pet
	self.wearAmuletStarUpRed = wearAmuletStarUpRed

	local mainAmulet, assistAmulet = self.pet:getBattleFightAmulet()

	mainAmulet.battleSkillId = mainAmulet.mainSkill
	mainAmulet.pos = 1

	if mainAmulet.id == ResPetMisc[1].default_amulet_id then
		mainAmulet.isDefault = true
	end

	if assistAmulet then
		assistAmulet.battleSkillId = assistAmulet.assistantSkill
		assistAmulet.pos = 2
	end

	self.skillList = {
		mainAmulet,
		assistAmulet
	}

	for i = 1, 2 do
		if self.skillList[i] then
			local resTable = i == 1 and ResSkillConfig or ResPassiveSkill
			local descStr = i == 1 and "skill_desc" or "desc"
			local skillData = resTable[self.skillList[i].battleSkillId][self.skillList[i].star]

			self.skillPanel[i].textTitle:setText(skillData.name or "")
			self.skillPanel[i].textInfo:setText(skillData[descStr] or "")

			if self.skillPanel[i].textEnNum and self.skillPanel[i].textEnSpeedNum then
				self.skillPanel[i].textEnNum:setText(self.skillList[i].initMana or 0)
				self.skillPanel[i].textEnSpeedNum:setText(string.format(Lang.get(73228), self.skillList[i].manaGen))
			end

			self.skillPanel[i].textTitle:setVisible(true)
			self.skillPanel[i].textInfo:setVisible(true)

			if not self.skillList[i].isDefault then
				local cell = self.skillCells[i]

				if not self.skillCells[i] then
					cell = UIControls.GridPetSkillChild(self, self.mPath .. "/Skill0" .. i .. "/ItemNode", "System/Pet/GridPetSkill", 0, 0, true)
				end

				cell:setObj(self.skillList[i])

				cell.mEventClick = Slot(self.onGridClick, self)
				self.skillCells[i] = cell

				self.skillPanel[i].iconNew:setVisible(self.skillList[i]:checkCanStarUp() and self.wearAmuletStarUpRed)
			else
				if self.skillCells[i] then
					self.skillCells[i]:destroy()

					self.skillCells[i] = nil
				end

				self.skillPanel[i].iconNew:setVisible(self.pet:checkCanWearAmuletByPos(i))
			end
		else
			if self.skillCells[i] then
				self.skillCells[i]:destroy()

				self.skillCells[i] = nil
			end

			self.skillPanel[i].textTitle:setVisible(false)
			self.skillPanel[i].textInfo:setVisible(false)
			self.skillPanel[i].iconNew:setVisible(self.pet:checkCanWearAmuletByPos(i))
		end
	end
end

function PetSkillPart:setGridClickEnable(v)
	for i, cell in ipairs(self.skillCells or {}) do
		cell:setGridClickEnable(v)
	end
end

function PetSkillPart:setSkillGridCallBack(gridClickCallBack)
	self.gridClickCallBack = gridClickCallBack
end

function PetSkillPart:setEmptySkillCallBack(emptySkillCallBack)
	self.emptySkillCallBack = emptySkillCallBack
end

function PetSkillPart:onGridClick(sender)
	if self.gridClickCallBack then
		self.gridClickCallBack(sender)
	end
end

function PetSkillPart:onSkillClick(index)
	if self.emptySkillCallBack then
		self.emptySkillCallBack(index)
	end
end

return PetSkillPart
