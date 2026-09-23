require "DormFurnitureSortUtil"
require "DormSetRoleSortUtil"
require "DormIconUtil"

local DormFurnitureData = require "DormFurnitureData"
local DormColData = require "DormColData"
local DormRoomData = require "DormRoomData"

local this = MgrRegister("DormMgr")

DormFurnitrueSortType = {
    shop = 1,
    layout = 2
}

function this:Clear()
    self.friendRoomDatas = {}
    self.roomDatas = {}
    self.themeDatas = nil
    self.BuyRecords = nil
    self.dormGround = nil

    self.sortTypes = nil -- 排序
    self.orderTypes = nil -- 升降
    self.price = nil
end

function this:Init()
    self:Clear()

    self.friendRoomDatas = {}
    self.roomDatas = {}
    self.sortTypes = {} -- 排序
    self.orderTypes = {} -- 升降
    self.price = {10013, 10002} -- 货币id
    self.defaultGroundID = 1001
    self.defaultWallID = 1002

    -- self:InitCfgs()
end

function this:RequestDormProtoServerData()
    -- 服务器压力大，不要在登录的时候发送
    DormProto:BuyRecord()
    DormProto:GetOpenDorm()
    DormProto:GetSelfTheme({ThemeType.Share, ThemeType.Sys}) -- 先获取分享数据，以获取长度，或分享时插入数据
end

-- -- 初始化表
-- function this:InitCfgs()
--     -- 计算主题表的舒适度和价格
--     local cfgs = Cfgs.CfgFurnitureTheme:GetAll()
--     for k, v in pairs(cfgs) do
--         local comfort, price_1, price_2 = 0, 0, 0
--         local id1, id2 = nil, nil
--         local layoutCfg = Cfgs.CfgThemeLayout:GetByID(v.layoutId)
--         if (layoutCfg) then
--             for n, m in ipairs(layoutCfg.infos) do
--                 local cfg = Cfgs.CfgFurniture:GetByID(m.cfgID)
--                 comfort = comfort + cfg.comfort
--                 price_1 = price_1 + cfg.price_1[1][2]
--                 price_2 = price_2 + cfg.price_2[1][2]
--                 if (id1 == nil) then
--                     id1, id2 = cfg.price_1[1][1], cfg.price_2[1][1]
--                 end
--             end
--         end
--         cfgs[k].comfort = comfort
--         cfgs[k].price_1 = {{id1, price_1}}
--         cfgs[k].price_2 = {{id2, price_2}}
--     end
--     -- 家具类型表重新排序
--     local cfgs = Cfgs.CfgFurnitureEnum:GetAll()
--     table.sort(cfgs, function(a, b)
--         return a.index < b.index
--     end)
-- end

function this:GetPrice()
    return self.price
end

-- ==============================--
-- desc:创建交互数据块
-- time:2022-02-08 05:48:28
-- @lua1:碰撞者
-- @lua2:被碰撞者
-- @return 
-- ==============================--
function this:CreateDormColData(lua1, lua2, colType, targetGO, _isTookDown)
    local _data = DormColData.New()
    _data:InitData(lua1, lua2, colType, targetGO, _isTookDown)
    return _data
end

-- 根据id获取房间类型 小于10000是宿舍  
function this:GetRoomTypeByID(id)
    local roomType = nil
    if (id) then
        if (GCalHelp:IsDormId(id)) then
            roomType = RoomType.dorm
        else
            roomType = RoomType.building
        end
    end
    return roomType
end

-- 截图名称 roomID为空，表示只是保存个自由主题,按时间区分，否则按房间区分
function this:GetScreenshotFileName(roomID)
    local _roomID = roomID == nil and "xxx" or roomID
    local _themeID = roomID == nil and TimeUtil:GetTime() .. "" or "xxx"
    return string.format("%s_%s_%s", PlayerClient:GetID(), _roomID, _themeID)
end

-----------------------------------------家具-------------------------------------
-- 清理当前房间数据
function this:ClearDatas()
    self.curOpenData = nil
    self.oldOpenData = nil
    self.copyFurnitureDatas = nil
    self.dormGround = nil
end

-- 家具所能放置的层级
function this:GetDormLayer(cfg)
    if (cfg.sType == DormFurnitureType.wall or cfg.sType == DormFurnitureType.hangings) then
        return DormLayer.wall -- 墙
    else
        return DormLayer.ground -- 地面
    end
end

-- 获取房间数据列表
function this:GetDormDatas(fid)
    if(fid~=nil) then 
        return self.friendRoomDatas[fid] 
    end 
    return self.roomDatas
end

-- 获取房间数据{id, fid}
function this:GetRoomData(id, fid)
    --local curOpenData = self:GetCurOpenData()
    local datas = self:GetDormDatas(fid)
    return datas[id]
end

-- 获取当前房间数据
function this:GetCurRoomData()
    local curOpenData = self:GetCurOpenData()
    local datas = self:GetDormDatas(curOpenData[2])
    return datas[curOpenData[1]]
end

-- 宿舍大小
function this:GetDormScale()
    local curRoomData = self:GetCurRoomData()
    local scale = curRoomData:GetScale()
    return {
        x = scale[1],
        z = scale[2]
    }
end

