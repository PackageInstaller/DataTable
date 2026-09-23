--编成预设Item
local items={};
local input=nil;
local group=nil;

function Awake()
	input=ComUtil.GetCom(inp_teamName,"InputField");
	CSAPI.AddInputFieldCallBack(inp_teamName,OnTeamNameEdit);
	CSAPI.AddInputFieldChange(inp_teamName,OnNameChange)
	group=ComUtil.GetCom(cardObj,"CanvasGroup");
	local iconName = Cfgs.ItemInfo:GetByID(g_FormationPriceList[1]).icon;
	ResUtil.IconGoods:Load(mIcon,iconName.."_1");
	CSAPI.SetRTSize(mIcon,40,40);
end

function OnNameChange(str)
	local text=StringUtil:FilterChar2(str);
	input.text=text;
end

function OnDestroy()
	CSAPI.RemoveInputFieldCallBack(inp_teamName,OnTeamNameEdit);
	CSAPI.RemoveInputFieldChange(inp_teamName,OnNameChange)
	ReleaseCSComRefs();
end

function OnTeamNameEdit(str)
	if elseData and elseData.team and isFirst==false then
		if not MsgParser:CheckContain(str) then
            elseData.team:SetTeamName(str);
            EventMgr.Dispatch(EventType.Team_PresetName_Change,{isChange=true,idx=elseData.team.index});
		else
            Tips.ShowTips(LanguageMgr:GetTips(9003))
            input.text=elseData.team:GetTeamName();
        end
	end
end

function Refresh(_data,_elseData)
	data=_data;
	elseData=_elseData;
	group.alpha=1;
	if elseData then
		CSAPI.SetGOActive(btnObj,elseData.isClick==true);
		SetItemState(elseData.isLock);
		if elseData.team~=nil and elseData.team:GetRealCount()>0 then
			input.interactable=true;
			-- CSAPI.LoadImg(renameImg,"UIs/FormatPreset/write.png",true,nil,true);
			isFirst=true;
			local teamName=elseData.team:GetTeamName();
			input.text=teamName==nil and FormationUtil.GetDefaultName(elseData.team.index) or tostring(teamName);
			isFirst=false;
			local datas={};
			for i=1,5 do
				local item=elseData.team:GetItemByIndex(i);
				if i>#items then
					ResUtil:CreateUIGOAsync("RoleLittleCard/RoleLittleCard",cardObj,function(go)
						local lua=ComUtil.GetLuaTable(go);
						if item then
							local isFight=TeamMgr:GetCardIsDuplicate(item:GetID());
							lua.Refresh(item:GetCard(),{key="TeamEdit",showState=isFight});
						else
							lua.Refresh();
							lua.ActiveClick(false);
						end
						table.insert(items,lua);
					end)
				elseif item~=nil then
					local isFight=TeamMgr:GetCardIsDuplicate(item:GetID());
					items[i].Refresh(item:GetCard(),{key="TeamEdit",showState=isFight});
				else
					items[i].Refresh();
					items[i].ActiveClick(false);
				end
			end
			CSAPI.SetGOActive(addObj,false);
			--生成队员格子
		else
			input.text=string.format(LanguageMgr:GetByID(26016),data);
			input.interactable=false;
			-- CSAPI.LoadImg(renameImg,"UIs/FormatPreset/write_white.png",true,nil,true);
			if elseData.isLock~=true then
				CSAPI.SetGOActive(addObj,true);
			else
				CSAPI.SetGOActive(addObj,false);
			end
			CSAPI.SetGOActive(cardObj,false);
		end
	else

	end
end

function GetIndex()
	return elseData.index;
end

function SetClickCB(cb)
	clickFunc=cb;
end

--设置item状态，是否锁定 lock=true：锁定，false解锁
function SetItemState(lock)
	lock = lock or false;
	CSAPI.SetGOActive(cardObj, not lock);
	CSAPI.SetGOActive(lockObj, lock);
	CSAPI.SetGOActive(renameBtn,not lock);
	if lock then
		CSAPI.SetText(txt_price,tostring(g_FormationPriceList[2]));
	end
	elseData.isLock = lock;
end

function OnClickItem()
	if elseData and elseData.isLock then
		--提示是否解锁
        return
	elseif elseData and elseData.team then
		if btnObj.activeSelf then
			group.alpha=1;
			CSAPI.SetGOActive(btnObj, false);
			elseData.isClick=false;
		else
			group.alpha=0.5;
			CSAPI.SetGOActive(btnObj, true);
			elseData.isClick=true;
		end
		if clickFunc then
			clickFunc(this,btnObj.activeSelf);
		end
	-- else
	-- 	local dialogdata = {}
	-- 	dialogdata.content = string.format(LanguageMgr:GetTips(14034),input.text)
	-- 	dialogdata.okCallBack = function()
	-- 		ReplaceTeam();
	-- 	end
    --     CSAPI.OpenView("Dialog", dialogdata)
	end
end

