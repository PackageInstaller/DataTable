-- chunkname: @IQIGame\\UI\\Maze\\IllusionMazeEmotionBubble.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(overloadParamId, overloadNum)
	local path = IllusionMazeMainUIApi:GetString("EmotionBubblePath", overloadParamId, overloadNum)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
