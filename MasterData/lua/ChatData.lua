--聊天数据
ChatData = {}
local this = ChatData

function this.New()
	this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins, this);	
	return ins;
end
--[[发送者id 头像id 名称 发送时间 消息类型 消息内容 文本提示表CfgTipsSimpleChinese的id 错误参数(map的sTipsInfo)
	uid		iconId name	sTime	type	content	 strId	args
	long	uint string	uint	byte	string	string	json
]]
function this:SetData(_data)
	self.data = _data.data
	self.isSelf = _data.isSelf
end

function this:GetData()
	return self.data
end

function this:GetIsSelf()
	return self.isSelf
end

function this:GetUid()
	return self.data and self.data.uid
end

function this:GetIconId()
	local iconID = 0
	if self.data then
		iconID = self.isSelf and PlayerClient:GetIconId() or self.data.iconId
	end
	return iconID
end

function this:GetName()
	return self.data and self.data.name
end

function this:GetContent()
	return self.data and self.data.content
end

function this:GetTimeStr()
	if(self.data) then
		local second = TimeUtil:GetTime() - self.data.sTime
		local minute = math.floor(second / 60)
		local hour = math.floor(second / 60 / 60)
		local day = math.floor(second / 60 / 60 / 24)
		
		local str = ""
		if day > 30 then
			str = "30天前"
		elseif day > 0 then
			str = day .. "天前"
		elseif hour > 0 then
			str = hour .. "小时前"
		elseif minute > 0 then
			str = minute .. "分钟前"
		end
		return str
	end
end

function this:Clear()
	self.data = {}
end 