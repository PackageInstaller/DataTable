curIndex1, curIndex2 = 1, 1
local MatrixCompoundData = require "MatrixCompoundData"
local selectUD = 1 -- 1:价格 2：品质
local priceUD = 2 -- 价格  1：由高到高低  2：由低到高
local qualityUD = 1 -- 品质

function Awake()
    AdaptiveConfiguration.SetLuaObjUIFit("MatrixCompound",gameObject)
    UIUtil:AddTop2("MatrixCompound", gameObject, function()
        view:Close()
    end, nil, {ITEM_ID.GOLD})

    layout = ComUtil.GetCom(vsv, "UISV")
    layout:Init("UIs/Compound/MatrixCompoundItem", LayoutCallBack, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.MatrixCompound)

    -- 排序
    ResUtil:CreateUIGOAsync("Sort/SortTop", sortParent, function(go)
        local lua = ComUtil.GetLuaTable(go)
        lua.Init(15, RefreshPanel)
    end)
    

end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data, heightIndex)
    end
end

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Matrix_Building_Update, function(ids)
        if (data and ids and ids[data:GetId()]) then
            RefreshPanel()
        end
    end)
    eventMgr:AddListener(EventType.Matrix_Compound_Success, function(proto)
        RefreshPanel()
    end)
    -- 背包
    eventMgr:AddListener(EventType.Bag_Update, function()
        layout:UpdateList()
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
    AdaptiveConfiguration.LuaView_Lua_Closed("MatrixCompound")

end

function OnOpen()
    isFirst = false
    InitIndex()
    InitCfgDatas()
    InitLeftPanel()
    RefreshPanel()
end

function InitIndex()
    -- 追踪  
    if (openSetting) then
        local cfg = Cfgs.CfgBCompoundOrder:GetByID(openSetting)
        curIndex1 = cfg.group
    end
end

function InitCfgDatas()
    if (not cfgDatas) then
        cfgDatas = {}
        local cfgs = Cfgs.CfgBCompoundOrder:GetAll()
        for k, v in pairs(cfgs) do
            cfgDatas[v.group] = cfgDatas[v.group] or {}
            local _data = MatrixCompoundData.New()
            _data:SetData(v)
            table.insert(cfgDatas[v.group], _data)
        end
    end
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftPoint.transform)
        leftPanel = ComUtil.GetLuaTable(go)
        local leftDatas = {}
        local leftChildDatas = {}
        local cfgs = Cfgs.CfgMatrixCompoundType:GetAll()
        for k, v in pairs(cfgs) do
            table.insert(leftDatas, {v.Name, "Compound/btn_02_01"})
        end
        leftPanel.Init(this, leftDatas, leftChildDatas)
    end
end

function RefreshPanel()
    -- SetUD()
    -- SetDatas()

    local _curDatas = cfgDatas[curIndex1] or {}
    curDatas = SortMgr:Sort(15, _curDatas)
    CSAPI.SetGOActive(SortNone, #curDatas <= 0)

    if (not isFirst and openSetting) then
        -- 追踪高亮
        isFirst = true
        heightIndex = 0
        for k, v in ipairs(curDatas) do
            if (v:GetID() == openSetting) then
                heightIndex = k
                break
            end
        end
        layout:IEShowList(#curDatas, function()
            heightIndex = 0
        end, heightIndex)
    else
        -- local showIndex = 0
        if (oldCurIndex1 ~= nil and oldCurIndex1 ~= curIndex1) then
            -- showIndex = 1
            -- tlua1:AnimAgain()
        end
        oldCurIndex1 = curIndex1
        layout:IEShowList(#curDatas)
    end
    -- 侧边动画
    leftPanel.Anim()
end

-- function SetUD()
--     -- color 
--     local code1 = selectUD == 1 and "ffc146" or "FFFFFF"
--     CSAPI.SetImgColorByCode(imgJG, code1)
--     CSAPI.SetTextColorByCode(txtJG, code1)

--     local code2 = selectUD == 2 and "ffc146" or "FFFFFF"
--     CSAPI.SetImgColorByCode(imgPJ, code2)
--     CSAPI.SetTextColorByCode(txtPJ, code2)

--     -- angle 
--     CSAPI.SetAngle(imgJG, 0, 0, (priceUD == 1) and -90 or 90)
--     CSAPI.SetAngle(imgPJ, 0, 0, (qualityUD == 1) and -90 or 90)
-- end

-- function SetDatas()
-- curDatas = cfgDatas[curIndex1] or {}
-- curDatas = SortMgr:Sort(15, _curDatas)
-- if (#curDatas > 1) then
--     table.sort(curDatas, function(a, b)
--         local num1 = a:CheckIsOpen() and 1 or 0
--         local num2 = b:CheckIsOpen() and 1 or 0
--         if (num1 == num2) then
--             if (selectUD == 1) then
--                 if (a:GetPriceNum() == b:GetPriceNum()) then
--                     return a:GetID() < b:GetID()
--                 else
--                     if (priceUD == 1) then
--                         return a:GetPriceNum() > b:GetPriceNum()
--                     else
--                         return a:GetPriceNum() < b:GetPriceNum()
--                     end
--                 end
--             else
--                 if (a:GetQuality() == b:GetQuality()) then
--                     return a:GetID() < b:GetID()
--                 else
--                     if (qualityUD == 1) then
--                         return a:GetQuality() > b:GetQuality()
--                     else
--                         return a:GetQuality() < b:GetQuality()
--                     end
--                 end
--             end
--         else
--             return num1 > num2
--         end
--     end)
-- end
-- end

-- -- 价格
-- function OnClickJG()
--     selectUD = 1
--     priceUD = priceUD == 1 and 2 or 1
--     RefreshPanel()
-- end

-- function OnClickPJ()
--     selectUD = 2
--     qualityUD = qualityUD == 1 and 2 or 1
--     RefreshPanel()
-- end
