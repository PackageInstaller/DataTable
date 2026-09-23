--AI设置界面
local isShowFocus=false;
--设置显示状态
function SetShowState(state)
    --LogError("Set AI Setting State:" .. tostring(state));

    local playAction = showState ~= state;    

    showState = state;
    --CSAPI.SetGOActive(nodes,state);    

    if(playAction)then
        if(showState)then
            PlayEnterAction();
            ApplyRefresh();
        else
            CSAPI.ApplyAction(nodes,"Fade_Out_100");    
            if(skillSetting)then
                skillSetting.SetShowState(false);
            end
        end

        CSAPI.MoveTo(moveNode,"move_linear_local",showState and 0 or 2000,0,0);    
    end
end

function GetShowState()
    return showState;
end

function Awake()
    InitItems();
    local emptyItem = GetEmptyItem();
    ApplyRefresh();
end

function OnInit()
    InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Character_Create,OnCharacterFightInfoChanged); 
    eventMgr:AddListener(EventType.Character_Dead,OnCharacterFightInfoChanged); 
    eventMgr:AddListener(EventType.Fight_AI_Skill_Changed,OnCharacterFightInfoChanged); 
    eventMgr:AddListener(EventType.Fight_AI_Skill_Setting,OnAISkillSetting);      
    eventMgr:AddListener(EventType.Fight_UI_Enter_Action,OnStartPlayEnterAction);    
end
function OnDestroy()
    eventMgr:ClearListener();
end

function OnAISkillSetting(eventData)
    if(not skillSetting)then
        local go = ResUtil:CreateUIGO("Skill/SkillSetting",settingNode.transform);
        skillSetting = ComUtil.GetLuaTable(go);
    end
    if(eventData and eventData.id)then    
        skillSetting.SetData(eventData);
        --CSAPI.SetGOActive(skillSetting.gameObject,true);
        skillSetting.SetShowState(true);        
    else
        --CSAPI.SetGOActive(skillSetting.gameObject,false);
        skillSetting.SetShowState(false);
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

--刷新
function ApplyRefresh() 
    -- LogError("刷新AI设置");
    applyRefresh = nil;       
    ResetAllItems();
    --设置战斗队伍头像
    local characters = CharacterMgr:GetAll();
    -- LogError("当前战斗队伍："..tostring(DungeonMgr:GetFightTeamId()))
    -- LogError(TeamMgr:GetFightTeamData(DungeonMgr:GetFightTeamId()))
    local fightTeam=nil;
    local fightID=DungeonMgr:GetFightTeamId()
    if fightID then
        fightTeam=TeamMgr:GetFightTeamData(fightID);
    end
    if(characters)then
        if fightTeam then--存在队伍数据情况下以队伍数据为准
            -- LogError("fightTeam")
            for k,v in ipairs(fightTeam.data) do
                -- LogError(v)
                local cData=nil;
                local targetIndex=v:GetIndex();
                for _,c in pairs(characters)do     
                    if c.IsEnemy()~=true and c.GetCfgID()==v:GetCfgID() then
                        targetIndex=v:IsAssist() and 7 or v:GetIndex();
                        cData = c;
                        break;
                    end
                end
                if cData~=nil then
                    RefreshCharacter(cData,targetIndex);
                else
                    SetGreyItem(v,targetIndex);
                end
            end
            for _,c in pairs(characters)do       
                local rowIndex,colIndex = c.GetCoord();    
                if c.IsEnemy()~=true and FightGroundMgr:IsSummonRow(rowIndex) then
                    RefreshCharacter(c,6);--召唤位的下标一直为6
                    break
                end
            end
        else --正常不会走这块逻辑
            for _,c in pairs(characters)do           
                local cData = c.data;
                -- local rowIndex,colIndex = c.GetCoord();
                if cData and c.IsEnemy()~=true then
                    local charData=g_FightMgr:GetCharData(c.GetID())
                    local targetIndex = nil;
                    if(cData)then        
                        local rowIndex,colIndex = c.GetCoord();
                        if(cData.fuid)then
                            --支援
                            targetIndex = 7;
                        elseif FightGroundMgr:IsSummonRow(rowIndex) then
                            --召唤
                            targetIndex = 6;
                        else--队员
                            -- LogError(charData);
                            local charData=g_FightMgr:GetCharData(c.GetID())
                            if charData and charData.nIndex then
                                targetIndex=charData.nIndex;
                            end
                        end
                    end
                    RefreshCharacter(c,targetIndex);
                end
            end
        end
    end   
    RefreshItemNode1();
