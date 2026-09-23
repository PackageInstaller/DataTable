--技能操作界面

items = nil;


--Overload剩余可选次数
local overloadCount = nil;

--local timeOutValue = nil;

function Awake()
    AdaptiveConfiguration.SetLuaObjUIFit("Skill",gameObject); --节点添加
    --timeBar = ComUtil.GetCom(goTimeBar,"BarBase");
    --txtTime = ComUtil.GetCom(timeText,"Text");
    actionOn = ComUtil.GetCom(onAction,"ActionBase")
    actionOff = ComUtil.GetCom(offAction,"ActionBase")

    overloadBar = ComUtil.GetCom(overload_icon,"BarBase")
    if(overloadBar)then
        overloadBar:SetFormat("<color=#FFC146><size=35>{0}</size></color>/{1}");
    end
    --txtShowName = ComUtil.GetCom(showNameText,"Text");    
    --txtOverload = ComUtil.GetCom(goOverloadText,"Text");   
    local _spStr = LanguageMgr:GetByID(28001) or "SP" 
    CSAPI.SetText(overload_cost,_spStr);   
    --CSAPI.SetText(title,StringConstant.fight_player_skill_title);       
    --txtOverload_cost1 = ComUtil.GetCom(overload_cost1,"Text");
    
    SetOverload();

end

function OnInit()
    --CSAPI.SetGOActive(btnOK,false);
    CSAPI.SetGOActive(btnOverLoad,false);
    --SetEnemyActionState(false);
    InitItems();    
    InitPlayerSkillItems();
    InitListener();

    SetOverload(nil);

    --CSAPI.SetText(playerSkill,StringConstant.fight_skill_view_player_skill);

    SetShowState(not FightClient:IsAutoFight());
    --SetPlayerSkillShowState(false);
    CSAPI.SetGOActive(btnPlayerSkill,false);
end

function SetShowState(isShow)
    UpdateMove();
    --CSAPI.SetLocalPos(stateNode,0,0,isShow and 0 or -10000);
end

--function SetEnemyActionState(state)
--    CSAPI.SetGOActive(enemyAction,state);
--    SetTimeOut(state and (g_fightControlTime or 20) or nil);
--end

function SetOverload(count)
    CSAPI.SetGOActive(overload,count and count > 0);
end

--function Update()
--    if(CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.A))then    
--        OnClickBtnOverLoad();
--    end 
--end


function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Input_Target_Changed,OnInputChanged); 
    eventMgr:AddListener(EventType.Fight_Action_Overload,OnFightActionOverLoad);
    eventMgr:AddListener(EventType.Input_Select_Relive_Target,OnSelectReliveTarget);    
    eventMgr:AddListener(EventType.Input_Select_Transform_Target,OnSelectTransformTarget);    
    
    eventMgr:AddListener(EventType.Input_Select_OK,OnClickBtnOK);    
    eventMgr:AddListener(EventType.Input_Select_Cancel,CancelSelect);    

    eventMgr:AddListener(EventType.Fight_Auto_Changed,OnFightAutoChanged);      
      
    eventMgr:AddListener(EventType.Input_Select_Skill_Item,OnSelectItem);    
    eventMgr:AddListener(EventType.Fight_UI_Enter_Action,PlayEnterAction);   
    eventMgr:AddListener(EventType.Fight_ShowTips_SkillUnusable,ShowUnusableTips);   
    
end
function OnDestroy()
    eventMgr:ClearListener()
    ReleaseCSComRefs()
end
function PlayEnterAction()    
    FuncUtil:Call(DelayPlayEnterAction,nil,500);
end
function DelayPlayEnterAction()
    canPlayed = true;
    UpdateMove();
end


local unusableTipsIndex = 
{
    19010,--1沉默只能用普攻
    19015,--2cd中
    19017,--3不可召唤
    19014,--4没有可触发对象
    19016,--5xp不足
    19011,--6np不足
    19009,--7sp不足
}

function ShowUnusableTips(index)
    if(not index or index > 0)then
        return;
    end    
    local tipsIndex = unusableTipsIndex[-index];
    if(tipsIndex)then
        Tips.ShowTips(LanguageMgr:GetTips(tipsIndex));
    end
end

function UpdateMove()
    local newState = GetShowState();

