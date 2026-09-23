local character = nil;
local timeOutValue = nil;
local recordBeginTime = 0;
local currTotalDamage=0;--当前战斗对敌方造成的总伤害值
---是否移动平台
local IsMobileplatform=false;
--inpt
local Input=UnityEngine.Input
local KeyCode=UnityEngine.KeyCode
function Awake()    
 	--添加问号 rui 211130 --因为不是通过openview打开的，所以要手动添加
	--UIUtil:AddQuestionItem("Fight",gameObject, rt,"QuestionItem2")
    CSAPI.Getplatform();
    IsMobileplatform=CSAPI.IsMobileplatform;

    currShowState = false;--当前状态
    ctrlShowState = false;--控制状态

    recordBeginTime = CSAPI.GetRealTime();

    --CSAPI.SetGOActive(nodes,false);
    timeBar = ComUtil.GetCom(goTimeBar,"BarBase");
    txtTime = ComUtil.GetCom(goTimeText,"Text");
    SetTimeOut(nil);

    hpBar = ComUtil.GetCom(goHp,"BarBase");
    if(hpBar)then
        hpBar:SetFormat("<color=#ffffff><size=45>{0}</size></color>/{1}");
    end

    --txtHp = ComUtil.GetCom(goHpText,"Text");
    shieldBar = ComUtil.GetCom(goShield,"BarBase");

    spBar = ComUtil.GetCom(goSp,"BarBase");
    txtSp = ComUtil.GetCom(goSpText,"Text");

    npBar = ComUtil.GetCom(goNp,"BarBase");
    --txtNp = ComUtil.GetCom(goNpText,"Text");
    if(npBar)then
        npBar:SetFormat("<color=#FFC146><size=45>{0}</size></color>/{1}");
    end

    if(npText)then
        CSAPI.SetText(npText,LanguageMgr:GetByID(28014));
    end

    txtName = ComUtil.GetCom(goNameText,"Text");
    txtLv = ComUtil.GetCom(goLvText,"Text");

    local goBuff = ResUtil:CreateUIGO("Fight/BuffActor",buffNode.transform);
    buffView = ComUtil.GetLuaTable(goBuff);

    local goAtkFocus = ResUtil:CreateUIGO("Fight/FightAttackFocus",subViewNode.transform);
    atkFocus = ComUtil.GetLuaTable(goAtkFocus);

--    local goAISetting = ResUtil:CreateUIGO("Fight/FightAISetting",subViewNode.transform);
--    aiSetting = ComUtil.GetLuaTable(goAISetting);
--    atkFocus.SetMovePosFunc(aiSetting.GetBtnPos);

    rootCanvasGroup = ComUtil.GetCom(rootNode, "CanvasGroup");

    rollDamageValue = ComUtil.GetCom(damageValue,"RollValue");
    damageEnter = ComUtil.GetCom(damageEnterAction,"ActionBase"); 
    damageExit = ComUtil.GetCom(damageExitAction,"ActionBase"); 

    rollTotalDamage=ComUtil.GetCom(totalDamageVal,"RollValue");
    local currRound = g_FightMgr and g_FightMgr.stage and g_FightMgr.stage > 0 and g_FightMgr.stage or 1;
    UpdateRound(currRound);

    UpdatePlaySpeed();  

    UpdateTriggerEvent(nil);

    --镜像
    -- if(g_FightMgr and g_FightMgr.type == SceneType.PVPMirror) then
    --     CSAPI.SetGOActive(btnBack,false);
    -- end
    --pvp隐藏暂停
    if(g_FightMgr and IsPvpSceneType(g_FightMgr.type)) then
        --CSAPI.SetGOActive(btnBack,false);
        --CSAPI.SetBtnState(btnSpeed,false); 
        CSAPI.SetGOActive(btnSpeed,false);
    end 

    if(FightClient:IsNewPlayerFight())then
        CSAPI.SetGOActive(btnBack,false);
        CSAPI.SetGOActive(btnAuto,false);
    end
    if(not FightClient:IsCanExit())then        
        CSAPI.SetGOActive(btnBack,false);
    end

    if(not _G.is_fight_ui_res_preloaded)then
        _G.is_fight_ui_res_preloaded = 1;
        PreloadFightUIRes();
        --LogError("预加载战斗ui资源");
    end

    --公会战开启总伤害显示
    if g_FightMgr and g_FightMgr.type==SceneType.GuildBOSS then
         -- UpdateCurrTotalDamage();--目前重连等于重新开始战斗，所以重进/重连都是从零开始统计
        CSAPI.SetGOActive(totalDamageObj,true);
    else
        CSAPI.SetGOActive(totalDamageObj,false);
    end

    --更新默认NP
    UpdateNP({np = g_nEnterNp,max=g_CostMax});

    InitFightInfo();

    if(not PlayerClient:IsPassNewPlayerFight())then
        if(not FightClient:GetDirll())then
            CSAPI.SetGOActive(rt,false);
            FightClient:SetAutoFight(false);
        end
    end

    CheckAutoFightState()
    UpdateAutoFightState();

    local autoState = GetAutoFightState();
    local isTutorialDungeon = DungeonMgr:IsTutorialDungeon();
    if(not autoState or isTutorialDungeon)then
        CSAPI.SetGOActive(autoMask,true);
    end
    local speedState = GetFightSpeedState();
    if(not speedState)then
        CSAPI.SetGOActive(speedMask,true);
    end
    AdaptiveConfiguration.SetLuaObjUIFit("FigHtView",gameObject);
