-- 图片窗口说明
local curIndex = 1
local isGuideing = false
local num = 0

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/ModuleInfo/ModuleInfoIcon", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(SetCurIndex)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data, ItemClickCB)
    end
end

function OnOpen()
    CSAPI.SetGOActive(bg1, data.question == nil)
    CSAPI.SetGOActive(bg2, data.question ~= nil)
    if (data.question) then
        SetBg2()
    else
        SetBg1()
    end
end

function SetBg2()
    isGuideing = true  --不能从背景退出
    -- title
    LanguageMgr:SetText(txtTitle, data.question[1])
    -- desc 
    LanguageMgr:SetText(txtDesc, data.question[2])
end

function SetBg1()
    -- 是否引导中 
    isGuideing = GuideMgr:IsGuiding()
    SetItems()
    SetGrids()
end

function SetItems()
    curDatas = data.icons
    layout:IEShowList(#curDatas)
end

-- 底部条条
function SetGrids()
    local maxX, maxScaleX, scaleY = 1348, 76, 24
    local count = #curDatas
    CSAPI.SetGOActive(grids, count > 1)
    if (count > 1) then
        -- 超过最大长度则压缩格子大小
        local x = ((count * maxScaleX) > maxX) and math.floor(maxX / count) or maxScaleX
        CSAPI.ChangeGridCellSize(grids, x, scaleY)

        items = items or {}
        ItemUtil.AddItems("ModuleInfo/ModuleInfoItem", items, curDatas, grids, nil, 1, curIndex, function()
            local isShow = true
            if (isGuideing) then
                isShow = curIndex == #curDatas
            end
            CSAPI.SetGOActive(btnClose, isShow)
        end)
    end
end

function SetCurIndex()
    local _curIndex = layout:GetMiddleIndex()
    if (curIndex ~= _curIndex) then
        curIndex = _curIndex
        SetGrids()
    end
end

function OnClick1()
    if (curIndex > 1) then
        layout:MoveToCenter(curIndex - 1)
    end
end

function OnClick2()
    if (curIndex < #curDatas) then
        layout:MoveToCenter(curIndex + 1)
    end
end

function OnClickBg()
    if (isGuideing) then
        return
    end
    view:Close()
end

function OnClickClose()
    view:Close()
end

function ItemClickCB()
    num = num + 1
    if (num >= 2) then
        num = 0
        LanguageMgr:ShowTips(29001)
    end
end