--    if(currShowState == nil)then
--        currShowState = true;
--    end    

    if(newState == currShowState)then
        return;
    end
    currShowState = newState;
    --LogError("技能面板显示状态：" .. tostring(newState));
    CSAPI.MoveTo(stateNode,"move_linear_local",newState and 0 or 700,0,0);    
    CSAPI.SetGOActive(enterAction,newState);
    CSAPI.SetGOActive(exitAction,not newState);
end

function GetShowState()
    --LogError("canPlayed:" .. tostring(canPlayed) .. "\ncurrSkillDatas:" .. (currSkillDatas and "true" or "false"));
    return canPlayed and currSkillDatas and not FightClient:IsAutoFight() and true or false;
end

function OnSelectItem(itemIndex)
    if(itemIndex == 0)then
        OnClickBtnOverLoad(); 
    else
        local targetItem = itemIndex and items[itemIndex];
        SelectItem(targetItem);
    end
end

function DefaultSelItem()
    if(items)then
        for _,item in ipairs(items)do
            if(item.IsBaseAttack())then
                --local lastSkillItem = GetLastSkillItem();
                --if(lastSkillItem ~= item)then
                    SelectItem(item);                    
                --end                
            end
        end
    end
end

--控制目标变化
function OnInputChanged(fightAction)    
    local skillList = nil;
    local character = nil;
    local skillDatas = nil;
    local isCanOverload = nil;

    local fightActionData = nil;
    if(fightAction and fightAction:GetType() == FightActionType.Turn and not fightAction:IsMotionless())then
        character = fightAction:GetActorCharacter();
        fightActionData = fightAction:GetData();
    end
    --LogError("显示技能版" .. table.tostring(fightActionData));
    currCharacter = character;

    local enemyAction = false;

    if(character and fightActionData)then      
        local isMyTurn = character.IsMine();
       
        enemyAction = not isMyTurn;
        if(isMyTurn)then  
            skillList = character.skillList;
            skillDatas = fightActionData.skillDatas;
            overloadStateNum = fightActionData.canOverLoad;
            isCanOverload = overloadStateNum and overloadStateNum > 0;
--            LogError("overloadStateNum:" .. tostring(overloadStateNum));
--            LogError("isCanOverload:" .. tostring(isCanOverload));
            if(FightClient:IsAutoFight())then
                FuncUtil:Call(DelaySendAuto,nil,500);
                --FightProto:SendAuto();
            end            
        end
    end

--    LogError("skillList==========================");
--    LogError(skillList);
--    LogError("skillDatas==========================");
--    LogError(skillDatas);
    
    ShowSkills(skillList,skillDatas);
    if(fightActionData)then
        ShowPlayerSkills(fightActionData.tCommanderSkill);
    end
    if(skillList == nil)then
        --CSAPI.SetGOActive(btnOK,false);      
        SwitchOverLoad(false);  
        SetPlayerSkillShowState(false);        
    end
    --SetEnemyActionState(enemyAction);
  
--    if(fightActionData and fightActionData.tCommanderSkill)then
--        LogError("指挥官技能");
--        LogError(fightActionData.tCommanderSkill);
--    end
--    LogError(g_FightMgr.type);
--    LogError(SceneType);
    CSAPI.SetGOActive(btnPlayerSkill,IsShowPlayerSkill(fightActionData));
    CSAPI.SetGOActive(btnOverLoad,skillList ~= nil);
    
    SetOverLoadValidState(isCanOverload);
end

function IsShowPlayerSkill(fightActionData)
    if g_FightMgr == nil or fightActionData == nil or fightActionData.tCommanderSkill == nil then
        return false
    elseif IsPvpSceneType(g_FightMgr.type) or g_FightMgr.type == SceneType.PVPMirror then
        return false
    else
        local cfgDungeon = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
        if cfgDungeon then
            if cfgDungeon.type == eDuplicateType.EternalBattle and g_EternityWarzoneTactics ~= 1 then
                return false
            elseif cfgDungeon.type == eDuplicateType.SkinPass and cfgDungeon.MainLinetype and cfgDungeon.MainLinetype == 1 then
                return false
            end
        end
    end
    return true
end

--延迟发送自动战斗
function DelaySendAuto()
    local character = currCharacter;
    if(character)then      
        local isMyTurn = character.IsMine();
       
        if(isMyTurn)then             
            if(FightClient:IsAutoFight())then
                FightClient:SendAutoFight();
            end            
        end
    end    
