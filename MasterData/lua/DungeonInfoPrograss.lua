local cfg = nil
local data = nil
local sectionData = nil
local cur,max = 0,0
local isRed = false
local gos = {}

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List, OnTowerRefresh)

    local imgGO = ComUtil.GetComInChildren(pImgObj, "Image").gameObject
    table.insert(gos, imgGO)
end

function OnTowerRefresh()
    if cfg then
        RefreshPanel()
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        RefreshPanel()
    end
end

function RefreshPanel()
    SetState()
    SetCount(cur,max)
    SetRed(isRed)
    SetGOs(cur,max)
end

function SetState()
    local missionDatas = MissionMgr:GetActivityDatas(eTaskType.TmpDupTower, cfg.missionID)
    if missionDatas then
        cur = 0
        isRed = false
        max = #missionDatas
        for _, missData in ipairs(missionDatas) do
            if missData:IsGet() then
                cur = cur + 1
            elseif missData:IsFinish() then
                isRed = true
            end
        end
    end
end

function SetCount(_cur,_max)
    CSAPI.SetText(txtPrograss, LanguageMgr:GetByID(15029) .. _cur .. "/" .. _max)
end

function SetRed(b)
    CSAPI.SetGOActive(redPoint, b)
end

function SetGOs(_cur,_max)
    for _, v in ipairs(gos) do
        CSAPI.SetGOActive(v.gameObject, false)
    end
    if _max > 0 then
        for i = 1, _max do
            local go = nil
            if (#gos < i) then
                go = CSAPI.CloneGO(gos[1])
                CSAPI.SetParent(go, pImgObj)
                table.insert(gos, go)
            else
                go = gos[i].gameObject
                CSAPI.SetGOActive(go, true)
            end
            local color = i <= _cur and {255,183,38,255} or {255,255,255,255}
            CSAPI.SetImgColor(go, color[1], color[2], color[3], color[4])
        end
    end
end

function OnClickReward()
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.TmpDupTower,
        title = LanguageMgr:GetByID(6018, cfg.name),
        group = cfg.missionID
    })
end