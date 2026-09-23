--地面
function Init(_dormMain)
	--dormMain = _dormMain
end


function Refresh(_data)
	--data = _data ~= nil and _data or data
	SetScale()
end

function SetScale()
	local scale = DormMgr:GetDormScale()
	CSAPI.SetScale(ground, scale.x, 1, scale.z)
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
ground=nil;
end
----#End#----