end


function OnFightActionOverLoad(state)    
    SwitchOverLoad(state);

    if(state)then
        CSAPI.SetGOActive(btnPlayerSkill,false);
        SetPlayerSkillShowState(false);       
    end
end
--切换overload状态
function SwitchOverLoad(state)
    --设置overload次数
    overloadCount = state and 3 or nil;
    SetOverload(overloadCount);
    if(state)then
        local item = OverLoadNext();
        SelectItem(nil);
        SelectItem(item);

        --overload状态下不能使用召唤和合体
        for _,item in ipairs(items) do          
            if(item and item.cfg and (item.cfg.type == SkillType.Summon or item.cfg.type == SkillType.Unite or item.cfg.type == SkillType.Transform))then                
                item.SetClickState(false);
            end
        end     
    end    

    SetOverLoadValidState(false);
end

function SetOverLoadValidState(isValid)
--    LogError(tostring(isValid));

    canOverload = isValid;  
    if(not canOverload)then
        CSAPI.SetGOActive(showNameText,false);
    end
--    local greyState = false;

--    if(currCharacter and not canOverload)then
--        local sp,spMax = currCharacter.GetSpInfo();
--        if(sp and spMax and sp == spMax)then
--            greyState = true;
--        end
--    end

--    CSAPI.SetGrey(overloadImg, greyState);
--    CSAPI.SetGOActive(prohibit, greyState);
end


--overload下一个技能
function OverLoadNext()
    if(overloadCount == nil or overloadCount <= 0)then
        return nil;
    end

    if(selItem and selItem.GetClickState())then
        return selItem;
    end

    local count =  #items;
    for i = 1,count do
        local currItem = items[i];
        
        --overload技能必须可用，并且是普通攻击或者普通技能（召唤、合体、被动不行）
        if(currItem ~= nil and currItem.Usable() > 0 and currItem.cfg ~= nil and SkillUtil:IsCanOverload(currItem.cfg.type))then                
            return currItem;
        end
    end         

    return nil;  
end

--初始化skillItem
function InitItems()
    items = {};
    
    local itemRoot = itemGOs.transform;
    local count = itemRoot.childCount;
    for i = 1,count do
        local subItemParent = itemRoot:Find("" .. i);   
        if(not IsNil(subItemParent))then             
            local goSkillItem = nil;

            local isSpe = i >= 4;
            if(isSpe)then
	            goSkillItem = ResUtil:CreateUIGO("Skill/SkillItem1", subItemParent);
            else
                goSkillItem = ResUtil:CreateSkillItem(subItemParent);
            end
            
            local skillItem = ComUtil.GetLuaTable(goSkillItem);
            skillItem.AddClickCallBack(OnClickItem);
            skillItem.InitSetting(i);
            skillItem.PressEnable();
            table.insert(items,skillItem);
        end
    end

    ShowSkills();
end

--初始化skillItem
function InitPlayerSkillItems()
    playerSkillItems = {};
    
    local count = 3;
    for i = 1,count do       	
        local goPlayerSkillItem = ResUtil:CreateUIGO("Skill/PlayerSkillItem", playerSkillItemNodes.transform);
        local playerSkillItem = ComUtil.GetLuaTable(goPlayerSkillItem); 
        playerSkillItem.AddClickCallBack(OnClickPlayerSkillItem);
        playerSkillItem.SetColorIndex(i);
        table.insert(playerSkillItems,playerSkillItem);       
    end

end

function CancelSelect()
    local targetState = GetOverloadState();
    if(targetState)then
        OnClickBtnOverLoad();
    else
        OnClickItem();
    end    
    SetPlayerSkillShowState(false);

    FightClient:SetSelSkill();
end

