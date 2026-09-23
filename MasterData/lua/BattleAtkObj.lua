
function Awake()
   ActiveEff(false); 
end

function ActiveEff(state)
    if(goAtk)then
        CSAPI.SetGOActive(goAtk,state);
    end

    if(state)then
        FuncUtil:Call(ActiveEff,nil,1000,false);
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
goAtk=nil;
end
----#End#----