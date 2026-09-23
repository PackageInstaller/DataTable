-- 能力 item
local canvasGroup1 = nil
local canvasGroup2 = nil
local txtCG1 = nil
local txtCG2 = nil
local isSkill = nil
local isLock = nil
local curSelectID = 0

function Awake()
    canvasGroup1 = ComUtil.GetCom(topObj1, "CanvasGroup")
    canvasGroup2 = ComUtil.GetCom(topObj2, "CanvasGroup")

    txtCG1 = ComUtil.GetCom(txtName1, "CanvasGroup")
    txtCG2 = ComUtil.GetCom(txtName2, "CanvasGroup")
    CSAPI.SetGOActive(unLock, false)
    CSAPI.SetGOActive(icon1_1, false)
    CSAPI.SetGOActive(icon2_1, false)
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _curSelectID)
    data = _data
    curSelectID = _curSelectID
    if (data) then
        isSkill = data:GetCfg().type == AbilityType.SkillGroup
        isLock = data:GetIsLock()
        -- obj
        SetSkill(isSkill)
        -- select
        SetSelect(curSelectID == data:GetID())
        -- lv 
        SetLv()
        -- icon
        SetIcon()
        -- lock
        SetLock(isLock)
        -- red
        SetRed()
    end
end

function SetSkill(b)
    CSAPI.SetGOActive(clickNode1, b)
    CSAPI.SetGOActive(clickNode2, not b)

    CSAPI.SetText(txtName1, data:GetCfg().name)
    CSAPI.SetText(txtName2, data:GetCfg().name)

    local scale = b and 1 or 0.8
    CSAPI.SetScale(unLock, scale, scale, 1)
end

function SetSelect(b)
    local _select = isSkill and select1 or select2
    CSAPI.SetGOActive(_select, b)
end

function SetLv()
    local _, isMax, curLv, maxLv = data:GetSkills()
    curLv = (data:GetIsLock() or not isSkill) and 0 or curLv
    CSAPI.SetGOActive(lvObj, curLv > 0)
    if not isMax then
        local strLv = curLv.."/" .. maxLv
        CSAPI.SetText(txtLv, curLv > 0 and strLv or "")
    else
        LanguageMgr:SetText(txtLv,34004)
        -- CSAPI.SetText(txtLv, "Max")
    end
end

function SetIcon()
    local icon = isSkill and icon1 or icon2
    local _icon = isSkill and icon1_1 or icon2_1
    CSAPI.SetGOActive(icon, not isLock)
    -- if(not isLock) then
    local iconName = data:GetCfg().icon
    CSAPI.SetGOActive(icon, iconName ~= nil)
    if (iconName) then
        ResUtil.Ability:Load(icon, iconName)
        ResUtil.Ability:Load(_icon, iconName)
    end
    -- end
end

function SetLock(b)
    CSAPI.SetGOActive(lock, b)

    -- alpha
    local canvas = isSkill and canvasGroup1 or canvasGroup2
    canvas.alpha = isLock and 0.3 or 1

    local txtCanvas = isSkill and txtCG1 or txtCG2
    txtCanvas.alpha = data:CanOpen() and 1 or 0.3

    -- normal
    if (data:CanOpen() and (b)) then
        CSAPI.SetImgColor(lock, 254, 182, 44, 255)
    else
        CSAPI.SetImgColor(lock, 255, 255, 255, 255)
    end
end

function SetRed()
    if (isSkill) then
        CSAPI.SetAnchor(upImg, 84, 84)
    else
        CSAPI.SetAnchor(upImg, 64, 64)
    end
    local isShow = PlayerAbilityMgr:GetRed(data:GetID())
    CSAPI.SetGOActive(upImg, isShow)
end

function OnClick()
    if (cb) then
        cb(this)
    end
end

