
local baseItems={};
local skillItems={};
local gridItem;
local eventMgr=nil;
local canvasGroup=nil;
local btn1Func=nil;
local btn2Func=nil;
local isLeft=false;
local data=nil;
local c_equip=nil; --用于对比属性的装备
local cardId=nil;--卡牌ID

function Awake()
    canvasGroup=ComUtil.GetCom(btn1,"CanvasGroup");
end

function OnEnable()
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Equip_SetLock_Ret, OnLockRet);
    eventMgr:AddListener(EventType.Equip_Upgrade_Ret, OnUpgradeRet);
    -- eventMgr:AddListener(EventType.Equip_Down_Ret, OnDownRet);
end

function OnDisable()
    eventMgr:ClearListener();
end

function OnDestroy()
    ReleaseCSComRefs();
end

--- 设置数据并刷新界面
---@param _d _d={equip=该界面显示的装备,equip2=该界面对比的装备,cardId=当前影响的卡牌ID}
---@param isLeft 是否在左侧 true:左侧窗口 false:右侧窗口
function SetData(_d,_isLeft)
    isLeft=_isLeft==true;
    data=_d.equip;
    c_equip=_d.equip2;
    cardId=_d.cardId;
    Refresh();
end

function SetLayout()
    local txt1,txt2=23034,23032
    local func1,func2=OnStrength,OnReplcae;
    if isLeft then --左侧窗口
        local isEquip=data:GetCardId()==cardId; --是否当前卡牌穿戴的装备
        if isEquip then
            txt1=23033;
            txt2=23034;
            func1=OnUnEquip;
            func2=OnStrength;
        elseif c_equip==nil then
            txt2=23047;
        end
    else --右侧窗口

    end
    CSAPI.SetGOActive(btns,isLeft);
    CSAPI.SetGOActive(stateObj,not isLeft);
    btn1Func=func1;
    btn2Func=func2;
    CSAPI.SetText(txt_replace,LanguageMgr:GetByID(txt1));
    CSAPI.SetText(txt_replaceTips,LanguageMgr:GetByType(txt1,4));
    CSAPI.SetText(txt_strength,LanguageMgr:GetByID(txt2));
    CSAPI.SetText(txt_strengthTips,LanguageMgr:GetByType(txt2,4));
end

function Refresh()
    if data then
        if gridItem==nil then
            ResUtil:CreateUIGOAsync("Grid/EquipItem2",gNode,function(go)
                gridItem=ComUtil.GetLuaTable(go);
                gridItem.Refresh(data,{isClick=false});
                gridItem.SetLockActive(false);
                gridItem.SetEquipped();
            end)
        else
            gridItem.Refresh(data,{isClick=false});
            gridItem.SetLockActive(false);
            gridItem.SetEquipped();
        end
        -- if gridItem==nil then
        --     _,gridItem=ResUtil:CreateEquipItem(gNode.transform);
        -- end
        -- gridItem.Refresh(data,{isClick=false});
        -- gridItem.SetLockActive(false);
        -- gridItem.SetEquipped();
        SetLock(data:IsLock());
        -- SetEquipped();
        CSAPI.SetText(txt_name,data:GetName());
        CSAPI.SetImgColorByCode(light,EquipMgr:GetQualityColor(data:GetQuality()));
        local list={};
        for i=1,g_EquipMaxAttrNum do
            local id,add,upAdd=data:GetBaseAddInfo(i);
            local isUp=nil;
            if id and add and upAdd then
                local addition=add+upAdd*data:GetLv();
                if c_equip then
                    local add2=c_equip:GetBaseAddByID(id);
                    if add2 and add2~=addition then
                        isUp=add2<addition and 1 or 2;
                    end
                end
                local text=EquipCommon.FormatAddtion(id,addition);
                table.insert(list,{add={id=id,val1="+"..text},isUp=isUp});
            end
        end
        ItemUtil.AddItems("EquipInfo/EquipReplaceAttribute",baseItems,list,baseRoot,nil,1);
        ShowSkill();
        --设置激活技能的描述和名称
        local cfg=Cfgs.CfgSuit:GetByID(data:GetSuitID());
        if cfg then
            CSAPI.SetGOActive(bottom,true);
            CSAPI.SetText(txt_effect,cfg.skillName);
            CSAPI.SetText(txt_desc,cfg.dec);
        else
            CSAPI.SetGOActive(bottom,false);
        end
    end
    SetLayout();
end

