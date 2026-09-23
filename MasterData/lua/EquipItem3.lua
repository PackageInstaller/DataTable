local grid=nil

function Refresh(data,elseData)
    this.data=data;
    if grid==nil then
        local go=ResUtil:CreateUIGO("Grid/EquipItem",node.transform);
        grid=ComUtil.GetLuaTable(go);
    end
    grid.Refresh(data,elseData);
    if this.data then
        grid.SetHoldCB(OnHoldGrid);
    else
        grid.SetHoldCB();
    end
    CSAPI.SetGOActive(btnRemove,data~=nil)
end

function OnHoldGrid(tab)
	CSAPI.OpenView("EquipFullInfo",tab.data,5);
end

function OnClickRemove()
    --移除按钮
    EventMgr.Dispatch(EventType.Equip_Remove_CombineM,this);
end