end

function InitFightInfo()
    local info = "";
    if(not g_FightMgr)then
        return;
    end  

    if(IsPvpSceneType(g_FightMgr.type))then
        info = LanguageMgr:GetByID(1080)--StringConstant.fight_info_pvp;
    elseif(g_FightMgr.type == SceneType.PVPMirror)then
        info = LanguageMgr:GetByID(1081)--StringConstant.fight_info_pvpmirror;
    elseif(g_FightMgr.type == SceneType.PVE or g_FightMgr.type == SceneType.SinglePVE)then
        --info = "副本";
        local dungeonId = DungeonMgr:GetCurrId();
        local cfgDungeon = Cfgs.MainLine:GetByID(dungeonId);
        if(cfgDungeon)then            
            if(cfgDungeon.type == eDuplicateType.MainNormal) then
                 info = LanguageMgr:GetByID(15015) .. " " .. tostring(cfgDungeon.chapterID);
            elseif(cfgDungeon.type == eDuplicateType.MainElite) then
                 info = LanguageMgr:GetByID(15016) .. " "  .. tostring(cfgDungeon.chapterID);
            else    
                info = tostring(cfgDungeon.name);
            end
        end
    elseif(g_FightMgr.type == SceneType.Rogue)then
        items2 = items2 or {}
        ItemUtil.AddItems("Rogue/RogueBuffSelectItem2", items2, RogueMgr:GetSelectBuffs(), rogueBuffs)
    elseif (g_FightMgr.type == SceneType.RogueT) then
        CSAPI.SetGOActive(rogutTBuff,true);        
    elseif (g_FightMgr.type == SceneType.TowerDeep) then
        CSAPI.SetGOActive(deepScore,true)
    end
    --CSAPI.SetText(fightInfoText,info);
end

function OnInit()
    InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Input_Target_Changed,OnInputTargetChanged); 
    eventMgr:AddListener(EventType.Fight_Img_Update,ShowCharacter); 
    
    eventMgr:AddListener(EventType.Fight_Info_Update,OnFightInfoUpdate);
    eventMgr:AddListener(EventType.Fight_Np_Cost,OnFightNpCost);
    eventMgr:AddListener(EventType.Fight_Trigger_Event_Update,UpdateTriggerEvent);
    eventMgr:AddListener(EventType.Character_FightInfo_Changed,OnCharacterFightInfoChanged);
    eventMgr:AddListener(EventType.Fight_View_Setting,OnSettingChanged);
    eventMgr:AddListener(EventType.Fight_Damage_Update,OnFightDamageUpdate);
    eventMgr:AddListener(EventType.Fight_Damage_Reshow,ShowLastTotalDamage);
    eventMgr:AddListener(EventType.Fight_Damage_Show_State,OnFightDamageShowState);
    eventMgr:AddListener(EventType.Relogin_Success,OnRelogin);
    eventMgr:AddListener(EventType.Fight_Float_Font,OnFightFloatFont); 
    eventMgr:AddListener(EventType.Fight_Float_Num,OnFightFloatNum); 
    eventMgr:AddListener(EventType.Role_Card_Add, EventCardUpdate)    

    eventMgr:AddListener(EventType.Fight_View_AutoFight_Changed, UpdateAutoFightState)    

    eventMgr:AddListener(EventType.Fight_View_Show_Changed, OnShowStateChanged)
    eventMgr:AddListener(EventType.Fight_View_Main_Info_Show_State, SetShowState);
    
    eventMgr:AddListener(EventType.Fight_Mask, OnFightMask)        

    eventMgr:AddListener(EventType.Fight_UI_Enter_Action,PlayEnterAction); 
       
    eventMgr:AddListener(EventType.Fight_Error_Msg,OnFightErrorMsg);    

    eventMgr:AddListener(EventType.Fight_SetSettingBtn,OnSetSettingBtnState);    

    eventMgr:AddListener(EventType.Fight_SkipCast2,OnPlayCastSkipSound);    

    eventMgr:AddListener(EventType.Fight_Action_Turn_Add1,TurnNumAdd);    
    
    eventMgr:AddListener(EventType.Fight_Activity_UpdateDamage,OnFightActivityUpdateDamage);    
   
    eventMgr:AddListener(EventType.Fight_Play_Face,PlayHeadFace);--表情     
    --PlayHeadFace({{id=1,delay=500},{id=2,delay=1000}});
end
function OnDestroy()
    AdaptiveConfiguration.LuaView_Lua_Closed("FigHtView");
    eventMgr:ClearListener();

    local fightDungeonId = DungeonMgr:GetCurrFightId() or 0;
    if(fightDungeonId)then
        RecordMgr:Save(RecordMode.Fight,recordBeginTime,"duplicateID=" .. fightDungeonId);
    end
