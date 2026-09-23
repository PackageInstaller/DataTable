--公会战编队界面

local teamData=nil;
local skillGrids={};
local is3D=true;
local addAttrs=nil;
local clickID=nil;
local recordTime=0;
local leaderGrid=nil;
local outputItems={};
local enemyItems={}
local taskItem=nil;
-- local forceData=nil;--强制位移的数据

function Awake()
    ResUtil:CreateUIGOAsync("RoleCard/RoleLittleCard",gridNode,function(go)
        leaderGrid=ComUtil.GetLuaTable(go);
        leaderGrid.ActiveClick(false);
    end);
    InitListener()
end

function OnEnable()
    recordTime=CSAPI.GetRealTime();
end

function InitListener()
	eventMgr = ViewEvent.New();
    -- eventMgr:AddListener(EventType.Team_Preset_Open, OnOpenPreset);
    eventMgr:AddListener(EventType.Team_FormationView_Select,OnHaloChange);
    eventMgr:AddListener(EventType.Team_Item_Change,RefreshOFightVal);
    -- eventMgr:AddListener(EventType.Team_FormationView_ForceMove,OnCharacterForceMove);
end


function OnDisable()
    teamEditView=nil;
    teamDetail=nil;
    RecordMgr:Save(RecordMode.View,recordTime,"ui_id="..RecordViews.TeamEdit);
end

function OnDestroy()
   eventMgr:ClearListener();
   SaveData();
   TeamMgr:DelEditTeam();
   ReleaseCSComRefs();
end

function OnInit()
    UIUtil:AddTop2("GuildFightTeamEdit", gameObject, OnClickReturn)
    --UIUtil:AddTop(gameObject, OnClickReturn,nil,true)
end

function OnOpen()
    TeamMgr.currentIndex=eTeamType.GuildFight;
    if teamData then
        TeamMgr:DelEditTeam(eTeamType.GuildFight);
    end
    --生成作战目标
    ResUtil:CreateUIGOAsync("FightTaskItem/FightBigTaskItem",taskObj,function(go)
        CSAPI.SetAnchor(go,0,0,0);
        taskItem=ComUtil.GetLuaTable(go);
        taskItem.Init(LanguageMgr:GetByID(27029),true);
    end);
    --生成奖励预览、敌兵介绍
    CreateOutputInfo();
    CreateEnemyInfo();
    --获取进场消耗
    if data then
        local costCfg=data:GetJoinCost();
        if costCfg then
            if costCfg[1] == ITEM_ID.GOLD then --钻石
                ResUtil.IconGoods:Load(priceIcon, tostring(ITEM_ID.GOLD));
            elseif costCfg[1] == ITEM_ID.DIAMOND then --金币
                ResUtil.IconGoods:Load(priceIcon, tostring(ITEM_ID.DIAMOND));
            elseif costCfg[1]== -1 then --人民币
                CSAPI.LoadImg(priceIcon,"UIs/Shop/yuan.png",true,nil,true)
            else
                local cfg = Cfgs.ItemInfo:GetByID(costCfg[1]);
                if cfg and cfg.icon then
                    ResUtil.IconGoods:Load(priceIcon, cfg.icon);
                end
            end
            CSAPI.SetRectSize(priceIcon, 25, 25);
            CSAPI.SetText(txt_price,tostring(costCfg[2]));
        end
    end
    Refresh();
end

function Refresh()
    teamData=TeamMgr:GetEditTeam();
    RefreshOFightVal();
    local leader=teamData:GetLeader();
    CSAPI.SetGOActive(rangObj,false);
    if leader==nil then
        CSAPI.SetGOActive(infos,false);
        CSAPI.SetGOActive(leaderGrid.gameObject,false)
    else
        CSAPI.SetGOActive(infos,true);
        CSAPI.SetGOActive(leaderGrid.gameObject,true)
        leaderGrid.Refresh(leader:GetCard());
        leaderGrid.ActiveClick(false);
    end
    --初始化阵型子物体
    if formationView==nil then
        CreateFormationView();
    else
        formationView.CleanCard();
        formationView.Init(teamData,true);
        if forceData then
            formationView.SetForceMove(forceData.forceData,forceData.forceCallBack,forceData.forceCaller);
        else
            formationView.SetForceMove(nil,nil,nil);
        end
        formationView.SetHaloEnable(true);
    end
	--初始化技能组
    InitSkillObj(teamData:GetSkillGroupID());
    if clickID~=nil then
        local hasClick=teamData:GetItem(clickID);
        ShowHaloAdd(hasClick~=nil)
    end
