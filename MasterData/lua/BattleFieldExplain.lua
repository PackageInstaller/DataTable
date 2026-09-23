local rect = nil
local titleIDs = {37018, 37019, 37012}
local buffItems = nil

function Awake()
    rect = ComUtil.GetCom(node, "RectTransform")
end

function OnOpen()
    if data then
        Refresh(data)
    end
end

-- 1.活动说明 2.活动BUFF 3.排行奖励
function Refresh(type)
    SetAnchors(type)
    LanguageMgr:SetText(txtTitle, titleIDs[type])
    CSAPI.SetGOActive(txtDesc, type == 1)
    CSAPI.SetGOActive(grid, type == 2)
    CSAPI.SetGOActive(sv, type == 3)
    
    local h = 915
    local pos = {495, -120}
    if type == 1 then
        CSAPI.SetTextColor(txtDesc, 211, 211, 213, 255)
        local str = BattleFieldMgr:GetActivityExplain()
        CSAPI.SetText(txtDesc, str)
    elseif type == 2 then
        h = 734
        pos = {905, -120}
        SetBuff()
    else
        h = 911
        pos = {686, 994}
        SetRank()
    end
    CSAPI.SetRTSize(node, 767, h)
    CSAPI.SetAnchor(node, pos[1], pos[2])
end

-- 设置锚点
function SetAnchors(type)
    local curX, curY = CSAPI.GetLocalPos(node)
    if type < 3 then
        rect.anchorMax = UnityEngine.Vector2(0, 1)
        rect.anchorMin = UnityEngine.Vector2(0, 1)
    else
        rect.anchorMax = UnityEngine.Vector2(0, 0)
        rect.anchorMin = UnityEngine.Vector2(0, 0)
    end
    CSAPI.SetLocalPos(node, curX, curY)
end

function SetTitle(str)
    CSAPI.SetText(txtTitle, str)
end

function SetDesc(str)
    CSAPI.SetText(txtDesc, str)
end

function SetBuff()
    local buffDatas = BattleFieldMgr:GetBossBuffs()
    buffItems = buffItems or {}
    if #buffItems > 0 then
        for i, v in ipairs(buffItems) do
            CSAPI.SetGOActive(v.gameObject,false)
        end
    end

    if #buffDatas > 0 then
        for i, v in ipairs(buffDatas) do
            if i > #buffItems then
                ResUtil:CreateUIGOAsync("BattleField/BattleFieldExplainItem1",grid,function (go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.SetIndex(i)
                    lua.Refresh(v)
                    table.insert(buffItems,lua)
                end)
            else
                CSAPI.SetGOActive(lua.gameObject, true)
                local lua = buffItems[i]
                lua.SetIndex(i)
                lua.Refresh(v)
            end
        end
    end
end

function SetRank()

end

function OnClickReturn()
    view:Close()
end