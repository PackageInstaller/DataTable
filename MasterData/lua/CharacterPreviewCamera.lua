
function Awake()
    _G.characterPreviewCamera = ComUtil.GetCom(gameObject,"BattleCameraMgr");    
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
goCamera=nil;
end
----#End#----