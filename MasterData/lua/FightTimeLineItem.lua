
function Awake()
    layoutCom = ComUtil.GetCom(gameObject,"CustomLayout");--自定义布局组件    
    actionScale = ComUtil.GetCom(scaleNode,"ActionBase");--缩放组件    
    actionMove = ComUtil.GetCom(node,"ActionBase");--移动组件 
    actionEnter = ComUtil.GetCom(enterAction,"ActionBase");--移动组件 

    actionShake = ComUtil.GetCom(shakeAction,"ActionBase");--震动组件 

    UpdateInfo(nil);    
    
    GMTestInfo(false);

    DisableBgs();
end

--设置布局信息
function SetLayoutInfo(info)
    layoutInfo = info;
    local lastIsFirst = currIsFirst;    
    currIsFirst = layoutInfo and layoutInfo.isFirst;
    
    --LogError(tostring(lastIsFirst) .. ":" .. tostring(currIsFirst));
        
    if(currIsFirst)then        
        if(not lastIsFirst) then
            actionScale:Play();  
            CSAPI.SetAnchor(node,15,0);
            --SetScale(1.4);
        end
    else
        if(lastIsFirst)then
            ApplyOut();
            return;
        else
            SetScale(1);
        end        
    end
    --LogError(currCharacter.GetID() .. "__lastIsFirst:" .. tostring(lastIsFirst) .. "__scale:" .. tostring(scale));
    layoutCom:Apply(info.index,info.pos);
end

function SetScale(scale)
    CSAPI.SetScale(scaleNode,scale,scale,scale);
end

function ApplyLayoutComplete()
    if(layoutCom)then
        layoutCom:ApplyComplete();
    end
end

function SetIndex(index)
    --LogError(tostring(index));
    transform:SetSiblingIndex(index);
end

function ApplyOut() 
    if(isFadeOuting)then
        return;
    end   
    isFadeOuting = 1;


    CSAPI.ApplyAction(gameObject,"TimeLine_Fade_Out");
    FuncUtil:Call(ApplyIn,nil,500);
end

function ApplyIn()
    isFadeOuting = nil;    
    SetScale(1);
    CSAPI.ApplyAction(gameObject,"TimeLine_Fade_In");
    if(actionMove)then
        actionMove:Play(); 
    end
    if(layoutInfo and layoutCom)then
        layoutCom:Apply(layoutInfo.index,layoutInfo.pos);
        layoutCom:ApplyComplete();
    end

    EventMgr.Dispatch(EventType.Fight_Reset_TimeLineIndex,this);
end

--获取布局信息
function GetLayoutInfo()
    return layoutInfo;
end

function GetID()
    if(currCharacter)then
        return currCharacter.GetID();
    end
end

function SetSelState(state)
    CSAPI.SetGOActive(selGO,state);
end

function OnInit(args)
    InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
    --eventMgr:AddListener(EventType.GM_Test_Info,GMTestInfo);   
    eventMgr:AddListener(EventType.Character_Hited,OnCharacterHited);   
        
end
function OnDestroy()
    if(eventMgr)then
        eventMgr:ClearListener();
    end
end
--GM测试信息
function GMTestInfo(state)
    if(goId)then
        CSAPI.SetGOActive(goId,state);
    end
end

function OnCharacterHited(id)
    if(GetID() == id)then
        ApplyShake();
    end
end

function OnEnable()
    --DisableBgs();    
end

--function OnDisable()
--   bgOur = nil;
--   bgEnemy = nil;
--end

function PlayEnterAction(delay)
    if(actionEnter)then
        actionEnter.delay = math.floor(delay);
        actionEnter:Play();
    end
end

function ApplyShake()
    actionShake:Play();
end

function Refresh()
    UpdateInfo(currCharacter);
end

function UpdateInfo(character,nextFlag)
    CSAPI.SetGOActive(gameObject,character ~= nil);
    if(character == nil)then
        return;
    end

    currCharacter = character;

    local cfg = character.GetCfgModel();
    --ResUtil.Card:Load(icon, cfg.card_icon);
    -- ResUtil.RoleCard:Load(icon, cfg.icon);
    ResUtil.RoleCard2:Load(icon, cfg.icon,false);

    local teamId = character.GetTeam();
   
    local isEnemy = TeamUtil:IsEnemy(teamId);

    bgOur = bgOur or bg_blue;
    bgEnemy = bgEnemy or bg_red;

    CSAPI.SetGOActive(bgEnemy,isEnemy);
    CSAPI.SetGOActive(bgOur,not isEnemy);

    CSAPI.SetGOActive(selGO_blue,false);
    CSAPI.SetGOActive(selGO_red,false);
    selGO = isEnemy and selGO_red or selGO_blue;

    CSAPI.SetGOActive(bossFlag,character.GetCharacterType() == CardType.Boss);     
end


function DisableBgs()
    CSAPI.SetGOActive(bg_red,false);
    CSAPI.SetGOActive(bg_blue,false);  
end
--设置高度
function SetHeight(height)
    --layoutElement.minHeight = height;
end

function OnClick()
    if(currCharacter)then
        if(FightClient:GetInputCharacter())then
            local id = currCharacter.GetID();
            --if (not IsPvpSceneType(g_FightMgr.type) and g_FightMgr.type ~= SceneType.PVPMirror) or _G.showPvpRoleInfo==true then --非PVP界面可以打开查看数据
            if g_FightMgr and not IsPvpSceneType(g_FightMgr.type) or _G.showPvpRoleInfo==true then --非PVP界面可以打开查看数据
                CSAPI.OpenView("FightRoleInfo",id);
            end
        end
        EventMgr.Dispatch(EventType.Character_FightInfo_Log,id);
    end
end

function Remove()
    CSAPI.RemoveGO(gameObject);
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
node=nil;
scaleNode=nil;
bg_blue=nil;
bg_red=nil;
icon=nil;
enterAction=nil;
shakeAction=nil;
view=nil;
end
----#End#----