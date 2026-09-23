--队伍数据
local this = {}

--==============================--
--desc:创建一个TeamData类
--time:2019-04-26 11:33:03
--@data:参考协议中的TeamItem结构体
--@return 
--==============================--
function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:SetData(data)
	if data then
		self.teamName = data.name;
		self.index = data.index;
		self.backUp = nil;--备份数据
		self.bIsReserveSP=data.bIsReserveSP;
		self.nReserveNP=data.nReserveNP;
		self.preformance=data.preformance;
		-- self.indexTab = {};--卡牌在数组中的下标索引，cid-下标
		-- self.skillGroupID=data.skill_group_id;
		self:SetSkillGroupID(data.skill_group_id);
		self.data = {};
		local lBIsNpc=false;
		if data.data~=nil then
			for k, v in ipairs(data.data) do
				local itemData=TeamItemData.New();
				local cid=v.cid;
				if v.bIsNpc then
					local isNpc=FormationUtil.CheckNPCID(cid);
					if isNpc~=true then
						cid=FormationUtil.FormatNPCID(cid);
					end
				end
				local tempData={
					cid=cid,
					row=v.row,
					col=v.col,
					fuid=v.fuid,
					card_info=v.card_info,
					bIsNpc=v.bIsNpc,
					index=v.index,--卡牌在队伍中的位置
					isForce=v.isForce,
					isLeader=v.cid==data.leader,
					nStrategyIndex=v.nStrategyIndex,
				}
				if v.cid==data.leader then
					lBIsNpc=v.bIsNpc;
				end
				itemData:SetData(tempData);
				table.insert(self.data, itemData);
			end
			self:SortByLeader();
			-- self:RefreshIndex();
		end
		local leaderID=data.leader;
		if lBIsNpc then
			local isNpc=FormationUtil.CheckNPCID(leaderID);
			if isNpc~=true then
				leaderID=FormationUtil.FormatNPCID(leaderID);
			end
		end
		self.leader = leaderID;
	end
end

function this:HasLeader()
	local hasLeader=true;
	if self.leader==nil or self.leader==0 then
		hasLeader=false;
	end
	return hasLeader;
end

--- func 返回队伍类型 retrun eTeamType
function this:GetTeamType()
	return TeamMgr:GetTeamType(self.index);
end

-- 返回成员最高等级
function this:GetMemberMaxLv()
    local maxLv = 0;
    if self.data then
        for k, v in ipairs(self.data) do
			if not v:IsAssist() then
				local lv = v:GetLv();
				if lv > maxLv then
					maxLv = lv;
				end
			end
        end
    end
    return maxLv;
end

--返回性能
function this:GetPreformance()
	return self.preformance or 0;
end

--返回预留NP
function this:GetReserveNP()
	return self.nReserveNP or 0;
end

--返回是否预留SP
function this:GetIsReserveSP()
	return self.bIsReserveSP or false;
end

function this:SetReserveNP(val)
	self.nReserveNP=val;
end

function this:SetIsReserveSP(val)
	self.bIsReserveSP=val;
end

