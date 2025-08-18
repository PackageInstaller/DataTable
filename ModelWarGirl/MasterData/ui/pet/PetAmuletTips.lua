-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetAmuletTips.lua

local PetAmuletSkillInfoPart = require("UI/Pet/PetAmuletSkillInfoPart")
local strClassName = "PetAmuletTips"
local PetAmuletTips = Class(strClassName, UIControls.Tips)

function PetAmuletTips:ctor(prefabPath, order, needShow)
	self:initUI()
end

function PetAmuletTips:initUI()
	self:initFuncBtn(3)

	self.petInfoNone = UIControls.Panel(self, "BgPanel/PetInfoNone")
	self.petName = UIControls.Label(self, "BgPanel/PetInfo/PetName")
	self.amuletSkillInfoPart = PetAmuletSkillInfoPart(self, "BgPanel/BgR/SkillList")
	self.iconStarRedNew = UIControls.Image(self, "BgPanel/Func/BtnFunc3/IconNew")
	self.petSkillName = UIControls.Label(self, "BgPanel/BgR/PetSkillName")
	self.amuletImg = UIControls.Image(self, "BgPanel/BgR/PetSkiilItem")
	self.starGroup = {}

	for i = 1, 5 do
		local star = UIControls.Panel(self, "BgPanel/BgR/StartGroup/Start0" .. i)
		local checkmark = UIControls.Image(self, "BgPanel/BgR/StartGroup/Start0" .. i .. "/Background/Checkmark")

		table.insert(self.starGroup, {
			star = star,
			checkmark = checkmark
		})
	end

	self.func = UIControls.Panel(self, "BgPanel/Func")
end

function PetAmuletTips:_setObj(grid, params)
	self.grid = grid
	self.amulet = grid.object
	self.pet = nil

	if params and params.pet then
		self.pet = params.pet
	elseif self.amulet.inWearing then
		self.pet = CurAvatar.petDic[self.amulet.inWearing]
	end

	local checkPet = self.pet ~= nil

	self.petInfoNone:setVisible(not checkPet)

	if checkPet then
		self.gridPet = UIControls.ItemGridChild(self, "BgPanel/PetInfo", "System/Common/Grid/GridMaterialItem", 0, 0, true)

		self.gridPet:setObj(self.pet)
		self.gridPet.btnSensor:setEnable(false)
		self.petName:setText(self.pet.name)
	end

	for i, v in ipairs(self.starGroup) do
		self.starGroup[i].checkmark:setVisible(i <= self.amulet.star)
		self.starGroup[i].star:setVisible(i <= self.amulet.maxStar)
	end

	self.petSkillName:setText(self.amulet.name)

	local iconPath = self.amulet:getIconPath()

	if iconPath and iconPath[1] and iconPath[2] then
		self.amuletImg:setImage(iconPath[1], iconPath[2])
	end

	self.amuletSkillInfoPart:setData(self.amulet)
	self.iconStarRedNew:setVisible(self.amulet:checkCanStarUp())
end

function PetAmuletTips:setFuncVisible(v)
	self.func:setVisible(v)
end

return PetAmuletTips
