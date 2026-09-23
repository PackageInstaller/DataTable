ABMgr = oo.class();

local this = ABMgr;
--通用界面相关的AB资源不被删除，需要手动注册、移除
-- this.protectABList = {}
--MenuView相关的AB资源不被删除，每次直接全部替换
this.protectAB_MajorRoleList = {}
--其他界面通用的AB资源不被删除
this.protectAB_List = {}
--记录的AB列表，由每个页面自己维护
this.recordAB_List = {}
--记录的需要被忽略AB列表，由每个页面自己维护
this.recordAB_List = {}

function this:RefreshMajorRoleList(_abList)
    this.protectAB_MajorRoleList = _abList == nil and this.protectAB_MajorRoleList or _abList
    -- LogError(_abList);    
end

function this:RefreshProtectABList(viewName,_abList)
    this.protectAB_List = this.protectAB_List == nil and {} or this.protectAB_List
    _abList = _abList == nil and {} or _abList
    this.protectAB_List[viewName] = _abList
    -- LogError(_abList);    
end

function this:GetProtectABListByViewName(viewName)
    return this.protectAB_List[viewName] == nil and {} or this.protectAB_List[viewName]
    -- LogError(_abList);    
end
-- function this:RegistProtectAB(cfgModel)
--     if cfgModel ~= nil then
--         local _abName = this:GetABName(cfgModel)
--         table.insert(this.protectABList,_abName)
--     end    
-- end

-- function this:RemoveProtectAB(cfgModel)
--     local _abName = this:GetABName(cfgModel)
--     if _abName ~= nil then
--         local _index = this:CheckTableContain(this.protectABList,_abName)
--         if _index > 0 then
--             table.remove(this.protectABList,_index)
--         end
--     end    
-- end
function this:ClearRecordsWithViewName(viewName)
    this.recordAB_List[viewName] = nil
end
function this:RecordABWithModelIDInto(viewName, _modelID)   
    local recordList = {}
    if this.recordAB_List[viewName] then
        recordList = this.recordAB_List[viewName]
    end

    local _abNameArray = this:GetABNameArrayWithID(_modelID)
    local abMemorys = nil
    for k, v in pairs(_abNameArray) do
        abMemorys = this:RecordABWithName(v,recordList) 
    end

    this.recordAB_List[viewName] = abMemorys
    return abMemorys
end

function this:RecordABWithModelID(_modelID,recordList)   
    local _abNameArray = this:GetABNameArrayWithID(_modelID)
    local abMemorys = nil
    for k, v in pairs(_abNameArray) do
        abMemorys = this:RecordABWithName(v,recordList) 
    end
    return abMemorys
end

function this:RecordABWithConfigInto(viewName,cfgModel)
    local recordList = {}
    if this.recordAB_List[viewName] then
        recordList = this.recordAB_List[viewName]
    end
    local _abName = this:GetABName(cfgModel)
    local abMemorys = this:RecordABWithName(_abName,recordList) 

    this.recordAB_List[viewName] = abMemorys
    return abMemorys
end
function this:RecordABWithConfig(cfgModel,recordList)    
    local _abName = this:GetABName(cfgModel)
    local abMemorys = this:RecordABWithName(_abName,recordList) 
    return abMemorys
end

function this:RecordABWithName(_abName,recordList)    
    _abName = string.lower(_abName)
    local abMemorys = recordList == nil and {} or recordList
    -- if this:CheckTableContain(abMemorys,_abName) == 0 and this:CheckTableContain(this.protectAB_MajorRoleList,_abName) == 0 then
    if this:CheckTableContain(abMemorys,_abName) == 0 and this:CheckIsProtectAB(_abName) == false then
        table.insert(abMemorys,_abName)        
        -- LogError(_abName)
    end    
    return abMemorys
end

function this:GetABName(cfgModel)    
    local _abName = ""
    local _abType = ""
    if (not cfgModel.l2dName) then
        _abName = cfgModel.img 
        _abType = "img"
    else            
        _abName = cfgModel.l2dName 
        _abType = "l2d"            
    end
    _abName = (_abType == "img" and "textures_bigs_character_" or "prefabs_spine_") .. _abName
    return _abName
end

function this:GetABNameWithID(modelID)
    local abName = ""
    local abType = ""
    if (modelID and modelID ~= 0) then
        local cfgModel = nil
        if (modelID > 10000) then
            cfgModel = Cfgs.character:GetByID(modelID)
        else
            cfgModel = Cfgs.CfgArchiveMultiPicture:GetByID(modelID)
        end

        if (not cfgModel.l2dName) then
            abName = cfgModel.img
            abType = "img"
        else
            abName = cfgModel.l2dName
            abType = "l2d"
        end

        if (modelID > 10000) then
            abName = (abType == "img" and "textures_bigs_character_" or "prefabs_spine_") .. abName
        else
            abName = (abType == "img" and "textures_bigs_uis_multiimg_" or "prefabs_spine_") .. abName
        end
        -- LogError(abName)
    end

    return abName
