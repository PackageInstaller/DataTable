-- chunkname: @IQIGame\\UI\\Lottery\\Template\\LotteryRoleNameTemplate.lua

local LotteryRoleNameTemplate = {
	roleCid = 0
}

function LotteryRoleNameTemplate.New(view)
	local obj = Clone(LotteryRoleNameTemplate)

	obj:__Init(view)

	return obj
end

function LotteryRoleNameTemplate:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.detailBtn.gameObject:SetActive(true)

	function self.__delegateOnDetailBtnClick()
		UIModule.Open(Constant.UIControllerName.DetailsPreviewUI, Constant.UILayer.UI, {
			type = Constant.ItemType.Hero,
			cid = self.roleCid
		})
	end

	self.detailBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnDetailBtnClick)
end

function LotteryRoleNameTemplate:Show(roleCid)
	self.roleCid = roleCid

	self.gameObject:SetActive(true)

	local heroCfg = CfgHeroTable[roleCid]

	self:__RefreshStarNum(heroCfg.Quality)

	self.nameText:GetComponent("Text").text = heroCfg.Name

	local elementIconPath = UIGlobalApi.GetImagePath(heroCfg.ElementsIcon)

	AssetUtil.LoadImage(self, elementIconPath, self.elementImg:GetComponent("Image"))

	local professionIconPath = UIGlobalApi.GetImagePath(heroCfg.ProfessionIcon)

	AssetUtil.LoadImage(self, professionIconPath, self.professionImg:GetComponent("Image"))
end

function LotteryRoleNameTemplate:__RefreshStarNum(starNum)
	for i = 0, self.starRoot.transform.childCount - 1 do
		self.starRoot.transform:GetChild(i).gameObject:SetActive(i < starNum)
	end
end

function LotteryRoleNameTemplate:Hide()
	self.gameObject:SetActive(false)
end

function LotteryRoleNameTemplate:Dispose()
	self.detailBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnDetailBtnClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return LotteryRoleNameTemplate
