local info = nil
local isSelf = false
local cfg = nil
local rank = 0
local isHideBtn = false
local isHideTurn = false
local desc1, desc2 = "", ""
local items = nil

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(_i)
    index = _i
end

function Refresh(_data, _elseData)
    info = _data
    isSelf = _elseData and _elseData.isSelf
    desc1 = _elseData and _elseData.desc1 or ""
    desc2 = _elseData and _elseData.desc2 or ""
    cfg = _elseData and _elseData.cfg
    isHideBtn = cfg and cfg.isClose
    isHideTurn = cfg and cfg.isHideTurn
    if info then
        -- bg
        CSAPI.SetGOActive(bg1, not isSelf)
        CSAPI.SetGOActive(bg2, isSelf)
        SetLeft()
        SetRight()
    end
end

function SetLeft()
    -- rank
    rank = info:GetRank()
    for i = 1, 3 do
        if this["rankImg" .. i] and not IsNil(this["rankImg" .. i].gameObject) then
            CSAPI.SetGOActive(this["rankImg" .. i].gameObject, rank == i)
        end
    end
    CSAPI.SetText(txtRank1, rank < 4 and rank .. "" or "")
    CSAPI.SetText(txtRank2, rank >= 4 and rank .. "" or "")
    -- name
    CSAPI.SetText(txtName, info:GetName())
    CSAPI.SetText(txtUID, info:GetUID() .. "")
    -- 等级
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtLv, info:GetLevel() .. "")
    -- 排名
    CSAPI.SetGOActive(rank1, rank < 4 and rank ~= 0)
    CSAPI.SetGOActive(rank2, rank >= 4 or info:GetRankStr() ~= nil)
    if isSelf then
        CSAPI.SetText(txtRank1, (rank < 4 and rank ~= 0) and rank .. "" or "")
        local rankStr = info:GetRankStr()
        if not rankStr then
            rankStr = rank > 100 and "100+" or rank .. ""
        end        
        if cfg then
            if cfg.id == eRankId.GlobalBoss then
                rankStr = GlobalBossMgr:GetRankStr(rank)
            elseif cfg.rankType and cfg.rankType == eRankType.PeriodBossRank and rank ~= 0 then
                rankStr = rank .. ""
            end
        end
        CSAPI.SetText(txtRank2, rankStr)
    else
        CSAPI.SetText(txtRank1, rank < 4 and rank .. "" or "")
        CSAPI.SetText(txtRank2, rank >= 4 and rank .. "" or "")
    end
    -- icon
    UIUtil:AddHeadByID(frameParent, 0.68, info:GetFrameId(), info:GetIconID(), info:GetSex())
    -- title
    UIUtil:AddTitleByID(titleParent, 0.55, info:GetTitle())
    -- iconCard 
    -- if isSelf then
    --     UIUtil:AddCardIcon(3, iconCardParent, 1)
    -- else
    --     UIUtil:AddCardIconByID(3, iconCardParent, 1, info:GetIconCard())
    -- end
end

function SetRight()
    -- 显示1
    local str1 = info:GetScore() .. ""
    if cfg and cfg.id == eRankId.GlobalBoss then
        str1 = info:GetDamage() .. ""
    end
    CSAPI.SetText(txtNum1, str1)
    CSAPI.SetText(txtDesc1, desc1)
    -- 显示2
    CSAPI.SetGOActive(numObj2, not isHideTurn)
    if not isHideTurn and cfg then
        -- CSAPI.SetText(txtDesc2, desc2)
        if cfg.id == eRankId.MultTeamRank then
            CSAPI.SetText(txtNum2, desc2 .. " " .. LanguageMgr:GetByID(77036, info:GetTurnNum()))
        elseif cfg.id == eRankId.RogueTRank then
            if isSelf then
                local maxHard = RogueTMgr:GetMaxHard2()
                local str = maxHard == 0 and "" or LanguageMgr:GetByID(54049, maxHard)
                CSAPI.SetText(txtNum2, desc2 .. " " .. str)
            else
            CSAPI.SetText(txtNum2, desc2 .. " " .. info:GetHard())
            end
        else
            CSAPI.SetText(txtNum2, desc2 .. " " .. info:GetTurnNum() .. "")
        end
    end
    if isSelf then
        CSAPI.SetGOActive(btnOpen, rank ~= 0 and rank <= 100 and not isHideBtn)
    else
        CSAPI.SetGOActive(btnOpen, not isHideBtn)
    end
    SetCards()
end

function SetCards()
    local hasCard = info:GetCardList() and #info:GetCardList() > 0
    CSAPI.SetGOActive(mask2, hasCard)
    CSAPI.SetAnchor(numObj1, hasCard and 813 or 788, hasCard and 59 or 0)
    CSAPI.SetAnchor(numObj2, hasCard and 193 or 168, hasCard and 59 or 0)
    CSAPI.SetAnchor(btnOpen, hasCard and 804 or 785, hasCard and 59 or 0)

    CSAPI.SetScriptEnable(numObj1, "Image", not hasCard and info:GetIconCard() ~= 1)
    CSAPI.SetScriptEnable(numObj2, "Image", not hasCard and info:GetIconCard() ~= 1)
    if hasCard then
        local cards = {}
        for i, v in ipairs(info:GetCardList()) do
            table.insert(cards, CharacterCardsData(v))
        end
        items = items or {}
        ItemUtil.AddItems("RoleLittleCard/RoleSmallCard", items, cards, grid, OnCardClickCB)
    end
end

function OnCardClickCB(item)
    OnClick()
    -- CSAPI.OpenView("RoleInfo", item.data)
end

function GetName()
    return info and info:GetName() or ""
end

function OnClick()
    if isHideBtn then
        return
    end
    if cb then
        cb(this)
    end
end
