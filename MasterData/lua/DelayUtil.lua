local list = {};
local emptyItems = {};
local mono;

function Awake()
    mono = ComUtil.GetCom(gameObject,"XLuaMono");
end

function UpdateTime(time)
    --LogError(#list);
    if(#list <= 0)then        
        return;
    end
   
    local needFix = nil;
    for _,item in ipairs(list)do
        if(not item.isCalled)then
            if(time >= item.delay)then
                item.isCalled = 1;
                CallFun(item.func,item.caller,item.p1,item.p2,item.p3,item.p4,item.p5,item.tr);

                --LogError(item);
                needFix = 1;
            end
        end
    end

    if(needFix)then
        FixList();
    end
end

function FixList()
    local count = #list;
    for i = 1,count do
        local index = count - i + 1;
        local item = list[index];
        if(item.isCalled)then
            table.remove(list,index);
            --�Ż�
            if(#list == 0)then
                mono.enabled = false;
                --LogError("false");
            end

            item.isCalled = nil;
            table.insert(emptyItems,item);
        end
    end
end

function DelayCall(func,caller,delay,p1,p2,p3,p4,p5)
    if(_G.debug_model)then
        local tr = debug.traceback();
    end
    if(not delay or delay <= 0)then
        CallFun(func,caller,p1,p2,p3,p4,p5,tr);
        return;
    end

    local item = GetItem();
    item.func = func;
    item.caller = caller;
    item.delay = delay + CSAPI.GetTime() * 1000;
    item.p1 = p1;
    item.p2 = p2;
    item.p3 = p3;
    item.p4 = p4;
    item.p5 = p5;
    item.tr = tr;
    table.insert(list,item);
    --�Ż�
    if(#list == 1)then
        mono.enabled = true;
        --LogError("true");
    end
end

function CallFun(func,caller,p1,p2,p3,p4,p5,tr)
--    if(caller)then
--        func(caller,p1,p2,p3,p4,p5);
--    else
--        func(p1,p2,p3,p4,p5);
--    end

    if caller then 
		result, errmsg = xpcall(func, ErrorCallBack,caller,p1,p2,p3,p4,p5);
	else
		result, errmsg = xpcall(func, ErrorCallBack,p1,p2,p3,p4,p5);
	end
end

function ErrorCallBack(tr)
    LogError(tr)
end

function GetItem()
    local count = #emptyItems;
    if(count == 0)then
        return {};
    else
        local item = emptyItems[count];
        table.remove(emptyItems,count);
        return item;
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

end
----#End#----