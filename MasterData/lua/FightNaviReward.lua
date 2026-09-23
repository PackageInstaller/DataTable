--自动战斗汇总奖励

local layout=nil;

function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Popup/RewardItem",LayoutCallBack,true);
end

function OnOpen()
    local rewards= DungeonMgr:GetAIFightRewards();
    if rewards and #rewards>0 then
        CSAPI.SetGOActive(vsv,true);
        CSAPI.SetGOActive(txt_none,false);
        ShowReward(rewards);
    else
        CSAPI.SetGOActive(vsv,false);
        CSAPI.SetGOActive(txt_none,true);
    end
end

function LayoutCallBack(index)
    local lua=layout:GetItemLua(index);
	if index < 27 then			
        lua.SetDelay((index - 1) * 50 + 400)
    else
        lua.SetDelay(- 1)
    end
    if curDatas[index] then
        lua.Refresh(curDatas[index])
    else
        lua.Refresh()
    end
end

--再次开始
function OnClickAgain()
    local info=DungeonMgr:GetAutoDungeonInfo();
    if info then
        --进入战斗
        EnterDungeon(info.id,info.teams);
    end
end

function EnterDungeon(id,teams)
    if id==nil or teams==nil or(teams and #teams<=0) then
        LogError("再次开始战斗数据有误！");
        LogError("再次战斗目标关卡："..tostring(id));
        LogError("再次战斗所选队伍：");
        LogError(teams);
        return
    end
    local dungeonCfg=Cfgs.MainLine:GetByID(id)
    local enterCost=dungeonCfg and dungeonCfg.enterCostHot or 0;
    local coolState=0;
    local choosieID={};
    for k,v in ipairs(teams) do
        local teamData=TeamMgr:GetTeamData(v.nTeamIndex);
        if HasCoolCard(teamData,enterCost) then
            coolState=1;
            break;
        elseif CheckCoolIng(teamData) then
            coolState=2;
            break;
        end
        table.insert(choosieID,v.nTeamIndex);
    end
    if coolState==1 then -- 需要冷却
        local dialogdata = {}
        dialogdata.content = LanguageMgr:GetTips(14033)
        dialogdata.okCallBack = function()
            JumpMgr:Jump(50001)
            view:Close();
        end
        CSAPI.OpenView("Dialog", dialogdata)
        return;
    elseif coolState==2 then --正在冷却中 
        local dialogdata = {}
        dialogdata.content = LanguageMgr:GetTips(5000) --StringTips.cool_tips4
        dialogdata.okCallBack = function()
            JumpMgr:Jump(50001)
            view:Close();
        end
        CSAPI.OpenView("Dialog", dialogdata)
        return;
    end
    if  id and teams then
         --进入战斗！！
         BattleMgr:SetLastCtrlId(nil);
         for k,v in ipairs(choosieID) do --用于处理单机模式下获取不到战斗中队伍数据的情况
             TeamMgr.currentIndex=v;
             local teamData=TeamMgr:GetEditTeam();
             TeamMgr:AddFightTeamData(teamData);
             UIUtil:AddFightTeamState(1,"FightNaviReward:EnterDungeon()")
         end
         DungeonMgr:ApplyEnter(id, choosieID, teams);
    end
end

function HasCoolCard(teamData,cost)
    local hasCool = false
    cost=cost or 1;
    if teamData then
        for k, v in ipairs(teamData.data) do
            local card = FormationUtil.FindTeamCard(v.cid)
            if v.bIsNpc==false and card:GetHot() < cost  and v:IsAssist()~=true then
                hasCool = true
                break
            end
        end
    end
    return hasCool;
end

--是否正在冷却中
function CheckCoolIng(teamData)
    local CoolIng = false;
	-- if teamData then
	-- 	for k, v in ipairs(teamData.data) do
	-- 		if(CoolMgr:CheckIsIn(v.cid)) then 
	-- 			CoolIng = true
	-- 			break
	-- 		end 
	-- 	end
	-- end
	return CoolIng
end

function OnDisable()
    DungeonMgr:ClearAIFightInfo();
end

--取消
function OnClickCancel()
    view:Close();
end

--显示掉落奖励 优先检查是否有卡牌，有卡牌的情况下先打开卡牌展示界面
function ShowReward(data)
	-- LogError("奖励数据：")
	-- LogError(data)
	if data and #data > 0 then
		local showList = {};
		for k, v in ipairs(data[1]) do --data[1]是奖励数据
			if v.type == RandRewardType.CARD then
				local card = RoleMgr:GetData(v.c_id);
				if card == nil then
					LogError("未获得卡牌数据：" .. v.c_id);
				elseif card:GetQuantity() < 2 then
					table.insert(showList, {sid = v.c_id, num = card:GetQuantity()});
				elseif card:GetQuality() == CardQuality.SSR or card:GetQuality() == CardQuality.SR then
					table.insert(showList, {sid = v.c_id, num = card:GetQuantity()});
				end
			elseif v.type == RandRewardType.ITEM then
				local cfg = Cfgs.ItemInfo:GetByID(v.id);
				if cfg.type == ITEM_TYPE.CARD and v.c_id then
					local card = RoleMgr:GetData(v.c_id);
					if card == nil then
						LogError("未获得卡牌数据：" .. v.c_id);
					elseif card:GetQuantity() < 2 then
						table.insert(showList, {sid = v.c_id, num = card:GetQuantity()});
					elseif card:GetQuality() == CardQuality.SSR or card:GetQuality() == CardQuality.SR then
						table.insert(showList, {sid = v.c_id, num = card:GetQuantity()});
					end
				end
			end
		end
		if showList and #showList >= 1 then
			CSAPI.OpenView("CreateShowView", {showList}, 2, function(go)
				local lua = ComUtil.GetLuaTable(go);
                lua.SetShowRewardPanel(function ()
                    curDatas=data;
                    layout:IEShowList(#curDatas);
                end)
			end);
		else
			curDatas=data;
            layout:IEShowList(#curDatas);
		end
	end
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
bg=nil;
txt_title=nil;
txt_titleTips=nil;
vsv=nil;
txt_none=nil;
btnCancel=nil;
txt_cancel=nil;
txt_cancelTips=nil;
btnAgain=nil;
txt_again=nil;
txt_againTips=nil;
txt_tips=nil;
view=nil;
end
----#End#----