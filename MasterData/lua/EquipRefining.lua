--装备洗炼
local eventMgr=nil;
local layout=nil;
local curItem=nil;--当前选中的格子
local disNewTween=true;
local curDatas=nil;
local sortID=14;
local rAttr=nil;
local lAttr=nil;
local preEquip=nil;
local lockSkills=nil;
local isLockBase=false;
local priceInfos=nil;
local dayKey="DayRefining"
local cAnimator=nil
local particle=nil;
local particle2=nil;
local animaTime=250;
local changeIDs=nil;
local glowImg=nil;
local isChangeSlot=false;
local filterQuality={};
local refCount=0;--洗炼次数
local isEnter=true;
local lastStateData=nil;
local isGetter=false;
local sortView=nil;

function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Grid/EquipItem",LayoutCallBack,true,0.8);
    cAnimator=ComUtil.GetCom(root,"Animator")
    particle=ComUtil.GetCom(Sweeplight,"ParticleSystem");
    particle2=ComUtil.GetCom(Glow1,"ParticleSystem");
    glowImg=ComUtil.GetCom(Glow2,"Image");
	tweenLua=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal);
    ResUtil:CreateUIGOAsync("Sort/SortTop",btnTool,function(go)
		CSAPI.SetScale(go,1,1,1);
		sortView=ComUtil.GetLuaTable(go);
		sortView.Init(sortID,RefreshList);
		CSAPI.SetAnchor(go,45,-10);
	end);
    EventMgr.Dispatch(EventType.Equip_StrengthTween_State,true)
    InitFilter()
end

function InitFilter()
    for k, v in pairs(Cfgs.CfgEquipMultCost:GetAll()) do
        filterQuality[v.id]=1;
    end
end

function OnEnable()
    sortView.Init(sortID,RefreshList);
	if eventMgr==nil then
        eventMgr = ViewEvent.New();
        eventMgr:AddListener(EventType.Equip_Lock_Attribute,OnLockAttrs);
        eventMgr:AddListener(EventType.Bag_Update,RefreshPrice);
        eventMgr:AddListener(EventType.Equip_Refining_Ret,OnRefiningRet)
        eventMgr:AddListener(EventType.Equip_Refining_Comfirm,OnComfrimRet)
        eventMgr:AddListener(EventType.Equip_Refining_Update,OnRefiningUpdate);
	end
end

function OnDisable()
    isEnter=true;
    lastStateData=nil;
	if eventMgr then
		eventMgr:ClearListener();
		eventMgr=nil;
	end
	RecordMgr:Save(RecordMode.View,recordTime,"ui_id=" .. RecordViews.Equip);	
end

function Refresh()
    InitLastState()
    RefreshList();
    if curItem==nil and lastStateData==nil then
        CSAPI.SetGOActive(tipsObj,true);
        CSAPI.SetGOActive(rightObj,false);
        return;
    elseif curItem~=nil or lastStateData~=nil then
        CSAPI.SetGOActive(tipsObj,false);
        CSAPI.SetGOActive(rightObj,true);
    end
    RefreshRight();
end

function RefreshRight()
    local lData={tips=LanguageMgr:GetByID(75009),equip=curItem}
    local rData={tips=LanguageMgr:GetByID(75010),equip=preEquip}
    if lAttr==nil then
        lAttr=CreateChild(lData,lNode);
    end
    lAttr.Refresh(lData,{lockSkills=lockSkills,isLockBase=isLockBase})
    if rAttr==nil then
        rAttr=CreateChild(rData,rNode);
    end
    rAttr.Refresh(rData,{lockSkills=lockSkills,disClicker=true,isLockBase=isLockBase,changeIDs=changeIDs,isChangeSlot=isChangeSlot})
    RefreshPrice();
    CSAPI.SetGOActive(repOn,preEquip~=nil);
    CSAPI.SetGOActive(repOff,not preEquip~=nil);
