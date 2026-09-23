-- 奖励箱子
local data = nil
local isGet = false
local isReach = false
local items = {}

function Refresh(_info)
    if _info then
        isGet = _info.isGet
        isReach = _info.isReach
        data = _info.info
        if data then
            -- title
            CSAPI.SetText(txt_title2, data.index .. "")
            -- reach
            CSAPI.SetGOActive(reachObj, isReach)
            -- target
            CSAPI.SetText(txt1, data.starNum1 .. "")
            CSAPI.SetText(txt2, "-" .. data.starNum2)
            -- rewards
            if data.rewards and #data.rewards > 0 then
                local datas = {}
                for i, v in ipairs(data.rewards) do
                    local rData = {
                        id = v[1],
                        num = v[2],
                        type = v[3] or 2
                    }
                    table.insert(datas, rData)
                end
                curDatas = datas
                SetItems()

                --SetRed(GetCanGet())
            end

            -- sv
            CSAPI.SetScriptEnable(sv, "ScrollRect", #curDatas > 4)
        end
    end
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Dungeon/DungeonBoxItem", items, curDatas, svContent, nil, 1, {
        isGet = isGet
    })
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

function IsGet()
    return isGet
end
