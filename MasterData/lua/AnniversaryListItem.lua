local data = nil
local anim = nil

function Awake()
    anim = ComUtil.GetCom(root,"Animator")
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    isSel = b
    SetRed()
end

function Refresh(_data)
    data = _data
    if data then
        SetName()
        SetIcon()
        SetRed()
    end
end

function SetName()
    CSAPI.SetText(txtName,data:GetName())
    CSAPI.SetText(txtEnName,data:GetEnName())
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName and iconName~="" then
        ResUtil.Summary:Load(icon,data:GetGroup() .. "/" .. iconName)
    end
end

function SetRed()
    if not data then
        return
    end
    local isRed = AnniversaryMgr:CheckRed(data:GetID())
    -- if isRed and isSel then
    --     isRed = false
    -- end
    UIUtil:SetRedPoint(redParent, isRed)
end

function OnClick()
    TrackEvent()
    if cb then
        cb(this)
    end
end

function PlayEnterAnim()
    if not IsNil(anim) then
        anim:Play("Tabs_entry")
    end
end

function ShowSelAnim()
    if not IsNil(anim) then
        if isSel then
            anim:Play("Tabs_sel")
        else
            anim:Play("Tabs_Nsel")
        end
    end
end

function TrackEvent()
    if data:GetID() == 8 then 
        AnniversaryMgr:TrackEvents("anniversary_tab_giftPack")
    elseif data:GetID() == 9 then
        AnniversaryMgr:TrackEvents("anniversary_tab_accumulatedRecharge")
    end
end