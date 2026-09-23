DungeonTeamReplaceMgr = MgrRegister("DungeonTeamReplaceMgr")
local this = DungeonTeamReplaceMgr;

function this:Init()
    self:Clear()
end

function this:Clear()
    self.saveTeamDatas = {}
end

function this:SaveTeamDatas(dupId,datas)
    if not dupId or not datas or #datas < 1 then
        return
    end
    self.saveTeamDatas[dupId] = datas
end

function this:GetTeamDatas(dupId)
    if dupId then
        return self.saveTeamDatas[dupId]
    end
end

function this:RequestData(url, callBack)
    if self.isRequest then
        return
    end
    self.isRequest = true

    -- 副本消息超时提示
    EventMgr.Dispatch(EventType.Net_Msg_Wait, {
        msg = "dungeon_activity_request",
        time = 5000,
        timeOutCallBack = function()
            self.isRequest = false
            LanguageMgr:ShowTips(1008)
        end
    });

    CSAPI.GetServerInfo(url, function(str)
        self.isRequest = false
        EventMgr.Dispatch(EventType.Net_Msg_Getted, "dungeon_activity_request")
        local json = Json.decode(str)
        if callBack then
            callBack(json)
        end
    end)
end

function this:GetTeamReplaceUrl(dungeonId)
    return ActivityMgr:GetBaseDownAddress() .. "DupPassTeam/DupPassTeamCfgId_" .. dungeonId .. ".json"
end

function this:GetTeamReplaceInfo(dungeonId)
    return self.dungeonTeams and self.dungeonTeams[dungeonId]
end

function this:SetTeamReplaceInfo(dungeonId, data)
    if not dungeonId or not data then
        return
    end
    self.dungeonTeams = self.dungeonTeams or {}
    self.dungeonTeams[dungeonId] = data
end

---------------------------------------------Coroutine

return this