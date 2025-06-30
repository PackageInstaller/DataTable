-- chunkname: @IQIGame\\Scene\\Survival\\SurvivalFlyGameSceneBG.lua

local m = {
	bgSpeed = 0.1
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.bgRender = self.ImgBG:GetComponent(typeof(UnityEngine.MeshRenderer))

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetSpeed(speed)
	self.bgSpeed = speed
end

function m:FrameUpdate()
	self.bgRender.material.mainTextureOffset = self.bgRender.material.mainTextureOffset + Vector2(self.bgSpeed * UnityEngine.Time.deltaTime, 0)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
