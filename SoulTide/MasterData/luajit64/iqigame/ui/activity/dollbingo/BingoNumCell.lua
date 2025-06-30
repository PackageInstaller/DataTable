-- chunkname: @IQIGame\\UI\\Activity\\DollBingo\\BingoNumCell.lua

local BingoNumCell = {}

function BingoNumCell.New(view)
	local obj = Clone(BingoNumCell)

	obj:Init(view)

	return obj
end

function BingoNumCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.icon = self.goIcon:GetComponent("Image")
	self.INTERVAL_MAX = ActivityNewDollBingoUIApi:GetString("tenCellEffectIntervalMax")
	self.INTERVAL_MIN = ActivityNewDollBingoUIApi:GetString("tenCellEffectIntervalMin")
end

function BingoNumCell:Refresh(times, cfgNumData)
	self.cfgNumData = cfgNumData

	self.goNumRoot:SetActive(times ~= nil)

	if times ~= nil then
		self.goNumRoot.transform:Find("Text"):GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("numTimes", times)
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgNumData.IconImage), self.icon)
	self:StopEffectTimer()
end

function BingoNumCell:OnUpdate(elapse)
	if self.enableTimer then
		self.timer = self.timer + elapse

		if self.timer >= self.INTERVAL then
			self.timer = 0

			self:StopTenEffect()
			self:PlayTenEffect()
		end
	end
end

function BingoNumCell:OnHide()
	self:StopEffectTimer()
	self:StopCircleEffect()
	self:StopTimer()
end

function BingoNumCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BingoNumCell:StartEffectTimer()
	self.enableTimer = true
	self.timer = 0
	self.INTERVAL = math.random(self.INTERVAL_MIN, self.INTERVAL_MAX)
end

function BingoNumCell:StopEffectTimer()
	self.enableTimer = false

	self:StopTenEffect()
end

function BingoNumCell:PlayTenEffect()
	self:ClearChildEffect()

	self.INTERVAL = math.random(self.INTERVAL_MIN, self.INTERVAL_MAX)

	local effectID = 9001220 + math.random(1, 5)

	self.tenEffectEntityID = GameEntry.Effect:PlayUIMountPointEffect(effectID, 50000, 0, self.View, 0)
end

function BingoNumCell:StopTenEffect()
	if self.tenEffectEntityID ~= nil then
		GameEntry.Effect:StopEffect(self.tenEffectEntityID)

		self.tenEffectEntityID = nil
	end

	self:ClearChildEffect()
	self:StartTimer()
end

function BingoNumCell:PlayCircleEffect(effectID)
	self:StopCircleEffect()
	self:ClearChildEffect()

	self.circleEffectEntity = GameEntry.Effect:PlayUIMountPointEffect(effectID, 50000, 0, self.View, 0)
end

function BingoNumCell:StopCircleEffect()
	if self.circleEffectEntity ~= nil then
		GameEntry.Effect:StopEffect(self.circleEffectEntity)

		self.circleEffectEntity = nil
	end

	self:ClearChildEffect()
	self:StartTimer()
end

function BingoNumCell:StartTimer()
	self:StopTimer()

	self.timerClear = Timer.New(function()
		self.timerClear = nil

		self:OnTimer()
	end, 1)

	self.timerClear:Start()
end

function BingoNumCell:StopTimer()
	if self.timerClear ~= nil then
		self.timerClear:Stop()
	end
end

function BingoNumCell:OnTimer()
	self:ClearChildEffect()
end

function BingoNumCell:ClearChildEffect()
	local count = self.goEffect.transform.childCount

	for i = 0, count - 1 do
		local target = self.goEffect.transform:GetChild(i)

		target.localPosition = Vector3.New(100000, 0, 0)
	end
end

return BingoNumCell
