-- chunkname: @IQIGame\\UI\\RoleDevelopment\\SkillUpgradeItemView.lua

local SkillUpgradeItemView = {}

function SkillUpgradeItemView.New(go, mainView)
	local o = Clone(SkillUpgradeItemView)

	o:Initialize(go, mainView)

	return o
end

function SkillUpgradeItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SkillUpgradeItemView:InitComponent()
	return
end

function SkillUpgradeItemView:InitDelegate()
	return
end

function SkillUpgradeItemView:AddListener()
	return
end

function SkillUpgradeItemView:RemoveListener()
	return
end

function SkillUpgradeItemView:Refresh(Data)
	self.Data = Data

	local itemCell = ItemCell.New(self.item)

	itemCell:SetItem(self.Data)

	local hasNum = WarehouseModule.GetItemNumByCfgID(self.Data.cid)
	local needNum = self.Data.num
	local hasNumText = ""

	if hasNum < needNum then
		hasNumText = "<color=#FF0000>" .. tostring(hasNum) .. "</color>"
	else
		hasNumText = tostring(hasNum)
	end

	LuaUtility.SetText(self.textCount, string.format("%s/%s", hasNumText, tostring(needNum)))
end

function SkillUpgradeItemView:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

return SkillUpgradeItemView