--显示技能
function ShowSkills(skillList,skillDatas)
--    if(skillList)then
--        LogError("skillList:" .. table.tostring(skillList));
--        LogError("skillDatas:" .. table.tostring(skillDatas));
--    end

    currSkillList = skillList;
    currSkillDatas = skillDatas;
    UpdateMove();

    lastNormalSkill = nil;
    SetOverloadSkill(nil);
    SetOverloadState(false);
    SelectItem(nil);
    --排列技能，召唤和合体放到第四个位置，攻击和技能不能超过3个
    local skills = nil;
    local normalSkillCount = 0;
    if(skillList ~= nil)then
        skills = {};
        local specialSkill = nil;
        for i,v in ipairs(skillList) do
            if(v.type ~= SkillType.Equip)then               
                if(SkillUtil:IsSpecialSkill( v.type))then
                    specialSkill = v;
                elseif(SkillUtil:IsOverloadSkill(v.upgrade_type))then
                    SetOverloadSkill(v);
                else
                    table.insert(skills,v);
                    lastNormalSkill = v;
                end
            end            
        end
        normalSkillCount = #skills;

        if(skills[4] ~= nil)then
            LogError("普通攻击和技能总数不能超过3个");
        end
        if(specialSkill ~= nil)then
            skills[4] = specialSkill;
        end
    end
    
    for i,v in ipairs(items) do
        local  index = i;
        if(i <= normalSkillCount)then
            index = skills and (normalSkillCount - i + 1);
        end
        local cfgSkill = nil;
        if(skills ~= nil)then
            cfgSkill = skills[index];
        end
        local data = nil;
        local skillCostData = nil;
        if(cfgSkill ~= nil)then
            data = skillDatas and skillDatas[cfgSkill.id] or nil;
            
            if(currCharacter)then
               skillCostData = currCharacter.GetSkillCostData(cfgSkill.id);     
            end
        end       
        
        v.InitItem(cfgSkill,data,skillCostData,currCharacter);
    end
end

function SetOverloadSkill(skillData)
    overloadSkill = skillData;
end
function GetOverloadSkill()
    return overloadSkill;
end

function ShowPlayerSkills(playerSkillDatas)
    local i = 1;

    for _,playerSkillItem in ipairs(playerSkillItems)  do
        playerSkillItem.InitItem();
    end
    if(playerSkillDatas)then
        local ids = {};
        for skillId,_ in pairs(playerSkillDatas)do
            table.insert(ids,skillId);
        end

        table.sort(ids, function(a, b)
            return a < b;
        end);

--        LogError(playerSkillDatas);
--        LogError(ids);

        for _,skillId in ipairs(ids)do
            local data = playerSkillDatas[skillId];
            local cfgSkill = Cfgs.skill:GetByID(skillId);
            if(cfgSkill)then
                playerSkillItems[i].InitItem(cfgSkill,data);
            end
            i = i + 1;
        end
    end   
end

--点击技能图标
function OnClickItem(item)
    if(item and item.Usable() <= 0)then
        if(not GetOverloadState() or not lastNormalSkill or item.GetSkillId() ~= lastNormalSkill.id)then
            return;
        end
    end

    if(FightClient:IsAutoFight())then
        --自动战斗不可控制
        return;
    end
  
--    if(overloadCount and overloadCount > 0)then
--        if(item and item.cfg and (item.cfg.type == SkillType.Summon or item.cfg.type == SkillType.Unite or  item.cfg.type == SkillType.Transform))then                
--             return;
--        end
--    end    

    if(GetOverloadState())then   
        local lastSkillItem = GetLastSkillItem();
        if(item ~= lastSkillItem)then
            --SetOverloadState(false);
            CancelSelect();
        end
    end

    SelectItem(item);
end

function OnClickPlayerSkillItem(item)
    if(GetOverloadState())then
        OnClickBtnOverLoad();
        --return;
    end

    OnClickItem(item);

    SetPlayerSkillShowState(false);
end

function ClearSelItem()
    selItem = nil;
