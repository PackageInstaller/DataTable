-- chunkname: @IQIGame\\UI\\RoleDevelopment\\ItemCell\\DiySelectSkillItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.New(self.CommonSlotUI, false)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(itemData)
	self.itemData = itemData

	self.itemCell:SetItem(self.itemData, 0)
	self.itemCell:SetItemLv(self.itemData.skillData.lv)

	local isEquip = self.itemData.skillData.heroCid ~= 0

	self.Lock:SetActive(self.itemData.skillData.lock)
	self.TagHero:SetActive(isEquip)

	if isEquip then
		AssetUtil.LoadImage(self, SkinModule.GetHeroCurrentSkinImgPath(self.itemData.skillData.heroCid, Constant.SkinImageType.HeadIcon), self.TagHero:GetComponent("Image"))
	end
end

function m:Selected()
	self.SelectState:SetActive(true)
end

function m:UnSelected()
	self.SelectState:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
