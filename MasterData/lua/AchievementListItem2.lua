local data = nil
local slider = nil
local colors = {{255,193,70,255},{255,255,255,255}}
local isNew = false

function Awake()
    slider= ComUtil.GetCom(numSlider, "Slider")

    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb =_cb
end

function Refresh(_data)
    data = _data
    if data then
        SetBG()
        SetPercent()
        SetIcon()
        SetName()
        SetNum()
        SetRed()
        SetNewState()
        SetNew(isNew)
    end
end

function SetPercent()
    local str = ""
    CSAPI.SetGOActive(txt_percent,not data:IsHide() or data:IsFinish())
    if not data:IsHide() or data:IsFinish()  then
        str = data:GetPercent() .. ""
    end
    CSAPI.SetText(txtPercent,str)
    local color = data:IsFinish() and colors[1] or colors[2]
    CSAPI.SetTextColor(txtPercent,color[1],color[2],color[3],color[4])
    CSAPI.SetGOActive(hide, data:IsHide() and not data:IsFinish())
end

function SetBG()
    local num = data:GetQuality() or 1
    num = num < 10 and "0" .. num or num .. ""
    local bgName = "img_" .. num .. "_01"
    ResUtil.AchievementQua:Load(bg,bgName)
end

function SetIcon()
    CSAPI.SetRTSize(icon1,0,0)
    CSAPI.SetRTSize(icon2,0,0)
    local iconName1 = data:GetIcon()
    if iconName1~=nil and iconName1~="" then
        ResUtil.Achievement:Load(icon1, iconName1)
    end
    local iconName2 = data:GetIcon2()
    if iconName2~=nil and iconName2~="" then
        ResUtil.Achievement:Load(icon2, iconName2)
    end
end

function SetName()
    CSAPI.SetText(txtName,data:GetName())
    CSAPI.SetTextColorByCode(txtName,(data:IsFinish() and data:IsGet()) and "929296" or "ffffff")
    CSAPI.SetAnchor(txtName,0,not data:IsFinish() and 5 or -5)
end

function SetNum()
    local cur,max = data:GetCount()
    CSAPI.SetGOActive(numSlider,not data:IsFinish())
    if not data:IsFinish() then
        slider.value = math.floor(cur / max * 100) / 100
    end
end

function SetSelect(b)
    CSAPI.SetGOActive(selImg,b)
end

function SetRed()
    UIUtil:SetRedPoint(redParent, data:IsFinish() and not data:IsGet())
end

function SetNewState()
    isNew = false
    if data:GetPreposition() then
        local prepData=AchievementMgr:GetData(data:GetPreposition())
        local info = FileUtil.LoadByPath("Achievement_New_Recover_2.txt") or {}
        if prepData and prepData:IsGet() and info[data:GetID()] == nil then
            isNew = true
            local info2 = FileUtil.LoadByPath("Achievement_New_Recover_1.txt") or {}
            if info2[data:GetID()] == nil then
                info2[data:GetID()] = 1
                FileUtil.SaveToFile("Achievement_New_Recover_1.txt",info2)    
            end
        end
    end
end

function SetNew(b)
    if b and data:IsFinish() and not data:IsGet() then --有红点
        b = false
    end
    UIUtil:SetNewPoint(newParent, b)
end

function OnClick()
    if isNew then
        SetNew(false)
        local info = FileUtil.LoadByPath("Achievement_New_Recover_2.txt") or {}
        info[data:GetID()] = 1
        FileUtil.SaveToFile("Achievement_New_Recover_2.txt",info)
        isNew = false
    end
    if cb then
        cb(this)
    end
end

function GetData()
    return data
end