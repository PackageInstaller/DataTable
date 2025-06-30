-- chunkname: @IQIGame\\Scene\\MemoryStory\\MemoryStoryBackgroundParallax.lua

local m = {
	backgrounds = {},
	parallaxScale = Vector2.New(1, 1),
	parallaxDecreasingCoefficient = Vector2.New(0.05, 0),
	scrollerSmoothing = Vector2.New(0.1, 0.1),
	lastCameraPosition = Vector3.New(0, 0, 0)
}

function m.New(backgroundRoot)
	local obj = Clone(m)

	obj:__Init(backgroundRoot)

	return obj
end

function m:__Init(backgroundRoot)
	self.backgroundRoot = backgroundRoot

	LuaCodeInterface.BindOutlet(self.backgroundRoot, self)
	log(self.topLayer)
	log(self.midLayer)
	log(self.bottomLayer)
	table.insert(self.backgrounds, self.midLayer.transform)
	table.insert(self.backgrounds, self.bottomLayer.transform)

	self.lastCameraPosition = MemoryStoryModule.MainCamera.gameObject.transform.localPosition
end

function m:OnUpdate()
	local cameraPosition = MemoryStoryModule.MainCamera.gameObject.transform.localPosition
	local parallax_x, parallax_y = self:__CalcParallax(cameraPosition.x, cameraPosition.y)

	for i = 1, #self.backgrounds do
		local transPosition = self.backgrounds[i].localPosition
		local posX = transPosition.x + parallax_x * (i * self.parallaxDecreasingCoefficient.x)
		local posY = transPosition.y + parallax_y * (i * self.parallaxDecreasingCoefficient.y)

		self.backgrounds[i].localPosition = Vector3.New(posX, posY, transPosition.z)
	end

	self.lastCameraPosition = cameraPosition
end

function m:__CalcParallax(x, y)
	local parallaxX = (self.lastCameraPosition.x - x) / self.parallaxScale.x
	local parallaxY = (self.lastCameraPosition.y - y) / self.parallaxScale.y

	return parallaxX, parallaxY
end

function m:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.backgroundRoot, self)
end

return m
