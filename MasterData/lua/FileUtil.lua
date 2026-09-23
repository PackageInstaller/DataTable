local this={};
--local path = CS.CPath.persistentDataPath;

function this.GetPath()
    if(not path)then
        path = CS.CPath.FilterFileHead(CS.CPath.persistentDataPath);--CS.Application.persistentDataPath; 
    end

    return path;
end

function this.StringToTable(str)
    if(StringUtil:IsEmpty(str))then
        return;
    end
    local result=loadstring("return "..str);
    return result();
end

function this.ValToString(val)
    if type(val)=="string" then
        return "\""..val.."\"";
    else
        return tostring(val);
    end
end

function this.TableToString(tab)
    local str="";
    if  tab==nil then
        return str;
    end
    str="{";
    local num=1;
    for k,v in pairs(tab) do
        local single=num==1 and "" or ","; 
        if type(v)=="number" or type(v)=="string" or type(v)=="boolean" then
            str=str..single.."["..this.ValToString(k).."]="..this.ValToString(v);
        elseif type(v)=="table" then
            -- local metatable=getmetatable(tab);
            str=str..single.."["..this.ValToString(k).."]="..this.TableToString(v);
            -- if metatable~=nil and type(metatable.__index=="table") then
            --     local count=1;
            --     for k,v in pairs(metatable.__index) do
            --         local single2=count==1 and "" or ",";
            --         str=str..single2.."["..this.ValToString(k).."]="..this.ValToString(v);
            --         count=count+1;
            --     end
            -- end
        end
        num=num+1;
    end
    str=str.."}";
    return str;
end

--fileName:文件名要带后缀 data:数据 isUnUse:不使用uid记录
function this.SaveToFile(fileName,data,isUnUse)
    if fileName=="" or fileName==nil then
        LogError("文件名不能为空！");
        return 
    end
    local serverID = PlayerPrefs.GetInt(lastServerPath);
    local str=this.TableToString(data);
    if str~="" and str~=nil then
        --加密
        local encodeStr=Base64.enc(str);
        encodeStr=CSAPI.EncyptStr(encodeStr);
        encodeStr=encodeStr;
        local uid = isUnUse and 0 or PlayerClient:GetUid()
        local filePath=string.format("%s/%s_%s_%s",this.GetPath(),serverID,uid,fileName);
        -- CSAPI.SaveToFile(filePath,str);
        CSAPI.SaveToFile(filePath,encodeStr);
    end
end

--读取文件并返回lua对象 fileName:要带后缀 isUnUse:不使用uid记录
function this.LoadByPath(fileName,isUnUse)
    local tab=nil;
    if fileName=="" or fileName==nil then
        return tab;
    end
    local serverID = PlayerPrefs.GetInt(lastServerPath);
    local uid = isUnUse and 0 or PlayerClient:GetUid()
    local filePath= string.format("%s/%s_%s_%s",this.GetPath(),serverID,uid,fileName);
    local str=CSAPI.LoadStringByFile(filePath);
    if str~=nil and str~="" then
        local result=string.match(str,"[^a-zA-Z0-9/+=]+"); --加密串不会有花括号之类的标点符号
        if result~=nil then
            tab=this.StringToTable(str);
        else
            local dStr=CSAPI.EncyptStr(str);
            local dec=Base64.dec(dStr);
            tab=this.StringToTable(dec);
        end       
    end
    return tab;
end

return this;