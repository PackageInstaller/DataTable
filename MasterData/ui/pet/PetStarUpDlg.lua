-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetStarUpDlg.lua

local ResPetStar = require("ClientData/ResPetStar")
local ResPet = require("ClientData/ResPet")
local strClassName = "PetStarUpDlg"
local PetStarUpDlg = Class(strClassName, UIControls.Window)
local ResPetPossessAttr = require("ClientData/ResPetPossessAttr")
local ATTR_DIC = {
	{
		floor = true,
		attrStr = "mhp",
		name = Lang.get(964)
	},
	{
		floor = true,
		attrStr = "atk",
		name = Lang.get(578)
	},
	{
		percent = true,
		attrStr = "cri_rate",
		name = Lang.get(12013)
	},
	{
		percent = true,
		attrStr = "cri_dmg",
		name = Lang.get(12010)
	}
}

function PetStarUpDlg:ctor()
	self:initUI()
end

function PetStarUpDlg:initUI()
	self.starGroup = {}

	for i = 1, 5 do
		local star = UIControls.Panel(self, "BgPanel/StartGroup/Start0" .. i)
		local checkmark = UIControls.Image(self, "BgPanel/StartGroup/Start0" .. i .. "/Background/Checkmark")

		table.insert(self.starGroup, {
			star = star,
			checkmark = checkmark
		})
	end

	self.attrsPanel = {}

	for i = 1, 4 do
		local textName = UIControls.Label(self, "BgPanel/InfoPanel/AttrPanel" .. i .. "/TextName")
		local textNumOld = UIControls.Label(self, "BgPanel/InfoPanel/AttrPanel" .. i .. "/TextNum1")
		local textNumNew = UIControls.Label(self, "BgPanel/InfoPanel/AttrPanel" .. i .. "/TextNum2")

		table.insert(self.attrsPanel, {
			textName = textName,
			textNumOld = textNumOld,
			textNumNew = textNumNew
		})
	end

	self.unLockNode1 = UIControls.Panel(self, "BgPanel/InfoPanel/UnLockNode/TextNum1")
	self.unLockNode2 = UIControls.Panel(self, "BgPanel/InfoPanel/UnLockNode/TextNum2")
	self.unLockNode3 = UIControls.Panel(self, "BgPanel/InfoPanel/UnLockNode/TextNum3")
	self.unLockNode4 = UIControls.Panel(self, "BgPanel/InfoPanel/UnLockNode/TextNum4")
	self.imgPetRole = UIControls.PetRole(self, "BgPanel/ImgPetPortrait")
	self.imgPetRole2 = UIControls.PetRole(self, "BgPanel/ImgPetPortrait02")
	self.rootAni = UIControls.UIAni(self, "")

	self.rootAni:addEventFinish(self._onAniFinish)

	self.itemPanel = UIControls.Panel(self, "BgPanel/InfoPanel/ItemPanel")
	self.grids = {}
end

function PetStarUpDlg:setData(petId, star)
	self.star = star

	for i, v in ipairs(self.starGroup) do
		self.starGroup[i].checkmark:setVisible(i <= star - 1)
	end

	local newPet = CurAvatar.petDic[petId]

	newPet:becomePropsContainer()

	local oldPet = BaseObject.CopyObject(newPet)

	oldPet.star = newPet.star - 1

	oldPet:becomePropsContainer()

	for i = 1, #ATTR_DIC do
		local name = ATTR_DIC[i].name

		self.attrsPanel[i].textName:setText(name)

		local oldValue = oldPet[ATTR_DIC[i].attrStr] or 0
		local newValue = newPet[ATTR_DIC[i].attrStr] or 0

		if ATTR_DIC[i].percent then
			oldValue = tostring(oldValue * 100) .. "%"
			newValue = tostring(newValue * 100) .. "%"
		end

		if ATTR_DIC[i].floor then
			oldValue = math.floor(oldValue)
			newValue = math.floor(newValue)
		end

		self.attrsPanel[i].textNumOld:setText(oldValue)
		self.attrsPanel[i].textNumNew:setText(newValue)
	end

	local changeStarTable = newPet:getModelChangeStar()

	self.unLockNode1:setVisible(utils.tableIsContainsElement(changeStarTable, newPet.star))
	self.unLockNode2:setVisible(self:isNewUnlockGemNum(newPet))
	self.unLockNode3:setVisible(self:isIntelligenceLimitChange(newPet))
	self.unLockNode4:setVisible(self:isGiftLimitChange(newPet))
	self.imgPetRole:showRole(newPet.id)
	self.imgPetRole2:showRole(newPet.id)
	self.imgPetRole2:changeMaterial(UIConst.PET_PORTRAIT_02_GET_NEW_MATERIAL)

	local rewardId

	if self.star == 1 then
		if ResPet[petId].starup_reward1 then
			rewardId = ResPet[petId].starup_reward1
		end
	elseif self.star == 3 then
		if ResPet[petId].starup_reward3 then
			rewardId = ResPet[petId].starup_reward3
		end
	elseif self.star == 5 and ResPet[petId].starup_reward5 then
		rewardId = ResPet[petId].starup_reward5
	end

	if rewardId ~= nil then
		self.itemPanel:setVisible(true)
		ClientUtils.CreateBonusGrid(self, self.grids, "BgPanel/InfoPanel/ItemPanel/ItemNode", rewardId, true, nil, true)
	else
		self.itemPanel:setVisible(false)
	end
end

function PetStarUpDlg:isNewUnlockGemNum(pet)
	if pet.star - 1 > 0 then
		return ResPetStar[pet.star - 1].gem_num < ResPetStar[pet.star].gem_num
	end
end

function PetStarUpDlg:isIntelligenceLimitChange(pet)
	if not CurAvatar:checkPetPossessEnterOpen() then
		return false
	end

	if pet.star - 1 > 0 then
		local config = ResPetPossessAttr[pet.quality][1]

		return config.intelligence_limit[pet.star - 1] < config.intelligence_limit[pet.star]
	end

	return false
end

function PetStarUpDlg:isGiftLimitChange(pet)
	if not CurAvatar:checkPetPossessEnterOpen() then
		return false
	end

	if pet.star - 1 > 0 then
		return ResPetStar[pet.star - 1].gifted_limit < ResPetStar[pet.star].gifted_limit
	end

	return false
end

function PetStarUpDlg:_onAniFinish(aniCom, aniName)
	if aniName == "InPetLevelUpCanvas" then
		for i, v in ipairs(self.starGroup) do
			self.starGroup[i].checkmark:setVisible(i <= self.star)
		end
	end
end

return PetStarUpDlg
