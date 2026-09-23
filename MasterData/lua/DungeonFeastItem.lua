local data =nil --DungeonGroupData
local currLevel = 1
local isSel = false
local isLock = false
local lockStr = ""
local isPass = false
local ids = nil
local cfgDungeon = nil
local dungeonData = nil
local fade = nil
local animator = nil
local text = nil

function Awake()
    CSAPI.SetScale(scale, 0.75,0.75,0.75)
    SetSelect(false, true)
    InitAnim()
    text =ComUtil.GetCom(txtIndex,"Text")
end

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(idx)
    index= idx
end

function Refresh(_data,level)
    data = _data
    currLevel = level or 1
    if data then
        ids = data:GetDungeonGroups()
        if ids then
            cfgDungeon = Cfgs.MainLine:GetByID(ids[1])
            dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
            local isOpen,_lockStr = data:IsOpen()
            isLock,lockStr = not isOpen,_lockStr
        end 
        SetLevel()
        SetIcon()
        SetState()
        SetText()
        SetStar()
        SetNew()
    end
end

function SetText()
    local str = index < 10 and "0" .. index or index .. ""
    CSAPI.SetText(txtIndex,str)
end

function SetLevel()
    local iconName = currLevel == 1 and "easy" or "hard"
    CSAPI.LoadImg(img,"UIs/DungeonActivity5/" .. iconName .. "_01.png", true,nil,true)
    CSAPI.SetGOActive(hardImg, currLevel == 2)
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName~=nil and iconName~="" then
        ResUtil.Feast:Load(icon, iconName)
    end
end

function SetStar()
    CSAPI.SetGOActive(starObj,not IsStory() and not IsDanger() and not IsSpecial())
    if not IsStory() and not IsDanger() then
        local star = 0
        if dungeonData then
            star = dungeonData:GetStar()
        end
        local colors = {{255,193,70,255},{255,255,255,255}}
        for i = 0, 2 do
            local go = starObj.transform:GetChild(i).gameObject
            local color = star >= (i + 1) and colors[1] or colors[2]
            CSAPI.SetImgColor(go,color[1],color[2],color[3],color[4])
        end
    end
end

function SetState()
    CSAPI.SetGOActive(nolImg, not isSel and not isLock)
    CSAPI.SetGOActive(selImg, isSel and not isLock and not isPass)
    CSAPI.SetGOActive(lockImg, isLock)
    CSAPI.SetGOActive(passImg, isPass)
    CSAPI.SetGOActive(hardEffect,not isLock and currLevel == 2)
    CSAPI.SetGOActive(selImg2,isSel)
    CSAPI.SetGOActive(nolImg2,not isSel)
    if not isLock then
        CSAPI.SetImgColor(nolImg,255,255,255,isPass and 128 or 204)
    end
    if not IsNil(text) then
        text.fontSize = isSel and 60 or 49
    end
    CSAPI.SetTextColor(txtIndex,255,255,255,isSel and 255 or 204)
    if isSel then
        CSAPI.MoveTo(txtIndex,"UI_Local_Move",-58,65,0,nil,0.2)
        -- CSAPI.SetAnchor(txtIndex,-58,65)
    else
        CSAPI.MoveTo(txtIndex,"UI_Local_Move",-44,50,0,nil,0.2)
        -- CSAPI.SetAnchor(txtIndex,-44,50)
    end
end

function SetNew()
    CSAPI.SetGOActive(newImg,dungeonData and dungeonData:IsOpen() and not dungeonData:IsPass())
end

function SetSelect(b,isNol)
    isSel = b
    SetState()
    if isNol then
        CSAPI.SetGOActive(selAnim, isSel)
        local _scale = isSel and 1 or 0.75
        CSAPI.SetScale(scale,_scale,_scale,_scale)
        if not IsNil(animator) and hardEffect.gameObject.activeSelf == true then
            animator:SetBool("isSel", isSel)
        end
    else
        ShowSelAnim()
    end
end

function GetInfoType()
    if IsDanger() then
        return DungeonInfoType.Danger
    elseif IsStory() then
        return DungeonInfoType.Plot
    elseif IsSpecial() then
        return DungeonInfoType.FeastSpecial
    end
    return DungeonInfoType.Feast 
end

function GetCfg()
    return cfgDungeon
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

function IsDanger()
    return ids and #ids > 1
end

function IsStory()
    return cfgDungeon and cfgDungeon.sub_type == DungeonFlagType.Story;
end

function IsOpen()
    return not isLock
end

function IsSpecial()
    return cfgDungeon and cfgDungeon.diff and cfgDungeon.diff == 4
end

function OnClick()
    if cb then
        cb(this)
    end
end

-----------------------------anim-----------------------------

function InitAnim()
    animator= ComUtil.GetComInChildren(hardEffect,"Animator")
    CSAPI.SetGOActive(enter,false)
    CSAPI.SetGOActive(animImg,false)
    CSAPI.SetGOActive(selAnim,false)
    CSAPI.SetGOActive(clickAnim,false)
    fade = ComUtil.GetCom(animImg,"ActionFade")
end

function ShowEffect(go)
    CSAPI.SetGOActive(go,false)
    CSAPI.SetGOActive(go,true)
end

function ShowEnterAnim(delay)
    CSAPI.SetGOAlpha(move,0)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(enter, true)
    end,this,delay)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(enter, false)
    end,this,delay + 800)
end

function ShowSelAnim()
    if isSel then
        CSAPI.SetGOActive(animImg,true)
        fade:Play(0,1,200)
        FuncUtil:Call(function ()
            fade:Play(1,0,600)
        end,this,200)
    end
    CSAPI.SetGOActive(selAnim, isSel)
    local _scale = isSel and 1 or 0.75
    CSAPI.SetUIScaleTo(scale,nil,_scale,_scale,_scale,nil,0.2)
    if not IsNil(animator) and hardEffect.gameObject.activeSelf == true then
        animator:SetBool("isSel", isSel)
    end
end

function ShowClickAnim(b)
    CSAPI.SetGOActive(clickAnim, b)
end

