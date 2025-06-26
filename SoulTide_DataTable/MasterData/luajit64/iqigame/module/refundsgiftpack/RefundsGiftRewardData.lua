-- chunkname: @IQIGame\\Module\\RefundsGiftPack\\RefundsGiftRewardData.lua

local m = {}

function m.New(itemCid, showNum)
	local obj = Clone(m)

	obj.itemCid = itemCid
	obj.showNum = showNum

	return obj
end

return m
