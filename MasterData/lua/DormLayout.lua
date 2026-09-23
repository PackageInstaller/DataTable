local mainIndex = nil -- 1:主题家具   2：家具部件  3：自由方案
local curThemeID = nil -- 当前选择的主题下标
local curTypeIndex = 2 -- 当前家具类型下标
local curDataType = nil -- 子数据类型 1：主题表 2：家具 3：主题数据

local isDetail = false -- 展开 
local isMove = false
local isSelecting = false -- 选中一件家具编辑中 
local isInWall = false -- 当前选中的家具在墙
local themeSort = {1, 1} -- 1:默认 2:舒适度  3：价格    ； 1：降序 2：升序
local funitureSort = {1, 1} -- 1:默认 2:舒适度  3：价格 ； 1：降序 2：升序
local needToFirst = false 

function Awake()
    sr1_sr = ComUtil.GetComInChildren(hsv,"ScrollRect")
    sr2_sr = ComUtil.GetComInChildren(vsv,"ScrollRect")

    layout1 = ComUtil.GetCom(hsv, "UIInfinite")
    layout1:Init("UIs/Dorm2/DormLayoutItem", LayoutCallBack1, true)
    sr1 = layout1:GetSR()

    layout2 = ComUtil.GetCom(vsv, "UIInfinite")
    layout2:Init("UIs/Dorm2/DormLayoutItem", LayoutCallBack2, true)
    sr2 = layout2:GetSR()

    -- 输入
    input = ComUtil.GetCom(InputField, "InputField")
    CSAPI.AddInputFieldChange(InputField, InputChange)
    CSAPI.AddInputFieldCallBack(InputField, InputCB)

    -- event 
    eventMgr = ViewEvent.New()
    -- 选中家具与否
    eventMgr:AddListener(EventType.Dorm_Furnitrue_Select, function(_data)
        isSelecting = _data[1]
        isInWall = _data[2]
        Refresh()
    end)
    eventMgr:AddListener(EventType.Dorm_Theme_Buy, Refresh)
    eventMgr:AddListener(EventType.Dorm_Furniture_Buy, Refresh)
    eventMgr:AddListener(EventType.Dorm_SaveTheme_Change, Refresh)

    -- 开始滑动/结束滑动
    eventMgr:AddListener(EventType.Input_Scene_Matrix_Move, function(num)
        local y = num == 1 and 100000 or 0
        CSAPI.SetAnchor(gameObject, 0, y, 0)
    end)
    
    AdaptiveConfiguration.SetLuaObjUIFit("DormLayout",gameObject)
end

function OnDisable()
    input.text = ""
    mainIndex = nil
    curThemeID = nil
    curTypeIndex = 2
    curDataType = nil
    isDetail = false
    isMove = false
    isSelecting = false
    isInWall = false
    themeSort = {1, 1}
    funitureSort = {1, 1}
    CSAPI.SetAnchor(node, 0, -400, 0)
    CSAPI.SetAnchor(main, 0, -400, 0)
end

function OnDestroy()
    eventMgr:ClearListener()
    CSAPI.RemoveInputFieldChange(InputField, InputChange)
    CSAPI.RemoveInputFieldCallBack(InputField, InputCB)


    AdaptiveConfiguration.LuaView_Lua_Closed("DormLayout")
end
function InputChange(str)
    input.text = StringUtil:FilterChar(str) --str
    SetNode()
end
function InputCB(str)
    input.text = StringUtil:FilterChar(str) --str
    SetNode()
end
function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index, ItemClickCB1)
        -- lua.SetScrollRect(sr1)
        lua.Refresh(curDataType, _data)
    end
end
function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index, ItemClickCB2)
        -- lua.SetScrollRect(sr2)
        lua.Refresh(curDataType, _data)
    end
end
function ItemClickCB1(item)
    needToFirst = true 
    local _data = item.data
    if (curDataType == 1) then
        -- 点选某主题
        curThemeID = _data.id
        Refresh()
    elseif (curDataType == 3) then
        -- 点选保存的方案
        CSAPI.OpenView("DormLayoutThemeCof", {ThemeType.Save, _data})
    elseif (curDataType == 2) then
        -- 点选家具
        ItemClickCB2(item)
    end
