
function SetIndex(_index)
	index = _index
end

function Refresh(_data,cb)
	--floor
	CSAPI.SetText(txtFloor, _data.sName)
	--grids
	local itemPath = "Dorm/DormRoomItem2"
	items = items or {}
	ItemUtil.AddItems(itemPath, items, _data.infos, grids, cb)
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
txtFloor=nil;
grids=nil;
view=nil;
end
----#End#----