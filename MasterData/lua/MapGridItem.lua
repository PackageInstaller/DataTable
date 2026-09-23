--战棋地图格子

function Awake()
    SetEnemyState(false);    
end

function OnEnable()
    SetLightState(false);    
end

function SetData(data)
    if(data.angle)then
        CSAPI.SetAngle(node,0,data.angle,0);
    end
    if(data.flip)then
        CSAPI.SetScale(node,-1,1,1);
    end
    local res = data.res or "0/7";
    if(not data.transfer_stage and res)then
        --SetShowState(false);
        CSAPI.CreateGOAsync("Grids/" .. res, 0, 0, 0, node);
    end
end


function SetLightState(state)
    lightState = state;
    CSAPI.SetGOActive(spriteNode,state and isEnable);
end
--是否可抵达
function IsReachable()
    return lightState and isEnable;
end

function PlayAni()
    if(not isEnable)then
        return;
    end
    if(not lightState)then
        return;
    end
    SetLightState(false);

    local res = isEnemy and "common/map_grid_enemy" or "common/map_grid_our";

    ResUtil:CreateEffect(res,0,0,0,goLight);
end

function SetEnemyState(isEnemyState)
    isEnemy = isEnemyState;
    
    CSAPI.SetGOActive(our,not isEnemy and isEnable);
    CSAPI.SetGOActive(enemy,isEnemy and isEnable);
end


function SetEnableState(state)
    isEnable = state;

    if(not isEnable)then
        SetLightState(false);
        SetEnemyState(false);
    end
end
function IsEnable()
    return isEnable;
end

function SetShowState(isShow)
    --CSAPI.SetGOActive(goModel,isShow);
end