-- -- 根据房间大小决定视野范围
-- function this:GetDormRadiusOffset()
--     -- local curRoomData = self:GetCurRoomData()
--     -- local lv = curRoomData:GetLv() or 1
--     -- return 3 *(lv - 1)
--     return 3
-- end

-- ==============================--
-- desc:当前房间家具（复制的数据_data=nil、系统主题、保存的主题、排行榜的主题{0，xx}）  
-- time:2022-03-18 03:23:13
-- @_data:
-- @return 
-- ==============================--
function this:GetCopyFurnitureDatas(_data)
    local dic = nil -- 未封装的数据
    if (_data) then
        if (_data[1] == ThemeType.Sys) then
            -- 系统的主题
            dic = self:GetFurnitureDatasBySysID(_data[2].id)
        else
            -- 保存的主题、排行榜的主题
            local themeData = _data[2]
            dic = self:GetFurnitureDatasByThemeFurnitures(themeData.furnitures) -- table.copy(themeData.furnitures)
        end
    else
        -- 复制当前房间数据
        local curRoomData = self:GetCurRoomData()
        dic = table.copy(curRoomData:GetFurnitures())
    end

    self.copyFurnitureDatas = self:SetCopyFurnitureDatas(dic)
    return self.copyFurnitureDatas
end

function this:GetCurRoomCopyDatas()
    return self.copyFurnitureDatas
end

-- 当前复制数据的舒适度
function this:GetCopyDatasComfort()
    local comfort = 0
    local datas = self:GetCurRoomCopyDatas()
    if (datas) then
        for k, v in pairs(datas) do
            comfort = comfort + v:GetCfg().comfort
        end
    end
    return comfort
end

-- 获取一份复制的家具数据（已封装）
function this:SetCopyFurnitureDatas(dic)
    local datas = {}
    for i, v in pairs(dic) do
        local _data = DormFurnitureData.New()
        _data:InitData(v)
        datas[v.id] = _data
    end
    return datas
end

-- 当前房间家具数量
function this:GetCurRoomCopyNum()
    local curCount, maxCount = 0, 0
    --
    local furnitureDatas = DormMgr:GetCurRoomCopyDatas()
    for k, v in pairs(furnitureDatas) do
        curCount = curCount + 1
    end
    --
    local cfg = Cfgs.CfgDormRoom:GetByID(1)
    maxCount = cfg.limit
    return curCount, maxCount
end

-- 根据系统主题id封装家具数据(根据当前能使用的数量来进行封装)（将数量不够，和不存在父类的剔除）
function this:GetFurnitureDatasBySysID(themeID)
    local needCounts = self:GetCfgFurnitureCount(themeID)
    local canUseCounts = self:GetCanUseFurnitureCount(needCounts) -- 当前能使用的数量
    local themeCfg = Cfgs.CfgFurnitureTheme:GetByID(themeID)
    local themeLayoutCfg = Cfgs.CfgThemeLayout:GetByID(themeCfg.layoutId)
    local idDics = {}
    local dic = {}
    for i, v in ipairs(themeLayoutCfg.infos) do
        -- 数量是否充足
        if (canUseCounts[v.cfgID] and canUseCounts[v.cfgID] > 0) then
            canUseCounts[v.cfgID] = canUseCounts[v.cfgID] - 1
            local incId = 1
            if (idDics[v.cfgID]) then
                incId = idDics[v.cfgID] + 1
                idDics[v.cfgID] = incId
            else
                idDics[v.cfgID] = 1
            end
            local data = table.copy(v)
            data.index = nil
            data.cfgID = nil
            data.id = GCalHelp:GetDormFurId(v.cfgID, incId)
            data.point = {
                x = v.point[1],
                y = v.point[2],
                z = v.point[3]
            } -- 重构
            dic[v.index] = data
        end
    end
    -- 父index、子index 设置未正确的id 
    local delectList = {}
    for i, v in pairs(dic) do
        if (v.parentID) then
            if (not dic[v.parentID]) then
                table.insert(delectList, i)
            else
                v.parentID = dic[v.parentID].id
            end
        end
        if (v.childID) then
            local ids = {}
            for k, m in ipairs(v.childID) do
                if (dic[m]) then
                    table.insert(ids, dic[m].id)
                end
            end
            v.childID = ids
        end
    end
    for k, v in pairs(delectList) do
        dic[v] = nil
    end
    return dic
end

-- 根据主题的家具信息（已封装）来计算可布置的家具（将数量不够，和不存在父类的剔除）
function this:GetFurnitureDatasByThemeFurnitures(furnitures)
    local needCounts = self:GetThemeDatasCount(furnitures)
    local canUseCounts = self:GetCanUseFurnitureCount(needCounts) -- 当前能使用的数量
    local newFurnitures = {}
    for k, v in pairs(furnitures) do
        local cfgID = GCalHelp:GetDormFurCfgId(v.id)
        if (canUseCounts[cfgID] and canUseCounts[cfgID] > 0) then
            canUseCounts[cfgID] = canUseCounts[cfgID] - 1
            newFurnitures[k] = v
        end
    end
    local delectList = {}
    for k, v in pairs(newFurnitures) do
        if (v.parentID and not newFurnitures[v.parentID]) then
            table.insert(delectList, k)
        end
    end
    for k, v in pairs(delectList) do
        newFurnitures[k] = nil
    end
    return newFurnitures
end

