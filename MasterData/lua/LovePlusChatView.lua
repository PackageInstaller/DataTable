local data = nil
local curDatas = nil
local layout = nil
local currIndex = 0
local iconItem = nil
local imgItems = nil
local sr = nil

--流程
local newChatListData = nil
local newChatDatas = nil
local newChatIndex = 1
local currShowData = nil
local updateCB = nil

function Awake()
    layout = UIInfiniteUnlimited.New()
    layout:Init("LovePlusChat/LovePlusChatItem",LayoutCallBack,itemParent,10,{40,40})
    eventMgr=ViewEvent.New()
    eventMgr:AddListener(EventType.LovePlus_Chat_Update,OnChatUpdate)
    InitAnim()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetFinishCB(ShowNextChat)
        lua.Refresh(_data, data:GetID())
    end
end

function OnChatUpdate()
    if newChatDatas and #newChatDatas> 0 then
        return
    end
    if updateCB then
        updateCB()
        updateCB = nil
    else
        StartShowChat()
    end
end

function OnDestroy()
    eventMgr:ClearListener()

    -- if #curDatas> 0 then
    --     for k, v in pairs(curDatas) do
    --         v:SetIsShow(false)
    --     end
    -- end
    -- curDatas[#curDatas]:SetIsShow(false)
end

function OnDisable()
    currShowData = nil
end

function Update()
    -- local x,y = CSAPI.GetAnchor(itemParent)
    -- LogError("x2:" .. x ..",y2:" .. y)
    layout:Update()
end

--LovePlusData  
function Refresh(_data)
    data = _data
    if data then
        SetDatas()
        SetIcon()
        SetRight()
    end
end

function SetDatas()
    curDatas = LovePlusMgr:GetChatArr(data:GetID())
    currIndex = #curDatas
end

function SetIcon()
    local imgCfgs= data:GetChatImgCfgs()
    local infos = {}
    if imgCfgs and #imgCfgs > 0 then
        for i, v in ipairs(imgCfgs) do
            if not v.dateImgUnlock or LovePlusMgr:IsOpen(eLovePlusUnLockType.Img,v.id) then
                table.insert(infos,v)
            end
        end
    end
    imgItems = imgItems or {}
    ItemUtil.AddItems("LovePlus/LovePlusImg",imgItems,infos,imgParent,nil,1,data:GetID())
end

function SetRight()
    SetItems()
end

function SetItems()
    if #curDatas > 0 then
        layout:IEShowList(curDatas,OnLoadSuccess,currIndex)
    else
        StartShowChat()
    end
end

function OnLoadSuccess()
    StartShowChat()
end

---------------------------------------------对话流程---------------------------------------------

--获取新对话
function StartShowChat()
    newChatListData = LovePlusMgr:GetNewChatListData(data:GetID())
    if newChatListData then
        newChatDatas = LovePlusMgr:GetNewChatArr(data:GetID())
        if #curDatas > 0 then
            currShowData = curDatas[#curDatas]
        end
        ShowNextChat()
    end
end

function ShowNextChat()
    SetSrState(false) -- 暂停sv组件
    if currShowData then 
        if currShowData:IsTemp() then  --临时数据
            local ids = currShowData:GetNextIDs()
            if ids and #ids> 0 then
                for _, id in ipairs(ids) do
                    local chatData = LovePlusMgr:GetChatData(id,newChatListData:GetID())
                    if chatData and chatData:IsShow() then
                        curDatas[#curDatas] = chatData --替换数据
                        currShowData = chatData
                        break
                    end
                end
            end
        end
        --下一句是选项对话或是跳转对话,创建一个临时数据
        if not currShowData:IsTemp() and (currShowData:GetShowType() == 3 or currShowData:GetShowType() == 4) then 
            local chatData = LovePlusChatData.New()
            chatData:Init(currShowData:GetCfg(),true)
            table.insert(newChatDatas,1,chatData)
            SetSrState(true) -- 恢复sv组件
        end
    end

    if #newChatDatas < 1 then
        SetSrState(true) -- 恢复sv组件
        ShowChatFinish()
        return 
    end
    currShowData = GetNewChatData()
    if currShowData == nil then
        return
    end
    table.insert(curDatas,currShowData)

    layout:IEShowList(curDatas,OnNextChatShow)
end

function OnNextChatShow()
    MoveToEnd(function()
        local lua = layout:GetItemLua(#curDatas)
        if lua then
            lua.ShowChat()
        end
    end)
end

function ShowChatFinish()
    if not newChatListData or not newChatListData:IsOpen() then --未解锁
        return  
    end
    if not currShowData or currShowData:GetNextIDs() then --不是最后一句
        return 
    end
    local ids = {}
    local options = LovePlusMgr:GetOptionChatArr(data:GetID(),newChatListData:GetID())
    if #options > 0 then
        for i, v in ipairs(options) do
            table.insert(ids,v:GetID())
        end
    end
    if currShowData:GetStoryID() and not LovePlusMgr:CheckChatIsRead(currShowData:GetID()) then
        local storyId = currShowData:GetStoryID()
        updateCB = function()
            LovePlusMgr:TryOpenPlot(data:GetID(),storyId,function ()
                if CSAPI.IsViewOpen("LovePlusListView") then
                    CSAPI.OpenView("LovePlusListView",data,{type = 2,id = storyId,storyID = storyId})
                end
            end)
        end
        currShowData = nil
    end
    layout:IEShowList(curDatas) --刷新列表
    LovePlusMgr:ClearNewChatListData(data:GetID())
    LovePlusProto:SaveChatData(data:GetID(),newChatListData:GetID(),ids)    

    --打点
	BuryingPointMgr:TrackEventsByDay("love_plus_chat_finish",{
		time = TimeUtil:GetTimeStr2(TimeUtil:GetTime(),true),
		groupId = tostring(newChatListData:GetID()),
		sectionId = tostring(data:GetID()),
        options = table.tostring(ids)
	})
end

function GetNewChatData()
    if #newChatDatas > 0 then
        local chatData = table.remove(newChatDatas,1)
        if currShowData then
            if currShowData:GetID() > chatData:GetID() then--序号在前面的直接递归掉
                return GetNewChatData() 
            end
            if not currShowData:IsTemp() and currShowData:GetShowType() < 3 then --排除临时数据，选项对话，跳转对话
                if currShowData:GetNextIDs() and #currShowData:GetNextIDs() > 0 then --排除最后一句对话
                    if currShowData:GetNextIDs()[1] ~= chatData:GetID() then --对比
                        return GetNewChatData() --递归获取正确数据
                    end
                end
            end
        end
        return chatData
    end
end

function SetSrState(b)
    if sr == nil then
        sr = ComUtil.GetCom(sv,"ScrollRect")
    end
    if not IsNil(sr) then
        sr.enabled = b
    end
end

---------------------------------------------anim---------------------------------------------
function PlayAnim(delay,cb)
    CSAPI.SetGOActive(animMask,true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(animMask,false)
        if cb then
            cb()
        end
    end,this,delay)
end

function InitAnim()
    CSAPI.SetGOActive(animMask,false)
    CSAPI.SetGOActive(svMask,false)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go,false)
    CSAPI.SetGOActive(go,true)
end

function MoveToEnd(cb)
    local size = CSAPI.GetRTSize(itemParent)
    local svSize = CSAPI.GetRTSize(sv)
    local len = size[1]
    if svSize[1] > size[1] then
        len = 0
    else
        len = size[1] - svSize[1]
        local data = curDatas[#curDatas]
        if data then
            local _len = data:GetSize()
            len = len - (_len - 113)
        end
    end
    
    PlayAnim(200)
    CSAPI.MoveTo(itemParent,"UI_Local_Move",0,len,0,cb,0.2)
end