function AddSkill()
    -- CSAPI.SetGOActive(lock2, false)
    -- CSAPI.SetGOActive(addObj, false)
    if data then
        if data:GetIsLock() then
            CSAPI.SetGOActive(icon1_1, true)
            CSAPI.SetGOActive(icon2_1, true)
            CSAPI.SetGOActive(unLock, true)
            FuncUtil:Call(function()
                if (gameObject) then
                    CSAPI.SetGOActive(icon1_1, false)
                    CSAPI.SetGOActive(icon2_1, false)
                    CSAPI.SetGOActive(unLock, false)
                end
            end, nil, 1100)
            -- CSAPI.SetGOActive(lock2, true)
        end
        curSelectID = 0
    end
end

-- 只生成一次
function SetLine(parent, list)
    local x, y = CSAPI.GetAnchor(gameObject)
    lines = lines or {}
    local nextPos = data:GetCfg().next_id or {}
    -- for i = #nextPos + 1, #lines do
    --     CSAPI.SetGOActive(lines[i].gameObject, false)
    -- end
    for i, v in ipairs(nextPos) do
        -- if (i <= #lines) then
        --     CSAPI.SetParent(lines[i].gameObject, linesParent, false)
        --     CSAPI.SetAnchor(lines[i].gameObject, 0, 0)
        --     CSAPI.SetGOActive(lines[i].gameObject, true)
        --     local nextData = PlayerAbilityMgr:GetData(v)
        --     -- lines[i].Refresh(data:GetCfg(), nextData:GetCfg())
        --     lines[i].SetColor(not isLock and nextData:GetIsLock() and nextData:CanOpen())
        -- else
        ResUtil:CreateUIGOAsync("PlayerAbility/PlayerAbilityLine", linesParent, function(go)
            local line = ComUtil.GetLuaTable(go)
            local nextData = PlayerAbilityMgr:GetData(v)
            line.Refresh(data:GetCfg(), nextData:GetCfg())
            line.SetColor(not isLock and nextData:GetIsLock() and nextData:CanOpen())
            -- line.ShowDot(not isLock or nextData:CanOpen())
            table.insert(list, line)
            table.insert(lines, line)
        end)
        -- end
        CSAPI.SetParent(lines[i].gameObject, parent)
        CSAPI.SetAnchor(lines[i].gameObject, x, y)
    end
    return list
end

-- 设置线段颜色
function SetLineColor()
    if (#lines > 0) then
        local nextPos = data:GetCfg().next_id or {}
        for i, v in ipairs(nextPos) do
            local nextData = PlayerAbilityMgr:GetData(v)
            lines[i].SetColor(not isLock and nextData:GetIsLock() and nextData:CanOpen())
            -- lines[i].ShowDot(not isLock or nextData:CanOpen())
        end
    end
end

-- 设置位置
function SetPos()
    local pos = data:GetCfg().pos
    local x, y = PlayerAbilityMgr:GetPos(pos[1], pos[2])
    CSAPI.SetAnchor(gameObject, x, y, 0)
end

-- 开始动画
function PlayDotAction(view)
    if (#lines > 0) then
        local nextPos = data:GetCfg().next_id
        if (nextPos) then
            for i, v in ipairs(nextPos) do
                local nextData = PlayerAbilityMgr:GetData(v)
                local isShowDot = not isLock or nextData:CanOpen()
                if (isShowDot) then
                    lines[i].PlayDotAction(view)
                end
            end
        end
    end
end

function IsSkill()
    return isSkill
end

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    linesParent = nil;
    normalObj = nil;
    addObj = nil;
    clickNode1 = nil;
    select1 = nil;
    selectImg1 = nil;
    img = nil;
    img1 = nil;
    icon1 = nil;
    upImg = nil;
    lvBG = nil;
    txtLv = nil;
    txtName1 = nil;
    clickNode2 = nil;
    select2 = nil;
    selectImg2 = nil;
    img2 = nil;
    icon2 = nil;
    txtName2 = nil;
    lock = nil;
    lockLight = nil;
    lockImg = nil;
    lock2 = nil;
    writeMask1 = nil;
    writeMask2 = nil;
    iconFade1 = nil;
    iconFade2 = nil;
    topFade1 = nil;
    topFade2 = nil;
    txtFade1 = nil;
    txtFade2 = nil;
    lock_Fade = nil;
    view = nil;
end
----#End#----
