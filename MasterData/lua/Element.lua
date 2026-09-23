--无限滚动格子父类
local item = nil
local itemPath = nil

function OnRecycle()
	if(item) then
		CSAPI.RemoveGO(item.gameObject)
	end
	item = nil
	itemPath = nil
end

function SetItem(_item, _itemPath)
	item = _item
	itemPath = _itemPath
end

function GetItem(_itemPath)
	if(itemPath and itemPath ~= _itemPath) then
		OnRecycle()
	end
	return item
end

function SetCellScale(_value)
	CSAPI.SetScale(Cell, _value, _value, _value)
end

function GetCell()
	return this["Cell"]
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
Cell=nil;
view=nil;
end
----#End#----