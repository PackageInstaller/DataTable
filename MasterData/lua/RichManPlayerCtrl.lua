-- 大富翁玩家控制器
local eventMgr = nil;
local clipTimes = {};
local ctrlGO = nil;
local cAnimator=nil;
local animator=nil;
local cfgModel = nil;
local playState=nil;
local actionQueue=nil; --行动队列
local getGridGOFunc=nil;--获取坐标的方法
local activtyData=nil;
local tpTweenCom=nil;
local isPlayTp=false;
local isPlayQueue=false;--是否在播放行动队列

function Awake()
    actionQueue=RichManActionQueue.New(this);
    tpTweenCom=ComUtil.GetCom(tpTween,"ActionMaterialValue2");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RichMan_ActionQueue_Push,OnActionPush);
end

function OnDestroy()
    eventMgr:ClearListener();
    SetPlayMoveSoundState(false);
    cAnimator = nil;
    animator = nil;
    ctrlGO=nil;
end

function SetGetPosFunc(func)
    getGridGOFunc=func;
end

function LookAt(go)
    if go~=nil then
        RichManUtil.SetAngle(gameObject,go);
    end
end

--根据移动步数获得坐标
function GetGridGO(pos)
    if pos and getGridGOFunc~=nil then
        return getGridGOFunc(pos);
    elseif getGridGOFunc==nil then
        LogError("未给getGridGOFunc赋值");
    end
end

function Init()
    -- 创建控制器
    activtyData = RichManMgr:GetCurData();
    --面向前进的方向
    LookAtNextPos();
    if activtyData then
        local cfgModel = activtyData:GetCtrlRole();
        if cfgModel ~= nil then
            CharacterMgr:LoadModel(cfgModel, node, OnModelLoadOver);
        end
    end
end

function OnModelLoadOver(go)
    ctrlGO = go;
    cAnimator = ComUtil.GetComInChildren(go,"CAnimator");
    animator = cAnimator.animator;   
end

function LookAtNextPos(curPosInfo)
    -- 设置角色位置为当前格子的位置
    curPosInfo = activtyData:GetCurPosGridInfo();
    if curPosInfo then
        local grid = GetGridGO(curPosInfo:GetPos());
        if grid == nil then
            LogError("未获取到名字为：" .. tostring(curPosInfo:GetPos()) .. "的格子GameObject！");
            do
                return
            end
        end
        -- LogError("LookAtNextPos:"..tostring(grid.name).."\t"..tostring(curPosInfo:GetPos()));
        SetPos(grid.position.x, 0, grid.position.z);
        local nextPos = activtyData:GetNextPosGridInfo();
        if nextPos then
            -- 设置旋转角度为面向下一步的方向
            LookAt(GetGridGO(nextPos:GetPos()));
        else
            -- 设置旋转角度为第二个格子
            LookAt(GetGridGO(2));
        end
    else
        LogError("未找到当前的格子信息:"..tostring(curPosInfo));
    end
end


function SetPos(x,y,z)
    CSAPI.SetPos(gameObject,x,y,z);
end

function PlayMove(state)
    --播放角色移动动画
    if(playState)then
        return;
    end

    if(not IsNil(animator))then
        SetPlayMoveSoundState(state);
        animator:SetBool("move",state) 
        if(state)then
            animator:Play("move");  
        end
    end
end

--播放传送
function PlayTP(isIn,func)
    if isPlayTp then
        if func~=nil then
            func();
        end
        do return end
    end
    if tpTweenCom~=nil then
        tpTweenCom.currValue=isIn and 0 or 4
        tpTweenCom.targetValue=isIn and 4 or 0;
        tpTweenCom.resetWhenComplete=not isIn;
        tpTweenCom.target=ctrlGO;
        CSAPI.SetGOActive(tpTween,true);
    end
    isPlayTp=true;
    FuncUtil:Call(function()
        isPlayTp=false;
         CSAPI.SetGOActive(tpTween,false);
        if func~=nil then
            func();
        end
    end,nil,1205)
end

--播放移动音效 state:是否移动
function SetPlayMoveSoundState(state)
    local sound = cfgModel and cfgModel.s_move;
    if(sound)then
        if(playState == state)then
            return;
        end
        playState = state;
        if(playState)then
            CSAPI.PlaySound("fight/effect/move.acb",sound);
        else
            CSAPI.StopTargetSound("fight/effect/move.acb",sound);
        end
    end
end

function PlayIdle()
    --播放角色待机动画
    PlayMove(false);
end

--新增的动作数据推送
function OnActionPush(action)
    if action~=nil and actionQueue~=nil then
        actionQueue:AddAction(action);
    end
end

function Update()
    -- 更新播放状态
    if actionQueue~=nil and actionQueue:IsDone()~=true then
        actionQueue:Update();
        if actionQueue:IsDone() then
            -- activtyData = RichManMgr:GetCurData();
            if RichManMgr:GetAutoState()~=true then
                RichManMgr:PlayAutoReward();--播放自动奖励
            end
            isPlayQueue=false;
            EventMgr.Dispatch(EventType.RichMan_ActionQueue_End)
        elseif isPlayQueue~=true and actionQueue:GetCount()>0 then
            isPlayQueue=true;
            EventMgr.Dispatch(EventType.RichMan_ActionQueue_Start)
        end
    end
end