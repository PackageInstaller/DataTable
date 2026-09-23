local data = nil
local isBuild = false
local isOpen = false
local lockStr = ""
local isSel = false
local currLevel = nil
local img1, img2, img3 = nil, nil, nil
local isAllBuild = false
local buildCfg  = nil

function Awake()
    InitAnim()
    img1 = ComUtil.GetCom(buildIcon, "Image")
    img2 = ComUtil.GetCom(buildSelIcon, "Image")
    img3 = ComUtil.GetCom(emptyObj, "Image")
    SetSelect(false)
    CSAPI.SetGOActive(showObj, false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    isSel = b
    CSAPI.SetGOActive(selImg, b)
    CSAPI.SetGOActive(buildIcon, not b)
    CSAPI.SetGOActive(buildSelIcon, b)
    -- img1.raycastTarget = not b
    -- img2.raycastTarget = not b
    -- img3.raycastTarget = not b
end

function Refresh(_data, _elseData)
    data = _data
    currLevel = _elseData and _elseData.level or 1
    currLevel = currLevel == 1 and 1 or 2
    isAllBuild = _elseData and _elseData.isAllBuild
    if data then
        isOpen, lockStr = data:IsOpen(currLevel)
        if data:GetType() == 3 then
            isOpen, lockStr = data:IsOpen(2)
        end
        isBuild = data:IsBuild()
        buildCfg = data:GetDungeonBuildCfg()
        SetIndexText()
        SetBuild()
        SetLock()
    end
end

function SetIndexText()
    CSAPI.SetText(txtIndex, index .. "")
    CSAPI.SetText(txtIndex2, index .. "")
    CSAPI.SetGOActive(indexObj,not isAllBuild or currLevel == 2)
    CSAPI.SetGOActive(indexObj2,isAllBuild and currLevel == 1)
    if isBuild and isOpen then
        local pos = data:GetTargetContent("indexPos")
        if isAllBuild and currLevel == 1 then
            CSAPI.SetAnchor(indexObj2,pos[1],pos[2])
        else
            CSAPI.SetAnchor(indexObj,pos[1],pos[2])
        end
        local num = 0
        if buildCfg then
            local dungeonData = DungeonMgr:GetDungeonData(buildCfg.id)
            if dungeonData then
                for i, v in ipairs(dungeonData:GetNGrade()) do
                    if v > 0 then
                        num = num + 1
                    end
                end
            end
        end
        CSAPI.LoadImg(indexImg,"UIs/DungeonActivity19/img_23_0" .. (num == 2 and 4 or 3) .. ".png",true,nil,true)
    else
        CSAPI.SetAnchor(indexObj,50,50)
        CSAPI.SetAnchor(indexObj2,50,50)
    end
end

function SetBuild()
    CSAPI.SetGOActive(emptyObj, not (isBuild or data:GetType() == 3) and isOpen)
    if isBuild then
        local pos = data:GetTargetContent("buildPos")
        if pos then
            CSAPI.SetAnchor(buildIcon,pos[1],pos[2])
        end
        local iconName = data:GetBuildIcon()
        if iconName then
            ResUtil.DungeonBuild:Load(buildIcon, "Map/" .. data:GetGroup() .. "/" .. iconName .. "_02")
            ResUtil.DungeonBuild:Load(buildSelIcon, "Map/" .. data:GetGroup() .. "/" .. iconName .. "_01")
        end
    end
    if data:GetType() == 3 then
        ResUtil.DungeonBuild:Load(buildIcon, "Map/" .. data:GetGroup() .. "/icon_25_02")
        ResUtil.DungeonBuild:Load(buildSelIcon, "Map/" .. data:GetGroup() .. "/icon_25_01")
    end
end

function SetLock()
    CSAPI.SetGOActive(lockImg, not (isOpen or data:GetType() == 3))
    CSAPI.SetGOActive(mapLock, not (isOpen or data:GetType() == 3) and currLevel == 1)
    if data:GetType() == 3 then
        CSAPI.SetGOActive(specialLockObj,not isOpen)
    else
        CSAPI.SetGOActive(specialLockObj,false)
    end
    if currLevel == 1 then
        ResUtil.DungeonBuild:Load(mapLock, "Map/" .. data:GetGroup() .. "/icon_00_" .. (index < 10 and "0" .. index or index))
        local pos = data:GetTargetContent("MapLockPos")
        if pos then
            CSAPI.SetAnchor(mapLock,pos[1],pos[2])
        end
    end
end

function SetPos()
    local info = GetInfo()
    if info and info[1] and info[1].pos then
        CSAPI.SetLocalPos(gameObject, info[1].pos[1], info[1].pos[2])
    end
end

function GetInfo()
    return data and data:GetTargetJson()
end

function GetDungeonCfgs()
    return data and data:GetDungeonCfgs()
end

function GetName()
    return data and data:GetName() or ""
end

-- 展示用
function SetFakeBuildIcon(isShow, idx)
    CSAPI.SetGOActive(node, not isShow)
    CSAPI.SetGOActive(showObj, isShow)
    if isShow then
        local _cfg = data:GetDungeonBuildCfg()
        if _cfg and _cfg.UnlockBuildingID and _cfg.UnlockBuildingID[idx] then
            local cfgBuild = Cfgs.Building:GetByID(_cfg.UnlockBuildingID[idx])
            if cfgBuild and cfgBuild.MapIcon then
                ResUtil.DungeonBuild:Load(icon, "Map/" .. data:GetGroup() .. "/" .. cfgBuild.MapIcon .. "_01")
                ResUtil.DungeonBuild:Load(effect1, "Map/" .. data:GetGroup() .. "/" .. cfgBuild.MapIcon .. "_01")
            end
        end
    end
end

function SetShowShare(isShow)
    if not isBuild then
        CSAPI.SetGOActive(emptyObj, not isShow)
    end
    if not isOpen then
        CSAPI.SetGOActive(lockImg, not isShow)
    end
    CSAPI.SetGOActive(indexObj, not isShow)
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
------------------------------anim------------------------------
local anim, showAnim,unLockAnim = nil, nil,nil
function InitAnim()
    anim = ComUtil.GetCom(node, "Animator")
    showAnim = ComUtil.GetCom(showObj, "Animator")
end

function PlayAnim(str)
    if not IsNil(anim) then
        anim:Play(str)
    end
end

function ShowEnterAnim()
    PlayAnim("entry")
end

function ShowQuitAnim()
    PlayAnim("quit")
end

function ShowSelAnim(b)
    SetSelect(b)
    if b then
        PlayAnim("sel")
    end
end

function PlayShowAnim(str)
    if not IsNil(showAnim) then
        showAnim:Play(str)
    end
end