end
function SelectItem(targetItem)
--    LogError("点击技能项");
--    LogError(selItem);

    if(selItem ~= nil)then
        if(selItem == targetItem)then
            OnClickBtnOK();
            return;
        end

        selItem.SetSelect(false);
        selItem = nil;
    end

    if(targetItem == nil or targetItem.cfg == nil)then
        --LogError("target item is nil");
        return;
    end
     
    --复活技能
    if(targetItem.IsRelive())then
        reliveSelItem = targetItem;
        local deadDatas = g_FightMgr and g_FightMgr:GetDeathObj(TeamUtil.myNetTeamId);
        if(deadDatas and #deadDatas > 0)then
            CSAPI.OpenView("Relive");
        else
            Tips.ShowTips(LanguageMgr:GetByID(25005));
        end
        return;
    end
    --变身技能
    if(targetItem.IsTransform())then
        transformSelItem = targetItem;
        local transDatas = currCharacter.GetTransDatas();
     
        if(#transDatas > 2)then
            
            CSAPI.OpenView("Transformer",currCharacter.GetID());
        else
            local transformState = currCharacter.GetTransformState();
          
            for _,transData in ipairs(transDatas)do
                if(transData.index ~= transformState)then
                    OnSelectTransformTarget(transData);
                end
            end
        end
        return;
    end
    --合体技能
    if(targetItem.IsCombo())then     
        if(currCharacter and not currCharacter.IsCanCombo())then
            Tips.ShowTips(LanguageMgr:GetByID(1091));
            return;
        end
    end

    selItem = targetItem;   

    if(selItem ~= nil)then
        selItem.SetSelect(true);

        EventMgr.Dispatch(EventType.Input_Select_Skill,targetItem.cfg.id);
    end
end
--复活选择目标回调
function OnSelectReliveTarget(characterGoodsData)
    selItem = reliveSelItem;   
--    if(selItem)then
--        selItem.SetSelect(true);

        local data = {};
        data.characterData = characterGoodsData;
        data.skillId = selItem.GetSkillId();
        EventMgr.Dispatch(EventType.Input_Select_Relive,data);
--    end    
end

function OnSelectTransformTarget(transData)
    selItem = transformSelItem;
    if(selItem)then
        selItem.SetSelect(true);      
        local data = {};
        data.transData = transData;
        data.skillId = selItem.GetSkillId();
        EventMgr.Dispatch(EventType.Input_Select_Transform,data);
    end    
end

--确定技能
function OnClickBtnOK()
    --LogError("选定技能");
    if(overloadCount and  overloadCount > 0)then
        local np = FightClient:GetNp();
        npCost = selItem.GetCostNP();
        if(np < npCost)then
            --Tips.ShowTips(StringConstant.fight_np_no_enough);
            return;
        end

        overloadCount = overloadCount - 1;
        SetOverload(overloadCount);
        RefreshSkillItems();
    end

    local nextItem =  OverLoadNext();  

    EventMgr.Dispatch(EventType.Input_Select_Grid,nextItem == nil);  
    
    if(nextItem ~= nil and nextItem ~= selItem)then
        SelectItem(nextItem);
    end

    SetPlayerSkillShowState(false);
end

--自动战斗切换
function OnFightAutoChanged()
    SetShowState(not FightClient:IsAutoFight());
end

function RefreshSkillItems()

    local np = FightClient:GetNp();

    local npCost = 0;
    if(selItem)then
        npCost = selItem.GetCostNP();
        EventMgr.Dispatch(EventType.Fight_Np_Cost,npCost);  
        np = np - npCost;
        np = math.max(np,0);
    end

    for _,item in ipairs(items) do     
        local npCostTmp = item and item.GetCostNP();
        if(npCostTmp > np)then                
            item.SetClickState(false);
        end
    end      
end

--OverLoad
function OnClickBtnOverLoad()    
    if(FightClient:IsAutoFight())then
        --自动战斗不可控制
        return;
    end

    ShowUnusableTips(overloadStateNum);
  
    if(not canOverload)then
        return;
    end

    if(not GetOverloadSkill())then
        return;
    end
    local lastSkillItem = GetLastSkillItem();
    if(not lastSkillItem)then
        return;
    elseif(lastSkillItem.Usable() <= 0)then
        lastSkillItem.ShowUnusableTips();
        return;
    end


    local targetState = not GetOverloadState();

    if(targetState)then                     
        CSAPI.SetGOActive(effOverload,true);  
        FuncUtil:Call(CSAPI.SetGOActive,nil,500,effOverload,false);        
        if(currCharacter)then
            currCharacter.SetOverloadState(true)           
        end
    else
        if(currCharacter)then
            currCharacter.SetOverloadState(false);
        end
        ShowSkills(currSkillList,currSkillDatas);
    end

    SetOverloadState(targetState);

    local lastSkillItem = GetLastSkillItem();
    if(targetState)then    
        selItem = nil;    
        if(selItem ~= lastSkillItem)then
            OnClickItem(lastSkillItem);                                  
        end    
    else
        EventMgr.Dispatch(EventType.Input_Select_Cancel);  
    end

    
--    CSAPI.OpenView("Dialog",
--    {
--         content = StringConstant.overload_warning,
--         okCallBack = OnOverLoadOK 
--    });
end

function SetOverloadState(state)
    --LogError(tostring(state));

    if(currCharacter)then
        local sp,spMax = currCharacter.GetSpInfo();
        CSAPI.SetText(overload_cost1,(sp or 0) .. "");
        --txtOverload_cost1.text = "<color=#FFC146><size=35>" .. sp .. "</size></color>/100";
        if(overloadBar)then
            if(not IsNil(overloadBar))then
                overloadBar:SetFullProgress(sp,spMax);  
            end 
        end
        --CSAPI.SetGOActive(showNameText,sp == spMax);
        --txtShowName.text = (sp == spMax) and StringConstant.overload_btn_show or "";
    end

    CSAPI.SetGOActive(showNameText,not state );
    CSAPI.SetGOActive(txtCancel,state);
    CSAPI.SetGOActive(onEff,state);
    FightClient:SetSelOverload(state);

     if(state)then
        actionOn:Play();
     else        
        actionOff:Play();        
     end
     


     for _,item in ipairs(items) do     
        local itemState = item.Usable() > 0;
        if(state)then
            if(lastNormalSkill)then
                itemState = item.GetSkillId() == lastNormalSkill.id;

                --切换overload
                if(itemState and overloadSkill)then
                    local cfgOverloadSkill = Cfgs.skill:GetByID(overloadSkill.id);
                    if(cfgOverloadSkill)then  
                        local skillCostData = nil; 
                        if(currCharacter)then
                            skillCostData = currCharacter.GetSkillCostData(overloadSkill.id);     
                        end                     
                        item.InitItem(cfgOverloadSkill,overloadSkill,skillCostData,currCharacter);    
                        item.SetSelect(true);                                         
                    end
                end
            end
        else
            local lastSkillItem = GetLastSkillItem();
            if(lastSkillItem == item)then  
                ClearSelItem();
                if(itemState)then    
                    SelectItem(item);
                else
                    DefaultSelItem();
                end
                       
                
            end
        end 

        item.SetClickState(itemState);        
    end      

    overloadState = state;
    EventMgr.Dispatch(EventType.Input_Overload_State_Changed,state);  
   
end
function GetOverloadState()
    return overloadState;
end

function GetLastSkillItem()    
    local lastNormalSkillId = lastNormalSkill and lastNormalSkill.id;
    local overloadSkillId = overloadSkill and overloadSkill.id;
    
    for _,item in ipairs(items) do     
        local itemSkillId = item.GetSkillId();       
        if(lastNormalSkillId == itemSkillId or overloadSkillId == itemSkillId)then
            return item;
        end
    end      
end

function OnOverLoadOK()    
    FightProto:SendCmd(CMD_TYPE.OverLoad,{state = 1, data={}});   
end

function OnClickPlayerSkill()
    SetPlayerSkillShowState(not playerSkillShowState);
end

function OnClickHidePlayerSkill()
    SetPlayerSkillShowState(false)
end

function SetPlayerSkillShowState(state)
    playerSkillShowState = state;
    --CSAPI.SetGOActive(playerSkillNode,state);

    CSAPI.SetGOActive(btnHidePlayerSkill,state);


--    if(state)then
--        CSAPI.SetAnchor(playerSkillNode,0,0);
--    else
--        CSAPI.SetAnchor(playerSkillNode,0,1000);
--        --FuncUtil:Call(CSAPI.SetAnchor,nil,300,playerSkillNode,0,1000);
--    end

    CSAPI.MoveTo(moveNode,"move_linear_local",state and -500 or 1000,0,0);    
    if(state)then
        CSAPI.ApplyAction(moveNode,"Fade_In_Action");  
    else
        CSAPI.ApplyAction(moveNode,"Fade_Out_100");  
    end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
stateNode=nil;
itemGOs=nil;
onEff=nil;
overload_icon=nil;
cancelNode=nil;
onAction=nil;
offAction=nil;
txtCancel=nil;
showNameText=nil;
overload_cost=nil;
overload_cost1=nil;
btnOverLoad=nil;
moveNode=nil;
playerSkillNode=nil;
title=nil;
playerSkillItemNodes=nil;
btnPlayerSkill=nil;
btnHidePlayerSkill=nil;
enterAction=nil;
exitAction=nil;
view=nil;
end
----#End#----