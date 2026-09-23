local index=nil;
local cb=nil;
local grid=nil;

function Refresh(data,_elseData)
    this.data=data;
    if grid==nil then
        ResUtil:CreateUIGOAsync("Grid/GridItem",node,function(go)
            grid=ComUtil.GetLuaTable(go)
            grid.Refresh(data.goods,_elseData);
            grid.SetClickCB(OnClickGrid);
        end);
    else
        -- grid.SetIndex(index);
        grid.Refresh(data.goods,_elseData);
        grid.SetClickCB(OnClickGrid);
    end
    SetChoosie(_elseData and _elseData.isSelect or false)
end

function SetChoosie(isSelect)
    CSAPI.SetGOActive(selectObj,isSelect==true);
end

function SetIndex(i)
    index=i;
end

function SetClickCB(_cb)
    cb=_cb
end

function OnClickGrid(tab)
    if cb~=nil then
        cb(this);
    end
end