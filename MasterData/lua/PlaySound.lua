
function Awake()
    SetSoundState(true);
end

function OnDestroy()
    SetSoundState(false);
end

function SetSoundState(state)    
    local targetCueSheet = cueSheet and cueSheet.name;
    local targetCueName = cueName and cueName.name;
    if(state)then
        CSAPI.PlaySound(targetCueSheet,targetCueName);
    else
        CSAPI.StopTargetSound(targetCueSheet,targetCueName);
    end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
cueSheet=nil;
cueName=nil;
end
----#End#----