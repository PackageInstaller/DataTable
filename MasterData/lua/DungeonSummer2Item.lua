local data = nil
local currLevel = 1
local isOpen = false
local lockStr = ""
local ids = nil
local cfgDungeon = nil
local dungeonData = nil
local isPlot = false
local isPass = false
local anim = nil

function Awake()
    InitAnim()
end

function OnEnable()
    -- if not IsNil(anim) then
    --     anim.enabled = true
    -- end
end

function OnDisable()
    -- if not IsNil(anim) then
    --     anim.enabled = false
    -- end
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    if not IsNil(anim) then
        anim:SetBool("isSel", b)
        if b then
            local str = "Stage_easy_loop"
            str = currLevel == 2 and "Stage_hard_loop" or str
            str = currLevel == 3 and "Stage_extra_loop" or str
            anim:Play(str)
        end
    end
end

function Refresh(_data, _elseData)
    data = _data
    currLevel = _elseData or 1
    if data then
        isOpen, lockStr = data:IsOpen()
        ids = data:GetDungeonGroups()
        cfgDungeon = Cfgs.MainLine:GetByID(ids[1])
        dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
        isPlot = cfgDungeon and cfgDungeon.sub_type ~= nil
        isPass = dungeonData and dungeonData:IsPass()
        -- CSAPI.SetAnchor(pos,0,index%2 == 0 and 14 or -44)
        SetTitle()
        SetPass()
        SetPlot()
        SetDungeon()
        SetLock()
        SetStar()
        SetNew()
        SetAnim()
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle1, (index < 10 and "0" .. index or index) .. "")
    CSAPI.SetText(txtTitle2, data:GetName())
end

function SetPlot()
    CSAPI.SetGOActive(plotImg, isPlot)
end

function SetPass()
    CSAPI.SetGOActive(passImg, isPass)
end

function SetDungeon()
    CSAPI.SetGOActive(easy, currLevel == 1)
    CSAPI.SetGOActive(hard, currLevel == 2)
    CSAPI.SetGOActive(extra, currLevel == 3)
end

function SetLock()
    if currLevel < 3 then
        CSAPI.LoadImg(lockImg, "UIs/DungeonActivity13/lock_0" .. currLevel .. ".png", true, nil, true)
    end
    CSAPI.SetGOActive(lockObj, not isOpen)
    CSAPI.SetGOActive(selObj, isOpen)
end

function SetStar()
    CSAPI.SetGOActive(starObj, not isPlot and not IsDanger() and not IsSpecial())
    if not isPlot and not IsDanger() and not IsSpecial() then
        local starNum = 0
        if dungeonData then
            starNum = dungeonData:GetStar()
        end
        local iconName = ""
        for i = 1, 3 do
            iconName = i <= starNum and "star_01" or "star_02"
            if not isOpen then
                iconName = "star_03"
            end
            CSAPI.LoadImg(this["star" .. i].gameObject, "UIs/DungeonActivity13/" .. iconName .. ".png", true, nil, true)
        end
    end
end

function SetNew()
    CSAPI.SetGOActive(newImg, dungeonData and dungeonData:IsOpen() and not dungeonData:IsPass())
end

function GetCfg()
    return cfgDungeon
end

function GetType()
    if cfgDungeon and cfgDungeon.sub_type and cfgDungeon.sub_type == 1 then
        return DungeonInfoType.Summer2Plot
    elseif IsDanger() then
        return DungeonInfoType.Summer2Danger
    elseif IsSpecial() then
        return DungeonInfoType.Summer2Special
    end
    return DungeonInfoType.Summer2
end

function GetCfgs()
    local cfgs = {}
    if ids and #ids > 0 then
        for _, cfgId in ipairs(ids) do
            local cfg = Cfgs.MainLine:GetByID(cfgId)
            if cfg then
                table.insert(cfgs, cfg)
            end
        end
    end
    return cfgs
end

function IsPlot()
    return cfgDungeon and cfgDungeon.sub_type
end

function IsDanger()
    return ids and #ids > 1
end

function IsSpecial()
    return cfgDungeon and cfgDungeon.diff and cfgDungeon.diff == 4
end

function OnClick()
    if not isOpen then
        Tips.ShowTips(lockStr)
        return
    end
    if cb then
        cb(this)
    end
end

-----------------------------------------------info-----------------------------------------------
function GetInfo()
    return data and data:GetTargetJson()
end

-----------------------------------------------anim-----------------------------------------------
function InitAnim()
    anim = ComUtil.GetCom(gameObject, "Animator")
end

function SetAnim()

end

function ShowEffect(go)
    CSAPI.SetGOActive(go, false)
    CSAPI.SetGOActive(go, true)
end

function PlayAnim(str)
    if not IsNil(anim) then
        anim:Play(str)
    end
end

function ShowSelAnim(b)
    local animName = "isEasySel"
    animName = currLevel == 2 and "isHardSel" or animName
    animName = currLevel == 3 and "isExtraSel" or animName
    if not IsNil(anim) then
        anim:SetBool(animName, b)
    end
end

function ShowUnLockAnim()
    CSAPI.SetGOActive(selObj, false)
    CSAPI.SetGOActive(lockObj, true)
    UIUtil:SetObjFade(lockObj, 1, 0, function()
        CSAPI.SetGOActive(selObj, true)
    end, 200)
end