-- -- 根据房间大小判断某个主题的家具数据是否需要调整位置
-- -- 墙壁家具调整到正确的位置
-- -- 无法向下兼容（墙物体向内移动，可能会与地面家具碰撞,这里不会出现这种判断，已在DormLayoutThemeInfo拦截）
-- function this:CheckThemeDataNeedChange(themeData)
--     local curRoomData = self:GetCurRoomData()
--     local lv = curRoomData:GetLv()
--     local themeLv = themeData.lv
--     if (themeLv == lv) then
--         -- 没有需要忽略的
--         return false
--     else
--         return true
--     end
-- end

-- 根据房间大小调整家具数据（墙壁家具位置调整）
function this:SetCorectDicByRoomScale(dic)
    local scale = self:GetDormScale()
    for i, v in pairs(dic) do
        local cfgID = GCalHelp:GetDormFurCfgId(v.id)
        local cfg = Cfgs.CfgFurniture:GetByID(cfgID)
        -- 装饰
        if (cfg.sType == DormFurnitureType.hangings) then
            if (v.planeType == 2) then
                dic[i].point.x = scale.x * 0.5
            elseif (v.planeType == 3) then
                dic[i].point.z = -scale.z * 0.5
            end
        end
    end
    return dic
end

--------------------------------------某主题否满足条件放置到当前房间------------------------------------------

-- -- 判断某主题id的家具是否足够
-- -- 当前房间已放置的要考虑进来
-- function this:CheckEnoughByThemeID(themeType, id)
--     if (themeType == ThemeType.Sys) then
--         return self:CheckEnoughForSys(id)
--     else
--         local themeData = self:GetThemesByID(themeType, id)
--         return themeData and self:CheckEnoughForOther(themeData) or false
--     end
-- end

-- -- 获取某个系统主题家具列表
-- function this:GetSysThemeLayoutCfg(id)
--     local themeCfg = Cfgs.CfgFurnitureTheme:GetByID(id)
--     local layoutId = themeCfg.layoutId
--     return Cfgs.CfgThemeLayout:GetByID(layoutId)
-- end

-- 系统主题（根据当前房间大小选取对应的表数据）
function this:CheckEnoughForSys(themeID)
    local themeCfg = Cfgs.CfgFurnitureTheme:GetByID(themeID)
    local themeLayoutCfg = Cfgs.CfgThemeLayout:GetByID(themeCfg.layoutId)
    local needDatas = {}
    for i, v in ipairs(themeLayoutCfg.infos) do
        if (needDatas[v.cfgID]) then
            needDatas[v.cfgID] = needDatas[v.cfgID] + 1
        else
            needDatas[v.cfgID] = 1
        end
    end
    return self:CheckEngough(needDatas)
end

-- 非系统主题(不判断房间大小，不考试放不下的家具，在使用该方法前判断)
function this:CheckEnoughForOther(themeData)
    -- 所需列表
    local needDatas = self:GetThemeDatasCount(themeData.furnitures)
    return self:CheckEngough(needDatas)
end

function this:CheckEngough(needDatas)
    -- 当前房间所含
    local curCounts = self:GetCurFurnitrueCount()
    -- 比较
    for i, v in pairs(needDatas) do
        local cfg = Cfgs.CfgFurniture:GetByID(i)
        local itemID = cfg.itemId
        local bagCount = BagMgr:GetCount(itemID)
        local curCount = curCounts[i] or 0
        if (v > (curCount + bagCount)) then
            return false
        end
    end
    return true
end

-- 当前房间(服务器)数据的家具数量 
function this:GetCurFurnitrueCount()
    -- 当前已放置的数量
    local curCounts = {}
    local curRoomData = self:GetCurRoomData()
    local curFurnitureDatas = curRoomData:GetFurnitures()
    for i, v in pairs(curFurnitureDatas) do
        local cfgID = GCalHelp:GetDormFurCfgId(v.id)
        if (curCounts[cfgID]) then
            curCounts[cfgID] = curCounts[cfgID] + 1
        else
            curCounts[cfgID] = 1
        end
    end
    return curCounts
end

-- 某主题的家具数量
function this:GetThemeDatasCount(furnitures)
    local curCounts = {}
    for i, v in pairs(furnitures) do
        local cfgID = GCalHelp:GetDormFurCfgId(v.id)
        if (curCounts[cfgID]) then
            curCounts[cfgID] = curCounts[cfgID] + 1
        else
            curCounts[cfgID] = 1
        end
    end
    return curCounts
end

-- 系统主题的家具数量
function this:GetCfgFurnitureCount(themeID)
    local curCounts = {}
    local cfg = Cfgs.CfgFurnitureTheme:GetByID(themeID)
    local themeCfg = Cfgs.CfgThemeLayout:GetByID(cfg.layoutId)
    for i, v in ipairs(themeCfg.infos) do
        if (curCounts[v.cfgID]) then
            curCounts[v.cfgID] = curCounts[v.cfgID] + 1
        else
            curCounts[v.cfgID] = 1
        end
    end
    return curCounts
end

-- 使用该主题，其当前可使用的家具数量（算入当前房间已布置的）
function this:GetCanUseFurnitureCount(needCounts)
    local useCounts = self:GetCurFurnitrueCount() -- 当前房间使用的数量
    for k, v in pairs(needCounts) do
        local cfg = Cfgs.CfgFurniture:GetByID(k)
        local use = useCounts[k] or 0
        local remainCount = BagMgr:GetCount(cfg.itemId) + use -- 共可用数量
        if (v > remainCount) then
            needCounts[k] = remainCount
        end
    end
    return needCounts
