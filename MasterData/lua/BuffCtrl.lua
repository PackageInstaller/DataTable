--特殊buff控制

function Awake()
    SetTierLv(1);
end

function OnRecycle()
    SetTierLv(1);
end

--设置层级
function SetTierLv(count)
    if(goEffs == nil)then
        goEffs = {};
        for i = 1,100 do
            local key = "eff" .. i;
            if(this[key])then
                goEffs[i] = this[key];
            end
        end
    end

    for index,goEff in ipairs(goEffs)do
        CSAPI.SetGOActive(goEff,index <= count);
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
eff1=nil;
eff2=nil;
eff3=nil;
eff4=nil;
eff5=nil;
end
----#End#----