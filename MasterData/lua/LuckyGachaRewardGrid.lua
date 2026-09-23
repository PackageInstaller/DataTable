local grid=nil;
local data=nil;
local elseData=nil;

function Refresh(_d,_elseData)
    data=_d;
    elseData=_elseData;
    if data then
        SetGrid(data:GetGoodInfo());
        CSAPI.SetText(txtNum,data:GetShowNum());
        CSAPI.SetGOActive(overObj,data:IsOver());
    else
        SetGrid();
    end
end

function SetGrid(d)
    if grid==nil then
        ResUtil:CreateUIGOAsync("Grid/RewardGrid",node,function(go)
            grid=ComUtil.GetLuaTable(go);
            grid.Refresh(d);
            grid.SetClickCB(GridClickFunc.OpenInfoSmiple);
        end)
    else
        grid.Refresh(d);
    end
end

function SetClick(isClick)
    if grid then
        grid.SetClicker(isClick);
    end
end