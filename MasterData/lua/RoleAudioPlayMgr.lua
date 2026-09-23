-- 角色音效播放管理
-- 对应表: s-声音
--[[	RoleAudioType = {}
RoleAudioType.CrossCore = 1 --游戏开始（标题时语音）
RoleAudioType.get = 2 --获得（获得该角色时的语音）
RoleAudioType.enterLevel = 3 --出击（进入关卡时，队长播放的语音）
RoleAudioType.upgrade = 4 --强化（强化角色时的语音）
RoleAudioType.perBreak = 5 --突破（角色突破时的语音）
RoleAudioType.maxBreak = 6 --最终突破（角色最终突破的语音）
RoleAudioType.login = 7 --看板（登录游戏时，看板的语音）
RoleAudioType.mvp = 8 --战斗胜利时，MVP角色的语音
RoleAudioType.fail = 9 --战斗失败时，角色的语音
RoleAudioType.touch = 10--接触时的语音
RoleAudioType.sprecialTouch = 11 --特殊部位的接触语音
RoleAudioType.levelBack = 12 --归来
RoleAudioType.expeditionBack = 13 --远征归来
RoleAudioType.allocation = 14 -- 配置设施
RoleAudioType.allocationTouch = 15 --设施接触
RoleAudioType.birthday = 16 -- 角色生日时
RoleAudioType.shop = 17 -- 商店语音（在商店界面，点击看板时的语音）
]] local this = MgrRegister("RoleAudioPlayMgr")

function this:Init()
    self:Clear()
end

function this:Clear()
    curEndCB = nil
    isPlaying = false
end

