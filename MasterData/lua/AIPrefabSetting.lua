--自动战斗预设UI data:teamItemData
local tabIndex=1;
local isFirst=true;
local layout1=nil;
local layout2=nil;
local isOverLoad=g_OverLoadActivate==nil and false or g_OverLoadActivate==1;
local skillList=nil;
local maxOrder=0;--最大的顺序值
local eventMgr=nil;
local cardAIPreset=nil;
local currItem=nil;--当前选中的队员
local teamData=nil;--队伍数据
local realIndex=nil;--当前的策略真实索引
local sdr=nil;
local tVal=5;
local colors={{0,0,0,255},{146,146,150,255}}
local currNP=0;
local bIsSP=false;
local assistAIPreset=nil;
local isSendProto=false;
local isSkillSetting=true;
local isLoadFinish=false;
function Awake()
    layout1=ComUtil.GetCom(vsv,"UISV");
    layout1:Init("UIs/AISetting/AIPrefabItem",LayoutCallBack,true);
    layout2=ComUtil.GetCom(vsv2,"UISV");
    UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)
    layout2:Init("UIs/AISetting/AITabItem",LayoutCallBack2,true);
    sdr=ComUtil.GetCom(Slider,"Slider");
    CSAPI.AddSliderCallBack(Slider,OnSliderChange);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Team_Confirm_SetAIPrefab, OnSetAIVal);
    eventMgr:AddListener(EventType.AIPreset_Update, OnPresetUpdate);
    eventMgr:AddListener(EventType.AIPreset_SetRet, SaveCache);
    eventMgr:AddListener(EventType.AIPreset_Switch,OnSwitch);
    eventMgr:AddListener(EventType.AIPreset_ShowSkill,ShowSkill);
    SetOverLoadState(isOverLoad);
end

function OnDestroy()
    CSAPI.RemoveSliderCallBack(Slider,OnSliderChange);
    eventMgr:ClearListener();
    eventMgr=nil;
end

function OnInit()
    topTools=UIUtil:AddTop2("AIPrefabSetting",gameObject,Close,ToMain,{});
 end

--data:{teamData=TeamData,selectIndex=选中的队员,index=副本类型,oid=oid,cuid=cuid}
function OnOpen()
    if topTools then
        topTools.SetHomeActive(openSetting==nil);
        local x=openSetting==nil and 485 or 300;
        local anchorX,anchorY=CSAPI.GetAnchor(topTools.btn_exit);
        CSAPI.SetAnchor(questionItem,x,-72)
    end
    AIStrategyMgr:ClearEditData();
    if data==nil then
        LogError("没有传入必须的参数");
        return
    end
    teamData=data.teamData;
    currNP=teamData:GetReserveNP();
    bIsSP=teamData:GetIsReserveSP();
    tabIndex=data.selectIndex==nil and 1 or data.selectIndex;
    currItem=data.teamData:GetItemByIndex(tabIndex);
    realIndex=FormationUtil.GetOrderByTeamIndex(teamData:GetIndex());
    SendProto();
    SetTabState(true)
end

function OnPresetUpdate()
    isSendProto=true;
    Refresh();
end

--请求卡牌AI预设数据
function SendProto()
    if currItem:IsAssist() then --助战卡没有数据则取默认值
        Refresh();
    else
        -- local list=AIStrategyMgr:GetListByCid(currItem:GetID());
        if isSendProto then
            Refresh();
        else
            if not isSendProto then
                local ids ={};
                for k,v in ipairs(teamData.data) do
                    if not v:IsAssist() and not v:IsNPC() then
                        table.insert(ids,v:GetID())
                    end
                end
                PlayerProto:GetAIStrategy(ids);
            end
        end
    end
end

function SetData()
    if currItem:IsAssist() then --助战卡
        cardAIPreset=AIStrategyMgr:GetAssistAIPrefs(currItem:GetID(),teamData:GetIndex(),true);
        assistAIPreset=cardAIPreset;
    else
        cardAIPreset=AIStrategyMgr:GetEditData(currItem:GetID(),teamData:GetIndex());--获取当前配置页信息
    end
end

function Refresh()
    SetData();
    SetLayout();
    SetActionInfo();
end

--行动设置信息
function SetActionInfo()
    --NP预留设定
    sdr.value=currNP/tVal;
    SetHandleVal(math.floor(currNP));
    --SP预留设定
    SetRadioState(bIsSP);
end

function SetRadioState(isOn)
    CSAPI.SetGOActive(onObj,isOn);
    CSAPI.SetGOActive(offObj,not isOn);
    -- local c=isOn and colors[1] or colors[2]
    -- local c2=isOn and colors[2] or colors[1]
    -- CSAPI.SetTextColor(txtSwitchOff1,c2[1],c2[2],c2[3],c2[4]);
    -- CSAPI.SetTextColor(txtSwitchOn1,c[1],c[2],c[3],c[4]);
