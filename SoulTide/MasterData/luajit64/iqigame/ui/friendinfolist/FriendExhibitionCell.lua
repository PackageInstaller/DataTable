-- chunkname: @IQIGame\\UI\\FriendInfoList\\FriendExhibitionCell.lua

local m = {}

function m.New(view, pos)
	local obj = Clone(m)

	obj:Init(view, pos)

	return obj
end

function m:Init(view, pos)
	self.View = view
	self.pos = pos

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.New(self.CommonSlot)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(cfgID)
	self.setCfgID = cfgID

	if cfgID ~= nil and cfgID > 0 then
		self.Empty:SetActive(false)
		self.Full:SetActive(true)
		self.itemCell:SetItemByCID(self.setCfgID, 1)
	else
		self.Empty:SetActive(true)
		self.Full:SetActive(false)
	end
end

function m:Dispose()
	self:RemoveListener()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
