--装备背包
local this={};
local root=nil;
local data=nil;
function this.SetData(_root,_data)
    root=_root;
    data=_data;
end

function this.Refresh()
    local list = EquipMgr:GetAllEquipArr(nil, true);
    root.Refresh(list);
end

-- function this.GetScreenDataType()
--     return EquipViewKey.Bag;
-- end

function this.GetElseData(data)
    return {isClick = true, isSelect = false,selectType=1,showNew=true, removeFunc = nil};
end

function this.OnClickGrid(tab)
    if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function() 
			tab.SetNewState(tab.data:IsNew());
		end);
    end
    tab.data:SetNew(false);
    GridClickFunc.OpenEquipInfo(tab)
end

function this.OnClickReturn()
    root.Close();
end

return this;