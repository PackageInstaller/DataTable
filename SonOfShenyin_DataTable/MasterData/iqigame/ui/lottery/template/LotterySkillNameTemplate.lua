-- chunkname: @IQIGame\\UI\\Lottery\\Template\\LotterySkillNameTemplate.lua

local LotterySkillNameTemplate = {
	itemCid = 0
}

function LotterySkillNameTemplate.New(view)
	local obj = Clone(LotterySkillNameTemplate)

	obj:__Init(view)

	return obj
end

function LotterySkillNameTemplate:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.detailBtn.gameObject:SetActive(true)

	function self.__delegateOnDetailBtnClick()
		UIModule.Open(Constant.UIControllerName.DetailsPreviewUI, Constant.UILayer.UI, {
			type = Constant.ItemType.Skill,
			cid = CfgItemTable[self.itemCid].LikeId
		})
	end

	self.detailBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnDetailBtnClick)
end

function LotterySkillNameTemplate:Show(itemCid)
	self.itemCid = itemCid

	self.gameObject:SetActive(true)

	local itemCfg = CfgItemTable[itemCid]
	local skillCfg = CfgSkillTable[itemCfg.LikeId]

	self.nameText:GetComponent("Text").text = skillCfg.Name

	self:__RefreshStarNum(skillCfg.Quality)
end

function LotterySkillNameTemplate:__RefreshStarNum(starNum)
	for i = 0, self.starRoot.transform.childCount - 1 do
		self.starRoot.transform:GetChild(i).gameObject:SetActive(i < starNum)
	end
end

function LotterySkillNameTemplate:Hide()
	self.gameObject:SetActive(false)
end

function LotterySkillNameTemplate:Dispose()
	self.detailBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnDetailBtnClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return LotterySkillNameTemplate
