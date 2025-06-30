-- chunkname: @IQIGame\\UI\\FormationUI\\FormationSoulHeadCell.lua

local m = {}

function m.New(view, isNotMySoul)
	local obj = Clone(m)

	obj:Init(view, isNotMySoul)

	return obj
end

function m:Init(view, isNotMySoul)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.SoulHeadCell = SoulHeadCell.New(self.SoulHeadView)

	self.SoulHeadCell:SetMouseEnabled(false)
	self.SoulHeadCell:SetIsMine(not isNotMySoul)
	self:ShowTag(false)
end

function m:SetData(soulData)
	self.SoulData = soulData

	self.SoulHeadCell.goView:SetActive(soulData ~= nil)

	if soulData == nil then
		return
	end

	self.SoulHeadCell:RefreshView(soulData)
end

function m:SetSoulLv(lv)
	if self.SoulHeadCell and self.SoulHeadCell.goLevelText then
		UGUIUtil.SetText(self.SoulHeadCell.goLevelText, lv)
	end
end

function m:ShowTag(top, str)
	if self.Tag then
		self.Tag:SetActive(top)
	end

	if self.TagText and str then
		UGUIUtil.SetText(self.TagText, str)
	end
end

function m:Dispose()
	self.SoulHeadCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.SoulData = nil
end

return m
