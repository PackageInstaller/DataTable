local data = nil
local img1 = nil
local img2 = nil
local targetPrecent = 0
local currPrecent = 0
local speed = 0
local isAdd = false
local lastHardLv = 0

function Awake()
    img1 = ComUtil.GetCom(prograssImg1, "Image")
    img2 = ComUtil.GetCom(prograssImg2, "Image")
    InitPanel()
end

function InitPanel()
    CSAPI.SetText(txtPrograss, 0 .. "%")
    img1.fillAmount = 0
    img2.fillAmount = 0
end

function SetHard(hardLv)
    if lastHardLv == hardLv then
        return
    end
    local str = hardLv > 1 and "hard" or "nol"
    CSAPI.LoadImg(prograssImg1, "UIs/Section/img_" .. str .. "_01.png", true, nil, true)
    CSAPI.LoadImg(prograssImg2, "UIs/Section/img_" .. str .. "_02.png", true, nil, true)
    CSAPI.LoadImg(prograssImg3, "UIs/Section/img_" .. str .. "_03.png", true, nil, true)
    local color = hardLv > 1 and {255, 0, 64, 255} or {255, 193, 70, 255}
    CSAPI.SetTextColor(txtPrograss, color[1], color[2], color[3], color[4])
    lastHardLv = hardLv
end

function Update()
    if targetPrecent ~= currPrecent then
        currPrecent = currPrecent + speed
        if isAdd then
            currPrecent = currPrecent > targetPrecent and targetPrecent or currPrecent
        else
            currPrecent = currPrecent < targetPrecent and targetPrecent or currPrecent
        end
        local precent = math.floor(currPrecent)
        CSAPI.SetText(txtPrograss, precent .. "%")
        img1.fillAmount = precent / 100
        img2.fillAmount = precent / 100
    end
end

function RefreshProgass(sectionData)
    if sectionData then
        local hardLv = DungeonMgr:GetDungeonHardLv(sectionData:GetID())
        SetHard(hardLv)
        targetPrecent = sectionData:GetCompletePercentByAll(hardLv) or 0
        speed = (targetPrecent - currPrecent) * 0.05
        isAdd = targetPrecent > currPrecent
    end
end