end

function OnFightActivityUpdateDamage(apiData)
    --LogError("更新伤害信息：" .. table.tostring(apiData));
    SetTotalDamage(apiData.nTotalDamage  or 0);
end

function OnSetSettingBtnState(state)
    --setbt
    CSAPI.SetBtnState(btnBack,state);
end

function OnRelogin()
    if(not g_FightMgr)then
        return;
    end

    if(IsPvpSceneType(g_FightMgr.type))then
        FightClient:SetStopState(false);
	    FightActionMgr:Surrender({ fight_error_msg = "" });
        --FightProto:RestoreFight();
    else
        
        local isMyTurn = character and character.IsMine();
        if(isMyTurn and FightClient:IsAutoFight())then         
            FightClient:SendAutoFight();
        end
    end   
end

function OnPlayCastSkipSound()
    local cfgModel = character and character.GetCfgModel();
    if(cfgModel)then
        CSAPI.PlayRandSound(cfgModel.s_skipcast2,true);
    end
end

function OnSettingChanged(settingData)
    if(settingData)then
        closeNpValue = settingData.closeNpValue;
    end
end

function SetShowState(state)
    --LogError(tostring(state));
    CSAPI.SetAnchor(rootNode,state and 0 or 10000,0);
    --CSAPI.SetGOActive(rootNode,state);
    if(rootCanvasGroup)then        
        rootCanvasGroup.alpha = state and 1 or 0;
    end
end

function OnInputTargetChanged(fightAction)
    local id = nil;
    if(fightAction ~= nil)then
        id = fightAction:GetActorID();
    end

    if(not id)then
        SetTimeOut(nil);
        return;
    end

    ShowCharacter( CharacterMgr:Get(id));
end
--显示指定角色
function ShowCharacter(showCharacter)
    character = showCharacter;
    if(character == nil)then
        return;
    end
        
    if(g_FightMgr and IsPvpSceneType(g_FightMgr.type))then
        local isMyTurn = character.IsMine();
        SetTimeOut(g_fightControlTime or 20);
        --CSAPI.SetText(goActionTips,isMyTurn and "" or "");
--        else
--            SetTimeOut(nil);
    end


    txtName.text = character.GetName();
    txtLv.text = "<size=25>" .. LanguageMgr:GetByID(1033) .. "</size>" .. character.GetLv();
    local cfg = character.GetCfgModel();      
    if(cfg == nil)then
        return; 
    end

    ResUtil.FightCard:Load(paintImg,cfg.Fight_head);

    UpdateInfo();
end

function OnFightInfoUpdate(fightActionDatas)
    UpdateRound(fightActionDatas.round);
    UpdateTurn(fightActionDatas.turnData);
  
    local npData = fightActionDatas.npData;
    if(npData)then
        local teamId = TeamUtil:ToClient(npData.teamID); 
        if(not TeamUtil:IsEnemy(teamId))then        
            UpdateNP(npData);
        end
    end

    UpdateTowerDeepScore()
end
function OnFightNpCost(data)
    if(data and data > 0)then
        local currNp = FightClient:GetNp();
        currNp = currNp - data;
        if(currNp < 0)then
            currNp = 0;
        end
        UpdateNP({ np = currNp});
    end
end

function OnCharacterFightInfoChanged(target)
    if(character ~= target)then
        return;
    end

    UpdateInfo();
end

function OnFightDamageShowState(state)
    totalDamageShowState = state;
    if(not totalDamageShowState)then
        UpdateDamageValue(nil);
    end
end
--伤害更新
function OnFightDamageUpdate(value)
    if(not totalDamageShowState)then
        return;
    end

    if(value)then
        AddDamageValue(value);
    else
        UpdateDamageValue(nil);
    end

    UpdateCurrTotalDamage();
    
    UpdateTowerDeepScore()
end

function UpdateCurrTotalDamage()
    if(g_FightMgr and g_FightMgr.type==SceneType.GuildBOSS) then --统计当前对敌方造成的总伤害
		local tempTotal=0;
		if	g_FightMgr.tDamageStat and g_FightMgr.tDamageStat[1] then
			for k,v in pairs(g_FightMgr.tDamageStat[1]) do
				tempTotal=tempTotal+v;
			end
		end
        if tempTotal>currTotalDamage then--增长才更新
            rollTotalDamage:SetValue(tempTotal);
            currTotalDamage=tempTotal;
        end
	end
end

--更新深塔计划分数
function UpdateTowerDeepScore()
    if not g_FightMgr or g_FightMgr.type ~= SceneType.TowerDeep then
        return
    end
    CSAPI.SetText(txtDeepScore,g_FightMgr:GetTowerDeepScore() .. "")
end

function SetTimeOut(value)
    if(value and myUpdater == nil)then
        myUpdater = CSAPI.CreateGO("Updater",0,0,0,gameObject);
        luaUpdater = ComUtil.GetLuaTable(myUpdater);
        luaUpdater.SetFunc(TimeUpdate);
    end

    CSAPI.SetGOActive(timeNode,value ~= nil);

    --local isCountDownStarted = timeOutValue;
    timeOutValue = value and (CSAPI.GetRealTime()) + value or nil;
    if(value)then        
        --if(not isCountDownStarted)then
            Log( "pvp计时开始");
            g_FightMgr:CountdownBegins();
        --end
        timeStart = CSAPI.GetRealTime();  
    end   
