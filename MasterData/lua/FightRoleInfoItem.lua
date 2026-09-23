local c_MinHeight=124;
local g_MinHeight=186;
local curHeight=0;
local minLines=3;
local lineTxtNum=15
local buffGrid=nil;
local skillGrid=nil;
local pList=nil;
local infoGrid=nil;
local iconColors = {"white", "green", "blue", "purple", "yellow", "red"};
local tweenCom=nil;

function Awake()
    pList=ComUtil.GetComsInChildren(points,"Image");
    tweenCom=ComUtil.GetCom(tween,"ActionFadeCurve");
end

function PlayTween(idx)
    if tweenCom then
        tweenCom.delay=(idx-1)*30;
        tweenCom:Play();
    end
end

function Refresh(data,type)
    if buffGrid then
        CSAPI.SetGOActive(buffGrid.gameObject,false);
    end
    if skillGrid then
        CSAPI.SetGOActive(skillGrid.gameObject,false);
    end
    if infoGrid then
        CSAPI.SetGOActive(infoGrid.gameObject,false);
    end
    CSAPI.SetGOActive(rangObj,false)
    CSAPI.SetGOActive(points,false);
    CSAPI.SetGOActive(img,false);
    local isSmiple=SettingMgr:GetValue(s_fight_simple_key)==SettingFightSimpleType.Open;
    if data then
        if type==1 then
            SetIsBuff(false);
            local cfg=data.cfg;
            if skillGrid then
                skillGrid.Refresh(cfg.id);
                CSAPI.SetGOActive(skillGrid.gameObject,true);
            else
                ResUtil:CreateUIGOAsync("Role/RoleInfoSkillItem1",gridNode,function(go)
                    skillGrid=ComUtil.GetLuaTable(go);
                    skillGrid.Refresh(cfg.id);
                    skillGrid.ActiveClick(false);
                    CSAPI.SetGOActive(skillGrid.gameObject,true);
                end);
            end
            local descCfg=Cfgs.CfgSkillDesc:GetByID(cfg.id);
            local resRange="effective_range_07";
            if(cfg and cfg.range_key) then
                local cfgRange = Cfgs.skill_range:GetByKey(cfg.range_key);
                resRange = cfgRange.skill_icon;
            end
            if descCfg then
                if descCfg.icon_bg_type then
                    local colorIndex = descCfg.icon_bg_type or 1;
                    local colorStr = "";
                    if(colorIndex and iconColors[colorIndex]) then
                        colorStr = "_" .. iconColors[colorIndex];
                    end
                    resRange = "UIs/Skill/" .. resRange .. colorStr .. ".png";
                    CSAPI.SetGOActive(rangObj,true)
		            CSAPI.LoadImg(rangImg, resRange, true, nil, true);
                end
                SetName(descCfg.name);
                if not isSmiple then
                    local desc, cfgs2 = StringUtil:SkillDescFormat(descCfg.desc);
                    SetDesc(desc);
                    if descCfg.desc1 then
                        local overDesc, overCfgs = StringUtil:SkillDescFormat(descCfg.desc1);
                        SetDesc2(overDesc);
                    else
                        SetDesc2();
                    end
                else
                    local desc, cfgs2 = StringUtil:SkillDescFormat(descCfg.desc2);
                    SetDesc(desc);
                    if descCfg.desc3 then
                        local overDesc, overCfgs = StringUtil:SkillDescFormat(descCfg.desc3);
                        SetDesc2(overDesc);
                    else
                        SetDesc2();
                    end
                end
            end
            SetRound();
            SetType(LanguageMgr:GetByID(cfg.type==5 and 28009 or 28008))
        elseif type==2 then--buff
            SetIsBuff(true);
            if buffGrid then
                CSAPI.SetGOActive(buffGrid.gameObject,true);
                buffGrid.Refresh(data);
            else
                ResUtil:CreateUIGOAsync("FightRoleInfo/FightBuffGrid",gridNode,function(go)
                    buffGrid=ComUtil.GetLuaTable(go); 
                    buffGrid.SetBorderHide();
                    buffGrid.Refresh(data);
                end);
            end
            local cfg=data:GetCfg();
            local exStr="";
            if data and data.data then
                if data:GetShowCount()~=nil and data:GetShowCount()>0 then
                    exStr=LanguageMgr:GetByID(26003,data:GetShowCount());
                end
                if data.data.round then
                    exStr=exStr..LanguageMgr:GetByID(26004,data.data.round);
                end
                if exStr~="" then
                    exStr="<color=#ffc428>("..exStr..")</color>"
                end
            end
            SetName(cfg.name..exStr);
            --SetName(cfg.name .. tostring(data:UID()));--显示UUID
            SetDesc(cfg.desc);
            SetRound(data.round);
            SetDesc2()
            SetType(LanguageMgr:GetByID(28003))
        elseif type==3 then --技能/天赋
            local cfg=data.cfg;
            SetIsBuff(false);
            SetInfoGrid(cfg.icon,"btn_1_01",cfg.lv, ResUtil.RoleTalent,1/0.6);
            -- ResUtil.RoleTalent:Load(icon,cfg.icon);
            SetName(cfg.name);
            local desc, cfgs2 = StringUtil:SkillDescFormat(isSmiple and cfg.desc1 or cfg.desc);
            SetDesc(desc);
            SetRound();
            SetDesc2()
            SetType(LanguageMgr:GetByID(28004))
        elseif type==4 then--装备技能
            SetIsBuff(false);
            CSAPI.SetGOActive(points,true);
            CSAPI.SetGOActive(img,true);
            local eSkillCfg=data[1];
            local curLv=0;
            if #data==1 then
                curLv=eSkillCfg.nLv;
                SetDesc(eSkillCfg.sShort);
            else
                curLv=(eSkillCfg.id%100)*3;
                local descCfg=Cfgs.CfgSkillDesc:GetByID(eSkillCfg.id);
                local desc, cfgs2 = StringUtil:SkillDescFormat(descCfg.desc);
                SetDesc(desc);
            end
            local iconName,borderName,lvStr="","",""
            borderName=eSkillCfg.nQuality and EquipQualityFrame[eSkillCfg.nQuality] or EquipQualityFrame[1];
            local eCfg=Cfgs.CfgEquipSkillTypeEnum:GetByID(eSkillCfg.group);
            if eCfg then
                if eCfg.icon then
                    iconName=eCfg.icon;
                    -- ResUtil.EquipSkillIcon:Load(icon,eCfg.icon);
                end
            else
                LogError("不存在类型为:"..eSkillCfg.group.."的装备技能类型！");
            end
            local cfgs=Cfgs.CfgEquipSkill:GetGroup(eSkillCfg.group);
            if cfgs then
                for i=0,pList.Length-1 do
                    local go=pList[i].gameObject;
                    CSAPI.SetGOActive(go,i+1<=#cfgs);
                    if i<=curLv-1 then
                        CSAPI.SetImgColor(go,255,170,0,255);
                    else
                        CSAPI.SetImgColor(go,112,112,112,255);
                    end
                end
                lvStr="<color=#FFC432>"..curLv.."</color>/"..#cfgs;
            else
                LogError("不存在类型为:"..eSkillCfg.group.."的装备技能类型！");
            end
            SetInfoGrid(iconName,borderName,lvStr,ResUtil.EquipSkillIcon,1,true);
            SetName(eSkillCfg.sSkillType);
            SetRound();
            SetDesc2()
            SetType(LanguageMgr:GetByID(28010))
        end
    end
    --暂时屏蔽
    CSAPI.SetGOActive(img,false)
end

function SetInfoGrid(iconName,borderName,lvStr,loader,scale,isBorderLoader)
    if infoGrid then
        CSAPI.SetGOActive(infoGrid.gameObject,true)
        infoGrid.Refresh(iconName,borderName,lvStr,loader,isBorderLoader);
        infoGrid.SetIconScale(scale);
    else
        ResUtil:CreateUIGOAsync("FightRoleInfo/FightInfoGrid",gridNode,function(go)
            infoGrid=ComUtil.GetLuaTable(go);
            infoGrid.Refresh(iconName,borderName,lvStr,loader,isBorderLoader);
            infoGrid.SetIconScale(scale);
        end);
    end
end

function SetIsBuff(isBuff)
    CSAPI.SetGOActive(bgNode,not isBuff);
    CSAPI.SetGOActive(buffLine,isBuff);
    CSAPI.SetGOActive(line,not isBuff);
    -- CSAPI.SetGOActive(txt_desc,isBuff);
    -- CSAPI.SetGOActive(layout,not isBuff);
end

function SetType(typeStr)
    CSAPI.SetGOActive(img,typeStr~=nil);
    CSAPI.SetText(txt_type,typeStr);
end

function SetDesc(desc)
    CSAPI.SetText(txt_desc,desc==nil and "" or desc);
    CSAPI.SetGOActive(layout,desc~=nil)
end

function SetDesc2(desc)
    CSAPI.SetGOActive(overloadObj,desc~=nil);
    CSAPI.SetText(txt_overload,desc);
end

function SetName(name)
    CSAPI.SetText(txt_name,name==nil and "" or name);
end

function SetRound(round)
    if round then
        CSAPI.SetText(txt_round,tostring(round));
        CSAPI.SetGOActive(txt_round,true);
    else
        CSAPI.SetGOActive(txt_round,false);
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
bgNode=nil;
gridNode=nil;
icon=nil;
txt_name=nil;
points=nil;
txt_round=nil;
lvObj=nil;
txt_lvTips=nil;
txt_lv=nil;
txt_buffDesc=nil;
img=nil;
txt_type=nil;
buffLine=nil;
layout=nil;
txt_desc=nil;
overloadObj=nil;
overLine=nil;
verlayout=nil;
txt_overload=nil;
line=nil;
view=nil;
end
----#End#----