-- chunkname: @IQIGame\\UI\\Equip\\EquipSuitTipsCell.lua

local EquipSuitTipsCell = {
	isChoose = false,
	isLock = false
}

function EquipSuitTipsCell.New(go)
	local o = Clone(EquipSuitTipsCell)

	o:Initialize(go)

	return o
end

function EquipSuitTipsCell:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
end

local gray90 = Color.New(0.5647058823529412, 0.5647058823529412, 0.5647058823529412, 1)
local gray97 = Color.New(0.592156862745098, 0.592156862745098, 0.592156862745098, 1)

function EquipSuitTipsCell:Refresh(name)
	UGUIUtil.SetText(self.Name, name)
end

function EquipSuitTipsCell:RefreshChoose(isChoose)
	if isChoose then
		UGUIUtil.SetColor(self.Name:GetComponent("Text"), gray90)
	else
		UGUIUtil.SetColor(self.Name:GetComponent("Text"), gray97)
	end
end

function EquipSuitTipsCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return EquipSuitTipsCell