end

function InitLastState()
    if isEnter then
        isEnter=false;
        lastStateData=EquipMgr:GetRefreshLastData()
        if lastStateData then
            refCount=refCount+1;
            curItem=EquipMgr:GetEquip(lastStateData.sid)
            RefreshPreEquip(lastStateData)
        else
            preEquip=nil;
            refCount=0;
            curItem=nil;
            lockSkills=nil;
            isLockBase=false;
        end
    end
end

function CreateChild(data,parent)
    if data and parent then
        local go=ResUtil:CreateUIGO("EquipInfo/EquipInfoItem",parent.transform);
        return ComUtil.GetLuaTable(go);
    end
    return nil;
end

function GetMoneys()
    return  {{10701},{10702}}
end

function RefreshList()
    local selectID=nil;
    -- if curItem then
    --     selectID=curItem:GetID()
    -- end
    -- local list=EquipMgr:GetNotEquippedItem(selectID,false,true);
    local list=EquipMgr:GetAllEquipArr(selectID,false)
    local source = {};
    if list then
        list=SortMgr:Sort(sortID,list);
        for i = 1, #list do--装备被选中后会被剔除
            if filterQuality[list[i]:GetQuality()] then
                table.insert(source, list[i]);
            end
        end
    end
    if #source>0 then
        curDatas=source;
    else
        curDatas={};
    end
    CSAPI.SetGOActive(SortNone,#curDatas<=0);
    layout:IEShowList(#curDatas,OnAnimaEnd);
end

function OnAnimaEnd()
    EventMgr.Dispatch(EventType.Equip_StrengthTween_State,false)
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local grid=layout:GetItemLua(index);
    if lastStateData and _data:GetID()==lastStateData.sid then
        curItem=_data;
    end
    local isSelect=curItem and curItem:GetID()==_data:GetID() or false
	grid.SetIndex(index);
    grid.Refresh(_data,{isClick = true,showNew=true,disNewTween=disNewTween,isSelect=isSelect,selectType=4})
	grid.SetClickCB(OnClickGrid);
end

function OnClickGrid(tab)
	--设置new
	if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function() 
			tab.data:SetNew(false);
			tab.SetNewState(tab.data:IsNew());
		end);
    end
    if curItem==nil or (curItem and refCount==0) then
        curItem=tab.data;
        lockSkills=nil;
        isLockBase=false;
    elseif curItem and refCount>0 then
        --提示是否切换洗炼
        local dialogData={
            content = LanguageMgr:GetByID(75024),
            okCallBack = function()
                EquipProto:EquipRefreshClearLastData();
                ResetView();
            end
        }
        CSAPI.OpenView("Dialog", dialogData);
    end
    Refresh();
end

function OnLockAttrs(eventData)
    if eventData==nil then
        do return end
    end
    local lockNum=0;
    local idx=nil;
    if (eventData.isBase~=true and isLockBase) or  (eventData.isBase  and  isLockBase~=true) then
        lockNum=1;
    end
    if lockSkills then
        for k,v in ipairs(lockSkills) do
            if v==eventData.id then
                idx=k
                break;
            end
        end
        if eventData.id then
            lockNum=idx and #lockSkills-1+lockNum   or #lockSkills+1+lockNum
        end
    elseif eventData.id  then
        lockNum=lockNum+1;
    end
    if lockNum>3 then
        Tips.ShowTips(LanguageMgr:GetByID(75021));
        RefreshRight();
        do return end
    end
    if eventData.isBase then
        isLockBase=not isLockBase;
    else
        lockSkills=lockSkills or {};
        if idx then
            table.remove(lockSkills,idx);
        else
            table.insert(lockSkills,eventData.id);
        end
    end
    RefreshPrice()
end

function OnClickRefining()
    if curItem==nil then
        do return end
    end
    local hasFull=true;
    local goodName=nil;
    local jumpID=nil;
    if priceInfos then
        for k, v in ipairs(priceInfos) do
            local goods=BagMgr:GetFakeData(v[1]);
            if goods:GetCount()<v[2] then
                hasFull=false;
                goodName=goods:GetName();
                jumpID=goods:GetMoneyJumpID()
                break;
            end
        end
    end
    if lockSkills and curItem and #lockSkills==#curItem:GetData().skills-1 and isLockBase then
        Tips.ShowTips(LanguageMgr:GetByID(75021));
        do return end;
    end
    local dialogData=nil
    if hasFull then
        if TipsMgr:IsShowDailyTips(dayKey) then
            dialogData = {
                content = LanguageMgr:GetByID(75016),
                dailyKey = dayKey,
                okCallBack = function()
                    SendRefining(curItem:GetID(),lockSkills,isLockBase)
                end
            }
        else
            SendRefining(curItem:GetID(),lockSkills,isLockBase)
        end
    else
        dialogData = {
            content = LanguageMgr:GetByID(75011,goodName),
            okCallBack = function()
                if jumpID then
                    JumpMgr:Jump(jumpID);
                end
            end
        }
    end
    if dialogData then
        CSAPI.OpenView("Dialog", dialogData);
    end
end

function SendRefining(cid,lockSkills,isLockBase)
    if cid then
        EquipProto:EquipRefresh(curItem:GetID(),lockSkills,isLockBase)
        OnNetWait();
    end
end

--洗炼返回
function OnRefiningRet(proto)
    EventMgr.Dispatch(EventType.Net_Msg_Getted,"EquipRefining");
    refCount=refCount+1;
    lastStateData=nil;
    if cAnimator and particle and proto then
        --播放洗炼动效
        local equip=EquipMgr:GetEquip(proto.sid)
        cAnimator:Play("Refining_effect",-1,0);
        FuncUtil:Call(function()
            OnRefiningAnimEnd(proto)
        end,nil,animaTime);
    else
        OnRefiningAnimEnd(proto)
    end
end

function OnRefiningAnimEnd(proto)
    if proto then
        RefreshPreEquip(proto)
        Refresh();
    end
end

function RefreshPreEquip(_data)
    if _data then
        local equip=EquipMgr:GetEquip(_data.sid)
        if equip==nil then
            do return end
        end
        local d=table.copy(equip:GetData());
        d.skills=_data.skills;
        d.cfgid=_data.newEquipId;
        preEquip=EquipData();
        preEquip:Init(d);
        --比较技能的不同
        isChangeSlot=equip:GetSlot()~=preEquip:GetSlot();
        changeIDs={};
        local max=#equip.data.skills>=#_data.skills and #equip.data.skills or #_data.skills
        for i = 1, max, 1 do
            if _data.skills[i]~=nil and equip.data.skills[i]~=_data.skills[i] then
                table.insert(changeIDs,_data.skills[i]);
            end
        end
    end
end

--确定返回
function OnComfrimRet(proto)
    EventMgr.Dispatch(EventType.Net_Msg_Getted,"EquipRefining");
    if proto then
        local rewards={};
        table.insert(rewards,{id=proto.equipData.cfgid,type=RandRewardType.EQUIP,c_id=proto.equipData.sid,num=1});
        UIUtil:OpenReward({rewards});
        ResetView()
    end
end

function OnNetWait()
    isGetter=false;
    EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="EquipRefining",time=5000,
    timeOutCallBack=function()
        Tips.ShowTips(LanguageMgr:GetTips(50001));
        EquipProto:EquipRefreshGetLastData(true)
        if isGetter~=true then
            OnNetWait();
        else
            isEnter=true;
            Refresh();
        end
    end});
