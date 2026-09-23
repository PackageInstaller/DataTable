local maxX = 13.5
local minY = 120
local isCheck = nil
local add = 150

function Awake()
    FightGridSelMgr.CloseInput(true); -- 开启时禁止战斗输入

    CSAPI.PlayUISound("ui_popup_open")
end

function Update()
    if (isCheck and isCheck >= 0) then
        isCheck = isCheck - Time.deltaTime
        if (isCheck <= 0) then
            isCheck = nil
            CheckHeigh()
        end
    end
end

function OnDestroy()
    FightGridSelMgr.CloseInput(false); -- 关闭时禁止战斗输入
    ReleaseCSComRefs()
end

function OnOpen()
    id = data[1]
    target = data[2]
    cfg = Cfgs.skill:GetByID(id)
    local cfgDesc = Cfgs.CfgSkillDesc:GetByID(cfg.id)
    -- name
    CSAPI.SetText(txt_name, cfgDesc.name)
    -- np,被动
    if (cfg.main_type == SkillMainType.CardTalent) then
        CSAPI.SetGOActive(imgTypc, true)
        CSAPI.SetText(txt_np, "")
    else
        CSAPI.SetGOActive(imgTypc, false)
        local str, num = RoleTool.GetNPStr(cfg)
        if (num ~= 0) then
            str = StringUtil:SetByColor(str .. "-", "929296")
        end
        CSAPI.SetText(txt_np, num == 0 and "" or string.format("%s%s", str, num))
    end
    -- desc

    local desc1 = cfgDesc.desc or ""
    if (desc1 and desc1 ~= "") then
        desc1 = StringUtil:SkillDescFormat(desc1)
    end
    CSAPI.SetText(txt_desc1, desc1)
    -- overload 
    local desc2 = cfgDesc.desc1 or ""
    if (desc2 and desc2 ~= "") then
        desc2 = StringUtil:SkillDescFormat(desc2)
    end
    CSAPI.SetGOActive(overLoad, desc2 ~= "")
    CSAPI.SetText(txt_desc2, desc2)

    -- 设置目标位置
    SetNodePos()
    -- 
    isCheck = 0.1
    CSAPI.SetGOAlpha(node, 0)
end

function SetNodePos()
    if (target) then
        local pos = node.transform:InverseTransformPoint(target.transform.position)
        local x = pos.x + 140
        x = x > maxX and maxX or x
        CSAPI.SetAnchor(node, x, minY, 0)
    end
end

function CheckHeigh()
    local size = CSAPI.GetRTSize(node)
    if (size[1] > 900) then
        local width = 765 + add
        CSAPI.SetRTSize(node, width, 900)
        CSAPI.SetGOActive(node, false)
        CSAPI.SetGOActive(node, true)
        add = add + 150
        isCheck = 0.1
    else
        CSAPI.SetGOAlpha(node, 1)
    end
end

function OnClickMask()
    view:Close()
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    node = nil;
    txt_name = nil;
    txt_np = nil;
    imgTypc = nil;
    txt_type = nil;
    txt_desc1 = nil;
    overLoad = nil;
    Text = nil;
    txt_desc2 = nil;
    view = nil;
end
----#End#----
