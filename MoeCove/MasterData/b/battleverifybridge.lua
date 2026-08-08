-- BattleVerifyBridge.lua
-- 由编辑器 BattleVerifyToolWindow 调用
-- 方法: GenerateVerifyData(jsonPayload)  -> 返回 JSON 字符串
-- 约定：jsonPayload 内含 levelId, randomSeed, runFullVerify, heroes (数组)

local cjson = require "cjson"
local BattleVerifyReplayer = require "BattleVerifyReplayer"

---@class BV_HeroInput
---@field cid integer
---@field level integer
---@field star integer
---@field hp integer
---@field armor integer
---@field evade integer
---@field bombard integer
---@field torpedo integer
---@field lucky integer
---@field airdefense integer
---@field weaponRatio integer
---@field load integer
---@field allDmg integer
---@field equipSkin integer
---@field equippedSkills string  -- 逗号分隔
---@field passiveSkills string   -- 逗号分隔

local M = {}

local function buildReplayResponse(ok, data)
    if ok and type(data) == "table" then
        local stateJson = cjson.encode(data[1] or {})
        local displayText = data[2] or ""
        return stateJson, displayText
    end

    local errText = "未知错误"
    if type(data) == "table" then
        errText = data.err or errText
        if data.detail then
            errText = errText .. ": " .. tostring(data.detail)
        end
    elseif type(data) == "string" then
        errText = data
    end
    return cjson.encode({
        filePath = "",
        levelId = 0,
        heroCids = {},
        totalOrderCount = 0,
        currentOrderIndex = 0,
        nextOrderIndex = 0,
        formationReady = false,
        started = false,
        finished = false,
        battleResultText = "未加载",
        lastActionText = errText,
    }), errText
end

