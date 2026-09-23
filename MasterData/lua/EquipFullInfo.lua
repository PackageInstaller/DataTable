
local baseItems={};
local skillItems={};
local gridItem;
local eventMgr=nil;
-- local canvasGroup=nil;
local btn1Func=nil;
local btn2Func=nil;
-- local canvasGroup2=nil;
function Awake()
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Equip_SetLock_Ret, OnLockRet);
    eventMgr:AddListener(EventType.Equip_Sell_Ret, OnSellRet);
    eventMgr:AddListener(EventType.Equip_Upgrade_Ret, OnUpgradeRet);
    -- canvasGroup=ComUtil.GetCom(btn1,"CanvasGroup");
    -- canvasGroup2=ComUtil.GetCom(btn2,"CanvasGroup")
end

function OnDestroy()
	eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function SetLayout()
    if openSetting==1 then --背包中打开 出售/强化
        CSAPI.SetGOActive(btns2,false);
        CSAPI.SetGOActive(lockBtn,true);
        CSAPI.SetText(txt_replace,LanguageMgr:GetByID(24015));
        CSAPI.SetText(txt_replaceTips,LanguageMgr:GetByType(24015,4));
        CSAPI.SetText(txt_strength,LanguageMgr:GetByID(23034));
        CSAPI.SetText(txt_strengthTips,LanguageMgr:GetByType(23034,4));
        CSAPI.SetGOActive(btns,data:GetType()~=EquipType.Material);
        btn1Func=OnSell;
        btn2Func=OnStrength;
    elseif openSetting ==2 then --角色中打开 
        CSAPI.SetGOActive(btns2,false);
        CSAPI.SetGOActive(lockBtn,true);
        CSAPI.SetText(txt_replace,LanguageMgr:GetByID(23032));
        CSAPI.SetText(txt_replaceTips,LanguageMgr:GetByType(23032,4));
        CSAPI.SetText(txt_strength,LanguageMgr:GetByID(23034));
        CSAPI.SetText(txt_strengthTips,LanguageMgr:GetByType(23034,4));
        btn1Func=OnReplace;
        btn2Func=OnStrength;
    elseif openSetting==3 then--奖励、商城、结算、角色中打开（只是查看）中打开 无
        CSAPI.SetGOActive(btns,false);
        CSAPI.SetGOActive(btns2,false);
        CSAPI.SetGOActive(lockBtn,true);
        btn1Func=nil;
        btn2Func=nil;
    elseif openSetting==4 then --改造中打开
        CSAPI.SetGOActive(btns,false);
        CSAPI.SetGOActive(lockBtn,false);
        CSAPI.SetGOActive(btns2,true);
        btn1Func=nil;
        btn2Func=nil;
    elseif openSetting==5 then --非自己的卡牌
        CSAPI.SetGOActive(btns,false);
        CSAPI.SetGOActive(btns2,false);
        CSAPI.SetGOActive(lockBtn,false);
        btn1Func=nil;
        btn2Func=nil;
    end
end

function OnOpen()
    openSetting=openSetting or 1;
    Refresh();
    SetLayout();
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
        SetLock(data:IsLock());
        -- SetEquipped();
        CSAPI.SetText(txt_name,data:GetName());
        CSAPI.SetImgColorByCode(light,EquipMgr:GetQualityColor(data:GetQuality()));
        local list={};
        for i=1,g_EquipMaxAttrNum do
            local id,add,upAdd=data:GetBaseAddInfo(i);
            if id and add and upAdd then
                local addition=add+upAdd*data:GetLv();
                local text=EquipCommon.FormatAddtion(id,addition);
                table.insert(list,{id=id,val1="+"..text});
            end
        end
        ItemUtil.AddItems("AttributeNew2/AttributeItem6",baseItems,list,baseRoot,nil,1);
        ShowSkill();
        --设置激活技能的描述和名称
        local cfg=Cfgs.CfgSuit:GetByID(data:GetSuitID());
        if cfg then
            CSAPI.SetText(txt_effect,cfg.skillName);
            CSAPI.SetText(txt_desc,cfg.dec);
        end
        if data:GetType()==EquipType.Normal then
            CSAPI.SetGOActive(btns,true);
            CSAPI.SetGOActive(bottom,true);
        elseif data:GetType()==EquipType.Material then
            CSAPI.SetGOActive(btns,false);
            CSAPI.SetGOActive(bottom,false);
        end
    end
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
    for i=1,g_EquipMaxSkillNum do
        local isLock,desc=true,"";
        if list[i]~=nil and data then
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

