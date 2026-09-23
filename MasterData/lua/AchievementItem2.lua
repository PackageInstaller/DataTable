local data = nil
local isList = false
local slider = nil
local rewardItems = nil
local items = nil

function Awake()
    slider= ComUtil.GetCom(numSlider, "Slider")
    InitAnim()
end

function Refresh(_data)
    data = _data
    if data then
        isList = data:GetKey() == "AchievementListData"
        SetBG()
        SetIcon()
        SetName()
        SetTime()
        SetDesc()
        SetNum()
        SetReward()
        SetCollect()
        SetRed()
        PlayChangeAnim()
    end
end

function SetBG()
    CSAPI.SetGOActive(bg,not isList)
    if not isList then
        local num = data:GetQuality() or 1
        num = num < 10 and "0" .. num or num .. ""
        local bgName = "img_" .. num .. "_02"
        ResUtil.AchievementQua:Load(bg,bgName)    
    end
end

function SetIcon()
    local iconName = data:GetIcon()
    CSAPI.SetGOActive(icon1,not isList)
    CSAPI.SetGOActive(icon3,isList)
    if iconName~=nil and iconName~="" then
        if isList then
            ResUtil.AchievementType:Load(icon3,iconName)
        else
            ResUtil.Achievement:Load(icon1,iconName)
        end
    end
    CSAPI.SetGOActive(icon2,not isList)
    if not isList then
        local iconName2 = data:GetIcon2()
        CSAPI.SetGOActive(icon2,iconName2~=nil and iconName2~="")
        if iconName2~=nil and iconName2~="" then
            ResUtil.Achievement:Load(icon2,iconName2)
        end        
    end
    
end

function SetName()
    CSAPI.SetText(txtName,data:GetName())
    CSAPI.SetAnchor(txtName,-6,isList and -30 or 112)
end

function SetTime()
    local str = ""
    if not isList and data:IsFinish() then
        str = data:GetTimeStr()
    end
    CSAPI.SetText(txtTime,str)
end

function SetDesc()
    local str = ""
    if not isList then
        str = data:GetDesc()
    end
    CSAPI.SetText(txtDesc,str)
    CSAPI.SetText(txtDesc2,str)
    if not isList then
        CSAPI.SetGOActive(txtDesc,not data:IsFinish())
        CSAPI.SetGOActive(txtDesc2,data:IsFinish())
    end
end

function SetNum()
    local isShowSlider = not isList and not data:IsFinish()
    CSAPI.SetGOActive(numSlider,isShowSlider)
    CSAPI.SetGOActive(hideImg,isShowSlider)
    if isShowSlider then
        local cur,max = data:GetCount()
        CSAPI.SetText(txtNum1,"/"..max)
        CSAPI.SetText(txtNum2,cur.."")
        slider.value = math.floor(cur / max * 100) / 100
        CSAPI.SetGOActive(txtNum1,not data:IsHide())
        CSAPI.SetGOActive(hideImg,data:IsHide())
    end
end

function SetReward()
    CSAPI.SetGOActive(grid,not isList)
    if not isList then
        local jumpId = data:GetJumpId()
        local isJump = not data:IsFinish() and jumpId ~=nil
        CSAPI.SetGOActive(btnGet,not data:IsGet() and not isJump)
        CSAPI.SetGOActive(btnJump,isJump)
        CSAPI.SetImgColor(btnGet,255,255,255,not data:IsFinish() and 125 or 255)
        local gridDatas = GridUtil.GetGridObjectDatas(data:GetRewards() or {})
        rewardItems = rewardItems or {}
        ItemUtil.AddItems("Achievement/AchievementReward", rewardItems, gridDatas, grid,
        GridClickFunc.OpenInfoSmiple, 1, data:IsGet())
    else
        CSAPI.SetGOActive(btnGet,false)
        CSAPI.SetGOActive(btnJump,false)
    end
end

function SetCollect()
    CSAPI.SetGOActive(collectObj, isList)
    if isList then
        local datas = data:GetQualityCount()
        items = items or {}
        ItemUtil.AddItems("Achievement/AchievementListItem3", items, datas, layout,nil,1,data:GetIcon())
    end 
end

function SetRed()
    local isRed = false
    if not isList and data:IsFinish() and not data:IsGet() then
        isRed = true
    end
    UIUtil:SetRedPoint(redParent,isRed)
end

function OnClickGet()
    if not data or not data:IsFinish() or isList then
        return
    end
    AchievementProto:GetReward(data:GetID(),function ()
        CSAPI.OpenView("Achievement",nil,{group = data:GetType(),itemId = data:GetID()})
    end)
end

function OnClickJump()
    if data:GetJumpId() then
        JumpMgr:Jump(data:GetJumpId())
    end
end

function OnClickQuestion()
    
end

----------------------------------------anim----------------------------------------
function InitAnim()
    CSAPI.SetGOActive(changeAction,false)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go,false)
    CSAPI.SetGOActive(go,true)
end

function PlayChangeAnim()
    ShowEffect(changeAction)
end