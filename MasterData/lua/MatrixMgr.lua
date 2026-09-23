-- 基地管理器
require "MatrixData"
require "MatrixCommon"
require "MatrixAssualtTool"
require "MatrixPL"

local isGetAssualt = false
local this = MgrRegister("MatrixMgr")

-- 进入游戏时将被调用 初始化
function this:Init()
    self:Clear()
    self:InitGroundDatas()
    BuildingProto:BuildsBaseInfo()
    BuildingProto:BuildsList()
    -- 获取突袭信息（在线期间仅请求一次突袭数据）
    if (not isGetAssualt) then
        isGetAssualt = true
        BuildingProto:AssualtInfo()
    end

    -- 是否有建筑可建造
    EventMgr.AddListener(EventType.Update_Coin, this.OnBagUpdate) -- 背包货币更新
    EventMgr.AddListener(EventType.Update_PlayerAbility, this.OnBagUpdate) -- 玩家能力变更
    EventMgr.AddListener(EventType.Matrix_Building_Update, this.OnBuildingUpdate) -- 建筑更新
    EventMgr.AddListener(EventType.Player_Update, this.OnBagUpdate) -- 玩家升级 
end

function this:Clear()
    self.gridDatas = {}
    self.buildingDatas = {}
    self.matrixInfo = {}
    isGetAssualt = false
    self.matrixGround = nil

    EventMgr.RemoveListener(EventType.Update_Coin, this.OnBagUpdate)
    EventMgr.RemoveListener(EventType.Update_PlayerAbility, this.OnBagUpdate)
    EventMgr.RemoveListener(EventType.Matrix_Building_Update, this.OnBuildingUpdate)
    EventMgr.RemoveListener(EventType.Player_Update, this.OnBagUpdate)
end

-- (延迟调用，优化物品大量刷新的情况)
function this.OnBagUpdate()
    local data = MatrixMgr:GetMainBuilding()
    if (not data) then
        return
    end
    if (this.applyRefresh) then
        return
    end
    this.applyRefresh = 1
    FuncUtil:Call(this.OnBagUpdate2, nil, 100)
end
function this.OnBagUpdate2()
    this.applyRefresh = nil
    local num = nil
    local buildData = MatrixMgr:GetBuildingDataByType(BuildsType.Remould)
    if (buildData) then
        local cur = buildData:GetCurMax()
        if (cur > 0) then
            num = 1
        end
    end
    if (num == nil) then
        num = MatrixMgr:CheckHadBuild() and 1 or nil
    end
    RedPointMgr:UpdateData(RedPointType.Matrix, num) -- 改造完成，有建筑可建造 
end

-- 建筑更新
function this.OnBuildingUpdate()
    -- 更新建筑下次刷新时间 
    MatrixMgr:InitResetTime()

    MatrixMgr.OnBagUpdate()
end

-- 建筑更新时间 
function this:InitResetTime()
    self.rRunTime = nil
    local buildingDatas = MatrixMgr:GetBuildingDatas()
    local curTime = TimeUtil:GetTime()
    for i, v in pairs(buildingDatas) do
        local _baseTime = v:GetFlushTime()
        if (_baseTime and _baseTime ~= 0 and curTime <= _baseTime) then
            if (self.rRunTime == nil or _baseTime < self.rRunTime) then
                self.rRunTime = _baseTime
            end
        end
    end
    EventMgr.Dispatch(EventType.Matrix_Building_UpdateEnd)
end
-- 需要更新的建筑
function this:GetResetIds()
    local ids = {}
    local buildingDatas = MatrixMgr:GetBuildingDatas()
    local curTime = TimeUtil:GetTime()
    for i, v in pairs(buildingDatas) do
        local _baseTime = v:GetFlushTime()
        if (_baseTime and _baseTime ~= 0 and curTime >= _baseTime) then
            table.insert(ids, v:GetId())
        end
    end
    return ids
