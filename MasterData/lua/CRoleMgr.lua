local CRoleSortUtil = require "CRoleSortUtil"
local CRoleInfo = require "CRoleInfo"
local CRoleTCInfo = require "CRoleTCInfo"
local CRoleStoryInfo = require "CRoleStoryInfo"

local this = MgrRegister("CRoleMgr")

function this:Init()
    self:SetSortDatas()

    self.datas = {}
    self.count = 0
    self.max = 0
    local _all = Cfgs.CfgCardRole:GetAll()
    for i, v in pairs(_all) do
        if (v.bShowInAltas) then
            if v.sShowTime then
                local time = TimeUtil:GetTimeStampBySplit(v.sShowTime)
                if TimeUtil:GetTime() >= time then
                    self.max = self.max + 1
                end
            else
                self.max = self.max + 1
            end
        end
    end
    PlayerProto:GetCardRole()
end

function this:Clear()
    self.datas = {}
end

function this:SetSortDatas()
    self.curFiltrateType = {
        ["RoleTeam"] = {0}
    }
end

function this:AddCardRole(roles)
    if (roles) then
        for i, v in ipairs(roles) do
            if (self.datas[v.id]) then
                self:UpdateOne(v)
            else
                if (Cfgs.CfgCardRole:GetByID(v.id)) then
                    local info = CRoleInfo.New()
                    info:InitData(v, true)
                    -- info:SetRealCard()
                    self.datas[v.id] = info
                    if (info:IsShowInAltas()) then
                        self.count = self.count + 1
                    end
                end
            end
        end
        EventMgr.Dispatch(EventType.CRole_Add)

        -- self:CheckNewSkin()
    end
end
-- -- 新皮肤红点 
-- function this:CheckNewSkin()
--     local num = nil
--     local datas = self:GetDatas()
--     for k, v in pairs(datas) do
--         if (v:CheckHadNewSkin()) then
--             num = 1
--             break
--         end
--     end
--     RedPointMgr:UpdateData(RedPointType.CRoleSkin, num)
-- end

function this:GetCRoleInfo(sCardRole)
    local info = CRoleInfo.New()
    info:InitData(sCardRole)
    return info
end

function this:UpdateCardRole(proto)
    if (proto.roles) then
        for i, v in ipairs(proto.roles) do
            self:UpdateOne(v)
        end
    end
    if (proto.is_finish) then
        EventMgr.Dispatch(EventType.CRole_Update)
    end
end

function this:UpdateOne(v)
    local info = self.datas[v.id]
    if (info and info.data) then
        for n, m in pairs(v.data) do
            info.data[n] = m
        end
    end
end

function this:GetData(id)
    if (not id) then
        LogError("获取角色失败,id为空")
        return
    end
    local data = self.datas[id]
    if (not data) then
        --LogError("无法获取角色数据,id:" .. id)
        return
    end
    return data
end

function this:GetFakeData(id, _data)
    local cfg = Cfgs.CfgCardRole:GetByID(id)
    if (cfg) then
        local info = CRoleInfo.New()
        info:InitData({
            id = cfg.id,
            data = _data or {}
        })
        return info
    end
    return nil
end

-- 通过模型表id获取角色数据
function this:GetCRoleByModelID(modelID)
    local cfg = Cfgs.character:GetByID(modelID)
    return self:GetData(cfg.role_id)
end

function this:GetCfgDatas()
    local all = {}
    local _all = Cfgs.CfgCardRole:GetAll()
    for i, v in pairs(_all) do
        table.insert(all, v)
    end
    -- table.sort(all, function(a, b)
    -- 	return a.index < b.index
    -- end)
    return all
end

-- 字典
function this:GetDatas()
    return self.datas
end

-- 数组
function this:GetArr()
    local arr = {}
    for i, v in pairs(self.datas) do
        table.insert(arr, v)
    end
    return arr
end

-- 已排序的arr
function this:SortArr()
    return CRoleSortUtil:SortByCondition(self:GetArr())
end

-- 筛选方式
function this:SGetCurFiltrateType(value)
    if (value) then
        self.curFiltrateType = value
    end
    return self.curFiltrateType
end

-- 台词
function this:GetScriptCfg(roleID, iconID)
    local roleData = CRoleMgr:GetData(roleID)
    local roleLv = roleData and roleData:GetLv() or 1
    local characterCfg = Cfgs.character:GetByID(iconID)
    local voiceID = characterCfg and characterCfg.voiceID or nil
    if (voiceID) then
        local info = CRoleTCInfo.New()
        info:InitData(voiceID, roleLv, roleID)
        return info or nil
    end
    return nil
end