--==============================--
--desc:添加卡牌
--time:2019-04-26 11:34:31
--@data:参考协议中的TeamItemData结构体
--@return 
--==============================--
function this:AddCard(data)
	self.data = self.data or {};
	-- self.indexTab = self.indexTab or {};
	if data then
		local itemData=TeamItemData.New();
		local tempData={
			cid=data.cid,
			row=data.row,
			col=data.col,
			fuid=data.fuid,
			card_info=data.card_info,
			bIsNpc=data.bIsNpc,
			index=data.index,
			isForce=data.isForce,
		}
		itemData:SetData(tempData);
		table.insert(self.data, itemData);
		-- self.indexTab[itemData.cid] = {teamPos = #self.data};
		-- if #self.data == 1 and FriendMgr:IsAssist(data.cid)==false and data.index==nil then
		-- 	self.leader = data.cid;
		-- else
		if data.index~=nil and data.index==1 and FriendMgr:IsAssist(data.cid)==false then
			self:SetLeader(data.cid);
		end
		self:SortByLeader();
		-- self:RefreshIndex();
	end
end

--删除卡牌 disRefresh:为true时不自动队员刷新下标
function this:RemoveCard(cid,disRefresh)
	local idx = -1;
	if self.data and cid then
		for k,v in ipairs(self.data) do
			if v.cid and v.cid==cid then
				idx=k;
				break;
			end
		end
	end
	if idx and idx ~= - 1 then
		table.remove(self.data, idx);
		--刷新index
		if disRefresh~=true then
			for k,v in ipairs(self.data) do
				local index=self:GetNextIndex();
				if index and v.index and v.index>index and not v:IsNPC() and not v:IsForce() and not v:IsAssist() then
					v.index=index;
				end
			end
		end
		if disRefresh and self.leader==cid then
			self.leader=nil;
		elseif self.leader == cid and #self.data > 0 and not self.data[1]:IsAssist()  then --支援队员不能是队长
			self.leader = self.data[1].cid;
			self.data[1].isLeader=true;
		elseif self.data == nil or #self.data == 0 then
			self.leader = nil;
		elseif self.leader == cid and #self.data ==1 and not self.data[1]:IsAssist() then
			self.leader=nil;
		end
		self:SortByLeader();
		-- self:RefreshIndex();
	end
end
--删除卡牌 disRefresh:为true时不自动队员刷新下标 根据卡牌tag查询
function this:RemoveCardByTag(roleTag,disRefresh)
	if self.data and roleTag then
		for k,v in ipairs(self.data) do
			if v:GetRoleTag() and v:GetRoleTag() == roleTag then
				self:RemoveCard(v.cid,disRefresh)
				break;
			end
		end
	end
end

--清理卡牌
function this:ClearCard()
	self.data={};
	self.leader=nil;
	-- self.indexTab = {};
end

--更新卡牌位置的变化
function this:UpdateItemPos(cid,row,col)
	local item=self:GetItem(cid);
	if item then
		item.row=row;
		item.col=col;
	end
end

--根据占位表设置卡牌信息
function this:UpdateDataByArray(array)
	if array then
		self.data = {};
		for k, v in ipairs(array) do
			local itemData=TeamItemData.New();
			local tempData={
				cid=v.cid,
				row=v.row,
				col=v.col,
				fuid=v.fuid,
				card_info=v.card_info,
				bIsNpc=v.bIsNpc,
				index=v.index,
				isForce=v.isForce,
				isLeader=v.isLeader,
			}
			itemData:SetData(tempData);
			table.insert(self.data, itemData);
		end
		self:SortByLeader();
		-- self:RefreshIndex();
	end
end

function this:SetIndex(index)
	if index then
		self.index = index;
	end
end

--返回队伍下标
function this:GetIndex()
	return self.index;
end

--备份当前队伍数据
function this:BackUp()
	local tempData = {};
	for k, v in ipairs(self.data) do
		table.insert(tempData, v:GetFormatData());
	end
	self.backUp = {
		index = self.index,
		leader = self.leader,
		name = self.teamName,
		skill_group_id=self:GetSkillGroupID(),
		data = tempData,
		performance=self.preformance,
		bIsReserveSP=self.bIsReserveSP,
		nReserveNP=self.nReserveNP,
	};
end

--重置数据
function this:Reset()
	if self.backUp then
		self:SetData(self.backUp);
	end
end

--返回数据
function this:GetData()
	local tempData = {};
	for k, v in ipairs(self.data) do
		table.insert(tempData, v:GetFormatData());
	end
	local tab = {
		index = self.index,
		leader = self.leader,
		name = self.teamName,
		skill_group_id=self:GetSkillGroupID(),
		data = tempData,
		performance=self.preformance,
		bIsReserveSP=self.bIsReserveSP,
		nReserveNP=self.nReserveNP,
	};
	return tab;
end

--返回保存时用到的数据
function this:GetSaveData()
	local tempData = {};
	for k, v in ipairs(self.data) do
		table.insert(tempData, v:GetSaveData());
	end
	local leaderID=self.leader;
    local isNpc,s1,s2=FormationUtil.CheckNPCID(leaderID);
	if isNpc and s2 then
		leaderID=tonumber(s2);
	end
	local tab = {
		index = self.index,
		leader = leaderID,
		name = self.teamName,
		skill_group_id=self:GetSkillGroupID(),
		data = tempData,
		performance=self.preformance,
		bIsReserveSP=self.bIsReserveSP,
		nReserveNP=self.nReserveNP,
	};
	return tab;
end

--刷新卡牌在数组中的的下标
-- function this:RefreshIndex()
-- 	self.indexTab = {};
-- 	if self.data then
-- 		for k, v in ipairs(self.data) do
-- 			self.indexTab[v.cid] = {teamPos = k};
-- 		end
-- 	end
-- end

--返回卡牌数量
function this:GetCount()
	return self.data and #self.data or 0;
end

function this:GetRealCount()
	local count=0;
	if self.data then
		for k,v in ipairs(self.data) do
			if  not v:IsAssist() then
				count=count+1;
			end
		end
	end
	return count;
end

--返回卡牌在数组中的下标
-- function this:GetCardIndex(cid)
-- 	local index = - 1;
-- 	if cid and self.data then
-- 		for k,v in ipairs(self.data) do
-- 			if v.cid and v.cid==cid then
-- 				index=k;
-- 				break;
-- 			end
-- 		end
-- 	end
-- 	return index;
-- end

--判断是否是队长
function this:IsLeader(cid)
	return self.leader == cid;
end

function this:SetLeader(cid)
	if self.data then
		local item=self:GetItem(cid);
		if item==nil then
			LogError("设置队长的ID无效："..tostring(cid))
			return;
		end
		if self.leader~=nil then
			local oldLeader=self:GetItem(self.leader);
			if oldLeader then
				oldLeader.index=item.index
				oldLeader.isLeader=false
			end
		end
		self.leader = cid;
		item.index=1;
		item.isLeader=true;
		self:SortByLeader();
		-- self:RefreshIndex();
	end
end

--返回队长ID
function this:GetLeaderID()
	return self.leader;
end

function this:GetLeader()
	if self.data then
		for k, v in ipairs(self.data) do
			if v.cid == self.leader then
				return v;
			end
		end
	end
	return nil;
end

--根据cfgID返回卡牌占位数据
function this:GetItemByCfgID(cfgId)
	local data = nil;
	if self.data then
		for k, v in ipairs(self.data) do
			local cfgId2 = v:GetCardCfgID();
			if cfgId2 and cfgId2 == cfgId then
				data = v;
				break;
			end
		end
	end
	return data;
end

--返回卡牌站位数据 
function this:GetItem(cid)
	local card = nil;
	if cid and self.data then
		for k,v in ipairs(self.data) do
			if v.cid and v.cid==cid then
				card=v;
				break;
			end
		end
	end
	return card;
end

--根据item的index属性返回数据
function this:GetItemByIndex(index) 
	local card=nil;
	if index and self.data then
		for k,v in ipairs(self.data) do
			if v.index and v.index==index then
				card=v;
				break;
			end
		end
	end
	return card;
end

--返回玩家持有的卡牌队员
function this:GetMineCard()
	local list={};
	if self.data then
		for k,v in ipairs(self.data) do
			if not v:IsNPC() and not v:IsAssist() then
				table.insert(list,v);
			end
		end
	end
	return list;
end

--设置队伍名
function this:SetTeamName(name)
	if name==nil or name=="" then
		name=FormationUtil.GetDefaultName(self.index);
	else
		name=tostring(name)
	end
	self.teamName = name;
end

--返回队伍名称
function this:GetTeamName()
	local teamName=self.teamName
	teamName=FormationUtil.GetDefaultName(self.index,self.teamName);
	return teamName;
end

--返回队伍COST值
function this:GetTeamCost()
	local cost = 0;
	if self.data then
		for _, v in ipairs(self.data) do
			cost=cost+v:GetCost();
		end
	end
	return math.modf(cost);
end

--返回队伍NP值
function this:GetTeamNP()
	local np = 0;
	if self.data then
		for _, v in ipairs(self.data) do
			np = np + v:GetNP();
		end
	end
	return math.modf(np);
end

--返回队伍能力值
function this:GetTeamStrength()
	local power = 0;
	if self.data then
		for _, v in ipairs(self.data) do
			power = power + v:GetProperty();
		end
	end
	return math.modf(power);
end

--返回队伍的光环战力值
function this:GetHaloStrength()
	local power=0;
	if self.data then
		local datas={};
		local infos={};
		for _,v in ipairs(self.data) do
			local card=v:GetCard();
			if card then
				-- LogError(card:GetBaseProperty())
				--25-09-17修改，光环战力计算只使用基础属性
				local data=card:GetBaseProperty();
				data.haloInfo=v:GetCard():GetData().haloInfo or {};
				data.id=v:GetCfgID();
				-- local data={
				-- 	id=v:GetCfgID(),
				-- 	name=v:GetCfg().name,
				-- 	attack=v:GetCard():GetCurDataByKey("attack"),
				-- 	maxhp=v:GetCard():GetCurDataByKey("maxhp"),
				-- 	defense=v:GetCard():GetCurDataByKey("defense"),
				-- 	speed=v:GetCard():GetCurDataByKey("speed"),
				-- 	crit_rate=v:GetCard():GetCurDataByKey("crit_rate"),
				-- 	crit=v:GetCard():GetCurDataByKey("crit"),
				-- 	hit=v:GetCard():GetCurDataByKey("hit"),
				-- 	damage=v:GetCard():GetCurDataByKey("damage"),
				-- 	resist=v:GetCard():GetCurDataByKey("resist"),
				-- 	haloInfo=v:GetCard():GetData().haloInfo or {},
				-- };
				infos[string.format("%s_%s",v.row,v.col)]=data
				table.insert(datas,{
					data=data,
					col=v.col,
					row=v.row,
				});
			end
		end
		power=GCardCalculator:GetTeamPowerAdd(self:GetTeamStrength(),datas);
		-- local property=Halo:Calc(datas); --计算光环加成的具体数值
		-- if property then
		-- 	for k,v in ipairs(property) do --计算这一部分属性的战斗力
		-- 		if v.bInHalo then --受到光环加成的卡
		-- 			local info=infos[string.format("%s_%s",v.row,v.col)];
		-- 			local basePower=GCardCalculator:CalPerformance(info,3);
		-- 			local haloAddPower=GCardCalculator:CalPerformance(v.data,3);
		-- 			power=power+(haloAddPower-basePower);
		-- 		end
		-- 	end
		-- end
	end
	return power;
end

--排序，将队长放第一位
function this:SortByLeader()
	if self.data then
		table.sort(self.data, function(a,b)
			if a.fuid==nil and a.cid==self.leader then
				return true;
			elseif b.fuid==nil and b.cid==self.leader then
				return false;
			else
				if a.index~=nil and b.index~=nil then
					return a.index<b.index;
				else
					if a.row==b.row then
						return a.col<b.col;
					else
						return a.row<b.row;
					end
				end
			end
		end);
	end
end

--判断当前队列中是否有卡牌存在相同的roleTag  isNotAssist:是否排除协战队员
function this:HasRoleTag(roleTag,isNotAssist)
	local hasRole = false;
	if self.data then
		for _, v in ipairs(self.data) do
			local itemRoleID = v:GetRoleTag();	
			if (isNotAssist~=true or (isNotAssist and not v:IsAssist())) and roleTag==itemRoleID and itemRoleID~=nil then
				hasRole=true;
				break;
			end
		end
	end
	return hasRole;
end

--根据roleID获取队员数据
function this:GetItemByRoleTag(roleTag,isNotAssist)
	local item = nil;
	if self.data then
		for _, v in ipairs(self.data) do
			local itemRoleTag = v:GetRoleTag();
			if (isNotAssist~=true or (isNotAssist and not v:IsAssist())) and itemRoleTag~=nil and roleTag==itemRoleTag  then
				item=v;
				break;
			end
		end
	end
	return item;
end

function this:SetSkillGroupID(id,isForce)
	local skillGroupId=id~=nil and id or g_DefaultAbilityId;
	if isForce then
		self.skillGroupID=id;
	else
		local tacticData=TacticsMgr:GetDataByID(skillGroupId);
		if tacticData and tacticData:IsUnLock() then
			self.skillGroupID=skillGroupId;--技能组ID
		else
			self.skillGroupID=nil;
		end
	end
end

--返回技能组ID
function this:GetSkillGroupID()
	if self.skillGroupID then
		local tacticData=TacticsMgr:GetDataByID(self.skillGroupID);
		if tacticData and tacticData:IsUnLock() then
			return self.skillGroupID 
		else
			self.skillGroupID=nil;
			return nil
		end		
	else
		local tacticData=TacticsMgr:GetDataByID(g_DefaultAbilityId);
		if tacticData and tacticData:IsUnLock() then--默认战术解锁则返回默认战术
			return g_DefaultAbilityId;
		else
			return 0;
		end
	end
end

--返回队伍中的助战卡牌ID，没有的话就返回nil
function this:GetAssistID()
	for k,v in ipairs(self.data) do
		if v:IsAssist() or tonumber(v.cid)==0 or v.index==6 then
			return v.cid;
		end
	end
	return nil;
end

--返回队伍中的助战队员数据
function this:GetAssistData()
	for k,v in ipairs(self.data) do
		if v:IsAssist() then
			return v;
		end
	end
	return nil;
end

--检查队伍数据中是否存在对应的强制上阵卡牌
function this:CheckTeamForce(forceCfg)
	local isTrue=true;
	if forceCfg==nil then
		return isTrue;
	end
	for k,v in ipairs(forceCfg) do
		local nForceID=FormationUtil.GetNForceID(v);
		if nForceID~=nil then
			local data=nil;
			if v.bIsNpc then
				data=self:GetItem(FormationUtil.FormatNPCID(nForceID));
			else
				data=self:GetItemByCfgID(nForceID);
			end
			if data==nil or data.index~=v.index then
				local cfg=Cfgs.CardData:GetByID(nForceID);
				if cfg.role_tag=="lead" then --队长需要另外判断
					-- local nForceID=v.nForceID;
					-- if RoleMgr:IsSexInitCardIDs(nForceID) then--判断当前卡牌是否是主角卡，是的话替换为当前性别的对应卡牌ID
					-- 	nForceID=RoleMgr:GetCurrSexCardCfgId();
					-- end
					data=self:GetItemByCfgID(nForceID);
					if data~=nil and data.index==v.index then
						isTrue=true;
					else
						isTrue=false;
					end
				else
					isTrue=false;
				end
				break;
			elseif v.bIsNpc~=data.bIsNpc and data.index==v.index then--验证卡牌类型是否一致
				isTrue=false;
				break;
			end
		end
	end
	return isTrue;
end

--交换两个的成员Index
function this:ExchangeItemIndex(cid1,cid2)
	if cid1 and cid2 then
		local item1=self:GetItem(cid1);
		local item2=self:GetItem(cid2);
		if item1==nil or item2==nil then
			Log("获取不到队员数据："..tostring(item1==nil).."\t"..tostring(item2==nil));
			return 
		end
		local index=item1.index;
        item1.index=item2.index;
		item2.index=index;
		if item1.index==1 then
			self:SetLeader(item1.cid);
		elseif item2.index==1 then
			self:SetLeader(item2.cid);
		end
		self:SortByLeader();
		-- self:RefreshIndex();
	end
end

--变更成员index
function this:ChangeItemIndex(cid,index)
	if cid and index then	
		local item=self:GetItem(cid);
		if item then
			if index==1 then
				self:SetLeader(item.cid);
			elseif item.index==1 then
				self.leader=nil;
			end
			item.index=index;
			self:SortByLeader();
			-- self:RefreshIndex();
		end
	end
end

--返回下个编辑的成员index
function this:GetNextIndex()
	for i=1,5 do
		if self:GetItemByIndex(i)==nil then
			return i;
		end
	end
	return 5;
end

--返回队伍的冷却状态 1:正常,2:有冷却中的队员,3:没有冷却中的队员但存在行动值低于10的队员
function this:GetCoolState()
	local state=nil;
	if self.data and self:GetRealCount()>0 then
		local hasCool=false;
		local hasLow=false;
		for k,v in ipairs(self.data) do
			if not v:IsNPC() and not v:IsAssist() then --NPC和助战卡不考虑
				local card=FormationUtil.FindTeamCard(v.cid);
				if card then
					if card:GetHot()<=10 then
						hasLow=true;
					end
					-- if CoolMgr:CheckIsIn(v.cid) then
					-- 	hasCool=true;
					-- end
				end
            end
		end
		if hasCool then
			state=2;
		elseif hasLow then
			state=3;
		else
			state=1;
		end
	end
	return state;
end

function this:GetRaisingInfo()
	local infos={};
	local lessGiftID,lessSkillID,lessChipQualityID,lessChipLevelID,lessCardLevelID,lessNumGift,lessNumSkill,lessNumChipQuality,lessNumChipLevel,lessNumCardLevel=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil;
	for k, v in ipairs(self.data) do
		local info=v:GetRaisingInfo();
		if info~=nil then
			infos.numGift=(infos.numGift or 0)+(info.numGift or 0)
			infos.numSkill=(infos.numSkill or 0)+(info.numSkill or 0)
			infos.numChipQuality=(infos.numChipQuality or 0)+(info.numChipQuality or 0)
			infos.numChipLevel=(infos.numChipLevel or 0)+(info.numChipLevel or 0)
			infos.numCardLevel=(infos.numCardLevel or 0)+(info.numCardLevel or 0)
			if lessNumGift==nil or (lessNumGift and lessNumGift>info.numGift) then
				lessNumGift=info.numGift;
				lessGiftID=v:GetID();
			end
			if lessNumSkill==nil or (lessNumSkill and lessNumSkill>info.numSkill) then
				lessNumSkill=info.numSkill;
				lessSkillID=v:GetID();
			end
			if lessNumChipQuality==nil or (lessNumChipQuality and lessNumChipQuality>info.numChipQuality) then
				lessNumChipQuality=info.numChipQuality;
				lessChipQualityID=v:GetID();
			end
			if lessNumChipLevel==nil or (lessNumChipLevel and lessNumChipLevel>info.numChipLevel) then
				lessNumChipLevel=info.numChipLevel;
				lessChipLevelID=v:GetID();
			end
			if lessNumCardLevel==nil or (lessNumCardLevel and lessNumCardLevel>info.numCardLevel) then
				lessNumCardLevel=info.numCardLevel;
				lessCardLevelID=v:GetID();
			end
		end
	end
	infos.lessNumGift=lessNumGift;
	infos.lessGiftID=lessGiftID;
	infos.lessNumSkill=lessNumSkill;
	infos.lessSkillID=lessSkillID;
	infos.lessNumChipQuality=lessNumChipQuality;
	infos.lessChipQualityID=lessChipQualityID;
	infos.lessNumChipLevel=lessNumChipLevel;
	infos.lessChipLevelID=lessChipLevelID;
	infos.lessNumCardLevel=lessNumCardLevel;
	infos.lessCardLevelID=lessCardLevelID;
	return infos;
end

return this; 