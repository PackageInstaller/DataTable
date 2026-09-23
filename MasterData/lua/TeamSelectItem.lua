--队伍选择子物体
local teamData=nil;
local input=nil;--输入栏
local teamGrids={};
local eventMgr=nil;
local canEmpty=true;--是否可以为空
local elseData=nil;
local isFight=false;
local maxSize={780,252};
local minSize={710,235};
local maxPadding=10;--选中后的间隔距离
local minPadding=18;--小格子的间隔
local maxScale=1;
local minScale=0.9;
local maxStarX=-300;
local minStarX=-280;
local gridWidth=142;
local isSelect=false
local tweens=nil;

function Awake()
    tweens=ComUtil.GetComs(enterTween,"ActionBase");
    eventMgr = ViewEvent.New();
    -- eventMgr:AddListener(EventType.Team_EditIndex_Change, OnIndexChange);
end

function OnDestroy()
    eventMgr:ClearListener();
end

--刷新 _data:index
function Refresh(_data,_elseData)
    -- if _data==TeamMgr.currentIndex then
    --     teamData=TeamMgr:GetEditTeam();
    -- else
        teamData=TeamMgr:GetTeamData(_data,true)
    -- end
    elseData=_elseData;
    if _elseData then
        canEmpty=_elseData.canEmpty;
    end
    isFight=TeamMgr:GetTeamIsFight(teamData.index);
    CSAPI.SetGOActive(fightMask,isFight)
    local index = teamData:GetIndex()
    if(teamData:GetTeamType()==eTeamType.PVP or teamData:GetTeamType()==eTeamType.PVPFriend)then 
       index = index-teamData:GetTeamType()+1
    end
    CSAPI.SetText(txt_index,tostring(index))
    --设置队伍名
    CSAPI.SetText(txt_Name,teamData:GetTeamName()==nil and "" or tostring(teamData:GetTeamName()));
    -- SetSkillInfo();
    --设置队伍战力
    local haloStrength=teamData:GetHaloStrength();
    CSAPI.SetText(txt_fighting, tostring(teamData:GetTeamStrength()+haloStrength));
    SetSelect();
    RefreshGrids();
end

function RefreshGrids()
    --初始化队员格子
    for i = 1, 5, 1 do
        local teamItem=teamData:GetItemByIndex(i);
        if #teamGrids<i then
            ResUtil:CreateUIGOAsync("Team/TeamSelectGrid", node, function(go)
                local lua=ComUtil.GetLuaTable(go);
                lua.Refresh(teamItem,true)
                lua.ActiveClick(false)
                if isSelect then
                    CSAPI.SetScale(go,maxScale,maxScale,maxScale)
                end
                CountPos(go,i);
                table.insert(teamGrids,lua);
            end)
        else
            teamGrids[i].Refresh(teamItem,true)
            teamGrids[i].ActiveClick(false)
            local go=teamGrids[i].gameObject;
            if isSelect then
                CSAPI.SetScale(go,maxScale,maxScale,maxScale)
            else
                CSAPI.SetScale(go,minScale,minScale,minScale)
            end
            CountPos(go,i);
        end
    end
end

function CountPos(go,index)
    local sP=isSelect==true and maxStarX or minStarX;
    local scale=isSelect==true and maxScale or minScale;
    local padding=isSelect==true and maxPadding or minPadding;
    local x=sP+(index-1)*(gridWidth*scale+padding);
    CSAPI.SetAnchor(go,x,0);
end

function SetSelect()
    isSelect=teamData:GetIndex()==TeamMgr.currentIndex;
    CSAPI.SetGOActive(selectTween,isSelect);
    CSAPI.SetGOActive(cancelTween,not isSelect);
    if isSelect then
        -- CSAPI.SetRTSize(root,maxSize[1],maxSize[2]);
        -- CSAPI.SetRTSize(gameObject,maxSize[1],maxSize[2]);
        -- CSAPI.SetGOActive(sBG,true)
        CSAPI.SetTextColor(txt_Name,0,0,0,255);
        CSAPI.SetTextColor(txt_fightingTips,0,0,0,255);
    else
        -- CSAPI.SetRTSize(root,minSize[1],minSize[2]);
        -- CSAPI.SetRTSize(gameObject,maxSize[1],minSize[2]);
        -- CSAPI.SetGOActive(sBG,false)
        CSAPI.SetTextColor(txt_Name,255,255,255,255);
        CSAPI.SetTextColor(txt_fightingTips,146,146,150,255);
    end
