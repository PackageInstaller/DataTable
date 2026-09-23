local func = nil;
local caller = nil;
local param1 = nil;
local param2 = nil;
local param3 = nil;
local param4 = nil;
local param5 = nil;

local tr = "";


function TimerUpdate()		
	ApplyCallBack();
	leftCount = leftCount - 1;
	if(leftCount == 0) then
		Remove();
	end
end


function Timer(targetFunc, targetCaller, delay, interal, count, param1, param2, param3, param4, param5)
	if(_G.debug_model) then
		local tr = debug.traceback();
	end
	
	SetCall(targetFunc, targetCaller, p1, p2, p3, p4, p5)
	leftCount = count or - 1;
	if(IsNil(comTimer)) then
		comTimer = ComUtil.GetCom(gameObject, "XLuaTimer");
	end
	
	comTimer:Init(delay or 0, interal or 1000, count or - 1);
end

function ApplyCall(targetFunc, targetCaller, delay, p1, p2, p3, p4, p5)
	if(_G.debug_model) then
		local tr = debug.traceback();
	end
	
	SetCall(targetFunc, targetCaller, p1, p2, p3, p4, p5)
	
	if(delay == nil or delay <= 0) then
		OnCallBack();
	else
		CSAPI.DelayCall(OnCallBack, delay);
	end
end

function SetCall(targetFunc, targetCaller, p1, p2, p3, p4, p5)
	func = targetFunc;
	caller = targetCaller;
	param1 = p1;
	param2 = p2;
	param3 = p3;
	param4 = p4;
	param5 = p5;
	
	--    Log( tostring(func));
	--    LogError("aaa");
end

function OnCallBack()
	
	--local lastTime = CSAPI.GetRealTime();
	ApplyCallBack();
	--    local currTime = CSAPI.GetRealTime();
	--    local delta = currTime - lastTime;
	--    if(delta > 0.1)then
	--       local s = "耗时：" .. delta ..  "，前一次：" .. lastTime .. "，现在：" .. currTime;       
	--        LogError(s);
	--        if(caller)then
	--            LogError(caller);
	--        end
	--        LogError(tostring(func));
	--    end
	Remove();
end

function ApplyCallBack()
	
	if(not func) then
		LogError("回调方法不存在");
	end
	
	local result, errmsg;
	if caller then
		result, errmsg = xpcall(func, function() LogError(tr) end, caller, param1, param2, param3, param4, param5);
	else
		result, errmsg = xpcall(func,
		function()		
			LogError(tr)
		end, param1, param2, param3, param4, param5);
	end
	
	--    if not result or errmsg then
	--		LogError("调用失败：" .. tostring(errmsg .. "\n" .. tr));
	--	end    
end

function Clean()
	func = nil;
	caller = nil;
	param1 = nil;
	param2 = nil;
	param3 = nil;
	param4 = nil;
	param5 = nil;
end

function Remove()
	Clean();	
	CSAPI.RemoveGO(gameObject);
end

function Stop(b)
	CSAPI.SetGOActive(gameObject, b)
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