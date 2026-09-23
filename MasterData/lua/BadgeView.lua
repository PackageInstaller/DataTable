local groupCfgs = {}
local listItems= nil
local infoItem = nil
local currItem = nil
local showItem = nil
local equipDatas = {}
local selData = nil
local selIndex= 1
local isHideNew = false

function Awake()
    InitAnim()

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Badge_Data_Update,OnPanelRefresh)
    eventMgr:AddListener(EventType.Badge_Sort_Update,OnPanelRefresh)
end

function OnPanelRefresh()
    equipDatas = BadgeMgr:GetSortArr() or {}
    if selData == nil then
        selData = equipDatas[selIndex]
    end
    SetLeft()
    SetShow()
    SetRight()
end

function OnDestroy()
    eventMgr:ClearListener()
    ClearNewInfo()
end

function OnInit()
    UIUtil:AddTop2("BadgeView", topParent, OnClickBack,OnClickHome);
end

function OnOpen()
    InitDatas()
    InitNewDatas()
    InitPanel()
end

function InitDatas()
    local cfgs = Cfgs.CfgBadgeGroup:GetAll()
    if cfgs then
        for k, v in pairs(cfgs) do
            if v.begTime then
                local sTime = TimeUtil:GetTimeStampBySplit(v.begTime)
                if TimeUtil:GetTime()>=sTime then
                    table.insert(groupCfgs,v)
                end
            else
                table.insert(groupCfgs,v)
            end
        end
    end
    if #groupCfgs >0 then
        table.sort(groupCfgs,function (a,b)
            return a.id < b.id
        end)
    end
    selIndex = data or 1
end

function InitNewDatas()
    local _datas = BadgeMgr:GetNewArr() or {}
    if #_datas > 0 then
        isHideNew = true
        CSAPI.OpenView("RewardBadge",_datas,{closeCallBack = PlayItemsAnim})
        BadgeMgr:UpdateNewDatas()
    end
end

function InitPanel()
    equipDatas = BadgeMgr:GetSortArr() or {}
    selData = equipDatas[selIndex]
    listItems = listItems or {}
    ItemUtil.AddItems("Badge/BadgeListItem",listItems,groupCfgs,grid,OnItemClickCB,1,
    {selData = selData,isHideNew = isHideNew},OnLoadSuccseMove)
    if selData==nil then --下方选中物体有数据走子物体点击刷新
        SetRight()
    end
    SetShow()
end

function RefreshPanel()
    equipDatas = BadgeMgr:GetSortArr() or {}
    selData = equipDatas[selIndex]
    SetLeft()
    SetShow()
    SetRight()
end

function SetLeft()
    listItems = listItems or {}
    ItemUtil.AddItems("Badge/BadgeListItem",listItems,groupCfgs,grid,OnItemClickCB,1,nil,SetGridHeight)
end

function OnItemClickCB(item)
    if currItem == item then
        selData = equipDatas[selIndex]
        item.SetSelect(false)
        currItem = nil
    else
        if currItem then
            currItem.SetSelect(false)
        end
        currItem = item
        currItem.SetSelect(true)
        
        selData = item.GetData()
    end
    SetRight()
    ShowRightAnim()
end

function SetGridHeight()
    local h = 0
    if listItems and #listItems > 0 then
        for i, v in ipairs(listItems) do
            local _,y =CSAPI.GetAnchor(v.gameObject)
            local size = CSAPI.GetRTSize(v.gameObject)
            if size then
                h = (math.abs(y) + size[1]) > h and math.abs(y) + size[1] or h
            end
        end
        h = h + 40
    end
    CSAPI.SetRTSize(grid,0,h)
end

--定位
function OnLoadSuccseMove()
    SetGridHeight()
    if selData then
        for i, v in ipairs(listItems) do
            if v.HasData(selData:GetID()) then
                local index = v.GetPosIndex()
                SVMove(index)
            end
        end
    end
    if not isHideNew then
        PlayItemsAnim()
    end
end

