-- chunkname: @IQIGame\\Module\\Friend\\FriendData.lua

local FriendData = {
	id = 0,
	serverId = "",
	vip = 0,
	type = 0,
	online = false,
	headIcon = 0,
	avatarFrame = 0,
	lastLoginTime = 0,
	guid = 0,
	title = 0,
	remark = "",
	pLv = 0,
	pName = "",
	createTime = 0,
	pId = 0
}

function FriendData.New(friendPOD)
	local obj = Clone(FriendData)

	obj:Update(friendPOD)

	return obj
end

function FriendData:Update(friendPOD)
	for k, v in pairs(friendPOD) do
		self[k] = v
	end
end

return FriendData