function ShowSkill()
    local list={};
    if data then
        local index=0;
        for i=1,g_EquipMaxSkillNum do
            local cfg=data:GetSkillInfo(i);
            if cfg then
                if index<=g_EquipMaxSkillNum then
                    table.insert(list,cfg);
                    index=index+1;
                else
                    LogError("技能数量超过上限！！");
                end
            end       
        end
    end
    skillItems=skillItems or {};
    for i=1,g_EquipMaxSkillNum  do
        local isLock,desc=true,"";
        if list and list[i] then
            isLock,desc=data:GetSkillIsLock(list[i].id,i);
        end
        if skillItems and i <= #skillItems then
            skillItems[i].Refresh(list[i],nil,{isLock=isLock,lockStr=desc});
            skillItems[i].SetClickCB(OnClickSkillItem);
        else
            ResUtil:CreateUIGOAsync("EquipInfo/EquipSkillAttribute",skillRoot,function(go)
                local tab=ComUtil.GetLuaTable(go);
                tab.Refresh(list[i],nil,{isLock=isLock,lockStr=desc});
                tab.SetClickCB(OnClickSkillItem);
                table.insert(skillItems,tab);
            end);
        end
    end
end

function OnClickSkillItem(cfg)
    if cfg then
        CSAPI.OpenView("RoleEquipSkillInfo",cfg);
    end
end

function SetEquipped()
    if data and data:IsEquipped() then
        local card=RoleMgr:GetData(data:GetCardId());
        local cfg=card:GetModelCfg();
        ResUtil.RoleCard:Load(equippedIcon, cfg.icon,false)
        CSAPI.SetGOActive(equippedObj,true);
        CSAPI.SetScale(equippedIcon,1,1,1);
    else
        CSAPI.SetGOActive(equippedObj,false);
    end
end

--替换装备
function OnClickBtn1()
    if btn1Func then
        btn1Func();
    end
end

function OnClickBtn2()
    if btn2Func then
        btn2Func();
    end
end

function OnUpgradeRet()
    if  data then
        data=EquipMgr:GetEquip(data:GetID());
    end
    if c_equip then
        c_equip=EquipMgr:GetEquip(c_equip:GetID());
    end
    Refresh();
end

--强化
function OnStrength()
    if CanEdit() then
        CSAPI.OpenView("EquipStreng",{equip=data,isBag=openSetting==1});
    end
end

--替换/穿戴
function OnReplcae()
    if CanEdit() and cardId then
        local slot=data:GetSlot();
        EquipProto:EquipUp(data:GetID(), cardId);
    elseif CanEdit() and cardId==nil then
        LogError("卡牌ID为nil："..tostring(cardId))
    end
end

function CanEdit()
    local cid=data:GetCardId();
    if cid then
        local isFight=TeamMgr:GetCardIsDuplicate(cid);
        local isAssist=FriendMgr:IsAssist(cid);
        if isAssist==true then
            Tips.ShowTips(LanguageMgr:GetTips(12006));
            return false;
        elseif isFight then
            Tips.ShowTips(LanguageMgr:GetTips(12007))
            return false;
        end
    end
    return true;
end

--卸下
function OnUnEquip()
    if CanEdit() then
        EquipProto:EquipDown({data:GetID()});     
    end
end

function SetLock(isLock)
    -- local txt=isLock and LanguageMgr:GetByID(24017) or LanguageMgr:GetByID(24018);
    -- CSAPI.SetText(txt_lock,txt);
    -- CSAPI.LoadImg(lockIcon,isLock and "" or "",true,nil,true);
    CSAPI.SetGOActive(lockIcon,not isLock);
    CSAPI.SetGOActive(lockIcon2,isLock);
end

function OnClickLock()
    local infos={{sid=data:GetID(),lock=data:IsLock() and 0 or 1}}
    EquipProto:SetLock(infos)
end

function OnLockRet(proto)
    local isThis=false;
    if proto and proto.infos then
        for k,v in ipairs(proto.infos) do
            if v.sid==data:GetID() then
                isThis=true;
                break;
            end
        end
    end
    if isThis then
        if data:IsLock() then
            Tips.ShowTips(LanguageMgr:GetByID(23054))
        else
            Tips.ShowTips(LanguageMgr:GetByID(23055))
        end    
        Refresh();
    end
end

function Close()
    CSAPI.SetGOActive(gameObject,false)
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
bg_b1=nil;
top=nil;
gridNode=nil;
txt_name=nil;
baseRoot=nil;
lockBtn=nil;
lockIcon=nil;
lockIcon2=nil;
txt_lock=nil;
equippedObj=nil;
txt_equipped=nil;
equippedIcon=nil;
center=nil;
skillRoot=nil;
bottom=nil;
svc=nil;
txt_desc=nil;
btns=nil;
txt_replace=nil;
txt_replaceTips=nil;
txt_strength=nil;
txt_strengthTips=nil;
view=nil;
end
----#End#----