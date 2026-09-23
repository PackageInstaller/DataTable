local index = 0 -- 当前页码
local max = 1 --
local page = 5 -- 每页数量
local allLogs = {} -- 所有数据 
local logs = {} -- 当前页数据
local is_end = false
local isRequest = false

function Awake()
    btnLCanvasGroup = ComUtil.GetCom(btnL, "CanvasGroup")
    btnRCanvasGroup = ComUtil.GetCom(btnR, "CanvasGroup")

    -- LanguageMgr:SetText(txtTips, 17041, g_CardCreateLogsCnt)
    -- UIUtil:AddTop2("CreateRecord", gameObject, function()
    --     view:Close()
    -- end, nil, {})
end

-- function OnOpen()
function Refresh(_data)
    poolId = _data.card_pool_id
    is_end = _data.is_end
    for k, v in ipairs(_data.logs) do
        table.insert(allLogs, v)
    end

    -- data = _data
    -- logs = data.logs or {}
    -- if (#logs > 1) then
    --     table.sort(logs, function(a, b)
    --         return a.t > b.t
    --     end)
    -- end
    max = math.ceil(#allLogs / page) or 0
    index = index + 1

    RefreshPanel()

    isRequest = false
end

function RefreshPanel()
    InitDatas()
    SetSV()
    SetBtns()

    CSAPI.SetGOActive(empty, #allLogs <= 0)
    CSAPI.SetGOActive(sv, #allLogs > 0)
end

function InitDatas()
    curDatas = {}
    local cur = page * (index - 1) + 1
    local len = #allLogs
    local cur2 = (cur + page - 1) > len and len or (cur + page - 1)
    for i = cur, cur2 do
        table.insert(curDatas, allLogs[i])
    end
end

function SetSV()
    items = items or {}
    ItemUtil.AddItems("Create/CreateRecordItem", items, curDatas, Content)
end

function SetBtns()
    CSAPI.SetText(txtPage, index .. "")
    btnLCanvasGroup.alpha = index <= 1 and 0.3 or 1
    if (index < max or not is_end) then
        btnRCanvasGroup.alpha = 1
    else 
        btnRCanvasGroup.alpha = 0.3
    end

end

function OnClickL()
    if (not isRequest and index > 1) then
        index = index - 1
        RefreshPanel()
    end
end

function OnClickR()
    if (not isRequest and index < max) then
        index = index + 1
        RefreshPanel()
    elseif (not isRequest and not is_end) then
        isRequest = true
        PlayerProto:GetCreateCardLogs(poolId, index, function(proto)
            Refresh(proto)
        end)
    end
end
