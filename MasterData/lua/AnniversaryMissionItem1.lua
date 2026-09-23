local cfg = nil
local slider = nil
local score = 0
local item = nil
local isGet = false

function Awake()
    slider = ComUtil.GetCom(Slider, "Slider")
end

function Refresh(_data, _group)
    cfg = _data
    score = MissionMgr:GetAnniversaryInfo(_group) or 0
    if cfg then
        isGet = score >= cfg.star
        CSAPI.SetGOAlpha(node,isGet and 0.5 or 1)
        SetNum()
        SetItem()
    end
end

function SetNum()
    CSAPI.SetText(txtNum, "x" .. cfg.star)
    slider.value = score / cfg.star
end

function SetItem()
    if item == nil then
        local go, _item = ResUtil:CreateRewardGrid(itemParent.transform)
        item = _item
    end
    local reward = cfg.jAwardId and cfg.jAwardId[1]
    if reward then
        local _data = {
            id = reward[1],
            type = reward[3],
            num = reward[2]
        }
        local result, clickCB = GridFakeData(_data)
        item.Refresh(result)
        item.SetClickCB(clickCB)
        item.SetCount(_data.num)
    end
end
