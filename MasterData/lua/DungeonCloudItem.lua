local data = nil
local currLevel = 1
local isOpen = false
local lockStr = ""
local ids = nil
local cfgDungeon = nil
local dungeonData = nil
local isPlot = false
local isPass= false
local levelAnims = {}

function Awake()
    InitAnim()
    CSAPI.SetGOActive(nol,true)
end

function OnEnable()
    -- if not IsNil(levelAnims[currLevel]) then
    --     levelAnims[currLevel].enabled = true
    -- end
end


function OnDisable()
    if not IsNil(levelAnims[currLevel]) then
        levelAnims[currLevel].enabled = false
    end
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    CSAPI.SetGOAlpha(nol,b and 0 or 1)
    CSAPI.SetGOActive(selObj,b)
end

function Refresh(_data,_elseData)
    data = _data
    currLevel = _elseData or 1
    if data then
        isOpen,lockStr = data:IsOpen()
        ids = data:GetDungeonGroups()
        cfgDungeon = Cfgs.MainLine:GetByID(ids[1])
        dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
        isPlot = cfgDungeon and cfgDungeon.sub_type ~= nil  
        isPass =  dungeonData and dungeonData:IsPass()
        CSAPI.SetAnchor(pos,0,index%2 == 0 and 14 or -44)
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
    CSAPI.SetText(txtTitle1,LanguageMgr:GetByID(15124) .." ".. (index < 10 and "0"..index or index))
    CSAPI.SetText(txtTitle2,data:GetName())
end

function SetPlot()
    CSAPI.SetGOActive(plotImg,isPlot)
end

function SetPass()
    CSAPI.SetGOActive(passImg,isPass)
end

function SetDungeon()
    local str = currLevel == 1 and "easy" or "hard"
    str = currLevel == 3 and "extra" or str
    CSAPI.LoadImg(nol,"UIs/DungeonActivity11/" .. str .. "_01.png",true,nil,true)
end

function SetLock()
    CSAPI.SetGOActive(lockObj,not isOpen)
end

function SetStar()
    CSAPI.SetGOActive(starObj,not isPlot and not IsDanger() and not IsSpecial())
    if not isPlot and not IsDanger() and not IsSpecial() then
        local starNum = 0
        if dungeonData then
            starNum = dungeonData:GetStar()
        end
        local iconName = ""
        for i = 1, 3 do
            iconName = i <= starNum and "star_01" or "star_02"
            CSAPI.LoadImg(this["star" .. i].gameObject,"UIs/DungeonActivity11/" .. iconName .. ".png",true,nil,true)
        end
    end
end

function SetNew()
    CSAPI.SetGOActive(newImg,dungeonData and dungeonData:IsOpen() and not dungeonData:IsPass())
end

function GetCfg()
    return cfgDungeon
end

function GetType()
    if cfgDungeon and cfgDungeon.sub_type and cfgDungeon.sub_type == 1  then
        return DungeonInfoType.CloudPlot
    elseif IsDanger() then
        return DungeonInfoType.CloudDanger
    elseif IsSpecial() then
        return DungeonInfoType.CloudSpecial
    end
    return DungeonInfoType.Cloud
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
    CSAPI.SetGOActive(lockAnim,false)
    table.insert(levelAnims,ComUtil.GetCom(easySel,"Animator"))
    table.insert(levelAnims,ComUtil.GetCom(hardSel,"Animator"))
    table.insert(levelAnims,ComUtil.GetCom(extraSel,"Animator"))
end

function SetAnim()
    CSAPI.SetGOActive(easySel,currLevel == 1)
    CSAPI.SetGOActive(hardSel,currLevel == 2)
    CSAPI.SetGOActive(extraSel,currLevel == 3)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go,false)
    CSAPI.SetGOActive(go,true)
end

function ShowSelAnim(b)
    UIUtil:SetObjFade(nol,b and 1 or 0,b and 0 or 1,nil,300)
    if not IsNil(levelAnims[currLevel]) then
        levelAnims[currLevel].enabled = true
        levelAnims[currLevel]:Play(b and "Stage_sel_entry" or "Stage_unsel")
    end
end

function ShowUnLockAnim()
    CSAPI.SetGOActive(lockObj, true)
    UIUtil:SetObjFade(lockObj,1,0,nil,200)
end