--战斗记录
FightRecordMgr = oo.class();
local this = FightRecordMgr;


function this:Reset()
    self.datas = nil;
    self.protos = nil;
end


function this:PushProto(proto)
    self.protos = self.protos or {};
    table.insert(self.protos,proto);       
end

function this:Push(datas)
    self.datas = self.datas or {};
    table.insert(self.datas,datas);       
end

local fileName = "fr.txt";

--保存
function this:Save()
    if(self.datas)then
        local str = os.date("%d_%H:%M ");
        FileUtil.SaveToFile(str .. fileName,self.datas);
    end
end
--读取
function this:Read()
    local datas = FileUtil.LoadByPath(fileName);
    self:SetRecordDatas(datas);
    Log("读取战斗数据成功=============");
end

function this:SetRecordDatas(datas)
    self.recordDatas = datas;
    self.playIndex = 1;
    
    FightActionMgr:Start();
end

function this:Step()
    if(not self.recordDatas)then
        LogError("未设置播放记录");
        return;
    end
    local datas = self.recordDatas[self.playIndex];
    self.playIndex = self.playIndex + 1;
    if(not datas)then
        LogError("已是最后一条数据");
        return;
    end
    Log(string.format("播放数据：%s",table.tostring(datas,true)));
    FightActionMgr:PushSkill(datas);
end