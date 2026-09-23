
function SetFunc(targetFunc,targetCaller)
    func = targetFunc; 
    caller = targetCaller;
end

function Update()
    if(func)then
        if(caller)then
            func(caller);
        else
            func();
        end
    end
end

function OnDestroy()
    func = nil; 
    caller = nil;
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  

end
----#End#----