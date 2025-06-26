-- chunkname: @IQIGame\\Module\\Friend\\HelpHeroData.lua

local HelpHeroData = {
	pid = 0,
	serverId = 0,
	pname = "",
	lv = 0,
	cid = 0,
	skill = {}
}

function HelpHeroData.New(HelpHeroPOD)
	local obj = Clone(HelpHeroData)

	obj:Update(HelpHeroPOD)

	return obj
end

function HelpHeroData:Update(HelpHeroPOD)
	for k, v in pairs(HelpHeroPOD) do
		self[k] = v
	end
end

return HelpHeroData
