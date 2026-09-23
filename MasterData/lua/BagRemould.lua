local this = {};
local root;
local data;
local selectIndex;
local remouldData;
function this.SetData(_root, _data)
	root = _root;
	data = _data;
	selectIndex = nil;
	remouldData = nil;
end

function this.Refresh()
	local selectDic = {}
	for i, v in pairs(data.selDatas) do
		selectDic[v:GetID()] = 1
	end

	local list = EquipMgr:GetNotEquippedItem(nil,false,false);
	local len = list ~= nil and #list or 0
	for i = len, 1, - 1 do
		if(list[i]:GetQuality() == 5 or selectDic[list[i]:GetID()] or list[i]:IsLock() ) then --最高品质不用改造
			table.remove(list, i)
		end
	end
	root.Refresh(list);
end

-- function this.GetScreenDataType()
-- 	return EquipViewKey.Remould;
-- end

function this.GetElseData(_data)
	local isSelect = remouldData and _data:GetID() == remouldData:GetID();
	selectIndex = isSelect == true and nil or selectIndex;
	return {isClick = true, isSelect = isSelect, selectType = 1, showNew = true, removeFunc = nil};
end

function this.OnClickGrid(tab)
	if tab==nil or tab.data==nil then
		do return end
	end
	if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function()
			if tab and tab.data then
				tab.SetNewState(tab.data:IsNew());
			end
		end);
	end
	if EquipMgr:CheckIsRefreshLast(tab.data:GetID()) then
		do return end
	end
	remouldData = tab.data
	if selectIndex and selectIndex ~= tab.index then
		root.UpdateCell(selectIndex);
	end
	tab.SetChoosie(true);
	selectIndex = tab.index;
	-- root.SetSellPrice(1, 0, 0);
	CSAPI.OpenView("EquipFullInfo",tab.data,4);
end

function this.OnClickReturn()
	root.Close();
end

-- function this.OnClickChoosie()
-- 	if(data.cb) then
-- 		data.cb(remouldData)
-- 	end
-- 	root.Close();
-- end

return this; 