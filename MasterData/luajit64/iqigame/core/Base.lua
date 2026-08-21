-- chunkname: @IQIGame\\Core\\Base.lua

Base = {
	__cname = "Base",
	__ctype = ClassType.Base
}

function Base:Extend(p1, p2, p3)
	local cls

	cls = Clone(self)

	if p1 then
		cls.__cname = p1
	end

	if p2 then
		if type(p2) == "string" then
			cls.__ctype = p2
		else
			for k, v in pairs(p2) do
				cls[k] = v
			end
		end
	end

	if p3 then
		for k, v in pairs(p3) do
			cls[k] = v
		end
	end

	cls.__index = cls

	setmetatable(cls, getmetatable(self))

	if cls.__childInit and type(cls.__childInit) == "function" then
		cls:__childInit()
	end

	return cls
end

function Base:New()
	return Clone(self)
end

function Base:GetClassType()
	return self.__ctype
end

function Base:GetClassName()
	return self.__cname
end