end

-- =可用数量：最大数量: 当前房间使用的数量
function this:GetFurnitureCount(cfgID)
    local curUseCounts = self:GetCurFurnitrueCount() -- 服务器记录的
    local useCounts = self:GetCopyFurnitureCount() -- 当前房间使用的数量  
    local curUse = curUseCounts[cfgID] or 0
    local use = useCounts[cfgID] or 0

    local cfg = Cfgs.CfgFurniture:GetByID(cfgID)
    local cur = BagMgr:GetCount(cfg.itemId) + curUse - use
    local max = self:GetBuyCount(cfgID)
    return cur, max, use
end

-----------------------------------------当前房间数据（实时的，复制的）-------------------------------------------------------
-- 系统主题的家具数量
function this:GetCopyFurnitureCount()
    local curCounts = {}
    for i, v in pairs(self.copyFurnitureDatas) do
        local cfgID = GCalHelp:GetDormFurCfgId(v:GetID())
        if (curCounts[cfgID]) then
            curCounts[cfgID] = curCounts[cfgID] + 1
        else
            curCounts[cfgID] = 1
        end
    end
    return curCounts
end

-- 计算当前房间实时舒适度
function this:GetChangeComfort()
    local comfort = 0
    for i, v in pairs(self.copyFurnitureDatas) do
        local cfgID = GCalHelp:GetDormFurCfgId(v:GetID())
        local cfg = Cfgs.CfgFurniture:GetByID(cfgID)
        comfort = comfort + cfg.comfort
    end
    return comfort
end

-- 当前房间家具数据
function this:GetChangeFurnitureDatas()
    local newDatas = {}
    for i, v in pairs(self.copyFurnitureDatas) do
        newDatas[v:GetID()] = v:GetData()
    end
    return newDatas
end

-- 当前房间某家具表id的数量
function this:GetChangeFurnitureCounts()
    local counts = {}
    for i, v in pairs(self.copyFurnitureDatas) do
        local cfgID = GCalHelp:GetDormFurCfgId(v:GetID())
        if (counts[cfgID]) then
            counts[cfgID] = counts[cfgID] + 1
        else
            counts[cfgID] = 1
        end
    end
    return counts
end

-- 当前房间可用类型数量 [类型，max最大可放置数量，cur已放置数量]
function this:GetLimit()
    local limitDatas = {} -- 当前房间可用类型数量
    -- cur
    local typeDatas = self:GetCurTypeCount()
    -- max
    local curRoomData = self:GetCurRoomData()
    local _limit = curRoomData:GetLvCfg().limit
    local maxLimit = {} -- 当前房间使用限制
    for i, v in pairs(_limit) do
        maxLimit[v[1]] = v[2]
    end
    for i, v in pairs(DormFurnitureType) do
        limitDatas[v] = {}
        -- 最大数量
        limitDatas[v].max = maxLimit[v] or 0
        -- 当前数量
        limitDatas[v].cur = typeDatas[v] or 0
    end
    return limitDatas
end

-- 当前复制数据的类型数量
function this:GetCurTypeCount()
    local typeDatas = {}
    for i, v in pairs(self.copyFurnitureDatas) do
        local type = v:GetCfg().sType
        if (typeDatas[type]) then
            typeDatas[type] = typeDatas[type] + 1
        else
            typeDatas[type] = 1
        end
    end
    return typeDatas
end

-- 获取某个类型全部家具
function this:GetCopyFurnitureDatasByType(_type)
    local typeDatas = {}
    for i, v in pairs(self.copyFurnitureDatas) do
        local sType = v:GetCfg().sType
        if (sType == _type) then
            table.insert(typeDatas, v)
        end
    end
    return typeDatas
end

-- ==============================--
-- desc:获取某房间的唯一家具id，根据类型获取，去掉当前已用的
-- time:2022-04-09 03:56:39
-- @_cfgID:
-- @return
-- ==============================--
function this:GetNewID(_cfgID)
    local newIndex = 1
    local cfg = Cfgs.CfgFurniture:GetByID(_cfgID)
    local typeDatas = self:GetCopyFurnitureDatasByType(cfg.sType)
    local maxIndex = 1
    local idDic = {}
    for i, v in ipairs(typeDatas) do
        local cfgID, index = GCalHelp:GetDormFurCfgId(v:GetID())
        idDic[index] = 1
        if (maxIndex < index) then
            maxIndex = index
        end
    end
    local len = maxIndex + 1
    for i = 1, len do
        if (not idDic[i]) then
            newIndex = i
            break
        end
    end
    return GCalHelp:GetDormFurId(_cfgID, newIndex)
end

-- 创建一个家具数据 {_cfgID, _point, _planeType, _rotateY}
function this:CrateFurnitureFakeData(_info)
    local _data = {}
    _data.id = self:GetNewID(_info[1])
    _data.point = _info[2]
    _data.planeType = _info[3]
    _data.rotateY = _info[4] or 0
    local newData = DormFurnitureData.New()
    newData:InitData(_data)
    return newData
end