-- 音效集合(包含未解锁的)
function this:GetScriptCfgs(role_id, modelId)
    local groups = {}
    local cfg_character = Cfgs.character:GetByID(modelId)
    local voiceID = cfg_character and cfg_character.voiceID or nil
    local _groups = Cfgs.Sound:GetGroup(voiceID)
    local data = self:GetData(role_id)
    if (data and _groups) then
        for i, v in ipairs(_groups) do
            -- if (data:CheckAudioIsGet(v.id)) then -- 等级已到的或者已播放的
            if v.bookDisplay then
                table.insert(groups, v)
            end
            -- end
        end
    end

    return groups
end

-- 角色音效集合(包含未解锁的和皮肤) --isHave:已拥有
function this:GetRoleScriptCfgs(role_id, isHave)
    local groups = {}
    local data = self:GetData(role_id)
    if data then
        local skins = RoleSkinMgr:GetDatas(role_id)
        local modelIds = {}
        if skins then
            for _, skin in pairs(skins) do
                if isHave then
                    if skin:CheckCanUse() then
                        table.insert(modelIds, skin:GetSkinID())
                    end
                else
                    table.insert(modelIds, skin:GetSkinID())
                end
            end
        end

        if #modelIds > 0 then
            table.sort(modelIds, function(a, b)
                return a < b
            end)
            local ids = {}
            for i, modelId in ipairs(modelIds) do
                local cfg_character = Cfgs.character:GetByID(modelId)
                if cfg_character and cfg_character.voiceID and
                    (not cfg_character.skinType or cfg_character.skinType ~= 2) then
                    local _groups = Cfgs.Sound:GetGroup(cfg_character.voiceID)
                    if _groups and not ids[cfg_character.voiceID] then
                        for i, v in ipairs(_groups) do
                            if v.bookDisplay then
                                table.insert(groups, v)
                            end
                        end
                    end
                    ids[cfg_character.voiceID] = 1
                end
            end
        end
    end
    return groups
end

-- 剧情 
function this:GetStory(cRoleId, moduleId)
    local datas = {}
    local allCfg = Cfgs.CfgCardRoleStory:GetAll()
    local cfgs = allCfg[cRoleId] and allCfg[cRoleId].infos or nil
    if (cfgs) then
        for i, v in ipairs(cfgs) do
            if (v.moduleId == moduleId) then
                local info = CRoleStoryInfo.New()
                info:InitData(cRoleId, v)
                table.insert(datas, info)
            end
        end
    end
    return datas
end

-- cg
function this:GetCG(cRoleId)
    local allCfg = Cfgs.CfgCardRoleCG:GetAll()
    local cfgs = allCfg[cRoleId] and allCfg[cRoleId].infos or nil
    return cfgs or {}
end

-- 不显示在图鉴的和不到开发时间的不计算 
function this:GetCount()
    return self.count, self.max
end

-- 记录已播放(填了等级的不计入)
function this:AddRoleAudioById(audioId)
    local cfg_Sound = Cfgs.Sound:GetByID(audioId)
    if (cfg_Sound and cfg_Sound.openLv == nil and cfg_Sound.model) then
        local cfg_character = Cfgs.character:GetByID(cfg_Sound.model)
        local role_id = cfg_character and cfg_character.role_id or nil
        if (role_id) then
            local data = self:GetData(role_id)
            if (data) then
                local b = data:CheckAudioIsGet(audioId)
                if (not b) then
                    PlayerProto:AddRoleAudio(role_id, audioId)
                end
            end
        end
    end
end

-- 角色最大等级
function this:GetCRoleMaxLv()
    if (not self.cRoleMaxLv) then
        local cfgs = Cfgs.CfgCardRoleUpgrade:GetAll()
        self.cRoleMaxLv = #cfgs
    end
    return self.cRoleMaxLv
end

--更换队长，机神(一样的id，不用删)
function this:ChangeLeader(ocfgid)
    for k, v in pairs(ocfgid) do
        local cfg = Cfgs.CardData:GetByID(v)
        self.datas[cfg.role_id] = nil
    end
end

----------------------------------------看板位置------------------------------------------------------
--[[
-- {type,id,x,y,scale,l2d} a：1角色,2多人插图  l2d：bool
function this:GetCacheData(_type, _id)
    local cache = FileUtil.LoadByPath("kanban")
    if (cache and cache.type == _type and cache.id == _id) then
        return cache
    end
    return nil
end

function this:SetCacheData(_cache)
    FileUtil.SaveToFile("kanban", _cache)
end

function this:SaveCacheData(panelID, modelID, isL2D, _x, _y, _z)
    local _type = panelID == nil and 1 or 2
    local _id = panelID == nil and modelID or panelID
    CRoleMgr:SetCacheData({
        type = _type,
        id = _id,
        x = _x or 0,
        y = _y or 0,
        scale = _z or 1,
        l2d = isL2D
    })
end

function this:RemoveData(id)
    self.datas[id] = nil 
end
]]
----------------------------------------多人插图------------------------------------------------------

return this
