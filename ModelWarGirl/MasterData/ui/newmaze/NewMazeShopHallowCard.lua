-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeShopHallowCard.lua

local ResNewMazeRelic = require("ClientData/ResNewMazeRelic")
local strClassName = "NewMazeShopHallowCard"
local NewMazeShopHallowCard = Class(strClassName, UIControls.Child)
local LayoutElementType = typeof(UnityEngine.UI.LayoutElement)

function NewMazeShopHallowCard:ctor()
	self:initUI()
end

function NewMazeShopHallowCard:initUI()
	self.iconHead = UIControls.Image(self, "BgTextDec/BgFigure/MaskHead/IconHead")
	self.bgFigure = UIControls.Panel(self, "BgTextDec/BgFigure")
	self.textBuff = UIControls.Label(self, "BgTextDec/TextBuff")
	self.textTitle = UIControls.Label(self, "BgTextTitle/TextTitle")
	self.icon = UIControls.Image(self, "Icon")
	self.bg = UIControls.Image(self, "Bg")
	self.bgTextDec = UIControls.Image(self, "BgTextDec")
	self.btnReduce = UIControls.Button(self, "BgTextDec/BtnReduce")

	self.btnReduce:addEventClick(self.onBtnReduceClick)

	self.btnExtend = UIControls.Button(self, "BgTextDec/BtnExtend")

	self.btnExtend:addEventClick(self.onBtnExtendClick)

	self.comDescLayout = self.bgTextDec:getComObj():GetComponent(LayoutElementType)
	self.panelCondition = UIControls.Panel(self, "BgCondition")
	self.imgConditions = {}

	for i = 1, 3 do
		local imgCondition = UIControls.Image(self, "BgCondition/Condition" .. i)

		table.insert(self.imgConditions, imgCondition)
	end
end

function NewMazeShopHallowCard:setData(itemId, upHeroId)
	self.hallowId = itemId
	self.hallowData = ResNewMazeRelic[self.hallowId]

	if self.hallowData then
		self.textTitle:setText(self.hallowData.name)
		self.textBuff:setText(self.hallowData.description)

		if self.hallowData.icon_path then
			self.icon:setImage(self.hallowData.icon_path, self.hallowData.icon_name)
		end

		if self.hallowData.hero_exclusive_id and self.mWindow.newMazeData and self.mWindow.newMazeData.heroId == self.hallowData.hero_exclusive_id then
			self.bgFigure:setVisible(true)

			local fakeHero = BaseObject.GetObject(self.hallowData.hero_exclusive_id)
			local iconPath = fakeHero:getQIconPath()

			if iconPath then
				self.iconHead:setImage(iconPath[1], iconPath[2])
			end
		else
			self.bgFigure:setVisible(false)
		end

		local iconBgNameList = {
			"BgHallowCardBlue",
			"BgHallowCardYellow",
			"BgHallowCardPink"
		}

		self.bg:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder", iconBgNameList[self.hallowData.rarity])

		local iconBgTextList = {
			"BgCardBlueBottom",
			"BgCardYellowBottom",
			"BgCardPinkBottom"
		}

		self.bgTextDec:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder01", iconBgTextList[self.hallowData.rarity])

		if self.textBuff:getHeight() > 120 then
			self.btnExtend:setVisible(true)
			self.btnReduce:setVisible(false)
		else
			self.btnExtend:setVisible(false)
			self.btnReduce:setVisible(false)
		end

		if self.hallowData.condition_icon_path and self.hallowData.condition_icon_name then
			self.panelCondition:setVisible(true)

			local names = utils.splitString(self.hallowData.condition_icon_name, ",")

			if names then
				local idx = 0

				for _, name in ipairs(names) do
					idx = idx + 1

					self.imgConditions[idx]:setImage(self.hallowData.condition_icon_path, name)
					self.imgConditions[idx]:setVisible(true)
				end

				for i = idx + 1, #self.imgConditions do
					self.imgConditions[i]:setVisible(false)
				end
			end
		else
			self.panelCondition:setVisible(false)
		end
	end
end

function NewMazeShopHallowCard:onBtnExtendClick()
	self.btnExtend:setVisible(false)
	self.btnReduce:setVisible(true)

	self.comDescLayout.enabled = false
end

function NewMazeShopHallowCard:onBtnReduceClick()
	self.btnExtend:setVisible(true)
	self.btnReduce:setVisible(false)

	self.comDescLayout.enabled = true
	self.comDescLayout.preferredHeight = 128
end

return NewMazeShopHallowCard
