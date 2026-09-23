function SetIndex(_i)
	index = _i
end

function Refresh(_data, _elseData)
	CSAPI.SetGOActive(sel, index == _elseData)
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
sel=nil;
view=nil;
end
----#End#----