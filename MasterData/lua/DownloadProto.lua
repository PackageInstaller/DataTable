DownloadProto={}
local this=DownloadProto;

---查询是否领取
function DownloadProto:CheckDownloadReward(cb)
    self.CheckDownloadRewardCB = cb
    if playerID == nil then
        -- playerID = PlayerClient.playerID
        playerID = PlayerClient:GetUid()
    end
    if playerID then        
        local proto = {"DownloadProto:CheckDownloadReward", { id = tonumber(playerID)}}
        NetMgr.net:Send(proto)
    else
        LogError("DownloadProto:CheckDownloadReward --playerID:"..tostring(ShopproductId))
    end
    
    -- local arr = {}
    -- arr.isGet = false
    -- DownloadProto:CheckDownloadRewardRet(arr)
end

---查询是否领取 返回
-- isGet:是否领取成功
function DownloadProto:CheckDownloadRewardRet(proto)
    if(self.CheckDownloadRewardCB ~= nil) then
        self.CheckDownloadRewardCB(proto)
    end
    if proto then
       if proto.isGet ~= nil then
            MenuMgr:SetDownloadRewardState(proto.isGet)    
       end 
    else
        LogError("DownloadProto:CheckDownloadRewardRet",table.tostring(proto,true))
    end
end

-- 获取奖励
function DownloadProto:GetDownloadReward(cb)
    self.GetDownloadRewardCB = cb
    if playerID == nil then
        playerID = PlayerClient:GetUid()
    end
    if playerID then        
        local proto = {"DownloadProto:GetDownloadReward", { id = tonumber(playerID)}}
        NetMgr.net:Send(proto)
    else
        LogError("DownloadProto:GetDownloadReward --playerID:"..tostring(ShopproductId))
    end
    
    -- local arr = {}
    -- arr.isGet = false
    -- DownloadProto:GetDownloadRewardRet(arr)
end

-- 获取奖励 返回参数
-- result:是否领取成功
function DownloadProto:GetDownloadRewardRet(proto)
    if(self.GetDownloadRewardCB ~= nil) then
        self.GetDownloadRewardCB(proto)
    end

    if proto then
        if proto.result ~= nil then
             MenuMgr:SetDownloadRewardState(proto.result)    
        end         
    else
        LogError("DownloadProto:GetDownloadRewardRet",table.tostring(proto,true))
    end
end