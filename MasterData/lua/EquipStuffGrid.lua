local gridItem=nil;
local equipItem=nil;
local cb=nil;
local data=nil;
local index=0;

--_d:StuffArray中的v={type=0：装备 1：经验,data=data,num=count};
function Refresh(_d,_elseData)
    data=_d;
    if _d==nil then
        InitEquip(_d and _d.data or nil,_elseData);
    else
        if _d.type==1 then
            InitGrid(_d or nil);
        else
            InitEquip(_d and _d.data or nil,_elseData);
        end
    end
end

function InitEquip(_d,_elseData)
    if equipItem==nil then
        ResUtil:CreateUIGOAsync("Grid/EquipItem",equipNode,function(go)
            equipItem=ComUtil.GetLuaTable(go)
            equipItem.Refresh(_d,_elseData);
            equipItem.SetHoldCB(_d==nil and nil or OnHoldGrid);
            equipItem.SetClickCB(OnClickCB);
        end)
    else
        equipItem.Refresh(_d,_elseData);
        equipItem.SetHoldCB(_d==nil and nil or OnHoldGrid);
        equipItem.SetClickCB(OnClickCB);
    end
    CSAPI.SetGOActive(equipNode,true)
    CSAPI.SetGOActive(gridNode,false)
end

function OnHoldGrid(tab)
    if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function() 
			tab.data:SetNew(false);
			tab.SetNewState(tab.data:IsNew());
		end);
    end
	CSAPI.OpenView("EquipFullInfo",tab.data,5);
end

function InitGrid(_d)
    if _d then
        if gridItem == nil then
            ResUtil:CreateUIGOAsync("Grid/GridItem", gridNode, function(go)
                gridItem = ComUtil.GetLuaTable(go)
                gridItem.Refresh(_d.data);
                gridItem.SetCount(_d.num);
                gridItem.SetClickCB(OnClickCB);
            end)
        else
            gridItem.Refresh(_d.data);
            gridItem.SetCount(_d.num);
            gridItem.SetClickCB(OnClickCB);
        end
    end
    CSAPI.SetGOActive(equipNode,false)
    CSAPI.SetGOActive(gridNode,true)
end

function SetClickCB(_cb)
    cb=_cb;
end

function OnClickCB()
    if cb then
        cb(data);
    end
end

function SetIndex(_idx)
    index=_idx
end