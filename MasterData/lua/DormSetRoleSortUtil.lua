-- 驻员入驻界面
-- 角色排序工具
DormSetRoleSortUtil = {}

local this = DormSetRoleSortUtil
local funcs = {}
local curRoomID

-- 优先度：
-- 基地： 有房间》 可用技能》好感度》疲劳值》角色id
-- 宿舍： 有房间》 疲劳值》好感度》角色id
function this:Init()
    local newList = g_DormSetRoleOrder or {1, 2, 3, 4}
    if (self.buildType == nil) then
        newList = {1, 3, 2, 4}
    end

    local list = {}
    list[1] = self.SortByUseable
    list[2] = self.SortByFavo
    list[3] = self.SortByTv
    list[4] = self.SortByID
    funcs = {}
    for i, v in ipairs(newList) do
        if (i <= #list) then
            table.insert(funcs, {v, list[v]})
        end
    end
end

function this:SortByCondition(_datas, _curRoomID)
    if (_datas == nil or #_datas <= 1) then
        return _datas
    end
    self.newDatas = _datas
    -- curRoomID = _curRoomID

    -- 建筑类型（无,表示是宿舍）
    self.buildType = nil
    local roomType = DormMgr:GetRoomTypeByID(_curRoomID) -- 房间类型
    if (roomType == RoomType.building) then
        local buildData = MatrixMgr:GetBuildingDataById(_curRoomID)
        self.buildType = buildData:GetType()
    end
    self:Init()

    self.sortType = DormMgr:GetSetRoleSortTab()

    self:SelectBy1()
    -- self:SelectBy2()  --只显示技能有效的角色,该筛选无作用
    self:MSort()
    return self.newDatas
end

-- 小队
function this:SelectBy1()
    local rule = self.sortType.RoleTeam
    if (rule[1] == 0) then
        return
    end
    local newRule = {}
    for i, v in ipairs(rule) do
        newRule[v] = v
    end
    local len = #self.newDatas
    for i = len, 1, -1 do
        if (newRule[self.newDatas[i]:GetTeam()] == nil) then
            table.remove(self.newDatas, i)
        end
    end
end

-- -- 进驻位置筛选
-- function this:SelectBy2()
--     local rule = self.sortType.Pos
--     if (rule[1] == 0) then
--         return
--     end
--     local posCfg = Cfgs["DormPos_Cfg"]:GetAll()
--     local posCfgLen = #posCfg
--     local newRule = {}
--     for i, v in ipairs(rule) do
--         if (v == 1) then
--             -- 未进驻
--             newRule[10000] = 1
--         elseif (v == posCfgLen) then
--             -- 宿舍
--             newRule[10001] = 1
--         else
--             -- 建筑
--             local cfg = Cfgs["DormPos_Cfg_Datas"]:GetByID(v)
--             newRule[cfg.buildID] = 1
--         end
--     end

--     local len = #self.newDatas
--     for i = len, 1, -1 do
--         local _type = 10000
--         local roomID = self.newDatas[i]:GetRoomBuildID()
--         if (roomID) then
--             local roomType = DormMgr:GetRoomTypeByID(roomID)
--             if (roomType == RoomType.building) then
--                 local buildData = MatrixMgr:GetBuildingDataById(roomID)
--                 local cfgID = buildData:GetCfgId()
--                 _type = cfgID
--             end
--         end
--         if (newRule[_type] == nil) then
--             table.remove(self.newDatas, i)
--         end
--     end
-- end

function this:MSort()
    firstIndex = 1
    for i, v in ipairs(funcs) do
        if (v[1] == self.sortType.Sort[1]) then
            firstIndex = i
        end
    end
    table.sort(self.newDatas, function(a, b)
        return self:SortFunc(a, b)
    end)
end

function this:SortFunc(a, b)
    local result = self.SortByHadRoom(a, b)
    if (result == nil) then
        local firstFunc = funcs[firstIndex]
        result = firstFunc[2](a, b, self.buildType)
    end
    if (result == nil) then
        for i, v in ipairs(funcs) do
            if (i ~= firstIndex) then
                if (result == nil) then
                    result = v[2](a, b, self.buildType)
                else
                    break
                end
            end
        end
    end
    return result or false
end

-- 是否已有房间
function this.SortByHadRoom(a, b)
    local id1 = a:GetRoomBuildID() or -1
    local id2 = b:GetRoomBuildID() or -1
    if (id1 == id2) then
        return nil
    else
        return id1 > id2
    end
end

-- 技能在建筑是否可以用
function this.SortByUseable(a, b, buildType)
    if (buildType ~= nil) then
        local num1 = a:CheckSkillCanUseByBuildType(buildType) and 1 or 0
        local num2 = b:CheckSkillCanUseByBuildType(buildType) and 1 or 0
        if (num1 ~= num2) then
            return num1 > num2
        end
    end
    return nil
end

--[[
-- 是否在当前房间
function this.SortByCurRoom(a, b)
    local a1 = 0
    local a1ID = a:GetRoomBuildID()
    if (a1ID and a1ID == curRoomID) then
        a1 = 3
    elseif (a1ID) then
        a1 = 2
    end

    local b1 = 0
    local b1ID = b:GetRoomBuildID()
    if (b1ID and b1ID == curRoomID) then
        b1 = 3
    elseif (b1ID) then
        b1 = 2
    end

    if (a1 == b1) then
        return nil
    else
        return a1 > b1
    end
end
]]
function this.SortByTv(a, b, buildType)
    if (a:GetCurRealTv() == b:GetCurRealTv()) then
        return nil
    else
        if (buildType == nil) then
            return a:GetCurRealTv() < b:GetCurRealTv()
        else
            return a:GetCurRealTv() > b:GetCurRealTv()
        end
    end
end
--[[
function this.SortBySkillID(a, b)
    if (a:GetAbilityId() == b:GetAbilityId()) then
        return nil
    else
        return a:GetAbilityId() < b:GetAbilityId()
    end
end
]]

function this.SortByFavo(a, b)
    if (a:GetLv() == b:GetLv()) then
        return nil
    else
        return a:GetLv() > b:GetLv()
    end
end

function this.SortByID(a, b)
    if (a:GetID() == b:GetID()) then
        return nil
    else
        return a:GetID() > b:GetID()
    end
end

-- this:Init()

return this
