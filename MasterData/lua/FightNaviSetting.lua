 
local team1={{title='道中战斗',id=1,group=FightNaviObjType.Team1,isOn=true},{title='BOSS战斗',id=2,group=FightNaviObjType.Team1},{title='全部战斗',id=3,group=FightNaviObjType.Team1},{title='战斗待机',id=4,group=FightNaviObjType.Team1}}
local team2={{title='道中战斗',id=1,group=FightNaviObjType.Team2},{title='BOSS战斗',id=2,group=FightNaviObjType.Team2,isOn=true},{title='全部战斗',id=3,group=FightNaviObjType.Team2},{title='战斗待机',id=4,group=FightNaviObjType.Team2}}
local attack={{title='优先敌兵',id=1,group=FightNaviObjType.Attack,isOn=true},{title='优先boss',id=2,group=FightNaviObjType.Attack}}
local get={{title='宝箱',id=1,group=FightNaviObjType.Get,isOn=true},{title='增益道具',id=2,group=FightNaviObjType.Get,isOn=true}}
local itemList={};
local config={};
local sConfig=nil;--缓存的配置数据
function OnOpen()
    --读取本地配置
    LoadConfig();
    --初始化控件状态
    if openSetting~=1 then --只有有两支队伍的时候才显示队伍选项
        CreateItems(team1,teamOption1,nil,FightNaviObjType.Team1)
        CreateItems(team2,teamOption2,nil,FightNaviObjType.Team2)
        CSAPI.SetGOActive(center,true);
    else
        CSAPI.SetGOActive(center,false);
    end
    CreateItems(attack,attackOption,nil,FightNaviObjType.Attack)
    CreateItems(get,getOption,true,FightNaviObjType.Get)
end

function SetItemState(id,isOn,group,isMult)
    if itemList[group] then
        if isMult then
            config[group]={};
        end
        for k,v in ipairs(itemList[group]) do
            if isMult then
                if v.GetID()==id then
                    if isOn then
                        table.insert(config[group],id);
                    end
                    v.SetState(isOn);
                elseif v.GetState() then
                    table.insert(config[group],v.GetID());
                end
            else
                if v.GetID()==id then
                    config[group]={id}
                    v.SetState(isOn);
                else
                    v.SetState(false);
                end
            end
        end
    end
end

function CreateItems(list,parent,isMult,key)
    for k,v in ipairs(list) do
        ResUtil:CreateUIGOAsync("TeamConfirm/FightNaviItem",parent,function(go)
            local lua=ComUtil.GetLuaTable(go);
            itemList[v.group]=itemList[v.group] or {}; 
            lua.Set(v.id,v.title,v.isOn,v.group,isMult,OnClickNaviItem)
            if v.isOn then
                config[key]=config[key] or {};
                table.insert(config[key],v.id);
            elseif key~=FightNaviObjType.Team1 and key~=FightNaviObjType.Team2 then
                config[key]=config[key] or {};
                table.insert(config[key],"");
            end
            table.insert(itemList[v.group],lua);
        end);
    end
end

function OnClickNaviItem(lua,id,group,isMult)
    local isOn=lua.GetState();
    if isMult then --多选
        isOn=not isOn;
        SetItemState(id,isOn,group,isMult);
    else
        if group==FightNaviObjType.Team1 or group==FightNaviObjType.Team2 then
            if id==1 or id==2 then
                SetItemState(id,true,group,false);
                SetItemState(id==1 and 2 or 1,true,group==FightNaviObjType.Team1 and FightNaviObjType.Team2 or FightNaviObjType.Team1,isMult);
            else
                SetItemState(id,true,group,false);
                SetItemState(id==3 and 4 or 3,true,group==FightNaviObjType.Team1 and FightNaviObjType.Team2 or FightNaviObjType.Team1,isMult);
            end
        else
            SetItemState(id,true,group,false);
        end
    end
end

function Close()
    -- Log(config)
    DungeonMgr:SaveNaviConfig(config);
    view:Close();
end

function OnClickOK()
    Close();
end

function OnClickMask()
    Close();
end

--设置数据源中选中的状态
function SetDataState(list,ids,isMult)
    for k,v in ipairs(list) do
        if isMult then
            local has=false;
            for _,val in ipairs(ids) do
                if v.id==val then
                    has=true;
                    break
                end
            end
            v.isOn=has;
        else
            for _,val in ipairs(ids) do
                -- Log(tostring(k).."\t"..tostring(v.id).."\t"..tostring(val))
                if v.id==val then
                    v.isOn=true;
                else
                    v.isOn=false;
                end
            end
        end
    end
end

--读取当前选择的队伍id
function LoadConfig()
    sConfig=DungeonMgr:LoadNaviConfig();
    if sConfig then
        -- Log(sConfig);
        for k,v in pairs(sConfig) do
            if k==FightNaviObjType.Team1 then
                SetDataState(team1,{v[1]})
            elseif k==FightNaviObjType.Team2 then
                SetDataState(team2,{v[1]})
            elseif k==FightNaviObjType.Attack then
                SetDataState(attack,v)
            else
                SetDataState(get,v,true)
            end
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
root=nil;
txt_title=nil;
txt_titleTips=nil;
center=nil;
txt_team1=nil;
teamOption1=nil;
txt_team2=nil;
teamOption2=nil;
bottom=nil;
txt_attack=nil;
attackOption=nil;
txt_get=nil;
getOption=nil;
txt_tips=nil;
btnOK=nil;
txt_battle=nil;
txt_battleTips=nil;
view=nil;
end
----#End#----