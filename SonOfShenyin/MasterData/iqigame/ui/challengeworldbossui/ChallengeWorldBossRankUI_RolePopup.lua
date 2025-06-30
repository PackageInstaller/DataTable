-- chunkname: @IQIGame\\UI\\ChallengeWorldBossUI\\ChallengeWorldBossRankUI_RolePopup.lua

local Json = require("Util.json")
local RoleItemCell = {}

function RoleItemCell.New(view)
	local obj = Clone(RoleItemCell)

	obj:__Init(view)

	return obj
end

function RoleItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function RoleItemCell:Show(jsonData)
	self.gameObject:SetActive(true)

	local roleCid = TryToNumber(jsonData.val, 0)
	local skinCid = TryToNumber(jsonData.iconSkin, 0)
	local level = TryToNumber(jsonData.heroLv, 0)
	local heroCfg = CfgHeroTable[roleCid]
	local headIconPath = ""

	if skinCid == 0 then
		headIconPath = SkinModule.GetHeroDefaultSkinImgPath(roleCid, Constant.SkinImageType.HeroResourcesHead)
	else
		headIconPath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, Constant.SkinImageType.HeroResourcesHead)
	end

	AssetUtil.LoadImage(self, headIconPath, self.RoleImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(heroCfg.ElementsIcon), self.elementImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(heroCfg.ProfessionIcon), self.Profession:GetComponent("Image"))

	self.RoleLevel:GetComponent("Text").text = UIGlobalApi.GetLevelText(level)

	self.StarRoot:GetComponent("SimpleStarComponent"):UpdateView(heroCfg.Quality, 0)
end

function RoleItemCell:Hide()
	self.gameObject:SetActive(false)
end

function RoleItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local RolePopup = {
	roleItemList = {}
}

function RolePopup.New(view)
	local obj = Clone(RolePopup)

	obj:__Init(view)

	return obj
end

function RolePopup:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	ForTransformChild(self.RoleItemRoot.transform, function(_trans, _index)
		local roleCell = RoleItemCell.New(_trans.gameObject)

		table.insert(self.roleItemList, roleCell)
	end)
	UIEventUtil.AddClickEventListener_Button(self, "closeButton", self.__OnCloseBtnClickHandler)
end

function RolePopup:Show(podData)
	self.gameObject:SetActive(true)

	self.RoleNameText:GetComponent("Text").text = podData.name

	if TryToNumber(podData.headIcon, 0) == 0 then
		self.HeadIcon.gameObject:SetActive(false)
	else
		self.HeadIcon.gameObject:SetActive(true)

		local skinCid = SkinModule.GetSkinCidByHeroSkinPOD(podData.heroSkin)
		local path = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, Constant.SkinImageType.HeroResourcesHead)

		AssetUtil.LoadImage(self, path, self.HeadIcon:GetComponent("Image"))

		local userDataList = Json.decode(podData.userData)
		local index = 0

		ForPairs(userDataList, function(_, _table)
			index = index + 1

			self.roleItemList[index]:Show(_table)
		end)
		ForArrayByCount(index + 1, #self.roleItemList, 1, function(k)
			self.roleItemList[k]:Hide()
		end)
	end
end

function RolePopup:Hide()
	self.gameObject:SetActive(false)
end

function RolePopup:__OnCloseBtnClickHandler()
	self:Hide()
end

function RolePopup:Dispose()
	ForPairs(self.roleItemList, function(k, _cell)
		_cell:Dispose()
	end)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return RolePopup
