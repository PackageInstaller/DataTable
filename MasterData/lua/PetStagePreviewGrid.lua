local grid=nil;
function Refresh(_d)
    local num=0;
    if _d then
        if grid then
            grid.Refresh(_d);
            grid.SetCount();
            grid.SetClickCB(GridClickFunc.OpenInfoSmiple);
        else
            ResUtil:CreateUIGOAsync("Grid/GridItem",gridNode,function(go)
                grid=ComUtil.GetLuaTable(go);
                grid.Refresh(_d);
                grid.SetCount();
                grid.SetClickCB(GridClickFunc.OpenInfoSmiple);
            end);
        end
        num=_d:GetCount();
    end
    CSAPI.SetText(txtNum,tostring(num));
end
