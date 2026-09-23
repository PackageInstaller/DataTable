--背景切割部件
function Awake()
	--CSAPI.SetAngle(gameObject, 45, 180, 0)
end

function SetBgSR(bgRes, bgName)
	ResUtil:LoadBigSR2(gameObject, "UIs/SectionImg/" .. bgRes .. "/" .. bgName)	
end

function SetPos(pos)
	CSAPI.SetLocalPos(gameObject, pos[1], pos[2], pos[3])
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