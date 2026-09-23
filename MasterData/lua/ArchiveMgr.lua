local this = MgrRegister("ArchiveMgr")

-- datas{
-- type = typeData={
-- count = 0
-- ids = {id = 0 }
-- }
-- }
-- 未做剧情红点
function this:Init()
    self.datas = {}
    self.News = {}
    self:InitCount()
end

function this:Clear()
    self.datas = {}
    self.News = {}
end

-- 初始化
function this:InitCount()
    for _, _type in pairs(ArchiveType) do
        self.datas[_type] = self:LoadFile(_type) or {}
    end
end

-- 读取文件
function this:LoadFile(_type)
    return FileUtil.LoadByPath("ArchiveCount" .. _type .. ".txt") or {}
end

-- 保存文件
function this:SaveFile(_type, _data)
    FileUtil.SaveToFile("ArchiveCount" .. _type .. ".txt", _data)
end

-- 获取数据
function this:GetData(_type)
    return self.datas[_type]
end

-- 获取数量
function this:GetCount(_type)
    return self:GetData(_type) and self:GetData(_type).count or 0
end

-- 设置数量
function this:SetCount(_type, _count)
    self.datas[_type] = self.datas[_type] or {}
    self.datas[_type].count = _count
    self:SaveFile(_type, self.datas[_type])
end

-- 角色数量
function this:GetRoleCount()
    local count, max = CRoleMgr:GetCount()
    if self:GetCount(ArchiveType.Role) < count then
        self.News[ArchiveType.Role] = true
        self:SetCount(ArchiveType.Role, count)
    end
    return count, max
end

-- 敌人数量
function this:GetEnemyCount()
    local count = 0
    local max = 0
    local cfgs = Cfgs.CfgArchiveMonster:GetAll()
    for i, v in pairs(cfgs) do
        if (v.bShowInAltas) then
            max = max + 1
            if v.unlock_type == 1 then
                local isLock = true
                for _, _id in ipairs(v.unlock_id) do
                    local dData = DungeonMgr:GetDungeonData(_id)
                    if dData and dData:IsPass() then
                        isLock = false
                        break
                    end
                end
                if not isLock then
                    count = count + 1
                end
            end
        end
    end

    if self:GetCount(ArchiveType.Enemy) < count then
        self.News[ArchiveType.Enemy] = true
        self:SetCount(ArchiveType.Enemy, count)
    end

    return count, max
end

-- 剧情数量
function this:GetMemoriesCount()
    local count = 0
    local max = 0
    local cfgs = Cfgs.CfgArchiveStory:GetAll()
    for i, v in pairs(cfgs) do
        local _count, _max = self:GetMemoryCountByID(v.id)
        count = count + _count
        max = max + _max
    end

    if self:GetCount(ArchiveType.Story) < count then
        self.News[ArchiveType.Story] = true
    end
    self:SetCount(ArchiveType.Story, count)

    return count, max
end

-- 子剧情数量
function this:GetMemoryCountByID(_id)
    local count = 0
    local max = 0
    local cfg = Cfgs.CfgArchiveStory:GetByID(_id)
    if (cfg and cfg.infos) then
        for k, m in ipairs(cfg.infos) do
            if (PlotMgr:IsPlayed(m.story_id)) then
                count = count + 1
            elseif m.lock then
                local dungeonData = DungeonMgr:GetDungeonData(m.lock)
                if dungeonData and dungeonData:IsPass() then
                    count = count + 1
                end
            end
        end
        max = max + #cfg.infos
    end
    return count, max
end

-- 看板数量
function this:GetBoardCounts()
    local count = 0
    local max = 0
    local cfgs = Cfgs.CfgArchiveIllustration:GetAll()
    if (cfgs) then
        for i, v in pairs(cfgs) do
			local _count, _max = self:GetBoardCountByID(v.id)
			count = count + _count
			max = max + _max
        end
    end

	if self:GetCount(ArchiveType.Board) < count then
        self.News[ArchiveType.Board] = true
    end
    self:SetCount(ArchiveType.Board, count)
end

