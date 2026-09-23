local stateStrs = {10403, 10404, 10405}
local isSelect = false
local curState = 1

local runTime = false
local timer = 0
selectCardDatas = nil -- 当前选择的队伍
local allIsEnough = false -- 所有条件均满足

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _buildData)
    buildData = _buildData
    data = _data
    running = buildData:GetData().running
    runTime = false

    -- 数据不同 默认不选择
    if (oldIndex and oldIndex ~= data:GetSortIndex()) then
        isSelect = false
    end
    oldIndex = data:GetSortIndex()

    -- 开始或完成
    if (data:GetState() == 2 or data:GetState() == 3) then
        isSelect = false
    end

    RefreshPanel()
end

function Update()
    if (running and runTime) then
        timer = timer - Time.deltaTime
        if (timer < 0) then
            timer = 0.1
            if (curState == 1) then
                SetLimitTime()
            else
                SetTime()
            end
        end
    end
end

-- 反选
function SetUnSelect()
    if (isSelect) then
        isSelect = false
        RefreshPanel()
    end
end

function RefreshPanel()
    curState = data:GetState()
    -- panel1
    SetPanel1()
    -- panel2
    CSAPI.SetGOActive(panel2, isSelect)
    if (not isSelect) then
        selectCardDatas = nil
    else
        SetPanel2()
    end

    -- white
    CSAPI.SetGOActive(white, isSelect)

    -- red
    UIUtil:SetRedPoint(red, curState == 3)
end

function SetPanel1()
    -- night
    CSAPI.SetGOActive(night, data:GetI() == 4)

    -- name
    CSAPI.SetText(txtName, data:GetCfg().name)
    -- state
    local str = ""
    local s = LanguageMgr:GetByID(stateStrs[curState])
    if (curState == 1) then
        str = StringUtil:SetByColor(s, "ffffff")
    elseif (curState == 2) then
        str = StringUtil:SetByColor(s, "00ffbf")
    else
        str = StringUtil:SetByColor(s, "ffc146")
    end
    CSAPI.SetText(txtState, str)
    -- time
    SetBaseTime()
    -- rewards
    items = items or {}

    GridAddRewards(items, data:GetCfg().rewards, svContent1, 1, 4) -- 最多显示4个
    -- limit time 
    SetLimitBaseTime()

    -- success
    CSAPI.SetGOActive(txtSuccess, curState == 3)
    -- statebg
    local bgName = curState == 1 and "img_80_02.png"
    if (curState ~= 1) then
        bgName = curState == 2 and "img_80_03.png" or "img_80_01.png"
    end
    CSAPI.LoadImg(imgState, "UIs/Matrix/" .. bgName, true, nil, true)
end

function SetPanel2()
    -- teams  
    SetTeam()
    -- condition  
    SetConditions()
    -- btn
    local canvasgroup = ComUtil.GetCom(btnGo, "CanvasGroup")
    canvasgroup.alpha = allIsEnough and 1 or 0.3
    -- hot    
    local need = data:GetCfg().costHot
    CSAPI.SetText(txtHot, need == 0 and "0" or "-" .. need)
end

