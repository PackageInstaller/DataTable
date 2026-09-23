local data = nil
local sid = nil
local chatItem = nil
local optionList = {}
local isOptionLoadSuccess = false
local optionCallBack = nil
local isChatLoadSucccess = false
local chatCallBack = nil

function SetIndex(idx)
    index= idx
end

function SetFinishCB(_cb)
    finishCB = _cb
end

function Refresh(_data,_elseData)
    data = _data
    sid = _elseData
    if data then
        CSAPI.SetGOAlpha(node,data:IsShow() and 1 or 0)
        SetIcon()
        SetHeight()
        SetChat()
    end
end

function SetIcon()
    CSAPI.SetGOActive(left,not data:IsHideIcon())
    if not data:IsHideIcon() and sid then
        -- local iconName = data:GetIcon()
        -- if iconName~=nil and iconName~="" then
        --     ResUtil.LovePlus:Load(iconL,sid .. "/" ..iconName)
        -- end
    end
end

function SetHeight()
    CSAPI.SetRTSize(gameObject,865,data:GetSize())
end

function SetChat()
    local isOption = data:IsTemp()
    CSAPI.SetGOActive(itemParent,not isOption)
    CSAPI.SetGOActive(options,isOption)
    if isOption then
        SetOptions()
    else
        SetItem()
    end
end

function SetOptions()
    if #optionList > 0 then
        for i, v in ipairs(optionList) do
            CSAPI.SetGOActive(v.gameObject,false)
        end
    end
    local ids = data:GetNextIDs()
    if ids and #ids> 0 then
        for i, v in ipairs(ids) do
            if i<=#optionList then
                CSAPI.SetGOActive(optionList[i].gameObject,true)
                optionList[i].Refresh(v)
            else
                ResUtil:CreateUIGOAsync("LovePlusChat/LovePlusChatItem3",options,function (go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.SetClickCB(OnOptionClickCB)
                    lua.Refresh(v)
                    table.insert(optionList,lua)
                    if i == #optionList then
                        isOptionLoadSuccess = true
                        if optionCallBack then
                            optionCallBack()
                            optionCallBack = nil
                        end
                    end
                end)
            end
        end
    end
end

function OnOptionClickCB(id)
    local chatData = LovePlusMgr:GetChatData(id)
    if chatData then
        chatData:SetIsShow(true)
    end
    if finishCB then
        finishCB()
    end
end

function SetItem()
    if chatItem == nil then
        ResUtil:CreateUIGOAsync("LovePlusChat/LovePlusChatItem2",itemParent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.SetFinishCB(OnShowFinish)
            lua.Refresh(data)
            chatItem = lua
            isChatLoadSucccess = true
            if chatCallBack then
                chatCallBack()
                chatCallBack = nil
            end
        end)
    else
        chatItem.Refresh(data)
    end
end

--------------------------------------聊天展示--------------------------------------

function ShowChat()
    --如果异步生成前先进行聊天展示则在异步生成完毕后再执行函数
    if data:IsTemp() then
        optionCallBack = function()
            CSAPI.SetGOAlpha(node,1)
        end
        if isOptionLoadSuccess then
            optionCallBack()
            optionCallBack = nil
        end
    else
        chatCallBack = function()
            CSAPI.SetGOAlpha(node.gameObject,1)
            chatItem.ShowChat()
        end
        if isChatLoadSucccess then
            chatCallBack()
            chatCallBack = nil
        end
    end
end

function OnShowFinish()
    if finishCB then
        finishCB()
    end
end