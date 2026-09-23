--战斗界面查看卡牌信息
local curDatas=nil;
local lastIndex=1;--选中物体的下标
local attrs={};--属性物体
local tabItems={};--tab物体
local listItems={};--物体
local type=1;--面板下标 1技能，2状态，3天赋，4芯片技能
local layout=nil;
local btnList=nil;--按钮列表
local btnTweens=nil;--按钮动画预制物
local hpSlider=nil;
local spSlider=nil;
local charInfos={};--战斗信息分组 1技能，2状态，3天赋，4芯片
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
local cTween=nil;
-- local grid=nil;
function Awake()
    -- ResUtil:CreateUIGOAsync("Grid/GridItem",gridObj,function(go)
    --     grid=ComUtil.GetLuaTable(go);
    --     grid.Clean();
    -- end);
    FightClient:SetStopState(true);
    btnList={btn_skill,btn_status,btn_talent,btn_equip};
    btnTweens={skillTween,statusTween,talentTween,equipTween}
    hpSlider=ComUtil.GetCom(hpBar,"Slider");
    spSlider=ComUtil.GetCom(spBar,"Slider");
    tabScroll=ComUtil.GetCom(sv,"ScrollRect");
    tabScrollRect=ComUtil.GetCom(sv,"RectTransform");
    tabRect=ComUtil.GetCom(tabContent,"RectTransform");
    cTween=ComUtil.GetCom(contentTween,"ActionUILayoutSpace");
    CreatePosInfos();
end

function OnClickClose()
    FightClient:SetStopState(false);
    view:Close();
end

function PlayCTween()
    if cTween then
        cTween:Play();
    end
end

function OnOpen()
    CSAPI.PlayUISound("ui_popup_open")
    curDatas={};
    local lineDatas=FightClient:GetTimeLineDatas();
    local addIds={};
    if lineDatas then
        for k,v in ipairs(lineDatas) do
            if addIds[v.id]~=true then --剔除重复数据
                local character=CharacterMgr:Get(v.id);   
                addIds[v.id]=true;
                if character then
                    table.insert(curDatas,{
                        character=character,
                    });
                end
            end
        end
        local sortList={};
        for i=#curDatas,1,-1 do --为使顺序一致，将数组倒序
            if curDatas[i].character.GetID()==data then
                lastIndex=#sortList+1
            end
            table.insert(sortList,curDatas[i]);
        end
        curDatas=sortList;
    else
        local characters=CharacterMgr:GetAll();
        for k,v in pairs(characters) do
            if v.GetID()==data then
               lastIndex=#curDatas+1;
            end
            table.insert(curDatas,{
                character=v,
            });
        end
    end
    if curDatas then
        RefreshTabs();
    end
    PlayCTween();
    SetInfo(curDatas[lastIndex].character);
    SetItemStyle(type);
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
    if lastType~=type then
        SetItemStyle(type);
        if curDatas then
            SetInfo(curDatas[lastIndex].character);
        end
        PlayCTween();
    end
end