function SetTeam()
    selectCardDatas = selectCardDatas or {}
    local arr = {}
    for i = 1, 5 do
        if (i > #selectCardDatas) then
            table.insert(arr, {}) -- 添加一个空位置
        else
            table.insert(arr, selectCardDatas[i])
        end
    end
    cardItems = cardItems or {}
    ItemUtil.AddItems("RoleLittleCard/RoleSmallCard", cardItems, arr, svContent2, CardItemClickCB)
end
function CardItemClickCB(_item)
    CSAPI.OpenView("RoleListExpeditionView", {
        oldExpeditionData = selectCardDatas,
        cb = SelectCB,
        startCondition = data:GetCfg().startCondition
    }, RoleListType.Expedition)
end

function SelectCB(newArr)
    selectCardDatas = newArr
    SetPanel2()
end

function SetConditions()
    allIsEnough = true
    local startCondition = data:GetCfg().startCondition
    if (startCondition ~= nil) then
        for i = 1, 3 do
            if (i <= #startCondition) then
                local str = ""
                local v = startCondition[i]
                if (v[1] == ExpeditionTeamLimit.Lv) then
                    str = LanguageMgr:GetByID(10408, v[3], v[2]) -- 队伍至少%s人%s级
                elseif (v[1] == ExpeditionTeamLimit.Num) then
                    str = LanguageMgr:GetByID(10409, v[2]) -- 至少上阵%s个角色
                elseif (v[1] == ExpeditionTeamLimit.Class) then
                    local cfg = Cfgs.CfgTeamEnum:GetByID(v[2])
                    local s = cfg and cfg.sName or "XX"
                    str = LanguageMgr:GetByID(10410, v[3], s) -- 上阵%s个%s小队的角色
                end
                local isEnough = MatrixMgr:CheckCondition(selectCardDatas, v)
                if (not isEnough) then
                    allIsEnough = false
                end
                CSAPI.SetGOActive(this["txtCondition" .. i], true)
                CSAPI.SetGOActive(this["tick" .. i], isEnough)
                CSAPI.SetText(this["txtCondition" .. i],
                    isEnough and StringUtil:SetByColor(str, "FFFFFF") or StringUtil:SetByColor(str, "ff8790"))
            else
                CSAPI.SetGOActive(this["txtCondition" .. i], false)
            end
        end
    end
end

-- 限时
function SetLimitBaseTime()
    CSAPI.SetGOActive(txtLimitTime1, false)
    CSAPI.SetGOActive(limit, false)
    if (curState == 1) then
        endTime = data:GetEndTime()
        if (endTime ~= nil and endTime ~= 0) then
            CSAPI.SetGOActive(txtLimitTime1, true)
            CSAPI.SetGOActive(limit, data:GetI() ~= 4)
            SetLimitTime()
        end
    end
end

function SetLimitTime()
    needTime = endTime - TimeUtil:GetTime()
    needTime = needTime < 0 and 0 or endTime
    runTime = needTime > 0
    if (runTime) then
        CSAPI.SetText(txtLimitTime2, TimeUtil:GetTimeStr(needTime))
    else
        CSAPI.SetGOActive(txtLimitTime1, false)
        CSAPI.SetGOActive(limit, false)
        -- 由MatrixView刷新 BuildingProto:GetBuildUpdate({data:GetBuildID()}) --刷新建筑 移除订单
    end
end

function SetBaseTime()
    if (curState ~= 2) then
        CSAPI.SetText(txtTime2, TimeUtil:GetTimeStr(data:GetCfg().tCost))
    else
        timeMul, openTime, oldLen = buildData:GetTimeMul() -- 加速相关
        createTime = data:GetCrateEndTime()
        if (TimeUtil:GetTime() >= (createTime - 0.1)) then
            runTime = false
            CSAPI.SetText(txtTime2, TimeUtil:GetTimeStr(data:GetCfg().tCost))
        else
            SetTime()
        end
    end
end

function SetTime()
    local runLen = oldLen + (TimeUtil:GetTime() - openTime) * timeMul
    if (data:GetTCur() and data:GetTCur() > 0) then
        --needTime = createTime - data:GetTCur() - runLen
        needTime = data:GetTF() - TimeUtil:GetTime()
    else
        needTime = createTime - buildData:GetOldTime() - runLen
    end
    needTime = needTime > 0 and needTime or 0
    runTime = needTime > 0
    CSAPI.SetText(txtTime2, TimeUtil:GetTimeStr(data:GetCfg().tCost - needTime))
    if (not runTime) then
        RefreshPanel()
    end
end

-- 出发
function OnClickGO()
    if (not allIsEnough) then
        return
    end
    -- 是否已达上限
    local hadCount = 0
    local _data = buildData:GetData()
    local gifts = _data and _data.gifts or {}
    for i, v in pairs(gifts) do
        for k, m in pairs(v) do
            hadCount = hadCount + 1
        end
    end
    local max = buildData:GetCfg().teamCntLimit
    if (hadCount >= max) then
        LanguageMgr:ShowTips(2302)
        return
    end
    -- 检测热值 todo 
    local need = data:GetCfg().costHot
    if (need > 0) then
        -- for i, v in ipairs(selectCardDatas) do
        -- 	if(v:GetHot() < need) then
        -- 		local dialogdata = {}
        -- 		dialogdata.content = LanguageMgr:GetTips(14033) --"存在热值不足的卡牌，是否进行冷却？"
        -- 		dialogdata.okCallBack = function()
        -- 			--CSAPI.OpenView("CoolView")
        -- 		end
        -- 		CSAPI.OpenView("Dialog", dialogdata)
        -- 		return
        -- 	end
        -- end
        if (PlayerClient:Hot() < need) then
            LanguageMgr:ShowTips(14033)
            return
        end
    end
    -- 检测小游戏
    if (data:GetCfg().eventId ~= nil) then
        data.OkCB = function(_evens)
            BuildingProto:StartExpedition(data:GetBuildID(), data:GetServerData().cfgId, data:GetServerData().id,
                GetCids(), _evens)
        end
        CSAPI.OpenView("MatrixMiniGame", this)
    else
        -- 开始远征
        BuildingProto:StartExpedition(data:GetBuildID(), data:GetServerData().cfgId, data:GetServerData().id, GetCids())
    end
end

function GetCids()
    local ids = {}
    for i, v in ipairs(selectCardDatas) do
        table.insert(ids, v:GetID())
    end
    return ids
end

function OnClick()
    if (curState == 3) then
        BuildingProto:FinishExpedition(data:GetBuildID(), data:GetServerData().cfgId, data:GetServerData().id)
        return
    end
    if (curState == 2) then
        return
    end
    isSelect = not isSelect
    if (isSelect) then
        if (cb) then
            cb(this) -- 将其他的反选
        end
    end
    RefreshPanel()
end

-- 推荐 （表id不能重复）
function OnClickRe()
    -- 条件=》字典
    conditions = SetCondition()

    local cfgLvDatas, cfgTDatas = {}, {}
    -- 总卡牌数量，满足等级的人数，满足类型的人数
    local cardCount, lvCount, tCount = 0, 0, 0
    -- 卡牌数据
    local newDatas = {} -- 1级的卡牌
    -- 筛选符合条件的
    local datas = RoleMgr:GetDatas()
    for i, v in pairs(datas) do
        -- 热值
        -- if(v:GetHot() >= data:GetCfg().costHot) then
        -- 未参与远征的
        if (not v:IsInExpedition()) then
            -- 不在关卡队伍
            local index = TeamMgr:GetCardTeamIndex(v:GetID())
            if index == -1 then
                table.insert(newDatas, v)
                cardCount = cardCount + 1
                -- 等级符合且未计算的表id
                if (v:GetLv() >= conditions[1][2] and cfgLvDatas[v:GetCfgID()] == nil) then
                    cfgLvDatas[v:GetCfgID()] = 1
                    lvCount = lvCount + 1
                end

                -- 类型符合且未计算的表id
                if (conditions[3][2] == 0 or conditions[3][2] == v:GetCamp() and cfgTDatas[v:GetCfgID()] == nil) then
                    cfgTDatas[v:GetCfgID()] = 1
                    tCount = tCount + 1
                end
            end
        end
        -- end
    end

    -- 总人数是否足够
    if (cardCount < conditions[2][2]) then
        LanguageMgr:ShowTips(2301)
        return
    end
    -- 满足等级的人数是否足够
    if (lvCount < conditions[1][3]) then
        LanguageMgr:ShowTips(2301)
        return
    end
    -- 满足类型人数是否足够
    if (tCount < conditions[3][3]) then
        LanguageMgr:ShowTips(2301)
        return
    end

    -- 排序规则，等级由小到大排序，等级相同时，需要的类型的卡牌排在前面,相同时=》等级低>低品质>低星级
    if (#newDatas > 1) then
        local count1 = 0
        table.sort(newDatas, function(a, b)
            count1 = count1 + 1
            if (a:GetLv() ~= b:GetLv()) then
                return a:GetLv() < b:GetLv()
            else
                if (conditions[3][2] == 0) then
                    -- 无类型需求
                    return SameFunc(a, b)
                else
                    if (a:GetCamp() == conditions[3][2] and b:GetCamp() ~= conditions[3][2]) then
                        return true
                    elseif (a:GetCamp() ~= conditions[3][2] and b:GetCamp() == conditions[3][2]) then
                        return false
                    else
                        return SameFunc(a, b)
                    end
                end
            end
        end)
    end
    -- 选择规则，先选择等级符合且类型符合的卡牌，如果条件不足，先选择符合等级的卡牌，如果足够再选择符合类型的卡牌，后判断总人数
    selectCfgIDs = {}
    selectDatas = {}
    _count, _lvCount, _tCount = 0, 0, 0
    for i, v in ipairs(newDatas) do
        -- 先从大于1级的开始选择
        if (v:GetLv() > 1 and v:GetLv() >= conditions[1][2]) then
            if (conditions[3][2] == 0 or conditions[3][2] == v:GetCamp()) then
                SelectDataAdd(v)
                if (_count >= 5) then -- 选满
                    SetCorrect(selectDatas)
                    return
                end
            end
        end
    end
    -- 是否满足
    if (conditions[1][3] <= _lvCount and conditions[2][2] <= _count and conditions[3][3] <= _tCount) then
        SetCorrect(selectDatas)
        return
    end
    -- 等级数量未符合（先由大于1级的选，不够再选择1级的）
    if (conditions[1][3] > _lvCount) then
        for i, v in ipairs(newDatas) do
            if (conditions[1][2] == 1) then
                if (v:GetLv() > 1) then
                    SelectDataAdd(v)
                    if (_lvCount >= conditions[1][3]) then
                        break
                    end
                end
            elseif (v:GetLv() >= conditions[1][2]) then
                SelectDataAdd(v)
                if (_lvCount >= conditions[1][3]) then
                    break
                end
            end
        end
        -- 依然不够，那肯定是1级也符合的（因为之前已有总人数的判断）
        if (conditions[1][3] > _lvCount) then
            for i, v in ipairs(newDatas) do
                SelectDataAdd(v)
                if (_lvCount >= conditions[1][3]) then
                    break
                end
            end
        end
    end
    -- 是否满足
    if (conditions[1][3] <= _lvCount and conditions[2][2] <= _count and conditions[3][3] <= _tCount) then
        SetCorrect(selectDatas)
        return
    end
    -- 类型数量未符合（先由大于1级的选，不够再选择1级的）
    if (conditions[3][3] > _tCount) then
        for i, v in ipairs(newDatas) do
            if (v:GetLv() > 1 and v:GetCamp() == conditions[3][2]) then
                SelectDataAdd(v)
                if (_tCount >= conditions[3][3]) then
                    break
                end
            end
        end
        if (conditions[3][3] > _tCount) then
            for i, v in ipairs(newDatas) do
                SelectDataAdd(v)
                if (_tCount >= conditions[3][3]) then
                    break
                end
            end
        end
    end
    -- 是否满足
    if (conditions[1][3] <= _lvCount and conditions[2][2] <= _count and conditions[3][3] <= _tCount) then
        SetCorrect(selectDatas)
        return
    end
    -- 到这里肯定是总人数不够
    for i, v in ipairs(newDatas) do
        SelectDataAdd(v)
        if (_count >= conditions[2][2]) then
            break
        end
    end
    -- 是否满足
    if (conditions[1][3] <= _lvCount and conditions[2][2] <= _count and conditions[3][3] <= _tCount) then
        SetCorrect(selectDatas)
        return
    end

    LanguageMgr:ShowTips(2301) -- 没有符合条件的角色
end

function SelectDataAdd(v)
    if (selectDatas[v:GetID()] == nil and not selectCfgIDs[v:GetCfgID()]) then
        selectDatas[v:GetID()] = v
        selectCfgIDs[v:GetCfgID()] = 1
        _count = _count + 1
        _lvCount = _lvCount + 1
        _tCount = _tCount + 1
    end
end

-- 选择
function SetCorrect(selectDatas)
    selectCardDatas = {}
    for i, v in pairs(selectDatas) do
        table.insert(selectCardDatas, v)
    end
    SetPanel2()
end

function SameFunc(a, b)
    if (a:GetQuality() ~= b:GetQuality()) then
        return a:GetQuality() < b:GetQuality()
    elseif (a:GetBreakLevel() ~= b:GetBreakLevel()) then
        return a:GetBreakLevel() < b:GetBreakLevel()
    else
        return a:GetID() < b:GetID()
    end
end

-- 条件整合成字典(表一定要填数据)
function SetCondition()
    local conditions = {}
    local startCondition = data:GetCfg().startCondition
    for i = 1, 3 do
        local isIn = false
        for k, m in ipairs(startCondition) do
            if (m[1] == i) then
                conditions[i] = m
                isIn = true
                break
            end
        end
        if (not isIn) then
            if (i == 1) then
                conditions[i] = {1, 1, 1}
            elseif (i == 2) then
                conditions[i] = {2, 1}
            else
                conditions[i] = {3, 0, 0} -- 没有0类型，此为标记
            end
        end
    end
    -- 最大人数适应
    if (conditions[2][2] < conditions[1][3]) then
        conditions[2][2] = conditions[1][3]
    end
    if (conditions[2][2] < conditions[3][3]) then
        conditions[2][2] = conditions[3][3]
    end
    return conditions
end

