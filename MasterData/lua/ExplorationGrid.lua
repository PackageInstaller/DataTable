local data=nil;
local grid=nil;
local redObj=nil;
local cb=nil;
local tween=nil;
local effObj=nil;
local currPath=nil;
function Awake()
    tween=ComUtil.GetCom(img,"ActionScale");
end

function Refresh(_d,state,hasEff,isUnLock)
    data=_d;
    if data then
        local itemData=GridUtil.RandRewardConvertToGridObjectData(_d);
        SetGrid(itemData);
        if hasEff then
            local path=itemData:GetQuality()==5 and "Exploration/Ltem_orange" or "Exploration/Ltem_purple"
            if isUnLock~=true then
                path=path.."_Shadow";
            end 
            if currPath~=path then
                CSAPI.RemoveGO(effObj);
                effObj=nil;
            end
            currPath=path;
            if effObj==nil then
                ResUtil:CreateUIGOAsync(currPath,effNode,function(go)
                    effObj=go;
                end);
            end
        end
        CSAPI.SetGOActive(effNode,hasEff==true);
        SetState(state);
    else
        InitNull();
    end
end

function SetClickCB(_cb)
    cb=_cb;
    if grid then
        grid.SetClickCB(cb)
    end
end

function SetClick(isClick)
    if grid then
        grid.SetClicker(isClick);
    end
end

function SetGrid(d)
    if grid==nil then
        ResUtil:CreateUIGOAsync("Grid/RewardGrid",gridNode,function(go)
            grid=ComUtil.GetLuaTable(go);
            grid.Refresh(d);
        end)
    else
        grid.Refresh(d);
    end
end

function SetState(_state)
    local isFin=false;
    local isRed=false;
    if _state==ExplorationRewardState.Available then --未领取
        if redObj==nil then
            UIUtil:SetRedPoint(redNode,true);
        end
        isRed=true;
    elseif _state==ExplorationRewardState.Received then --已领取
        isFin=true;
    end
    CSAPI.SetGOActive(redNode,isRed);
    CSAPI.SetGOActive(finObj,isFin);
end

function PlayTween()
    if tween then
        CSAPI.SetScale(img,1.2,1.2,1.2);
        tween:Play();
    end
end

function InitNull()
    SetState();
end