end


--当队伍切换时 teamIndex:当前选中的队伍索引
function OnIndexChange(teamIndex)
    if teamIndex==teamData:GetIndex() then
        teamData=TeamMgr:GetEditTeam();
    else
        teamData=TeamMgr:GetTeamData(teamData:GetIndex())
    end
    SetSelect();
    RefreshGrids();
end

function PlayEnter()
    CSAPI.SetGOActive(enterTween,true)
end

function SetEnterDelay(index)
    if tweens then
        local delay=index*100;
        for i=0,tweens.Length-1 do
            local now=i==0 and 150 or 0;
            tweens[i].delay=now+delay;
        end
    end
end

--点击自身
function OnClickSelf()
    -- TeamMgr.currentIndex=teamData:GetIndex();
    EventMgr.Dispatch(EventType.Team_EditIndex_Change,teamData:GetIndex())
end

--点击了编辑
-- function OnClickEdit()
--     -- EventMgr.Dispatch(EventType.Team_Edit_Change)
--     if isFight then
--         Tips.ShowTips(LanguageMgr:GetTips(14001));
--         return
--     end
--     EventMgr.Dispatch(EventType.TeamView_EditMode_Change,true);
-- end

-- --点击了清空
-- function OnClickClean()
--     if teamData and isFight then
-- 		Tips.ShowTips(LanguageMgr:GetTips(14001));
-- 		return;
-- 	end
--     local removeCid={};
-- 	for i=1,#teamData.data do
-- 		local item=teamData.data[i];
--         if (teamData:GetIndex()==1 or canEmpty~=true) and item:IsLeader()==false then--不能为空的队伍或者编队1会留下队长卡
--             table.insert(removeCid,item.cid);
-- 		elseif teamData:GetIndex()~=1 and canEmpty and item:IsForce()~=true and item:IsNPC()~=true then --不清空助战队员和强制上阵卡牌
-- 			table.insert(removeCid,item.cid);
-- 		end
-- 	end
-- 	local assistData=teamData:GetAssistData();
-- 	for k,v in ipairs(removeCid) do
-- 		if assistData and assistData.cid==v then
-- 			TeamMgr:RemoveAssistTeamIndex(v);
-- 		end
-- 		teamData:RemoveCard(v);
-- 	end
--     Refresh(teamData:GetIndex(),elseData);
--     EventMgr.Dispatch(EventType.Team_Data_Change)
--     EventMgr.Dispatch(EventType.TeamView_Refresh_Formation)
-- end

-- --点击了AI
-- function OnClickAI()
--     --打开设置AI界面
--     -- EventMgr.Dispatch(EventType.Team_Edit_Change)
--     if isFight then
--         Tips.ShowTips(LanguageMgr:GetTips(14001));
--         return
--     end
--     if teamData==nil or (teamData and teamData:GetRealCount()==0) then
--         Tips.ShowTips("请先上阵队员再设置");
--         return
--     end
--     CSAPI.OpenView("AIPrefabSetting",{teamData=teamData});
-- end

-- --点击了技能
-- function OnClickSkill()
--     --显示战术选择面板
--     if isFight then
--         Tips.ShowTips(LanguageMgr:GetTips(14001));
--         return
--     end
--     CSAPI.OpenView("TacticsView",{teamData=teamData,closeFunc=OnSkillChange});
-- end

-- --战术变更
-- function OnSkillChange(cfgId)
--     local isChange=teamData:GetSkillGroupID()~=cfgId;
--     if not isChange then
--         return;
--     end
--     cfgId=cfgId or 0;
-- 	if TeamMgr:GetTeamData():GetCount()>0 then
-- 		AbilityProto:SkillGroupUse(cfgId,TeamMgr.currentIndex,function(proto)
-- 			if teamData then
-- 				teamData:SetSkillGroupID(cfgId);
--                 EventMgr.Dispatch(EventType.Team_Data_Change)
-- 			end
--             SetSkillInfo();
-- 		end);
-- 	else
-- 		teamData:SetSkillGroupID(cfgId);
--         EventMgr.Dispatch(EventType.Team_Data_Change)
--         SetSkillInfo();
-- 	end
-- end

function OnClickFightMask()
    Tips.ShowTips(LanguageMgr:GetTips(14001));
end