function RefreshTabs()
    local y=starY;
    local posY=0;
    local sizeY=math.abs(starY);
    for k,v in ipairs(curDatas) do
        ResUtil:CreateUIGOAsync("FightRoleInfo/FightRoleTag",tabContent,function(go)
            local item=ComUtil.GetLuaTable(go);
            local cfg = v.character.GetCfgModel();   
            local teamId = v.character.GetTeam();
            local isEnemy = TeamUtil:IsEnemy(teamId);
            local isBoss=false;
            if v.character and v.character.cfg then
                isBoss=v.character.cfg.isboss==1;
            end
            local d={
                icon=cfg.icon,
                isEnemy=isEnemy,
                isBoss=isBoss;
            }
            item.SetIndex(k);
            item.Refresh(d,lastIndex);
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
function SetInfo(character)
    if character==nil then
        LogError("未获取到卡牌数据！");
        return;
    end
    --显示卡牌名称
    if character.IsEnemy()~=true and character.GetID()==PlayerClient:GetID() then
        CSAPI.SetText(txt_name,PlayerClient:GetName());
    else
        CSAPI.SetText(txt_name,character.GetName());
    end
    -- local nameColor=character.IsEnemy() and {255,0,64,255} or {255,193,70,255}
    -- CSAPI.SetTextColor(txt_name,nameColor[1],nameColor[2],nameColor[3],nameColor[4]);
    CSAPI.SetText(txt_lv,tostring(character.GetLv()));
    --显示hp
    local curHp,maxHp,buffHp=character.GetHpInfo();
    hpSlider.value=curHp/maxHp;
    CSAPI.SetText(txt_hp,curHp.."/"..maxHp);
    --显示sp
    if character.cfg and character.cfg.sp==0 then
        CSAPI.SetGOActive(spBar,false);
    else
        CSAPI.SetGOActive(spBar,true);
        local curSp,maxSp=character.GetSpInfo();
        spSlider.value=curSp/maxSp;
        CSAPI.SetText(txt_sp,curSp.."/"..maxSp);
    end
    --显示位置
    leftPosInfo.SetFoucs(character.GetID());
    rightPosInfo.SetFoucs(character.GetID());
    -- local modelCfg=character.GetCfgModel();
    -- ResUtil.ImgCharacter:Load(charImg,modelCfg.img);
    -- grid.Clean();
    -- grid.LoadIconByLoader(ResUtil.RoleCard,modelCfg.icon);
    -- grid.LoadFrame(character.GetCfg().quality);
    --显示立绘
    local cfgModel=character.GetCfgModel();
    ResUtil.FightCard:Load(charImg,cfgModel.Fight_head);
    -- local pos, scale, imgName = RoleTool.GetImgPosScale(cfgModel.id,LoadImgType.RoleInfo);
	-- if(pos) then
    --     ResUtil.ImgCharacter:Load(charImg, imgName,function()
    --         -- local realPos=gameObject.transform:TransformPoint(UnityEngine.Vector3(pos.x, pos.y));
    --         -- CSAPI.SetPos(charImg,realPos.x,realPos.y,gameObject.transform.position.z);
    --         CSAPI.SetAnchor(charImg,pos.x,pos.y-200);
    --         ResUtil.ImgCharacter:SetScale(charImg, scale)
    --     end);
    -- end
    local charData=g_FightMgr:GetCharData(character.GetID())
    --显示角色属性   
    SetAttribute(charData);
    SetCharInfos(character);
    for k,v in ipairs(btnList) do
        if charInfos[k]~=nil and #charInfos[k]>=1 then
            CSAPI.SetGOActive(v,true);
        else
            CSAPI.SetGOActive(v,false);
        end
    end
    -- LogError(charInfos[type]);
    RefreshList(charInfos[type]);
    RefreshTags(character);
end

function RefreshTags(character)
    local list={};
    local baseCfg=character.GetCfg()
    if baseCfg.tRace~=nil then
        local cfg=Cfgs.CfgRaceEnum:GetByID(baseCfg.tRace)
        if cfg~=nil then
            table.insert(list,cfg.sName);
        end
    end
    if baseCfg.tType~=nil then
        local cfg=Cfgs.CfgMonsterEnum:GetByID(baseCfg.tType)
        if cfg~=nil then
            table.insert(list,cfg.sName);
        end
    end
    if baseCfg.tBody~=nil then
        local cfg=Cfgs.CfgBodyEnum:GetByID(baseCfg.tBody)
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
            if k<=#listItems then
                CSAPI.SetGOActive(listItems[k].gameObject,true);
                listItems[k].Refresh(v,type);
                listItems[k].PlayTween(k);
            else
                ResUtil:CreateUIGOAsync("FightRoleInfo/FightRoleInfoItem",Content,function(go)
                    local item=ComUtil.GetLuaTable(go);
                    item.Refresh(v,type);
                    item.PlayTween(k);
                    table.insert(listItems,item);
                end);
            end
        end
    end
end

--创建属性物体
function SetAttribute(charData)
    -- local showAttriute={"career","attack","maxhp","defense","speed","crit_rate","crit","hit","resist"};
    -- local showAttriuteIds={20,1,2,3,4,5,6,7,8};
    local attributes={}; --显示的属性信息
    local showAttributeIds={};
    for k,v in ipairs(g_RoleAttributeList) do
        table.insert(showAttributeIds,v);
    end
    if charData then --设置护甲类型
        local index =charData["career"]
        local cfg = Cfgs.CfgCardPropertyEnum:GetByID(40 + index)
        local iconName = index == 1 and "img_12_02" or "img_12_01"
        CSAPI.SetGOActive(armorObj,true);
        local sName="";
        if index==1 then
            sName=LanguageMgr:GetByID(1028)
        elseif index==2 then
            sName=LanguageMgr:GetByID(1029)
        elseif index==3 then
            sName=LanguageMgr:GetByID(1030)
        end
        CSAPI.LoadImg(armorIcon, "UIs/FightRoleInfo/" .. iconName .. ".png", true, nil, true)
        CSAPI.SetText(txt_armor, sName)
    else
        CSAPI.SetGOActive(armorObj,false);
    end
    
    for k,v in ipairs(showAttributeIds) do
        local cfg = Cfgs.CfgCardPropertyEnum:GetByID(v)
		local key = cfg.sFieldName
        local val=0;
        if charData and charData[key] then
            val=charData[key];
            val=RoleTool.GetStatusValueStr(key,val);
        end
        table.insert(attributes,{id=cfg.id,val1=val,nobg=true,nobg2=k%2==0});
    end
    for i=1,#attributes do
        local item=nil;
        if i>#attrs then
            ResUtil:CreateUIGOAsync("AttributeNew2/AttributeItem3",statusRoot,function(go)
                item=ComUtil.GetLuaTable(go);
                table.insert(attrs,item);
                item.Refresh(attributes[i]);
            end);
        else
            item=attrs[i];
            item.Refresh(attributes[i]);
            if attributes[i].id==20 then
                item.SetName(attributes[i].val1);
                item.SetValStr("");
            end
        end
    end
end

--获取所有数据
function SetCharInfos(character)
    charInfos={};
    local charData=g_FightMgr:GetCharData(character.GetID())
    if charData==nil then
        return charInfos;
    end
    charInfos[1]={};--技能OverLoad
    charInfos[2]={};--buff
    charInfos[3]={};--天赋
    charInfos[4]={};--装备技能
    --获取主动、被动、特殊技能信息
    -- Log(character);
    -- Log(charData);
    -- Log(charData.cid);
    for k,v in ipairs(charData.skills) do --主动、被动技能、特殊技
        local cfg=Cfgs.skill:GetByID(v);
        -- LogError("主动、被动、特殊技：");
        -- LogError(cfg)
        if cfg.bIsHide~=true and cfg.main_type~=SkillMainType.Other then --技能类型为6的不在该面板显示
            if cfg and character.IsEnemy()==false and charData.isNpc~=true and (charData.cid==nil or charData.cid>0) then --剔除副天赋 charData的cid为负数时表示在试玩模式
                if SkillUtil:IsSpecialSkill(cfg.type) and not PlayerClient:IsPassNewPlayerFight() then --如果未通关新手剧情不显示合体技
                elseif cfg.main_type~=SkillMainType.CardSubTalent and cfg.main_type~=SkillMainType.Equip and cfg.upgrade_type~=CardSkillUpType.OverLoad then
                    table.insert( charInfos[1], {cfg=cfg});
                -- elseif cfg.main_type==SkillMainType.Equip then
                --     local skillCfg = Cfgs.CfgEquipSkill:GetByID(v);
                --     if skillCfg then
                --         table.insert( charInfos[4], skillCfg);
                --     end
                end
            elseif cfg and cfg.upgrade_type~=CardSkillUpType.OverLoad  then --不再次显示Overload技能
                if cfg.main_type==SkillMainType.CardSubTalent then --怪物的副天赋技能
                    local cfg2=Cfgs.CfgSubTalentSkill:GetByID(v);
                    if cfg2~=nil then
                        table.insert( charInfos[3], {cfg=cfg2});
                    else
                        LogError("怪物的副天赋配置有误！技能ID："..tostring(v));
                    end
                elseif cfg.main_type==SkillMainType.Equip and charData.isMonster then
                    local skillCfg = Cfgs.CfgEquipSkill:GetByID(v);
                    if skillCfg then
                        table.insert( charInfos[4],charData.isMonster==true and {skillCfg,1} or {skillCfg});
                    end
                elseif cfg.main_type~=SkillMainType.Equip then
                    table.insert( charInfos[1], {cfg=cfg});
                end
            end
        end
    end
    --装备技能
    if charData.eskills then
        for k,v in ipairs(charData.eskills) do
            if character.IsEnemy()==false and charData.isNpc~=true then
                local skillCfg = Cfgs.CfgEquipSkill:GetByID(v);
                if skillCfg and skillCfg.bIsHide~=true  then
                    -- LogError("装备技能：")
                    -- LogError(skillCfg);
                    table.insert( charInfos[4], {skillCfg});
                end
            else
                local skillCfg = Cfgs.CfgEquipSkill:GetByID(v);
                if skillCfg and skillCfg.bIsHide~=true then
                    -- LogError("装备技能：")
                    -- LogError(skillCfg);
                    table.insert( charInfos[4],charData.isMonster==true and {skillCfg,1} or {skillCfg});
                end
            end
        end
    end
    --新增机神继承用户装备技能词条
    if character.GetEquipSkills() and charData then
         for k,v in ipairs(character.GetEquipSkills()) do
            local skillCfg=Cfgs.skill:GetByID(v);
            if skillCfg and skillCfg.main_type~=SkillMainType.Other then--技能类型为6的不在该面板显示
                -- LogError("装备技能：")
                -- LogError(skillCfg);
                table.insert( charInfos[1], {cfg=skillCfg});
            end
        end
    end
    --怪物和NPC没有Buff信息
    local buffs=character.GetBuffs();
    if buffs then
        for k,v in pairs(buffs) do
            local cfg=v:GetCfg();
            if cfg and cfg.icon~=nil and cfg.icon~="" then
                table.insert(charInfos[2],v);
            end
        end
    end
    --获取卡牌对象的天赋技能信息
    if character.IsEnemy()==false and charData.isNpc~=true then
        -- if card and card:GetCfgID()==charData.cfgid then --防止试玩中cid错误的情况
        if charData.fuid==nil then
            --获取卡牌数据
            local card=FormationUtil.FindTeamCard(charData.cid)
            if card~=nil then
                --副天赋
                local serverData=card:GetDeputyTalent();
                local talentList=serverData==nil and nil or serverData.use;
                if talentList then
                    for i=1,#talentList do
                        if talentList[i]~=0 then
                            local cfg=Cfgs.CfgSubTalentSkill:GetByID(talentList[i]);
                            table.insert(charInfos[3],{cfg=cfg,isTalent=true});
                        end
                    end
                end
            end
        else --助战卡
            local use=charData.use_sub_talent or {};
            for k,v in pairs(use) do
                local cfg=Cfgs.CfgSubTalentSkill:GetByID(v);
                table.insert(charInfos[3],{cfg=cfg,isTalent=true});
            end
        end
    end
    --排序
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
        local round=a.data.round or 0;
        local round2=b.data.round or 0;
        if round==round2 then
            return a.data.id<b.data.id;
        else
            return round>round2;
        end       
    end);
    table.sort(charInfos[3],function(a,b)
        return a.cfg.id<b.cfg.id;
    end);
    table.sort(charInfos[4],function(a,b)
        if a[1].nLv==b[1].nLv then
            return a[1].group<b[1].group
        else
            return a[1].nLv>b[1].nLv
        end
    end);
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

