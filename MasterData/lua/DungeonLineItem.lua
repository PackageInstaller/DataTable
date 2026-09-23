-- 点线段
local lines = {}
local datas = {}
local index = 1
local curIndex = 0
local linePool = {}

function Awake()
    -- lineMove = ComUtil.GetCom(lineMask, "ActionMoveByCurve");

    canvasGroup = ComUtil.GetCom(gameObject, "CanvasGroup")

    dotCloseFadeT = ComUtil.GetCom(dotClose, "ActionFadeT")
    dotOpenFadeT = ComUtil.GetCom(dotOpen, "ActionFadeT")
end

-- function Update()
--     if datas and #datas > 0 then
--         if curIndex ~= index then
--             curIndex = index
--             lineMove.time = datas[index].t
--             local sp = datas[index].sp
--             local ep = datas[index].ep
--             lineMove.startPos = UnityEngine.Vector3(sp[1], sp[2], 0)
--             lineMove.targetPos = UnityEngine.Vector3(ep[1], ep[2], 0)
--             CSAPI.SetAngle(lineMask, 0, 0, datas[index].a);
--             lineMove:Play(function()
--                 index = index >= #datas and 1 or index + 1
--                 curIndex = index >= #datas and 0 or curIndex
--             end)
--         end
--     end
-- end

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
            shadow = shadow1.gameObject
        })
    else
        for i, v in ipairs(lines) do
            CSAPI.SetGOActive(v.line, false)
            CSAPI.SetGOActive(v.shadow, false)
        end
    end
    for i = 2, #pos do
        local lineGO = nil
        local shadowGO = nil
        if i - 1 > #lines then
            shadowGO = CSAPI.CloneGO(shadow1, gameObject.transform)
            lineGO = CSAPI.CloneGO(line1, gameObject.transform)        
            table.insert(lines, {
                line = lineGO,
                shadow = shadowGO
            })
        else
            shadowGO = lines[i - 1].shadow
            lineGO = lines[i - 1].line           
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
        CSAPI.SetRTSize(lineGO, width + 1.2, 12);
        -- shadow
        CSAPI.SetGOActive(shadowGO, true)
        CSAPI.SetRTSize(shadowGO, width + 1.2, 12);
        CSAPI.SetAngle(shadowGO, 0, 0, rotateZ);
        CSAPI.SetAnchor(shadowGO, x, y - 10)
    end
end

-- 设置图片
function SetLock(isUnLock)
    local name = isUnLock and "dot1" or "dot2"
    CSAPI.LoadImg(line1, "UIs/Dungeon/" .. name .. ".png", false, nil, true)
end

-- 计算角度
function CountAngle(p1, p2)
    local p = {};
    p.x = p2[1] - p1[1]
    p.y = p2[2] - p1[2]
    local r = math.atan(p.y, p.x) * 180 / math.pi;
    return r;
end

function SetShow(isShow)
    canvasGroup.alpha = isShow and 1 or 0
end

function SetLineAction(isOpen)
    if not isOpen then
        dotCloseFadeT:Play()
    else
        dotOpenFadeT:Play()
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