function ReplaceTeam()
	--保存预设队伍信息
	local teamData=TeamData.New();
	-- local currentData = TeamMgr:GetTeamData(TeamMgr.currentIndex);
	local currentData=TeamMgr:GetEditTeam();
	if currentData then
		teamData.skill_group_id=currentData:GetSkillGroupID();
		--判断当前卡牌是否存在于其他队伍，存在的话需要提示是否清空
		teamData:SetData(currentData:GetData());
	end
	teamData.index = eTeamType.Preset + data;
	teamData:SetTeamName(input.text);
	local assistCid=teamData:GetAssistID();
	if assistCid then --删除助战卡牌
		teamData:RemoveCard(assistCid);
	end
	TeamMgr:SaveDataByIndex(teamData.index, teamData);
	TeamMgr:SaveData(teamData,function(proto)
		if proto then
			local teamData2=TeamData.New();
			teamData2:SetData(proto.info);
			TeamMgr:SaveDataByIndex(teamData.index, teamData2);
		end
		local elseData={
			team=TeamMgr:GetTeamData(teamData.index),
			isLock=false,
			index=GetIndex(),
		}
		EventMgr.Dispatch(EventType.Team_PresetName_Change,{isChange=false,idx=teamData.index});
		Refresh(data,elseData);
	end);
end

--替换当前的数据
function OnClickReplace()
	ReplaceTeam();
end

--使用当前的数据
function OnClickUse()
	if elseData==nil or elseData.team==nil then
		LogError("要使用的队伍数据为nil");
		return
	end
	if elseData.team:GetLeader()==nil then
		Tips.ShowTips(LanguageMgr:GetTips(14014));
		return
	end
	local isPractice=false; --是否是军演队伍
	if	TeamMgr:IsTeamType(eTeamType.PracticeAttack,TeamMgr.currentIndex) or TeamMgr:IsTeamType(eTeamType.PracticeDefine,TeamMgr.currentIndex) or TeamMgr:IsTeamType(eTeamType.PVP,TeamMgr.currentIndex) then
		isPractice=true;
	end
	local isFight = TeamMgr:GetTeamIsFight(TeamMgr.currentIndex);
	if isFight then
		Tips.ShowTips(LanguageMgr:GetTips(14001));
		return;
	end
	if TeamMgr:IsTeamType(eTeamType.ChainFront,TeamMgr.currentIndex) and TrialsMgr:IsFighting() then --连锁战线
		if not CheckCanUse() then
			LanguageMgr:ShowTips(76004)
			return
		end
	end
	if isPractice then
		UseByPractice()
	elseif TeamMgr:IsTeamType(eTeamType.ChainFront,TeamMgr.currentIndex) then
		UseByCheckAssist()
	elseif TeamMgr:IsTeamType(eTeamType.CrossBoss,TeamMgr.currentIndex) then
		UseByVirCat()
	else
		UseByDuplication()
	end
end

function CheckCanUse()
	if elseData.team and elseData.team.data then
		for k,v in ipairs(elseData.team.data) do
			if not TrialsMgr:IsShowCard(v:GetRoleTag()) then
				return false
			end
		end
	end
	return true
end

function UseByDuplication() --副本队伍使用时需要检测卡牌是否冲突
	--将预设队伍信息覆盖普通队伍的信息
	local presetData = TeamMgr:GetTeamData(eTeamType.Preset + data);
	local team1=TeamMgr:GetTeamData(1);
	if TeamMgr.currentIndex==1 and presetData:GetLeader()==nil then
		local tips=string.format(LanguageMgr:GetTips(14015),tostring(team1:GetTeamName()));
		Tips.ShowTips(tips);
		return;
	end
	if presetData ~= nil then
		local hasFightCard=false;
		for k,v in ipairs(presetData.data) do
			if TeamMgr:GetCardIsDuplicate(v:GetID()) then
				hasFightCard=true;
				break;
			end
		end
		if hasFightCard then
			Tips.ShowTips(LanguageMgr:GetTips(14020));
			return;
		end
		local teamData = TeamData.New();
		teamData:SetData(presetData:GetData());
		--移除队伍一的队长卡牌
		local hasMainLeader=false;
		if TeamMgr.currentIndex~=1 then
			hasMainLeader=teamData:GetItem(team1:GetLeaderID())~=nil;
			teamData:RemoveCard(team1:GetLeaderID());
		end
		local currentData = TeamMgr:GetTeamData(TeamMgr.currentIndex);
		if currentData ~= nil then
			teamData:SetTeamName(currentData:GetTeamName() or "");
			teamData.index = currentData.index;
		else
			teamData:SetTeamName("");
			teamData.index = TeamMgr.currentIndex;
		end
		local teamType=TeamMgr:GetTeamType(TeamMgr.currentIndex);
		teamData.skill_group_id=teamData.skillGroupID;
		--判断当前卡牌是否存在于其他队伍，存在的话需要提示是否清空
		local isEmploy = false;
		for k, v in ipairs(teamData.data) do
			local card = RoleMgr:GetData(v.cid);
			if card then
				local teamIndex = TeamMgr:GetCardTeamIndex(card:GetID(),teamType,true);
				if(teamIndex ~= - 1 and teamIndex ~= TeamMgr.currentIndex) then --该卡牌存在于其他队伍中
					isEmploy = true;
					break;
				end
			end
		end
		if isEmploy then
			CSAPI.OpenView("Dialog",
			{
				content = LanguageMgr:GetTips(14016),
				okCallBack = function()
					local teamIds = {};
					for k, v in ipairs(teamData.data) do
						local card = RoleMgr:GetData(v.cid);
						if card then
							local teamIndex = TeamMgr:GetCardTeamIndex(card:GetID(),teamType,true);
							if(teamIndex ~= - 1 and teamIndex ~= TeamMgr.currentIndex) then      --该卡牌存在于其他队伍中,移除它
								local tempData = TeamMgr:GetTeamData(teamIndex);
								tempData:RemoveCard(v.cid);
								teamIds[teamIndex] = teamIndex;
							end
						end
					end
					--保存其它队伍的数据到服务器
					local teams={};
					for k, v in pairs(teamIds) do
						table.insert(teams,TeamMgr:GetTeamData(v));
					end
					table.insert(teams, teamData);
					TeamMgr:SaveDatas(teams);
					if hasMainLeader and TeamMgr.currentIndex~=1 then
						Tips.ShowTips(LanguageMgr:GetTips(14037));
					end
					EventMgr.Dispatch(EventType.Team_Preset_Open, nil);
				end
			});
		else
			if hasMainLeader and TeamMgr.currentIndex~=1 then
				Tips.ShowTips(LanguageMgr:GetTips(14037));
			end
			TeamMgr:UpdateDataByIndex(TeamMgr.currentIndex, teamData:GetData());
			--保存到服务器
			TeamMgr:SaveData(teamData);
			EventMgr.Dispatch(EventType.Team_Preset_Open, nil);
		end
	end
