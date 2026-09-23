--邮件管理
local MailInfo = require "MailInfo"
local this = MgrRegister("MailMgr")

-----------------------------------------------协议发------------------------
function this:Init()
	self.datas = {}
	self:GetMailsData()
end

function this:Clear()
	self.datas = {}
end

function this:GetArr()
	self.arr = {}	
	if(self.datas) then
		for i, v in pairs(self.datas) do
			if(not v:IsEnd()) then
				table.insert(self.arr, v)
			end
		end
		table.sort(self.arr, function(a, b)
			if(a:GetIsGet() == b:GetIsGet()) then
				if a.start_time == b.start_time then
					return a:GetID() > b:GetID()
				else
					return a.start_time > b.start_time
				end
			else
				return a:GetIsGet() < b:GetIsGet()
			end
		end)
	end
	return self.arr
end

function this:GetData(id)
	return self.datas and self.datas[id] or nil
end

--请求所有邮件
function this:GetMailsData()
	local proto = {"MailProto:GetMailsData"}
	NetMgr.net:Send(proto)
end

function this:CanGetIDs()
	local ids = {}
	local arr = self:GetArr()
	if(arr and #arr > 0) then
		for i, v in ipairs(arr) do
			if(v:GetIsGet() == MailGetType.No and v:GetRewards() and #v:GetRewards() > 0) then
				table.insert(ids, v:GetID())
			end
		end
	end
	return ids
end

function this:GetDeleteIDs()
	local ids = {}
	local arr = self:GetArr()
	if(arr and #arr > 0) then
		for i, v in ipairs(arr) do
			--LogError(v:GetRewards())
			if not v:GetRewards() or #v:GetRewards() < 1 then
				if(v:GetIsRead() == MailReadType.Yes) then
					table.insert(ids, v:GetID())
				end
			else
				if(v:GetIsGet() == MailGetType.Yes) then			
					table.insert(ids, v:GetID())
				end
			end						
		end
	end
	return ids
end

--邮件操作 1：读取 2：领取 3：删除
function this:MailOperate(_ids, _operate_type)
	local proto = {"MailProto:MailsOperate", {ids = _ids, operate_type = _operate_type}}
	NetMgr.net:Send(proto)
end

--未读的数量
function this:GetNotReadCount()
	local count = 0
	local arr = self:GetArr()
	if(arr and #arr > 0) then
		for i = 1, #arr do
			if(arr[i]:GetIsRead() == MailGetType.No) then
				count = count + 1
			end
		end
	end
	return count
end

--检查红点数据
function this:CheckRedPointData()
	local ids = {}
	local arr = self:GetArr()
	if(arr and #arr > 0) then
		for i, v in ipairs(arr) do
			if v:GetIsRead() == MailReadType.No then
				table.insert(ids, v:GetID())
			elseif v:GetIsGet() == MailGetType.No and v:GetRewards() and #v:GetRewards() > 0 then
				table.insert(ids, v:GetID())
			end
		end
	end
	RedPointMgr:UpdateData(RedPointType.Mail, #ids > 0 and #ids or nil)
end

-----------------------------------------------协议收------------------------
--请求所有邮件
function this:GetMailsDataRet(proto)
	if(proto and #proto.mails > 0) then
		self.datas = {}
		for i, v in ipairs(proto.mails) do
			local mail = MailInfo.New()
			mail:InitData(v.data)
			self.datas[v.id] = mail
		end
	end
	self:CheckRedPointData()
end

--邮件操作 1：读取 2：领取 3：删除
function this:MailsOperateRet(proto)
	if(proto and #proto.ids > 0) then
		if(proto.operate_type == MailOperateType.Read) then
			self:Read(proto.ids)	
		elseif(proto.operate_type == MailOperateType.Get) then
			self:Get(proto.ids)
			--奖励面板
-- local rewards = {}
-- for i, id in ipairs(proto.ids) do
-- 	local mail = MailMgr:GetData(id)
-- 	local rs = mail and mail:GetRewards() or nil
-- 	if(rs and #rs > 0) then
-- 		for n, m in ipairs(rs) do
-- 			table.insert(rewards, m)
-- 		end
-- 	end
-- end
-- if(#rewards > 0) then
-- 	UIUtil:OpenReward({rewards})
-- end
		elseif(proto.operate_type == MailOperateType.Delete) then
			self:Delete(proto.ids)
		end
		EventMgr.Dispatch(EventType.Mail_Operate, proto)
	end
	self:CheckRedPointData()
end

function this:Read(ids)
	for i, v in ipairs(ids) do
		if(self.datas[v]) then
			self.datas[v]:SetIsRead(2)
		end
	end
end

function this:Get(ids)
	for i, v in ipairs(ids) do
		if(self.datas[v] and #self.datas[v].rewards > 0) then
			self.datas[v]:SetIsRead(2)
			self.datas[v]:SetIsGet(2)
		end
	end
end

function this:Delete(ids)
	for i, v in ipairs(ids) do
		if(self.datas[v]) then
			self.datas[v] = nil
		end
	end
end

function this:MailAddNotice(proto)
	if(proto and #proto.adds > 0) then
		self.datas = self.datas or {}
		for i, v in ipairs(proto.adds) do
			local mail = MailInfo.New()
			mail:InitData(v)
			self.datas[v.id] = mail
		end
		EventMgr.Dispatch(EventType.Mail_AddNotice)
	end
	self:CheckRedPointData()
end

function this:GetMailStr(v)
	local str = ""
	local item=nil
	if v.type == TipAargType.OnlyParm then
		str = v.param .. ""
	elseif v.type == TipAargType.EmptyParm then
		str = ""
	elseif v.type == TipAargType.ItemId then
		item=BagMgr:GetFakeData(tonumber(v.param));
		str = item and item:GetName() or ""
	elseif v.type == TipAargType.CardId then
		item=RoleMgr:GetFakeData(tonumber(v.param));
		str=item and item:GetName() or "";	
	elseif v.type == TipAargType.EquipId then
		str = ""
	elseif v.type == TipAargType.DupId then
		item=Cfgs.MainLine:GetByID(tonumber(v.param));
		str=item and item.name or ""	
	elseif v.type == TipAargType.Role then
		item=Cfgs.CfgCardRole:GetByID(v.param);
		str=item and item.sAliasName or ""	
	elseif v.type == TipAargType.SectionId then
		item =Cfgs.Section:GetByID(tonumber(v.param))
		str=item and item.name or ""	
	else    --不对的参数类型
		LogError("不支持的参数类型:"..tostring(data.type));	
	end
	return str
end

return this 