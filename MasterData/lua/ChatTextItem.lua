--常用语子物体
local data = nil
local index = 0

function SetIndex(idx)
	index = idx
end

function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_data)
	data = _data
	if data then
		CSAPI.SetText(txt, data)
	end
end

function GetStr()
	return data
end

function OnClick()
	if cb then
		cb(this)
	end
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
txt=nil;
view=nil;
end
----#End#----