-- chunkname: @IQIGame\\Scene\\DualTeamExplore\\Path\\DualTeamExploreRefPool.lua

local m = {
	Size = 10,
	Pool = {}
}

function m.New(size, createFunc, disposeFunc)
	local pool = Clone(m)

	pool.Size = size
	pool.CreateFunc = createFunc
	pool.DisposeFunc = disposeFunc

	return pool
end

function m:Obtain()
	local obj

	if #self.Pool > 0 then
		obj = table.remove(self.Pool, 1)
	else
		obj = self.CreateFunc()
	end

	return obj
end

function m:Release(obj)
	if #self.Pool < self.Size then
		table.insert(self.Pool, obj)
	elseif self.DisposeFunc ~= nil then
		self.DisposeFunc(obj)
	end
end

function m:Clear()
	if #self.Pool > 0 then
		for i = #self.Pool, 1, -1 do
			local obj = self.Pool[i]

			table.remove(self.Pool, i)

			if self.DisposeFunc ~= nil then
				self.DisposeFunc(obj)
			end
		end
	end
end

function m:Dispose()
	self:Clear()

	self.CreateFunc = nil
	self.DisposeFunc = nil
end

return m