end

-- 点选家具
function ItemClickCB2(item)
    local _data = item.data
    if (curDataType == 1) then
        -- 点选某主题
        curThemeID = _data.id
        Refresh()
        return
    end
    --是否还有位置 (墙、地面、墙饰忽略；地毯单独算)
    if(_data.sType~=0 and _data.sType~=1 and _data.sType~=7 and _data.sType~=8) then 
        local roleNum = DormMgr:GetCurRoomData():GetNum()
        local fNum = DormMgr:GetFurnitureGridNum()
        local hadNum = 256-fNum-roleNum
        local needNum = math.ceil(_data.scale[1]*_data.scale[3])
        if(hadNum<=needNum) then 
            LanguageMgr:ShowTips(21035)
            return 
        end
    end 
    -- 已放置高亮
    if (item.iSet) then
        EventMgr.Dispatch(EventType.Dorm_UIFurnitrue_Click, _data.id)
    end
    -- 是否还有
    if (curDataType ~= 2 or item.cur <= 0) then
        return
    end
    -- 数量限制
    local curCount, maxCount = DormMgr:GetCurRoomCopyNum()
    if (curCount >= maxCount) then
        LanguageMgr:ShowTips(21030)
        return
    end

    local planeType = 1 -- 地面或者墙纸不用用到这个选项
    local cfg = Cfgs.CfgFurniture:GetByID(_data.id)
    if (cfg.sType == DormFurnitureType.hangings) then
        planeType = 2 -- 默认放在左墙壁
    end
    local _x = planeType == 2 and 8 or 0
    local _y = planeType == 2 and 2.5 or 0
    local _data = {_data.id, {
        x = _x,
        y = _y,
        z = 0
    }, planeType, 0}
    local _datas = {_data, true}
    EventMgr.Dispatch(EventType.Dorm_Furniture_Add, _datas) -- 推送到DormMain 生成3d物体
end

-- function OnBeginDragXY(data)
--     AddMoveItem(true, data)
-- end
-- function OnEndDragXY(data)
--     AddMoveItem(false, data)
-- end

-- -- 生成拖拽item
-- function AddMoveItem(add, data)
--     if (add) then
--         if (dormLayoutMoveItem == nil) then
--             local go = ResUtil:CreateUIGO("Dorm/DormLayoutMoveItem", transform)
--             dormLayoutMoveItem = ComUtil.GetLuaTable(go)
--         else
--             CSAPI.SetGOActive(dormLayoutMoveItem.gameObject, true)
--         end
--         CSAPI.SetAnchor(dormLayoutMoveItem.gameObject, 0, 10000, 0)
--         dormLayoutMoveItem.Refresh(data)
--     else
--         if (dormLayoutMoveItem) then
--             CSAPI.SetGOActive(dormLayoutMoveItem.gameObject, false)
--         end
--     end
--     isSelecting = add
--     Refresh()
-- end

--------------------------------------------------------------------------------------------------------
function Init(_dormView)
    dormView = _dormView
end

-- 重新打开界面
function Refresh()
    SetBtns()
    SetMain()
    SetNode()
end

function RefreshPanel()

end

function SetBtns()
    -- btns 
    CSAPI.SetGOActive(btns, isSelecting)
    CSAPI.SetGOActive(btnRotate, not isInWall)
    -- -- clear 
    -- CSAPI.SetGOActive(clear, mainIndex ~= nil)
    -- -- save 
    -- CSAPI.SetGOActive(save, mainIndex ~= nil)
end

