local collectItem = nil
local layout1 = nil
local listDatas= nil
local slider = nil

local curDatas = nil
local finishIndex= 1
local layout2 = nil
local mTab = nil
local lastTabIndex = 1

function Awake()
    layout1=ComUtil.GetCom(vsv,"UISV");
    layout1:Init("UIs/Achievement/AchievementListItem1",LayoutCallBack1,true);
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)
    slider= ComUtil.GetCom(numSlider, "Slider")

    layout2=ComUtil.GetCom(hsv,"UISV");
    layout2:Init("UIs/Achievement/AchievementListItem2",LayoutCallBack2,true);
    tlua2 = UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.MoveByType2,{"RTL"})

    mTab = ComUtil.GetCom(tabs,"CTab")
    mTab:AddSelChangedCallBack(OnTabChanged)

    InitAnim()
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = listDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnClickItemCB1)
        lua.Refresh(_data)
    end
end

function OnClickItemCB1(item)
    local _data = item.GetData()
    CSAPI.OpenView("Achievement",nil,{group = _data:GetID()})
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnClickItemCB2)
        lua.Refresh(_data)
    end
end

--AchievementData
function OnClickItemCB2(item)
    local _data = item.GetData()
    CSAPI.OpenView("Achievement",nil,{group = _data:GetType(),itemId = _data:GetID()})
end

function OnTabChanged(index)
    if lastTabIndex ~= index then
        lastTabIndex = index
        finishIndex = index
        RefreshBottomPanel()
    end
end

function Refresh(_data,_elseData)
    RefreshCollet()
    RefreshRightPanel()
    RefreshBottomPanel()
    PlayEnterAnim()
end

function RefreshCollet()
    if collectItem then
        collectItem.Refresh()
    else
        ResUtil:CreateUIGOAsync("Achievement/Achievementitem1",itemParent1,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh()
            collectItem=lua
        end)
    end
end

function RefreshRightPanel()
    local cur,max = AchievementMgr:GetCount()
    CSAPI.SetText(txtNum2,cur.."")
    CSAPI.SetText(txtNum1,"/" .. max)
    slider.value = cur / max
    listDatas = AchievementMgr:GetListArr()
    tlua1:AnimAgain()
    layout1:IEShowList(#listDatas)
end

function RefreshBottomPanel()
    curDatas = AchievementMgr:GetArr2(finishIndex == 1, true)
    tlua2:AnimAgain()
    layout2:IEShowList(#curDatas)
    CSAPI.SetGOActive(emptyObj,#curDatas == 0)
    if #curDatas == 0 then
        LanguageMgr:SetText(txtEmpty,finishIndex == 1 and 47004 or 47005)
    end
end

----------------------------------------anim----------------------------------------
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

function PlayEnterAnim()
    PlayAnim(400)
    ShowEffect(enterAction)
end