-- 当前房间数据  {id, fid}
function this:SetCurOpenData(_data)
    local isChange = true
    if (self.curOpenData) then
        if (self.curOpenData[1] == _data[1] and self.curOpenData[2] == _data[2]) then
            isChange = false -- 有一个不对都证明房间不同
        end
    end
    self.curOpenData = _data

    if (self.curOpenData[2] == nil) then
        self.oldOpenData = {self.curOpenData[1]} -- 记录自己打开的房间,方便从好友房间返回自己的房间
    end

    return isChange
end
function this:GetCurOpenData()
    return self.curOpenData
end
function this:GetOldOpenData()
    return self.oldOpenData
end

-- 初始化好友房间数据（仅保存当前查看的好友数据）
function this:InitFriendDatas(fid)
    -- if (not self.friendRoomDatas[fid]) then
    --     self.friendRoomDatas[fid] = {}
    -- end
    self.friendRoomDatas[fid] = self.friendRoomDatas[fid] or {}
    return self.friendRoomDatas[fid]
end

-- 更新房间简单数据
function this:UpdateDatasA(rootDatas, infos, fid)
    for i, v in ipairs(infos) do
        if (rootDatas[v.id]) then
            rootDatas[v.id]:UpdateDataA(v)
        else
            local _data = DormRoomData.New()
            _data:SetFid(fid)
            _data:UpdateDataA(v)
            rootDatas[v.id] = _data
        end
    end
    -- LogError(rootDatas)
end

-- 更新详细房间数据
function this:UpdateDataB(rootDatas, v, fid)
    if (rootDatas[v.id]) then
        rootDatas[v.id]:InitData(v)
    else
        local _data = DormRoomData.New()
        _data:SetFid(fid)
        _data:InitData(v)
        rootDatas[v.id] = _data
    end
end

-- 更新自己的房间（更新已有字段）
function this:UpdateData(info)
    if (self.roomDatas[info.id]) then
        local data = self.roomDatas[info.id]:GetData()
        for i, v in pairs(info) do
            if (i == "data") then
                for k, m in pairs(v) do
                    data["data"][k] = m
                end
            else
                data[i] = v
            end
        end
    else
        -- 添加房间
        local _data = DormRoomData.New()
        _data:InitData(info)
        self.roomDatas[info.id] = _data
    end
end
------------------------------------------------组件
--
function this:GetDormGround()
    if (not self.dormGround) then
        local go = GameObject.Find("DormGround")
        self.dormGround = ComUtil.GetLuaTable(go)
    end
    return self.dormGround
end

-- 场景相机
function this:GetSceneCamera()
    local dormGround = self:GetDormGround()
    local camera = ComUtil.GetCom(dormGround.cameraGo, "Camera")
    return camera
end

-- 是否激活场景相机的操作
function this:SetSceneCameraAction(b)
    local dormGround = self:GetDormGround()
    local dormCameraMgr = ComUtil.GetCom(dormGround.gameObject, "DormCameraMgr")
    if (dormCameraMgr) then
        dormCameraMgr:SetIsOn(b)
    end
end

------------------------------------------------主题/家具购买-----------------------------------------------------------
-- 保存主题
function this:SaveThemeData(sType, info)
    local themeDatas = self:GetThemesDic(sType)
    if (not themeDatas[info.id]) then
        themeDatas[info.id] = info
    end
end

-- 移除主题
function this:RemoveThemeData(sType, themeID)
    local themeDatas = self:GetThemesDic(sType)
    themeDatas[themeID] = nil
end

function this:GetThemesDic(sType)
    self.themeDatas = self.themeDatas or {}
    return self.themeDatas[sType]
end

