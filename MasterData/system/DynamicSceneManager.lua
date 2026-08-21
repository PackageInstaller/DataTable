-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\DynamicSceneManager.lua

local DynamicSceneUtil = DynamicScene.DynamicSceneUtil
local DynamicSceneManager = {}
local self = DynamicSceneManager

function DynamicSceneManager.initDynamicSceneManager(...)
	self.refCountMap = {}
end

function DynamicSceneManager.clear()
	for path, count in pairs(self.refCountMap) do
		if count > 0 then
			-- block empty
		end
	end

	self.refCountMap = {}
end

function DynamicSceneManager.load(path)
	if not self.refCountMap[path] then
		self._loadScene(path)

		self.refCountMap[path] = 1
	else
		self.refCountMap[path] = self.refCountMap[path] + 1
	end
end

function DynamicSceneManager.unload(path)
	local nowCount = self.refCountMap[path]

	if nowCount then
		self.refCountMap[path] = nowCount - 1

		if self.refCountMap[path] <= 0 then
			self._unloadScene(path)

			self.refCountMap[path] = nil
		end
	end
end

function DynamicSceneManager._loadScene(path)
	DynamicSceneUtil.LoadScene(path)
end

function DynamicSceneManager._unloadScene(path)
	DynamicSceneUtil.UnloadScene(path)
end

return DynamicSceneManager
