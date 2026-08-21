-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\CommentInfo.lua

local CommentInfo = {}

function CommentInfo.CommentData(info, data)
	if info and data then
		info.id = data.id
		info.uid = data.uid
		info.name = data.name
		info.entry_id = data.entry_id
		info.content = data.content
		info.favor_num = data.favor_num
		info.status = data.status
		info.createTime = data.created
		info.updateTime = data.updated
		info.is_favor = data.is_favor
	end
end

function CommentInfo.RateData(info, data)
	if info and data then
		info.id = data.id
		info.type = data.type
		info.rate = data.rate
		info.rate_count = data.rate_count
		info.score_sum = data.score_sum
		info.created = data.Created
		info.updated = data.Updated
	end
end

return CommentInfo
