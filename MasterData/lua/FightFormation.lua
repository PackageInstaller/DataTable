--战前界面
local formation = nil;    --阵型盘
local dropList = nil; --掉落格子列表
local taskItems = nil;    --目标集合
local gridList = nil; --队员格子集合
local isAuto = false;-- 自动战斗

local moveData = nil;
local tmpId = nil;
local monsterCfg = nil;
local fightTeamInfo = nil;--战斗中的队伍各个卡牌的信息
local supportItem = nil;
local lineHight=68;
local layout=nil;
local dungeonCfg=nil;

function Awake()
	gridList = {};
	for i = 1, 5 do
		local item = CreateTeamGrid(bottomGrid.transform);
		item.SetIndex(i);
		table.insert(gridList, item);
	end
	supportItem = CreateTeamGrid(supportGo.transform);
	supportItem.SetIndex(6);
	layout=ComUtil.GetCom(sv,"UICircularScrollView")
	layout:Init(LayoutCallBack)
	SetText();
end

function OnInit()
	UIUtil:AddTop2("FightFormation", gameObject, OnClickReturn)
	--UIUtil:AddTop(gameObject, OnClickBack)

end

function OnOpen()
	PlayAction(true);
	if data then
		moveData = data.moveData;
		tmpId = data.tmpId;
		monsterCfg = data.cfg;
		local character = BattleCharacterMgr:GetCharacter(moveData.oid);
		fightTeamInfo = character.GetData();
		-- DungeonMgr:SetFightTeamId(fightTeamInfo.nTeamID);--设置战斗队伍ID
	end
	-- isAuto = FightClient:IsAutoFight()==1;
	isAuto = FightClient:IsAutoFight();
	SetToggleState(isAuto);
	Init();
end

--初始化多语言
function SetText()
end

--初始化
function Init()
	dungeonCfg=Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId());
	InitFormation();
	InitFightTask();
	InitRewardPrev();
	if dungeonCfg.nGroupID~=nil and dungeonCfg.nGroupID~="" then
		CSAPI.SetText(text_hotTips,"+0");
	else
		CSAPI.SetText(text_hotTips,"+"..dungeonCfg.costHot);
	end
end

function CreateTeamGrid(parent)
	local go = ResUtil:CreateUIGO("Common/BattleTeamGrid", parent);
	local item = ComUtil.GetLuaTable(go);
	item.Refresh();
	item.SetClickCB(OnClickGrid);
	return item;
end

--初始化阵容信息
function InitFormation()
	for k, v in ipairs(gridList) do
		v.Refresh();
	end
	supportItem.Refresh();
	local teamData = TeamMgr:GetFightTeamData(fightTeamInfo.nTeamID);
	-- LogTable(teamData);
	if formation == nil then
		local go = ResUtil:CreateUIGO("Formation/FormationView", childNode.transform);
		formation = ComUtil.GetLuaTable(go);
		formation.SetScale(0.65);
		formation.SetLocalPos(-350,-80);
	end
	formation.Init(teamData, true, function(item, cid)
		local hp = GetCardHP(cid,FriendMgr:IsAssist(cid));
		item.SetDamage(hp <= 0);
	end);
	if teamData then
		local index = 1;
		for _, v in ipairs(teamData.data) do
			local hp = 0;
			local totalHp=0;
			local grid=nil;
			if FriendMgr:IsAssist(v.cid) then
				grid=supportItem;
				hp = GetCardHP(v.cid, true);
				totalHp=v:GetCard():GetTotalProperty()["maxhp"] or 0;
				grid.SetHP(hp / totalHp);
			else
				if v.index~=nil then
					grid=gridList[v.index];
				else
					grid=gridList[index];
				end
				hp = GetCardHP(v.cid,false);
				if v.bIsNpc then
					grid.SetHP(hp / v:GetCfg().maxhp);
				else
					local card=v:GetCard();
					totalHp=card:GetTotalProperty()["maxhp"] or 0;
					grid.SetHP(hp / totalHp);
				end
				index=index+1;
			end
			grid.Refresh(v);
			if v.bIsNpc==false and v.fuid==nil then
				local card=v:GetCard();
				local hot=card:GetCurDataByKey("hot");
				grid.SetHot(card:GetHot()/hot);  
				grid.SetClick(true);
			elseif v.fuid~=nil then
				grid.SetClick(true);
			else
				grid.SetClick(false);
			end
		end
	end
end

