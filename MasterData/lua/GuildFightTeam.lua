--公会战编队UI
local gridClicks={};
local grids={};
local teamData=nil;
local gridsPos={{70,0,0},{210,0,0},{335,0,0},{460,0,0},{585,0,0}}
function Awake()
    for i=1,5 do
        ResUtil:CreateUIGOAsync("TeamConfirm/TeamConfirmGrid",items,function(go)
            local lua=ComUtil.GetLuaTable(go);
            lua.Refresh(nil);
            lua.SetPos(gridsPos[i]);
            lua.SetCB(OnClickRoleItem);
            table.insert(grids,lua);
        end);
    end
end

function OnOpen()
    SetTeamData()
    Refresh()
end

function SetTeamData()
    TeamMgr.currentIndex=eTeamType.GuildFight;
    if teamData then
        TeamMgr:DelEditTeam(eTeamType.GuildFight);
    end
    teamData=TeamMgr:GetEditTeam();
end


function Refresh()
    if teamData then
        RefreshTeamGrids();
        --初始化指挥官战术
        SetSkillIcon(teamData:GetSkillGroupID());
    end
end

function RefreshTeamGrids()
    for i=1,g_TeamMemberMaxNum do
        local grid=grids[i];
        local item=nil;
        if teamData then
           item=teamData:GetItemByIndex(i);
        end
        -- CSAPI.SetGOActive(grid.gameObject,item~=nil);
        if item then
            grid.Refresh(item);
        end
    end
end

-- 点击队员格子
function OnClickRoleItem(tab) 
    CSAPI.OpenView("TeamView",{team=teamData,canEmpty=false,closeFuncOnChange,selectType=TeamSelectType.Normal,is2D=true},TeamOpenSetting.PVP);
end

--变更队员
function OnChange(data)
    --保存修改
    TeamMgr:SaveEditTeam();
    SetTeamData(teamData.index);
    Refresh();
end

function SetSkillIcon(cfgId)
    if cfgId~=0 then
        CSAPI.SetGOActive(txt_noSkillTips,false);
        CSAPI.SetGOActive(txt_skill,true);
        CSAPI.SetGOActive(skillIcon,true);
        local tactice=TacticsMgr:GetDataByID(cfgId);
        ResUtil.Ability:Load(skillIcon,tactice:GetIcon());
        CSAPI.SetScale(skillIcon,0.35,0.35,0.35);
        local lvStr = LanguageMgr:GetByID(1033) or "LV."
        CSAPI.SetText(txt_skill,string.format("%s  <color=\'#ffc146\'>%s%s</color>",tactice:GetName(),lvStr,tactice:GetLv()));
    else
        CSAPI.SetGOActive(txt_noSkillTips,true);
        CSAPI.SetGOActive(txt_skill,false);
        CSAPI.SetGOActive(skillIcon,false);
    end
end


function OnCloseFormation()
    SetTeamData(teamData.index);
    Refresh();
end

function OnClickSkill()
    CSAPI.OpenView("TacticsView",{teamData=teamData,closeFunc=OnSkillChange});
end

--战术变更
function OnSkillChange(cfgId)
    AbilityProto:SkillGroupUse(cfgId,teamData.index,function(proto)
        if teamData then
            teamData:SetSkillGroupID(cfgId);
            isChange=true;
        end
        SetSkillIcon(cfgId);
    end);
end



function OnClickEdit()

end

function OnClickClose()
    view:Close();
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
txt_title=nil;
items=nil;
btnSkill=nil;
txt_skill=nil;
skillIcon=nil;
txt_noSkillTips=nil;
view=nil;
end
----#End#----