end

function OnRefiningUpdate(isConfirm)
    if isGetter~=true and curItem then
        local temp=isConfirm and EquipMgr:GetEquip(curItem:GetID()) or EquipMgr:GetRefreshLastData();
        if temp then
            if isConfirm then
                OnComfrimRet({equipData=temp:GetData()})
            else
                OnRefiningRet({sid=temp.sid,newEquipId=temp.newEquipId,skills=temp.skills})
            end
        else
            EventMgr.Dispatch(EventType.Net_Msg_Getted,"EquipRefining");
        end
    else
        EventMgr.Dispatch(EventType.Net_Msg_Getted,"EquipRefining");
    end
    isGetter=true;
end

function ResetView()
    preEquip=nil;
    refCount=0;
    curItem=nil;
    lockSkills=nil;
    isLockBase=false;
    lastStateData=nil;
    Refresh();
end

function OnClickReplace()
    if curItem then
        if preEquip~=nil then
            local dialogData = {
                content = LanguageMgr:GetByID(75017),
                okCallBack = function()
                    EquipProto:EquipRefreshConfirm(curItem:GetID())
                    OnNetWait();
                end
            }
            CSAPI.OpenView("Dialog", dialogData);
        elseif preEquip==nil then
            Tips.ShowTips(LanguageMgr:GetByID(75012));
        end
    end
