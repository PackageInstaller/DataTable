local ladIDs = {72005, 72002, 72003, 72004}
local selectInfo

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(datas, _selectInfo)
    selectInfo = _selectInfo
    local type = datas[1]:GetType()
    -- title
    LanguageMgr:SetText(txtTitle1, ladIDs[type])
    local str = ""
    if (selectInfo[1] ~= 1) then
        local num1, num2 = 0, #datas
        for k, v in pairs(datas) do
            if (v:CheckCanUse()) then
                num1 = num1 + 1
            end
        end
        str = num1 .. "/" .. num2
    end
    CSAPI.SetText(txtTitle2, str)
    -- grids
    items = items or {}
    ItemUtil.AddItems("HeadFrame/HeadFrameItem4", items, datas, grid, ItemClickCB, 1, selectInfo)
end

function ItemClickCB(data, gameObject)
    if (not data:CheckCanUse()) then
        local item_id = data:GetItemID()
        if (item_id) then
            local fakeData = BagMgr:GetFakeData(item_id)
            GridClickFunc.OpenInfoSmiple({
                ["data"] = fakeData
            })
        end
        return
    end
    if (cb) then
        cb(data, gameObject)
    end
end
