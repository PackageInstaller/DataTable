-- 驻员行为管理器
DormRoleActionMgr = require "DormRoleActionMgr"

-- 驻员状态机（动画播放切换）
DormRoleStateMachine = require "DormRoleStateMachine"

DormRoleHitAngle = 60 -- 驻员与碰撞点发生交互的最大角度，这是一个-60到60的值
DormRoleHitAngle2 = 120
DormColMinDis1 = 0.2 -- 与家具的碰撞区域发生碰撞的最小距离
DormColMinDis2 = 0.2 -- 与触发区的碰撞区域发生碰撞的最小距离
DormInteDis = 0.01 -- 与目标点的最小判断距离
DormMoveSpeed = 0.7 -- 移动速度
DormAngularSpeed = 3 -- 角速度
Dorm_IdleToWall_Time = 0.3 -- 休闲到行走动作的过渡时间

Dorm_Action_Weidgh = {
    ["DormRoleActionIdle"] = 34,
    ["DormRoleActionMove"] = 33,
    ["DormRoleActionIpad"] = 33
} -- 行为比重

Dorm_CfgID = 2001

-- 房间类型
RoomType = {}
RoomType.building = 1 -- 建筑
RoomType.dorm = 2 -- 宿舍

DormFurnitureType = {}
DormFurnitureType.ground = 0 -- 地板
DormFurnitureType.wall = 1 -- 墙纸
DormFurnitureType.seat = 2 -- 座椅
DormFurnitureType.bed = 3 -- 床
DormFurnitureType.chest = 4 -- 柜
DormFurnitureType.desk = 5 -- 桌
DormFurnitureType.equipment = 6 -- 电子设备
DormFurnitureType.hangings = 7 -- 挂饰
DormFurnitureType.carpet = 8 -- 地毯
DormFurnitureType.sundries = 9 -- 杂物

-- 家具细分
-- DormFurnitrueChildType = {}
-- DormFurnitrueChildType.normal = 1 -- 普通家具
-- DormFurnitrueChildType.brick = 2 -- 地砖（无碰撞）

-- 墙饰细分
-- DormHangingsChildType = {}
-- DormHangingsChildType.normal = 1 -- 普通墙饰
-- DormHangingsChildType.brick = 2 -- 墙砖（无碰撞）

-- 宿舍层级
DormLayer = {}
DormLayer.col_area = 17 -- 触发区域
DormLayer.wall = 18 -- 墙壁
DormLayer.ground = 19 -- 地板
DormLayer.furniture = 20 -- 家具
DormLayer.dorm_role = 21 -- 驻员

-- 与驻员发生碰撞的脚本类型
DormGoType = {}
DormGoType.col_area = 1
DormGoType.furniture = 2
DormGoType.dorm_role = 3

-- 主题界面打开方式
DormThemeOpenType = {}
DormThemeOpenType.Shop = 1 -- 商店打开（表数据）
DormThemeOpenType.Theme = 2 -- 他人房间数据（主题分享）
DormThemeOpenType.Room = 3 -- 房间数据

-- 动作分类
-- DormAction1 = {}
-- DormAction1.Speed = "Speed"
-- DormAction1.furniture = "furniture"
-- DormAction1.grab = "grab"
-- DormAction1.leisure = "leisure"

-- 角色动作，作为key去获取DormRoleActionType
-- DormAction2 = {}
-- DormAction2.idle = "idle"
-- DormAction2.walk = "walk"
-- DormAction2.furniture_sleep_01 = "furniture_sleep_01"
-- DormAction2.furniture_sit_01 = "furniture_sit_01"
-- DormAction2.furniture_sit_02 = "furniture_sit_02"
-- DormAction2.base_operatePC = "base_operatePC" -- 操作电脑
-- DormAction2.role_highfive_01 = "role_highfive_01" -- 集掌 右
-- DormAction2.role_highfive_02 = "role_highfive_02" -- 集掌 左 
-- DormAction2.click_grab = "click_grab" -- 抓起
-- DormAction2.click_lens = "click_lens" -- 挥手
-- DormAction2.click_lens_02 = "click_lens_02" -- 挥手
-- DormAction2.furniture_Nod = "furniture_Nod" -- 点头
-- DormAction2.Furn_ComA_ipad_01 = "Furn_ComA_ipad_01" -- 看ipad
-- DormAction2.base_dozeOff = "base_dozeOff" -- 打瞌睡
-- DormAction2.base_drinkTea = "base_drinkTea" -- 喝茶
-- DormAction2.base_phone = "base_phone" -- 打电话
-- DormAction2.base_handlingData = "base_handlingData" -- 送快递
-- DormAction2.normal_daze_01 = "normal_daze_01" -- 发呆动作 
-- DormAction2.normal_daze_02 = "normal_daze_02"
-- DormAction2.normal_daze_03 = "normal_daze_03"
-- DormAction2.normal_daze_04 = "normal_daze_04"
-- DormAction2.normal_daze_05 = "normal_daze_05"
-- DormAction2.normal_daze_06 = "normal_daze_06"
-- DormAction2.normal_clean = "normal_clean"
-- DormAction2.normal_stretch = "normal_stretch"
-- DormAction2.normal_fatigue = "normal_fatigue"