function SetMain()
    if (isSelecting) then
        CSAPI.SetGOActive(main, false)
        CSAPI.SetAnchor(main, 0, -400, 0)
        return
    end
    if (mainIndex ~= nil) then
        SetGoPos(main, -400, function()
            CSAPI.SetGOActive(main, false)
        end)
        return
    end
    CSAPI.SetGOActive(main, true)
    SetGoPos(main, 0)

    -- 主题家具
    if (not themeCfgLen) then
        themeCfgLen = 0
        local cfgThemeDatas = Cfgs.CfgFurnitureTheme:GetAll()
        for k, v in pairs(cfgThemeDatas) do
            if(DormMgr:CheckIsOpen(v) and  not v.hide) then 
                themeCfgLen = themeCfgLen + 1
            end 
        end
    end
    -- 家具部件
    CSAPI.SetText(txtCount2, DormMgr:GetBuyCounts() .. "")

    -- 系统主题，保存主题（一起请求一次）
    if (not isGet) then
        isGet = 1
        DormProto:GetSelfTheme({ThemeType.Sys, ThemeType.Save}, function()
            -- local sysDatas = DormMgr:GetThemes(ThemeType.Sys) --系统主题购买数量
            local num = DormMgr:GetThemeBuyCount()
            CSAPI.SetText(txtCount1, string.format("%s/%s", num, themeCfgLen))

            local saveDatas = DormMgr:GetThemes(ThemeType.Save)
            CSAPI.SetText(txtCount3, #saveDatas .. "")
        end)
    else
        -- local sysDatas = DormMgr:GetThemes(ThemeType.Sys)
        local num = DormMgr:GetThemeBuyCount()
        CSAPI.SetText(txtCount1, string.format("%s/%s", num, themeCfgLen))

        local saveDatas = DormMgr:GetThemes(ThemeType.Save)
        CSAPI.SetText(txtCount3, #saveDatas .. "")
    end

    -- -- 系统主题，显示已购买的
    -- local sysDatas = DormMgr:GetThemes(ThemeType.Sys)
    -- if (curDatas1 == nil) then
    --     DormProto:GetSelfTheme(ThemeType.Sys, function()
    --          sysDatas = DormMgr:GetThemes(ThemeType.Sys)
    --         CSAPI.SetText(txtCount1, string.format("%s/%s", #sysDatas, themeCfgLen))
    --     end)
    -- else
    --     CSAPI.SetText(txtCount1, string.format("%s/%s", #sysDatas, themeCfgLen))
    -- end

    -- -- 自由方案 
    -- local saveDatas = DormMgr:GetThemes(ThemeType.Save)
    -- if (saveDatas == nil) then
    --     DormProto:GetSelfTheme(ThemeType.Save, function()
    --         saveDatas = DormMgr:GetThemes(ThemeType.Save)
    --         CSAPI.SetText(txtCount3, #saveDatas .. "")
    --     end)
    -- else
    --     CSAPI.SetText(txtCount3, #saveDatas .. "")
    -- end
end

function SetGoPos(go, newY, cb)
    local x, oldY = CSAPI.GetAnchor(go)
    if (oldY ~= newY) then
        UIUtil:SetPObjMove(go, 0, 0, oldY, newY, 0, 0, function()
            isMove = false
            if (cb) then
                cb()
            end
        end, 300, 0)
    end
end

function SetNode()
    if (isSelecting) then
        CSAPI.SetGOActive(node, false)
        CSAPI.SetAnchor(node, 0, -400, 0)
        return
    end

    if (mainIndex == nil) then
        SetGoPos(node, -400, function()
            CSAPI.SetGOActive(node, false)
        end)
        return
    end
    -- 
    CSAPI.SetGOActive(node, true)
    local newY = isDetail and 465 or 0
    SetGoPos(node, newY)

    -- sv
    CSAPI.SetGOActive(hsv, not isDetail)
    CSAPI.SetGOActive(vsv, isDetail)

    -- curDatas 
    SetCurDatas()
    local _index = needToFirst and 1 or 0
    if (isDetail) then
        sr2_sr.enabled = false 
        sr2_sr.enabled = true 
        layout2:IEShowList(#curDatas,nil,_index)
    else
        sr1_sr.enabled = false 
        sr1_sr.enabled = true 
        layout1:IEShowList(#curDatas,nil,_index)
    end 
    
    -- title 
    local titleImgName = nil
    local titleName1, titleName2 = "", ""
    -- if (mainIndex == nil) then
    --     titleImgName = "img_05_01"
    --     titleName1 = LanguageMgr:GetByID(32070)
    --     titleName2 = LanguageMgr:GetByType(32070, 3)
    -- else
    if (mainIndex == 1) then
        if (curThemeID ~= nil) then
            titleImgName = "btn_14_01"
            local themeCfg = Cfgs.CfgFurnitureTheme:GetByID(curThemeID)
            titleName1 = themeCfg.sName
            titleName2 = themeCfg.sEnName
        else
            titleImgName = "img_05_01"
            titleName1 = LanguageMgr:GetByID(32070)
            titleName2 = LanguageMgr:GetByType(32070, 4)
        end
    elseif (mainIndex == 2) then
        titleName1 = LanguageMgr:GetByID(32071)
        titleName2 = LanguageMgr:GetByType(32071, 4)
    elseif (mainIndex == 3) then
        titleName1 = LanguageMgr:GetByID(32072)
        titleName2 = LanguageMgr:GetByType(32072, 4)
    end
    CSAPI.SetGOActive(imgTitleBg, titleImgName ~= nil)
    if (titleImgName) then
        CSAPI.LoadImg(imgTitle, "UIs/Dorm2/" .. titleImgName .. ".png", true, nil, true);
    end
    CSAPI.SetText(txtNodeTitle1, titleName1)
    CSAPI.SetText(txtNodeTitle2, titleName2)

    -- top
    CSAPI.SetGOActive(top12, mainIndex ~= 3)
    CSAPI.SetGOActive(top3, mainIndex == 3)
    if (mainIndex == 3) then
        SetTop3()
    else
        SetTop12()
    end

    -- layout 
    if (mainIndex == 1 and curThemeID ~= nil) then
        CSAPI.SetGOActive(btnLayout, true)
    else
        CSAPI.SetGOActive(btnLayout, false)
    end
    -- furGrids 
    CSAPI.SetGOActive(furGrids, mainIndex == 2)
    if (mainIndex == 2) then
        furItems = furItems or {}
        local cfgs = Cfgs.CfgFurnitureEnum:GetAll()
        -- local _cfgs = table.copy(cfgs)
        -- table.sort(_cfgs, function(a, b)
        --     return a.index < b.index
        -- end)
        ItemUtil.AddItems("Dorm2/DormLayoutItem2", furItems, cfgs, furGrids, FurItemCB, 1, curTypeIndex)
    end
end

function FurItemCB(_curTypeIndex)
    curTypeIndex = _curTypeIndex
    SetNode()
end

function SetTop12()
    -- sort 
    local imageName = "btn_06_02"
    if (mainIndex == 1 and curThemeID == nil) then
        imageName = themeSort[2] == 1 and "btn_06_02" or "btn_06_01"
    else
        imageName = funitureSort[2] == 1 and "btn_06_02" or "btn_06_01"
    end
    CSAPI.LoadImg(imgSort, "UIs/Dorm2/" .. imageName .. ".png", true, nil, true)
    -- detail 
    CSAPI.SetAngle(imgDetail, 0, 0, isDetail and 180 or 0)
end

function SetTop3()
    -- limit
    CSAPI.SetText(txtPreinstallLimit, #curDatas .. "/" .. g_DormSaveLimt)
    -- btn 
    if (not cg_save) then
        cg_save = ComUtil.GetCom(btnSavePreinstall, "CanvasGroup")
    end
    cg_save.alpha = #curDatas >= g_DormSaveLimt and 0.3 or 1
end

function SetCurDatas()
    curDatas = {}
    curDataType = 1
    local furnitureCfgs = nil
    if (mainIndex == 1) then
        if (curThemeID ~= nil) then
            -- 单个主题的家具数据(去重复)
            furnitureCfgs = {}
            local dic = {}
            local themeCfg = Cfgs.CfgFurnitureTheme:GetByID(curThemeID)
            local cfg = Cfgs.CfgThemeLayout:GetByID(themeCfg.layoutId)
            for k, v in ipairs(cfg.infos) do
                if (not dic[v.cfgID]) then
                    dic[v.cfgID] = 1
                    local cfg = Cfgs.CfgFurniture:GetByID(v.cfgID)
                    table.insert(furnitureCfgs, cfg)
                end
            end
        else
            -- 主题数据
            if (not themeCfgsArr) then
                themeCfgsArr = {}
                local themeCfgs = Cfgs.CfgFurnitureTheme:GetAll()
                for k, v in pairs(themeCfgs) do
                    if(DormMgr:CheckIsOpen(v) and  not v.hide) then 
                        table.insert(themeCfgsArr, v)
                    end 
                end
                table.sort(themeCfgsArr, function(a, b)
                    return a.id < b.id
                end)
            end
            -- 排序数据  
            curDatas = themeCfgsArr
            if (#curDatas > 1) then
                local func = SortByDefaultTheme
                if (themeSort[1] ~= 1) then
                    func = themeSort[1] == 2 and SortByComfort or SrotByPrice1
                end
                table.sort(curDatas, function(a, b)
                    local bo = func(a, b, themeSort[2])
                    if (bo ~= nil) then
                        return bo
                    else
                        return a.id < b.id
                    end
                end)
            end
            curDataType = 1
        end
    elseif (mainIndex == 2) then
        -- 家具数据(按类型划分)
        furnitureCfgs = {}
        local cfgs = Cfgs.CfgFurniture:GetAll()
        local themeHideDic = DormMgr:ThemeHideDic(false)
        for k, v in pairs(cfgs) do
            if (v.sType == curTypeIndex and not themeHideDic[v.theme]) then
                table.insert(furnitureCfgs, v)
            end
        end
    else
        -- 保存的方案
        curDatas = DormMgr:GetThemes(ThemeType.Save)
        table.sort(curDatas,function (a,b)
            return a.id<b.id
        end)
        curDataType = 3
    end

    -- 排序
    if (furnitureCfgs) then
        CacheSortData(furnitureCfgs)
        local func = SortByDefault
        if (funitureSort[1] ~= 1) then
            func = funitureSort[1] == 2 and  SortByComfort or SrotByPrice1
        end
        table.sort(furnitureCfgs, function(a, b)
            local bo = func(a, b, funitureSort[2])
            if (bo ~= nil) then
                return bo
            else
                return a.id < b.id
            end
        end)
        curDatas = furnitureCfgs
        curDataType = 2
        cacheDic = nil
    end

    -- 搜索
    local _curDatas = {}
    if (not StringUtil:IsEmpty(input.text)) then
        for k, v in ipairs(curDatas) do
            local name = curDataType == 3 and v.name or v.sName
            if (name == input.text) then
                table.insert(_curDatas, v)
            end
        end
        curDatas = _curDatas
    end
end

function OnClickShop()
    CSAPI.OpenView("DormShop")
end
--------------------------------------------------------------------------------------------------------
function OnClickMain1()
    mainIndex = 1
    Refresh()
end
function OnClickMain2()
    mainIndex = 2
    Refresh()
end
function OnClickMain3()
    mainIndex = 3
    Refresh()
end

-- 展开 
function OnClickDetail()
    if (isMove) then
        return
    end
    isMove = true

    isDetail = not isDetail
    Refresh()
end

-- 后退
function OnClickBack()
    if (mainIndex == 1 and curThemeID ~= nil) then
        curThemeID = nil
    else
        mainIndex = nil
    end
    if (mainIndex == nil) then
        isDetail = false
        curTypeIndex = 0
    end
    input.text = ""
    Refresh()
end

-- 快速布局(这里只有系统主题)
function OnClickLayout()
    if (curThemeID) then
        EventMgr.Dispatch(EventType.Dorm_Theme_Change, {ThemeType.Sys, {
            id = curThemeID
        }})
        LanguageMgr:ShowTips(21026)
        RefreshLayout()
    end
end

-- 排序
function OnClickSort()
    local sort = {}
    if (curThemeID ~= nil or mainIndex == 2) then
        sort = funitureSort
    else
        sort = themeSort
    end
    CSAPI.OpenView("DormLayoutSort", {sort, isDetail, SetSortCB})
end
function SetSortCB(sort)
    if (curThemeID ~= nil or mainIndex == 2) then
        funitureSort = sort
    else
        themeSort = sort
    end
    SetNode()
end

-- 保存方案
function OnClickSavePreinstall()
    local saveDatas = DormMgr:GetThemes(ThemeType.Save)
    if (#saveDatas < g_DormSaveLimt) then
        CSAPI.OpenView("DormLayoutThemeSave")
    end
end

-- 旋转
function OnClickRotate()
    dormView.GetDormMain().tool:Rotate()
end

-- 回收当前
function OnClickRecycle()
    dormView.GetDormMain().tool:Recycle()
    Refresh()
end

-- 确定
function OnClickSure()
    dormView.GetDormMain().tool:Sure()
end

-- 清空（回收所有）
function OnClickClear()
    UIUtil:OpenDialog(LanguageMgr:GetTips(21004), function()
        dormView.GetDormMain().tool:Clear()
    end)
end

-- 还原
function OnClickRestore()
    local str = LanguageMgr:GetTips(21029)
    UIUtil:OpenDialog(str, function()
        dormView.GetDormMain().tool:DontSave()
        dormView.GetDormMain().tool:InSelect(false)
    end)
end

-- 保存并退出(全部)
function OnClickSave()
    if (dormView.GetDormMain().tool:CheckCanSave()) then
        dormView.GetDormMain().tool:Sure() -- 先保存编辑中的家具
        dormView.GetDormMain().tool:Save()
    else
        LanguageMgr:ShowTips(21031)
    end
end

-- function OnClickFind()
--     SetNode()
-- end

----------------------------------------------------排序----------------------------------------------------
-- 已购未放置家具>已放置>未拥有
function CacheSortData(cfgs)
    cacheDic = {}
    for k, v in pairs(cfgs) do
        local index = 1
        local cur, max, use = DormMgr:GetFurnitureCount(v.id)
        if (max > 0) then
            if (cur <= 0) then
                index = 2
            else
                index = cur == max and 4 or 3
            end
        end
        cacheDic[v.id] = index
    end
end

-- 默认排序 未放置家具>已放置>未拥有
function SortByDefault(a, b, ud)
    local index1 = cacheDic[a.id]
    local index2 = cacheDic[b.id]
    if (index1 == index2) then
        return nil
    else
        if (ud == 1) then
            return index1 > index2
        else
            return index1 < index2
        end
    end
end

-- 舒适度排序
function SortByComfort(a, b, ud)
    if (a.comfort == b.comfort) then
        return nil
    else
        if (ud == 1) then
            return a.comfort > b.comfort
        else
            return a.comfort < b.comfort
        end
    end
end
-- 价格1
function SrotByPrice1(a, b, ud)
    if (a.price_1[1][2] == b.price_1[1][2]) then
        return nil
    else
        if (ud == 1) then
            return a.price_1[1][2] > b.price_1[1][2]
        else
            return a.price_1[1][2] < b.price_1[1][2]
        end
    end
end

-- -- 面积
-- function SrotByScale(a, b, ud)
--     local aScale = a.scale and a.scale[1] * a.scale[2] * a.scale[3] or 1
--     local bScale = b.scale and b.scale[1] * b.scale[2] * b.scale[3] or 1
--     if (aScale == bScale) then
--         return nil
--     else
--         if (ud == 1) then
--             return aScale > bScale
--         else
--             return aScale < bScale
--         end
--     end
-- end
----------------------------------------------------排序end----------------------------------------------------
-- 默认排序 未放置家具>已放置>未拥有
function SortByDefaultTheme(a, b,ud)
    if (a.id == b.id) then
        return nil
    else
        if (ud == 1) then
            return a.id < b.id
        else
            return a.id > b.id
        end
    end
end


function RefreshLayout()
    if (isDetail) then
        layout2:UpdateList()
    else
        layout1:UpdateList()
    end
end
