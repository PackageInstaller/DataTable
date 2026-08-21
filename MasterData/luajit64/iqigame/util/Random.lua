-- chunkname: @IQIGame\\Util\\Random.lua

local m = {
	c = 0,
	a = 16807,
	m = 2147483647
}

function m.New(seed)
	local obj = Clone(m)

	obj:Constructor(seed)

	return obj
end

function m:Constructor(seed)
	if seed == nil then
		seed = os.time()
	end

	self.seed = seed
end

function m:next()
	self.seed = (self.a * self.seed + self.c) % self.m

	return self.seed
end

function m:nextInt(bound)
	if bound == nil then
		return self:next()
	else
		local r = self:next()
		local u = r

		r = u % bound

		while u - r + bound - 1 < 0 do
			u = self:next()
			r = u % bound
		end

		return r
	end
end

function m:Bound(num)
	return self:nextInt(num)
end

function m:Range(min, max)
	return self:nextInt(max - min) + min
end

Random = m
