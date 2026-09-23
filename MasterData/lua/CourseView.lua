local layout = nil
local sectionData =nil
local curDatas = {}
local selItem = nil
local itemInfo = nil
local selIndex = nil
local numSlider = nil
local top=nil
function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Course/CourseItem", LayoutCallBack, true)

    numSlider = ComUtil.GetCom(slider, "Slider")
    SetOutRed()
end

function OnInit()
    top = UIUtil:AddTop2("CourseView", gameObject, OnClickReturn, nil)
   top.SetMoney({{ITEM_ID.DIAMOND,140001}})
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data)
        if selIndex == index then
            lua.OnClick()
        end
    end
end

function OnItemClickCB(item)
    if selItem then
        selItem.SetSelect(false)
    end
    selItem = item
    selItem.SetSelect(true)

    ShowItemInfo(item)
end

function OnOpen()
    local datas = DungeonMgr:GetScetionDatas(SectionType.Course)
    if datas == nil then
        return
    end
    sectionData = datas[1]

    if sectionData then
        local cfgs = sectionData:GetDungeonCfgs()
        if cfgs then
            for k, v in pairs(cfgs) do
                table.insert(curDatas,v)
            end
        end
        if #curDatas > 0 then
            table.sort(curDatas,function (a,b)
                return a.id < b.id
            end)
        end
    end

    ShowBtnPanel()

    ShowSV()

    if data then
        FuncUtil:Call(function ()
            ShowSV(true)
        end,nil,200)
    end
end

function ShowBtnPanel()
    local curCount,maxCount,curNum,maxNum = 0,0,0,0
    if #curDatas > 0 then
        for _, cfg in ipairs(curDatas) do
            local dungeonData = DungeonMgr:GetDungeonData(cfg.id)
            if dungeonData and dungeonData:IsPass() then
                curNum = curNum + 1
            end
            if cfg.fisrtPassReward then --首通
                for k, reward in ipairs(cfg.fisrtPassReward) do
                    if reward[1] == ITEM_ID.DIAMOND then
                        if dungeonData and dungeonData:IsPass() then
                            curCount = curCount + reward[2]
                        end
                        maxCount = maxCount + reward[2]
                    end
                end
            end
            if cfg.fisrt3StarReward then --三星
                for k, reward in ipairs(cfg.fisrt3StarReward) do
                    if reward[1] == ITEM_ID.DIAMOND then
                        if dungeonData and dungeonData:GetStar() >= 3 then
                            curCount = curCount + reward[2]
                        end
                        maxCount = maxCount + reward[2]
                    end
                end
            end
        end
        maxNum = #curDatas
    end
    CSAPI.SetText(txtNum1,curNum .. "")
    CSAPI.SetText(txtNum2,"/" .. maxNum)
    CSAPI.SetText(txtCount1,curCount.. "")
    CSAPI.SetText(txtCount2,"/" .. maxCount)
    numSlider.value = curNum/maxNum
end

function ShowSV(b)
    --left
    CSAPI.SetGOActive(imgL, not b)
    local x = b and -250 or 0
    CSAPI.SetAnchor(moveL,x,0)
    local h = b and 624 or 700
    CSAPI.SetRTSize(topImg,28,h)
    local w = b and 543 or 613
    CSAPI.SetRTSize(topImg2,w,6)

    --right
    if (CSAPI.RegionalCode() == 4 or CSAPI.RegionalCode() == 6) and CSAPI.ReviewMode() then
        CSAPI.SetGOActive(right, false)
    else
        CSAPI.SetGOActive(right, not b)
    end
    

    --center
    x = b and 0 or 319
    CSAPI.SetAnchor(moveC,x,0)
    CSAPI.SetGOActive(vsv,b)

    --itemInfo
    if b then
        selIndex = selItem and selItem:GetIndex() or 0
        if selIndex < 1 then --没选中自动获取最新关卡
            for i, v in ipairs(curDatas) do
                if DungeonMgr:IsDungeonOpen(v.id) then
                    selIndex = i
                end
            end
            -- selItem = layout:GetItemLua(index)
        end
        layout:IEShowList(#curDatas, nil, selIndex)
        -- ShowItemInfo(selItem)
    else
        selItem = nil
        ShowItemInfo()
    end
end

function ShowItemInfo(item)
    if itemInfo then
        itemInfo.Show(item and item.GetCfg() or nil,DungeonInfoType.Course)
    else
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.SetClickCB(OnBattleEnter)
            itemInfo.Show(item and item.GetCfg() or nil,DungeonInfoType.Course)
        end)
    end
end

function OnBattleEnter()
    if (selItem) then
        if selItem.GetCfg() and selItem.GetCfg().arrForceTeam ~= nil then -- 强制上阵编队
            CSAPI.OpenView("TeamForceConfirm", {
                dungeonId = selItem.GetCfg().id,
                teamNum = selItem.GetCfg().teamNum or 1
            })
        else
            CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                dungeonId = selItem.GetCfg().id,
                teamNum = selItem.GetCfg().teamNum or 1
            }, TeamConfirmOpenType.Dungeon)
        end
        if CSAPI.IsADV()==false then
            BuryingPointMgr:TrackEvents("main_fight", {
                reason = "进入副本",
                world_id = sectionData:GetID(),
                card_id = selItem.GetID()
            })
        end
    end
end

function OnClickCourse1()
    if selItem then
        return
    end
    ShowSV(true)
end

function OnClickCourse2()
    CSAPI.OpenView("ArchiveCourseView")
end

function OnClickBack()
    -- if itemInfo.IsShow() then
    --     ShowSV()
    -- end
end

function OnClickReturn()
    if itemInfo.IsShow() then
        ShowSV()
    else 
        view:Close()
    end
end


---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if  top.OnClickBack then
        top.OnClickBack();
    end
end

function SetOutRed()
    local _data = RedPointMgr:GetData(RedPointType.CourseView)
    if(_data)then 
       RedPointMgr:UpdateData(RedPointType.CourseView, nil)
    end
end