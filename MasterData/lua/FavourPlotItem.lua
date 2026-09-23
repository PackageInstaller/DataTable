-- {lv, cfgData} --CfgCardRoleStory ->info 
function Refresh(_role, _data, _isNext, _isGet)
    cRoleData = _role
    lv = _data[1]
    storyCfg = _data[2]
    isNext = _isNext -- 是否是下一个准备解锁的
    isGet = _isGet -- 是否已领取故事奖励

    isOpen = cRoleData:GetLv() >= lv

    -- heart bg 
    CSAPI.SetGOActive(imgHeartBg, isOpen)
    local bgName = isOpen and "img_09_02.png" or "img_09_04.png"
    CSAPI.LoadImg(imgHeart, "UIs/Favour/" .. bgName, true, nil, true)
    -- lv 
    CSAPI.SetText(txtLv, lv .. "")
    --
    SetLine()
    -- red
    local isRed = false
    if (isOpen and not isGet) then
        isRed = true
    end
    UIUtil:SetRedPoint(line, isRed, 223, 228, 0)
end

-- 无，未解锁，已解锁未领取，已解锁已领取
function SetLine()
    CSAPI.SetGOActive(line, storyCfg ~= nil)
    if (storyCfg ~= nil) then
        CSAPI.SetGOActive(entity, isOpen)
        CSAPI.SetGOActive(empty, not isOpen)
        CSAPI.SetGOActive(txtEmpty, (not isOpen and not isNext) and true or false)
        CSAPI.SetGOActive(iconObj, (isOpen or isNext) and true or false)
        if (isOpen or isNext) then
            -- icon
            ResUtil.Card:Load(icon, cRoleData:GetIcon())
            -- talk 
            local story = Cfgs.StoryInfo:GetByID(storyCfg.story_id)
            local colorName = isNext and "000000" or "ff4d7a"
            StringUtil:SetColorByName(txtTalk, story.name, colorName)
        end
    end
end

function OnClickTalk()
    if (isOpen) then
        -- 播放剧情 
        CSAPI.OpenView("Plot", {
            storyID = storyCfg.story_id,
            playCallBack = PlayCallBack
        })
    elseif (isNext) then
        -- 预览
        CSAPI.OpenView("FavourPlotInfoView", {cRoleData, storyCfg})
    end
end

function PlayCallBack()
    if (not isGet) then
        PlayerProto:PassCardRoleStory(cRoleData:GetID(), storyCfg.index)
    end
end