function OnClickItem(item)
    local index=item.GetIndex();
    if lastIndex~=index then
        tabItems[lastIndex].SetSelect(false);
        type=1;
        SetItemStyle(type);
        SetInfo(curDatas[index].character);
        PlayCTween();
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

function CreatePosInfos()
    local characters = CharacterMgr:GetAll();
    local mineList={};
    local enemyList={};
    for k,v in pairs(characters) do
        if not v.IsDead() and not v.IsDeadPlayed() then
            if v.IsEnemy() then--获取敌方站位
                table.insert(enemyList,v);
            else --获取己方站位
                table.insert(mineList,v);
            end
        end
    end
    ResUtil:CreateUIGOAsync("FightRoleInfo/FightPosInfo",posObj,function(go)
        leftPosInfo=ComUtil.GetLuaTable(go);
        leftPosInfo.Init(mineList);
        CSAPI.SetScale(go,0.7,0.7,0.7);
        CSAPI.SetAnchor(go,-89,6);
    end)
    ResUtil:CreateUIGOAsync("FightRoleInfo/FightPosInfo",posObj,function(go)
        rightPosInfo=ComUtil.GetLuaTable(go);
        rightPosInfo.Init(enemyList);
        CSAPI.SetScale(go,0.7,0.7,0.7);
        CSAPI.SetAnchor(go,83,6);
    end)
end
function OnDestroy()    
    FightClient:SetStopState(false);
end