-- Desc: 玩家图鉴数据
---@class Player
local Player = require "Player"

--获取图鉴总数据
---@return table<integer, HandbookInfo> 图鉴数据
function Player:getHandbookData()
    return self.handbookData
end

--获取图鉴类型数据
---@param bookType integer 图鉴类型
---@return HandbookInfo 图鉴类型数据
function Player:getHandbookDataByType(bookType)
    local handbookData = self:getHandbookData()
    if not handbookData[bookType] then
        handbookData[bookType] = {
            data = {}
        }
    end
    return handbookData[bookType]
end

--根据类型及id获取图鉴数据
---@param bookType integer 图鉴类型
---@param id integer 图鉴id
---@return HandbookData 图鉴数据
function Player:getHandbookDataByTypeAndId(bookType, id)
    local bookTypeData = self:getHandbookDataByType(bookType)
    return bookTypeData.data[id]
end

--保存剧情图鉴
---@param storyId integer 剧情id
---@param proto UserInfo 用户数据
function Player:saveStoryHandbookData(storyId, proto)
    local storyData = self:getHandbookDataByTypeAndId(GE.HandbookType.Story, storyId)
    if not storyData then
        local storyConfig = Config.GetStoryArraryInfo(storyId)

        -- 如果剧情配置内有章节信息，先保存该章节的图鉴信息
        if storyConfig and storyConfig.chapter and storyConfig.chapter ~= 0 then
            local chapterId = storyConfig.chapter
            local chapterData = self:getHandbookDataByTypeAndId(GE.HandbookType.Story, chapterId)

            -- 章节图鉴数据不存在时才创建
            if not chapterData then
                chapterData = {
                    count = 0,
                    getTime = DLuaUtil.GetGreenwichTime(),
                    isCollected = false
                }
                local bookTypeData = self:getHandbookDataByType(GE.HandbookType.Story)
                bookTypeData.data[chapterId] = chapterData

                if proto then
                    if not proto.handbookData then
                        proto.handbookData = {}
                    end
                    if not proto.handbookData[GE.HandbookType.Story] then
                        proto.handbookData[GE.HandbookType.Story] = {
                            data = {}
                        }
                    end
                    proto.handbookData[GE.HandbookType.Story].data[chapterId] = chapterData
                end
            end
        end

        -- 保存剧情图鉴数据
        storyData = {
            count = 0,
            getTime = DLuaUtil.GetGreenwichTime(),
            isCollected = false
        }
        local bookTypeData = self:getHandbookDataByType(GE.HandbookType.Story)
        bookTypeData.data[storyId] = storyData
        if proto then
            if not proto.handbookData then
                proto.handbookData = {}
            end
            if not proto.handbookData[GE.HandbookType.Story] then
                proto.handbookData[GE.HandbookType.Story] = {
                    data = {}
                }
            end
            proto.handbookData[GE.HandbookType.Story].data[storyId] = storyData
        end
    end
end

--保存装备图鉴
---@param equipCid integer 装备配置id
---@param proto UserInfo 用户数据
---@param addCount integer? 增加数量，默认为1
---@return ActionFailReason? 错误码
function Player:saveEquipHandbookData(equipCid, proto, addCount)
    --装备配置检测
    local equipConfig = Config.GetEquipmentInfo(equipCid)
    if not equipConfig then
        return ActionFailReason.CfgNotFind
    end
    addCount = addCount or 1
    local equipData = self:getHandbookDataByTypeAndId(GE.HandbookType.Equip, equipCid)
    if not equipData then
        equipData = {
            getTime = DLuaUtil.GetGreenwichTime(),
            count = 0,
            isCollected = false
        }
        local bookTypeData = self:getHandbookDataByType(GE.HandbookType.Equip)
        bookTypeData.data[equipCid] = equipData
    end
    equipData.count = (equipData.count or 0) + addCount
    if proto then
        if not proto.handbookData then
            proto.handbookData = {}
        end
        if not proto.handbookData[GE.HandbookType.Equip] then
            proto.handbookData[GE.HandbookType.Equip] = {
                data = {}
            }
        end
        proto.handbookData[GE.HandbookType.Equip].data[equipCid] = equipData
    end
    return ActionFailReason.None
end

--保存武器图鉴
---@param weaponCid integer 武器配置id
---@param proto UserInfo 用户数据
---@param addCount integer? 增加数量，默认为1
---@return ActionFailReason? 错误码
function Player:saveWeaponHandbookData(weaponCid, proto, addCount)
    --武器配置检测
    local weaponConfig = Config.GetWeaponInfo(weaponCid)
    if not weaponConfig then
        return ActionFailReason.CfgNotFind
    end
    addCount = addCount or 1
    local weaponData = self:getHandbookDataByTypeAndId(GE.HandbookType.Weapon, weaponCid)
    if not weaponData then
        weaponData = {
            getTime = DLuaUtil.GetGreenwichTime(),
            count = 0,
            isCollected = false
        }
        local bookTypeData = self:getHandbookDataByType(GE.HandbookType.Weapon)
        bookTypeData.data[weaponCid] = weaponData
    end
    weaponData.count = (weaponData.count or 0) + addCount
    if proto then
        if not proto.handbookData then
            proto.handbookData = {}
        end
        if not proto.handbookData[GE.HandbookType.Weapon] then
            proto.handbookData[GE.HandbookType.Weapon] = {
                data = {}
            }
        end
        proto.handbookData[GE.HandbookType.Weapon].data[weaponCid] = weaponData
    end
    return ActionFailReason.None
