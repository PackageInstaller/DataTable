-- 好感度剧情
local curDatas
local maxLv
local storyDic
local len -- item距离328
local nextIndex = nil -- 下一个解锁的对象

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/Favour/FavourPlotItem", LayoutCallBack, true)

    m_slider = ComUtil.GetCom(slider, "Slider")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.CRole_PlayJQ, RefreshPanel)

    UIUtil:AddTop2("FavourPlotView", gameObject, function()
        view:Close()
    end, nil, {})
end

function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        local isGet = StoryIsGet(_data) -- 是否已领取奖励
        local isNext = nextIndex == index
        lua.Refresh(data, _data, isNext, isGet)
    end
end

function OnOpen()
    SetDatas()
    RefreshPanel()
end

function SetDatas()
    -- 角色剧情 dic[解锁等级] = cfg_info 
    local cfgStoryDic = {}
    local cfg = Cfgs.CfgCardRoleStory:GetByID(data:GetID())
    for k, v in ipairs(cfg.infos) do
        local cfgLock = Cfgs.CfgCardRoleUnlock:GetByID(v.unlock_id)
        cfgStoryDic[cfgLock.value] = v
    end
    storyMaxCount = #cfg.infos -- 故事总长度

    curDatas = {}
    maxLv = CRoleMgr:GetCRoleMaxLv()
    local num = math.floor(maxLv / 10)
    for k = 0, num do
        local lv = k == 0 and 1 or k * 10
        local _cfg = cfgStoryDic[lv] or nil
        local data = {lv, _cfg}
        table.insert(curDatas, data)
    end
end

function RefreshPanel()
    -- percent
    local storyIDs = data:GetStoryIds() -- 已解锁 
    local percent = math.floor(#storyIDs / storyMaxCount)
    CSAPI.SetText(txtPercent, percent .. "%")

    -- storydic
    storyDic = {}
    for k, v in ipairs(storyIDs) do
        storyDic[v] = v
    end

    -- 
    SetNextIndex()

    -- items
    if (not isFirst) then
        isFirst = 1
        layout:IEShowList(#curDatas)
    else
        layout:UpdateList()
    end

    -- slider 
    if (len == nil) then
        len = 328 * (#curDatas - 1)
        if (len > 0) then
            CSAPI.SetRTSize(slider, len, 20)
        end
    end
    m_slider.value = data:GetLv()==1 and 0 or data:GetLv() / maxLv
end

-- 故事已经解锁
function StoryIsGet(_data)
    if (_data[2]) then
        local storyID = _data[2].story_id
        return storyDic[storyID] ~= nil
    end
    return false
end

-- 
function SetNextIndex()
    nextIndex = nil
    local curLv = data:GetLv()
    for k, v in ipairs(curDatas) do
        if (v[1] > curLv) then
            nextIndex = k
            break
        end
    end
end

