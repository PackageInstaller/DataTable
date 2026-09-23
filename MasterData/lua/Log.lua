--是否屏蔽日志
-- noLog = 1;
-- debug_model = 1;


-- table转字符串, 带美化格式
function table.tostring(t,force)  
    if(not debug_model and not force)then
        return "";
    end 
  if type(t) ~= "table" then
    return tostring(t)
  end
    -- if(t == nil)then
    --     return "nil";
    -- end

  local mark={}
  local assign={}
  local function ser_table(tbl, parent, deep)
    mark[tbl]=parent
    local tmp={}
    local head = ""
    if deep > 0 then
      for i=1,(deep-1)*4 do
        head = "_"..head
      end
    end

    for k,v in pairs(tbl) do
        if(k ~= "__super")then
          local key = "";
          if(k)then
             key = type(k)=="number" and "["..k.."]" or "[".. string.format("%q", tostring(k)) .."]"
          end
          key = head.."__"..key

          if type(v)=="table" then
            local dotkey= parent.. key
            if mark[v] then
              table.insert(assign,dotkey..":'"..mark[v] .."'")
            else
              table.insert(tmp, key..":"..ser_table(v,dotkey, deep + 1))
            end
          elseif type(v) == "string" then
            table.insert(tmp, key..":".. string.format('%q', v))
          elseif type(v) == "number" or type(v) == "boolean" then
            table.insert(tmp, key..":".. tostring(v))
--          elseif type(v) ~= "function" then     
--             table.insert(tmp, key ..":".. tostring(v))   
          end
        end
    end
    return "\n"..head.."{\n"..table.concat(tmp,",\n").."\n"..head.."}"
  end
  return ser_table(t,"ret", 1)..table.concat(assign," ")
end



function _G.LogTime(content)
    currTime = CSAPI.GetRealTime();
    lastTime = lastTime or currTime;    
    content = content or "";
    local s = content .. "，耗时：" .. (currTime - lastTime) ..  "，前一次：" .. lastTime .. "，现在：" .. currTime;
    
    lastTime = currTime;
    CS.CDebug.Log(s,"ddaa88");
end

function _G.Log(content,color) 
    if(noLog)then return; end
    color = color or "";
    if(type(content) =="table")then
      CS.CDebug.Log(table.tostring(content),color);
    else
	    CS.CDebug.Log(content or "nil",color);
    end
end

function _G.LuaLog(...)
  if(noLog)then return; end
  local p = {...}
  -- table.insert(p, "\n"..debug.traceback())

  local str = ""

  local maxn = #p
  for i,v in pairs(p) do
    if i > maxn then
      maxn = i
    end
  end

  for i=1,maxn do
    if type(p[i]) =="table" then
      str = str .. table.tostring(p[i])
    elseif type(p[i]) =="nil" then
      str = str .. "nil"
    elseif type(p[i]) =="boolean" then  
      if p[i] then
        str = str .. "true"
      else
        str = str .. "false"
      end
    else
      str = str .. p[i]
    end    
    str = str .. "\t"
  end

  print(str)
  -- for k,v in pairs(p) do
  --   if type(v) =="table" then
  --     p[k] = table.tostring(v)
  --   end
  -- end
  -- print(table.unpack(p));
end
--开发日志接口
function _G.DebugLog(content,color)
    if(noLog)then return; end
    color = color or "66aaee";
    Log( content,color);
end

function _G.LogError(content)
    if(type(content) =="table")then
        if _G.g_ver_name and CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.WindowsEditor then
          CS.CDebug.LogError("AppVersion = ".. _G.g_ver_name .. "\n" .. table.tostring(content,true).."\n"..debug.traceback());  
        else
          CS.CDebug.LogError( table.tostring(content,true).."\n"..debug.traceback());  
        end
    else
      if _G.g_ver_name and CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.WindowsEditor then
        CS.CDebug.LogError("AppVersion = ".. _G.g_ver_name .. "\n" .. (content or "nil").."\n"..debug.traceback(),color);
      else
        CS.CDebug.LogError((content or "nil").."\n"..debug.traceback(),color);
      end
    end
end

function _G.ShowTable(content)
    local s = table.tostring(content,true);
    local ss = Split(s,"\n");
    if(ss)then
        for _,str in ipairs(ss)do
            LogError(str);  
        end  
    end
end

function _G.Split(szFullString, szSeparator)  
local nFindStartIndex = 1  
local nSplitIndex = 1  
local nSplitArray = {}  
while true do  
    local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
     if not nFindLastIndex then  
      nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
      break  
    end  
    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
    nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
    nSplitIndex = nSplitIndex + 1  
 end  
 return nSplitArray  
 end 


