-- 房间数据(宿舍（好友的，自己的），建筑)
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:SetFid(fid)
    self.fid = fid
end

-- 更新简单数据（好友时才有num,roleIds自己才有）
function this:UpdateDataA(sDormA)
    if (self.isInit) then
        return
    end
    self.data = self.data or {}
    self.data.comfort = sDormA.comfort or 0
    self.data.id = sDormA.id
    self.data.num = sDormA.num or 0
    self.data.lv = 1 -- sDormA.lv or 1 --默认为1
    self.data.data = self.data.data or {}
    self.data.data.img = sDormA.img or nil
    self.data.data.roleIds = sDormA.roleIds
    self:InitID()
end

function this:InitData(_data)
    self.isInit = true
    self.data = _data
    self:InitID()
end

-- 是否已请求房间数据
function this:GetIsInit()
    return self.isInit
end

-- 划分出表id、index
function this:InitID()
    self.cfgID, self.index = GCalHelp:GetDormCfgId(self.data.id)
end

---获取驻员数据列表（已封装）
function this:GetRoleDatas()
    local roleDatas = {}
    local ids = self:GetRoles()
    for i, v in ipairs(ids) do
        local _data = CRoleMgr:GetData(v)
        table.insert(roleDatas, _data)
    end
    return roleDatas or {}
end

-- 获取当前最大长度的驻员数据
function this:GetRoleInfos()
    local roleInfos = {}
    local roles = self:GetRoles()
    local max = self:GetMaxNum()
    for i = 1, max do
        local _id = i <= #roles and roles[i] or nil
        table.insert(roleInfos, {
            data = _id,
            curLv = 1,
            openLv = 1
        })
    end
    return roleInfos
end

-- --获取最大长度的驻员数据
-- function this:GetRoleDatas_Five()
-- 	local datas_five = {}
-- 	local datas = self:GetRoleDatas()
-- 	local max = self:GetMaxNum()         --当前最大
-- 	local limit = self:GetMaxRoleLimit() --最大
-- 	for i = 1, limit do
-- 		if(i <= #datas) then
-- 			table.insert(datas_five, datas[i])
-- 		elseif(i <= max) then
-- 			--空
-- 			table.insert(datas_five, {isEmpty = true})
-- 		else
-- 			--lock
-- 			table.insert(datas_five, {isNil = true})
-- 		end
-- 	end
-- 	return datas_five
-- end

function this:GetID()
    return self.data.id
end

function this:GetData()
    return self.data
end

function this:GetIndexCfg()
    local cfg = Cfgs.CfgDorm:GetByID(self:GetCfgID())
    return cfg.infos[self:GetIndex()]
end

function this:GetLvCfg()
    return Cfgs.CfgDormRoom:GetByID(self:GetLv())
end
-- function this:GetNextLvCfg()
-- 	local lv = self:GetLv() + 1
-- 	if(lv <= self:GetMaxLv()) then
-- 		return Cfgs.CfgDormRoom:GetByID(lv)
-- 	end
-- 	return nil
-- end

-- 编号
function this:GetIndex()
    return self.index
end

-- 表id
function this:GetCfgID()
    return self.cfgID
end

-- 好友id
function this:GetFid()
    return self.fid
end

-- 驻员
function this:GetRoles()
    return self.data.data.roleIds or {}
end

-- 等级
function this:GetLv()
    return self.data.lv or 1
end

function this:GetMaxLv()
    return self:GetIndexCfg().maxLv
end

-- 房间人数
function this:GetNum()
    local cur = 0
    if (self:GetFid()) then
        cur = self.data.num or 0
    else
        cur = #self:GetRoles()
    end
    return cur, self:GetMaxNum()
end

-- 当前房间可以放置的驻员数量
function this:GetMaxNum()
    return self:GetLvCfg().maxRole or 0
end

-- --最大驻员
-- function this:GetMaxRoleLimit()
-- 	return 5
-- end

-- 主题id
function this:GetThemeID()
    return self.data.themeId
end
-- 主题类型
function this:GetThemType()
    return self.data.themeType
end

-- 房间名称
function this:GetName()
    return self:GetIndexCfg().roomName or ""
end

-- 家具数据
function this:GetFurnitures()
    return self.data.data.furnitures or {}
end

-- 舒适度
function this:GetComfort()
    return self.data.comfort or 0
end

-- 房间大小
function this:GetScale()
    return self:GetLvCfg().scale
end

-- function this:GetNextScale()
-- 	local cfg = self:GetNextLvCfg()
-- 	if(cfg) then
-- 		return {x = cfg.scale[1], z = cfg.scale[2]}
-- 	end
-- 	return nil
-- end

-- 是否有红点
function this:GetRed()
    local red = false
    if (not self:GetFid()) then
        local roles = self:GetRoleDatas()
        local curTime = TimeUtil:GetTime()
        for i, v in ipairs(roles) do
            if (v:GetEStart() and curTime > v:GetEStart()) then
                red = true
                break
            end
        end
    end
    return red
end

-- --获取房间升级后的家具数据（房间升级后，墙壁家具需要跟随移动，所以位置要发生变化）
-- function this:GetUpFurnitrueDatas(id)
-- 	local curDatas = self:GetFurnitures()
-- 	for i, v in pairs(curDatas) do
-- 		local cfgID = GCalHelp:GetDormFurCfgId(v.id)
-- 		local cfg = Cfgs.CfgFurniture:GetByID(cfgID)
-- 		--装饰
-- 		if(cfg.sType == DormFurnitureType.decorate) then
-- 			local scale = self:GetNextScale()
-- 			if(v.planeType == 2) then
-- 				self.data.point.x = scale.x * 0.5
-- 			elseif(v.planeType == 3) then
-- 				self.data.point.z = - scale.z * 0.5
-- 			end
-- 		end
-- 	end
-- end

function this:GetImg()
    return self.data.data.img
end

-- 家具数量
function this:GetFurnitureNum()
    local cur = 0
    local furnitureDatas = self:GetFurnitures()
    for i, v in pairs(furnitureDatas) do
        cur = cur + 1
    end
    local lvCfg = self:GetLvCfg()
    return cur, lvCfg.limit
end

-- 场景key
function this:GetSceneKey()
    return "Dorm"
end

----------------------------------------队伍预设------------------------------------------
-- 当前使用的预设队伍id（默认1）
function this:GetCurPresetId()
    return 1
end

function this:GetCfgIDIndex()
    return self.cfgID, self.index
end

-- 是仅摆设的房间
function this:IsOnlyShow()
    return self:GetIndexCfg().onlyShow
end

-- 宠物id 
function this:GetRoles_pet()
    return self.data.data.petIds or {}
end

function this:GetNum_pet()
    local cur = #self:GetRoles_pet() or 0
    return cur, self:GetMaxNum_pet()
end

function this:GetRoleInfos_pet()
    local roleInfos = {}
    local roles = self:GetRoles_pet()
    local max = self:GetMaxNum_pet()
    for i = 1, max do
        local _id = i <= #roles and roles[i] or nil
        table.insert(roleInfos, {
            data = _id,
            curLv = 1,
            openLv = 1
        })
    end
    return roleInfos
end

function this:GetMaxNum_pet()
    return 5
end

return this
