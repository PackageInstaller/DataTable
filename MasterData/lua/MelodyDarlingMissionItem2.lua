
local isGet = false
local item = nil
local cfg = nil

function Refresh(_data)
    cfg = _data
    local rewards = GetJAwardId()
    if rewards then
        local goodsData = GridUtil.RandRewardConvertToGridObjectData(rewards[1])
        if item then
            item.Refresh(goodsData)
        else
            ResUtil:CreateUIGOAsync("Grid/GridItem",itemParent,function (go)
                local lua = ComUtil.GetLuaTable(go)
                lua.SetClickCB(GridClickFunc.OpenInfoSmiple)
                lua.Refresh(goodsData)
                item = lua
            end)
        end
    end
    isGet = MissionMgr:GetAnniversaryInfo(eTaskType.SONICO) >= cfg.star
    CSAPI.SetGOActive(getImg, isGet)
    CSAPI.SetGOActive(getImg2, isGet)
    CSAPI.SetGOActive(nolImg, not isGet)
    CSAPI.SetGOAlpha(itemParent,isGet and 0.5 or 1)
    CSAPI.SetText(txtNum,(cfg and cfg.star or 0) .. "")
end

function GetJAwardId()
    local rewards = {}
    if(cfg and cfg.jAwardId) then
        for i, v in ipairs(cfg.jAwardId) do
            table.insert(rewards, {id = v[1], num = v[2], type = v[3]})
        end
    end
    return rewards
end