end

function TimeUpdate()
    if(not timeOutValue)then
        return;
    end

    local totalTime = timeOutValue - timeStart;
    totalTime = math.max(totalTime,1);
    local leftTime = timeOutValue - CSAPI.GetRealTime();
    leftTime = math.max(leftTime,0);
    local t = leftTime / totalTime;
     
    timeBar:SetProgress(t);   
    if(txtTime)then
        txtTime.text = math.ceil(leftTime) .. "";
    end
    --LogError("剩余时间：" .. leftTime);
    if(leftTime <= 0)then
        local isMyTurn = character and character.IsMine();      
        if(isMyTurn and not FightClient:IsAutoFight())then
            OnClickBtnAuto();
            Log( "PVP思考时间到，自动切换到托管模式");
            --g_FightMgr:SetTrusteeship(true);
        end

        timeOutValue = nil;
    end
    --txtTime.text = math.floor(leftTime) .. "";    
end

function UpdateRound(data)
    if(data ~= nil)then
        if(txtRound == nil)then
            txtRound = ComUtil.GetCom(round,"Text");
        end
        local round = math.max(1,math.min(3,data));     
        local totalWave = math.min(3,FightClient:GetTotalWave());   
        txtRound.text = round .. "/" .. math.min(3,FightClient:GetTotalWave());
    end
end

--回合数+1
function TurnNumAdd()
    if(turnData)then
        turnData.add1 = 1;
        --LogError(turnData.turnNum + 1);
        UpdateTurn(turnData);
    end
end

function UpdateTurn(data)
    if(data)then
        turnData = data;        
        if(txtTurn == nil)then
            txtTurn = ComUtil.GetCom(turn,"Text");
        end
        local turnNum = data and data.turnNum or 1;
        --turnNum = math.max(1,turnNum);
        local turnNumLimit = data and data.nStepLimit or 0;--"--";
        local turnLeft = turnNumLimit - turnNum + 1;
        local colorStr = "FFFFFF";
        if(turnLeft and turnLeft >= 0)then
            local isWarning,enterWarning = FightClient:IsWarningTurn(turnLeft);            
            
            if(isWarning)then             
                CSAPI.OpenView("TurnWarning",turnLeft);          
            end

            local warningEff;

            if(enterWarning)then
                warningEff = 1;
                colorStr = "FF2222";
            else
                local warning1 = g_turn_timeout_eff;
                if(warning1 and warning1 >= turnLeft)then 
                    warningEff = 1;   
                    colorStr = "FF0040";                
                end
            end
            
            if(warningEff)then
                CSAPI.SetGOActive(bgTurnWarning,true); 
                --ResUtil:CreateUIGO("Fight/FightWarningEff",turn.transform);  
            end           
        end
        local str = turnNumLimit >= 100 and "" or ("/" .. turnNumLimit);

        if(turnData and turnData.add1)then
            turnNum = turnNum + 1;
        end

        txtTurn.text = string.format("<color=#%s>%s</color>%s",colorStr,turnNum,str);                   
    end
    
end

--function CreateTurnWarning(leftTurnNum)
--    local go =  ResUtil:CreateUIGO("Fight/FightTurnWarning",transform);
--    local lua = ComUtil.GetLuaTable(go);
--    lua.SetValue(leftTurnNum);
--end

function UpdateNP(data)    
    if(data ~= nil)then
--        if(not showNp)then
--            showNp = 1;
--            CSAPI.SetGOActive(enterActionNP,true);
--        end


        local curr = data.np or 0;
        local max = data.max or g_CostMax;        
        UpdateBar(npBar,nil,curr,max,false);        
        --txtNp.text = curr .. "<color=#aaaaaa>/" .. max .. "</color>";
        --txtNp.text = curr .. "/" .. max;
        --txtNp.text = "<color=#FFC146><size=35>" .. curr .. "</size></color>/" .. max;
        if(closeNpValue == nil)then
            if(data.add)then
               ApplyCreateNP(data.add);
            end
        end
        FightClient:SetNp(curr);
    end
end

function PlayEnterAction()
    played = 1;
    CSAPI.SetGOActive(enterAction,true);   

    local state = GetShowState();
    if(state)then        
        PlayEnterActionNP();
    else
        OnShowStateChanged(true);
    end
end

function PlayEnterActionNP()
    if(not played)then
        return;
    end

    SetEnterActionNPState(false);
    SetEnterActionNPState(true);
    --FuncUtil:Call(SetEnterActionNPState,nil,500,true);
end

function SetEnterActionNPState(state)
    CSAPI.SetGOActive(enterActionNP,state);
end

--function Update()
--    if(CS.UnityEngine.Input.GetKey(CS.UnityEngine.KeyCode.RightControl) and CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.E))then        
--        ApplyCreateNP(5);   
--    end
--end