end

function RefreshPrice()
    if curItem==nil then
        do return end
    end
    local index=1;
    local cfg = Cfgs.CfgEquipRefreshLock:GetByID(curItem:GetQuality());
    local cfg2 = Cfgs.CfgEquipMultCost:GetByID(curItem:GetQuality());
    local infos=nil;
    local idx=isLockBase and 1 or 0;
    if cfg then
        if lockSkills then
            idx=#lockSkills+idx;
        end
        infos=#cfg.infos>=idx and cfg.infos[idx] or nil;
    end
    priceInfos=nil;
    -- 显示定价
    if idx>0 and infos and infos.lockCost then
        priceInfos=priceInfos or {}
        for k, v in ipairs(infos.lockCost) do
            local has=false;
            if priceInfos then
                for idx, val in ipairs(priceInfos) do
                    if v[1]==val[1] then
                        has=true;
                        priceInfos[idx]=priceInfos[idx][2]+v[2]
                        break;
                    end
                end
            end
            if has~=true then
                table.insert(priceInfos,table.copy(v));
            end
        end
    end
    if cfg2 and cfg2.refreshCost then
        priceInfos=priceInfos or {}
        for k, v in ipairs(cfg2.refreshCost) do
            local has=false;
            if priceInfos then
                for idx, val in ipairs(priceInfos) do
                    if v[1]==val[1] then
                        has=true;
                        priceInfos[idx]=priceInfos[idx][2]+v[2]
                        break;
                    end
                end
            end
            if has~=true then
                table.insert(priceInfos,table.copy(v));
            end
        end
    end
    for index=1, 3 do
        if priceInfos and priceInfos[index] then
            if index<=3 then
                local v=priceInfos[index];
                CSAPI.SetGOActive(this["p"..index],true);
                local goods=BagMgr:GetFakeData(v[1]);
                goods:GetIconLoader():Load(this["mIcon"..index],goods:GetIcon().."_1");
                CSAPI.SetText(this["txt_p"..index],tostring(v[2]));
                CSAPI.SetTextColorByCode(this["txt_p"..index],goods:GetCount()>=v[2] and "FFFFFF" or "E38089");
            else
                LogError("价格配置数量超出上限！");
                break;
            end
        else
            CSAPI.SetGOActive(this["p"..index],false);
        end     
    end
end

function OnClickMIcon1()
    OnClickMIcon(1)
end

function OnClickMIcon2()
    OnClickMIcon(2)
end

function OnClickMIcon3()
    OnClickMIcon(3)
end

function OnClickMIcon(idx)
    if priceInfos and idx then
        local good=BagMgr:GetFakeData(priceInfos[idx][1]);
        CSAPI.OpenView("GoodsFullInfo",{data=good});
    end
end