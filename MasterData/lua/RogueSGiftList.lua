function Refresh(_cfgChild, starIx)
    cfg = _cfgChild
    -- 
    local curStar = RogueSMgr:GetStars(starIx)
    local maxIndex = RogueSMgr:GetRogueSGainMaxIndex(starIx)
    isGet = maxIndex >= cfg.index
    isReach = curStar >= cfg.starNum
    -- title
    CSAPI.SetText(txt_title2, cfg.index .. "")
    -- reach
    CSAPI.SetGOActive(reachObj, isReach)
    -- target
    CSAPI.SetText(txt_target, cfg.starNum .. "")

    -- rewards
    if cfg.rewards and #cfg.rewards > 0 then
        local datas = {}
        for i, v in ipairs(cfg.rewards) do
            local rData = {
                id = v[1],
                num = v[2],
                type = v[3]
            }
            table.insert(datas, rData)
        end
        curDatas = datas
        SetItems()

        SetRed(GetCanGet())
    end

    -- sv
    CSAPI.SetScriptEnable(sv, "ScrollRect", #curDatas > 4)
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Dungeon/RogueSGiftListItem", items, curDatas, svContent, nil, 1, isGet)
end

function SetRed(b)
    UIUtil:SetRedPoint(redParent, b, 0, 0)
end

function GetCanGet()
    local isCanGet = false
    if not isGet and isReach then
        isCanGet = true
    end
    return isCanGet
end

