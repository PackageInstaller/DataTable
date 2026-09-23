local datas = {}
local items = nil
local padding = {20, 20}
local spacing = 25
local currItem = nil
local arrowUtil = nil

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedPointRefersh)

    arrowUtil = ArrowUtil.New()
    arrowUtil:Init(sv, itemParent, arrowL, arrowR)

    CSAPI.SetGOActive(animMask,false)
end

function OnRedPointRefersh()
    if items and #items >0 then
        for i, v in ipairs(items) do
            v.SetRed()
            v.SetNum()
        end
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("StoryCollection", topParent, OnClickBack)
end

function Update()
    arrowUtil:Update()
end

function OnOpen()
    SetDatas()
    SetItems(OnItemLoadSuccess)
end

function SetDatas()
    datas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.StoryCollection)
end

function SetItems(callBack)
    items = items or {}
    ItemUtil.AddItems("StoryCollection/StoryCollectionItem", items, datas, itemParent, OnItemClickCB, 1, nil, callBack)
end

function OnItemClickCB(item)
    local lastIndex = nil
    if currItem then
        if currItem.index == item.index then
            CSAPI.OpenView("StoryCollectionList",{id = item.GetID()})
            return
        end

        lastIndex = currItem.index
        -- currItem.ShowSelAnim(false)
        currItem = nil
    end

    currItem = item
    -- currItem.ShowSelAnim(true)
    RefreshItemByAnim(lastIndex,currItem.index)
end

function OnItemLoadSuccess()
    RefreshItemPanel()
end

function RefreshItemPanel()
    local len = padding[1]
    if #items > 0 then
        for i, v in ipairs(items) do
            CSAPI.SetAnchor(v.gameObject, len, 0)
            if i == #items then
                len = len + v.GetWidth()
            else
                len = len + v.GetWidth() + spacing
            end
        end
    end
    len = len + padding[2]
    CSAPI.SetRTSize(itemParent, len, 0)
    arrowUtil:RefreshLen()
end

function OnClickBack()
    view:Close()
end
---------------------------------------------anim---------------------------------------------
local animInfos = {}
local isAnim = false
function PlayAnim(delay, cb)
    if delay <= 0 then
        return
    end
    if isAnim then
        table.insert(animInfos,{time = delay,func = cb})
        return
    end
    CSAPI.SetGOActive(animMask, true)
    isAnim = true
    FuncUtil:Call(function()
        if cb then
            cb()
        end
        isAnim = false
        if #animInfos > 0 then
            local info = table.remove(animInfos,1)
            PlayAnim(info.time,info.func)
        else
            CSAPI.SetGOActive(animMask, false)
        end
    end, this, delay)
end

function RefreshItemByAnim(lastIndex,curIndex)
    local animTime = 0
    if lastIndex then
        local len = padding[1]
        if #items > 0 then
            items[lastIndex].ShowSelAnim(false)
            for i, v in ipairs(items) do
                if i > lastIndex then
                    v.MoveTo(len,0,500)
                end
                len = len + v.GetWidth() + spacing
            end
        end
        animTime = 550
    end
    if curIndex then
        FuncUtil:Call(function ()
            local len = padding[1]
            if #items > 0 then
                items[curIndex].ShowSelAnim(true)
                for i, v in ipairs(items) do
                    if i > curIndex then
                        v.MoveTo(len,0,600)
                    end
                    if i == #items then
                        len = len + v.GetWidth()
                    else
                        len = len + v.GetWidth() + spacing
                    end
                end
            end
            len = len + padding[2]
            CSAPI.SetRTSize(itemParent, len, 0)
            arrowUtil:RefreshLen()
        end,this,animTime)
        animTime = animTime + 650
    end
    PlayAnim(animTime)
end