function _G.LogWarning(content)
    if(type(content) =="table")then
        CS.CDebug.LogWarning(table.tostring(content).."\n"..debug.traceback());        
    else
	    CS.CDebug.LogWarning((content or "nil").."\n"..debug.traceback(),color);
    end
end

function _G.ServerLogError(content)
    if(noLog)then return; end
    LogError(content);
end

---
-- @function: 获取table的字符串格式内容，递归
-- @tab： table
-- @ind：不用传此参数，递归用（前缀格式（空格））
-- @return: format string of the table
function _G.DumpTable(tab,ind)
  if(tab==nil)then return "nil" end;
  local str="{";
  if(ind==nil)then ind="  "; end;
  --//each of table
  for k,v in pairs(tab) do
    --//key
    if(type(k)=="string")then
      k=tostring(k).." = ";
    else
      k="["..tostring(k).."] = ";
    end;--//end if
    --//value
    local s="";
    if(type(v)=="nil")then
      s="nil";
    elseif(type(v)=="boolean")then
      if(v) then s="true"; else s="false"; end;
    elseif(type(v)=="number")then
      s=v;
    elseif(type(v)=="string")then
      s="\""..v.."\"";
    elseif(type(v)=="table")then
      s=DumpTable(v,ind.."  ");
      s=string.sub(s,1,#s-1);
    --elseif(type(v)=="function")then
    --  s="function : "..v;
    elseif(type(v)=="thread")then
      s="thread : "..tostring(v);
    elseif(type(v)=="userdata")then
      s="userdata : "..tostring(v);
    else
      s="nuknow : "..tostring(v);
    end;--//end if
    --//Contact
    str=str.."\n"..ind..k..s.." ,";
  end --//end for
  --//return the format string
  local sss=string.sub(str,1,#str-1);
  if(#ind>0)then ind=string.sub(ind,1,#ind-2) end;
  sss=sss.."\n"..ind.."}\n";
  return sss;--string.sub(str,1,#str-1).."\n"..ind.."}\n";
end;--//end function

--//网摘,直接打印到屏幕
function _G.PrintTable(t, n)
  if "table" ~= type(t) then
    return 0;
  end
  n = n or 0;
  local str_space = "";
  for i = 1, n do
    str_space = str_space.."  ";
  end
  print(str_space.."{");
  for k, v in pairs(t) do
    local str_k_v
    if(type(k)=="string")then
      str_k_v = str_space.."  "..tostring(k).." = ";
    else
      str_k_v = str_space.."  ["..tostring(k).."] = ";
    end
    if "table" == type(v) then
      print(str_k_v);
      PrintTable(v, n + 1);
    else
      if(type(v)=="string")then
        str_k_v = str_k_v.."\""..tostring(v).."\"";
      else
        str_k_v = str_k_v..tostring(v);
      end
      print(str_k_v);
    end
  end
  print(str_space.."}");
end



function Dump(obj)
	local getIndent, quoteStr, wrapKey, wrapVal, dumpObj

	getIndent = function(level)
		return string.rep("\t", level)
	end

	quoteStr = function(str)
		-- print("quoteStr recv", str)
		-- local retStr ='"' .. string.gsub(str, '"', '\\"') .. '"'
		-- print("quoteStr ret", retStr)
		return string.format("%q", str)
	end

	wrapKey = function(val)
		if type(val) == "number" then
			return "[" .. val .. "]"
		elseif type(val) == "string" then
			return "[" .. quoteStr(val) .. "]"
		else
			return "[" .. tostring(val) .. "]"
		end
	end

	wrapVal = function(val, level)
		if type(val) == "table" then
			return dumpObj(val, level)
		elseif type(val) == "number" then
			return val
		elseif type(val) == "string" then
			return quoteStr(val)
		else
			return tostring(val)
		end
	end

	dumpObj = function(obj, level)
		if level >= 3 then
			return wrapKey("deep limit!!")
		end

		if type(obj) ~= "table" then
			return wrapVal(obj)
		end
		level = level + 1
		local tokens = {}
		tokens[#tokens + 1] = "{"
		for k, v in pairs(obj) do
			tokens[#tokens + 1] = getIndent(level) .. wrapKey(k) .. " = " .. wrapVal(v, level) .. ","
		end
		tokens[#tokens + 1] = getIndent(level - 1) .. "}"
		return table.concat(tokens, "\n")
	end

	return dumpObj(obj, 0)
end

-- arg, 可以传入 table, 或者单个变量
function LogEx(arg)
	if type(arg) == "table" then
		Log(Dump(arg))
	else
		Log(arg)
	end
end

_G.DrawLine=CS.CDebug.DrawLine;