-- 获取某类型主题有序列表  
-- ThemeType = {}
-- ThemeType.Sys = 1 -- 系统
-- ThemeType.Save = 2 -- 保存
-- ThemeType.Store = 3 -- 收藏
-- ThemeType.Share = 4 -- 分享
function this:GetThemes(sType)
    self.themeDatas = self.themeDatas or {}
    if (self.themeDatas[sType] == nil) then
        return nil -- 未请求过
    else
        local arr = {}
        local datasDic = self.themeDatas[sType]
        for i, v in pairs(datasDic) do
            table.insert(arr, v)
        end
        if (#arr > 1) then
            table.sort(arr, function(a, b)
                return a.id < b.id
            end)
        end
        return arr
    end
end

-- 根据类型和id获取某个主题
function this:GetThemesByID(sType, id)
    local themeDatas = self:GetThemesDic(sType)
    if (themeDatas == nil) then
        -- LogError(string.format("获取主题失败,类型:%s,id:", sType, id))
        return nil
    else
        return themeDatas[id] or nil
    end
end

-- -- 一键购买主题时的总消耗,显示用（只考虑家具币）(已购买的也统计)
-- function this:GetCost(id)
--     local cfg = Cfgs.CfgFurnitureTheme:GetByID(id)
--     local themeCfg = Cfgs.CfgThemeLayout:GetByID(cfg.layoutId)
--     local costs = {}
--     for i, v in ipairs(themeCfg.infos) do
--         costs[v.cfgID] = costs[v.cfgID] and (costs[v.cfgID] + 1) or 1
--     end
--     local cost = {}
--     for i, v in pairs(costs) do
--         local fCfg = Cfgs.CfgFurniture:GetByID(i)
--         if (fCfg.price and fCfg.priceIndex == 3) then
--             local price = fCfg.price[1]
--             cost.id = cost.id and cost.id or price[1]
--             local num = price[2] * v
--             cost.num = cost.num and cost.num + num or num
--         end
--     end
--     return cost
-- end

-- 购买记录的类型统计
function this:GetButRecordTypes()
    local recordTypeCounts = {}
    local buyRecords = self.GetBuyRecords()
    for i, v in pairs(buyRecords) do
        local cfg = Cfgs.CfgFurniture:GetByID(k)
        if (recordTypeCounts[cfg.sType]) then
            recordTypeCounts[cfg.sType] = recordTypeCounts[cfg.sType] + v.num
        else
            recordTypeCounts[cfg.sType] = v.num
        end
    end
    return recordTypeCounts
end

-- 购买记录
function this:GetBuyRecords()
    self.BuyRecords = self.BuyRecords or {}
    return self.BuyRecords
end

-- 已购买家具的数量
function this:GetBuyCounts()
    local count = 0
    local dic = self:GetBuyRecords()
    for k, v in pairs(dic) do
        count = count + v
    end
    return count
end

-- 刷新购买次数
function this:UpdateBuyRecoreds(dic)
    local BuyRecords = self:GetBuyRecords()
    for i, v in pairs(dic) do
        if (BuyRecords[v.id]) then
            BuyRecords[v.id] = BuyRecords[v.id] + v.num
        else
            BuyRecords[v.id] = v.num
        end
    end
end

-- 购买次数 id：家具id
function this:GetBuyCount(id)
    local BuyRecords = self:GetBuyRecords()
    return BuyRecords[id] ~= nil and BuyRecords[id] or 0
end

------------------------------------------------协议-----------------------------------------------------------
function this:GetOpenDormRet(proto)
    local rootDatas = {}
    local fid = proto.fid
    if (fid) then
        -- 好友数据
        rootDatas = self:InitFriendDatas(fid)
        --rootDatas = self.friendRoomDatas[fid]
    else
        -- 自己的数据
        rootDatas = self.roomDatas
    end
    self:UpdateDatasA(rootDatas, proto.infos, fid)
end

function this:GetDormRet(proto)
    local rootDatas = {}
    local fid = proto.fid
    if (fid ~= nil) then
        rootDatas = self:InitFriendDatas(fid)
        --rootDatas = self.friendRoomDatas
    else
        rootDatas = self.roomDatas
    end
    self:UpdateDataB(rootDatas, proto.info, fid)
end

-- 获取主题返回
function this:GetSelfThemeRet(proto)
    self.themeDatas = self.themeDatas or {}
    if (self.themeDatas[proto.themeType]) then
        for k, v in pairs(proto.themes) do
            self.themeDatas[proto.themeType][k] = v
        end
    else
        self.themeDatas[proto.themeType] = proto.themes or {}
    end
end
-- 清除主题数据（请求主题前要调用）
function this:RemoveTheme(themeTypes)
    if (not self.themeDatas) then
        return
    end
    for k, v in pairs(themeTypes) do
        self.themeDatas[v] = {}
    end
end

-- 分享回调
function this:ShareThemeRet(proto, isRemove)
    self.themeDatas = self.themeDatas or {}
    self.themeDatas[ThemeType.Share] = self.themeDatas[ThemeType.Share] or {}
    if (isRemove) then
        local _data = self.themeDatas[ThemeType.Share][proto.themeId]
        local _store = proto.store or 0
        if (_data and _store < 1) then
            self:RemoveImg(self.themeDatas[ThemeType.Share][proto.themeId].img) -- 收藏已为0
        end
        self.themeDatas[ThemeType.Share][proto.themeId] = nil
    else
        self.themeDatas[ThemeType.Share][proto.info.id] = {}
        self.themeDatas[ThemeType.Share][proto.info.id] = proto.info
    end
    EventMgr.Dispatch(EventType.Dorm_Share, isRemove)
    if (not isRemove) then
        LanguageMgr:ShowTips(21017)
    end
end

-- 删除分享上传的图片
function this:RemoveImg(imgName)
    if (not StringUtil:IsEmpty(imgName)) then
        CSAPI.PostUpload(ActivityMgr:GetDormUploadAddress(), imgName)
    end
end

function this:BuyRecordRet(proto)
    self.BuyRecords = proto.infos or {}
end

function this:BuyThemeRet(proto)
    -- 刷新系统主题列表
    if (proto.isFullBuy) then
        self.themeDatas = self.themeDatas or {}
        self.themeDatas[ThemeType.Sys] = self.themeDatas[ThemeType.Sys] or {}
        self.themeDatas[ThemeType.Sys][proto.themeId] = {
            id = proto.themeId
        }
    end
    -- local sysDatas = self.themeDatas[ThemeType.Sys] or {}
    -- sysDatas[proto.themeId] = {
    --     id = proto.themeId
    -- } -- 封装一个主题数据
    -- 刷新购买记录
    local dic = {}
    if (proto.ids) then
        for i, v in ipairs(proto.ids) do
            if (dic[v]) then
                dic[v].num = dic[v].num + 1
            else
                dic[v] = {}
                dic[v].id = v
                dic[v].num = 1
            end
        end
    end
    self:UpdateBuyRecoreds(dic)
end

-- 购买返回
function this:BuyFurnitureRet(proto)
    self:UpdateBuyRecoreds(proto.infos)
end

----------------------------------////排序相关
-- 家具界面筛选排序数据
function this:SetFurnitueSortTab(_datas, _sortType)
    self.SortFurnitrueDatas = self.SortFurnitrueDatas or {}
    self.SortFurnitrueDatas[_sortType] = _datas
end

function this:GetFurnitureSortTab(_sortType)
    self.SortFurnitrueDatas = self.SortFurnitrueDatas or {}
    if (not self.SortFurnitrueDatas[_sortType]) then
        self.SortFurnitrueDatas[_sortType] = {}
        self.SortFurnitrueDatas[_sortType].Sort = {1}
        self.SortFurnitrueDatas[_sortType].Theme = {0} -- todo        
    end
    return self.SortFurnitrueDatas[_sortType]
end

-- 家具界面升降序数据
function this:SetFurnitureSortUD(_data, _sortType)
    self.SortFurnitureUD = self.SortFurnitureUD or {}
    self.SortFurnitureUD[_sortType] = _data
end
function this:GetFurnitureSortUD(_sortType)
    self.SortFurnitureUD = self.SortFurnitureUD or {}
    if (not self.SortFurnitureUD[_sortType]) then
        self.SortFurnitureUD[_sortType] = 2
    end
    return self.SortFurnitureUD[_sortType]
end

-- 驻员入驻界面筛选排序数据
function this:SetSetRoleSortTab(_datas)
    self.SortSetRoleDatas = _datas
end
function this:GetSetRoleSortTab()
    if (not self.SortSetRoleDatas) then
        self.SortSetRoleDatas = {}
        self.SortSetRoleDatas.Sort = {1}
        self.SortSetRoleDatas.RoleTeam = {0}
        -- self.SortSetRoleDatas.Pos = {0}
    end
    return self.SortSetRoleDatas
end

-- 驻员入驻界面升降序数据
function this:SetSetRoleSortUD(_data)
    self.SortSetRoleUD = _data
end
function this:GetSetRoleSortUD()
    if (not self.SortSetRoleUD) then
        self.SortSetRoleUD = 2
    end
    return self.SortSetRoleUD
end

-- 宿舍人数
function this:GetRoleCnt()
    local cur, max = 0, 0
    local cfgs = Cfgs.CfgDorm:GetAll()
    local openDatas = DormMgr:GetDormDatas()
    for i, v in ipairs(cfgs) do
        for k, m in ipairs(v.infos) do
            local id = GCalHelp:GetDormId(v.id, m.index)
            local openData = openDatas[id]
            if (openData) then
                cur = cur + openData:GetNum()
                local lvCfg = Cfgs.CfgDormRoom:GetByID(openData:GetLv())
                max = max + lvCfg.maxRole
            end
        end
    end
    return cur, max
end

-- 宿舍进入前的场景
function this:SetOpenSceen(sceenKey)
    self.sceenKey = sceenKey
end
-- 退出宿舍
function this:Quit()
    self.friendRoomDatas = {}--清空好友的数据防止数据过多
    if (self.sceenKey) then
        SceneLoader:Load(self.sceenKey)
        self.sceenKey = nil
    else
        EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"MatrixScene"})
    end
