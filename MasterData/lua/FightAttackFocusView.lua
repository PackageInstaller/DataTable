--集火界面

--设置显示状态
function SetShowState(state)      
    --LogError("Set Attack Focus State:" .. tostring(state));

    local playAction = showState ~= state;    

    showState = state;
    --LogError("showState:" .. tostring(showState));
    --CSAPI.SetGOActive(nodes,state);    

    if(playAction)then
        if(showState)then
            PlayEnterAction();
        else
            CSAPI.ApplyAction(moveNode,"Fade_Out_100");    
            ToHide();
        end

        CSAPI.MoveTo(moveNode,"move_linear_local",showState and 0 or 2000,0,0);    
    end

    if(showState)then
        ApplyRefresh();
    end

    Init();
end

local attackFocusState = "attack_focus";
function Init()
    local state = PlayerPrefs.GetInt(attackFocusState) or 0;
    OnClickShowBtn(state == 0);
end

function PlayEnterAction()
    if(not canPlay)then
        return;
    end

    if(not IsNil(actionEnter))then
        actionEnter.delay = 400;
        actionEnter:Play();
    end
end
function GetShowState()
    return showState;
end

function Awake()
    actionEnter = ComUtil.GetCom(enterAction,"ActionBase"); 
    UpdateSelItem();
    ApplyRefresh();
end

function OnInit()
    InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Character_Create,OnCharacterFightInfoChanged); 
    eventMgr:AddListener(EventType.Character_Dead,OnCharacterFightInfoChanged); 
    eventMgr:AddListener(EventType.Fight_UI_Enter_Action,PlayEnterAction); 
    eventMgr:AddListener(EventType.Fight_UI_Enter_Action,OnStartPlayEnterAction);  
    eventMgr:AddListener(EventType.Fight_Focus_Show,OnClickShowBtn);       

    eventMgr:AddListener(EventType.Character_FightInfo_Changed,OnCharacterInfoChanged);
end
function OnDestroy()
    eventMgr:ClearListener();
end

function OnCharacterInfoChanged(character)
    if(not viewState)then
        return;
    end
    local item = RefreshCharacter(character);
    if(item)then
        item.UpdateHp();
    end
end

function OnStartPlayEnterAction()
    canPlay = 1;
    if(showState)then
        PlayEnterAction();
    end
end

function OnCharacterFightInfoChanged(data)
    if(not GetShowState())then
        return;
    end

    if(applyRefresh)then
        return;
    end
    applyRefresh = 1;

    FuncUtil:Call(ApplyRefresh,nil,10);
end

function SetMovePosFunc(call)
    --将世界坐标转为本地坐标
    moveCall=call;
end

function GetMoveX()
    local moveX=0;
    if moveCall then
        local movePox=moveCall();
        local p2=mask.transform:InverseTransformPoint(UnityEngine.Vector3(movePox[1],movePox[2],movePox[3]));
        moveX=p2.x;
    end
    return moveX;
end

--刷新
function ApplyRefresh()
    applyRefresh = nil;
    --LogError("刷新AI激活");
    local characters = CharacterMgr:GetAll();
    if(characters)then
        for _,character in pairs(characters)do
            RefreshCharacter(character);
        end
    end
    
    if(items)then
        for character,item in pairs(items)do
            if((character.IsDead() and character.IsDeadPlayed()) or (not CharacterMgr:Get(character.GetID())))then
                items[character] = nil;
                item.Remove();
                --FuncUtil:Call(item.Remove,nil,100);
            else
                if(viewState)then
                    item.ApplyRefresh();
                    item.UpdateHp();
                end
            end            
        end
    end   

--    if(currItem)then
--        UpdateCurrItemHp();
--    end
end

function RefreshCharacter(character)
    if(not character or not character.IsEnemy or  not character.IsEnemy())then
        return;
    end

--    local rowIndex,colIndex = character.GetCoord();
--    if(not rowIndex or rowIndex < 1)then
--        return;
--    end

    local item = GetItem(character);
    return item;
end

function GetItem(character)
    items = items or {};
    local item = items[character];
    if(not item and not character.IsDead())then
        local go = ResUtil:CreateUIGO("Fight/FightAttackFocusItem",itemNode.transform);
        item = ComUtil.GetLuaTable(go);
        item.Set(character);
        item.SetClickCallBack(OnClickItem);
        items[character] = item;
    end

    return item;
end

function OnClickItem(clickItem)
    local selItem = nil;
    if(items)then
        for _,item in pairs(items)do
            local state = item.SetGoalState(item == clickItem);      
            if(state)then
                selItem = clickItem;
            end      
        end
    end  
    
    UpdateSelItem(selItem); 
end

function UpdateSelItem(item)
    currItem = item;
end

function OnClickShowBtn(state)
    if state then
        ToShow();
    else
        ToHide()
    end
end

function OnClickShow()
    ToShow();
    PlayerPrefs.SetInt(attackFocusState,0);
end
function ToShow()
    viewState = true;

    CSAPI.SetGOActive(clickMask,true);
    FuncUtil:Call(CSAPI.SetGOActive,nil,300,goBtnHide,true);
    SetShowBtnState(false);
    CSAPI.MoveTo(actionNode,"move_attack_focus",GetMoveX(),0,0);
    CSAPI.ApplyAction(actionNode,"Fade_In_Action"); 

    ApplyRefresh();
end

function OnClickHide()
    ToHide();
    PlayerPrefs.SetInt(attackFocusState,1);
end
function ToHide()
    viewState = false;

    CSAPI.SetGOActive(clickMask,false);
    CSAPI.SetGOActive(goBtnHide,false);
    CSAPI.MoveTo(actionNode,"move_attack_focus",2000,0,0);
    CSAPI.ApplyAction(actionNode,"Fade_Out_100");   
    --SetShowBtnState(true);
    FuncUtil:Call(SetShowBtnState,nil,500,true);
end

function SetShowBtnState(state)
    CSAPI.SetGOActive(goBtnShow,state);
end