--初始化奖励预览
function InitRewardPrev()
	curDatas={};
	--获取当前怪物是普通、精英还是boss
	local cfg=nil;
	if monsterCfg.type==1 then
		--普通
		cfg=dungeonCfg.mRewardPrev;
	elseif monsterCfg.type==2 then
		--精英
		cfg=dungeonCfg.rRewardPrev;
	elseif monsterCfg.type==3 then
		--boss
		cfg=dungeonCfg.bRewardPrev;
	end
	for k,v in ipairs(cfg) do
		local goodsData=GoodsData();
		goodsData:InitCfg(v);
		table.insert(curDatas,goodsData);
	end
	layout:IEShowList(#curDatas)
end

function LayoutCallBack(element)
	local index = tonumber(element.name) + 1
	local _data = curDatas[index]
    ItemUtil.AddCircularItems(element, "Grid/GridItem", _data,{isClick=true},GridClickFunc.OpenInfo ,0.6)
end

function InitFightTask()
	for i=1,3 do
		ResUtil:CreateUIGOAsync("FightTaskItem/FightTaskItem",taskParent,function(go)
			taskItems=taskItem or {};
			local item=ComUtil.GetLuaTable(go);
			local strs = StringUtil:split(LanguageMgr:GetByID(1093), ",") or {}
			item.Init(strs[i],true);
			CSAPI.SetAnchor(go,0+15*(i-1),0-lineHight*(i-1));
			table.insert(taskItems,item);
		end);
	end
	--初始化特殊通关条件
	CSAPI.SetText(txt_pass,"特殊通关条件: "..DungeonMgr:GetPassDesc());
end

--自动战斗
function OnClickToggle()
	isAuto = not isAuto;
	SetToggleState(isAuto);
end

function SetToggleState(isAuto)
	local pos={22.86,0};
    local pos2={-25.29,0};
    local txt="开启";
    if isAuto then
		CSAPI.SetGOActive(switchImg,true);
		CSAPI.SetGOActive(switchImg2,false);
		CSAPI.SetLocalPos(txt_switch,pos2[1],pos2[2],0);
		CSAPI.SetTextColor(txt_switch,204,246,0,255);
    else  
		txt="关闭";
		CSAPI.SetGOActive(switchImg,false);
		CSAPI.SetGOActive(switchImg2,true);
		CSAPI.SetLocalPos(txt_switch,pos[1],pos[2],0);
		CSAPI.SetTextColor(txt_switch,144,144,144,255);
    end
    CSAPI.SetText(txt_switch,txt);
end

--返回卡牌的HP
function GetCardHP(cid,isAssist)
	if cid and fightTeamInfo then
		local strs=StringUtil:split(tostring(cid),"_");
		cid=strs[2]==nil and cid or tonumber(strs[2]);
		local fuid=strs[1]==nil and nil or tonumber(strs[1]);
		for k, v in ipairs(fightTeamInfo.team) do
			if isAssist and v.cid==cid and v.fuid==fuid then
				return v.hp;
			elseif v.cid == cid and isAssist==false then
				return v.hp;
			end
		end
	end
	return 0;
end

--出击按钮
function OnClickAttack()
	--Log("是否自动:" .. tostring(isAuto));
	FightClient:Clean();
	FightClient:SetAutoFight(isAuto);
	local teamData = TeamMgr:GetFightTeamData(fightTeamInfo.nTeamID);
	DungeonMgr:SetFightMonsterGroup(data.cfg);--设置战斗中的怪物组配置数据
	local index = BattleMgr:GetDungeonIndex();
	--改动的位置信息
	local posInfo=GetChangePosData();
	local proto = {index = index, myOID = moveData.oid, monsterOID = tmpId,posData=posInfo};	
	FuncUtil:Call(FightProto.EnterFight, FightProto, 1500, proto);	
	DungeonMgr:ClearDragList();		
	--CSAPI.ApplyAction(BattleMgr.ground.GetCamera(), "action_radia_blur");  
end

--返回改动的位置数据
function GetChangePosData()
	local dragItems=DungeonMgr:GetDragList();
	local posInfo=formation.GetDragList();
	local tempList=nil;
	if dragItems~=nil then
		for k,v in pairs(dragItems) do
			local item=nil;
			if posInfo~=nil and posInfo[k]==nil then
				item= posInfo[k];
			else
				item=v;
			end
			tempList=tempList or {};
			table.insert(tempList,item);
		end
	elseif posInfo~=nil then
		for k,v in pairs(posInfo) do
			tempList=tempList or {};
			table.insert(tempList,v);
		end
	end
	local list=nil;
	if tempList then
		list={};
		for k,v in ipairs(tempList) do
			local item=nil;
			if FriendMgr:IsAssist(v.cid) then
				--助战卡牌
				local cid=FormationUtil.GetAssitCID(v.cid);
				local card=FormationUtil.FindTeamCard(v.cid);
				item={
					fuid=card:GetAssistData().uid,
					row=v.row,
					col=v.col,
					cid=cid,
				};
			else
				item={
					row=v.row,
					col=v.col,
					cid=v.cid,
				};
			end
			table.insert(list,item);
		end
	end
	return list;
end

function OnClickBack()
	-- view:Close();
	DungeonMgr:SetDragList(formation:GetDragList());
	PlayAction(false,function()
		view:Close();
	end);
end

-- function OnClickHome()
-- 	DungeonMgr:SetDragList(formation:GetDragList());
-- 	EventMgr.Dispatch(EventType.Scene_Load, "MajorCity");
-- end

function OnClickGrid(item)
	if item and item.sourceData then
		if item == supportItem then
			--助战格子
			-- Log( "点击了助战格子");
			local assist=FormationUtil.FindTeamCard(item.sourceData.cid);
			if assist~=nil then
				CSAPI.OpenView("RoleInfo", assist)
			end
		else
			local card=item.sourceData:GetCard();
			if card~=nil then
				CSAPI.OpenView("RoleInfo", card)
			end
		end
	end
end 

function PlayAction(isShow,func)
	local list={}
	if isShow==true then
		list={
			{go=topBg,pos={-182.93,234.14,0}},
			{go=right,pos={0,0,0}},
			{go=bottom,pos={-198.46,-302.4,0},func=func}
		}
	else
		list={
			{go=topBg,pos={-1200,234.14,0}},
			{go=right,pos={1100,0,0}},
			{go=bottom,pos={-1200,-302.4,0},func=func}
		}
	end
	UIUtil:PlayMoveList(list);
end 