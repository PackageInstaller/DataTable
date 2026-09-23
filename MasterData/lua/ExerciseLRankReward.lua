local ExerciseLRankData = require "ExerciseLRankData"
local index = nil

function Awake()
    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)

    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    layout1:Init("UIs/ExerciseL/ExerciseLRankRewardItem", LayoutCallBack1, true)

    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/ExerciseL/ExerciseLRankRewardItem3", LayoutCallBack2, true)
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end
function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Exercise_End, function()
        view:Close()
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    tab.selIndex = 0
end

function OnTabChanged(_index)
    if (index and _index == index) then
        return
    end
    index = _index

    CSAPI.SetGOActive(vsv1, index == 0)
    CSAPI.SetGOActive(vsv2, index == 1)
    -- 
    if (index == 0) then
        curDatas = {}
        local cfgs = Cfgs.CfgPracticeRankLevel:GetAll()
        for k, v in ipairs(cfgs) do
            local data = ExerciseLRankData.New()
            data:InitData(v)
            table.insert(curDatas, data)
        end
        table.sort(curDatas, function(a, b)
            if (a:IsGetNum() == b:IsGetNum()) then
                return a:GetID() < b:GetID()
            else
                return a:IsGetNum() < b:IsGetNum()
            end
        end)
        layout1:IEShowList(#curDatas)
    else
        curDatas = Cfgs.CfgPracticeRankLevelReward:GetAll()
        layout2:IEShowList(#curDatas)
        SetMe()
    end

end

function SetMe()
    local realId = GetRealIndex()
    local cfg = Cfgs.CfgPracticeRankLevelReward:GetByID(realId)
    -- icon 
    SetGrade(cfg.icon)
    -- name 
    CSAPI.SetText(txtName, cfg.name)
    -- zf 
    CSAPI.SetText(txtZf, ExerciseMgr:GetScore() .. "") -- cfg.scoreShow)
    -- items
    items = items or {}
    ResUtil:CreateCfgRewardGrids(items, cfg.rewards, grid)
end
-- 段位图标
function SetGrade(icon)
    CSAPI.SetGOActive(imgGrade, icon ~= nil)
    if (icon) then
        ResUtil.ExerciseGrade:Load(imgGrade, icon, true)
    end
end
function GetRealIndex()
    local rankLv = ExerciseMgr:GetRankLevel()
    return math.ceil(rankLv / 5)
end

function OnClickMask()
    view:Close()
end
