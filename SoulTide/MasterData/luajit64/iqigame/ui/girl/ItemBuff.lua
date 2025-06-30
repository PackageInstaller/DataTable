-- chunkname: @IQIGame\\UI\\Girl\\ItemBuff.lua

local ItemBuff = {
	buffEndTime = 0
}

function ItemBuff.__New(ui, itemID, buffID, percent)
	local o = Clone(ItemBuff)

	o:InitView(ui, itemID, buffID, percent)

	return o
end

function ItemBuff:InitView(ui, itemID, buffID, percent)
	self.goView = ui
	self.itemID = itemID
	self.buffID = buffID
	self.percent = percent
	self.buffEndTime = self:GetBuffEndTime()

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.textCd = self.TextTime:GetComponent("Text")
	self.btnUse = self.BtnUes:GetComponent("Button")

	function self.delegateBtnUse()
		self:OnBtnUse()
	end

	self.textCd.text = ""
	self.timerCD = Timer.New(function()
		self:ChangeBuffCd()
	end, 1, -1)

	self.timerCD:Start()
	self:AddEventListener()
end

function ItemBuff:AddEventListener()
	self.btnUse.onClick:AddListener(self.delegateBtnUse)
end

function ItemBuff:RemoveEventListener()
	self.btnUse.onClick:RemoveListener(self.delegateBtnUse)
end

function ItemBuff:GetBuffEndTime()
	for i, v in pairs(PlayerModule.PlayerInfo.globalBuffs) do
		if v.cid == self.buffID then
			return v.endTime
		end
	end

	return 0
end

function ItemBuff:ChangeBuffCd()
	if self.textCd ~= nil then
		local cd = self.buffEndTime - PlayerModule.GetServerTime()

		if cd > 0 then
			self.textCd.text = self:GetFormatTime(cd) .. ""
		else
			self.textCd.text = ""
		end
	end
end

function ItemBuff:GetFormatTime(second)
	local timeText = ""
	local h = math.floor(second / 3600)

	h = h < 10 and "0" .. h or tostring(h)

	local m = math.floor(second % 3600 / 60)

	m = m < 10 and "0" .. m or tostring(m)

	local s = math.floor(second % 60)

	s = s < 10 and "0" .. s or tostring(s)
	timeText = string.format("%s:%s:%s", h, m, s)

	return timeText
end

function ItemBuff:OnBtnUse()
	if WarehouseModule.GetItemNumByCfgID(self.itemID) <= 0 then
		NoticeModule.ShowNotice(21043002)

		return
	end

	local itemData = WarehouseModule.GetItemDataByCfgID(self.itemID)

	if itemData == nil then
		NoticeModule.ShowNotice(21043003)

		return
	end

	ItemModule.UseItem(itemData, 1)
end

function ItemBuff:UpDateView()
	if self.itemID ~= nil then
		self.buffEndTime = self:GetBuffEndTime()

		local itemObj = self.Slot.transform:GetChild(0).gameObject
		local itemCell = ItemCell.PackageOrReuseView(self, itemObj)

		itemCell:SetItemByCID(self.itemID)

		local num = WarehouseModule.GetItemNumByCfgID(self.itemID)

		itemCell:SetNum(num)
	end
end

function ItemBuff:Dispose()
	self:RemoveEventListener()

	self.callBackCloseFun = nil

	if self.timerCD ~= nil then
		self.timerCD:Stop()
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return ItemBuff
