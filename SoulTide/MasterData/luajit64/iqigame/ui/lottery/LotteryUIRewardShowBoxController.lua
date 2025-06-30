-- chunkname: @IQIGame\\UI\\Lottery\\LotteryUIRewardShowBoxController.lua

local m = {
	Opened = false,
	BoxShowEffectPlayId = 0,
	OpenBoxEffectPlayId = 0,
	BoxEffectPlayId = 0,
	Order = 0,
	TailEffectPlayId = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	function self.DelegateOnEffectShow(sender, args)
		self:OnEffectShow(sender, args)
	end

	self.TailEffectNode = self.View.transform:Find("Walker").gameObject
	self.BoxEffectNode = self.View.transform:Find("Box").gameObject
end

function m:SetOrder(order)
	self.Order = order + 3
end

function m:SetData(cfgItemData)
	self.CfgItemData = cfgItemData
end

function m:PlayEffect(cfgItemData)
	self.CfgItemData = cfgItemData

	self.TailEffectNode:SetActive(true)
	self.BoxEffectNode:SetActive(true)

	if self.CfgItemData.Quality < 1 or self.CfgItemData.Quality > 5 then
		logError("PlayEffect 道具 " .. self.CfgItemData.Id .. " 的Quality " .. self.CfgItemData.Quality .. " 不在 1-5 范围内。")

		return
	end

	local itemLotteryType = 3
	local isSoulItem, soulCid = ItemModule.IsSoulItem(self.CfgItemData)

	if isSoulItem then
		itemLotteryType = 1
	elseif self.CfgItemData.Type == Constant.ItemType.Equip then
		itemLotteryType = 2
	end

	self.TailEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(LotteryUIApi:GetString("TailEffect", self.CfgItemData.Quality, itemLotteryType), 50000, 0, self.TailEffectNode, self.Order)

	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.LotteryUI, function()
		self.BoxShowEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(LotteryUIApi:GetString("OpenBoxEffect", self.CfgItemData.Quality, itemLotteryType), 50000, 0, self.BoxEffectNode, self.Order + 1)
		self.BoxEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(LotteryUIApi:GetString("BoxEffect", self.CfgItemData.Quality, itemLotteryType), 50000, 0, self.BoxEffectNode, self.Order)
	end, Constant.Lottery.UIBoxFlyDuration - 0.1)

	timer:Start()

	timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.LotteryUI, function()
		if self.TailEffectPlayId ~= 0 then
			GameEntry.Effect:StopEffect(self.TailEffectPlayId)

			self.TailEffectPlayId = 0
		end
	end, Constant.Lottery.UIBoxFlyDuration + 0.2)

	timer:Start()
end

function m:Clear()
	self.Opened = false
	self.CfgItemData = nil

	self.TailEffectNode:SetActive(false)
	self.BoxEffectNode:SetActive(false)

	if self.TailEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.TailEffectPlayId)

		self.TailEffectPlayId = 0
	end

	if self.BoxEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.BoxEffectPlayId)

		self.BoxEffectPlayId = 0
	end

	if self.BoxShowEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.BoxShowEffectPlayId)

		self.BoxShowEffectPlayId = 0
	end

	if self.OpenBoxEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.OpenBoxEffectPlayId)

		self.OpenBoxEffectPlayId = 0
	end

	GameEntry.LuaEvent:Unsubscribe(EffectShowEventArgs.EventId, self.DelegateOnEffectShow)
end

function m:Open(onOpenEffectShowCallback)
	if self.CfgItemData == nil then
		return
	end

	self.OnOpenEffectShowCallback = onOpenEffectShowCallback
	self.Opened = true

	self.TailEffectNode:SetActive(false)

	if self.BoxEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.BoxEffectPlayId)

		self.BoxEffectPlayId = 0
	end

	if self.CfgItemData.Quality < 1 or self.CfgItemData.Quality > 5 then
		logError("Open 道具 " .. self.CfgItemData.Id .. " 的Quality " .. self.CfgItemData.Quality .. " 不在 1-5 范围内。")

		return
	end

	if self.OpenBoxEffectPlayId == 0 then
		GameEntry.LuaEvent:Subscribe(EffectShowEventArgs.EventId, self.DelegateOnEffectShow)

		local itemLotteryType = 3
		local isSoulItem, soulCid = ItemModule.IsSoulItem(self.CfgItemData)

		if isSoulItem then
			itemLotteryType = 1
		elseif self.CfgItemData.Type == Constant.ItemType.Equip then
			itemLotteryType = 2
		end

		self.OpenBoxEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(LotteryUIApi:GetString("OpenBoxEffect", self.CfgItemData.Quality, itemLotteryType), 50000, 0, self.BoxEffectNode, self.Order + 1)
	end

	GameEntry.Sound:PlaySound(10206, Constant.SoundGroup.UI)
end

function m:OnEffectShow(sender, args)
	if args.EffectPlayID == self.OpenBoxEffectPlayId then
		GameEntry.LuaEvent:Unsubscribe(EffectShowEventArgs.EventId, self.DelegateOnEffectShow)

		if self.OnOpenEffectShowCallback ~= nil then
			self.OnOpenEffectShowCallback()

			self.OnOpenEffectShowCallback = nil
		end
	end
end

function m:IsOpened()
	return self.CfgItemData ~= nil and self.Opened
end

function m:Dispose()
	self:Clear()

	self.TailEffectNode = nil
	self.BoxEffectNode = nil
	self.View = nil
end

return m
