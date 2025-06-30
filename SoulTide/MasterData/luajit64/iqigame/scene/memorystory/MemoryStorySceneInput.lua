-- chunkname: @IQIGame\\Scene\\MemoryStory\\MemoryStorySceneInput.lua

local m = {}

m = extend(InputManager, m)

function m.New()
	local obj = Clone(m)

	obj:__Init()

	return obj
end

function m:__Init()
	self:Init()
end

function m:OnTap(mouseX, mouseY)
	local wordPoint = MemoryStoryModule.MainCamera:ScreenToWorldPoint(Vector2(mouseX, mouseY))
	local hits = LuaCodeInterface.RaycastAll(wordPoint, Vector2.zero)

	for i = 0, hits.Length - 1 do
		local hit = hits[i]
		local insId = hit.transform.parent.parent.gameObject:GetInstanceID()

		if self.OnElementClickEvent ~= nil then
			self.OnElementClickEvent(insId)
		end
	end
end

function m:OnDispose()
	self.OnElementClickEvent = nil

	self:Dispose()
end

return m
