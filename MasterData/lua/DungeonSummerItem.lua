local data = nil
local currLevel = 1
local cfgDungeon = nil
local dungeonData = nil
local isLock = false
local lockStr = ""
local isSelect = false
local ids = nil
local isPlot = false
local isSpecial= false
local anim1,anim2,anim3

function Awake()
    SetSelect(false)
    InitAnim()
end

function OnEnable()
    if not IsNil(action) and action.transform.childCount > 0 then
        for i = 0, action.transform.childCount - 1 do
            CSAPI.SetGOActive(action.transform:GetChild(i).gameObject, false)
        end
    end
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    isSelect = b
    CSAPI.SetAnchor(obj,0,b and 0 or -76)
end

function Refresh(_data, _elseData)
    data = _data
    currLevel = _elseData
    if data then
        ids = data:GetDungeonGroups()
        if ids then
            cfgDungeon = Cfgs.MainLine:GetByID(ids[1])
            dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
            local isOpen,_lockStr = data:IsOpen()
            isLock,lockStr = not isOpen,_lockStr
            isPlot = cfgDungeon and cfgDungeon.sub_type ~= nil
            isSpecial = data:GetType() == 3
            SetPlot()
            SetDungeon()
            SetSpecial()
            SetIcon()
            SetTitle()
            SetStar()
            SetLock()
            CSAPI.SetGOActive(passImg,IsPass())
        end
    end
end

function SetDungeon()
    CSAPI.SetGOActive(dungeonObj,not isPlot and not isSpecial)
    if not isPlot and not isSpecial then
        local iconName = "1"
        local nolName = "2"
        local selName = "1"
        if currLevel == 2 then
            iconName = "2"
            selName = "4"
            nolName = IsPass()and "3" or"5"
        end
        ResUtil.DungeonSummer:Load(dIcon1,"btn_03_0" .. iconName)
        ResUtil.DungeonSummer:Load(dIcon3,"btn_01_0" .. iconName)
        ResUtil.DungeonSummer:Load(dSelIcon,"btn_02_0".. selName)
        ResUtil.DungeonSummer:Load(dNolIcon,"btn_02_0".. nolName)
        CSAPI.SetGOAlpha(dSelIcon,isSelect and 1 or 0)
        CSAPI.SetGOAlpha(dNolIcon,not isSelect and 1 or 0)
    end
end

function SetSpecial()
    CSAPI.SetGOActive(specialObj,isSpecial)
    if isSpecial then
        local nolName = "2"
        local selName = "1"
        ResUtil.DungeonSummer:Load(sSelIcon,"btn_02_0".. selName)
        ResUtil.DungeonSummer:Load(sNolIcon,"btn_02_0".. nolName)
        CSAPI.SetGOAlpha(sSelIcon,isSelect and 1 or 0)
        CSAPI.SetGOAlpha(sNolIcon,not isSelect and 1 or 0)
    end
end

function SetPlot()
    CSAPI.SetGOActive(plotObj,isPlot)
    if isPlot then
        local iconName1 = "1"
        if currLevel == 2 then
            iconName1 = "2"
        end
        ResUtil.DungeonSummer:Load(pIcon3,"btn_05_0" .. iconName1)
        ResUtil.DungeonSummer:Load(pNolIcon,"btn_06_0" .. (IsPass() and 1 or 2))
        CSAPI.SetGOAlpha(pSelIcon,isSelect and 1 or 0)
        CSAPI.SetGOAlpha(pNolIcon,not isSelect and 1 or 0)
    end
end

function SetIcon()
    local nolName = currLevel == 2 and "05" or  "01"
    local selName = currLevel == 2 and "06" or  "02"
    local lockName = "09"
    if isPlot then
        nolName = currLevel == 2 and "07" or "03"
        selName = currLevel == 2 and "08" or "04"
        lockName = "10"
    end
    ResUtil.DungeonSummer:Load(nolIcon1,"btn_04_".. nolName)
    ResUtil.DungeonSummer:Load(selIcon1,"btn_04_".. nolName)
    ResUtil.DungeonSummer:Load(lockIcon1,"btn_04_".. nolName)
    CSAPI.SetGOAlpha(nolIcon,(isSelect and not isLock) and 0 or 1)
    CSAPI.SetGOAlpha(selIcon,(not isSelect and not isLock) and 0 or 1)

    if isPlot then
        CSAPI.SetAnchor(tagIcon,-72,49)
        CSAPI.SetAnchor(txtStage,-72,49)
        CSAPI.SetAnchor(tagLockIcon,-72,49)
        CSAPI.SetAnchor(textImg,-108,16)
    else
        CSAPI.SetAnchor(tagIcon,-43,60)
        CSAPI.SetAnchor(txtStage,-43,60)
        CSAPI.SetAnchor(tagLockIcon,-43,60)
        CSAPI.SetAnchor(textImg,-73,27)
    end
end

