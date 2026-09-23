-- cfg : CfgOpenCondition
local canClick = true;
function Refresh(_cfg)
    cfg = _cfg

    -- anchor
    local pivot = cfg.pivot or 5
    local rect = ComUtil.GetCom(gameObject, "RectTransform")
    local x = 0
    local y = 0
    if (pivot == 1 or pivot == 4 or pivot == 7) then
        x = 0
    elseif (pivot == 2 or pivot == 5 or pivot == 8) then
        x = 0.5
    elseif (pivot == 3 or pivot == 6 or pivot == 9) then
        x = 1
    end
    -- if(pivot % 2 == 0) then
    -- 	x = 0.5
    -- elseif(pivot % 3 == 0) then
    -- 	x = 1
    -- end
    if (pivot < 4) then
        y = 1
    elseif (pivot < 7) then
        y = 0.5
    end

    rect.anchorMin = UnityEngine.Vector2(x, y)
    rect.anchorMax = UnityEngine.Vector2(x, y)

    -- pos
    CSAPI.SetAnchor(gameObject, cfg.pos[1], cfg.pos[2], 0)

    -- firstOpen
    if (cfg.first_open == 1) then
        local id = PlayerClient:GetID()
        local value = PlayerPrefs.GetInt(id .. "first_open_" .. cfg.id)
        if (value == nil or value == 0) then
            CSAPI.OpenView("ModuleInfoView", cfg)
            PlayerPrefs.SetInt(id .. "first_open_" .. cfg.id, 1)
        end
    end
end

function OnClick()
    if canClick ~= true then
        return;
    end
    CSAPI.OpenView("ModuleInfoView", cfg)
end

function ActiveClick(_canClick)
    canClick = _canClick
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

    view = nil;
end
----#End#----