-- ==============================--
-- desc:通过类型播放语音
-- time:2021-06-04 03:34:24
-- @model: 模型id
-- @roleAudioType: 音效类型
-- @type_child: 子类型 为nil时随机roleAudioType中的一个
-- @playCB: 开始播放时回调
-- @endCB: 播放结束回调
-- @return 
-- ==============================--
function this:PlayByType(modelId, roleAudioType, type_child, playCB, endCB, _cfg)
    local cfg = _cfg == nil and Cfgs.Sound or _cfg
    local lv = modelId ~= nil and self:GetCRoleLv(modelId) or 1
    local cfg_character = Cfgs.character:GetByID(modelId)
    local voiceID = cfg_character and cfg_character.voiceID or nil
    if (voiceID) then
        -- 底
        local voiceID1 = cfg_character and cfg_character.base_voiceID or nil
        local groups1 = voiceID1 ~= nil and cfg:GetGroup(voiceID1) or nil
        -- 上层(如果有底，则)
        local groups2 = cfg:GetGroup(voiceID) or {}
        local groups = self:GetCorrectGroup(groups1, groups2)
        -- local groups = cfg:GetGroup(voiceID) or {}
        local selectCfgs = {}
        local count = 0
        for i, v in ipairs(groups) do
            if (v.type and v.type == roleAudioType and self:CheckOpen(v, lv)) then
                if (type_child) then
                    if (v.type_child) then
                        for k, m in pairs(v.type_child) do
                            if (m == type_child) then
                                count = count + 1
                                table.insert(selectCfgs, v)
                                break
                            end
                        end
                    end
                else
                    count = count + 1
                    table.insert(selectCfgs, v)
                end
            end
        end
        if (count > 0) then
            local index = 1
            if (#selectCfgs > 0) then
                index = CSAPI.RandomInt(1, #selectCfgs)
            end
            local cfg_Sound = selectCfgs[index]
            self:Play(cfg_Sound, playCB, endCB)
        end
    end
end

function this:CheckIsSet(modelId, roleAudioType, type_child, _cfg)
    local cfg = _cfg == nil and Cfgs.Sound or _cfg
    local lv = modelId ~= nil and self:GetCRoleLv(modelId) or 1
    local cfg_character = Cfgs.character:GetByID(modelId)
    local voiceID = cfg_character and cfg_character.voiceID or nil
    if (voiceID) then
        local groups = cfg:GetGroup(voiceID) or {}
        local selectCfgs = {}
        local count = 0
        for i, v in ipairs(groups) do
            if (v.type and v.type == roleAudioType and self:CheckOpen(v, lv)) then
                if (type_child and v.type_child) then
                    for k, m in pairs(v.type_child) do
                        if (m == type_child) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

-- ==============================--
-- desc:通过表id播放语音
-- time:2021-06-05 11:01:09
-- @modelId:
-- @id:
-- @playCB:
-- @endCB:
-- @return 
-- ==============================--
function this:PlayById(modelId, id, playCB, endCB, _cfg)
    local cfg = _cfg == nil and Cfgs.Sound or _cfg
    local lv = modelId ~= nil and self:GetCRoleLv(modelId) or 1
    local cfg_Sound = cfg:GetByID(id)
    if (cfg_Sound and self:CheckOpen(cfg_Sound, lv)) then
        self:Play(cfg_Sound, playCB, endCB)
    end
end

-- ==============================--
-- desc:播放
-- time:2021-06-04 04:32:26
-- @cfg:
-- @playCB:
-- @endCB:
-- @return 
-- ==============================--
function this:Play(cfg, playCB, endCB)
    local isJP = SettingMgr:CheckIsJP()
    if ((isJP and cfg.script1_display == 1) or cfg.script2_display == 1) then
        Log("改音效已屏蔽？：" .. cfg.name)
        return -- 屏蔽了音效
    end

    if (cfg and cfg.cue_sheet and cfg.cue_name) then
        if (playCB) then
            playCB(cfg)
        end
        curEndCB = endCB
        isPlaying = true
        CRoleMgr:AddRoleAudioById(cfg.id)
        CSAPI.PlaySound(cfg.cue_sheet, cfg.cue_name, false, true, "feature", nil, function()
            if (curEndCB) then
                curEndCB()
            end
            isPlaying = false
        end)
    end
end

-- ==============================--
-- desc:取消播放
-- time:2021-06-04 04:31:24
-- @return 
-- ==============================--
function this:StopSound()
    CSAPI.PlaySound("", "", true, false, "feature", 0)
    if (curEndCB) then
        curEndCB()
    end
    curEndCB = nil
    isPlaying = false
end

-- ==============================--
-- desc:通过模型表id获取角色当前等级
-- time:2021-06-05 10:29:05
-- @modelId:
-- @return 
-- ==============================--
function this:GetCRoleLv(_modelId)
    local lv = 1
    local cfg_character = _modelId ~= nil and Cfgs.character:GetByID(_modelId) or nil
    local roleId = cfg_character and cfg_character.role_id or nil
    local cRoleInfo = roleId and CRoleMgr:GetData(roleId) or nil
    if (cRoleInfo) then
        lv = cRoleInfo:GetLv()
    end
    return lv
end

-- ==============================--
-- desc:是否有音效正在播放
-- time:2021-06-05 11:07:45
-- @return 
-- ==============================--
function this:GetIsPlaying()
    return isPlaying
end

-- 音效是否可用
function this:CheckAndioIsOpen(modelId, id, _cfg)
    local cfg = _cfg == nil and Cfgs.Sound or _cfg
    local lv = modelId ~= nil and self:GetCRoleLv(modelId) or 1
    local cfg_Sound = cfg:GetByID(id)
    if (cfg_Sound and self:CheckOpen(cfg_Sound, lv)) then
        return true
    end
    return false
end

-- 上层音效覆盖底层音效（有则覆盖，没则保留）
function this:GetCorrectGroup(groups1, groups2)
    if (groups1 == nil) then
        return groups2
    end
    local groups = {}
    local types = {}
    for k, v in pairs(groups2) do
        if (v.type) then
            if (v.type_child) then
                types[v.type] = types[v.type] or {}
                types[v.type][v.type_child[1]] = 1
            else
                if (not types[v.type]) then
                    types[v.type] = {}
                end
            end
        end
    end
    for k, v in pairs(groups1) do
        if (v.type == nil or not types[v.type] or (v.type_child and types[v.type][v.type_child[1]] == nil)) then
            table.insert(groups, v)
        end
    end
    for k, v in pairs(groups2) do
        table.insert(groups, v)
    end
    return groups
end

function this:CheckOpen(childCfg, lv)
    if (childCfg.openModel and not RoleSkinMgr:CheckModelsIsGet(childCfg.openModel)) then
        return false
    end
    if (childCfg.openLv and childCfg.openLv > lv) then
        return false
    end
    return true
end

return this
