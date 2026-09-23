--关卡敌人信息界面
local MonsterInfo=require "MonsterInfo"
local curDatas=nil;
local lastIndex=1;--选中物体的下标
local tabItems={};--tab物体
local listItems={};--物体
local type=1;--面板下标 1技能，2天赋
local layout=nil;
local btnList=nil;--按钮列表
local charInfos={};--战斗信息分组 1技能，2天赋
local tabScroll=nil;
local tabRect=nil;
local tabScrollRect=nil;
local starY=-45
local normalY=123;
local selectY=152;
local paddingX=70
local lineHeight=20;
local leftPosInfo=nil;
local rightPosInfo=nil;
local tags={};
local btnTweens=nil;
local cTween=nil;
local infoScroll=nil;
local infoScrollImg=nil;
function Awake()
    btnList={btn_skill,btn_talent};
    btnTweens={skillTween,talentTween}
    tabScroll=ComUtil.GetCom(sv,"ScrollRect");
    infoScroll=ComUtil.GetCom(isv,"ScrollRect");
    infoScrollImg=ComUtil.GetCom(isv,"Image");
    tabScrollRect=ComUtil.GetCom(sv,"RectTransform");
    tabRect=ComUtil.GetCom(tabContent,"RectTransform");
    cTween=ComUtil.GetCom(contentTween,"ActionUILayoutSpace");
    UIUtil:AddTop2("FightEnemyInfo",gameObject,function()
        view:Close();
    end,nil,{})
end

function OnClickClose()
    view:Close();
end

--- func data table {id,level,isBoss} id:Cfg.MonsterData.id
function OnOpen()
    CSAPI.PlayUISound("ui_popup_open")
    curDatas={};
    SetData();
    RefreshTabs();
    SetInfo(curDatas[lastIndex].monster);
    SetItemStyle(type);
    if cTween then
        cTween:Play();
    end
end

function SetData()
    if data then
        for index,item in ipairs(data) do
            local cardData = MonsterInfo.New();
            cardData:Init(item.id);	
            table.insert(curDatas,{monster=cardData,isBoss=item.isBoss,isDead = item.isDead});
            lastIndex = item.isSel and index or lastIndex
        end
    end
end

function SetItemStyle(index)
    for k, v in ipairs(btnTweens) do
        CSAPI.SetGOActive(v,index==k);
    end
    -- for k,v in ipairs(btnList) do
    --     if index==k then
    --         CSAPI.SetImgColor(v,255,196,38,255);
    --         CSAPI.SetTextColor(v,255,196,38,255,true);
    --     else
    --         CSAPI.SetImgColor(v,255,255,255,255);
    --         CSAPI.SetTextColor(v,255,255,255,255,true);
    --     end
    -- end
end

--点击页面标签
function OnClickTab(go)
    local lastType=type;
    for k,v in ipairs(btnList) do
        if go==v then
            type=k;
            break;
        end
    end
    SetItemStyle(type);
    if lastType~=type then
        if curDatas then
            SetInfo(curDatas[lastIndex].monster);
        end
        if cTween then
            cTween:Play();
        end
    end
end

function RefreshTabs()
    local y=starY;
    local posY=0;
    local sizeY=math.abs(starY);
    for k,v in ipairs(curDatas) do
        ResUtil:CreateUIGOAsync("FightRoleInfo/FightRoleTag",tabContent,function(go)
            local item=ComUtil.GetLuaTable(go);
            item.SetIndex(k);
            item.Refresh({
                icon=v.monster:GetIcon(),
                isEnemy=true,
                isBoss=v.isBoss,
                isDead = v.isDead
            },lastIndex);
            y=k==1 and y or y-item.GetLineHeight()-normalY;
            sizeY=sizeY+normalY+item.GetLineHeight();
            if lastIndex==k-1 then 
                y=y-(selectY-normalY)/2;
                sizeY=sizeY+(selectY-normalY)/2;
            end
            CSAPI.SetAnchor(go,paddingX,y);
            item.SetClickCB(OnClickItem);
            table.insert(tabItems,item);
        end)
        if lastIndex==k then
            posY=lastIndex==1 and math.abs(y) or math.abs(y)+normalY;
        end
    end
    sizeY=sizeY+normalY;
    CSAPI.SetRTSize(tabContent,0,sizeY);
    local percent=0;
    if lastIndex==1 then
        percent=1;
    elseif lastIndex<#curDatas then
        percent=1-posY/sizeY;
    end
    tabScroll.normalizedPosition=UnityEngine.Vector2(1,percent);
