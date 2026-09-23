local data = nil
local infos = nil
function Awake()
    SetBGScale()
end

function Refresh(_data)
    data = _data
    if data then
        SetTop()
        infos = data:GetSummaryInfo()
        if infos and #infos > 0 then
            for i, v in ipairs(infos) do
                SetName(v, i)
                SetTime(v, i)
                SetIcon(v, i)
            end
        end
    end
end

function SetBGScale()
    if bg and not IsNil(bg.gameObject) then
        local scale = CSAPI.GetSizeOffset()
        CSAPI.SetScale(bg,scale,scale,scale)
    end
end

function SetTop()
    SetText(txtTitle,data:GetName())
    local sTime,eTime = data:GetStartTime(),data:GetEndTime()
    SetText(txtTime,TimeUtil:GetTimeHMS(sTime,"%m.%d %H:%M") .. "-" .. TimeUtil:GetTimeHMS(eTime,"%m.%d %H:%M"))
end

function SetName(info, index)
    if info.name then
        SetText(this["txtName" .. index], info.name)
    end
    if info.desc then
        SetText(this["txtDesc" .. index], info.desc)
    end
end

function SetTime(info, index)
    if info.sTime and info.eTime then
        local sTime, eTime = TimeUtil:GetTimeStampBySplit(info.sTime), TimeUtil:GetTimeStampBySplit(info.eTime)
        SetText(this["txtTime" .. index .. "_1"], TimeUtil:GetTimeHMS(sTime, "%m/%d"))
        SetText(this["txtTime" .. index .. "_2"], TimeUtil:GetTimeHMS(sTime, "%H:%M"))
        SetText(this["txtTime" .. index .. "_3"], TimeUtil:GetTimeHMS(eTime, "%m/%d"))
        SetText(this["txtTime" .. index .. "_4"], TimeUtil:GetTimeHMS(eTime, "%H:%M"))
    end
end

function SetIcon(info, index)
    if info.icon and info.icon ~= "" and this["icon" .. index] and not IsNil(this["icon" .. index].gameObject) then
        local type = info.iconType or 1
        if type == 1 then
            ResUtil.Summary:Load(this["icon" .. index].gameObject, data:GetGroup() .. "/" .. info.icon)
        else
            ResUtil.SummaryImg:Load(this["icon" .. index].gameObject, info.icon)
        end
    end
end

function SetText(obj, str)
    if obj and not IsNil(obj.gameObject) then
        str = str or ""
        CSAPI.SetText(obj.gameObject, str)
    end
end

function OnClickItem(go)
    -- TrackEvent(tonumber(go.name))
    if infos and #infos > 0 then
        for i, v in ipairs(infos) do
            if tostring(i) == go.name and v.jumpId then
                if CheckIsOpen(v) then
                    JumpMgr:Jump(v.jumpId)
                else
                    LanguageMgr:ShowTips(24003)
                end
                break
            end
        end
    end
end

function CheckIsOpen(v)
    if v.sTime and v.eTime and not v.checkActivityTime then
        local sTime = TimeUtil:GetTimeStampBySplit(v.sTime)
        local eTime = TimeUtil:GetTimeStampBySplit(v.eTime)
        return TimeUtil:GetTime() >= sTime and TimeUtil:GetTime() < eTime
    end
    return true
end

function TrackEvent(index)
    local eventNames = nil
    if gameObject.name == "AnniversaryPicView1" then
        eventNames = {"anniversary_signIn","anniversary_freePull","anniversary_collaborationMain"}
    elseif gameObject.name == "AnniversaryPicView2" then
        eventNames = {"anniversary_mainLine","anniversary_multFight","anniversary_taoFa","anniversary_totalBattle"}
    elseif gameObject.name == "AnniversaryPicView3" then
        eventNames = {"anniversary_picture"}
    elseif gameObject.name == "AnniversaryPicView4" then
        eventNames = {"anniversary_skin"}
    elseif gameObject.name == "AnniversaryPicView5" then
        eventNames = {"anniversary_package_flippedClassroom","anniversary_package_oceanGlowResearch","anniversary_package_crimsonLumishot"}
    elseif gameObject.name == "AnniversaryPicView6" then
        eventNames = {"anniversary_luckyGacha"}
    end
    if eventNames and eventNames[index] then
        AnniversaryMgr:TrackEvents(eventNames[index])
    end
end

function OnClickJump()
    JumpMgr:Jump(data:GetJumpId())
end