end

function this:GetABNameArrayWithID(modelID)
    local abNameArray = {}
    local abName = ""
    local abType = ""
    if (modelID and modelID ~= 0) then
        local cfgModel = nil
        if (modelID > 10000) then
            cfgModel = Cfgs.character:GetByID(modelID)
        else
            cfgModel = Cfgs.CfgArchiveMultiPicture:GetByID(modelID)
        end

        if cfgModel.img then
            abName = cfgModel.img
            abType = "img"
            if (modelID > 10000) then
                abName = "textures_bigs_character_" .. abName
            else
                abName = "textures_bigs_uis_multiimg_" .. abName
            end
            table.insert(abNameArray,abName)
        end
        if cfgModel.l2dName then
            abName = cfgModel.l2dName
            abType = "l2d"
            abName = "prefabs_spine_" .. abName
            table.insert(abNameArray,abName)
        end

        -- LogError(abNameArray)
    end

    return abNameArray
end

function this:CheckTableContain(_table,val)
    local _index = 1
    for k, v in pairs(_table) do
        _index = _index + 1
        if v == val then
            return _index
        end
    end
    return 0
end

function this:ReleaseABAutoWithViewName(viewName,protectABList,limitNum)
    local abMemorys = this.recordAB_List[viewName] == nil and {} or this.recordAB_List[viewName]
    protectABList = protectABList == nil and {} or protectABList
    local abList = {}
    limitNum = limitNum == nil and 5 or limitNum
    -- table.insert(abList,abMemorys[1])
    if #abMemorys > limitNum then
        local deleteGoal = #abMemorys - limitNum           
        local deleteNum = 0
        for i = 1, #abMemorys, 1 do
            if this:CheckTableContain(protectABList,abMemorys[i]) == 0 then            
                -- LogError("Auto 移除 " .. abMemorys[i])
                table.insert(abList,string.lower(abMemorys[i]))
                table.remove(abMemorys,i)                 
                deleteNum = deleteNum + 1
            end
            if deleteNum >= deleteGoal then
                break
            end
        end        
    end
    ReleaseMgr:ApplyRelease(abList);            
    -- LogError(abList)    
end
function this:ReleaseABAuto(recordList,protectABList,limitNum)
    local abMemorys = recordList == nil and {} or recordList
    protectABList = protectABList == nil and {} or protectABList
    local abList = {}
    limitNum = limitNum == nil and 5 or limitNum
    -- table.insert(abList,abMemorys[1])
    if #abMemorys > limitNum then
        local deleteGoal = #abMemorys - limitNum           
        local deleteNum = 0
        for i = 1, #abMemorys, 1 do
            if this:CheckTableContain(protectABList,abMemorys[i]) == 0 then            
                -- LogError("Auto 移除 " .. abMemorys[i])
                table.insert(abList,string.lower(abMemorys[i]))
                table.remove(abMemorys,i)                 
                deleteNum = deleteNum + 1
            end
            if deleteNum >= deleteGoal then
                break
            end
        end        
    end
    ReleaseMgr:ApplyRelease(abList);            
    -- LogError(abList)    
end


function this:ReleaseABAllWithViewName(viewName,protectABList)
    local abMemorys = this.recordAB_List[viewName] == nil and {} or this.recordAB_List[viewName]
    protectABList = protectABList == nil and {} or protectABList
    local abList = {}
    for k, v in pairs(abMemorys) do             
        if this:CheckTableContain(protectABList, v) == 0 then            
            -- LogError("All 移除 " .. string.lower(v))
            table.insert(abList,string.lower(v))   
        end
    end
    ReleaseMgr:ApplyRelease(abList);            
    -- LogError(abList)    
end
function this:ReleaseABAll(recordList,protectABList)
    local abMemorys = recordList == nil and {} or recordList
    protectABList = protectABList == nil and {} or protectABList
    local abList = {}
    for k, v in pairs(abMemorys) do             
        if this:CheckTableContain(protectABList, v) == 0 then            
            -- LogError("All 移除 " .. string.lower(v))
            table.insert(abList,string.lower(v))   
        end
    end
    ReleaseMgr:ApplyRelease(abList);            
    -- LogError(abList)    
end

function this:CheckIsProtectAB(_abName)
    local isProtectAB = false
    if this:CheckTableContain(this.protectAB_MajorRoleList,_abName) ~= 0 then
        isProtectAB = true
    end
    for i, v in pairs(this.protectAB_List) do
        if this:CheckTableContain(v,_abName) ~= 0 then
            isProtectAB = true
        end
    end
    return isProtectAB
end
return this;