end

function Update()
    CSAPI.SetGOActive(arrow1,tabRect.anchoredPosition.y>0);
    CSAPI.SetGOActive(arrow2,math.ceil(tabRect.anchoredPosition.y)<math.ceil(tabRect.sizeDelta.y - tabScrollRect.rect.height));
end

--显示卡牌信息
function SetInfo(monster)
    if monster==nil then
        LogError("未获取到卡牌数据！");
        return;
    end
    --显示立绘
    local cfgModel=monster:GetCfgModel();
    ResUtil.FightCard:Load(roleImg,cfgModel.Fight_head);
    --显示卡牌名称
    CSAPI.SetText(txt_name,monster:GetName());
    CSAPI.SetText(txt_lv,tostring(monster:GetLv()));
    -- local pos, scale, imgName = RoleTool.GetImgPosScale(cfgModel.id, LoadImgType.RoleInfo);
	-- if(pos) then
    --     ResUtil.ImgCharacter:Load(roleImg, imgName,function()
    --         -- local realPos=gameObject.transform:TransformPoint(UnityEngine.Vector3(pos.x, pos.y));
    --         -- CSAPI.SetPos(roleImg,realPos.x,realPos.y,gameObject.transform.position.z);
    --         -- ResUtil.ImgCharacter:SetScale(roleImg, scale)
    --         CSAPI.SetAnchor(charImg,pos.x,pos.y-200);
    --         ResUtil.ImgCharacter:SetScale(charImg, scale)
    --     end);
    -- end
    -- ResUtil.FightCard:Load(roleImg,cfgModel.card_icon1);
    --显示护甲类型
    local career=monster:GetCareer();
    CSAPI.SetText(txt_armor,career==2 and LanguageMgr:GetByID(1029) or LanguageMgr:GetByID(1028));
    local iconName = career == 1 and "img_12_02" or "img_12_01"
    CSAPI.LoadImg(armorIcon,string.format("UIs/FightRoleInfo/%s.png",iconName),true,nil,true)
    --显示说明
    local desc=monster:GetDesc();
    CSAPI.SetText(txt_desc,desc);
    FuncUtil:Call(function()
        local txtSize=CSAPI.GetRealRTSize(iContent);
        infoScroll.normalizedPosition=UnityEngine.Vector2(1,1);
        infoScrollImg.raycastTarget=txtSize[1]>308;
    end,nil,10)
    SetMonsterInfos(monster);
    for k,v in ipairs(btnList) do
        if charInfos[k]~=nil and #charInfos[k]>=1 then
            CSAPI.SetGOActive(v,true);
        else
            CSAPI.SetGOActive(v,false);
        end
    end
    RefreshList(charInfos[type]);
    RefreshTags(monster)
end

