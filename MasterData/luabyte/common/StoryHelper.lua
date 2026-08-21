StoryHelper = {}

function StoryHelper.GetCnRandomName()
    local nameStr
    local nameCfg = ConfigHelper.GetCfgByLua("name", 1)
    if nameCfg then
        local checkFun = table.isNullOrEmpty
        local namePrefix, nameMid, nameSuffix
        if not checkFun(nameCfg.nameCN1) then
            local index = math.random(1, #nameCfg.nameCN1)
            namePrefix = nameCfg.nameCN1[index]
        end

        if not checkFun(nameCfg.nameCN2) then
            local index = math.random(1, #nameCfg.nameCN2)
            nameMid = nameCfg.nameCN2[index]
        end

        if not checkFun(nameCfg.nameCN3) then
            local index = math.random(1, #nameCfg.nameCN3)
            nameSuffix = nameCfg.nameCN3[index]
        end

        if namePrefix and nameMid and nameSuffix then
            nameStr = namePrefix .. nameMid .. nameSuffix
        end
    else
        Logger.LogError("name is nil, id = 1")
    end
    return nameStr
end

function StoryHelper.GetEnRandomName()
    local nameStr
    local nameCfg = ConfigHelper.GetCfgByLua("name", 1)
    if nameCfg then
        local namePrefix, nameSuffix
        local checkFun = table.isNullOrEmpty
        if not checkFun(nameCfg.nameEU1) then
            local index = math.random(1, #nameCfg.nameEU1)
            namePrefix = nameCfg.nameEU1[index]
        end

        if not checkFun(nameCfg.nameEU2) then
            local index = math.random(1, #nameCfg.nameEU2)
            nameSuffix = nameCfg.nameEU2[index]
        end

        if namePrefix and nameSuffix then
            nameStr = namePrefix .. nameSuffix
        end
    else
        Logger.LogError("name is nil, id = 1")
    end
    return nameStr
end

function StoryHelper.SetActive(comp, active)
    local isActive = comp:IsActiveInHierarchy()
    if not active and isActive then
        comp:SetActive(active)
    elseif active and not isActive then
        comp:SetActive(active)
    end
end

function StoryHelper.IsFirstStory(storyCfg)
    if not storyCfg then return false end
    return storyCfg.stepId == 1
end

function StoryHelper.GetPauseDuration(storyCfg)
    local checkFun = table.isNullOrEmpty
    local checkMax = table.maxValue
    local tInsert = table.insert
    local data, fadeInDur = {}, storyCfg.roleFadeInDuration
    if not checkFun(fadeInDur) then tInsert(data, checkMax(fadeInDur)) end

    local fadeOutDur = storyCfg.roleFadeOutDuration
    if not checkFun(fadeOutDur) then tInsert(data, checkMax(fadeOutDur)) end

    local roleMove1 = storyCfg.roleMove1 or {}
    local value1 = roleMove1[3] or 0
    if value1 > 0 then tInsert(data, value1) end

    local roleMove2 = storyCfg.roleMove2 or {}
    local value2 = roleMove2[3] or 0
    if value2 > 0 then tInsert(data, value2) end

    local roleMove3 = storyCfg.roleMove3 or {}
    local value3 = roleMove3[3] or 0
    if value3 > 0 then tInsert(data, value3) end

    local scaleDur = storyCfg.roleScaleDuration
    if not checkFun(scaleDur) then tInsert(data, checkMax(scaleDur)) end

    local rotateDur = storyCfg.roleRotateDuration
    if not checkFun(rotateDur) then tInsert(data, checkMax(rotateDur)) end

    local flipDur = storyCfg.roleFlipDuration
    if not checkFun(flipDur) then tInsert(data, checkMax(flipDur)) end

    local blackDur = storyCfg.roleBlackDuration
    if not checkFun(blackDur) then tInsert(data, checkMax(blackDur)) end

    local shakeParam = storyCfg.shakeParam
    if not checkFun(shakeParam) then
        local shakeData = {}
        for i = 1, #shakeParam / 3 do
            local value = shakeParam[i * 3]
            if value > 0 then tInsert(shakeData, value) end
        end

        if not checkFun(shakeData) then
            tInsert(data, checkMax(shakeData))
        end
    end

    local maxDuration, blinkDuration = 0, storyCfg.blinkDuration
    for _, value in ipairs(blinkDuration) do
        if value > 0 then maxDuration = maxDuration + value end
    end
    if maxDuration > 0 then tInsert(data, maxDuration) end

    local focusParam = storyCfg.focusParam
    if not checkFun(focusParam) then
        local value = focusParam[4] or 0
        if value > 0 then tInsert(data, value) end
    end

    local duration = 0.01
    if not checkFun(data) then
        duration = duration + checkMax(data) / 1000
    end

    local pauseDur = storyCfg.pauseDuration
    if pauseDur > 0 then duration = duration + pauseDur / 1000 end
    return duration
end

-- 剧情对话时间
function StoryHelper.GetStoryDialogueTime(roleTalk)
    if roleTalk <= 0 then return 0 end

    local content = ConfigHelper.GetLocalStringByPlayerName(roleTalk)
    local trimStr = string.replaceRichText(content)
    return string.utf8len(trimStr) / StoryDataMgr:GetInstance():GetSpeed()
end
