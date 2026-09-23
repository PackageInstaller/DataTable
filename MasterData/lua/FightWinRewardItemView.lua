
function SetData(data)
    CSAPI.SetText(count,"x" .. data.num);
    if data.type == RandRewardType.EQUIP then
        --装备显示装备属性
        local _,item  = ResUtil:CreateGridItem(itemNode.transform);
        local itemData=nil;

		if data.c_id then
			itemData=EquipMgr:GetEquip(data.c_id);
		else
			itemData = EquipData();
			itemData:InitCfg(data.id);
		end
		item.Refresh(itemData)
		item.SetClickCB(GridClickFunc.EquipDetails);
    else
        ResUtil:CreateRandRewardGrid(data,itemNode.transform);  
    end  
end