end

--刷新图鉴数据
---@param data table<integer, HandbookInfo> 图鉴信息
function Player:updateHandbookData(data)
    for handbookType, typeData in pairs(data) do
        for id, value in pairs(typeData.data) do
            local bookTypeData = self:getHandbookDataByType(handbookType)
            bookTypeData.data[id] = value
        end
    end
end

--检查指定图鉴是否已解锁
---@param bookType HandbookType 图鉴类型
---@param id integer 图鉴id
---@return boolean 是否已解锁
function Player:isHandbookUnlocked(bookType, id)
    local handbookData = self:getHandbookDataByTypeAndId(bookType, id)
    return handbookData ~= nil
end

--获取指定图鉴的拥有数量
---@param bookType integer 图鉴类型
---@param id integer 图鉴id
---@return integer 拥有数量
function Player:getHandbookCount(bookType, id)
    local handbookData = self:getHandbookDataByTypeAndId(bookType, id)
    if not handbookData then
        return 0
    end
    return handbookData.count or 0
end

--获取指定图鉴的解锁时间
---@param bookType integer 图鉴类型
---@param id integer 图鉴id
---@return integer? 解锁时间戳，未解锁返回nil
function Player:getHandbookUnlockTime(bookType, id)
    local handbookData = self:getHandbookDataByTypeAndId(bookType, id)
    if not handbookData then
        return nil
    end
    return handbookData.getTime
end

--获取某类型图鉴的解锁总数
---@param bookType integer 图鉴类型
---@return integer 解锁总数
function Player:getHandbookUnlockCount(bookType)
    local bookTypeData = self:getHandbookDataByType(bookType)
    return tablex.size(bookTypeData.data)
end

--获取某类型图鉴的全部已解锁id列表
---@param bookType integer 图鉴类型
---@return integer[] 已解锁的id列表
function Player:getHandbookUnlockedIdList(bookType)
    local idList = {}
    local bookTypeData = self:getHandbookDataByType(bookType)
    for id, _ in pairs(bookTypeData.data) do
        table.insert(idList, id)
    end
    return idList
end

--获取某类型图鉴的收集进度
---@param bookType integer 图鉴类型
---@param totalCount integer 该类型图鉴的总数量
---@return number 收集进度百分比(0-100)
function Player:getHandbookProgress(bookType, totalCount)
    if totalCount <= 0 then
        return 0
    end
    local unlockCount = self:getHandbookUnlockCount(bookType)
    return (unlockCount / totalCount) * 100
end

--登录检查图鉴数据迁移（图鉴系统上线时为老玩家填充数据）
---@param proto UserInfo? 用户数据
function Player:loginCheckHandbookMigration(proto)
    if not GV.IsServer then
        return
    end

    -- 检查是否已经迁移过
    if self:getUserData().handbookMigrated then
        return
    end

    -- 执行迁移
    local result = self:migrateInventoryToHandbook(proto)
    self:getUserData().handbookMigrated = true

    -- 记录迁移日志
    if result.equipCount > 0 or result.weaponCount > 0 then
        LuaLogger.ds(string.format("[图鉴迁移] uid=%d 装备:%d 武器:%d 错误:%d", 
            self.uid, result.equipCount, result.weaponCount, result.errorCount))
    end
end

--迁移玩家仓库装备和武器到图鉴系统（用于老玩家数据填充）
---@param proto UserInfo? 用户数据
---@return table 迁移结果统计 {equipCount=装备数量, weaponCount=武器数量, errorCount=错误数量}
function Player:migrateInventoryToHandbook(proto)
    local result = {
        equipCount = 0,
        weaponCount = 0,
        errorCount = 0
    }

    -- 迁移装备图鉴
    local equipMap = self:getAllEquipData()
    if equipMap then
        for _, equipData in pairs(equipMap) do
            if equipData and equipData.cid then
                local ret = self:saveEquipHandbookData(equipData.cid, proto, 1)
                if ret == ActionFailReason.None then
                    result.equipCount = result.equipCount + 1
                else
                    result.errorCount = result.errorCount + 1
                end
            end
        end
    end

    -- 迁移武器图鉴
    local weaponMap = self:getAllWeaponData()
    if weaponMap then
        for _, weaponData in pairs(weaponMap) do
            if weaponData and weaponData.cid then
                local ret = self:saveWeaponHandbookData(weaponData.cid, proto, 1)
                if ret == ActionFailReason.None then
                    result.weaponCount = result.weaponCount + 1
                else
                    result.errorCount = result.errorCount + 1
                end
            end
        end
    end

    return result
