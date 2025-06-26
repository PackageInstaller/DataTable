-- chunkname: @IQIGame\\Scene\\Dreamland\\DreamlandNodeSubViewController.lua

local m = {
	IsActive = false,
	NumGos = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	if self.NumNode ~= nil then
		local num = 0

		for i = 1, 6 do
			local trans = self.NumNode.transform:Find("Num" .. i)

			if trans ~= nil then
				self.NumGos[i] = trans.gameObject
				num = num + 1
			end
		end

		if num ~= 6 then
			logError("格子数字名称错误，必须是Num?，?为数字且数字前不带0")
		end
	end

	self.IsActive = self.View.activeSelf
end

function m:SetActive(value)
	self.IsActive = value

	self.View:SetActive(value)
end

function m:SetData(isOpen, aroundNum)
	self.HideView:SetActive(not isOpen)
	self.ShowView:SetActive(isOpen)

	if isOpen then
		for i = 1, 6 do
			local numGo = self.NumGos[i]

			if numGo ~= nil then
				numGo:SetActive(i == aroundNum)
			end
		end
	end
end

function m:Dispose()
	for i = 1, 6 do
		self.NumGos[i] = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