function RefreshTags(monster)
    local list={};
    local race=monster:GetRace()
    local styleType=monster:GetStyleType()
    local bodyType=monster:GetBodyType()
    if race~=nil then
        local cfg=Cfgs.CfgRaceEnum:GetByID(race)
        if cfg~=nil then
            table.insert(list,cfg.sName);
        end
    end
    if styleType~=nil then
        local cfg=Cfgs.CfgMonsterEnum:GetByID(styleType)
        if cfg~=nil then
            table.insert(list,cfg.sName);
        end
    end
    if bodyType~=nil then
        local cfg=Cfgs.CfgBodyEnum:GetByID(bodyType)
        if cfg~=nil then
            table.insert(list,cfg.sName);
        end
    end
    for i=1,3 do
        CSAPI.SetGOActive(this["mType"..i],i<=#list)
        if i<=#list then
            CSAPI.SetText(this["txt_mType"..i],list[i]);
        end
    end
end

function RefreshList(list)
    for k,v in ipairs(listItems) do
        CSAPI.SetGOActive(v.gameObject,false);
    end
    if list then
        local realY=0;
        for k,v in ipairs(list) do
            local t=type==1 and 1 or 3;
            if k<=#listItems then
                CSAPI.SetGOActive(listItems[k].gameObject,true);
                listItems[k].Refresh(v,t);
                listItems[k].PlayTween(k);
            else
                ResUtil:CreateUIGOAsync("FightRoleInfo/FightRoleInfoItem",Content,function(go)
                    local item=ComUtil.GetLuaTable(go);
                    item.Refresh(v,t);
                    item.PlayTween(k);
                    table.insert(listItems,item);
                end);
            end
        end
    end
end

--获取所有数据
function SetMonsterInfos(monster)
    charInfos={};
    if monster==nil then
        return charInfos;
    end
    charInfos[1]={};
    charInfos[2]={};
    --获取主动、被动、特殊技能信息
    for k,v in ipairs(monster:GetSkills()) do --主动、被动技能、特殊技
        local cfg=Cfgs.skill:GetByID(v);
        if cfg==nil then
            LogError("未找到技能配置："..tostring(v))
        end
        if cfg and cfg.bIsHide~=true and cfg.main_type~=SkillMainType.Other then --技能类型为6的不在该面板显示
            if SkillUtil:IsSpecialSkill(cfg.type) and not PlayerClient:IsPassNewPlayerFight() then --如果未通关新手剧情不显示合体技
            else 
                if cfg.main_type~=SkillMainType.CardSubTalent then
                    table.insert(charInfos[1], {cfg=cfg});
                else
                    table.insert(charInfos[2],{cfg=cfg})
                end
            end
        end
    end
    for k,v in ipairs(monster:GetTalents()) do --天赋
        local cfg=Cfgs.CfgSubTalentSkill:GetByID(v);
        if cfg==nil then
            LogError("未找到天赋配置："..tostring(v))
        end
        if cfg and cfg.bIsHide~=true  then
            table.insert(charInfos[2],{cfg=cfg})
        end
    end
    table.sort(charInfos[1],function(a,b)
        if a.cfg.upgrade_type and b.cfg.upgrade_type then
            if a.cfg.upgrade_type==b.cfg.upgrade_type then
                if a.cfg.type==b.cfg.type then
                    return a.cfg.id<b.cfg.id;
                else
                    return a.cfg.type<b.cfg.type;
                end
            else
                return a.cfg.upgrade_type<b.cfg.upgrade_type
            end 
        else
            if a.cfg.type==b.cfg.type then
                return a.cfg.id<b.cfg.id;
            else
                return a.cfg.type<b.cfg.type;
            end
        end
    end);
    table.sort(charInfos[2],function(a,b)
        return a.cfg.id<b.cfg.id;
    end);
end

function OnClickItem(item)
    local index=item.GetIndex() 
    if lastIndex~=index then
        tabItems[lastIndex].SetSelect(false);
        type=1;
        SetItemStyle(type);
        SetInfo(curDatas[index].monster);
        if cTween then
            cTween:Play();
        end
    end
    lastIndex=index;
    SetTabLayout(true)
end

function SetTabLayout(isTween)
    local y=starY;
    for i=1,#curDatas do
        local item=tabItems[i];
        if item  then
            y=i==1 and y or y-item.GetLineHeight()-normalY;
            if lastIndex==i-1 then 
                y=y-(selectY-normalY)/2;
            end
            if isTween then
                UIUtil:DoLocalMove(item.gameObject,{paddingX,y,0});
            else
                CSAPI.SetAnchor(item.gameObject,0,y);
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
tabs=nil;
sv=nil;
tabContent=nil;
arrow1=nil;
arrow2=nil;
sv2=nil;
btn_skill=nil;
txt_skill=nil;
btn_status=nil;
txt_status=nil;
btn_talent=nil;
txt_talent=nil;
btn_equip=nil;
txt_equip=nil;
Content=nil;
gridObj=nil;
view=nil;
end
----#End#----