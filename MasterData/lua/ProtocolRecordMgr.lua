ProtocolRecordMgr = oo.class();

local this = ProtocolRecordMgr;

function this:Record(proto,action)
    self.datas = self.datas or {};

    local data = {};
    data.proto = proto;
    data.action = action;
    data.time = os.date("%X"); 
    table.insert(self.datas,data);    
end

function this:GetDatas()
    return self.datas;
end

function this:RecordFight(proto,action)
    self.fightDatas = self.fightDatas or {};

    local data = {};
    data.proto = proto;
    data.action = action;
    data.title = action and "Send" or "Recv";
    data.time = os.date("%X"); 
    table.insert(self.fightDatas,data);    
end

function this:GetFightDatas()
    return self.fightDatas;
end

function this:SelLast()    
    self:SetSelIndex(self:GetSelIndex() - 1);
    self:WriteSelIndex();
end
function this:SelNext()    
    self:SetSelIndex(self:GetSelIndex() + 1);
    self:WriteSelIndex();
end
function this:SelHead()    
    self:SetSelIndex(1);
    self:WriteSelIndex();
end
function this:SelEnd()    
    self:SetSelIndex(9999999);
    self:WriteSelIndex();
end
function this:ShowSel()
    if(self.fightDatas)then
        --LogError(self:GetSelIndex() " / " .. #self.fightDatas);
        ShowTable(self.fightDatas[self:GetSelIndex()]);
    end
end
function this:WriteSelIndex()
    LogError(self:GetSelIndex() .. " / " .. #self.fightDatas);
end

function this:GetSelIndex()
    self.selIndex = self.selIndex or 1;
    return self.selIndex;
end
function this:SetSelIndex(val)
    val = math.max(1,val);
    val = math.min((self.fightDatas and #self.fightDatas or 1),val);
    self.selIndex = val;
end

----���뱣��
--function this:ApplySave()
--    self:Save();
--end
--local key = "key_proto_record";
--function this:Save()
--    if(not self.fileName)then        
--        local index = PlayerPrefs.GetInt(key) or 0;        
--        index = index + 1;
--        self.fileName = "proto record" .. index .. ".txt";
--        PlayerPrefs.SetInt(key,index);
--    end

--    self:SaveToFile(self.fileName,self.datas);
--end
--function this:Load()
--    local index = PlayerPrefs.GetInt(key) or 0;   
--    if(index <= 0)then
--        return;
--    end  

--    local fileName = "proto record" .. index .. ".txt";
--    local protoRecordDatas = self:LoadByPath(fileName);
--    LogError(protoRecordDatas);
--end


----fileName:�ļ���Ҫ����׺ data:����
--function this:SaveToFile(fileName,data)

--    local str = FileUtil.TableToString(data);
--    if str~="" and str~=nil then
--        local filePath=string.format("%s/%s",FileUtil.GetPath(),fileName);
--        CSAPI.SaveToFile(filePath,str);
--    end
--end
----��ȡ�ļ�������lua���� fileName:Ҫ����׺
--function this:LoadByPath(fileName)
--    local tab=nil;

--    local filePath= string.format("%s/%s",FileUtil.GetPath(),fileName);
--    local str=CSAPI.LoadStringByFile(filePath);

--    if str~=nil and str~="" then
--        tab = FileUtil.StringToTable(str);
--    end
--    return tab;
--end

return this;
