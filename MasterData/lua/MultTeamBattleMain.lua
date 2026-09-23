local top=nil;
local eventMgr=nil;
local activityData=nil;
local itemInfo=nil;
local isActive=false;
local timer=0
local curTime=0;
local fixedTime=1;
local items={};
local sectionData=nil;--章节数据
local curList = {};
local aDelayTime=130;
local curDungeon=nil;
local isSelLayout=false;
local currDungeonCfg=nil;
local lastState=nil;
function Awake()
    top=UIUtil:AddTop2("MultTeamBattleMain",gameObject,OnClickClose);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.MTB_Click_Dungeon,OnClickItem);
    eventMgr:AddListener(EventType.MTB_Click_Reward,OnClickReward)
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
    eventMgr:AddListener(EventType.Bag_Update,OnBagUpdate)
end

function OnDestroy()
    eventMgr:ClearListener();
 end

 --data:{id=sectionID}
function OnOpen()
    activityData=MultTeamBattleMgr:GetCurData(); 
    if data and data.id then
        sectionData=DungeonMgr:GetSectionData(data.id);
    end
    -- if activityData then--检查并置空已出战过的队员
    --     local teamData=TeamMgr:GetEditTeam(eTeamType.MultBattle);
    --     if teamData and teamData:GetRealCount()>0 then
    --         local ids={};
    --         for k, v in ipairs(teamData.data) do
    --             if activityData:CardCanUse(v:GetID())~=true then
    --                 table.insert(ids,v:GetID());
    --             end
    --         end
    --         if #ids>0 then
    --             for k, v in ipairs(ids) do
    --                 teamData:RemoveCard(v);
    --             end
    --             -- LogError("删除队员："..table.tostring(ids))
    --             TeamMgr:SaveEditTeam();
    --         end
    --     end
    -- end
    SetRedInfo();
    Refresh()
end

function Refresh()
    if activityData then
        CSAPI.SetText(txtRound,LanguageMgr:GetByID(77005,activityData:GetRound()));
        SetTime();
        InitItems();
        SetCost();
        CSAPI.SetGOActive(leftBottom,activityData:GetActivityState()~=MultTeamActivityState.Settlement);
    end
end

function SetTime()
    --处于结算期内显示结算剩余时间，否则显示活动剩余时间
    local time=TimeUtil:GetTime();
    local lID=77003;
    if activityData:GetActivityState()==MultTeamActivityState.Open or activityData:GetActivityState()==MultTeamActivityState.Over then
        timer=activityData:GetSettlementTime()-time;
        lID=77002;
        lastState=1
    else
        timer=activityData:GetEndTime()-time;
        if lastState==1 then
            lastState=2;
            Refresh();
            do return end
        end
    end
    local tab = TimeUtil:GetTimeTab(timer)
    LanguageMgr:SetText(txtTime,lID,tab[1],tab[2],tab[3])
    if timer<=0 then
        HandlerOver()
    end
end

-- 活动结束
function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(24001));
    end, nil, 100);
end

function SetLayout()
    if activityData:GetActivityState()==MultTeamActivityState.Settlement and isSelLayout~=true then --结算期，屏蔽内容
        CSAPI.SetGOActive(btnEnter,false);
        ShowInfo();
        isSelLayout=true;
    end
end

function InitItems()
    -- 获取关卡信息并生成子物体
    if sectionData then
        curList={};
        local list = sectionData:GetDungeonCfgs();
        if list then -- 筛选当前周目的数据
            for k, v in ipairs(list) do
                if v.stage == activityData:GetRound() then
                    table.insert(curList, v);
                end
            end
        end
        for i=1,5 do  --每一轮固定5个
            if #curList>=i then
                if #items>i then
                    CSAPI.SetGOActive(items[i].gameObject,true);
                    items[i].Refresh(curList[i]);
                else
                    local go =ResUtil:CreateUIGO("MultTeamBattle/MultTeamBattleItem",this["p"..i].transform);
                    local lua=ComUtil.GetLuaTable(go)
                    lua.Refresh(curList[i],aDelayTime*i);
                    table.insert(items,lua)
                end
            elseif #items>=i then
                CSAPI.SetGOActive(items[i].gameObject,false);
            end
        end
    end
end

function SetCost()
    local goods=activityData:GetEnterGoods();
    if goods then
        goods:GetIconLoader():Load(goodsIcon,goods:GetIcon().."_1");
        CSAPI.SetText(txtGoodsName,goods:GetName()..":");
        CSAPI.SetText(txtGoodsNum,tostring(goods:GetCount()));
    end
end

--排行榜
function OnClickRank()
    UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end

--结算奖励
function OnClickGiveUp()
    CSAPI.OpenView("MultTeamRewardInfo");
end

function OnClickShop()
    if activityData then
        activityData:OpenShop();
    end
end

function OnClickShop2()
    if activityData then
        local jumpId=activityData:GetJumpId();
        if jumpId then
            JumpMgr:Jump(jumpId);
        end
    end
end

--限制信息
function OnClickBuff()
    CSAPI.OpenView("MultTeamLimitInfo");
end

--获取入场券
function OnClickEnter()
    if activityData then
        CSAPI.OpenView("MissionActivity",{type=eTaskType.MultTeam,title=LanguageMgr:GetByID(77030),group=activityData:GetMissionGroup()});
    end
