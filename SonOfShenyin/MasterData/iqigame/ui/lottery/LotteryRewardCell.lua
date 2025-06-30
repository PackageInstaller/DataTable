-- chunkname: @IQIGame\\UI\\Lottery\\LotteryRewardCell.lua

local m = {}

function m.PackageOrReuseView(ui, cellGo)
	if ui == nil or cellGo == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LotteryRewardCell == nil then
		ui.__SUB_UI_MAP_LotteryRewardCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LotteryRewardCell
	local itemCell

	if subUIMap[cellGo:GetInstanceID()] == nil then
		itemCell = m.__New(cellGo)
		subUIMap[cellGo:GetInstanceID()] = itemCell
	else
		itemCell = subUIMap[cellGo:GetInstanceID()]
	end

	return itemCell
end

function m.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LotteryRewardCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LotteryRewardCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LotteryRewardCell = nil
end

function m.__New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUI, false)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(rewardType, data)
	self.HeroParent:SetActive(rewardType == Constant.ItemType.Hero)
	self.SkillParent:SetActive(rewardType == Constant.ItemType.Skill)

	local itemdata

	if rewardType == Constant.ItemType.Hero then
		local heroCid = tonumber(CfgItemTable[data.ItemId].ActionParams[1])

		UGUIUtil.SetText(self.HeroName, CfgHeroTable[heroCid].Name)

		local heroResourcesShowImgPath = SkinModule.GetHeroDefaultSkinImgPath(heroCid, Constant.SkinImageType.HeroResourcesShowImg)

		self:LoadImg(heroResourcesShowImgPath, self.HeroImg)

		local cfgItem = CfgUtil.GetItemCfgDataWithID(data.ItemId)
		local heroID = cfgItem.LikeId
		local cfgHero = CfgUtil.GetCfgHeroDataWithID(heroID)

		LuaUtility.LoadImage(self, string.format(CfgUtil.GetCfgResourceUrl(Constant.Resource.RoleElement), cfgHero.Elements), self.HeroElementImg:GetComponent("Image"), function()
			LuaUtility.SetImageNativeSizeWithGameObject(self.HeroElementImg)
		end)
	elseif rewardType == Constant.ItemType.Skill then
		UGUIUtil.SetText(self.SkillName, CfgItemTable[data.ItemId].Name)

		itemdata = ItemData.CreateByCIDAndNumber(data.ItemId, 0)

		self.ItemCell:SetItem(itemdata)
	end
end

function m:LoadImg(path, imgObj)
	AssetUtil.LoadImage(self, path, imgObj:GetComponent("Image"))
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
