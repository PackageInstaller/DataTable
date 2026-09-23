-- 关卡组
local clickCallBack = nil
local curName = nil
local alpha = 0
local data = nil
local btnPos = {}
local isSelect = false
local index = 0
local isNew =false
local isOpen = false
local lockStr = ""
local ids = nil
local cfgDungeon = nil
local dungeonData = nil


function SetClickCB(callBack)
    clickCallBack = callBack
end

function SetIndex(idx)
    index = idx
end

function Awake()
    bgFade = ComUtil.GetCom(bg, "ActionFade")
    nodeFadeT = ComUtil.GetCom(node, "ActionFadeT")
    canvasGroup = ComUtil.GetCom(gameObject, "CanvasGroup")

    SetNew(false)
end

function Refresh(_data)
    data = _data
    if data then
        isOpen,lockStr = data:IsOpen()
        ids = data:GetDungeonGroups()
        -- icon
        SetColor(isOpen, isSelect, data:IsHard())

        -- index
        CSAPI.SetText(txtNum, index .. "")

        -- name
        CSAPI.SetText(txtName, data:GetName())

        -- title
        CSAPI.SetText(txtTitle2, index .. "")

        -- pos
        SetPos(data:GetPos())

        -- btnPos
        SetBtnPos(data:GetRelativePos())

        -- button
        SetBtnActive(isOpen)

        --plot
        CSAPI.SetGOActive(plot,IsStory())
        CSAPI.SetGOActive(nol,not IsStory())
        
        -- action
        -- SetTxtState()
    end
end

function SetPos(pos)
    CSAPI.SetAnchor(gameObject, pos.x, pos.y)
end

function SetBtnPos(pos)
    pos = pos and pos or {100, 0}
    local x = 180 * (pos[1] / 100)
    local y = 80 * (pos[2] / 100)
    CSAPI.SetAnchor(root, x, y)
    btnPos = {x, y}
end

function SetNew(_isNew)
    isNew = _isNew
    CSAPI.SetGOActive(newObj, _isNew)
end

-- 能否点击
function SetBtnActive(isClick)
    CSAPI.SetGOActive(btnClick, isClick)
end

function Show(isShow)
    canvasGroup.alpha = isShow and 1 or 0
end

function SetSel(isSel)
    isSelect = isSel
    SetColor(isOpen, isSel, data:IsHard())
    PlayAnim(isSel)
    if isNew then
        CSAPI.SetGOActive(newObj, not isSel)
    end
end

-- 设置颜色
function SetColor(isOpen,isSelOrNew,isHard)
    type = type or 0
    if not txtCG then
        txtCG = ComUtil.GetCom(txtObj, "CanvasGroup")
    end
    txtCG.alpha = isOpen and 1 or 0.4

    local iconColor = {255, 255, 255, 255}
    local nameColor = {255, 255, 255, 255}
    local titleColor1 = {255, 255, 255, 255}
    local titleColor2 = {255, 255, 255, 255}
    local numColor = {255, 255, 255, 255}

    if isSelOrNew then
        iconColor = {255, 193, 70, 255}
        nameColor = {255, 193, 70, 255}
        titleColor1 = {255, 193, 70, 255}
        titleColor2 = {255, 193, 70, 255}
        numColor = {15, 15, 25, 255}
    elseif isHard then
        iconColor = {255, 0, 64, 255}
    else
        numColor = {15, 15, 25, 255}
    end
    CSAPI.SetImgColor(icon, iconColor[1], iconColor[2], iconColor[3], iconColor[4])
    CSAPI.SetTextColor(txtName, nameColor[1], nameColor[2], nameColor[3], nameColor[4])
    CSAPI.SetTextColor(txtTitle1, titleColor1[1], titleColor1[2], titleColor1[3], titleColor1[4])
    CSAPI.SetTextColor(txtTitle2, titleColor2[1], titleColor2[2], titleColor2[3], titleColor2[4])
    CSAPI.SetTextColor(txtNum, numColor[1], numColor[2], numColor[3], numColor[4])
end

function PlayAnim(isSelect)
    CSAPI.SetGOActive(play.gameObject, false)
    CSAPI.SetGOActive(scaleOut.gameObject, false)
    CSAPI.SetGOActive(scaleIn.gameObject, false)

    CSAPI.SetGOActive(play.gameObject, true)
    if isSelect then
        CSAPI.SetGOActive(scaleOut.gameObject, true)
    else
        CSAPI.SetGOActive(scaleIn.gameObject, true)
    end
end

function GetIndex()
    return index
end

function GetData()
    return data
end

function GetID()
    return data:GetID()
end

function GetDungeonID()
    local id = 0
    if GetGroups() then
        id = GetGroups()[1] or 0
    end
    return id
end

function GetGroups()
    return ids
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

function IsHard()
    return data:IsHard()
end

function IsPass()
    return data:IsPass()
end

function IsStory()
    return GetCfg() and GetCfg().sub_type == DungeonFlagType.Story;
end

function IsDanger()
    return ids and #ids > 1
end

function IsOpen()
    return isOpen
end

function GetType()
    local type = DungeonInfoType.Normal
    if IsStory() then
        type = DungeonInfoType.Plot
    elseif IsDanger() then
        type = DungeonInfoType.Danger
    end
    return type
end

function GetCfg()
    local cfg = nil
    if data and data:GetDungeonGroups() then
        local cfgID = data:GetDungeonGroups()[1]
        cfg = Cfgs.MainLine:GetByID(cfgID)
    end
    return cfg
end

function OnClick()
    if not IsOpen() then
        Tips.ShowTips(lockStr)
        return 
    end
    if clickCallBack then
        clickCallBack(this)
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
    centerObj = nil;
    dot = nil;
    root = nil;
    bg = nil;
    node = nil;
    img = nil;
    icon = nil;
    txtObj = nil;
    txtNum = nil;
    txtTitle = nil;
    txtName = nil;
    newObj = nil;
    txtNew = nil;
    btnClick = nil;
    dotClose = nil;
    dotOpen = nil;
    view = nil;
end
----#End#----
