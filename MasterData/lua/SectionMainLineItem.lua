local data = nil
local index = 0
local titleIdx = 0
local cb = nil
local upCb = nil
local elseData = nil
local isLock = false
-- local rect = nil
local curX = 0
local hardLv = 1

local textRand = nil
local fadeT = nil

function Awake()
    textRand = ComUtil.GetCom(action, "ActionTextRand")
    fadeT = ComUtil.GetCom(action, "ActionFadeT")
end

function SetIndex(idx)
    index = idx
end

function SetTitleIdx(idx)
    titleIdx = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetUpCb(_cb)
    upCb = _cb
end

function Init()
    CSAPI.SetRectAngle(node, 0, 0, 0)
    CSAPI.SetScale(node, 1, 1, 1)
end

function Refresh(_data, _elseData)
    data = _data
    elseData = _elseData
    if data then
        hardLv =DungeonMgr:GetDungeonHardLv(data:GetID())
        isLock = data:GetState(hardLv) == 0
        if hardLv == 2 and isLock then --困难未开启但切换到了困难则返回普通难度
            hardLv = 1
            DungeonMgr:SetDungeonHardLv(data:GetID(),hardLv)
            isLock = data:GetState(hardLv) == 0
        end
        curX = CSAPI.GetLocalPos(gameObject)
        if not (elseData.fakeType > 0) then
            SetBg()
            SetPart()
            SetTitle()
            SetDesc()
            SetLock()
            SetHard()
            SetRed()
        end

        CSAPI.SetGOActive(nol, not (elseData.fakeType > 0))
        CSAPI.SetGOActive(fake, elseData.fakeType > 0)
        CSAPI.SetGOActive(fakeText, elseData.fakeType > 1 and not CSAPI.IsAppReview())
    end
end

function SetBg()
    local bgName = data:GetSectionBG()
    ResUtil:LoadBigImg(bg, "UIs/SectionImg/sBg2/" .. bgName, false)
end

function SetTitle()
    local str = isLock and LanguageMgr:GetByID(15080) or data:GetName()
    CSAPI.SetText(txtTitle, str)
end

function SetDesc()
    local str = data:GetMapName()
    if isLock then
        str = hardLv > 1 and  data:GetHardLockDesc() or data:GetLockDesc()
    end
    CSAPI.SetText(txtDesc, str)
    textRand.targetStr = str
end

function SetPart()
    local _titleIdx = titleIdx - 1
    local indexStr = _titleIdx > 9 and _titleIdx .. "" or "0" .. _titleIdx
    CSAPI.SetText(txtPart, "PART " .. indexStr)
    CSAPI.SetText(txtIndex, indexStr)
end

function SetLock()
    local color = isLock and {146, 146, 150, 255} or {255, 255, 255, 255}
    CSAPI.SetTextColor(txtIndex, color[1], color[2], color[3], color[4])
    CSAPI.SetTextColor(txtTitle, color[1], color[2], color[3], color[4])
    CSAPI.SetTextColor(txtDesc, color[1], color[2], color[3], color[4])
    CSAPI.SetImgColor(titleImg, color[1], color[2], color[3], color[4])
    CSAPI.SetImgColor(bg, 255, 255, 255, isLock and 51 or 255)
    CSAPI.SetGOActive(lockImg, isLock)
end

function SetHard()
    CSAPI.SetGOActive(hardImg, hardLv > 1)
end

function SetAngle(x)
    local distance = curX - x
    distance = distance > 1144 and 1144 or distance
    distance = distance < -1144 and -1144 or distance
    local precent = distance / 1144
    local angle = 17.5 * precent
    CSAPI.SetRectAngle(node, 0, angle, 0)
    local scale = 0.95 + (0.05 * math.abs(precent))
    CSAPI.SetScale(node, scale, scale, 1)
end

function SetRed()
    local isRed = DungeonBoxMgr:CheckRed(data:GetID())
    UIUtil:SetRedPoint(redParent,isRed,0,0)
end

function ShowRed(b)
    if not canvasGroup then
        canvasGroup = ComUtil.GetCom(redParent,"CanvasGroup")
    end
    canvasGroup.alpha = b and 1 or 0
end

function OnClick()
    if elseData.fakeType > 0 then
        if elseData.fakeType > 1 and not CSAPI.IsAppReview() then
            LanguageMgr:ShowTips(1000)
        end
        return
    end

    if isLock then
        if data:GetCfg().preSection  then
            local preSectionData = DungeonMgr:GetSectionData(data:GetCfg().preSection)
            if preSectionData:GetState() ~= 2 then
                LanguageMgr:ShowTips(25001, preSectionData:GetName())
                return
            end
        end
        local _,lockStr = data:GetOpen()
        if lockStr and lockStr~="" then
            Tips.ShowTips(lockStr)
            return
        end
    end
    if cb and not isLock then
        cb(this)
    end
end

function GetID()
    return data and data:GetID() or 0
end

function GetIndex()
    return index
end

function GetTitleIdx()
    return titleIdx
end

function PlayAction()
    textRand:Play()
    fadeT:Play()
end