end

function OnClickReturn()
    view:Close()
end

--切换视图
function OnClickViewType()
    is3D=not is3D;
    CSAPI.SetGOActive(onObj,is3D);
    CSAPI.SetGOActive(offObj,not is3D);
    --切换显示的阵型图
    if formationView then
        formationView:CleanCard();
        formationView.view:Close();
        formationView=nil;
    end
    CreateFormationView();
end

--编成预设
function OnClickPreset()
    SaveLocal();
    if teamPreset == nil then
        ResUtil:CreateUIGOAsync("FormatPreset/TeamPreset", gameObject,function(go)
            teamPreset = ComUtil.GetLuaTable(go);
        end);
	else
		CSAPI.SetGOActive(teamPreset.gameObject, true);
	end
end

--是否有改动
function GetIsChange()
	if (formationView and formationView.GetIsChange()==true) or isChange then
		return true;
	end
	return false;
end

function SaveLocal()
    if GetIsChange() then --有变更时先保存变更到本地
        TeamMgr:SaveDataByIndex(teamData.index, teamData);
        TeamMgr:DelEditTeam(TeamMgr.currentIndex);
        teamData=TeamMgr:GetEditTeam();
    end
end

--编辑队伍
function OnClickEdit()
    if TeamMgr:GetTeamIsFight(teamData.index) then
        Tips.ShowTips(LanguageMgr:GetTips(14001));
        return
    end
    local index=teamData:GetCount();
    local cid=nil;
    if teamData then
       local item=teamData:GetItemByIndex(index);
       if item then
        cid=item:GetID();
       end
    end
    local canEmpty=false;
    if data then
        canEmpty=data.canEmpty==true and true or false;
    else
        canEmpty=TeamMgr.currentIndex~=1;
    end
    SaveLocal();
    if formationView then
        formationView:CleanCard();
        formationView.view:Close();
        formationView=nil;
    end
    CSAPI.OpenView("TeamView",{team=teamData,index=index,cid=cid,canEmpty=canEmpty,closeFunc=OnChangeOver,selectType=TeamSelectType.Normal,is2D=true},TeamOpenSetting.PVP);
end

--变更完毕
function OnChangeOver()
    TeamMgr:SaveEditTeam(function()
        isChange=false;
        -- clickID=nil;
        Refresh();
	end);
end

function SaveData()
    if  GetIsChange() then
        TeamMgr:SaveEditTeam();
    else
        TeamMgr:DelEditTeam(TeamMgr.currentIndex);
    end
end
 

--出击
function OnClickFight()
    if data then
        GuildFightMgr:SetCurrFightRoomID(data:GetID());
        GuildProto:GFJoinRoom(data:GetID(),data:GetIndex());
    end
end

--更换队长
function OnClickLeader()
    sLeaderInfo={};
    local idx=1;
    CSAPI.SetGOActive(selectLeaderObj,true);
    if teamData then
        for k,v in ipairs(teamData.data) do
            if not teamData:IsLeader(v.cid) then
                local bgRes = FormationUtil.bgIcons[v:GetQuality()];
                ResUtil.CardBG:Load(this["lIconObj"..idx],bgRes,true);
                CSAPI.SetGOActive(this["lIconObj"..idx],true);
                local modelID=v:GetModelID();
                local modeCfg=Cfgs.character:GetByID(modelID);
                ResUtil.Card:Load(this["lIcon"..idx],modeCfg.List_head);
                table.insert(sLeaderInfo,v);
                idx=idx+1;
            end
        end
    end
    for i=idx,4 do
        CSAPI.SetGOActive(this["lIconObj"..i],false);
    end
    if idx~=1 then
        local width=(idx-1)*87.3+(52)+(idx-2)*17.2;
        CSAPI.SetRTSize(sbg,width,124.86);
        UIUtil:DoLocalMove(sbg, {width,0,0});
    end
end

