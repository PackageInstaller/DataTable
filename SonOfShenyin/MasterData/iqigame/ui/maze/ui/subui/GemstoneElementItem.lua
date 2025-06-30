-- chunkname: @IQIGame\\UI\\Maze\\UI\\SubUI\\GemstoneElementItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.bgImageCom = self.bg:GetComponent("Image")

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(type, value)
	AssetUtil.LoadImage(self, MazeApi:GetGemElementBG(type), self.bgImageCom, function()
		return
	end)
	UGUIUtil.SetText(self.Num, string.format(MazeApi:GetTypeTextColor(type), value))
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	self.bgImageCom = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