end

-----------------------------------外部调用------------------------------------------------------
-- 宿舍是否已开启
function this:DormIsOpen()
    local b, str = MenuMgr:CheckModelOpen(OpenViewType.main, "Dorm")
    if (not b) then
        return b, str
    end
    return true, ""
end

-- 在好友界面进入好友宿舍 fid:好友id
function this:OpenFidDorm(fid)
    if (not self:DormIsOpen()) then
        return
    end
    -- 先请求好友宿舍数据
    DormProto:GetOpenDorm(fid, function()
        self:OpenFidDorm2(fid)
    end)
end
-- 请求详细数据
function this:OpenFidDorm2(fid)
    local roomID = GCalHelp:GetDormId(1, 1) -- 默认打开101房
    DormProto:GetDorm(fid, roomID, function()
        MatrixMgr:SetMatrixViewData({true}) -- 标记为打开宿舍，MatrixView打开后调用
        self:SetCurOpenData({roomID, fid})
        self:SetOpenSceen("MajorCity")
        local scene = SceneMgr:GetCurrScene()
        SceneLoader:Load("Matrix")
    end)
end

-- 主题当前购买价格，使用前要确定未购买该主题
-- return: 家具币价格,钻石价格
function this:GetThemePrices(themeId)
    local counts = self:GetCfgFurnitureCount(themeId)
    local curDatas = {}
    for k, v in pairs(counts) do
        local buyCount = self:GetBuyCount(k)
        table.insert(curDatas, {k, v, buyCount}) -- {id,需要的数量，已购买的数量}
    end
    local price1, price2 = 0, 0
    for k, v in pairs(curDatas) do
        local num = v[2] > v[3] and (v[2] - v[3]) or 0
        if (num > 0) then
            local _cfg = Cfgs.CfgFurniture:GetByID(v[1])
            if (not _cfg.special) then
                price1 = price1 + _cfg.price_1[1][2] * num
                price2 = price2 + _cfg.price_2[1][2] * num
            end
        end
    end
    return price1, price2
end