function SetRight()
    if infoItem then
        infoItem.Refresh(selData)
        infoItem.SetBtnState(selData,currItem and currItem.GetData() or nil,equipDatas[selIndex])
    else
        ResUtil:CreateUIGOAsync("Badge/BadgeItem2",infoParent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.SetClickCB(OnItemClickCB2)
            lua.SetSaveClickCB(OnSaveClickCB)
            lua.SetBtnClickCB(OnBtnClickCB)
            lua.Refresh(selData)
            lua.SetBtnState(selData,currItem and currItem.GetData() or nil,equipDatas[selIndex])
            infoItem = lua
        end)
    end
end

function OnItemClickCB2(_data)
    selData = _data
    infoItem.SetBtnState(_data,currItem and currItem.GetData() or nil,equipDatas[selIndex])
end

function OnBtnClickCB(_data)
    if not _data then
        return 
    end

    if not _data:IsGet() then
        return
    end


    local id = nil
    local isEquip,index = BadgeMgr:IsEquip(_data:GetID())
    if not isEquip then --替换
        id = _data:GetID()
    elseif isEquip and index ~= selIndex then --换位置
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(36004)
        dialogData.okCallBack=function ()
            BadgeMgr:UpdateSort(index,nil)
            BadgeMgr:UpdateSort(selIndex,_data:GetID())
            if currItem then
                currItem.PlayChangeAnim2()
                currItem.SetSelect(false)
                currItem = nil
            end
            RefreshPanel()
            if showItem and showItem.GetCurrItem() then
                showItem.GetCurrItem().PlayChangeAnim1()
            end
        end
        CSAPI.OpenView("Dialog",dialogData)
        return
    end
    local sortId = BadgeMgr:GetSort(selIndex)
    if not sortId or sortId ~= id then
        BadgeMgr:UpdateSort(selIndex,id)
        if currItem then
            currItem.PlayChangeAnim2()
            currItem.SetSelect(false)
            currItem = nil
        end
        RefreshPanel()
        if showItem and showItem.GetCurrItem() then
            showItem.GetCurrItem().PlayChangeAnim1()
        end
    end
end

function OnSaveClickCB()
    BadgeMgr:SendSorts()
end

function SetShow()
    if showItem then
        showItem.Refresh(equipDatas,{selIndex = selIndex,isHideNew = isHideNew})
    else
        ResUtil:CreateUIGOAsync("Badge/BadgeItem1",showParent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.SetClickCB(OnShowItemClickCB)
            lua.Refresh(equipDatas,{selIndex = selIndex,isHideNew = isHideNew})
            showItem = lua
        end)
    end
end

function OnShowItemClickCB(item)
    if currItem == nil then
        selData = item.GetData()
        ShowRightAnim()
    end
    selIndex = item.index
    SetRight()
end

function OnClickBack()
    if BadgeMgr:IsChange() then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(36003)
        dialogData.okCallBack = function()
            BadgeMgr:Restore()
            view:Close()
        end
        CSAPI.OpenView("Dialog",dialogData)
    else
        view:Close()
    end
end

function OnClickHome()
    if BadgeMgr:IsChange() then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(36003)
        dialogData.okCallBack = function()
            BadgeMgr:Restore()
            UIUtil:ToHome()
        end
        CSAPI.OpenView("Dialog",dialogData)
    else
        UIUtil:ToHome()
    end
end

function ClearNewInfo()
    local newInfos = FileUtil.LoadByPath("Badge_new_info.txt") or {} -- 记录new
    for k, v in pairs(newInfos) do
        newInfos[k] = 0
    end
    FileUtil.SaveToFile("Badge_new_info.txt", newInfos)
end

--------------------------------anim--------------------------------
function PlayAnim(time)
    CSAPI.SetGOActive(animMask,true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(animMask,false)
    end,this,time)
end

function InitAnim()
    CSAPI.SetGOActive(animMask,false)
    CSAPI.SetGOActive(enterAction,false)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go,false)
    CSAPI.SetGOActive(go,true)
end

function SVMove(index,callback)
    local x = CSAPI.GetLocalPos(grid)
    CSAPI.MoveTo(grid,"UI_Local_Move",x,(index - 1) * 142,0,callback,0.2)
end

function PlayItemsAnim()
    PlayAnim()
    if listItems and #listItems > 0 then
        for i, v in ipairs(listItems) do
            v.PlayEnterAnim()
        end
    end
    ShowEffect(enterAction)
end

function ShowRightAnim()
    if infoItem then
        infoItem.ShowSelAnim()
    end
end