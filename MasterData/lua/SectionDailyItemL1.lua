-- 支线选项
local clickCallBack = nil
local index = 0
local data = nil
local cfg = nil
local cfgEnum = nil
local isOpen = false
local rewards = nil
local curState = 1 -- 1是缩小状态 2是正常状态
local isSelect = false
local selIndex = 0

local moveAction = nil
local sizeAction1 = nil
local sizeAction2 = nil
local fadeT = nil
local fade = nil

function Awake()
    moveAction = ComUtil.GetCom(action, "ActionMoveByCurve")
    sizeAction1 = ComUtil.GetCom(action, "ActionWH")
    sizeAction2 = ComUtil.GetCom(bgAction, "ActionWH")
    fadeT = ComUtil.GetCom(action, "ActionFadeT")
    fade= ComUtil.GetCom(action, "ActionFade")

    CSAPI.SetGOActive(selectObj, false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(callBack)
    clickCallBack = callBack;
end

function PlayMove(delay)
    moveAction.delay = delay
    moveAction:Play()
end

function Refresh(_data)   
    data = _data
    cfgEnum = Cfgs.CfgDailyEnum:GetByID(data)
    if cfgEnum then
        InitPanel()
    end
    RefreshTag()
end

function InitPanel()
    SetBG()

    -- title
    CSAPI.SetText(txtTitle1, cfgEnum.sName)
    CSAPI.SetText(txtTitle2, cfgEnum.eName)

    -- desc
    CSAPI.SetText(txtDesc, cfgEnum.desc)
end

function SetBG()
    ResUtil:LoadBigImg(bg2, "UIs/SectionImg/sBg3/" .. cfgEnum.icon .. "_1", false)
    ResUtil:LoadBigImg(bg3, "UIs/SectionImg/sBg3/" .. cfgEnum.icon .. "_2", false)
end

function SetColor(b)
    local color1 = b and {255,193,70,77} or {255,255,255,77}
    CSAPI.SetTextColor(txt_desc1,color1[1],color1[2],color1[3],color1[4])
    CSAPI.SetTextColor(txt_desc2,color1[1],color1[2],color1[3],color1[4])

    local color2 = b and {255,193,70,255} or {208,208,208,255}   
    CSAPI.SetTextColor(txtDesc,color2[1],color2[2],color2[3],color2[4])

    local color3 = b and {255,193,70,255} or {255,255,255,255}   
    CSAPI.SetTextColor(txtTitle1,color3[1],color3[2],color3[3],color3[4])

    local color4 = b and {255,193,70,102} or {189,189,189,102}   
    CSAPI.SetTextColor(txtTitle2,color4[1],color4[2],color4[3],color4[4])

    local i = b and 1 or 2
    -- CSAPI.LoadImg(img2, "UIs/Section/img_new_12_0" .. i.. ".png" ,true, nil, true)
end

-- 选中
function SetSelect(_isSelect,_isCloseAnim)
    isSelect = _isSelect
    SetColor(_isSelect)
    CSAPI.SetGOActive(selectObj, _isSelect)
    if _isCloseAnim then
        SelectState(_isSelect)
    else
        SelectAnimState(_isSelect)
    end
end

--无动效
function SelectState(b)
    local width1 = isSelect and 631 or 529
    CSAPI.SetRTSize(node,width1,202)
    local width2 = isSelect and 605 or 516
    CSAPI.SetRTSize(bg2,width2,191)
end

function SelectAnimState(b)
    sizeAction1.scaleW = b and 101 or -101
    sizeAction2.scaleW = b and 89 or -89
    if b then
        fadeT:Play()
        fade:Play(0,1,200,100)
    end
    sizeAction1:Play()
    sizeAction2:Play()
end

function GetData()
    return data
end

function GetIndex()
    return index
end

function OnClick()
    if clickCallBack then
        clickCallBack(this)
    end
end

function RefreshTag()
    local dailyCfgs = Cfgs.Section:GetGroup(SectionType.Daily)
    local isNew = false
    local isLimitDouble= false
    if dailyCfgs then
        for _, cfg in pairs(dailyCfgs) do
            local sectionData = DungeonMgr:GetSectionData(cfg.id)
            if sectionData:GetDailyType() == data then
                if not isLimitDouble then
                    isLimitDouble = DungeonUtil.IsLimitDropAdd(sectionData:GetID())
                end
                if not isNew and sectionData and sectionData:GetOpen() then
                    local dungeonCfgs = sectionData:GetDungeonCfgs()
                    if dungeonCfgs then
                        for i, dungeonCfg in ipairs(dungeonCfgs) do
                            if DungeonMgr:GetIsNew(dungeonCfg.id) then
                                isNew = true
                            end
                        end
                    end
                end
            end
        end
    end  
    SetNew(isNew)
    SetLimitDouble(isLimitDouble)
    if isLimitDouble and isNew then
        CSAPI.SetAnchor(newParent,-34,65)
    else
        CSAPI.SetAnchor(newParent,-49,102)
    end
end

function SetNew(b)
    UIUtil:SetNewPoint(newParent, b)
end

function SetLimitDouble(b)
    UIUtil:SetDoublePoint(doubleParent, b)
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
    bg = nil;
    txtNum = nil;
    txtTitle = nil;
    txtDesc = nil;
    txtFall = nil;
    openObj = nil;
    txtOpen = nil;
    txtChange = nil;
    itemParent = nil;
    btnQuestion = nil;
    lockObj = nil;
    txtCondition = nil;
    view = nil;
end
----#End#----