end

function OnClickSkill()
    SetTabState(true);
end

function OnClickAction()
    SetTabState(false);
end

function SetTabState(isSkill)
    isSkillSetting=isSkill;
    CSAPI.SetGOActive(skillOn,isSkill);
    CSAPI.SetGOActive(actionOn,not isSkill)
    CSAPI.SetGOActive(skillOff,not isSkill);
    CSAPI.SetGOActive(actionOff,isSkill)
    CSAPI.SetGOActive(AINode,isSkill);
    CSAPI.SetGOActive(ActionNode,not isSkill);
end

function SetLayout()
    if isFirst then
        layout2:IEShowList(g_TeamMemberMaxNum+1);
        isFirst=false
    else
        layout2:UpdateList();
    end
    curDatas={};
    isOverLoad=cardAIPreset:IsOverLoad();
    curDatas=cardAIPreset:GetSkillPresets();
    maxOrder=curDatas and #curDatas or 0;
    SetOverLoadState(isOverLoad);
    if isSkillSetting then
        layout1:IEShowList(#curDatas,OnAnimeEnd);
    end
end

function OnAnimeEnd()
    if isLoadFinish~=true then
        isLoadFinish=true;
        CSAPI.SetGOActive(mask,false);
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item=layout1:GetItemLua(index);
    local card=cardAIPreset:GetCard();
    local cfg=_data:GetSkillCfg();
    local skillCfg=nil
    if card and cfg then
        local skillList=card:GetSkillByType(cfg.main_type);
        if skillList then
            for k,v in ipairs(skillList) do
                local c=Cfgs.skill:GetByID(v.id);
                if c.group==cfg.group then
                    skillCfg=v;
                    break;
                end
            end
        end
    end
    item.Refresh(_data,maxOrder,skillCfg);
end

function LayoutCallBack2(index)
    local item=layout2:GetItemLua(index);
    local itemData=teamData:GetItemByIndex(index);
    -- local card=itemData~=nil and itemData:GetCard() or nil;
    item.Refresh(itemData,true)
    local isSelect=index==tabIndex;
    item.SetSelect(isSelect);
    item.SetClickCB(OnClickItem);
    -- item.ActiveClick(true)
end

function OnClickItem(tab)
    local card=tab.data~=nil and tab.data:GetCard() or nil;
    if card then    
        -- CheckSave(LanguageMgr:GetTips(20001),function()
        local teamItem=teamData:GetItem(card:GetID());
        currItem=teamItem;
        tab.SetSelect(true);
        if currItem~=nil and currItem:IsAssist() then
            assistAIPreset=cardAIPreset;
            if tabIndex then
                layout2:UpdateOne(tabIndex);
            end
        end
        tabIndex=teamItem:GetIndex();
        Refresh();
        -- end)
    end
end

-- function CheckSave(tips,call)
--     if IsEqual()~=true then
--         local dialogdata = {};
-- 		dialogdata.content = tips;
-- 		dialogdata.okCallBack = call
-- 		CSAPI.OpenView("Dialog", dialogdata)
--     elseif call then
--         call();
--     end
-- end

function SetOverLoadState(isOn)
    CSAPI.SetGOActive(overOn,isOn);
    CSAPI.SetGOActive(overOff,not isOn);
    isOverLoad=isOn;
end

function OnClickSwitch()
    bIsSP=not bIsSP;
    SetRadioState(bIsSP);
end

function OnClickOverLoad()
    SetOverLoadState(not isOverLoad)
    cardAIPreset:SetIsOverLoad(isOverLoad);
end

function OnClickApply()
    Apply();
end

function OnClickReset()
    --重置只重置当前方案的预设值
    if isSkillSetting then
        local defaultData=AIStrategyMgr:GetDefaultConfig(currItem:GetID(),realIndex);
        cardAIPreset:SetData(defaultData:GetData());
        SetLayout();
    else
        currNP=0;
        bIsSP=false;
        SetActionInfo();
    end
end

function OnClickCancel()
    view:Close();
end

function Apply()
    local assistID=teamData:GetAssistID();
    if assistID~=nil and assistAIPreset~=nil then --保存助战AI设置
        -- Log("Apply")
        -- Log(cardAIPreset:GetStrategyData())
        AIStrategyMgr:SetAssistAIPrefs(assistID,teamData:GetIndex(),cardAIPreset:GetStrategyData());
    end
    if openSetting and openSetting==2 then --战斗中修改ai预设
        --如果行动设置变更，则发送给服务器
        if currNP~=teamData:GetReserveNP() or bIsSP~=teamData:GetIsReserveSP() then
            FightProto:SendMapSetSkillAI(1,data.oid,bIsSP,currNP)
        end
        --组装战斗中修改需要的数据
        local protoData=nil;
        local changeList=AIStrategyMgr:GetChangeList();
        if changeList and next(changeList) then
            protoData=protoData or {};
            for k,v in ipairs(changeList) do
                local teamItem=teamData:GetItemByIndex(v.nCardIndex);
                if teamItem==nil then
                    LogError("未找到对应下标的队员数据:"..tostring(v.nCardIndex));
                    LogError(teamData:GetData())
                end
                table.insert(protoData,{
                  cuid=teamItem:GetID(), --卡牌ID
                  nStrategyIndex=realIndex, --AI预设下标
                  tStrategyData=v.tStrategyData,--策略数据  
                })
            end
        end
        local aiPreset=AIStrategyMgr:GetAssistAIPrefs(assistID,teamData:GetIndex());
        if aiPreset then
            protoData=protoData or {}
            local teamItem=teamData:GetItem(assistID)
            local cid=FormationUtil.GetAssitCID(teamItem:GetID())
            table.insert(protoData,{
                cuid=tonumber(cid), --卡牌ID
                fuid=teamItem:Getfuid(),
                tStrategyData=aiPreset:GetStrategyData(),--策略数据  
              })
            --   LogError(protoData)
        end
        if protoData~=nil then
            AIStrategyMgr:FightUsePreset(data.dupType,data.oid,protoData); --保存助战数据
        else
            Close();
        end
    else
        --如果行动设置变更，则保存队伍
        if currNP~=teamData:GetReserveNP() or bIsSP~=teamData:GetIsReserveSP() then
            teamData:SetReserveNP(currNP);
            teamData:SetIsReserveSP(bIsSP);
            TeamMgr:SaveEditTeam();
            EventMgr.Dispatch(EventType.Team_Data_Change);
        end
        if AIStrategyMgr:SaveEditData()~=true then
            Close();
        end
    end
end

function ToMain()
    -- CheckSave(LanguageMgr:GetTips(20000),function()
        UIUtil:ToHome()
    -- end)
end

function Close()
    -- CheckSave(LanguageMgr:GetTips(20000),function()
        view:Close();
    -- end)
end

function PostEvent()
    -- EventMgr.Dispatch(EventType.AIPreset_Use,{cid=currItem:GetID(),index=realIndex});
    Close();
end

function OnSwitch()--切换完成
    Close();
end

--刷新缓存
function SaveCache()
    AIStrategyMgr:ClearEditData(true);
    PostEvent();
end

function OnSetAIVal(info)
    if info and curDatas then
        --如果是释放顺序，则需要同时更新其它技能的释放顺序
        local tItem=nil;
        local tVal=nil;
        --设置最新的技能预设值
        for k,v in ipairs(curDatas) do
            local d=v:GetData();
            if info.type~=AIConditionOpenType.Sort then
                if v:GetCfgID()==info.id then
                    d[info.type]=info.val;
                    v:SetData(d);
                end
            elseif info.val==d[info.type] then --当前位置的技能
                tItem=v;
            elseif v:GetCfgID()==info.id then
                tVal=d[info.type];
                d[info.type]=info.val;
                v:SetData(d);
            end
        end
        if tItem and tVal then--设置优先级时会同时设置受影响的另一技能的优先级
            local d=tItem:GetData();
            d[info.type]=tVal;
            tItem:SetData(d);
        end
        --刷新父类中各项的值
        for k,v in ipairs(curDatas) do
            -- Log(tostring(v:GetCfgID()))
            -- Log(v:GetData())
            cardAIPreset:SetSkillPreset(v:GetCfgID(),v:GetData());
        end
        SetLayout();
    end
end

function ShowSkill(eventData)
    if eventData and currItem then
        local card=currItem:GetCard();
        if card then
            local skillList=card:GetSkillByType(eventData.main_type);
            if skillList then
                for k,v in ipairs(skillList) do
                    local cfg=Cfgs.skill:GetByID(v.id);
                    if cfg.group==eventData.group then
                        CSAPI.OpenView("RoleSkillInfoView", {v,card})
                        break;
                    end
                end
            end
        else
            LogError("未找到对应卡牌数据！")
        end
    end
end

function OnSliderChange(val)
    SetHandleVal(math.floor(val*tVal));
end

function OnClickRemove()
    sdr.value=sdr.value-1;
end

function OnClickAdd()
    sdr.value=sdr.value+1;
end

function SetHandleVal(val)
    CSAPI.SetText(txtVal,tostring(val));
    currNP=val;
end

function OnClickQuestion()
    local cfg=Cfgs.CfgModuleInfo:GetByID("AIPrefabSetting");
    if cfg then
        CSAPI.OpenView("ModuleInfoView", cfg)
    end
end