function OnClickLIcon(go)
    if sLeaderInfo then
        for i=1,4 do
            if "lIconObj"..i==go.name then
                teamData:SetLeader(sLeaderInfo[i].cid);
                isChange=true
                Refresh();
                break;
            end
        end
    end
    OnClicklMask();
end

function OnClicklMask()
    UIUtil:DoLocalMove(sbg, {0,0,0},function()
        CSAPI.SetGOActive(selectLeaderObj,false);
    end);
end

--显示卡牌受到加成的光环和光环加成
function OnHaloChange(eventData)
    if formationView then
        if eventData.cid==nil then
            return
        elseif clickID==eventData.cid and not eventData.isDrag then --点击相同角色取消
            clickID=nil;
            ShowHaloAdd(false);
        else
            clickID=eventData.cid
            ShowHaloAdd(true);
        end
        formationView.RefreshGrids();
    end
end

--显示卡牌的光环加成信息
function ShowHaloAdd(isShow)
    CSAPI.SetGOActive(txt_adds,isShow);
    CSAPI.SetGOActive(txt_none,not isShow);
	if isShow then
        addAttrs=addAttrs or {};
        local item=teamData:GetItem(clickID);
        if item then
            local curHalo = item:GetHaloInfo();
            local adds = HaloUtil.CountHaloAddtion(curHalo, item:GetCard(), nil, nil, nil, nil);
            if adds~=nil and next(adds)~=nil then
                local strs={};
                for k,v in ipairs(adds) do
                    table.insert(strs,v.cfg.sName);
                    table.insert(strs,"<color=\"#17ff79\">+")
                    table.insert(strs,tostring(v.addtive));
                    table.insert(strs,"</color>");
                    if k<#adds then
                        table.insert(strs,"\n");
                    end
                end
                CSAPI.SetText(txt_adds,table.concat(strs));
                local item=teamData:GetItem(clickID);
                ResUtil.RoleSkillGrid:Load(rangImg, item:GetCfg().gridsIcon)
                CSAPI.SetGOActive(rangObj,true);
            else
                CSAPI.SetGOActive(txt_adds,false);
                CSAPI.SetText(txt_none,LanguageMgr:GetByID(26002));
                CSAPI.SetGOActive(txt_none,true);
                CSAPI.SetGOActive(rangObj,false);
            end
        end
    else
        CSAPI.SetText(txt_none,LanguageMgr:GetByID(26001));
        CSAPI.SetGOActive(rangObj,false);
	end
end

--刷新光环站位
function RefreshOFightVal()
    if teamData then
        local haloStrength=teamData:GetHaloStrength();
        CSAPI.SetText(txt_fightingVal, tostring(teamData:GetTeamStrength()+haloStrength));
    end
end

function CreateFormationView()
    local path=is3D and "Formation/FormationView" or "Formation/FormationView2D";
    ResUtil:CreateUIGOAsync(path,childNode,function(go)
        formationView=ComUtil.GetLuaTable(go);
        if is3D then
            formationView.SetScale(1);
            formationView.SetLocalPos(62.86,-77.84);
        end
        if forceData then
            formationView.SetForceMove(forceData.forceData,forceData.forceCallBack,forceData.forceCaller);
        else
            formationView.SetForceMove(nil,nil,nil);
        end
        formationView.Init(teamData,true);
        -- formationView.SetForceMove({{row=1,col=3,cfgId=71020}},OnForceMove);
        formationView.SetHaloEnable(true);
        if clickID then
            formationView.OnClickFGrid({cid=clickID});
        end
    end);
end

-----------------------------------------战术相关----------------------------------

--点击战术物体
function OnClickSkill()
    --显示战术选择面板
    if TeamMgr:GetTeamIsFight(teamData.index) then
        Tips.ShowTips(LanguageMgr:GetTips(14001));
        return
    end
    CSAPI.SetGOActive(hideObj,false);
    -- CSAPI.SetGOActive(mask,true);
    -- CSAPI.SetGOActive(viewNode,true);
    CSAPI.OpenView("TacticsView",{teamData=teamData,closeFunc=OnSkillChange});
end 

--战术变更
function OnSkillChange(cfgId)
    AbilityProto:SkillGroupUse(cfgId,TeamMgr.currentIndex,function(proto)
        if teamData then
            teamData:SetSkillGroupID(cfgId);
            isChange=true;
        end
        InitSkillObj(cfgId);
    end);
    CSAPI.SetGOActive(hideObj,true);
    -- CSAPI.SetGOActive(mask,false);
    -- CSAPI.SetGOActive(viewNode,false);
    Refresh();
