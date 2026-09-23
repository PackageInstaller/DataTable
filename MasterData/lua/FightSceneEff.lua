
function Awake()
    EventMgr.AddListener(EventType.Scene_Mask_Changed,OnSceneMaskChanged);    
end

function OnSceneMaskChanged(state)
     CSAPI.SetLocalPos(gameObject,0,state and -1000 or 0,0);
end

function OnRecycle()
    EventMgr.RemoveListener(EventType.Scene_Mask_Changed,OnSceneMaskChanged);    
end

function OnDestroy()
    EventMgr.RemoveListener(EventType.Scene_Mask_Changed,OnSceneMaskChanged);    
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  

end
----#End#----