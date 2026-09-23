--战斗数据管理器
local this = {};
FightActionDataMgr = this;

FightActionDataMgr.fight_data_key = "fight_data_key";
FightActionDataMgr.fight_data_list_key = "fight_data_list_key";

--重置
function this:Reset()   
    self:Init();

    if(self.isEnable)then
	    self.content = nil;
        self.needCommitListData = nil;  
        self.commitFlag = nil;    
        self.commitKey = nil;  
    end
end

--增加数据
function this:Push(data)
    if(not self.isEnable)then
        return;
    end

	if(not data)then
		return;
	end
	
    if(not self.content)then
        self.content = os.date("%Y-%m-%d %H:%M:%S");
    end

    local str = table.tostring(data);

    if(str)then
        self.content = self.content .. "\n****************************************************************************************************************************************\n" .. str;
	end

    
    if(self.commitFlag)then
        return;
    else
        self.commitFlag = 1;
        FuncUtil:Call(self.ApplyCommit,self,2000);
    end
end

function this:ApplyCommit()
    self.commitFlag = nil;
    self:Commit();
end

--提交
function this:Commit()
    local key = self:GetCommitKey();
    if(key and self.content)then
        LogError("提交：" .. key .. ":" .. self.content);
        PlayerProto:SetClientData(key,{ content = self.content});
    end

    if(self.needCommitListData)then
        LogError("提交：\n" .. table.tostring(self.listData));
        PlayerProto:SetClientData(self.fight_data_key,self.listData);
        self.needCommitListData = nil;
    end
end
--获取提交key
function this:GetCommitKey()
    if(not self.commitKey)then
        self.listData = self.listData or {};
        table.insert(self.listData,os.date("%Y-%m-%d %H:%M:%S"));
        self.commitKey = self.fight_data_key .. #self.listData;        

        self.needCommitListData = 1;
    end

    return self.commitKey;
end

function this:Init()
    if(self.isInit)then
        return;
    end
    self.isInit = 1;

    --self.isEnable = 1;
    if(self.isEnable)then
        PlayerProto:GetClientData(self.fight_data_list_key);
    end
end

function this:SetListData(data)
    self.listData = data or {};
end

function this:DownloadFightData(index)
    local key = self.fight_data_key .. index;
    PlayerProto:GetClientData(key);
end

return this;