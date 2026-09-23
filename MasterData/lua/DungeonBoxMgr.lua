DungeonBoxMgr = MgrRegister("DungeonBoxMgr")
local this = DungeonBoxMgr

function this:Init()
    self:Clear()

    ClientProto:DupSumStarRewardInfo()
end

function this:Clear()
    self.datas = {}
end

function this:SetDatas(proto)
    if proto and proto.infos and #proto.infos > 0 then
        for i, v in ipairs(proto.infos) do
            if self.datas[v.id] then
                self.datas[v.id]:Init(v)
            else
                local data =  DungeonBoxData.New()
                data:Init(v)
                self.datas[v.id] = data
            end
        end
    end

    self:CheckRedPointData()
    EventMgr.Dispatch(EventType.Dungeon_Box_Refresh)
end

function this:GetDatas()
    return self.datas
end

function this:GetData(id)
    if id == nil then
        return
    end
    self.datas = self.datas or {}
    if self.datas[id] == nil then --没有则创建一个
        local data =  DungeonBoxData.New()
        data:Init({id = id})
        self.datas[id] = data
    end
    return self.datas[id]
end

function this:CheckRedPointData()
    local redData1 = self:CheckRed() and 1 or 2
    local redData2 = RedPointMgr:GetData(RedPointType.Attack)
    if redData1 ~= redData2 then
        RedPointMgr:UpdateData(RedPointType.Attack, redData)
    end
end

function this:CheckRed(sectionID, _hardLv)
    local sectionDatas = DungeonMgr:GetAllSectionDatas()
    if sectionDatas then
        for i, sData in ipairs(sectionDatas) do
            if sData:GetSectionType() == SectionType.MainLine and (not sectionID or sectionID == sData:GetID()) then --星级奖励只出现在主线
                local starRewardIDs = sData:GetCfg().starRewardID
                if starRewardIDs then
                    for hardLv, starRewardId in ipairs(starRewardIDs) do
                        if (not _hardLv or _hardLv == hardLv) and sData:GetState(hardLv) > 0 then --有无开启
                            local starNum = DungeonMgr:GetMainSectionStar(sData:GetID(),hardLv)
                            local boxData = self:GetData(starRewardId)
                            if boxData and starNum > 0  then
                                local cur,max = boxData:GetStage()
                                --获得的星数超过当前阶段最大星数
                                if cur <= max and starNum >= boxData:GetStarNum() then
                                    return true
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

return this