-- 动作对应lua文件。 通过 Dorm_GetActionType  来获取后续动作(找不到的都返回DormRoleActionLeisure)
DormRoleActionType = {}
DormRoleActionType.Hide = "DormRoleActionHide" -- 隐藏  编辑家具时的状态
DormRoleActionType.Await = "DormRoleActionAwait" -- 换装时进入待机
DormRoleActionType.idle = "DormRoleActionIdle"
DormRoleActionType.walk = "DormRoleActionMove"
DormRoleActionType.Interaction = "DormRoleActionInteraction" -- 交互
DormRoleActionType.click_grab = "DormRoleActionTookUp"
DormRoleActionType.click_lens = "DormRoleActionClick"
DormRoleActionType.click_lens_02 = "DormRoleActionClick"
DormRoleActionType.furniture_Nod = "DormRoleActionClick"
-- DormRoleActionType.Furn_ComA_ipad_01 = "DormRoleActionLeisure" -- 看ipad
-- DormRoleActionType.base_dozeOff = "DormRoleActionLeisure" -- 打瞌睡
-- DormRoleActionType.base_drinkTea = "DormRoleActionLeisure" -- 喝茶
-- DormRoleActionType.base_phone = "DormRoleActionLeisure" -- 打电话
DormRoleActionType.base_handlingData = "DormRoleActionHandlingData" -- 送快递
-- DormRoleActionType.normal_daze_01 = "DormRoleActionLeisure" -- 发呆动作（假数据，要在获取里赋值真正的数据）
-- DormRoleActionType.normal_daze_02 = "DormRoleActionLeisure"
-- DormRoleActionType.normal_daze_03 = "DormRoleActionLeisure"
-- DormRoleActionType.normal_daze_04 = "DormRoleActionLeisure"
-- DormRoleActionType.normal_daze_05 = "DormRoleActionLeisure"
-- DormRoleActionType.normal_daze_06 = "DormRoleActionLeisure"
-- DormRoleActionType.normal_clean = "DormRoleActionLeisure"
-- DormRoleActionType.normal_stretch = "DormRoleActionLeisure"
-- DormRoleActionType.normal_fatigue = "DormRoleActionLeisure"
DormRoleActionType.lie = "DormRoleActionLie" -- 猫的休闲
-- -- 家具触发人物动作 编辑器对应
-- --[[
-- 0：睡觉（要区分左右） furniture_sleep_01 furniture_sleep_02
-- 1：坐沙发
-- 2：坐椅子
-- 3：坐睡
-- 4：观看
-- 5：玩模型
-- 6：浇水
-- 7: 跳舞
-- 8：操作电脑
-- 9: 有靠背的椅子
-- 10：无靠背的椅子
-- 11：棺材
-- ]]
-- DormAction3 = {"furniture_sleep_0", "furniture_sit_01", "furniture_sit_02", "furniture_sit_03", "furniture_watch",
--                "furniture_gundam", "furniture_Watering","furniture_Dance","base_operatePC_01","furniture_sit_04","furniture_sit_05","furniture_revive01"}

-- 基础时间+持续时间
function Dorm_Action_Time(_dormAction2)
    local cfg = Cfgs.CfgCardRoleAction:GetByID(_dormAction2)
    local timer = 0
    if cfg==nil then LogError("DormLauncher:154 cfg==nil"..table.tostring(_dormAction2,true)) end
    if (cfg and cfg.loop) then
        if (#cfg.loop > 1) then
            timer = CSAPI.RandomFloat(cfg.loop[1], cfg.loop[2])
        else
            timer = cfg.loop[1]
        end
    end
    return timer
end

-- 还原时间(有loop的才有)
function Dorm_Action_RestoreTime(_dormAction2)
    local cfg = Cfgs.CfgCardRoleAction:GetByID(_dormAction2)
    return cfg.restore
end

-- 获取后续行为
function Dorm_GetActionType(_dormAction2, role)
    local cfg = Cfgs.CfgCardRoleAction:GetByID(_dormAction2)
    local actions = nil

    if (role.IsPet()) then 
        actions = cfg.petActions
    elseif (role.IsRobot()) then
        actions = cfg.robotActions
    else
        -- 在宿舍或者咨询室
        if (role.CheckIsDorm() or role.CheckIsPhyRoom()) then
            actions = role.IsMan() and cfg.roleActions_m_d or cfg.roleActions_g_d
        else
            actions = role.IsMan() and cfg.roleActions_m_m or cfg.roleActions_g_m
        end
    end
    if (actions ~= nil) then
        local total = 0
        for k, v in pairs(actions) do
            total = total + v[2]
        end
        local num = CSAPI.RandomInt(1, total)
        local count = 0
        for i, v in pairs(actions) do
            count = count + v[2]
            if (count >= num) then
                local key = v[1] 
                if (v[1] == "normal_daze_0") then
                    key = Dorm_GetDaze(role.data)
                end
                local actionType = DormRoleActionType[key] or "DormRoleActionLeisure"
                return actionType, key
            end
        end
    else
        LogError("该动作无后续动作，配置错误：" .. _dormAction2)
    end

    return DormRoleActionType.idle, "idle"
end

-- 获取角色的发呆动作
function Dorm_GetDaze(cRoleInfo)
    local daze = cRoleInfo:GetDaze()
    return "normal_daze_0" .. daze
end

-- 获取角色的点击动作
function Dorm_GetClick(cRoleInfo)
    local click = cRoleInfo:GetClick()
    local str = "click_lens"
    if (click ~= 1) then
        str = click == 2 and "click_lens_02" or "furniture_Nod"
    end
    return str
end
