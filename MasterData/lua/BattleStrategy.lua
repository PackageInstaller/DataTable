--自动战斗策略
local targets={};
local spRadios={};
local sliders={};
local colors={{0,0,0,255},{146,146,150,255}}
local colors2={{146,146,150,255},{255,193,70,255}}
local colors3={{255,255,255,255},{255,193,70,255}}
local teamMax=2;
local source=nil;
local config=nil;
function Awake()
    targets[1]={onObj=onImg1,txt=txtRadio1,point=onPoint1}
    targets[2]={onObj=onImg2,txt=txtRadio2,point=onPoint2}
    targets[3]={onObj=onImg3,txt=txtRadio3,point=onPoint3}
    spRadios[1]={onObj=switchOn1,offObj=switchOff1,low=txtSwitchOff1,height=txtSwitchOn1}
    spRadios[2]={onObj=switchOn2,offObj=switchOff2,low=txtSwitchOff2,height=txtSwitchOn2}
    CSAPI.SetGOActive(Target,false);
end

function OnInit()
    topTools=UIUtil:AddTop2("BattleStrategy",gameObject,Close,nil,{});
 end

function OnOpen()
    if data then
        teamMax=data.teamMax;
    end
    source=TeamMgr:LoadStrategyConfig();
    config=table.copy(source);
    Refresh();
end

function Refresh()
    CreateItems();
    CSAPI.SetGOActive(team2,teamMax>1);
    for k,v in ipairs(spRadios) do
        local cKey=string.format("team%sSP",k);
        SetTeamRadioState(v,config[cKey]);
    end
    for k,v in ipairs(targets) do
        SetTargetRadioState(v,k==config["target"])
    end
end

function CreateItems()
    for i=1,teamMax do
        ResUtil:CreateUIGOAsync("BattleAISetting/NPSliderItem",layout2,function(go)
            local lua=ComUtil.GetLuaTable(go);
            local key=string.format("team%sNP",i);
            lua.Refresh({index=i,val=config[key]});
            table.insert(sliders,lua);
        end)
    end
end

function OnClickTeam(go)
    local name=go.name==team1.name and 1 or 2;
    local cKey=string.format("team%sSP",name);
    config[cKey]=not config[cKey]
    SetTeamRadioState(spRadios[name],config[cKey]);
end

function SetTeamRadioState(tab,isOn)
    CSAPI.SetGOActive(tab.onObj,isOn);
    CSAPI.SetGOActive(tab.offObj,not isOn);
    local c=isOn and colors[1] or colors[2]
    local c2=isOn and colors[2] or colors[1]
    CSAPI.SetTextColor(tab.low,c2[1],c2[2],c2[3],c2[4]);
    CSAPI.SetTextColor(tab.height,c[1],c[2],c[3],c[4]);
end

function OnClickTarget(go)
    local type=nil;
    if go==btnRadio1 then
        type=1;
    elseif go==btnRadio2 then
        type=2
    else
        type=3
    end
    if type~=config.target then
        config.target=type;
    end
    for k,v in ipairs(targets) do
        SetTargetRadioState(v,k==config.target);
    end
end

function SetTargetRadioState(tab,isOn)
    local idx=isOn and 2 or 1
    CSAPI.SetGOActive(tab.point,isOn);
    CSAPI.SetImgColor(tab.onObj,colors3[idx][1],colors3[idx][2],colors3[idx][3],colors3[idx][4],true);
    CSAPI.SetTextColor(tab.txt,colors2[idx][1],colors2[idx][2],colors2[idx][3],colors2[idx][4]);
end

function OnClickOK()
    config.team1NP=sliders[1].GetVal();
    if teamMax>1 then
        config.team2NP=sliders[2].GetVal();
    end
    local isChange=false;
    for k,v in pairs(source) do
        if config[k]~=v then
            isChange=true;
            break;
        end
    end
    if data and data.isBattle and isChange then
        OnSetStrategyComm();
    elseif isChange then
        TeamMgr:SaveStrategyConfig(config);
    end
    Close();
end

--当玩家修改了战斗中的AI通用设置时
function OnSetStrategyComm()
    if config==nil then
        return;
    end
	local characters=BattleMgr:GetMineTeams();
    local aiDatas={};
	if characters then
		for k,v in ipairs(characters) do
            local character=BattleCharacterMgr:GetCharacter(v.oid);
			if character then
                local index=character:GetTeamNO();
                local d={
                    oid=v.oid,
                    bIsReserveSP=config[string.format("team%sSP",index)],
                    nReserveNP=config[string.format("team%sNP",index)],
                    -- nFocusFire=config.target,--没有这个选项
                    nFocusFire=nil,
                }
                table.insert(aiDatas,d);
			end
        end
	end
    FightProto:SendSetSkillAI(1,aiDatas);--发送修改协议
end

function Close()
    view:Close();
end