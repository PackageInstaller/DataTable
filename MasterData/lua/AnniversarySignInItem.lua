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
    ItemUtil.AddItems("SignInContinue14/AnniversarySignInItem2",items,rewards,grid)
end

function SetText()
    CSAPI.SetText(txtDay, index < 10 and "0" .. index or index .. "")
    CSAPI.SetText(txtDay2,StringUtil:NumberToWords(index))
    local str, enStr = "", ""
    if not isDone then
        if isCurDay then
            str, enStr = LanguageMgr:GetByID(6011), LanguageMgr:GetByType(6011, 4)
        else
            str, enStr = LanguageMgr:GetByID(71007), LanguageMgr:GetByType(71007, 4)
        end
    end
    CSAPI.SetText(txtDesc,str)
    CSAPI.SetText(txtDesc2,enStr)
    local code,code2,code3 = "a19e9d","444343","444343"
    if isCurDay and not isDone then
        code,code2,code3 = "f5f2eb","292726","335f82"
    end
    CSAPI.SetTextColorByCode(txtDay,code)
    CSAPI.SetTextColorByCode(txtDay2,code)
    CSAPI.SetTextColorByCode(txtDesc,code2)
    CSAPI.SetTextColorByCode(txtDesc2,code3)
    CSAPI.SetGOAlpha(txtDesc2,(isCurDay and not isDone) and 1 or 0.5)
end

function SetRed()
    UIUtil:SetRedPoint(redParent,isCurDay and not isDone)
end

function PlayEnterAnim()
    if not IsNil(anim) then
        anim:Play("Item_entry")
    end
end

function PlayGetAnim()
    if not IsNil(anim) then
        anim:Play("Item_get")
    end
end