local M = BaseClass("OtakuRoomLiveSpace")


function M:HeroId()
    return self.m_Data.HeroId
end

function M:Position()
    return self.m_Index
end

function M:LiveType()
    return self.m_Data.LiveType
end

function M:RoleStudio()
    return self.m_RoleStudio
end

function M:RoomId()
    return self.m_RoomId
end

function M:IsUp()
    return self.m_IsUp
end

function M:State()
    return self.m_State
end

function M:LockLevel()
    return self.m_LockLevel 
end

function M:IsLock()
    return self.m_Lock
end

function M:Select()
    return self.m_Select
end

function M:SetSelect(b)
    self.m_Select = b
end

function M:UpHero(data)
    self.m_IsUp = true
    self.m_Data = data
    self.m_RoleStudio = IRoleStudioHeroDataMgr:GetRoleStudioDataById(data.HeroId)
    self.m_State = OtakuType.DeployState.Plus
end

function M:RemoveHero()
    if self.m_Lock then
        return 
    end
    
    self.m_IsUp = false
    self.m_Data = {}
    self.m_RoleStudio = nil
    self.m_State = OtakuType.DeployState.Normal
end

function M:UnLock()
    self.m_Lock = false
    self.m_State = OtakuType.DeployState.Normal
end

function M:Init(index, roomId, settleType, config)
    self.settleRoomType = settleType
    self.m_Index = index
    self.m_RoomId = roomId
    self.m_Lock = true 
    self.m_State = OtakuType.DeployState.Lock
    self.m_IsUp = false
    self.m_LockLevel = 1
    self.m_Data = {}
    self.m_RoleStudio = nil
    self:_InitLockLevel(config)
end

function M:_InitLockLevel(config)
    for i, cfg in ipairs(config) do
        if cfg.num == self.m_Index then
            self.m_LockLevel = cfg.level
            break
        end
    end
end

return M