end

--设置图鉴收藏状态
---@param bookType integer 图鉴类型
---@param id integer 图鉴id
---@param isCollected boolean 是否收藏
---@param proto UserInfo? 用户数据
---@return ActionFailReason 错误码
function Player:setHandbookCollected(bookType, id, isCollected, proto)
    local handbookData = self:getHandbookDataByTypeAndId(bookType, id)
    if not handbookData then
        return ActionFailReason.HandbookNoFind
    end

    handbookData.isCollected = isCollected

    if proto then
        if not proto.handbookData then
            proto.handbookData = {}
        end
        if not proto.handbookData[bookType] then
            proto.handbookData[bookType] = {
                data = {}
            }
        end
        proto.handbookData[bookType].data[id] = handbookData
    end

    return ActionFailReason.None
end

--反转图鉴收藏状态（用于切换收藏/取消收藏）
---@param bookType integer 图鉴类型
---@param id integer 图鉴id
---@param proto UserInfo? 用户数据
---@return ActionFailReason 错误码
---@return boolean? 新的收藏状态
function Player:toggleHandbookCollected(bookType, id, proto)
    --参数验证
    if not bookType or not id then
        return ActionFailReason.ParameterInvalid, nil
    end

    --图鉴类型检测
    if not tablex.contains(GE.HandbookType, bookType) then
        return ActionFailReason.ParameterInvalid, nil
    end

    local handbookData = self:getHandbookDataByTypeAndId(bookType, id)
    if not handbookData then
        return ActionFailReason.HandbookNoFind, nil
    end

    -- 反转当前状态
    local newCollectedState = not (handbookData.isCollected or false)
    handbookData.isCollected = newCollectedState

    if proto then
        if not proto.handbookData then
            proto.handbookData = {}
        end
        if not proto.handbookData[bookType] then
            proto.handbookData[bookType] = {
                data = {}
            }
        end
        proto.handbookData[bookType].data[id] = handbookData
    end

    return ActionFailReason.None, newCollectedState
end

--获取图鉴收藏状态
---@param bookType integer 图鉴类型
---@param id integer 图鉴id
---@return boolean 是否已收藏，未解锁的图鉴返回false
function Player:isHandbookCollected(bookType, id)
    local handbookData = self:getHandbookDataByTypeAndId(bookType, id)
    if not handbookData then
        return false
    end
    return handbookData.isCollected or false
end

--获取某类型图鉴的所有已收藏id列表
---@param bookType integer 图鉴类型
---@return integer[] 已收藏的id列表
function Player:getHandbookCollectedIdList(bookType)
    local idList = {}
    local bookTypeData = self:getHandbookDataByType(bookType)
    for id, handbookData in pairs(bookTypeData.data) do
        if handbookData.isCollected then
            table.insert(idList, id)
        end
    end
    return idList
end

--根据关卡id记录怪物图鉴
---@param levelId integer 关卡id
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
function Player:setMonsterHandbookDataByLevelId(levelId, proto)
    local stageConfig = Config.GetPveLevelInfo(levelId)
    if not stageConfig then
        return ActionFailReason.CfgNotFind
    end
    for _, monsterData in ipairs(stageConfig.monsterShow) do
        local monsterId = monsterData[1]
        local ret = self:saveMonsterHandbookData(monsterId, proto)
        if ret ~= ActionFailReason.None and ret ~= ActionFailReason.CfgNotFind then
            return ret
        end
    end
    return ActionFailReason.None
end

--保存怪物图鉴
---@param monsterId integer 怪物id
---@param proto UserInfo 用户数据
---@return ActionFailReason? 错误码
function Player:saveMonsterHandbookData(monsterId, proto)
    --怪物id检测
    local monsterConfig = Config.GetMonsterInfo(monsterId)
    if not monsterConfig then
        return ActionFailReason.CfgNotFind
    end
    local monsterData = self:getHandbookDataByTypeAndId(GE.HandbookType.Monster, monsterId)
    if monsterData then
        return ActionFailReason.None
    end
    monsterData = {
        getTime = DLuaUtil.GetGreenwichTime()
    }
    local bookTypeData = self:getHandbookDataByType(GE.HandbookType.Monster)
    bookTypeData.data[monsterId] = monsterData
    if proto then
        if not proto.handbookData then
            proto.handbookData = {}
        end
        if not proto.handbookData[GE.HandbookType.Monster] then
            proto.handbookData[GE.HandbookType.Monster] = {
                data = {}
            }
        end
        proto.handbookData[GE.HandbookType.Monster].data[monsterId] = monsterData
    end
    return ActionFailReason.None
end

--获取某类型图鉴的已收藏数量
---@param bookType integer 图鉴类型
---@return integer 已收藏数量
function Player:getHandbookCollectedCount(bookType)
    local count = 0
    local bookTypeData = self:getHandbookDataByType(bookType)
    for _, handbookData in pairs(bookTypeData.data) do
        if handbookData.isCollected then
            count = count + 1
        end
    end
    return count
end

return Player