-- chunkname: @IQIGame\\Module\\Sound\\SoundPackageData.lua

local m = {
	BGM = 0,
	Environments = {}
}

function m.New(bgm, environments)
	local obj = Clone(m)

	obj:Init(bgm, environments)

	return obj
end

function m:Init(bgm, environments)
	self.BGM = bgm
	self.Environments = environments
end

SoundPackageData = m