-- 主题： 已购买件数(主题上限)，总件数
function this:GetThemeCount(id)
    local cfg = Cfgs.CfgThemeLayout:GetByID(id)
    local max = #cfg.infos
    local dic = {}
    for k, v in pairs(cfg.infos) do
        if (dic[v.cfgID]) then
            dic[v.cfgID] = dic[v.cfgID] + 1
        else
            dic[v.cfgID] = 1
        end
    end
    local cur = 0
    for k, v in pairs(dic) do
        local num = self:GetBuyCount(k)
        if (num > v) then
            cur = cur + v
        else
            cur = cur + num
        end
    end
    return cur, max
end

-- 购买过家具的主题数量
function this:GetThemeBuyCount()
    local cur = 0
    local cfgs = Cfgs.CfgFurnitureTheme:GetAll()
    for k, v in pairs(cfgs) do
        if (not v.hide) then
            local cfg = Cfgs.CfgThemeLayout:GetByID(v.id)
            for m, n in pairs(cfg.infos) do
                local num = self:GetBuyCount(n.cfgID)
                if (num > 0) then
                    cur = cur + 1
                    break
                end
            end
        end
    end
    return cur
end

-- 被隐藏的主题
function this:ThemeHideDic(isContain4001)
    isContain4001 = isContain4001 == nil and true or isContain4001
    local dic = {}
    local cfgs = Cfgs.CfgFurnitureTheme:GetAll()
    for k, v in pairs(cfgs) do
        if (not DormMgr:CheckIsOpen(v) or (v.hide and (v.id ~= 4001 or isContain4001))) then
            dic[v.id] = 1
        end
    end
    return dic
end

-- 移除宿舍模型
function this:ClearDormModels()
    local modelNames = {"DormGround", "DormMain"}
    for k, v in pairs(modelNames) do
        local go = GameObject.Find(v)
        if (go) then
            local lua = ComUtil.GetLuaTable(go)
            lua.Exit()
            CSAPI.RemoveGO(go)
        end
    end
end

-- 可用的空位置数量（放置驻员）
function this:GetEmptyNum()
    -- local raysHitCount = 0
    -- local gridSize = 16
    -- local rayHeight = 2
    -- local gridSizeHalf = gridSize / 2
    -- for x = 0, gridSize do
    --     for z = 0, gridSize do
    --         local rayOrigin = UnityEngine.Vector3(x - gridSizeHalf + 0.5, 0, z - gridSizeHalf + 0.5)
    --         if (UnityEngine.Physics.Raycast(rayOrigin, UnityEngine.Vector3.up, rayHeight,1<<DormLayer.furniture)) then
    --             raysHitCount = raysHitCount + 1
    --         end
    --     end
    -- end
    -- return 256 - raysHitCount
    return 256 - self:GetFurnitureGridNum()
end

-- 当前所有家具占地格子数量
function this:GetFurnitureGridNum()
    local num = 0
    local furnitureDatas = self:GetCurRoomCopyDatas() or self:GetCopyFurnitureDatas2()
    if (furnitureDatas) then
        for i, v in pairs(furnitureDatas) do
            num = num + v:GetGridNum()
        end
    end
    return num
end

-- 某保存主体的占地数量
function this:GetSaveThemeGridNun(id)
    local num = 0
    local themeData = DormMgr:GetThemesByID(ThemeType.Save, id)
    local furnitureDatas = themeData.furnitures or {}
    for k, v in pairs(furnitureDatas) do
        if (v.parentID == nil) then
            local cfgID = GCalHelp:GetDormFurCfgId(v.id)
            local cfg = Cfgs.CfgFurniture:GetByID(cfgID)
            if (cfg.sType ~= 0 and cfg.sType ~= 1 and cfg.sType ~= 7 and cfg.sType ~= 8) then
                num = num + math.ceil(cfg.scale[1] * cfg.scale[3])
            end
        end
    end
    return num
end

-- 临时复制一份当前真实数据
function this:GetCopyFurnitureDatas2(_roomID)
    local roomID = _roomID or GCalHelp:GetDormId(1, 1)
    local roomDatas = self:GetDormDatas()
    local roomData = roomDatas[roomID]
    local dic = table.copy(roomData:GetFurnitures())
    local datas = {}
    for i, v in pairs(dic) do
        local _data = DormFurnitureData.New()
        _data:InitData(v)
        datas[v.id] = _data
    end
    return datas
end

-- 是否在开放时间段内
function this:CheckIsOpen(cfg)
    local curTime = TimeUtil:GetTime()
    if (cfg.sStart and curTime < TimeUtil:GetTimeStampBySplit(cfg.sStart)) then
        return false
    end
    if (cfg.sEnd and curTime >= TimeUtil:GetTimeStampBySplit(cfg.sEnd)) then
        return false
    end
    return true
end

-- 新房间2-1红点
function this:CheckNewRoomRedNum()
    if (not self.newroomisred) then
        local key = PlayerClient:GetID() .. "_newroomisred"
        local num = PlayerPrefs.GetInt(key) or 0
        self.newroomisred = num == 0
    end
    return self.newroomisred
end
function this:SetNewRoomRedNum()
    local key = PlayerClient:GetID() .. "_newroomisred"
    PlayerPrefs.SetInt(key, 1)
    self.newroomisred = false
end

return this
