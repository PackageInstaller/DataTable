local grid=nil;
local character=nil;
local isNil=true;
local isLoadGrid=false;--是否加载子物体
function Awake()
    actionEnter = ComUtil.GetCom(enterAction,"ActionBase"); 
end

function SetAsFirstSibling()
    transform:SetAsFirstSibling();
end
function SetAsLastSibling()
    transform:SetAsLastSibling();
end

function SetGrey(isGrey)
    isGrey=isGrey or false;
    if(greyState == isGrey)then
        return;
    end   

    greyState = isGrey;
    if gameObject then
        CSAPI.SetGrey(gameObject,isGrey,true)
    end
end

--设置目标
function Set(targetCharacter)    
    --SetAsFirstSibling();
    myCharacter = targetCharacter;
    if grid==nil and isLoadGrid~=true  then
        ResUtil:CreateUIGOAsync("BattleAISetting/BattleAISetItem",gridNode,function(go)
            grid=ComUtil.GetLuaTable(go);
            RefreshGridNode(myCharacter)
        end)
        isLoadGrid=true;
    elseif grid~=nil then
        RefreshGridNode(myCharacter)
    end
    isNil=myCharacter==nil;
end

--通过编队数据设置阵亡样式
function SetGreyLayout(teamItem)
    if grid==nil and isLoadGrid~=true then
        ResUtil:CreateUIGOAsync("BattleAISetting/BattleAISetItem",gridNode,function(go)
            grid=ComUtil.GetLuaTable(go);
            SetGreyByTeamItem(teamItem);
        end)
        isLoadGrid=true;
    elseif grid~=nil then
        SetGreyByTeamItem(teamItem);
    end
    isNil=teamItem==nil;
end

function SetGreyByTeamItem(teamItem)
    if teamItem==nil then
        if grid~=nil then
            grid.Refresh(); 
        end
        return;
    end
    if teamItem:IsAssist() then
        grid.SetDescObj(true,6);
    else
        if teamItem:GetIndex()==nil then
            grid.SetDescObj(false);
        else
            grid.SetDescObj(true,teamItem:GetIndex());
        end
    end
    grid.SetIcon(teamItem:GetModelCfg().icon);
    grid.SetBG();
    grid.SetGrey(true);
end

function RefreshGridNode(_character)
    -- LogError(character)
    if(_character == nil)  then
        if character==nil then
            grid.Refresh();
        end
        return;
    end
    character=_character;
    SetGrey(character.IsDead())
    local model = character.GetCfgModel();
    local cData=character.data;
    local charData=g_FightMgr:GetCharData(character.GetID());
    if charData then
        -- LogError(charData);
        -- LogError(tostring(charData.nIndex))
        if charData.fuid then
            grid.SetDescObj(true,6);
        else
            if charData.nIndex==nil then
                grid.SetDescObj(false);
            else
                grid.SetDescObj(true,charData.nIndex);
            end
        end
        grid.SetIcon(model.icon);
        grid.SetBG();
        grid.SetGrey(character.IsDead());
    else        
        grid.SetDescObj(false);
    end
end

function GetCharacter()
    return myCharacter;
end

--当前格子是否为空
function IsNil()
    return isNil;
end

function PlayEnterAction(delay)
    if(actionEnter)then
        actionEnter.delay = math.floor(delay);
        actionEnter:Play();
    end
end


function OnClick()
--    useSkillState = not useSkillState;
--    SetUseSkill(useSkillState);

--     if(characterId and g_FightMgr)then
--        g_FightMgr:SetSkillAI(characterId,not useSkillState);
--    end
    
    -- EventMgr.Dispatch(EventType.Fight_AI_Skill_Setting,{id=characterId,posNode = posNode});
end

function Remove()
    character=nil;
    greyState=nil;
    CSAPI.RemoveGO(gameObject);
end

function Reset()
    Set(nil);
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
posNode=nil;
grid=nil;
gridNode=nil;
enterAction=nil;
view=nil;
greyState=nil;
end
----#End#----