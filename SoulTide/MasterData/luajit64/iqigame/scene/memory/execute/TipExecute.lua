-- chunkname: @IQIGame\\Scene\\Memory\\Execute\\TipExecute.lua

local TipExecute = {
	INTERVAL = 3
}

function TipExecute.New(element)
	local obj = Clone(TipExecute)

	obj:Init(element)

	return obj
end

function TipExecute:Init(element)
	self.tfTip = element.goTip:GetComponent("Text")
	self.timer = Timer.New(function()
		self:OnTimer()
	end, self.INTERVAL, 1)
end

function TipExecute:Execute(args)
	self.content = args[1]

	self:StopTimer()
	self:StartTimer()
end

function TipExecute:OnDestroy()
	self:StopTimer()

	self.timer = nil
end

function TipExecute:StartTimer()
	self.tfTip.text = MemorySceneMainUIApi:GetString("tip", self.content)

	self:SetTipVisible(true)
	self.timer:Stop()
	self.timer:Reset(function()
		self:OnTimer()
	end, self.INTERVAL, 1)
	self.timer:Start()
end

function TipExecute:StopTimer()
	self:SetTipVisible(false)
	self.timer:Stop()
end

function TipExecute:OnTimer()
	self:StopTimer()
end

function TipExecute:SetTipVisible(vs)
	self.tfTip.transform.parent.gameObject:SetActive(vs)
end

return TipExecute