end

function OnClickClose()
    view:Close();
end

function Update()
    if timer>0 then 
        curTime=curTime+Time.deltaTime;
        if curTime>=fixedTime then
            curTime=0;
            SetTime();
        end
    end
end

function OnBagUpdate()
    SetCost();
end

-----------------------------------------------关卡信息-----------------------------------------------
-- 关卡信息 cfg:dungeonCfg
function ShowInfo(cfg)
    isActive = cfg ~= nil;
    currDungeonCfg=cfg;
    CSAPI.SetGOActive(mask, isActive)
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("MultTeamBattle/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.Show(cfg, DungeonInfoType.MultTeamBattle, OnLoadCallBack)
        end)
    else
        itemInfo.Show(cfg, DungeonInfoType.MultTeamBattle, OnLoadCallBack)
    end
end

function OnLoadCallBack()
    itemInfo.SetFunc("Button7", "OnClickEnter", OnBattleEnter)
    itemInfo.SetFunc("Button7", "OnClickDirll", OnClickDirll)
    local name=""
    if currDungeonCfg and currDungeonCfg.enemyPreview then
        local mCfg = Cfgs.MonsterData:GetByID(currDungeonCfg.enemyPreview[1]);
        if mCfg then
            name=mCfg.name;
        end
    end
    itemInfo.CallFunc("Title","SetName",name)
    SetInfoItemPos()
end

function SetInfoItemPos()
    if itemInfo then
        itemInfo.SetPanelPos("Title", -35, 418)
        itemInfo.SetPanelPos("BossState", 12,265)
        itemInfo.SetPanelPos("Point", -12, 66)
        itemInfo.SetPanelPos("Details", -14, -138)
        itemInfo.SetPanelPos("Button7", 0, -364)
    end
end

function OnClickItem(eventData)
    --已击败或者结算期，都无法点击
    if activityData and eventData then
        local isKill=activityData:IsPass(eventData.id);
        if isKill or activityData:GetActivityState()==MultTeamActivityState.Settlement then
            curDungeon=nil;
            do return end;
        end
    end
    curDungeon=eventData;
    ShowInfo(eventData);
end

function OnClickMask()
    ShowInfo();
end

--进入战斗
function OnBattleEnter()
    if sectionData and not sectionData:GetOpenInfo():IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    CleanTeam()
    local cfg = curDungeon
    if cfg then
        local cost = DungeonUtil.GetCost(cfg)
        if cost then
            local cur = BagMgr:GetCount(cost[1])
            if cur < cost[2] then
                LanguageMgr:ShowTips(51001)
                do
                    return
                end
            end
        end
        if cfg.arrForceTeam ~= nil then -- 强制上阵编队
            CSAPI.OpenView("TeamForceConfirm", {
                dungeonId = cfg.id,
                teamNum = cfg.teamNum or 1 ,
                disChoosie=true,
                -- isNotAssist=true,
            })
        else
            CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                dungeonId = cfg.id,
                teamNum = cfg.teamNum or 1 ,
                disChoosie=true,
                -- isNotAssist=true,
            }, TeamConfirmOpenType.MultTeamBattle)
        end
    end
end

function CleanTeam()
    -- 清理队员
    local teamData = TeamMgr:GetEditTeam(eTeamType.MultBattle);
    teamData:ClearCard();
    TeamMgr:SaveEditTeam();
end


--扫荡
function OnClickDirll()
    if sectionData and not sectionData:GetOpenInfo():IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    CleanTeam()
    local cfg = curDungeon
    if cfg then
        if cfg.arrForceTeam ~= nil then -- 强制上阵编队
            CSAPI.OpenView("TeamForceConfirm", {
                dungeonId = cfg.id,
                teamNum = cfg.teamNum or 1 ,
                disChoosie=true,
                isDirll=true,
                -- isNotAssist=true,
                overCB = OnFightOverCB
            })
        else
            CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                dungeonId = cfg.id,
                teamNum = cfg.teamNum or 1 ,
                disChoosie=true,
                -- isNotAssist=true,
                isDirll=true,
                overCB = OnFightOverCB
            }, TeamConfirmOpenType.MultTeamBattle)
        end
    end
end

--模拟战斗结束
function OnFightOverCB(stage, winer,nTotalDamage,proto)
    -- DungeonMgr:SetCurrId1(cfg.id)
    FightOverTool.OnMultTeamBattleOver(proto,nil,true)
    --清理掉模拟队伍数据
    local teamData=TeamMgr:GetEditTeam(eTeamType.MultBattle);
    if teamData and teamData:GetRealCount()>0 then
        for k, v in ipairs(teamData.data) do
            teamData:RemoveCard(v.cid)
        end
        TeamMgr:SaveEditTeam()
    end
end

--结算
function OnClickReward()
    if activityData and activityData:GetActivityState()==MultTeamActivityState.Settlement then
        FightProto:GetSettleReward(activityData:GetID());
    end
end

function SetRedInfo()
    local redInfo=RedPointMgr:GetData(RedPointType.MultTeamBattle);
    UIUtil:SetRedPoint(btnGiveUp,redInfo and redInfo.hasReward or false,40,50);
    UIUtil:SetRedPoint(btnEnter,redInfo and redInfo.isTask or false,80,20);
end