end

function UseByPractice() --军演队伍不需要检测是否与副本队伍冲突
	local presetData = TeamMgr:GetTeamData(eTeamType.Preset + data);
	if presetData ~= nil then
		local teamData = TeamData.New();
		teamData:SetData(presetData:GetData());
		local currentData = TeamMgr:GetTeamData(TeamMgr.currentIndex);
		if currentData ~= nil then
			teamData:SetTeamName(currentData:GetTeamName() or "");
			teamData.index = currentData.index;
		else
			teamData:SetTeamName("");
			teamData.index = TeamMgr.currentIndex;
		end
		teamData.skill_group_id=teamData.skillGroupID;
		TeamMgr:UpdateDataByIndex(TeamMgr.currentIndex, teamData:GetData());
		--保存到服务器
		TeamMgr:SaveData(teamData);
		EventMgr.Dispatch(EventType.Team_Preset_Open, nil);
	end
end

function UseByCheckAssist() -- 检测同一队伍类型是否存在队伍角色冲突
	local presetData = TeamMgr:GetTeamData(eTeamType.Preset + data);
	if presetData ~= nil then
		local teamData = TeamMgr:GetEditTeam(TeamMgr.currentIndex)
		teamData:SetData(presetData:GetData())
		teamData.index = TeamMgr.currentIndex;
		teamData.skill_group_id=teamData.skillGroupID;
		TeamMgr:SaveEditTeam()
		EventMgr.Dispatch(EventType.Team_Preset_Open, nil);
	end
end

function UseByVirCat()
	local presetData = TeamMgr:GetTeamData(eTeamType.Preset + data);
	if presetData ~= nil then
		local teamData = TeamMgr:GetEditTeam(TeamMgr.currentIndex)
		teamData:SetData(presetData:GetData())
		teamData.index = TeamMgr.currentIndex;
		teamData.skill_group_id=teamData.skillGroupID;
		local removeIDs = {}
		for k, v in ipairs(teamData.data) do
			if not VirCatMgr:IsCardShow(v:GetID()) then
				table.insert(removeIDs,v:GetID())
			end
		end
		if #removeIDs > 0 then
			for i, v in ipairs(removeIDs) do
				teamData:RemoveCard(v)
			end
		end
		TeamMgr:SaveEditTeam()
		EventMgr.Dispatch(EventType.Team_Preset_Open, nil);
	end
end

function OnClickOpen()
	if data - 1 <= TeamMgr.presetNum then
		local cfg=Cfgs.ItemInfo:GetByID(g_FormationPriceList[1]);
		local content = string.format(LanguageMgr:GetTips(14019), cfg.name.."X"..g_FormationPriceList[2]);
		local dialogdata = {}
		dialogdata.content = content
		dialogdata.okCallBack = function()
			if CSAPI.IsADVRegional(3) then
				CSAPI.ADVJPTitle(g_FormationPriceList[2],function() PlayerProto:BuyTeam(); end)
			else
				PlayerProto:BuyTeam();
			end
		end
		CSAPI.OpenView("Dialog", dialogdata)
	else
		Tips.ShowTips(LanguageMgr:GetTips(14018));
	end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
lockObj=nil;
btn_open=nil;
moneyObj=nil;
mIcon=nil;
txt_price=nil;
addObj=nil;
inp_teamName=nil;
renameBtn=nil;
renameImg=nil;
cardObj=nil;
btnObj=nil;
view=nil;
end
----#End#----