-- 看板数量
function this:GetBoardCountByID(id)
    local count = 0
    local max = 0
    local cfg = Cfgs.CfgArchiveIllustration:GetByID(id)
    if (cfg and cfg.infos) then
        for i, v in ipairs(cfg.infos) do
            local data = MulPicMgr:GetData(v.board_id)
            if v.shopId then
                local cfgBoard = Cfgs.CfgArchiveMultiPicture:GetByID(v.board_id)
                if cfgBoard and cfgBoard.itemId then 
                    if BagMgr:GetCount(cfgBoard.itemId) > 0 then --查询背包
                        count = count + 1
                        max = max + 1
                    elseif ShopMgr:HasBuyRecord(v.shopId) then --已购买
                        if data and data:IsHad() then
                            count = count + 1
                        end
                        max = max + 1
                    else
                        local commodity =ShopMgr:GetFixedCommodity(v.shopId)
                        if commodity and commodity:GetNowTimeCanBuy() then --当前商品是否在销售
                            if data and data:IsHad() then
                                count = count + 1
                            end
                            max = max + 1
                        end
                    end
                end
            else
                if data and data:IsHad() then
                    count = count + 1
                end
                max = max + 1
            end
        end
    end
    return count, max
end

function this:GetBiteCounts()
    local count = 0
    local max = 0
    local cfgs = Cfgs.CfgArchiveBite:GetAll()
    if cfgs then
        for _, cfg in pairs(cfgs) do
            if cfg.infos then
                for k, m in ipairs(cfg.infos) do
                    if m.item_id and BagMgr:GetCount(m.item_id) > 0 then
                        count = count + 1
                    end
                    max = max + 1
                end
            end
        end
    end
    if self:GetCount(ArchiveType.Bite) < count then
        self.News[ArchiveType.Bite] = true
    end
    self:SetCount(ArchiveType.Bite, count)
    return count, max
end

-- 获取new
function this:GetIsNew(_type)
    if (_type) then
        self.News[_type] = self.News[_type] or false
        return self.News[_type]
    end
    for i, v in pairs(self.News) do
        if (v == true) then
            return true
        end
    end
    local newCount = 0
    for aType, data in pairs(self.datas) do
        if (data.ids) then
            for _, state in pairs(data.ids) do
                if (state == 1) then
                    self.News[aType] = true
                    newCount = newCount + 1
                end
            end
        end
    end
    return newCount > 0
end

-- 设置new
function this:SetIsNew(_type, _isNew)
    self.News[_type] = _isNew
end

-- 设置具体图鉴物体new状态
function this:SetNew(_type, _id, _isNew)
    if (_type) then
        self:SetIsNew(_type, true)
        self.datas[_type].ids = self.datas[_type].ids or {}
        self.datas[_type].ids[_id] = _isNew and 1 or 2 -- 1为new，2为old
        self:SaveFile(_type, self.datas[_type])
    end
end

-- 获取具体图鉴物体new状态
function this:GetNew(_type, _id)
    local _data = self:GetData(_type)
    if (_data and _data.ids) then
        for i, v in pairs(_data.ids) do
            if (_id == i) then
                return v == 1
            end
        end
    end
    return false
end

function this:CheckRedPoint(_type)
    RedPointMgr:UpdateData(RedPointType.Archive, self:CheckRed(_type) and 1 or nil)
end

function this:CheckRed(_type)
    if _type == nil or _type == ArchiveType.Enemy then --刷新敌人
        self:GetEnemyCount()
    end
    if _type == nil or _type == ArchiveType.Board then --刷新插画
        self:GetBoardCounts()
    end
    if _type == nil or _type == ArchiveType.Role then --刷新角色
        self:GetRoleCount()
    end
    if _type == nil or _type == ArchiveType.Bite then --刷新图鉴
        self:GetBiteCounts()
    end
    local isRed = self:GetIsNew()
    if not isRed then
        isRed = ASMRMgr:IsRed()
    end
    if not isRed then
        isRed = MissionMgr:CheckRed({eTaskType.StoryCollection})
    end
    return isRed
end

return this