function SetTitle()
    CSAPI.SetText(txtStage, LanguageMgr:GetByID(15124) .. " " .. index)
    CSAPI.SetText(txtTitle, cfgDungeon.name)

    CSAPI.SetTextColorByCode(txtStage,isLock and "212121" or "2d1e12")
    if isPlot then
         local code = IsPass() and "413229" or "fee0ba"
         code = currLevel == 2 and "fee0ba" or code
         code = isLock and "e6e6e6" or code
         CSAPI.SetTextColorByCode(txtTitle,code)
    else
        local code = currLevel == 2 and "aa3131" or "413229"
        code = isLock and "363636" or code
        CSAPI.SetTextColorByCode(txtTitle,code)  
    end

    CSAPI.SetScriptEnable(textImg,"Image",not isPlot)
    if not isPlot then
        local imgName = isLock and "img_13_02" or "img_13_01"
        CSAPI.LoadImg(textImg,"UIs/DungeonActivity7/" ..imgName ..".png",false,nil,true)
    end
end

function SetStar()
    CSAPI.SetGOActive(starObj,not isPlot and not IsDanger() and not isSpecial)
    if not isPlot and not IsDanger() and not isSpecial then
        local starNum = 0
        if dungeonData then
            starNum = dungeonData:GetStar()
        end
        local iconName = ""
        for i = 1, 3 do
            if i <= starNum then
                iconName = currLevel == 2 and "03_02" or "04_02"
            else
                iconName = currLevel == 2 and "03_01" or "04_01"
            end
            ResUtil.DungeonSummer:Load(this["star" .. i].gameObject,"img_".. iconName)
        end
    end
end

function SetLock()
    CSAPI.SetGOActive(unLockObj,not isLock)
    CSAPI.SetGOActive(lockObj, isLock)
    if isLock then
        CSAPI.SetGOActive(starLockObj,not isPlot)
        CSAPI.SetGOActive(pLockIcon1,isPlot)
        CSAPI.SetGOActive(dLockIcon1,not isPlot and not isSpecial)
        CSAPI.SetGOActive(sLockIcon1,isSpecial)
    end
end

function SetIsLock(b)
    isLock=b
end

function IsPass()
    return dungeonData and dungeonData:IsPass()
end

function GetCfg()
    return cfgDungeon
end

function GetType()
    if cfgDungeon and cfgDungeon.sub_type and cfgDungeon.sub_type == 1  then
        return DungeonInfoType.SummerPlot
    elseif IsDanger() then
        return DungeonInfoType.SummerDanger
    elseif IsSpecial() then
        return DungeonInfoType.SummerSpecial
    end
    return DungeonInfoType.Summer
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

function GetCfgs()
    local cfgs = {}
    if ids and #ids > 0 then
        for _, cfgId in ipairs(ids) do
            local cfg =Cfgs.MainLine:GetByID(cfgId)
            if cfg then
                table.insert(cfgs,cfg)
            end
        end
    end
    return cfgs
end

function OnClick()
    if isLock then
        Tips.ShowTips(lockStr)
        return
    end
    if cb then
        cb(this)
    end
end

-----------------------------------------anim-----------------------------------------

function InitAnim()
    anim1 = ComUtil.GetCom(iconAnim1,"Animator")
    anim2 = ComUtil.GetCom(iconAnim2,"Animator")
    anim3 = ComUtil.GetCom(iconAnim3,"Animator")

    if not IsNil(anim1) then
        anim1.keepAnimatorControllerStateOnDisable = true
    end
    if not IsNil(anim2) then
        anim2.keepAnimatorControllerStateOnDisable = true
    end
    if not IsNil(anim3) then
        anim3.keepAnimatorControllerStateOnDisable = true
    end
    CSAPI.SetGOActive(hardObj,false)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go,false)
    CSAPI.SetGOActive(go,true)
end

function ShowEnterAnim(idx,_delay)
    _delay = _delay or 60
    local delay = (idx -1 ) * _delay
    CSAPI.SetAnchor(move,0,-600)
    FuncUtil:Call(function ()
        ShowEffect(enterAction)
    end,this,delay)
end

function ShowSelAnim(b)
    isSelect = b
    local anim = isPlot and anim2 or anim1
    anim =isSpecial and anim3 or anim
    if b then
        ShowEffect(selAction)
        CSAPI.SetGOActive(nolAction,false)
        if not IsNil(anim) then
            anim:SetBool("isSelect",true)
        end
    else
        ShowEffect(nolAction)
        CSAPI.SetGOActive(selAction,false)
        if not IsNil(anim) then
            anim:SetBool("isSelect",false)
        end
    end
    if not isPlot and currLevel == 2 then
        CSAPI.SetGOActive(hardObj, b)
    end
end

function ShowUnLockAnim()
    CSAPI.SetGOActive(lockObj,true)
    CSAPI.SetGOActive(unLockObj,true)
    isLock = false
    SetTitle()
    ShowEffect(unLockAction)
    local anim = isPlot and anim2 or anim1
    anim =isSpecial and anim3 or anim
    local animName = isPlot and "Story_bg_unlock" or  "Rudder_unlock"
    animName = isSpecial and "Level_bossUnlock" or  animName
    if not IsNil(anim) then
        anim:Play(animName)
    end
end

function ShowChangeLevel()
    ShowEffect(changeAction)
end