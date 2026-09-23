--注音工具
local this = {}

this.isInit = false
this.words = nil

function this:SetText(textGo, str)
	--check
	if(textGo == nil) then
		return
	end
	if(StringUtil:IsEmpty(str) or not ComUtil.GetCom(textGo, "ZYText")) then
		CSAPI.SetText(textGo, "")
		return
	end
	--word
	if(not this.isInit) then
		this.isInit = true
		this.words = {}
		local all = Cfgs.CfgZuYing:GetAll()
		for i, v in ipairs(all) do
			local _len = self:GetLen(v.word)
			this.words[v.word] = {zy = v.zy, len = _len}
		end
	end
	for i, v in pairs(this.words) do
		str = string.gsub(str, i, i .. "<quad name=" .. v.zy .. " size=" .. v.len .. " width=0 />")
	end
	CSAPI.SetText(textGo, str)
end

function this:GetFormatText(str)
	--word
	if(not this.isInit) then
		this.isInit = true
		this.words = {}
		local all = Cfgs.CfgZuYing:GetAll()
		for i, v in ipairs(all) do
			local _len = self:GetLen(v.word)
			this.words[v.word] = {zy = v.zy, len = _len}
		end
	end
	for i, v in pairs(this.words) do
		str = string.gsub(str, i, i .. "<quad name=" .. v.zy .. " size=" .. v.len .. " width=0 />")
	end
	return str;
end


function this:GetLen(str, len)
	len = len == nil and 2 or len
	if not str or type(str) ~= "string" or #str <= 0 then
		return 0
	end
	local length = 0
	local i = 1
	while(true) do
		local curByte = string.byte(str, i)
		local byteCount = 1
		if(curByte > 239) then
			byteCount = 4
		elseif(curByte > 223) then
			byteCount = 3
		elseif(curByte > 128) then
			byteCount = 2
		else
			byteCount = 1
		end
		length = length + byteCount
		i = i + byteCount
		if i > #str then
			break
		end
	end
	local s = string.format("%0.2f", length / 3)
	return tonumber(s)
end


return this 