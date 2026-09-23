local grid=nil;

function Refresh(_teamItem)
    this.data=_teamItem;
    if grid then
        grid.Refresh(_teamItem);
        SetSelect(false)
        grid.ActiveClick(false);
    else
        ResUtil:CreateUIGOAsync("Team/TeamSelectGrid",gridNode,function(go)
            grid=ComUtil.GetLuaTable(go);
            grid.Refresh(_teamItem);
            SetSelect(false)
            grid.ActiveClick(false);
        end);
    end
end

function SetClickCB(cb)
    this.callBack=cb;
end

function SetSelect(isShow)
    CSAPI.SetGOActive(choosie,isShow);
end

function OnClickSelf()
    if this.callBack then
       this.callBack(this)
    end
end

-- function ActiveClick(isActive)

-- end