local function splitToIntArray(str)
    if not str or str == '' then return {} end
    local t = {}
    for v in string.gmatch(str, "[^,]+") do
        local num = tonumber(v)
        if num then t[#t+1] = num end
    end
    return t
end

local function buildHeroInfo(input)
    local h = {
        id = input.cid,
        name = tostring(input.cid),
        level = input.level or 1,
        star = input.star or 1,
        hp = input.hp or 0,
        load = input.load or 0,
        exp = input.exp or 0,
        getTime = input.getTime or 0,
        isInHome = input.isInHome or false,
        equipSkin = input.equipSkin or 0,
        carryEquip = {},
        talentTreeList = {},
        talentTreeStage = {},
        EquippedSkillList = splitToIntArray(input.equippedSkills),
        carryWeapon = {},
        armor = input.armor or 0,
        evade = input.evade or 0,
        bombard = input.bombard or 0,
        torpedo = input.torpedo or 0,
        lucky = input.lucky or 0,
        airdefense = input.airdefense or 0,
        effectiveSkill = splitToIntArray(input.passiveSkills),
        weaponRatio = 0,
        allDmg = 0,
    }
    return h
end

-- 将伤害日志与Buff快照格式化为可读文本
---@param damageLogs ReportRoleDoSkillData[]?
local function formatLogsText(damageLogs)
    local lines = {}
    local function push(s) lines[#lines+1] = s end
    push(string.format("==== 技能伤害日志 (%s) ====", type(damageLogs)))
    if type(damageLogs) == 'table' then
        for i, d in ipairs(damageLogs) do
            local sid = d.skillId or "?"
            local src = d.cid or "?"
            local tgt = d.targetCId or "?"
            local dmg = d.damageValue or 0
            local crit = (d.isCrit == true) and "暴击了" or "没暴击"
            local targetCid = d.targetCId or "?"
            push(string.format("[%d] 施放技能 %s 对 %s 造成 %d 点伤害 (%s) (sourceCid=%s targetCid=%s)", i, tostring(sid), tostring(tgt), tonumber(dmg), crit, tostring(src), tostring(targetCid)))
            -- 列出触发的Buff
            local sourceBuffList = ""
            for _, buffId in ipairs(d.sourceBuffIdList) do
                sourceBuffList = sourceBuffList .. tostring(buffId) .. ","
            end
            local targetBuffList = ""
            for _, buffId in ipairs(d.targetBuffIdList) do
                targetBuffList = targetBuffList .. tostring(buffId) .. ","
            end
            if sourceBuffList ~= "" then
                push(string.format("触发了技能施放者Buff: %s", sourceBuffList))
            end
            if targetBuffList ~= "" then
                push(string.format("触发了技能目标者Buff: %s", targetBuffList))
            end
            push("")
        end
    else
        push("(无结构化伤害数据，原始simpleVerifyData已保留)")
    end
    return table.concat(lines, "\n")
end

-- 生成 BattleStartInfo
local function buildBattleStartInfo(payload)
    local heroInfoMap = {}
    local formation = {}
    for i, heroIn in ipairs(payload.heroes) do
        local info = buildHeroInfo(heroIn)
        heroInfoMap[info.id] = info
        formation[#formation+1] = info.id
    end
    local levelInfo = {
        id = payload.levelId or 0,
        star = 0,
        state = 0,
        completeNum = 0,
        battleNum = 0,
        achieveList = {},
    }
    ---@type BattleStartInfo
    local bsi = {
        level = payload.levelId,
        randomseed = payload.randomSeed,
        heroInfoMap = heroInfoMap,
        weaponCidMap = {},
        levelInfo = levelInfo,
        formation = formation,
        weeklyBossPveLevelId = 0,
        weeklyBossTagList = {},
    }
    return bsi
end

---@class Skill

-- 执行一次验证
local function runVerify(startInfo, runFullVerify)
    local battleMgr = BattleCore:getBattleMgr()
    if not battleMgr then
        return { error = 'BattleManager not ready' }
    end
    -- 启动本地战斗
    local result, orderReport, simpleVerifyData = battleMgr:LocalStartBattle(startInfo.level, startInfo, runFullVerify)
    return {
        result = result,
        orderReport = orderReport,
        simpleVerifyData = simpleVerifyData,
        battleStartInfo = startInfo,
    }
end

local _editorInited = false

local function ensureBattleEnv()
    if _editorInited then return true end
    -- 在编辑器未运行时尝试最小初始化
    if (not BattleCore) or (not BattleCore.getBattleMgr) then
        pcall(require, 'BattleCore')
    end
    local okBM, BattleManagerMod = pcall(require, 'BattleManager')
    local battleMgr = nil
    if BattleCore and BattleCore.getBattleMgr then
        pcall(function()
            battleMgr = BattleCore:getBattleMgr()
        end)
    end
    if (not battleMgr) and okBM and BattleManagerMod and BattleManagerMod.instance then
        -- 实例化并最小 init（BattleManager:init 里可能依赖外围，这里容错）
        pcall(function()
            battleMgr = BattleManagerMod.instance()
            if battleMgr and battleMgr.init then
                battleMgr:init()
            end
        end)
    end
    _editorInited = battleMgr ~= nil
    return _editorInited
end

-- 入口
function M.GenerateVerifyData(jsonPayload)
    if not ensureBattleEnv() then
        return cjson.encode({ error = 'battle env init failed (editor). 请确认相关Lua文件可require且无语法错误' })
    end
    local ok, payload = pcall(cjson.decode, jsonPayload)
    if not ok then
        return cjson.encode({ error = 'decode payload failed' })
    end
    local randomSeed = payload.randomSeed
    if not randomSeed or randomSeed == 0 then
        randomSeed = math.random(1, 2147483646)
        payload.randomSeed = randomSeed
    end
    local startInfo = buildBattleStartInfo(payload)
    local verifyRet = runVerify(startInfo, payload.runFullVerify)
    -- 解析技能伤害日志(simpleVerifyData)
    local damageLogs = nil
    if verifyRet and verifyRet.simpleVerifyData then
        local ok2, decoded = pcall(cjson.decode, verifyRet.simpleVerifyData)
        if ok2 then
            damageLogs = decoded
        end
    end
    local logsText = formatLogsText(damageLogs)
    return { cjson.encode(verifyRet), logsText }
end

function M.LoadReplayFromFile(filePath)
    local ok, state, orderText = BattleVerifyReplayer.loadReplaySessionFromFile(filePath)
    if ok then
        return buildReplayResponse(true, { state, orderText })
    end
    return buildReplayResponse(false, state)
end

function M.StartReplayBattle()
    local ok, state, orderText = BattleVerifyReplayer.startReplaySession()
    if ok then
        return buildReplayResponse(true, { state, orderText })
    end
    return buildReplayResponse(false, state)
end

function M.PlayNextReplayOrder()
    local ok, state, orderText = BattleVerifyReplayer.playNextReplayOrder()
    if ok then
        return buildReplayResponse(true, { state, orderText })
    end
    return buildReplayResponse(false, state)
end

function M.GetReplayState()
    local state, orderText = BattleVerifyReplayer.getReplaySessionState()
    return buildReplayResponse(true, { state, orderText })
end

return M
