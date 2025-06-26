-- chunkname: @IQIGame\\Common\\CachePool.lua

local CachePool = {}

function CachePool.New()
	local o = Clone(CachePool)

	o:Initialize()

	return o
end

function CachePool:Initialize()
	self.ObjectList = {}
end

function CachePool:GetObject(path)
	local list = self.ObjectList[path]

	if not list then
		return
	end

	if not list[1] then
		return
	end

	local o = list[1]

	table.remove(list, 1)

	return o
end

function CachePool:BackPool(path, obj)
	if not self.ObjectList[path] then
		self.ObjectList[path] = {}
	end

	table.insert(self.ObjectList[path], obj)
end

function CachePool:ClearPool()
	for _, list in pairs(self.ObjectList) do
		for i = #list, 1, -1 do
			if list[i].gameObject then
				GameObject.Destroy(list[i].gameObject)
			end

			list[i] = nil

			table.remove(list, i)
		end
	end

	self.ObjectList = {}
end

return CachePool
