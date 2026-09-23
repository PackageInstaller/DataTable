local itemPath = "Sort/SortBtn2"
function OnOpen()
	rolePro = data[1]
	cb = data[2]
	listType = data[3]
	
	mulID = RoleMgr:GetMultiID(listType)
	index = nil
	if(mulID ~= nil) then
		for i, v in ipairs(rolePro) do
			if(v == mulID) then
				index = i
				break
			end
		end
	end
	oldIndex = index
	SetItems()
end

function SetItems()
	items = items or {}
	ItemUtil.AddItemsImm(itemPath, items, rolePro, grid, ItemClickCB, nil, index)
end

function Select()
	local proID = data.rolePro[index]
	local cfg = Cfgs.CfgCardPropertyEnum:GetByID(proID)
	local name = cfg.sName
	CSAPI.SetText(txtName, isSelect and StringUtil:SetByColor(name, "FFC146") or name)
end

function ItemClickCB(_index)
	if(index) then
		items[index].Select(false)
	end
	if(index and index == _index) then
		index = nil
	else
		index = _index
	end
	if(index) then
		items[index].Select(true)
	end
end

function OnClickMask()
	if(oldIndex ~= index) then
		cb(rolePro[index])
	end
	view:Close()
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
grid=nil;
view=nil;
end
----#End#----