-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Controller\\HorizontalRPGRollingCtrl.lua

local m = {
	StartY = 0,
	RightStartPosX = 0,
	LimitMinY = 0,
	StartMove = false,
	Layer = 0,
	MaxDisY = 3,
	BgSpeed = 1,
	TargetY = 0,
	LeftStartPosX = 0
}

function m.New(view, layer)
	local obj = Clone(m)

	obj:Init(view, layer)

	return obj
end

function m:Init(view, layer)
	self.View = view
	self.Layer = layer

	LuaCodeInterface.BindOutlet(self.View, self)

	self.LeftStartPosX = self.Left.transform.localPosition.x
	self.RightStartPosX = self.Right.transform.localPosition.x
	self.StartY = self.View.transform.localPosition.y
	self.LimitMinY = self.StartY - self.MaxDisY

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:FrameUpdate()
	if self.StartMove then
		self.Left.transform:Translate(Vector3.New(self.BgSpeed * UnityEngine.Time.deltaTime, 0, 0))
		self.Right.transform:Translate(Vector3.New(self.BgSpeed * UnityEngine.Time.deltaTime, 0, 0))

		if self.BgSpeed < 0 and self.Left.transform.localPosition.x < -self.RightStartPosX then
			self.Left.transform.localPosition = Vector3.New(self.LeftStartPosX, 0, 0)
			self.Right.transform.localPosition = Vector3.New(self.RightStartPosX, 0, 0)
		end

		if self.BgSpeed > 0 and self.Left.transform.localPosition.x > self.LeftStartPosX then
			local des = self.RightStartPosX - self.LeftStartPosX

			self.Left.transform.localPosition = Vector3.New(self.LeftStartPosX - des, 0, 0)
			self.Right.transform.localPosition = Vector3.New(self.RightStartPosX - des, 0, 0)
		end
	end

	local localPos = self.View.transform.localPosition
	local endPos = Vector3.New(localPos.x, self.StartY - self.TargetY, localPos.z)

	self.View.transform.localPosition = Vector3.Lerp(localPos, endPos, 0.1)
end

function m:RefreshWeather(isDay)
	local leftDay = self.Left.transform:Find("day")
	local leftNight = self.Left.transform:Find("night")
	local rightDay = self.Right.transform:Find("day")
	local rightNight = self.Right.transform:Find("night")

	if leftDay then
		leftDay.gameObject:SetActive(isDay)
	end

	if leftNight then
		leftNight.gameObject:SetActive(not isDay)
	end

	if rightDay then
		rightDay.gameObject:SetActive(isDay)
	end

	if rightNight then
		rightNight.gameObject:SetActive(not isDay)
	end
end

function m:SetSpeed(data)
	self.BgSpeed = data
	self.StartMove = data ~= 0
end

function m:SetPosY(proportion)
	self.TargetY = proportion * self.MaxDisY

	if self.TargetY < self.LimitMinY then
		self.TargetY = self.LimitMinY
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