function ApplyCreateNP(npValue)   
   
    local currTime = CSAPI.GetTime();  
    if(nextNpTime and nextNpTime > currTime)then
        local delay = math.floor((nextNpTime - currTime) * 1000);
        --LogError(delay);
        FuncUtil:Call(CreateNP,nil,delay,npValue);

        nextNpTime = nextNpTime + 0.2;
    else
       --LogError("aa");
       nextNpTime = currTime + 0.2;
       CreateNP(npValue);
    end     
end

function CreateNP(npValue)   
    local go =  ResUtil:CreateUIGO("Fight/NPValue",npFloatNode.transform);
    local lua = ComUtil.GetLuaTable(go);
    lua.SetValue(npValue);
end

--更新协战头像
function UpdateTriggerEvent(data)    
    if(data)then

        local go =  ResUtil:CreateUIGO("Fight/FightTriggerEventItem",eventItems.transform);
        local lua = ComUtil.GetLuaTable(go);
        lua.SetData(data);    

--        triggerEventItems = triggerEventItems or {};
--        table.insert(triggerEventItems,lua);
--    else
--        if(triggerEventItems)then
--            for _,item in ipairs(triggerEventItems)do
--                item.ApplyRemove();
--            end

--            triggerEventItems = nil;
--        end        
    end
end

--回城
function OnClickBtnBack()
    if(DungeonMgr:IsTutorialDungeon() and GuideMgr:HasGuide("Fight"))then      
        --Tips.ShowTips("特殊关卡，暂不能操作")
        return;
    end
    --LogError("aaa");
    CSAPI.OpenView("FightMenu");
    FightClient:SetPauseState(true);
end

--测试移动
function OnClickBtnMove()     
   EventMgr.Dispatch(EventType.Fight_Move_Character);
end

function UpdateInfo()
    if(character ~= nil)then
        if(not showCharacterInfo)then
            showCharacterInfo = 1;
            CSAPI.SetGOActive(enterActionInfo,true);
        end

        local currHp,maxHp,buffHp = character.GetHpInfo();
   
        UpdateBar(hpBar,nil,currHp,maxHp,false);

        local overflow = maxHp > 100000000;--血量溢出
        if(overflow)then
            if(not txtHp)then
                CSAPI.SetGOActive(goHpText,false);
                CSAPI.SetGOActive(goHpText1,true);

                txtHp = ComUtil.GetCom(goHpText1,"Text");                
            end
            if(txtHp)then
                txtHp.text = "<color=#ffffff><size=45>" .. currHp .. "</size></color>/" .. maxHp;
            end
        else
            if(txtHp)then
                CSAPI.SetGOActive(goHpText,true);
                CSAPI.SetGOActive(goHpText1,false);
                
                txtHp = nil;
            end             
        end
        --UpdateBar(shieldBar,nil,currHp + buffHp,maxHp,true);
        --UpdateBar(spBar,nil,character.sp,character.spMax,true);
        
        UpdateBuff();
    end
end

function UpdateBar(bar,txt,curr,max,immediately)
    curr = math.floor(0.5 + curr or 0);
    max = math.floor(0.5 + max or 1);
    --local progress = curr / max;
    if(not IsNil(bar))then
        bar:SetFullProgress(curr,max,immediately);  
    end 
    if(not IsNil(txt))then
        txt.text = curr ..  "<color=#aaaaaa>/" .. max .. "</color>";
        --txt.text = curr .. "";
    end
end
--更新Buff
function UpdateBuff()
    local buffs = character.GetBuffs();

    local buffState = false;
    for _,buff in pairs(buffs)do
        if(buff:IsShow())then
            buffState = true;
            break;
        end
    end
    CSAPI.SetGOActive(buffBg,buffState);

    buffView.UpdateBuff(buffs);
end


-----播放速度调整
function OnClickBtnSpeedUp()
    FightClient:AddPlaySpeed(1);
    UpdatePlaySpeed();
end
function OnClickBtnSpeedDown()
    FightClient:AddPlaySpeed(-1);
    UpdatePlaySpeed();
end
function OnClickBtnSpeedOrigin()
    FightClient:SetPlaySpeed();
    UpdatePlaySpeed();
end

function UpdatePlaySpeed()
--    if(txtPlaySpeed == nil)then
--        txtPlaySpeed = ComUtil.GetCom(playSpeed,"Text");
--    end
--    txtPlaySpeed.text = "播放速度：" .. FightClient:GetPlaySpeed();

    local speed = FightClient:GetPlaySpeed();
    local speed1,speed2,speed3 = FightClient:GetPlaySpeedSetting();
    
    --CSAPI.SetText(goSpeed,(speed == speed1) and "x1" or "x2");
    CSAPI.SetGOActive(goSpeed1,speed == speed1);
    CSAPI.SetGOActive(goSpeed2,speed == speed2);
    if(goSpeed3 and speed3)then
        CSAPI.SetGOActive(goSpeed3,speed == speed3);
    end
end

function GetFightSpeedState()
    return MenuMgr:CheckModelOpen(OpenViewType.special, SpecialOpenViewType.SpeedFight);
