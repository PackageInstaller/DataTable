local name = nil
--聊天表情
function SetIndex(idx)
	index = idx
end

function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_name)
	name = _name
	if name then
		ResUtil:LoadFaceImg(gameObject, name, false)
	end
end

function GetName()
	return name
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

view=nil;
end
----#End#----