end

function InitSkillObj(cfgId)
    if cfgId~=0 then
        CSAPI.SetGOActive(txt_noSkillTips,false);
        CSAPI.SetGOActive(skillNameObj,true);
        CSAPI.SetGOActive(skillIcon,true);
        local tactice=TacticsMgr:GetDataByID(cfgId);
        ResUtil.Ability:Load(skillIcon,tactice:GetIcon());
        CSAPI.SetScale(skillIcon,0.35,0.35,0.35);
        local lvStr = LanguageMgr:GetByID(1033) or "LV."
        CSAPI.SetText(txt_skill,string.format("%s  <color=\'#ffc146\'>%s%s</color>",tactice:GetName(),lvStr,tactice:GetLv()));
    else
        CSAPI.SetGOActive(txt_noSkillTips,true);
        CSAPI.SetGOActive(skillNameObj,false);
        CSAPI.SetGOActive(skillIcon,false);
    end
end



-----关卡情报查看

function OnClickEnemy()
    if data then
        local list={};
        local lv=data:GetPreviewLv()
        for k,v in ipairs(data:GetEnemyPreview()) do
            local cfg=Cfgs.CardData:GetByID(v);
            table.insert(list,{cfg=cfg,level=lv,isBoss=k==1});
        end
        ShowDetails(list,DungeonDetailsType.Enemy);
    end
end

function OnClickOutput()
    ShowDetails(data:GetItemPreview(),DungeonDetailsType.OutPut);
end

function ShowDetails(_data,_elseData)
    if detailView==nil then
        local go=ResUtil:CreateUIGOAsync("DungeonDetail/DungeonDetail",gameObject,function(go)
            detailView=ComUtil.GetLuaTable(go);
            detailView.Show(_data,_elseData);
        end)
    else
        detailView.Show(_data,_elseData);
    end
end

function CreateEnemyInfo()
    local enemyPre=data:GetEnemyPreview()
    if enemyPre then
        local preList={};
        local lv=data:GetPreviewLv()
        for i=1,3 do
            if i<=#enemyPre then
                local cfg=Cfgs.CardData:GetByID(enemyPre[i]);
                table.insert(preList,{cfg=cfg,level=lv,isBoss=i==1});
            end
        end
        ItemUtil.AddItems("DungeonDetail/DungeonEnemyItem", enemyITems, preList, enemyNode, nil, 0.75)
    end
end

function CreateOutputInfo()
    local itemPre=data:GetItemPreview()
    if itemPre then
        local preList={};
        for i=1,3 do
            if i<=#itemPre then
                local goodsData=GoodsData();
                goodsData:InitCfg(itemPre[i]);
                table.insert(preList,goodsData);
            end
        end
        ItemUtil.AddItems("Grid/GridItem", outputItems, preList, goodsNode, GridClickFunc.OpenInfoSmiple, 0.75)
    end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
viewNode=nil;
top=nil;
infos=nil;
txt_fighting=nil;
txt_fightingVal=nil;
btnEdit=nil;
txt_edit=nil;
skillObj=nil;
skillNameObj=nil;
txt_skill=nil;
txt_skillLv=nil;
skillIcon=nil;
txt_noSkillTips=nil;
childNode=nil;
leftObj=nil;
haloObj=nil;
txt_none=nil;
rangObj=nil;
rangImg=nil;
txt_adds=nil;
leaderObj=nil;
gridNode=nil;
add=nil;
selectLeaderObj=nil;
sbg=nil;
lIconObj1=nil;
lIcon1=nil;
lIconObj2=nil;
lIcon2=nil;
lIconObj3=nil;
lIcon3=nil;
lIconObj4=nil;
lIcon4=nil;
viewType=nil;
onObj=nil;
offObj=nil;
txt_target=nil;
taskObj=nil;
outputObj=nil;
goodsNode=nil;
enemyObj=nil;
enemyNode=nil;
costObj=nil;
txt_costTips=nil;
priceIcon=nil;
txt_price=nil;
mask=nil;
view=nil;
end
----#End#----