end

function OnClickBtnSpeed()
    local b, str = GetFightSpeedState();
	if(not b) then
		Tips.ShowTips(str)
		return
	end 


   if(g_FightMgr and IsPvpSceneType(g_FightMgr.type))then
       --Tips.ShowTips(StringConstant.fight_pvp_tips_1);
       return;
   end   

    local speed = FightClient:GetPlaySpeed();
    local speed1,speed2,speed3 = FightClient:GetPlaySpeedSetting();
    if(speed == speed1)then
        speed = speed2;
    elseif(speed == speed2)then
        speed = speed3 or speed1;
    elseif(speed3 and speed == speed3)then
        speed = speed1;
    else
        speed = speed1;
    end
    --speed = speed ~= speed2 and speed2 or speed1;
    FightClient:SetPlaySpeed(speed);
    --LogError(speed);
    UpdatePlaySpeed();
    --CSAPI.SetText(goSpeed,(speed == speed1) and "x1" or "x2");
end

function GetAutoFightState()
   local b, str =  MenuMgr:CheckModelOpen(OpenViewType.special, SpecialOpenViewType.AutoFight);    
   return b,str;
end

--自动战斗
function OnClickBtnAuto()
	local b, str = GetAutoFightState();
	if(not b) then
		Tips.ShowTips(str)
		return
	end    

    if(DungeonMgr:IsTutorialDungeon())then
        Tips.ShowTips(LanguageMgr:GetTips(8021));
        return;
    end


    EventMgr.Dispatch(EventType.Input_Select_Cancel);  

   FightClient:ChangedAutoFight();
   UpdateAutoFightState();
   FightClient:SetAutoFight(FightClient:IsAutoFight());
   EventMgr.Dispatch(EventType.Input_Auto_Change);

   

   if(g_FightMgr and IsPvpSceneType(g_FightMgr.type))then
       if(FightClient:IsAutoFight() == false)then
            Log( "取消PVP自动战斗");
            g_FightMgr:SetTrusteeship(false);
       end
   end

   
end 

--强制改为非自动
function CheckAutoFightState()
    --local b = UIUtil:CheckConditionMore(SpecialOpenViewType.AutoFight)
    local b = GetAutoFightState();
    if(not b and FightClient:IsAutoFight()) then 
        FightClient:ChangedAutoFight();
    end 
end


function UpdateAutoFightState()
    CSAPI.SetGOActive(autoState,FightClient:IsAutoFight());
    CSAPI.SetGOActive(autoState1,not FightClient:IsAutoFight());
  
    atkFocus.SetShowState(FightClient:IsAutoFight());
    --aiSetting.SetShowState(FightClient:IsAutoFight());
end

function SetTotalDamage(val)
    FightClient:SetTotalDamage(val);
    CSAPI.SetGOActive(damageInfoTotal,true);
    rollTatalDamageValue = rollTatalDamageValue or ComUtil.GetCom(totalDamageValue,"RollValue");
    if(not IsNil(rollTatalDamageValue))then
        rollTatalDamageValue:SetCurr(val);
    end
end

--添加伤害数值
function AddDamageValue(value)
    --忽略负数
    if(value and value < 0)then
        return;
    end

    if(totalDamage == nil and value)then
        totalDamage = 0;              

        damageEnter:Play();
        rollDamageValue:SetCurr(0);        
    end

    totalDamage = totalDamage or 0;
    totalDamage = totalDamage + value;
    UpdateDamageValue(totalDamage);
end

function ShowLastTotalDamage()
    if(lastTotalDamage)then       
        totalDamage = nil; 
        AddDamageValue(lastTotalDamage);
        FuncUtil:Call(UpdateDamageValue,nil,1000);
    end
end

--更新伤害数据
function UpdateDamageValue(value)
    --CSAPI.SetGOActive(damageInfo,value ~= nil);
    if(value == nil)then
        if(totalDamage)then
            lastTotalDamage = totalDamage;
            totalDamage = nil;   
            damageExit:Play();
        end
    else
        rollDamageValue:SetValue(value);
    end
end

function OnClickCreateEffect()
    inputEff = ComUtil.GetCom(effInputField,"InputField");
    ResUtil:CreateEffect(inputEff.text,0,0,0);
end


--创建角色飘字
function OnFightFloatFont(data)
    if(_G.no_float_font)then
        return;
    end

    local floatFontRes = data.floatFontRes or "Common/FloatFontItem";
    local go = ResUtil:CreateUIGO(floatFontRes,transform);
    local lua = ComUtil.GetLuaTable(go);
    lua.Set(data);
end

function OnFightFloatNum(data) 
    if(_G.no_float_font)then
        return;
    end

    local go = ResUtil:CreateUIGO("Fight/" .. data.res,transform);
    local lua = ComUtil.GetLuaTable(go);
    lua.Set(data);
end

