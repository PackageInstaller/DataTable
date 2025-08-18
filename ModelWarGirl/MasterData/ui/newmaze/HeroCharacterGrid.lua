-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\HeroCharacterGrid.lua

local HeroCharacterGrid = Class("HeroCharacterGrid", UIControls.Child)

function HeroCharacterGrid:ctor(...)
	self:initUI()
end

function HeroCharacterGrid:initUI(...)
	self.bg = UIControls.Image(self, "Bg")
	self.icon = UIControls.Image(self, "Icon")
	self.imgDis = UIControls.Image(self, "ImgDis")
	self.imgType = UIControls.Image(self, "ImgType")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onGridClick)
end

function HeroCharacterGrid:setData(data, isInMainDlg, index)
	self.data = data
	self.index = index
	self.isInMainDlg = isInMainDlg

	if self.data.icon_path then
		self.icon:setImage(data.icon_path, data.icon_name)
	end

	if data.type == 1 then
		self.imgType:setImage("Atlas/RogueAtlas/RougeMainAtlas", "TxtIconRouge01")
	else
		self.imgType:setImage("Atlas/RogueAtlas/RougeMainAtlas", "TxtIconRouge02")
	end

	if self.isInMainDlg then
		if self.index == 1 then
			self.bg:setImage("Atlas/RogueAtlas/RougeMainAtlas", "BtnSkillNml01")
			self.imgDis:setImage("Atlas/RogueAtlas/RougeMainAtlas", "BtnSkillSel01")
		else
			self.bg:setImage("Atlas/RogueAtlas/RougeMainAtlas", "BtnSkillNml02")
			self.imgDis:setImage("Atlas/RogueAtlas/RougeMainAtlas", "BtnSkillSel02")
		end
	end
end

function HeroCharacterGrid:onGridClick(sender)
	if self.openTipsClick then
		self:openTipsClick(self)
	end
end

return HeroCharacterGrid
