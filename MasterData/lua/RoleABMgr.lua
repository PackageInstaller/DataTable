-- 角色（img,spine）资源关界面清理工具
local this = MgrRegister("RoleABMgr")

function this:Init()
    self:Clear()
end

function this:Clear()
    self.abs = {} -- {abName:{viewName1 =1,viewName2 =1..},abName:{viewName1 =1,viewName2 =1..}...}
    self.removeABNames = {} -- 待移除的ab
    self.removeLimit = 10 -- 上限缓存6个
end

function this:ChangeByIDs(viewName, modelIDs)
    local abNames = {}
    for k, v in ipairs(modelIDs) do
        self:SetABNameByID(v, abNames)
    end
    self:ChangeByABNames(viewName, abNames)
end

-- 默认是替换
function this:ChangeByABNames(viewName, abNames)
    for k, v in pairs(self.abs) do
        if (v[viewName] == 1) then
            v[viewName] = nil
        end
    end
    --
    for k, v in ipairs(abNames) do
        if (self.abs[v]) then
            self.abs[v][viewName] = 1
        else
            local tab = {}
            tab[viewName] = 1
            self.abs[v] = tab
        end
    end
    -- 
    self:ToRelease()
end

-- 清除某界面的缓存的ab,并记录下来
function this:CheckRemoveAB(viewName)
    for k, v in pairs(self.abs) do
        if (v[viewName] == 1) then
            v[viewName] = nil
        end
    end
    self:ToRelease()
end

-- 释放缓存的ab
function this:ToRelease()
    local noHadNames = {}
    for k, v in pairs(self.abs) do
        local isHad = false
        for p, q in pairs(v) do
            isHad = true
            break
        end
        if (not isHad) then
            noHadNames[k] = 1
            self.removeABNames[k] = 1
        end
    end
    for k, v in pairs(noHadNames) do
        self.abs[k] = nil
    end
    --
    for k, v in pairs(self.abs) do
        self.removeABNames[k] = nil
    end
    local removeABNames = {}
    for k, v in pairs(self.removeABNames) do
        table.insert(removeABNames, string.lower(k))
    end
    if (#removeABNames >= self.removeLimit) then
        self.removeABNames = {}
        ReleaseMgr:ApplyRelease(removeABNames)
    end
end

function this:SetABNameByID(modelID, tabs)
    if (modelID and modelID ~= 0) then
        local cfgModel = nil
        if (modelID > 10000) then
            cfgModel = Cfgs.character:GetByID(modelID)
            table.insert(tabs, "textures_bigs_character_" .. cfgModel.img)
        else
            cfgModel = Cfgs.CfgArchiveMultiPicture:GetByID(modelID)
            table.insert(tabs, "textures_bigs_uis_multiimg_" .. cfgModel.img)
        end
        if (cfgModel.l2dName) then
            table.insert(tabs, "prefabs_spine_" .. cfgModel.l2dName)
        end
    end
    return tabs
end

return this