--获得新卡牌
function EventCardUpdate(data)
    if data~=nil and data.isAdd==true then
        local showList={}
		for k,v in ipairs(data.card) do
			local card=RoleMgr:GetData(v.cid);
			if card then
				if card:GetQuantity()<2 then --新获得的卡牌
					table.insert(showList,{sid=v.cid,num=1});
				elseif card:GetQuality()>CardQuality.SR then --卡牌品质大于SR必定显示
					table.insert(showList,{sid=v.cid,num=2});
				end
			end
		end
		if #showList>0 then
			BattleMgr:SetShowCardData(showList); 
		end
    end
end

--查看正在战斗的角色信息
function OnClickPaint()
    if(character)then
        if(FightClient:GetInputCharacter())then
            local id = character.GetID();
            --if (g_FightMgr and not IsPvpSceneType(g_FightMgr.type) and g_FightMgr.type ~= SceneType.PVPMirror) or _G.showPvpRoleInfo then --非PVP界面可以打开查看数据
            if g_FightMgr and not IsPvpSceneType(g_FightMgr.type) or _G.showPvpRoleInfo then --非PVP界面可以打开查看数据
                CSAPI.OpenView("FightRoleInfo",id);
            end
        end
        EventMgr.Dispatch(EventType.Character_FightInfo_Log,id);
    end
end

--自动战斗切换
--function OnFightAutoChanged()
--    UpdateShowState(not FightClient:IsAutoFight());
--end

function OnShowStateChanged(state)
    ctrlShowState = state;
    UpdateShowState();
end

function UpdateShowState()
    local newState = GetShowState();

    if(currShowState == nil)then
        currShowState = true;
    end    

    if(newState == currShowState)then
        return;
    end
    currShowState = newState;

    if(newState)then
        PlayEnterActionNP();        
    else
        CSAPI.ApplyAction(npNode,"Np_Fade_To_Out");
    end
end

function GetShowState()
    --LogError("ctrlShowState：" .. tostring(ctrlShowState) .. "，AutoFight："  .. tostring(FightClient:IsAutoFight()));
    return ctrlShowState;-- and not FightClient:IsAutoFight() and true or false;
end

function OnFightErrorMsg(errContent)
    CSAPI.OpenView("Dialog",
	{
		content = errContent,
		okCallBack = function()
            FightClient:ForceQuit();			
		end,
		cancelCallBac = okCallBack
	});
end

function OnFightMask(characterID)
    CSAPI.SetGOActive(cast2Mask,true);
    local delayCloseTime = 1500;
    --LogError(tostring(characterID));
    local character = characterID and CharacterMgr:Get(characterID);
    if(character)then
        delayCloseTime = 2200;

        local cfgModel = character.GetCfgModel();  
        ResUtil.Cast2Card:LoadSR(Role,cfgModel.cast2_card);  
        ResUtil.Cast2Card:LoadSR(Role_white_flicker,cfgModel.cast2_card);  
        ResUtil.Cast2Card:LoadSR(Role_white,cfgModel.cast2_card);    
--        ResUtil.Cast2Card:LoadSR(Cast2ShowRole_Role,cfgModel.card_icon1);

        local cfg = character.GetCfg();
        local starLv = cfg and cfg.quality or 3;     
        local isOverLoad = character.GetOverloadState();

        CheckAutoSkipCast2(character);  

        ActiveCast2Mask(starLv,isOverLoad,character.IsSkipSkill());    
                    
    else
        delayCloseTime = 1000;
        CSAPI.SetGOActive(Cast2ShowRole_ToWhite,true);
        FuncUtil:Call(function()
            CSAPI.SetGOActive(Cast2ShowRole_ToWhite,false);
            CSAPI.SetGOActive(Cast2ShowRole_EndLine,true);
            CSAPI.SetGOActive(effEnd,true);
        end,nil,500);        
    end
    
    FuncUtil:Call(RecoverCast2Mask,nil,delayCloseTime,true);
end

--自动跳过大招检测
function CheckAutoSkipCast2(character)    

    --LogError(SceneType);
    --LogError(g_FightMgr.type);
    
    local skipPlay = nil;
    local skipSettingVal = SettingMgr:GetValue(s_fight_action_key);

    local fightAction = character.GetFightAction();
    local skillID = fightAction and fightAction:GetSkillID();  
    local cfgSkill = Cfgs.skill:GetByID(skillID);
    
    --if(not cfgSkill or (cfgSkill.type ~= SkillType.Summon and cfgSkill.type ~= SkillType.Unite))then--不是召唤和同调
    --if(not cfgSkill)then
    
        if(skipSettingVal == SettingFightActionType.Close)then
            skipPlay = 1;
        else            
            local skillKey = tostring(skillID); 
            local currPlayTime = os.date("%d");   
            
            if(skipSettingVal == SettingFightActionType.Once)then                   
                local lastPlayTime = PlayerPrefs.GetString(skillKey);
                if(lastPlayTime == currPlayTime)then
                    skipPlay = 1;
                end                
            end       

            PlayerPrefs.SetString(skillKey,currPlayTime);
        end
    --end
    
    if(g_FightMgr and (g_FightMgr.type == SceneType.PVP or g_FightMgr.type == SceneType.PVEFreeMatch or g_FightMgr.type == SceneType.PVP3 or g_FightMgr.type == SceneType.PVEFreeMatch3)) then
        skipPlay = true;
    end 

    if(skipPlay)then
        character.SetSkipSkill(true);
        --EventMgr.Dispatch(EventType.Fight_Skill_Skip_Next);
    end 
