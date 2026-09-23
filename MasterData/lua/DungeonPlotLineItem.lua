-- 点线段
local lines = {}
local datas = {}
local isShadow = false
local lineHeight = 12

function SetLine(pos)
    if pos == nil or #pos <= 1 then
        return;
    end
    local p = pos[1]
    CSAPI.SetAnchor(gameObject, p[1], p[2])
    datas = {}
    if #lines < 1 then
        table.insert(lines, {
            line = line1.gameObject,
            actionLine = CSAPI.CloneGO(line1, gameObject.transform), --用于开场动效
            shadow = shadow1.gameObject
        })
    else
        for i, v in ipairs(lines) do
            CSAPI.SetGOActive(v.line, false)
            CSAPI.SetGOActive(v.shadow, false)
            CSAPI.SetGOActive(v.actionLine, false)
        end
    end
    for i = 2, #pos do
        local lineGO = nil
        local shadowGO = nil
        local actionLineGO = nil
        if i - 1 > #lines then
            shadowGO = CSAPI.CloneGO(shadow1, gameObject.transform)
            lineGO = CSAPI.CloneGO(line1, gameObject.transform)
            actionLineGO = CSAPI.CloneGO(line1, gameObject.transform)
            table.insert(lines, {
                line = lineGO,
                actionLine = actionLineGO,
                shadow = shadowGO
            })
        else
            shadowGO = lines[i - 1].shadow
            lineGO = lines[i - 1].line
            actionLineGO = lines[i - 1].actionLine
        end

        local p1 = pos[i - 1];
        local p2 = pos[i];
        local rotateZ = CountAngle(p1, p2);
        rotateZ = rotateZ < 0 and rotateZ + 360 or rotateZ
        local width = math.sqrt((p1[1] - p2[1]) * (p1[1] - p2[1]) + (p1[2] - p2[2]) * (p1[2] - p2[2]));
        local x = p1[1] - p[1]
        local y = p1[2] - p[2]
        -- line
        CSAPI.SetGOActive(lineGO, true)
        CSAPI.SetAnchor(lineGO, x, y, 0);
        CSAPI.SetAngle(lineGO, 0, 0, rotateZ);
        CSAPI.SetRTSize(lineGO, width + 1.2, lineHeight);
        -- shadow
        CSAPI.SetGOActive(shadowGO, isShadow)
        CSAPI.SetRTSize(shadowGO, width + 1.2, 12);
        CSAPI.SetAngle(shadowGO, 0, 0, rotateZ);
        CSAPI.SetAnchor(shadowGO, x, y - 10)
        -- actionLine
        CSAPI.SetGOActive(actionLineGO, false)
        CSAPI.SetAnchor(actionLineGO, x, y, 0);
        CSAPI.SetAngle(actionLineGO, 0, 0, rotateZ);
        CSAPI.SetRTSize(actionLineGO, width + 1.2, lineHeight);
    end
end

-- 设置图片
function SetLock(isUnLock)
    local name = isUnLock and "dot2" or "dot1"
    if lines and #lines > 0 then
        for i, v in ipairs(lines) do
            CSAPI.LoadImg(v.line, "UIs/DungeonActivity1/" .. name .. ".png", false, nil, true)
        end
    end
    lineHeight = isUnLock and 22 or 12
end

-- 计算角度
function CountAngle(p1, p2)
    local p = {};
    p.x = p2[1] - p1[1]
    p.y = p2[2] - p1[2]
    local r = math.atan(p.y, p.x) * 180 / math.pi;
    return r;
end

-----------------------------------------------anim-----------------------------------------------
function InitAnim()
    if lines and #lines > 0 then
        for i, v in ipairs(lines) do
            CSAPI.SetGOActive(v.actionLine, true)
            --固定图片
            CSAPI.LoadImg(v.line, "UIs/DungeonActivity1/dot1.png", false, nil, true)
            CSAPI.LoadImg(v.actionLine, "UIs/DungeonActivity1/dot2.png", false, nil, true)
            --更改高度
            local size = CSAPI.GetRTSize(v.line)
            CSAPI.SetRTSize(v.line, size[0], 12)
            CSAPI.SetRTSize(v.actionLine, size[0], 22)
            --图片填充预先设置为0
            local img = ComUtil.GetCom(v.actionLine, "Image")
            if img then
                img.fillAmount = 0
            end
        end
    end
end

function PlayAnim()
    if lines and #lines > 0 then
        for i, v in ipairs(lines) do
            local fillAction = ComUtil.GetCom(v.actionLine, "ActionUIImgFilled")
            if fillAction then
                fillAction.time = 100
                fillAction.delay = (i - 1) * 100
                fillAction:Play()
            end
        end
    end
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
    lineMask = nil;
    line = nil;
    dotClose = nil;
    dotOpen = nil;
    view = nil;
end
----#End#----
