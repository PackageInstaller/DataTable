
--设置目标
function Set(targetCharacter)    

    CSAPI.SetGOActive(goal,false);  

    character = targetCharacter;

    if(character == nil)then
        return;
    end

    local isBoss = character.GetCharacterType() == CardType.Boss;

    CSAPI.SetGOActive(flag1,not isBoss);
    CSAPI.SetGOActive(flag2,isBoss);

    UpdateIcon();
    ApplyRefresh();
end

function ApplyRefresh()  
    if(character)then     
        UpdateHp();
        UpdatePlace();
    end
end

function UpdateIcon()
    if(character)then
        local cfgModel = character.GetCfgModel();
        local customIcon = cfgModel and cfgModel.ai_icon;
        --local customIcon = "Horizontal/40060_Break_Mist_H";
        if(customIcon)then              
            ResUtil.RoleCardCustom:Load(icon, customIcon,true,UpdateSize);
        else
            ResUtil.RoleCard:Load(icon, cfgModel.icon,true,UpdateSize);
        end

        --FuncUtil:Call(UpdateSize,nil,50);
    end
end

function UpdateSize()
    local size = CSAPI.GetRTSize(icon);
    if(not size)then
        return;
    end
    local x = size[0] or 212;
    local y = size[1] or 212;
    CSAPI.SetRTSize(iconbg,x + 10,y + 10);

    CSAPI.SetScale(hp,x / 212,1,1);
end

--更新HP
function UpdateHp()
    --LogError("update hp");
    if(character)then
        if(not hpBar)then
            hpBar = ComUtil.GetCom(goHp,"BarBase");
            if(not hpBar)then
                return;
            end
        end
        local buffHp = character.GetBuffHp() or 0;
        local maxHp = (character.hpMax or 0) + buffHp;   
        local currHp = character.hp or 0;
        local progress = currHp / maxHp;
        hpBar:SetProgress(progress);    
    end
end
function GetCharacter()
    return character;
end
--更新占位
function UpdatePlace()
    local grids = character and character.GetGrids();

    local minRow,maxRow,minCol,maxCol;

    if(grids)then        
        for _,grid in ipairs(grids)do
            local currRow = grid[1];
            local currCol = grid[2];
            
            currRow = (currRow == 0) and 4 or currRow;

            minRow = minRow and math.min(minRow,currRow) or currRow;
            maxRow = maxRow and math.max(maxRow,currRow) or currRow;

            minCol = minCol and math.min(minCol,currCol) or currCol;
            maxCol = maxCol and math.max(maxCol,currCol) or currCol;
        end
    end

    local gridSize = 106;--格子大小
    local space = 6;--间隔

    minRow = minRow or 0;
    maxRow = maxRow or 0;
    minCol = minCol or 0;
    maxCol = maxCol or 0;

    local w = maxRow - minRow + 1;
    local width = w * gridSize + (w - 1) * space;
    local h = maxCol - minCol + 1;
    local height = h * gridSize + (h - 1) * space;

    local x = (maxRow + minRow) / 2 - 1;
    x = x * (gridSize + space);
    local y = (maxCol + minCol) / 2 - 1;
    y = y * (gridSize + space) * -1;

    --CSAPI.SetRTSize(frame,width,height);
    CSAPI.SetAnchor(gameObject,x,y,0);
end

--设置点击回调
function SetClickCallBack(callBack)
    clickCallBack = callBack;
end

function OnClick()
    if(clickCallBack)then
        clickCallBack(this);
    end
end

function SetGoalState(state)
    if(state and lastState)then
        state = nil;
        g_FightMgr:SetFocusFire();--取消激活
    end
    lastState = state;

    CSAPI.SetGOActive(goal,state);  
    
--    local colorValue = state and 255 or 100;
--    CSAPI.SetImgColor(frame,colorValue,colorValue,colorValue,255);

    if(state and character)then
        g_FightMgr:SetFocusFire(character.GetID());--激活目标
    end

    return state;  
end

function Remove()
    CSAPI.RemoveGO(gameObject);
end