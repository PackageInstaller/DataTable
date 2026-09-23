local data = nil
local items = {}
local anim = nil

function Awake()
    anim = ComUtil.GetCom(root,"Animator")
end

function SetIndex(idx)
    index = idx
end

function Refresh(_data)
    data = _data
    if data then
        index = data:GetIndex() or 1 -- 天
        isDone = data:CheckIsDone() -- 已签
        isCurDay = data:GetIsCurDay() -- 是否是当天
        SetText()
        SetReward()
        SetRed()
        CSAPI.SetGOActive(get,isDone)
        CSAPI.SetGOActive(cur,isCurDay and not isDone)
    end
end

function SetReward()
    local rewards = data:GetRewards()
    items = items or {}
    ItemUtil.AddItems("SignInContinue16/AnniversarySignIn2Item2",items,rewards,grid)
end

function SetText()
    CSAPI.SetText(txtDay, index .. "")
    CSAPI.SetText(txtDay2,StringUtil:NumberToWords(index))
    local str = ""
    if not isDone then
        if isCurDay then
            str = LanguageMgr:GetByID(6011)
        else
            str= LanguageMgr:GetByID(71007)
        end
    else
        str = LanguageMgr:GetByID(1050)
    end
    CSAPI.SetText(txtDesc,str)
end

function SetRed()
    UIUtil:SetRedPoint(redParent,isCurDay and not isDone)
end

function PlayEnterAnim()
    if not IsNil(anim) then
        -- anim:Play("Item_entry")
    end
end

function PlayGetAnim()
    if not IsNil(anim) then
        -- anim:Play("Item_get")
    end
end