local isSelect = false
local cb = nil
local elseData =nil
local cfgDungeon = nil
local dungeonData = nil
local isNew = false
local isLock = false
local actions = nil

function Awake()
    CSAPI.SetGOActive(enterAction,false)
    CSAPI.SetGOActive(unLockAnim,false)
    actions = ComUtil.GetComsInChildren(enterAction,"ActionBase")
    SetSelect(false)
end

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(_index)
    index = _index
end

function SetSelect(b)
    isSelect = b
    SetColor(b)
    CSAPI.SetGOActive(nol,not b)
    CSAPI.SetGOActive(nolImg,not b)
    CSAPI.SetGOActive(sel,b)
    CSAPI.SetGOActive(selImg, b)
end

function Refresh(_data,_elseData)
    cfgDungeon = _data
    elseData = _elseData
    if cfgDungeon then
        dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
        SetTitle()
        SetStar()
        SetHard()
        local isNew = DungeonMgr:IsDungeonOpen(cfgDungeon.id) and ((not dungeonData) or (dungeonData and not dungeonData:IsPass())) --关卡开启了但未通关
        SetNew(isNew)
        isLock = not DungeonMgr:IsDungeonOpen(cfgDungeon.id)
        SetLock(isLock)
    end
end

function SetIcon(iconName)
    local sectionData = DungeonMgr:GetSectionData(cfgDungeon.group)
    if not sectionData then
        LogError("找不到章节表数据！！！id:" .. cfgDungeon.group)
        return
    end
    local path = sectionData:GetIndex() > 10 and sectionData:GetIndex() or "0" .. sectionData:GetIndex() 
    path = "icon_01_" .. path
    if iconName and iconName~= "" then
        ResUtil:LoadBigImg(icon,"UIs/DungeonActivity/Role/" .. path .."/" .. iconName)
    end
end

function SetTitle()
    CSAPI.SetText(txtIndex1, index .. "")
    CSAPI.SetText(txtIndex2, index .. "")

    local name = cfgDungeon.name
    CSAPI.SetText(txtName, name)

    CSAPI.SetGOActive(txt_plot, IsStory())
end

function SetColor(b)
    -- local color1 = b and {255,193,70,255} or {0,0,0,255}
    -- CSAPI.SetTextColor(txtIndex1,color1[1],color1[2],color1[3],color1[4])

    local color2 = b and {255,193,70,255} or {255,255,255,255}
    CSAPI.SetTextColor(txtIndex2,color2[1],color2[2],color2[3],color2[4])
    CSAPI.SetTextColor(txt_index,color2[1],color2[2],color2[3],color2[4])
    CSAPI.SetTextColor(txtName,color2[1],color2[2],color2[3],color2[4])
end

function SetStar()
    CSAPI.SetGOActive(txtStar,not IsStory())
    if not IsStory() then
        local cur = dungeonData and dungeonData:GetStar() or 0
        local max = StringUtil:SetByColor("/3","FFC146")
        if cur >= 3 then
            cur =  StringUtil:SetByColor(cur,"FFC146")
        end
        CSAPI.SetText(txtStar,cur .. max)
    end
end

function SetHard()
    local isHard = elseData == 2
    CSAPI.SetGOActive(hardImg, isHard)
end

function SetNew(b)
    CSAPI.SetGOActive(new,b)
end

function SetLock(_isLock)
    CSAPI.SetImgColor(mask,255,255,255,_isLock and 255 or 0)
    CSAPI.SetGOActive(lock,_isLock)
end

function IsStory()
    return cfgDungeon and cfgDungeon.sub_type == DungeonFlagType.Story
end

function GetCfg()
    return cfgDungeon
end

function GetLock()
    return isLock
end

function GetType() 
    return IsStory() and DungeonInfoType.Plot or DungeonInfoType.Normal
end

function OnClick()
    if isLock then      
        return
    end
    if cb then
        cb(this)
    end
end

-----------------------------------------------动效-----------------------------------------------

function PlayEnterAnim()
    if actions.Length>0 then
        for i = 0, actions.Length - 1 do
            actions[i].delay = index % 2 == 0 and 100 or 0
        end
    end

    CSAPI.SetGOActive(enterAction, false)
    CSAPI.SetGOActive(enterAction, true)
end

function PlayUnLockAnim()
    CSAPI.SetGOActive(unLockAnim, false)
    CSAPI.SetGOActive(unLockAnim, true)
    FuncUtil:Call(function ()
        if gameObject then
            CSAPI.SetGOActive(unLockAnim, false)
            CSAPI.SetScale(lockImg,1,1,1)
            SetNew(true)
            local canvasGroup1 = ComUtil.GetOrAddCom(lock,"CanvasGroup")
            canvasGroup1.alpha = 1
            local canvasGroup2 = ComUtil.GetOrAddCom(mask,"CanvasGroup")
            canvasGroup2.alpha = 1
            SetLock(false)
        end
    end,this,620)
end