function OnReplace()
    if data and CanEdit() then
        CSAPI.OpenView("RoleEquip",{card=RoleMgr:GetData(data:GetCardId()),slot=data:GetSlot()});
        view:Close();
    end
end

--强化
function OnStrength()
    if EquipMgr:CheckIsRefreshLast(data:GetID()) then
        view:Close();
		do return end
	end
    if CanEdit() then
        -- if data:GetLv()>=data:GetMaxLv() then
        --     Tips.ShowTips(LanguageMgr:GetTips(12008));
        --     do return end;
        -- end
        CSAPI.OpenView("EquipStreng",{equip=data,isBag=openSetting==1});
        view:Close();
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
        view:Close();
    end
end

--出售
function OnSell()
    if EquipMgr:CheckIsRefreshLast(data:GetID()) then
        view:Close();
		do return end
	end
    if data:IsLock() and openSetting==1 then
        return;
    end
    if data:IsEquipped() then
        return;
    end
    local str="";
    local price=data:GetSellPrice();
    local rewards=data:GetSellRewards();
    if rewards and #rewards>0 then
        str=LanguageMgr:GetByID(23074,price,rewards[1].num);
    else
        str=LanguageMgr:GetByID(23073,price);
    end
    local dialogdata={
        content=str,
        okCallBack=function()
            SendSell();
        end,
    }
    CSAPI.OpenView("Dialog",dialogdata)
end

function SendSell()
	local ids = {data:GetID()};
	local price=data:GetSellPrice();
	--发送出售协议
	EquipProto:EquipSell(ids);
end

function OnSellRet()
    EventMgr.Dispatch(EventType.Equip_Change);
    Close();
end

function SetLock(isLock)
    -- local txt=isLock and LanguageMgr:GetByID(24017) or LanguageMgr:GetByID(24018);
    -- CSAPI.SetText(txt_lock,txt);
    -- CSAPI.LoadImg(lockIcon,isLock and "" or "",true,nil,true);
    CSAPI.SetGOActive(lockIcon,not isLock);
    CSAPI.SetGOActive(lockIcon2,isLock);
    -- if data:GetMaxLv()==data:GetLv() then
    --     UIUtil:SetBtnState(btn2,false);
    -- else
    --     UIUtil:SetBtnState(btn2,true);
    -- end
    if openSetting==1 then
        -- local alpha=1
        if data:IsEquipped() or data:IsLock() then
            -- alpha=0.5
            UIUtil:SetBtnState(btn1,false);
        else
            UIUtil:SetBtnState(btn1,true);
        end
        -- canvasGroup.alpha=alpha;
    else
        UIUtil:SetBtnState(btn1,true);
        -- canvasGroup.alpha=1;
    end
end

function OnClickLock()
    local infos={{sid=data:GetID(),lock=data:IsLock() and 0 or 1}}
    EquipProto:SetLock(infos)
end

function OnUpgradeRet()
    Refresh();
end

function OnLockRet()
    if data:IsLock() then
        Tips.ShowTips(LanguageMgr:GetByID(23054))
    else
        Tips.ShowTips(LanguageMgr:GetByID(23055))
    end    
    SetLock(data:IsLock());
    EventMgr.Dispatch(EventType.Equip_Change);
end

function OnClickBtn3()
    EventMgr.Dispatch(EventType.Equip_Remould_Select,data);
    Close();
end

function Close()
    view:Close();
end

function OnClickReturn()
    Close();
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