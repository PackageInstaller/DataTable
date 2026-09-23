--墙
function Init(_dormMain)
	--dormMain = _dormMain
end

function Refresh(_data)
	--data = _data ~= nil and _data or data
	SetScale()
	SetPos()
end

function SetScale()
	local scale = DormMgr:GetDormScale()
	CSAPI.SetScale(left, 1, 6, scale.z)
	CSAPI.SetScale(right, scale.x, 6, 1)
end

function SetPos()
	local scale = DormMgr:GetDormScale()
	CSAPI.SetLocalPos(left, scale.x * 0.5 + 0.5, 2, 0)
	CSAPI.SetLocalPos(right, 0, 2, -( scale.z * 0.5 + 0.5))
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
left=nil;
right=nil;
end
----#End#----