end

function RefreshItemNode1()
    local num = 0;
    for i = 6,7 do
        local item = itemArr[i];
        local isShow = item.IsNil()~=true;
        if(isShow)then
            num=num+1;
        end
        CSAPI.SetGOActive(this["item"..i],isShow);
    end
    if(num == lastItemNode1State)then
        return;
    end

    lastItemNode1State = num;
    CSAPI.SetGOActive(itemNode1,num>0 and true or false);    
    local bgName=num>1 and "UIs/Fight/img_18.png" or "UIs/Fight/img_18_2.png"
    CSAPI.LoadImg(arrow,bgName,false,nil,true);
end


function RefreshCharacter(character,targetIndex)   
    if(character.IsEnemy() or targetIndex==nil)then
        return;
    end
    
--    机神位
--    local rowIndex,colIndex = character.GetCoord();
--    if(not rowIndex or rowIndex < 1 or rowIndex > 3)then
--        return;
--    end
    -- LogError(character)
    -- LogError(targetIndex)
    items = items or {};
   
    -- local characterId = character.GetID();
    -- LogError(targetIndex)
    local item = items[targetIndex];
        
    if(not item)then
--        local go = ResUtil:CreateUIGO("Fight/FightAISettingItem",itemNode.transform);
--        item = ComUtil.GetLuaTable(go);
        item = GetEmptyItem(targetIndex);
        -- LogError(item and "有" or "没有");
        if(item)then
            item.Set(character);   
            items[targetIndex] = item;   
        end
    end

    return item;
end

--通过队伍数据设置灰色格子
function SetGreyItem(teamItem,realIndex)
    if teamItem and realIndex then
        local item = GetEmptyItem(realIndex);
        if(item)then
            item.SetGreyLayout(teamItem);   
            items[realIndex] = item;   
        end
    end
end

function GetEmptyItem(index)
    if(index)then
        return itemArr and itemArr[index];
    end

    for i,item in ipairs(itemArr)do
        if(item.IsNil())then
            return item;       
        end
    end

    return nil;
end

function ResetAllItems()
    for i,item in ipairs(itemArr)do
        item.Reset();
    end
    items = {};
end

function InitItems()
    itemArr = {};

    for i = 1,7 do
        local itemParent = itemNode.transform;
        if(i >= 6)then
            itemParent = this["item" .. i].transform;
        end
        local go = ResUtil:CreateUIGO("Fight/FightAISettingItem",itemParent);
        local item = ComUtil.GetLuaTable(go);
        item.Set();   
        table.insert(itemArr,item);   
    end

    --PlayEnterAction();
end

function OnStartPlayEnterAction()
    canPlay = 1;
    if(showState)then
        PlayEnterAction();
    end
end

function OnClickShow()
    --显示AttackFocusView
    isShowFocus=not isShowFocus;
    EventMgr.Dispatch(EventType.Fight_Focus_Show,isShowFocus);
end

function GetBtnPos()
    local x,y,z=CSAPI.GetPos(goBtnShow);
    return {x,y,z};
end

function PlayEnterAction()
    if(not canPlay)then
        return;
    end

    if(not itemArr)then
        return;
    end
    for i,item in ipairs(itemArr)do
        local delay = (i - 1) * 50 + 80;
        item.PlayEnterAction(delay);
    end
    CSAPI.ApplyAction(nodes,"Fade_In_200");    
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
moveNode=nil;
nodes=nil;
settingNode=nil;
itemNode=nil;
itemNode1=nil;
item6=nil;
item7=nil;
view=nil;
end
----#End#----