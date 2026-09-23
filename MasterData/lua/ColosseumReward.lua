function OnOpen()
    randModData = ColosseumMgr:GetRandModData()
    local cur, max = ColosseumMgr:GetRandomStar(), 27
    -- star
    CSAPI.SetText(txt_star1, cur .. "")
    CSAPI.SetText(txt_star2, max .. "")

    RefreshPanel()
end

function RefreshPanel()
    -- item
    SetItem()
    -- btn
    SetBtn()
end

function SetBtn()
    CSAPI.SetGOActive(btnGet, randModData.isOver)
    if (randModData.isOver) then
        CSAPI.SetGOAlpha(btnGet, randModData.isGet and 0.5 or 1)

        -- red
        local isRed = false
        if (not randModData.isGet) then
            isRed = true
        end
        UIUtil:SetRedPoint(btnGet, isRed, 108, 32, 0)
    end
end

function SetItem()
    local itemData = {}
    itemData.isGet = randModData.isGet
    itemData.isReach = true -- ColosseumMgr:GetRandomStar() > 0
    itemData.info = GetInfo()
    --
    if (not item) then
        ResUtil:CreateUIGOAsync("Dungeon/ColosseumRewardItem", itemParent, function(go)
            item = ComUtil.GetLuaTable(go)
            item.Refresh(itemData)
        end)
    end
end

-- 取第一关数据的即可
function GetInfo()
    local info = {}
    local cur = ColosseumMgr:GetRandomStar()
    local randLvs = ColosseumMgr:GetRandModData().randLvs
    local id = randLvs[1].dupIds[1]
    local cfg = Cfgs.MainLine:GetByID(id)
    local arr = Cfgs.cfgColosseumRewar:GetAll()
    for k, v in ipairs(arr) do
        if (arr[k].star >= cur or k == #arr) then
            info.index = k
            info.starNum1 = arr[k - 1] ~= nil and arr[k - 1].star+1 or 0
            info.starNum2 = arr[k].star
            info.rewards = arr[k].reward
            break
        end
    end
    return info
end

function OnClickGet()
    if (not randModData.isGet) then
        AbattoirProto:RandModeGetRwd(OnClickMask)
    end
end

function OnClickMask()
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