end


function ActiveCast2Mask(starLv,isOverLoad,skipSkill)
    CSAPI.SetGOActive(this["Cast2ShowRole_" .. starLv],true);
--    if(not roleAnimator)then
--        roleAnimator = ComUtil.GetComInChildren(Cast2ShowRole_Role,"Animator");
--    end
--    roleAnimator:Play("State_" .. starLv);
    CSAPI.SetGOActive(Cast2ShowRole_Role,true);
    if(isOverLoad)then
        CSAPI.SetGOActive(Cast2ShowRole_OverLoad,isOverLoad);
    end
    if(skipSkill)then
        FuncUtil:Call(RecoverCast2Mask,nil,2400);
    else
        FuncUtil:Call(ActiveToWhite,nil,1650);    
        FuncUtil:Call(ActiveCast2MaskComplete,nil,1950);
    end
    --直播模式 
    local value = SettingMgr:GetValue(s_other_live_key)
    if(value==1) then 
        CSAPI.SetGOActive(this["Cast2ShowRole_" .. starLv],false)
        CSAPI.SetScale(Role,0,0,0)
    else 
        CSAPI.SetScale(Role,150,150,1)
    end
end

function ActiveToWhite()
    CSAPI.SetGOActive(Cast2ShowRole_ToWhite,true);
end

function ActiveCast2MaskComplete()
    RecoverCast2Mask();
    CSAPI.SetGOActive(Cast2ShowRole_EndLine,true);
end

function RecoverCast2Mask(disableRootNode)
    for i = 3,6 do
        CSAPI.SetGOActive(this["Cast2ShowRole_" .. i],false);
    end
    CSAPI.SetGOActive(Cast2ShowRole_Role,false);
    CSAPI.SetGOActive(Cast2ShowRole_OverLoad,false);
    CSAPI.SetGOActive(Cast2ShowRole_EndLine,false);
    CSAPI.SetGOActive(Cast2ShowRole_ToWhite,false);
    CSAPI.SetGOActive(effEnd,false);
    if(disableRootNode)then
        CSAPI.SetGOActive(cast2Mask,false);
    end
end


--预加载战斗ui资源
function PreloadFightUIRes()

    PreloadRes("Fight/Damage",10);
    PreloadRes("Fight/Damage_1",10);
    PreloadRes("Fight/Damage_2",10);
    PreloadRes("Fight/Damage_Crit",5);
    PreloadRes("Fight/Damage_Crit_1",5);
    PreloadRes("Fight/Damage_Crit_2",5);
    PreloadRes("Fight/CureValue",5);    
    PreloadRes("Fight/NPValue",10);


    PreloadRes("Common/FloatFontItem",10);
    PreloadRes("Common/FloatFontItem_1",5);
end

function PreloadRes(res,count)
    local resGOs = {};
    for i = 1,count do
        local go = ResUtil:CreateUIGO(res,transform);
        table.insert(resGOs,go);
    end

    for _,go in ipairs(resGOs) do
        CSAPI.RemoveGO(go);
    end
end


function OnClickQuestion()
    local cfg = Cfgs.CfgModuleInfo:GetByID("Fight")
    if(cfg) then 
        CSAPI.OpenView("ModuleInfoView", cfg)
    end 
end


function OnClickRogutTBuff()
    CSAPI.OpenView("RogueTCurBuff",nil,1)
end

-----------------------------------------------虚拟返回键代码 下-------------------------------------------------------------

--OnClickBtnBack
function Update()
    CheckVirtualkeys()
end
---判断检测是否按了返回键
function CheckVirtualkeys()
    --仅仅安卓或者苹果平台生效
    if IsMobileplatform then
        if(Input.GetKeyDown(KeyCode.Escape))then
            if  OnClickBtnBack then
                if CSAPI.IsBeginnerGuidance()==false then
                    if FightClient.IsFightStop and FightClient.IsFightOver==false then
                        OnClickBtnBack();
                    else
                        FightClient.IsFightStop=true;
                    end
                end
            end
        end
    end
end
-----------------------------------------------虚拟返回键代码 上-------------------------------------------------------------

--播放表情
function PlayHeadFace(faceData)
    --LogError(faceData);
    if(not faceData)then
        return;
    end
    local faceData1,faceData2 = faceData[1],faceData[2];
    if(faceData1)then
        FuncUtil:Call(function()
            AddFace(faceData1.id,true);    
        end,nil,faceData1.delay or 0);        
    end
    if(faceData2)then
        FuncUtil:Call(function()
            AddFace(faceData2.id,false);   
        end,nil,faceData2.delay or 0);    
    end
end
function AddFace(id,isL)
    local faceGO = ResUtil:CreateUIGO("Fight/FaceNode" .. (isL and "L" or "R"),transform);
    local lua = ComUtil.GetLuaTable(faceGO);
    lua.PlayHeadFace(id,isL);
end