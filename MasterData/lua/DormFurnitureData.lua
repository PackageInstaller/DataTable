-- 3d家具数据
local this = {}
function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

-- 服务器数据  {id,point,planeType,rotateY,parentID,childID[]}   point={x=,y=,z=}
function this:InitData(_data)
    self.data = _data
    self.cfgID = GCalHelp:GetDormFurCfgId(self:GetID())
    self.cfg = Cfgs.CfgFurniture:GetByID(self:GetCfgID())
end

function this:GetData()
    return self.data
end

-- 唯一id
function this:GetID()
    return self.data.id
end

-- 表id
function this:GetCfgID()
    return self.cfgID
end

function this:GetCfg()
    return self.cfg
end

-- 可叠性家具可能会放置在某个家具上
function this:GetParentID()
    return self.data.parentID
end
function this:SetParentID(id)
    self.data.parentID = id
end

function this:GetChildID()
    return self.data.childID or {}
end

function this:SetChildID(id, add)
    self.data.childID = self.data.childID or {}
    if (add) then
        for i, v in ipairs(self.data.childID) do
            if (v == id) then
                return
            end
        end
        table.insert(self.data.childID, id)
    else
        for i, v in ipairs(self.data.childID) do
            if (v == id) then
                self.data.childID[i] = nil
                return
            end
        end
    end
end

function this:GetPoint()
    return self.data.point or {
        x = 0,
        y = 0,
        z = 0
    }
end
function this:SetPoint(point)
    self.data.point = point
end
-- 修改墙饰的位置（改变场景大小后）
function this:ChangePoint()
    if (self:GetCfg().sType ~= DormFurnitureType.decorate) then
        return
    end
    local scale = DormMgr:GetDormScale()
    local panelType = self:GetPlaneType()
    if (panelType == 2) then
        self.data.point.x = scale.x * 0.5
    elseif (panelType == 3) then
        self.data.point.z = -scale.z * 0.5
    end
end

-- 所在位置 1:地板 2：左墙壁  3：右墙壁
function this:GetPlaneType()
    return self.data.planeType
end
function this:SetPlaneType(type)
    self.data.planeType = type
end

-- 旋转角度  0，90,180,270
function this:GetRotateY()
    return self.data.rotateY
end
function this:SetRotateY()
    self.data.rotateY = self.data.rotateY + 90
    if (self.data.rotateY == 360) then
        self.data.rotateY = 0
    end
    return self.data.rotateY
end
function this:ResetRotaY(y)
    self.data.rotateY = y
end

function this:GetName()
    return self:GetCfg().sName
end

function this:GetModel()
    return self:GetCfg().model
end

function this:GetModelPath()
    return "Scenes/" .. self:GetModel()
end

-- 大小  {x,y,z}
function this:GetScale()
    local scale = self.cfg.scale or {1, 1, 1}
    return {
        ["x"] = scale[1],
        ["y"] = scale[2],
        ["z"] = scale[3]
    }
end

function this:IsGround()
    return self:GetCfg().sType == DormFurnitureType.ground
end

function this:IsWall()
    return self:GetCfg().sType == DormFurnitureType.wall
end

-- 地毯
function this:IsCarpet()
    return self:GetCfg().sType == DormFurnitureType.carpet
end

-- 装饰
function this:IsHangings()
    return self:GetCfg().sType == DormFurnitureType.hangings
end

-- --能否与角色发生交互  
function this:CheckCanInte()
    return self:GetCfg().intePoints and #self:GetCfg().intePoints > 0
end

-- -- 是否有碰撞(墙砖和地毯无碰撞)
-- function this:IsBrick()
--     if (self:GetCfg().sType == DormFurnitureType.carpet) then
--         return true
--     else
--         return false
--     end
-- end

--是墙砖
function this:IsBrick()
    return self:GetCfg().isBrick
end

-- 可容纳
function this:IsCanReceive()
    return self:GetCfg().receive
end

-- 可叠放
function this:IsCanOverlay()
    return self:GetCfg().overlay
end

-- index 由1 开始
function this:GetChildBoxPosRot(index)
    local info = self:GetCfg().boxChilds
    local _index = (index - 1) * 2 + 1
    return info[_index], info[_index + 1]
end

function this:GetInteRate()
    return self:GetCfg().inteRate or 0
end
--[[
0：睡觉（要区分左右）
1：坐沙发
2：坐椅子
3：坐睡
4：观看
5：玩模型
6：浇水
7: 跳舞机
8：操作电脑
]]
function this:GetInteActionID(targetGO)
    -- local inteActionId = self:GetCfg().inteActionId or 0
    -- local key = DormAction3[inteActionId + 1]
    local key = self:GetCfg().inteActionId or ""
    if (key == "furniture_sleep_0" and targetGO) then
        local inteBoxIndex = targetGO.transform:GetSiblingIndex()
        key = inteBoxIndex == 0 and "furniture_sleep_01" or "furniture_sleep_02"
    end
    return key
end

--宠物交互动作
function this:GetPetInteActionID()
    local key = self:GetCfg().petInteActionId
    return key
end


--占地数量（仅考虑放地且无父的家具）
function this:GetGridNum()
    if(self:GetParentID()~=nil or self:GetCfg().sType==0 or self:GetCfg().sType==1 or self:GetCfg().sType==7 or self:GetCfg().sType==8) then 
        return 0
    end 
    return math.ceil(self:GetCfg().scale[1]*self:GetCfg().scale[3])
end

--地面家具
function this:IsGroundFurnitrue()
    if(self:GetCfg().sType==2 or self:GetCfg().sType==3 or self:GetCfg().sType==4 or self:GetCfg().sType==5 or self:GetCfg().sType==6 or self:GetCfg().sType==9) then 
        return true
    end 
    return false 
end

return this
