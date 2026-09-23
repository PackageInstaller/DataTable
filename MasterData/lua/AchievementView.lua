local leftDatas = {}
local panels = {}
local lastPanel = nil
curIndex1, curIndex2 = 1, 0 -- 父index,子index
local recoverNews = {}
local refreshTime,time,timer = 0,0,0

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Achievement_Data_Update,RefreshPanel)
end

function OnInit()
    UIUtil:AddTop2("Achievement", topParent, OnClickBack ,OnClickHome);
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if time > 0 and timer < Time.time then
         timer = Time.time + 1
         time = refreshTime - TimeUtil:GetTime()
         if time <= 0 then
             RefreshDatas()
             if time > 0 then
                 InitLeftPanel()
                 RefreshPanel()            
             end
         end
    end 
 end

function OnOpen()
    RefreshDatas()
    InitJumpState()
    InitLeftPanel()
    RefreshPanel()
end

function RefreshDatas()
    leftDatas = {}
    refreshTime = 0
    local cfgs = Cfgs.CfgAchieveType:GetAll()
    if cfgs == nil then
        return
    end
    for _, cfg in pairs(cfgs) do
        local data ={cfg = cfg,infos = {}}
        if cfg.infos and #cfg.infos > 0 then
            for _, info in ipairs(cfg.infos) do
                if info.showTime then
                    local sTime = TimeUtil:GetTimeStampBySplit(info.showTime)
                    if sTime then
                        if TimeUtil:GetTime() >= sTime then
                            table.insert(data.infos, info)
                        elseif refreshTime == 0 or refreshTime > sTime then
                            refreshTime = sTime
                        end
                    end
                else
                    table.insert(data.infos, info)
                end
            end
        end
        if #data.infos > 0 then
            table.sort(data.infos,function (a,b)
                return a.index < b.index
            end)
        end
        table.insert(leftDatas,data)
    end
    if #leftDatas > 0 then
        table.sort(leftDatas,function (a,b)
            return a.cfg.sort < b.cfg.sort
        end)
    end

    time = refreshTime > 0 and refreshTime - TimeUtil:GetTime() or 0
    timer = 0
end

function InitJumpState()
    if openSetting and openSetting.group then
        if #leftDatas > 0 then
            for k, data in ipairs(leftDatas) do
                if data.infos and #data.infos>0 then
                    for i, v in ipairs(data.infos) do
                        if v.typeNum == openSetting.group then
                            curIndex1,curIndex2 = k + 1, i
                        end
                    end
                end
            end
        end
    end
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftParent.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local _leftDatas,_leftChildDatas = {{47100,"ActivityList/icon1"}},{{}} -- 多语言id，需要配置英文 -- 子项多语言，需要配置英文
    if #leftDatas > 0 then
        for _, data in ipairs(leftDatas) do
            table.insert(_leftDatas,{data.cfg.leftInfo[1].id,data.cfg.leftInfo[1].path})
            local _data = {}
            if data.infos then
                for i, v in ipairs(data.infos) do
                    table.insert(_data,v.childId)
                end
            end
            table.insert(_leftChildDatas,_data)
        end
    end
    leftPanel.Init(this, _leftDatas, _leftChildDatas)
end

function RefreshPanel()
    ShowRightPanel()
    -- 侧边动画
    leftPanel.Anim()
    -- 红点
    SetRed()
end

function ShowRightPanel()
    if lastPanel then
        CSAPI.SetGOActive(lastPanel.gameObject,false)
    end
    local currIndex = curIndex1 == 1 and 1 or 2
    local elseData = openSetting and openSetting.itemId
    openSetting = nil
    if panels[currIndex] then
        CSAPI.SetGOActive(panels[currIndex].gameObject, true)
        lastPanel = panels[currIndex]
        panels[currIndex].Refresh(GetData(),elseData)
    else
        ResUtil:CreateUIGOAsync("Achievement/AchievementListView" .. currIndex,rightParent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(GetData(),elseData)
            panels[currIndex] = lua
            lastPanel = lua
        end)
    end
    RefreshNew()
end

function GetData()
    if curIndex1 > 1 then
        local data = leftDatas[curIndex1 - 1]
        if data.infos and data.infos[curIndex2] and data.infos[curIndex2].typeNum then
            return AchievementMgr:GetListData(data.infos[curIndex2].typeNum)
        end
    end
    return nil
end

function RefreshNew()
    local info1 = FileUtil.LoadByPath("Achievement_New_Recover_1.txt") or {}
    local info2 = FileUtil.LoadByPath("Achievement_New_Recover_2.txt") or {}
    if info1 and #info1> 0 then
        for k, v in ipairs(info1) do
            info2[k] = v
        end
        info1 = nil
    end
    FileUtil.SaveToFile("Achievement_New_Recover_1.txt",info1)
    FileUtil.SaveToFile("Achievement_New_Recover_2.txt",info2)
end

function SetRed()
    for i, v in ipairs(leftPanel.leftItems) do
        if i == 1 then
            v.SetRed(AchievementMgr:CheckRed())
        elseif leftDatas[i - 1] then
            v.SetRed(AchievementMgr:CheckRed2(leftDatas[i - 1].cfg.id))
        end
    end
    for i, v in ipairs(leftPanel.leftChildItems) do
        if i ~= 1 then
            local infos = leftDatas[i-1] and leftDatas[i-1].infos or nil
            for k, m in ipairs(v) do
                if infos and infos[k] then
                    m.SetRed(AchievementMgr:CheckRed(infos[k].typeNum))
                end
            end
        end
    end
end

function OnClickBack()
    if curIndex1 ~= 1 then
        curIndex1 = 1
        RefreshPanel()
    else
        RefreshNew()
        view:Close()    
    end
end

function OnClickHome()
    RefreshNew()
    UIUtil:ToHome();
end



