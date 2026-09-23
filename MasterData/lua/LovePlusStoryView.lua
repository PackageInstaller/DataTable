local data = nil
local elseData = nil
local datas = {}
local items = {}
local topIndex = 0 --头顶下标
local topLockInfos = nil
local currTopIndex = 0--当前已解锁下标
local lastTopIndex = 0
local topDatas = {}
local topItems = {}
--sv
local itemLen = 0
local isShowArrow = false
local svLen = 0
local lastX = 1
local currX = 0
local padding,spacing,itemSize = {40,40},48,452

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.LovePlus_Story_Select,OnTopItemSelect)
    eventMgr:AddListener(EventType.LovePlus_Story_Update,OnStoryUnLock)
end

--LovePlusStoryListData
function OnTopItemSelect(_storyData)
    if _storyData and _storyData:GetPos() then
        lastTopIndex = currTopIndex
        currTopIndex = _storyData:GetPos()[2]
        RefreshPanel()
    end
end

function OnStoryUnLock()
    RefreshPanel()
end

function OnDisable()
    eventMgr:ClearListener()
end

function Update()
    UpdateArrow()
end

function Refresh(_data,_elseData)
    data = _data
    elseData = _elseData
    if data then
        RefreshPanel()
    end
    SetJump()
end

function RefreshPanel()
    SetPrograss()
    SetDatas()
    SetTopIndex()
    SetWidth()
    SetArrow()
    SetTopItems()
    SetItems()
end

function SetDatas()
    datas = LovePlusMgr:GetStoryListArr(data:GetID())
end

function SetTopIndex()
    topIndex = 0
    topLockInfos = {}
    if #datas>0 then
        for _, _data in ipairs(datas) do
            local pos = _data:GetPos()
            if pos and pos[2] then
                topIndex = pos[2] > topIndex and pos[2] or topIndex
                if not _data:IsOpen() and topLockInfos[pos[2]] == nil then
                    topLockInfos[pos[2]] = 1
                end
            end
        end
    end
end

--sv宽度
function SetWidth()
    itemLen = padding[1] + (topIndex * itemSize) + (topIndex>1 and (topIndex-1)*spacing or 0) + padding[2]
    CSAPI.SetRTSize(content,itemLen,0)
end

--完成率
function SetPrograss()
    CSAPI.SetText(txtPrograss, data:GetPrograss() .. "%")
end

function SetTopItems()
    if #topItems>0 then
        for i, v in ipairs(topItems) do
            CSAPI.SetGOActive(v.gameObject,false)
        end
    end
    if topIndex>0 then
        if lastTopIndex > 0 and topLockInfos[currTopIndex] ~= nil then
            currTopIndex = lastTopIndex
        end
        for i = 1, topIndex do
            if i<=#topItems then
                CSAPI.SetGOActive(topItems[i].gameObject,true)
                topItems[i].Refresh(i,topLockInfos[i] ~= nil)
                if currTopIndex == i and topLockInfos[i] == nil then
                    topItems[i].SetSel()
                end
            else
                ResUtil:CreateUIGOAsync("LovePlusStory/LovePlusStoryNum",topObj,function (go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(i,topLockInfos[i] ~= nil)
                    if currTopIndex == i and topLockInfos[i] == nil then
                        lua.SetSel()
                    end
                    table.insert(topItems,lua)
                end)
            end
        end
    end
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("LovePlusStory/LovePlusStoryItem",items,datas,itemParent,OnItemClickCB)
end

function OnItemClickCB(item)
    local storyData = item.GetData()
    if storyData then
        LovePlusMgr:TryOpenPlot(data:GetID(),storyData:GetID(),function ()
            CSAPI.OpenView("LovePlusPlotPanel",{storyID = storyData:GetID(),playCallBack = OnPlotPlayEnd})
        end)
        OnTopItemSelect(storyData)
    end
end

function SetJump()
    if elseData then
        if elseData.id and #datas>0 then
            for k, v in ipairs(datas) do
                if v:GetID() == elseData.id then
                    local pos = v:GetPos()
                    if pos[2] then
                        MoveToIndex(pos[2])
                    end
                    break
                end
            end
        end
        if elseData.storyID then
            local storyId,talkId = elseData.storyID,elseData.talkID
            LovePlusMgr:TryOpenPlot(data:GetID(),storyId,function ()
                CSAPI.OpenView("LovePlusPlotPanel",{storyID = storyId,talkID = talkId,playCallBack = OnPlotPlayEnd})
            end)
        end
        elseData = nil
    end
end

function OnPlotPlayEnd()
    FuncUtil:Call(function ()
        local isChatNew= LovePlusMgr:GetChatNew(data:GetID())
        if isChatNew then
            LovePlusMgr:SetChatNew(data:GetID(),false)
            EventMgr.Dispatch(EventType.LovePlus_List_View_Change,1) --跳转至聊天界面
        end
    end,this,50)
end
---------------------------------------------sv---------------------------------------------
function SetArrow()
    lastX = 1
    currX = 0
    local svSize = CSAPI.GetRTSize(hsv)  
    svLen = svSize[0]
    isShowArrow = itemLen > svLen
    CSAPI.SetGOActive(arrowL,isShowArrow)
    CSAPI.SetGOActive(arrowR,isShowArrow)
end


function UpdateArrow()
    if not isShowArrow then
        return
    end

    currX = CSAPI.GetAnchor(content)
    if math.abs(currX - lastX) > 0.01 then
        CSAPI.SetGOActive(arrowL,currX < -(0.1 + padding[1]))
        CSAPI.SetGOActive(arrowR,currX > -(itemLen-svLen -padding[2]))    
        lastX = currX
    end
end

function MoveToIndex(index,isAnim)
    if itemLen > svLen then
        local _,y = CSAPI.GetLocalPos(content)
        local x = padding[1] - 50 + (index -1) * (spacing + itemSize)
        x = x > itemLen - svLen and itemLen - svLen or x
        if isAnim then
            CSAPI.MoveTo(content,"UI_Local_Move",-x,y,0,nil,0.2)
        else
            CSAPI.SetLocalPos(content,-x,y)
        end
    end
end
