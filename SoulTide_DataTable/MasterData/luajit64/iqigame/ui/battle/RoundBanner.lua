-- chunkname: @IQIGame\\UI\\Battle\\RoundBanner.lua

local m = {}
local RoundBannerModeController = require("IQIGame.UI.Battle.RoundBannerModeController")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.RoundMode = RoundBannerModeController.New(self.RoundMode1)
end

function m:Play()
	self.View:SetActive(true)
	self.RoundMode:Play()
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