end
-- function this:InitResetTime()
--     self.rRunTime = false
--     self.rFastestData = {}
--     local _rFastestData = {} -- {{time,ids = {}}}
--     local buildingDatas = MatrixMgr:GetBuildingDatas()
--     local curTime = TimeUtil:GetTime()
--     for i, v in pairs(buildingDatas) do
--         -- if(v:CheckRunning()) then
--         local _baseTime = v:GetNextRefreshTime()
--         if (_baseTime and _baseTime ~= 0 and curTime <= _baseTime) then
--             if (_rFastestData[_baseTime]) then
--                 table.insert(_rFastestData[_baseTime].ids, v:GetId())
--             else
--                 _rFastestData[_baseTime] = {}
--                 _rFastestData[_baseTime].time = _baseTime
--                 _rFastestData[_baseTime].ids = {v:GetId()}
--             end
--         end
--         -- end
--     end
--     local _rFastestData2 = {}
--     for i, v in pairs(_rFastestData) do
--         table.insert(_rFastestData2, v)
--     end
--     if (#_rFastestData2 > 0) then
--         table.sort(_rFastestData2, function(a, b)
--             return a.time < b.time
--         end)
--         self.rFastestData = _rFastestData2[1]
--         self.rRunTime = true
--     end
--     EventMgr.Dispatch(EventType.Matrix_Building_UpdateEnd)
-- end
function this:GetResetTime()
    return self.rRunTime
end

--------------------------------------////data
-- 地面
function this:GetGridDatas()
    return self.gridDatas
end
function this:GetGridDataById(id)
    return self.gridDatas[id]
end

-- 基地信息
function this:SetMatrixInfo(proto)
    self.matrixInfo = proto
end
function this:GetMatrixInfo()
    return self.matrixInfo
end
function this:UpdateMatrixInfo(proto)
    for k, v in pairs(proto) do
        self.matrixInfo[k] = v
    end
end

-- 建筑
function this:AddNotice(proto)
    for i, v in ipairs(proto.builds) do
        if (self.buildingDatas[v.id]) then
            self.buildingDatas[v.id]:SetData(v)
        else
            local _data = MatrixData.New()
            _data:SetData(v)
            self.buildingDatas[v.id] = _data
        end
    end
end
-- 全部
function this:GetBuildingDatas()
    return self.buildingDatas
end

-- 不包含建造中的,不包含非建筑
function this:GetBuildingDatasArr(noEntry)
    local arr = {}
    local datas = self:GetBuildingDatas()
    for i, v in pairs(datas) do
        local _buildingState = v:GetState()
        if (v:CheckIsBuilding() and _buildingState ~= MatrixBuildingType.Create) then
            if (noEntry and v:GetType() == BuildsType.Entry) then

            else
                table.insert(arr, v)
            end
        end
    end
    table.sort(arr, function(a, b)
        return a:GetCfgId() < b:GetCfgId()
    end)
    return arr
end

function this:UpdateNotice(info)
    if (self.buildingDatas[info.id]) then
        self.buildingDatas[info.id]:UpdateData(info)
    end

    self:_UpdateDatas()
end

function this:GetBuildingDataById(_id)
    for i, v in pairs(self.buildingDatas) do
        if (i == _id) then
            return v
        end
    end
    return nil
end
function this:GetBuildingDataByCfgId(_cfgId)
    for i, v in pairs(self.buildingDatas) do
        if (v:SetBaseCfg().id == _cfgId) then
            return v
        end
    end
    return nil
end

function this:GetBuildingDataByType(_type)
    for i, v in pairs(self.buildingDatas) do
        if (v:GetType() == _type) then
            return v
        end
    end
    return nil
end

function this:GetBuildingIDsByType(_type)
    local ids = {}
    for i, v in pairs(self.buildingDatas) do
        if (v:GetType() == _type) then
            table.insert(ids, v:GetId())
        end
    end
    return ids
end
-- 指挥中心
function this:GetMainBuilding()
    for i, v in pairs(self.buildingDatas) do
        if (v:GetType() == BuildsType.ControlTower) then
            return v
        end
    end
    return nil
end

function this:BuildRemoveRet(id)
    if (self.buildingDatas[id]) then
        self.buildingDatas[id] = nil
    end
end

-- --获取驻员信息
-- function this:GetRoleInfoByRoleId(_cRoleId)
-- 	for i, v in pairs(self.buildingDatas) do
-- 		local cRoleInfo = v:GetRoleInfo(_cRoleId)
-- 		if(cRoleInfo) then
-- 			return cRoleInfo
-- 		end
-- 	end
-- 	return nil
-- end
function this:GetBuildingAllCount()
    local curNum, maxNum = 0, 0
    for i, v in pairs(self.buildingDatas) do
        curNum = curNum + 1
    end
    local mainData = self:GetMainBuilding(BuildsType.ControlTower)
    maxNum = mainData:GetCfg().builSumLimit
    return curNum, maxNum
end

-- 建筑数量 curNum, maxNum  
function this:GetBuildingCount(_id)
    local curNum, maxNum = 0, 0
    for i, v in pairs(self.buildingDatas) do
        if (v:GetCfgId() == _id) then
            curNum = curNum + 1
        end
    end
    local mainData = self:GetMainBuilding(BuildsType.ControlTower)
    for i, v in pairs(mainData:GetCfg().buildNumLimit) do
        if (v[1] == _id) then
            maxNum = v[2]
            break
        end
    end
    return curNum, maxNum
end

-- 是否是建筑需要的能力(池id)
function this:CheckAbilityIsNeed(buildData, abilityID)
    local needAbilityIds = buildData:GetNeedAbilityTypes()
    if (needAbilityIds and #needAbilityIds > 0) then
        for i, v in ipairs(needAbilityIds) do
            if (v == abilityID) then
                return true
            end
        end
    end
    return false
end

-- 全体建筑疲劳减免数值 (todo 改成建筑自己算)
function this:GetPLDerate()
    local mainData = self:GetMainBuilding(BuildsType.ControlTower)
    local data = mainData:GetData()
    if (data.roleAbilitys and data.roleAbilitys[RoleAbilityType.Controler]) then
        return data.roleAbilitys[RoleAbilityType.Controler].vals[1] or 0
    end
    return 0
end

--------------------------------------////get
-- 人口
function this:GetRoleCnt()
    local cur = 0
    local max = 0
    cur = self.matrixInfo.roleCnt or 0
    local mainData = self:GetMainBuilding(BuildsType.ControlTower)
    max = mainData and mainData:GetCfg().roleSumLimit or 0
    return cur, max
end
-- 电力
function this:GetPower()
    -- local cur = self.matrixInfo.power and self.matrixInfo.power.cost or 0
    -- local max = self.matrixInfo.power and self.matrixInfo.power.add or 0
    -- local add = self.matrixInfo.perRolePower and self.matrixInfo.perRolePower or 0
    -- if (add ~= 0) then
    --     cur = math.floor(math.abs(cur) * (add / 100))
    -- end
    -- return cur, max
    local cur = self.matrixInfo.power and self.matrixInfo.power.realCost or 0
    local max = self.matrixInfo.power and self.matrixInfo.power.add or 0
    return cur, max
end
-- 预警级别
function this:GetWarningLv()
    return self.matrixInfo.warningLv or 1
end
-- 基地面积
function this:GetScale()
    local cur = 0
    local max = g_BuildScale[1] * g_BuildScale[2]
    local mainData = self:GetMainBuilding(BuildsType.ControlTower)
    local openArea = mainData:GetCfg().openArea
    if (openArea) then
        for i, v in ipairs(openArea) do
            local cfg = Cfgs.CfgBOpenArea:GetByID(v)
            if (cfg.scale) then
                cur = cur + cfg.scale[1] * cfg.scale[2]
            end
        end
    end
    return cur, max
end

-- 驻员能力描述
function this:GetRoleAbilityStr(abilityIds)
    local str = ""
    if (abilityIds and #abilityIds > 0) then
        for i, v in ipairs(abilityIds) do
            local cfg = Cfgs.CfgCardRoleAbility:GetByID(v)
            if (not StringUtil:IsEmpty(cfg.desc)) then
                if (str == "") then
                    str = cfg.desc
                else
                    str = str .. "\n" .. cfg.desc
                end
            end
        end
    end
    return str
end

-- 初始化地面
function this:InitGroundDatas()
    if (not g_BuildScale) then
        return;
    end

    local row = g_BuildScale[1] -- 行
    local cloumn = g_BuildScale[2] -- 列
    local mRow = math.fmod(row, 2) == 1 and (row + 1) / 2 or row / 2
    local mCloumn = math.fmod(cloumn, 2) == 1 and (cloumn + 1) / 2 or cloumn / 2
    local index = 1
    for j = mCloumn, -(mCloumn - 1), -1 do
        for i = -mRow, (mRow - 1) do
            local grid = {
                id = index,
                pos = {i, 0, j}
            }
            -- local grid = {id = index, pos = {i, j, 0}}
            self.gridDatas[index] = grid
            index = index + 1
        end
    end
end

-- 根据index获取坐标(3d地面)
function this:GetPosByIndex(_index)
    local data = self.gridDatas[_index]
    return data and data.pos or {0, 0, 0}
end

-- 已开放的区域(字典)
function this:GetOpenAreaDic()
    local mainData = self:GetMainBuilding(BuildsType.ControlTower)
    local openArea = mainData:GetCfg().openArea
    local openAreaDic = {}
    for i, v in ipairs(openArea) do
        openAreaDic[v] = {v}
    end
    return openAreaDic
end

-- 建筑范围坐标集合
function this:GetAllPos(x, y, cfgId)
    local allPos = {}
    local newArea = Cfgs.CfgBuidingBase:GetByID(cfgId).area
    for i = x, (x + newArea[1] - 1) do
        for j = y, (y + newArea[2] - 1) do
            table.insert(allPos, {i, j})
        end
    end
    return allPos
end

-- 建筑范围是否已全部开放
function this:CheckIsOpen(allPos)
    local openAreaDic = self:GetOpenAreaDic()
    local cfgs = Cfgs.CfgBOpenArea:GetAll()
    for k, m in pairs(allPos) do
        local isOpen = false
        for i, v in ipairs(cfgs) do
            if (openAreaDic[i]) then
                if (m[1] >= v.startPos[1] and m[1] <= (v.startPos[1] + v.scale[1] - 1) and m[2] >= v.startPos[2] and
                    m[2] <= (v.startPos[2] + v.scale[2] - 1)) then
                    isOpen = true
                    break
                end
            end
        end
        if (not isOpen) then
            return false
        end
    end
    return true
end

-- 是否在其它建筑内
function this:CheckIsInBuilding(_data, _x, _y)
    local buildDatas = self:GetBuildingDatas()
    for i, v in pairs(buildDatas) do
        if (_data:GetId() == nil or (_data:GetId() ~= v:GetId())) then
            -- 中点
            local middleA = {_data:GetArea()[1] / 2 + _x, _data:GetArea()[2] / 2 + _y}
            local middleB = {v:GetArea()[1] / 2 + v:GetCachePos()[1], v:GetArea()[2] / 2 + v:GetCachePos()[2]}
            -- 最小距离
            local minDiscX = (_data:GetArea()[1] + v:GetArea()[1]) / 2
            local minDiscY = (_data:GetArea()[2] + v:GetArea()[2]) / 2
            if (math.abs(middleA[1] - middleB[1]) < minDiscX and math.abs(middleA[2] - middleB[2]) < minDiscY) then
                return true
            end
        end
    end
    return false
end

function this:GetMiddlePos(_data, _x, _y)
    local area = data:GetArea()
    return
end

-- 获取可用的位置
function this:GetCanUsePos(_data)
    local row = g_BuildScale[1] -- 行
    local cloumn = g_BuildScale[2] -- 列
    for i = 1, cloumn do
        for j = 1, row do
            -- 坐标是否已开放
            local allPos = self:GetAllPos(j, i, _data:GetCfgId())
            local isOpen = self:CheckIsOpen(allPos)
            if (isOpen) then
                -- 是否与其它建筑交叉
                local isIn = self:CheckIsInBuilding(_data, j, i)
                if (not isIn) then
                    return {j, i}
                end
            end
        end
    end
    -- 无空余位置，取中点
    local mRow = math.fmod(row, 2) == 1 and (row + 1) / 2 or row / 2
    local mCloumn = math.fmod(cloumn, 2) == 1 and (cloumn + 1) / 2 or cloumn / 2
    return {mRow, mCloumn}
end

-- 是否在地图内,并且不交叉  
function this:CheckIsInMap(_x, _y, _data)
    local allPos = self:GetAllPos(_x, _y, _data:GetCfgId())
    local isOpen = self:CheckIsOpen(allPos)
    if (isOpen) then
        -- 是否在其它建筑内
        local isIn = self:CheckIsInBuilding(_data, _x, _y)
        return not isIn
    end
    return false
end

-- 退出基地
function this:Quit()
    SceneLoader:Load("MajorCity")
end

function this:SetIsAttack(b)
    self.isAttack = b
end

-- 是否是基地的战斗
function this:GetIsAttack()
    return self.isAttack
end

-- 远征任务列表
function this:GetExpeditionLists()
    return nil
end

-- 当前执行的远征任务id
function this:GetCurExpeditionIDs()
    return nil
end

-----------------------------------外部调用------------------------------------------------------

-- 建筑是否已开启(需要基地)
function this:BuildingIsOpen(type)
    local b, str = MenuMgr:CheckModelOpen(OpenViewType.main, "Matrix")
    if (not b) then
        return b, str
    end
    local buildingData = MatrixMgr:GetBuildingDataByType(type) or nil
    if (buildingData ~= nil) then
        return true, ""
    else
        return false, LanguageMgr:GetTips(4003)
    end
end

-- 打开好友的订单库
function this:OpenMatrixTrading(fid)
    local isOpen = self:BuildingIsOpen(BuildsType.TradingCenter)
    if (isOpen) then
        CSAPI.OpenView("MatrixTrading", fid)
    end
end

-- 打开合成列表
function this:OpenCompoundPanel(val1, cb)
    local isOpen = self:BuildingIsOpen(BuildsType.Compound)
    if (isOpen) then
        local buildingData = self:GetBuildingDataByType(BuildsType.Compound)
        if (buildingData) then
            CSAPI.OpenView("MatrixCompound", buildingData, val1, cb)
        else
            LanguageMgr:ShowTips(4000)
        end
    end
end

-- -- 打开自己的订单中心
-- function this:OpenTradingCenter()
--     local isOpen = self:BuildingIsOpen(BuildsType.TradingCenter)
--     if (isOpen) then
--         CSAPI.OpenView("MatrixTrading")
--     else
--         LanguageMgr:ShowTips(4002)
--     end
-- end

function this:GetFaceName(tv)
    local faceName = "face1"
    if (tv <= 10) then
        faceName = "face3"
    elseif (tv <= 50) then
        faceName = "face2"
    end
    return faceName
end

function this:SetFace(obj, tv)
    local faceName = self:GetFaceName(tv)
    ResUtil.Face:Load(obj, faceName)
    CSAPI.SetGOActive(obj, true)
end

-- function this:SetFace(obj, tv)
-- 	local faceName = 16
-- 	if(tv >= 90) then
-- 		faceName = 18
-- 	elseif(tv >= 50) then
-- 		faceName = 17
-- 	end
-- 	CSAPI.LoadImg(obj, "UIs/Matrix/" .. faceName .. ".png", true, nil, true)
-- 	CSAPI.SetGOActive(obj, true)	
-- end
-- 修理
function this:Repair(buildData)
    local str = ""
    local costs, needHp = buildData:GetHPCosts()
    if (needHp > 0 and costs and #costs > 0) then
        for i, v in ipairs(costs) do
            if (str == "") then
                str = v[2] .. " " .. v[1]
            else
                str = str .. "、" .. v[2] .. " " .. v[1]
            end
        end
    end
    if (not StringUtil:IsEmpty(str)) then
        local s1 = LanguageMgr:GetTips(4001)
        str = string.format(s1, str)
        CSAPI.OpenView("Dialog", {
            content = str,
            okCallBack = function()
                BuildingProto:AddHp(buildData:GetId(), needHp)
            end
        })
    end
end

-- 建筑cfgid是否满足建造条件 reture: bool,提示
function this:CheckCreate(cfgId)
    local cfg = Cfgs.CfgBuidingBase:GetByID(cfgId)
    if (cfg == nil) then
        return false, ""
    end
    -- 建筑数量
    local curNum, maxNum = MatrixMgr:GetBuildingCount(cfgId)
    if (curNum >= maxNum) then
        return false, LanguageMgr:GetByID(10042) -- 10042
    end
    -- 开启类型（玩家等级，指挥塔等级，玩家能力）
    local str = ""
    if (cfg.openType and cfg.openVal) then
        if (cfg.openType == BuildOpenType.PlrLevel) then
            str = LanguageMgr:GetByID(10043, cfg.openVal)
            if (PlayerClient:GetLv() < cfg.openVal) then
                return false, str -- 10043
            end
        elseif (cfg.openType == BuildOpenType.ControlTowerLevel) then
            local mainData = MatrixMgr:GetMainBuilding(BuildsType.ControlTower)
            str = LanguageMgr:GetByID(10044, cfg.openVal)
            if (mainData:GetLv() < cfg.openVal) then
                return false, str -- 10044
            end
        elseif (cfg.openType == BuildOpenType.PlrAbility) then
            local abilityData = PlayerAbilityMgr:GetData(cfg.openVal)
            str = LanguageMgr:GetByID(10045)
            if (abilityData and abilityData:GetIsLock()) then
                return false, str -- 10045
            end
        end
    end
    return true, str
end

this.showQP = true
this.showRole = true
this.showHP = false
-- 气泡
function this:ShowQP(b)
    if (b ~= nil) then
        self.showQP = b
    end
    return self.showQP
end

-- 驻员显示
function this:ShowRole(b)
    if (b ~= nil) then
        self.showRole = b
    end
    return self.showRole
end

-- 血量
function this:ShowHP(b)
    if (b ~= nil) then
        self.showHP = b
    end
    return self.showHP
end

function this:GetPLType(curLv, openLv)
    local type = 1
    if (openLv == -1) then
        type = 3
    elseif (curLv >= openLv) then
        type = 1
    else
        type = 2
    end
    return type
end

--[[  已有内部建筑，不支持旧的查看方式 2022/09/02 rui
--根据类型获取建筑id
function this:GetBuildIDByType(_type)
	local ids = self:GetBuildingIDsByType(_type)
	return ids[1]
end

--通过类型查看建筑
function this:OpenMatrixBuilding(_type)
	local id = _type ~= nil and self:GetBuildIDByType(_type) or nil
	local data = id ~= nil and self:GetBuildingDataById(id) or nil
	local datas = data ~= nil and {data} or nil
	EventMgr.Dispatch(EventType.Matrix_Grid_Click, datas)
end
]]
function this:OpenMatrixBuilding(_type)
    _type = _type or BuildsType.ControlTower
    local buildingData = MatrixMgr:GetBuildingDataByType(_type)
    if (buildingData) then
        EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"MatrixBuilding", buildingData})
    else
        LogError("建筑未建筑")
    end
end

function this:GetDormGround()
    if (not self.matrixGround) then
        local go = GameObject.Find("MatrixGround")
        self.matrixGround = ComUtil.GetLuaTable(go)
    end
    return self.matrixGround
end

-- 是否激活场景相机的操作
function this:SetSceneCameraAction(b)
    local matrixGround = self:GetDormGround()
    local matrixCameraMgr = ComUtil.GetCom(matrixGround.gameObject, "MatrixCameraMgr")
    if (matrixCameraMgr) then
        dormCameraMgr:SetIsOn(b)
    end
end

-- function this:GetMatrixIndoorGround()
-- 	if(not self.matrixIndoorGround) then
-- 		local go = GameObject.Find("MatrixIndoorGround")
-- 		self.matrixIndoorGround = ComUtil.GetLuaTable(go)
-- 	end
-- 	return self.matrixIndoorGround
-- end
-- --场景相机
-- function this:GetSceneCamera()
-- 	local matrixIndoorGround = self:GetMatrixIndoorGround()
-- 	local camera = ComUtil.GetCom(matrixIndoorGround.cameraGo, "Camera")
-- 	return camera
-- end
function this:ClearDatas()
    self.matrixIndoorGround = nil
end

-- 检查远征条件
function this:CheckCondition(cardArr, condition)
    local isEnough = false
    if (cardArr) then
        if (condition[1] == ExpeditionTeamLimit.Lv) then
            local count = 0
            for i, data in ipairs(cardArr) do
                if (data:GetLv() >= condition[2]) then
                    count = count + 1
                end
                if (count >= condition[3]) then
                    isEnough = true
                    break
                end
            end
        elseif (condition[1] == ExpeditionTeamLimit.Num) then
            isEnough = #cardArr >= condition[2]
        elseif (condition[1] == ExpeditionTeamLimit.Class) then
            local count = 0
            for i, data in ipairs(cardArr) do
                if (data:GetCamp() == condition[2]) then
                    count = count + 1
                end
                if (count >= condition[3]) then
                    isEnough = true
                    break
                end
            end
        end
    end
    return isEnough
end

-- CfgMatrixAttribute
function this:GetIDByBuildData(buildData)
    local index = nil
    if (buildData:GetType() == BuildsType.ControlTower) then
        index = 9
        -- elseif(buildData:GetType() == BuildsType.PowerHouse) then	--发电厂，攻击建筑，防御建筑，入口建筑
        -- elseif(buildData:GetType() == BuildsType.Attack) then  
        -- elseif(buildData:GetType() == BuildsType.Defence) then
        -- elseif(buildData:GetType() == BuildsType.Entry) then
    elseif (buildData:GetType() == BuildsType.ProductionCenter) then
        index = 3
    elseif (buildData:GetType() == BuildsType.TradingCenter) then
        index = 5
    elseif (buildData:GetType() == BuildsType.Expedition) then
        index = 8
    elseif (buildData:GetType() == BuildsType.Compound) then
        index = 2
    elseif (buildData:GetType() == BuildsType.Remould) then
        index = 1
    end
    return index
end

-- 通过界面名称获取建筑类型
function this:GetBuildingTypeByViewName(viewName)
    if (viewName == "MatrixCompound") then
        return BuildsType.Compound
    elseif (viewName == "MatrixRemould") then
        return BuildsType.Remould
    elseif (viewName == "MatrixTrading") then
        return BuildsType.TradingCenter
    elseif (viewName == "MatrixResPanel") then
        return BuildsType.ProductionCenter
    elseif (viewName == "MatrixExpedition") then
        return BuildsType.Expedition
    end
    return nil
end

-- CfgMatrixAttribute
function this:GetPointPosByBuildType(type)
    local pos = {0, -80}
    if (type == BuildsType.ControlTower) then
        pos = {-128, -80}
        -- elseif(type == BuildsType.PowerHouse) then	--发电厂，攻击建筑，防御建筑，入口建筑
        -- elseif(type == BuildsType.Attack) then  
        -- elseif(type == BuildsType.Defence) then
        -- elseif(type == BuildsType.Entry) then
    elseif (type == BuildsType.ProductionCenter) then
        pos = {50, -80}
    elseif (type == BuildsType.TradingCenter) then
        pos = {-20, -80}
        -- elseif (type == BuildsType.Expedition) then
    elseif (type == BuildsType.Compound) then
        pos = {-50, -80}
        -- elseif (type == BuildsType.Remould) then
    end
    return pos
end

-- MatrixRole红点 有上驻的疲劳为0
function this:CheckAllRoleRed()
    local datas = self:GetBuildingDatas()
    for k, v in pairs(datas) do
        if (v:CheckRolesRed()) then
            return true
        end
    end
    return false
end

-- MatrixRole红点 建筑+升级
function this:CheckBuildRed()
    if (self:CheckHadBuild()) then
        return true
    end
    if (self:CheckHadUp()) then
        return true
    end
    return false
end

-- MatrixScene红点 有可建筑的建筑
function this:CheckHadBuild()
    local cfgs = Cfgs.CfgBuidingBase:GetAll()
    for i, v in pairs(cfgs) do
        if (self:CheckHadBuildByID(v)) then
            return true
        end
    end
    return false
end
function this:CheckHadBuildByID(cfg)
    local canOpen, strID = self:CheckCreate(cfg.id)
    if (canOpen) then
        -- 材料金钱是否足够 
        local max = BagMgr:GetCount(ITEM_ID.GOLD)
        local goldCount = cfg.costs ~= nil and cfg.costs[1][2] or 0
        if (max >= goldCount) then
            return true
        end
    end
    return false
end

-- MatrixScene红点 有可升级的建筑
function this:CheckHadUp()
    local datas = self:GetBuildingDatas()
    for k, v in pairs(datas) do
        if (v:CheckCanUp()) then
            return true
        end
    end
    return false
end
---------------------------------建造升级完成提示缓存----------------------------------------
-- 1、在线期间，在以下界面（xx）不打开情况下，缓存消息（保存到本地），在再次进入基地时弹出，如果不进入基地直接下线则缓存到下次弹出,如果是多条消息，则需要转换成其它提示
-- 2、离线期间完成了建造或者升级，+缓存的消息，在进入基地时弹出
-- 在线不在基地收到升级或者建造完成，缓存tips

-- 建造、升级完成 (如果 MatrixScene或MatrixBuilding打开中，则直接提示)
function this:SetCreateUpTips(buildData, isUp)
    local name = buildData:GetBuildingName()
    local id = isUp == 1 and 2007 or 2315
    local tips = LanguageMgr:GetTips(id, name)
    if (CSAPI.IsViewOpen("MatrixScene") or CSAPI.IsViewOpen("MatrixBuilding")) then
        Tips.ShowTips(tips)
    else
        self.cuTips = self.cuTips or {}
        for k, v in pairs(self.cuTips) do
            if (v[1] == tips) then
                return
            end
        end
        table.insert(self.cuTips, {tips, isUp}) -- 1 
        local key2 = string.format("%s_matrixbuilding2.txt", PlayerClient:GetID())
        FileUtil.SaveToFile(key2, self.cuTips)
    end
end

-- 登录时检查离线期间的建筑和升级状态，生成tips
function this:CheckCreateUpOutline()
    local tipsDatas = self:GetBuildTipsDatas()
    self._buildingDatas = tipsDatas
    local key = string.format("%s_matrixbuilding1.txt", PlayerClient:GetID())
    local oldDatas = FileUtil.LoadByPath(key)
    if (oldDatas) then
        local dic = {}
        for k, v in pairs(oldDatas) do
            dic[v[1]] = v[2]
        end
        -- 有数据，对比数据后
        for k, v in pairs(tipsDatas) do
            if (not dic[v[1]]) then
                -- 离线期间建造完成的
                self:SetCreateUpTips(self:GetBuildingDataById(v[1]), 2)
            elseif (dic[v[1]] ~= v[2]) then
                -- 离线期间升级的
                self:SetCreateUpTips(self:GetBuildingDataById(v[1]), 1)
            end
        end
    end
    -- 刷新数据
    FileUtil.SaveToFile(key, tipsDatas)

    -- 离线前未播放的tips
    local key2 = string.format("%s_matrixbuilding2.txt", PlayerClient:GetID())
    local oldDatas2 = FileUtil.LoadByPath(key2)
    if (oldDatas2) then
        self.cuTips = self.cuTips or {}
        for k, v in pairs(oldDatas2) do
            table.insert(self.cuTips, {v[1], v[2]}) -- 2 
        end
    end

    FileUtil.SaveToFile(key2, {})
end

-- 封装的基地数据 {{id,lv}}
function this:GetBuildTipsDatas()
    local _datas = {}
    local datas = self:GetBuildingDatas() or {}
    for k, v in pairs(datas) do
        local d = {}
        d[1] = v:GetID()
        d[2] = v:GetLv()
        table.insert(_datas, d)
    end
    return _datas
end

-- 更新建筑信息(提示用)
function this:_UpdateDatas()
    local tab1 = self._buildingDatas
    local tab2 = self:GetBuildTipsDatas()
    local isSame = FuncUtil.TableIsSame(tab1, tab2)
    if (not isSame) then
        local key = string.format("%s_matrixbuilding1.txt", PlayerClient:GetID())
        FileUtil.SaveToFile(key, tab2)
        self._buildingDatas = tab2
    end
end

-- 弹出提示 
function this:PlayTips()
    if (self.cuTips and #self.cuTips > 0) then
        if (#self.cuTips == 1) then
            Tips.ShowTips(self.cuTips[1][1])
        else
            local isUp = false
            local isCreate = false
            for k, v in pairs(self.cuTips) do
                if (v[2] == 1) then
                    isUp = true
                else
                    isCreate = true
                end
            end
            local id = 2313
            if (isUp and isCreate) then
                id = 2314
            elseif (isCreate) then
                id = 2312
            end
            LanguageMgr:ShowTips(id)
        end

        -- 清除 
        self.cuTips = nil
        local key2 = string.format("%s_matrixbuilding2.txt", PlayerClient:GetID())
        FileUtil.SaveToFile(key2, {})
    end
end

--[[
    -- 建筑类型
BuildsType = {}
BuildsType.ControlTower = 1 -- 指挥塔
BuildsType.PowerHouse = 2 -- 发电厂
BuildsType.ProductionCenter = 3 -- 生产中心(制造中心)
BuildsType.TradingCenter = 4 -- 交易中心（订单中心）
BuildsType.Expedition = 5 -- 远征
BuildsType.Compound = 6 -- 合成工厂
BuildsType.Attack = 7 -- 攻击设备
BuildsType.Defence = 8 -- 防御设备
BuildsType.Remould = 9 -- 改造工厂
BuildsType.Entry = 10 -- 入口建筑（宿舍）
BuildsType.PhyRoom = 11 -- 心理咨询室
]]
-- 建筑是否小于等于该等级  （ BuildsType 建筑类型）
function this:CheckBuildingIsUpgrade(_type, lv)
    lv = lv or 1
    local data = self:GetBuildingDataByType(_type)
    if (data and data:GetLv() <= lv) then
        return true
    end
    return false
end

---------------------------------场景跳转管理----------------------------------------
function this:SetMatrixViewData(_data)
    self.matrixViewData = _data
end

function this:GetMatrixViewData()
    return self.matrixViewData or {}
end

---------------------------------从主界面进入基地需要摄像机效果----------------------------------------

function this:SetEnterAnim(b)
    self.enterAnim = b
end

function this:GetEnterAnim()
    return self.enterAnim
end

----------------------------------------队伍预设------------------------------------------
-- 额外预设队伍数
function this:GetExtraPresetTeamNum()
    return self.matrixInfo.extraPresetTeamNum or 1
end
function this:SetExtraPresetTeamNum(num)
    self.matrixInfo.extraPresetTeamNum = num
end

function this:GetCfgModuleInfoName(type)
    local name = nil 
    if(type==BuildsType.ControlTower)then 
        name = "MatrixCommand"
    elseif(type==BuildsType.Compound)then  
        name = "MatrixCompound"
    elseif(type==BuildsType.Remould)then  
        name = "MatrixRemould"
    elseif(type==BuildsType.PowerHouse)then  
        name = "PowerHouse"
    elseif(type==BuildsType.ProductionCenter)then  
        name = "MatrixResPanel"
    elseif(type==BuildsType.TradingCenter)then  
        name = "MatrixTrading"
    end
    return name
end

return this
