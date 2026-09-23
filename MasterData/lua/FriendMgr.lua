
local this = MgrRegister("FriendMgr")
FriendIxType = {
	Assist = 0, --协战
	FriendList = 1, --好友列表（除了搜索以外）
	FriendSreach = 2 --好友搜索
}

function this:Init()
	self.datas = {}
	self.recommends = {}
	self.talkInfos = {}
	self.had_del_cnt = 0
	self.had_apply_cnt = 0
	self:GetFriendsData()
	--self:InitAssistData();
    --服务器压力大，不要在登录的时候发送
	--self:GetRecomend()
end

function this:Clear()
	self.datas = {}
	self.recommends = {}
	self.talkInfos = {}
	self:ClearAssistData(true);
end

--获取聊天数据
function this:GetTalks(uid)
	if(not self.talkInfos[uid]) then
		local oldData = FileUtil.LoadByPath(uid .. "friend.txt")  --获取数据
		self.talkInfos[uid] = oldData or {}
	end
	--仅保留50条数据
	if(#self.talkInfos[uid] > 50) then
		table.remove(self.talkInfos[uid], 1)
	end
	return self.talkInfos[uid]
end

--保存消息
function this:SetInfo(proto, _isSelf)
	if(proto) then
		local datas = self:GetTalks(proto.uid)
		proto.msg = MsgParser:getString(proto.msg)--屏蔽字体用***代替
		table.insert(datas, {data = proto, isSelf = _isSelf})
		FileUtil.SaveToFile(proto.uid .. "friend.txt", datas)  --保存数据
	end
end

--获取数据
function this:GetData(uid)
	if(uid == nil) then
		LogError("uid is nil")
		return nil
	end
	return self.datas[uid]
end

--获取数据
function this:GetDatasByState(state)
	state = state == nil and eFriendState.Pass or state
	local _datas = {}
	for i, v in pairs(self.datas) do
		if(v:GetState() == state) then
			table.insert(_datas, v)
		elseif(state == eFriendState.Black and v:GetState() == eFriendState.InterBlack) then
			table.insert(_datas, v)
		end
	end
	table.sort(_datas, function (a,b)
		if a:IsOnLine() ~= b:IsOnLine() then
			return a:IsOnLine()
		else
			return a:GetUid()<b:GetUid()
		end
	end)
	return _datas
end


function this:GetDelCnt()
	return self.had_del_cnt or 0
end

--推荐的好友（过滤掉已申请的）
function this:GetRecommends()
	local _datas = {}
	for i, v in ipairs(self.recommends) do
		local _data = self:GetData(v.uid)
		if(_data == nil or _data:GetState() == eFriendState.ApplyCancel) then
			table.insert(_datas, v)
		end	
	end
	table.sort(_datas, function (a,b)
		if a:IsOnLine() ~= b:IsOnLine() then
			return a:IsOnLine()
		else
			return false
		end
	end)
	return _datas
end

function this:GetRecommendData(uid)
	for i, v in ipairs(self.recommends) do
		if(v:GetUid() == uid) then
			return v
		end
	end
	return nil
end
--上次刷新的时间
function this:GetPreFlushTime()
	return self.pre_flush_time or 0
end

function this:FindData(str)
	local data = {}
	if(str == nil or str == "") then
		return self.datas
	end
	local datas = self:GetDatasByState()
	if(datas and #datas > 0) then
		for i, v in ipairs(datas) do
			if(v:GetUid() == str or v:GetName() == str or v:GetAlias() == str) then
				table.insert(data, v)
				break
			end
		end
	end
	return data
end

function this:CanAdd()
	return Cfgs.CfgFriendConst:GetByID(eFriendConst.InviteLimit).nVal >= self.had_apply_cnt
end

function this:CreateFakeData(v)
	local data = FriendInfo.New()
	data:InitData(v)
	return data
end

--好友数量
function this:GetFriendCount()
	local datas = FriendMgr:GetDatasByState(1)
	return datas and #datas or 0
end

--当前好友上限
function this:GetMaxCount()
	local cfg = Cfgs.CfgPlrUpgrade:GetByID(PlayerClient:GetLv())
	return cfg and cfg.nFriendLimit or 0
end


----------------------------------////助战卡牌数据
-- 设置助战数据
function this:AddAssistData(data)
	local assist = self:CreateAssistData(data);
	if assist then
		self.assistData = self.assistData or {}
		table.insert(self.assistData,{assist=assist,showNum=0});
		-- self.assistData[cid] = assist
	end
end

--创建助战数据
function this:CreateAssistData(data)
	if data then
		local assist = table.copy(data)
		setmetatable(assist.card, getmetatable(data.card))
		setmetatable(assist, getmetatable(data))
		local card = assist.card
		card.old_cid=card.cid;
		local cid = FormationUtil.FormatAssitID(data.uid, card.cid)
		card.cid = cid
		card.fuid=data.uid;
		return assist;
	end
	return nil;
end

-- 判断卡牌是否是助战卡牌
function this:IsAssist(cid)
	if cid and self:GetAssistData(cid) ~= nil then
		return true
	end
	return false
end

function this:GetAssistData(cid)
	if self.assistData and cid then
		for k, v in ipairs(self.assistData) do
			if v.assist.card and v.assist.card.cid == cid then
				return v.assist;
			end
		end
	end
	return nil;
end

--cid:助战id，cardData:卡牌数据非卡牌对象
function this:SetAssistCard(cid, cardData, isFull)
	if cid and cardData and self.assistData then
		cardData.cid = cid;
		local aData = self:GetAssistData(cid);
		if aData then
			aData.card = cardData;
			aData.isFull = isFull;
		end
	end
end

function this:GetAssistFormat(proto, card, index, isFull)
	return {
		uid = proto.uid,
		name = proto.name,
		alias = proto.alias,
		icon_id = proto.icon_id,
		icon_frame=proto.icon_frame,
		sel_card_ix=proto.sel_card_ix,
		level = proto.level,
		card = card,
		assit_cnt = proto.assit_cnt,
		last_save_time = proto.last_save_time,
		online = proto.online,
		is_fls = proto.is_fls,
		showCount = proto.showCount or 0,--显示的次数
		isFull = isFull,
		index = index,
	};
end

-- 获取助战的数据
function this:InitAssistData(callBack)
	FriendProto:GetAssitInfo(nil, function(proto)
		self:OnAssitInfoAdd(proto);
		if callBack then
			callBack();
		end
	end)
end

function this:OnAssitInfoAdd(proto)
	if proto then
		self:ClearAssistData(false);
		if proto.assits then
			--缓存已经助战的卡
			self.isRealRefresh = false;
			self.tLIndex=1;
			for _, v in ipairs(proto.assits) do
				for k, val in ipairs(v.cards) do
					local cardData = Cfgs.CardData:GetByID(val.cfgid)
					if cardData ~= nil then
						self:AddAssistData(self:GetAssistFormat(v, val, k));
					end
				end
			end
		end
		-- LogError(proto.new_tower_assits)
		if proto.new_tower_assits and #proto.new_tower_assits>0 then --爬塔锁定的角色数据,只有重登才会清理
			self.newTowerAssitsLock=self.newTowerAssitsLock or {};
			for k,v in ipairs(proto.new_tower_assits) do
				if v.new_tower_assit and v.sid then
					local formatData=self:GetAssistFormat(v.new_tower_assit, v.new_tower_assit.cards[1], 1,true)
					local assist=self:CreateAssistData(formatData);
					self.newTowerAssitsLock[v.sid] =assist;
				end
			end
		-- else
		-- 	self.newTowerAssitsLock=nil;
		end
	end
	if self.assistData then
		table.sort(self.assistData, AssistSortUtil.Sort);
	end
end

function this:IsLockAssist(cid,sectionId)
	if self.newTowerAssitsLock and self.newTowerAssitsLock[sectionId] and self.newTowerAssitsLock[sectionId].card.cid==cid then
		return true;
	end
	return false;
end

function this:GetLockAssistID(sectionId)
	if self.newTowerAssitsLock and self.newTowerAssitsLock[sectionId] then
		return self.newTowerAssitsLock[sectionId].card.cid;
	end
	return nil;
end

--是否刷新助战数据
function this:IsRefreshAssist()
	if self.assistData then
		return self.isRealRefresh == true;
	end
	return true;
end

--返回助战卡牌数据列表 isRefresh:是否刷新下标
function this:GetAssistList(num, isRefresh, fixedID,isTower,sectionId)
	local list = {};
	if self.assistData then
		self.tLIndex = self.tLIndex or 1;
		if isRefresh then
			--判断是否需要再次请求数据
			if self.tLIndex + 1 > #self.assistData then --下一个循环的起始下标
				self.tLIndex = 1;
			end
		elseif self.tLAssitList then --上次请求的列表
			if fixedID then
				local fixedUserID=nil;--当前固定显示的卡牌的用户ID
				local card = self:GetAssistCardData(fixedID,sectionId);
				if card then
					fixedUserID=card:GetData().assist.uid;--持有人ID
					local has=false;
					for k,v in ipairs(self.tLAssitList) do
						if v:GetID()==fixedID then
							has=true;
							break;
						end
					end
					if has~=true then
						table.insert(list, card);
					end
				end
			end
			for k,v in ipairs(self.tLAssitList) do --防止NPC重复
				table.insert(list,v);
			end
			return list;
		end
		local fMax=Cfgs.CfgFriendConst:GetByID(eFriendConst.AssitCntLimit).nVal --好友卡牌助战总次数
		local oMax=Cfgs.CfgFriendConst:GetByID(eFriendConst.NotFriendAssitCntLimit).nVal --路人卡牌助战总次数
		local assits = {};
		local fixedUserID=nil;--当前固定显示的卡牌的用户ID
		if fixedID then
			local card = self:GetAssistCardData(fixedID,sectionId);
			if card then
				fixedUserID=card:GetData().assist.uid;--持有人ID
				table.insert(list, card);
			end
		end
		local isRun=true;
		local idx=self.tLIndex;
		local runNum=0;
		while(isRun) do
			for i = idx, #self.assistData do
				local currNum=#list+#assits;
				if currNum >= num then
					isRun=false;
	 				break;
				end
				local assist=self.assistData[i].assist;
				if fixedUserID~=assist.uid then --固定卡牌的用户卡牌不再获取
					local userIdx = -1; --同一人的卡
					if #assits > 0 then
						for k, v in ipairs(assits) do --剔除重复的玩家卡牌
							if v.card:GetAssistData().uid == assist.uid then
								userIdx = k;
								break;
							end	
						end
					end
					if currNum < num and((assist.is_fls == true and assist.assit_cnt < fMax) or(assist.is_fls ~= true and assist.assit_cnt < oMax)) then
						if userIdx~=-1 then --存在相同玩家的卡牌时判定使用哪一张
							--比较两个卡的显示次数，少的覆盖多的
							if self.assistData[i].showNum<assits[userIdx].showNum then
								local card = self:GetAssistCardData(assist.card.cid,sectionId);
								assits[userIdx]={card=card,showNum=self.assistData[i].showNum};
								self.tLIndex = i;
							end
						else --否则直接加入
							local card = self:GetAssistCardData(assist.card.cid,sectionId);
							table.insert(assits, {card=card,showNum=self.assistData[i].showNum});
							self.tLIndex = i;
						end
					end
				end
			end
			idx=1;
			runNum=runNum+1;
			if runNum>=2 then
				break;
			end
			-- Log("idx:"..tostring(idx).."\t"..tostring(#self.assistData))
		end
		if assits then
			self.tLAssitList={}
			for k, v in ipairs(assits) do
				table.insert(list,v.card);
				table.insert(self.tLAssitList,v.card)
			end
		end
		table.sort(list,AssistSortUtil.Sort2);
		table.sort(self.tLAssitList,AssistSortUtil.Sort2);
		local isRefresh2=true;
		for k,v in ipairs(self.assistData) do --记录显示轮次并判断是否刷新
			local has=false;
			for _, val in ipairs(assits) do
				-- Log(v.assist.card.cid.."\t"..val.card:GetID())
				if v.assist.card.cid==val.card:GetID() then
					has=true;
					break;
				end
			end
			if has then
				v.showNum=v.showNum+1;
			end
			if v.showNum<1 then
				isRefresh2=false;
				break;
			end
		end
		-- Log("是否需要刷新："..tostring(isRefresh2))
		self.isRealRefresh = isRefresh2; --设置下次获取需要刷新
	end
	return list;
end

--设置助战次数+1
function this:SetAssistMemberCnt(uid)
	if uid==nil then
		return;
	end
	for k, v in ipairs(self.assistData) do
		local val=v.assist;
		if val.uid==uid then
			-- i=k;x=key;
			val.assit_cnt=val.assit_cnt+1;
		end
	end
end

--返回协战数据的卡牌对象
function this:GetAssistCardData(cid,sectionId)
	-- local assist = self:GetAssistData(cid);
	local assist=nil;
	if (sectionId==7001 or sectionId==7002 or sectionId == 23001) and self.newTowerAssitsLock~=nil and self.newTowerAssitsLock[sectionId]~=nil then --优先获取爬塔助战卡
		if self.newTowerAssitsLock[sectionId].card and self.newTowerAssitsLock[sectionId].card.cid==cid then
			assist=self.newTowerAssitsLock[sectionId];
		end
	end
	if assist==nil then
		assist = self:GetAssistData(cid);
	end
	local card = nil;
	if assist ~= nil then
		card = CharacterCardsData(assist.card)
		card:GetData().assist = self:GetAssistFormat(assist, nil, assist.index, assist.isFull);
	end
	return card;
end

--获取助战卡牌的详细卡牌数据
function this:SetAssistInfos(uid, cids, func)
	if uid and cids then
		FriendProto:GetFriendCard(uid, cids, FriendIxType.Assist, function(proto)
			if proto and proto.cards then
				for k, v in ipairs(proto.cards) do
					local assistId = FormationUtil.FormatAssitID(uid, v.cid)
					self:SetAssistCard(assistId, v, true);
				end
			end
			if func then
				func(proto);
			end
		end);
	elseif func then
		func();
	end
end

--返回UID对应的玩家的支援卡牌数据
function this:GetAssistCardByUID(uid)
	local data = {}
	if self.assistData == nil or uid == nil then
		return data;
	end
	for k, v in ipairs(self.assistData) do
		if uid == v.assist.uid then
			local card = self:GetAssistCardData(v.assist.card.cid);
			-- card:GetData().assist=self:GetAssistFormat(v.assist,nil,v.assist.isFull);
			table.insert(data, card)
		end
	end
	table.sort(data, function(a, b)
		if a:GetLv() == b:GetLv() then
			return a:GetCfgID() < b:GetCfgID()
		else
			return a:GetLv() > b:GetLv()
		end
	end)
	return data
end

--返回根据类型返回显示用的协战卡牌(用于处理RoleList中助战卡牌的显示问题)
function this:GetAssisCardByType(type)
	local data = {}
	if self.assistData == nil then
		return data;
	end
	for k, v in ipairs(self.assistData) do
		local val=v.assist;
		local card = self:GetAssistCardData(val.card.cid);
		if type and card:GetMainType() == type then
			card:GetData().assist = self:GetAssistFormat(val, nil, val.isFull);
			table.insert(data, card)
		elseif type == nil then
			card:GetData().assist = self:GetAssistFormat(val, nil, val.isFull);
			table.insert(data, card)
		end
	end
	table.sort(data, function(a, b)
		if a:GetLv() == b:GetLv() then
			return a:GetCfgID() < b:GetCfgID()
		else
			return a:GetLv() > b:GetLv()
		end
	end)
	return data
end

--标示助战卡不清理
function this:SetDontCleanAssist(cids)
	if cids and self.assistData then
		self.dCleanList = self.dCleanList or {};
		for k, v in ipairs(cids) do
			for _, val in ipairs(self.assistData) do
				if val.assist.card and val.assist.card.cid == v then
					table.insert(self.dCleanList, val);
					break;
				end
			end
		end
	end
end

-- 清空助战数据isForce:强制清空所有数据，为false时被标记为不清空的数据不会情况
function this:ClearAssistData(isForce)
	if isForce then
		self.assistData = nil
		self.newTowerAssitsLock=nil;
	else
		if self.dCleanList then
			self.assistData ={}
			for k, v in ipairs(self.dCleanList) do
				table.insert(self.assistData, v);
			end
		else
			self.assistData = nil
		end
	end
	self.dCleanList = nil;
	self.tLIndex = 1;
	self.tLAssitList=nil;
end

function this:SetSelect(_uid)
	self.selectID = _uid
end
function this:GetSelect()
	return self.selectID
end



----------------------------------发--------------------------------------
--好友列表
function this:GetFriendsData()
	self.datas = {}
	local proto = {"FriendProto:GetFriendsData"}
	NetMgr.net:Send(proto)
end
--查看协战信息
function this:HelpFigtInfo(_fid)
	local proto = {"FriendProto:HelpFigtInfo", {uid = _fid}}
	NetMgr.net:Send(proto)
end
--查看卡牌信息
function this:HelpFightCard(_fid, _cid)
	local proto = {"FriendProto:HelpFightCard", {uid = _fid, cid = _cid}}
	NetMgr.net:Send(proto)
end
--搜索好友
function this:Search(_fid)
	local proto = {"FriendProto:Search", {name = _fid}}
	NetMgr.net:Send(proto)
end
--修改玩家状态
function this:Op(datas)
	local proto = {"FriendProto:Op", {ops = datas}}
	NetMgr.net:Send(proto)
	
	for i, v in pairs(datas) do
		local eventName = ""
		if(v.state == eFriendState.Apply) then
			eventName = "apply_friend"
		elseif(v.state == eFriendState.Pass) then
			eventName = "add_friend"
		elseif(v.state == eFriendState.Delete) then
			eventName = "delete_friend"
		end
		if(eventName ~= "") then
			if CSAPI.IsADV()==false then
				BuryingPointMgr:TrackEvents(eventName, {friend_id = v.uid})
			end
		end
	end
	
end
--修改玩家名称
function this:Alias(_fid, _alias)
	local proto = {"FriendProto:Alias", {uid = _fid, alias = _alias}}
	NetMgr.net:Send(proto)
end
--获取推荐 --_is_manual 是否手动刷新
function this:GetRecomend(_is_manual)
	local proto = {"FriendProto:GetRecomend", {is_manual = _is_manual}}
	NetMgr.net:Send(proto)
end
--获取推荐返回
function this:GetRecomendRet(proto)
	self.recommends = {}
	self.pre_flush_time = proto.pre_flush_time or 0 --上次自动刷新的时间
	if(proto and #proto.info > 0) then
		for i, v in ipairs(proto.info) do
			if(v.uid ~= PlayerClient:GetID()) then
				--local data = self.datas[v.uid]
				--if(data == nil or data:GetState() == eFriendState.ApplyCancel) then
				local newData = FriendInfo.New()
				newData:InitData(v)	
				table.insert(self.recommends, newData)
				--end
			end
		end
	end
	EventMgr.Dispatch(EventType.Friend_Recommend)
end

--发送信息
function this:SendMsg(_fid, _msg)
	local proto = {"FriendProto:SendMsg", {uid = _fid, msg = _msg}}
	NetMgr.net:Send(proto)
end
--请求刷新列表
function this:GetFlush(_fileds)
	local proto = {"FriendProto:GetFlush", {fileds = _fileds}}
	NetMgr.net:Send(proto)
end
--请求刷新列表
function this:GetFriendFlush()
	local fileds = {
		"sign",
		"assit_team",
		"last_save_time",
		"is_online",
		"level",
		"uid",
		"build_opens",
		"icon_frame",
		"sel_card_ix",
		"icon_title",
		"icon_id",
	}
	self:GetFlush(fileds)
end

--获取玩家面板信息
function this:FriendPaneInfo(_uid)
	local proto = {"FriendProto:FriendPaneInfo", {uid = _uid}}
	NetMgr.net:Send(proto)
end

----------------------------------收--------------------------------------
--检查红点数据
function this:CheckRedPointData()
	local _datas = self:GetDatasByState(eFriendState.Waiting)
	RedPointMgr:UpdateData(RedPointType.Friend, #_datas > 0 and #_datas or nil)
end

--好友添加通知
function this:FriendAdd(proto)
	self.datas = self.datas or {}
	self.had_del_cnt = proto.had_del_cnt
	self.had_apply_cnt = proto.had_apply_cnt
	if(#proto.friends > 0) then
		for i, v in ipairs(proto.friends) do
			local data = FriendInfo.New()
			data:InitData(v)
			self.datas[v.uid] = data
		end
	end
	EventMgr.Dispatch(EventType.Friend_Update)
	EventMgr.Dispatch(EventType.Friend_Add)
	self:CheckRedPointData()
end

--好友刷新通知
function this:FriendFlush(proto)
	self.datas = self.datas or {}
	if(proto and #proto.friends > 0) then
		for i, v in ipairs(proto.friends) do
			local data = self.datas[v.uid]
			if(data) then
				for k, m in pairs(v) do
					data[k] = m
				end
			end
		end		
	end
	EventMgr.Dispatch(EventType.Friend_Update)
	
	self:CheckRedPointData()
end

--查看协战信息返回
function this:HelpFigtInfoRet(proto)
	EventMgr.Dispatch(EventType.Friend_Team, proto)
end
--查看卡牌信息返回
function this:HelpFightCardRet(proto)
	EventMgr.Dispatch(EventType.Friend_Card, proto)
end
--搜索好友返回
function this:SearchRet(proto)
	EventMgr.Dispatch(EventType.Friend_Find, proto)
end

--修改玩家状态返回
function this:OpRet(proto)
	local needNotice = true
	self.had_del_cnt = proto.had_del_cnt
	self.had_apply_cnt = proto.had_apply_cnt
	for i, v in ipairs(proto.ops) do
		local data = self.datas[v.uid]
		if(data) then
			data.state = v.state
			if v.state == eFriendState.Apply then
				LanguageMgr:ShowTips(6012)
			end
		end
	end
	if(#proto.ops > 0) then
		EventMgr.Dispatch(EventType.Friend_Op)
	end
	
	self:CheckRedPointData()
end
--修改玩家名称返回
function this:AliasRet(proto)
	local data = self.datas[proto.uid]
	if(data) then
		data.alias = proto.alias
	end
	EventMgr.Dispatch(EventType.Friend_Update)
end


--发送信息返回
function this:SendMsgRet(proto)
	self:SetInfo(proto, true)
	EventMgr.Dispatch(EventType.Friend_MsgNotice_self, proto)
end
--消息通知
function this:RecvNotice(proto)
	self:SetInfo(proto, false)
	local data = self.datas[proto.uid]
	if(data) then
		data:IsNewInfo(true)
	end
	EventMgr.Dispatch(EventType.Friend_MsgNotice, proto)
	--EventMgr.Dispatch(EventType.Chat_UpdateInfos_Firend, proto)
end

--获取玩家面板信息返回
function this:FriendPaneInfoRet(proto)
	EventMgr.Dispatch(EventType.Player_Info, proto)
end

--刷新玩家助战信息
function this:FriendSupportUpdate(_uid, _datas, _type)
	if _type == 2 then
		if self.recommends then
			for i, v in ipairs(self.recommends) do			
				if v.uid == _uid then
					v.assit_team.data = _datas
					break
				end
			end
		end
	else
		if self:GetData(_uid) then
			self:GetData(_uid).assit_team.data = _datas
		end
	end
end

return this 