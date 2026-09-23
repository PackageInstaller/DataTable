-- 支线选项
local clickCallBack = nil
local index = 0
local data = nil
local cfg = nil
local cfgEnum = nil
local isOpen = false
local rewards = nil
local isSelect = false
local selIndex = 0

local lastW = 472
local sizeAction = nil
local fadeT = nil

local moveAction = nil
local fade = nil

function Awake()
    moveAction = ComUtil.GetCom(enter, "ActionMoveByCurve")
    fade= ComUtil.GetCom(enter, "ActionFade")
    sizeAction = ComUtil.GetCom(action, "ActionWH")
    fadeT = ComUtil.GetCom(action, "ActionFadeT")

    CSAPI.SetGOActive(select, false)
    -- SetSelect(false)
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
    if data then
        InitPanel()
    end
    RefreshPanel()
end

-- 初始化
function InitPanel()
    cfg = data:GetCfg()
    -- 背景
    local bgName1 = cfg.sBg .. "_1"
    ResUtil:LoadBigImg(bg1, "UIs/SectionImg/sBg1/" .. bgName1, false)
    local bgName2 = cfg.sBg .. "_2"
    ResUtil:LoadBigImg(bg2, "UIs/SectionImg/sBg1/" .. bgName2, false)
    local bgName3 = cfg.sBg .. "_3"
    ResUtil:LoadBigImg(bg3, "UIs/SectionImg/sBg1/" .. bgName3, false)
    -- title
    CSAPI.SetText(txtTitle, cfg.name)
    -- desc
    CSAPI.SetText(txtDesc, cfg.desc)
end

function RefreshPanel()
    if data then
        isOpen = data:GetOpen()
        SetLock()
        SetText()
        RefreshTag()
    end
end

-- 锁
function SetLock()
    CSAPI.SetGOActive(lockMask,not isOpen)
    if not isOpen then
        CSAPI.SetGOActive(lockImg,false)
        local color = {146,146,150,255}
        -- local openStr = LanguageMgr:GetByID(15095)
        local state, openStr= data:GetOpenState()
        if state == -1.5 then
            color = {255,255,255,255}
            openStr = LanguageMgr:GetByID(15093)
        elseif state == 0 then
            local ids = data:GetCfg().conditions
            local str = ""
            for _, id in ipairs(ids) do
                local cfgRule = Cfgs.CfgOpenRules:GetByID(id)
                if cfgRule then
                    local cfgDungeon = Cfgs.MainLine:GetByID(cfgRule.val)
                    if cfgDungeon then
                        if str ~= "" then
                            str = str .. "," .. cfgDungeon.chapterID
                        else
                            str = cfgDungeon.chapterID .. ""
                        end
                    end
                end
            end
            CSAPI.SetGOActive(lockImg, true)
            color = {202,202,202,255}
            openStr = LanguageMgr:GetByID(15094, str)
        end
        CSAPI.SetTextColor(txtLock,color[1],color[2],color[3],color[4])
        CSAPI.SetText(txtLock, openStr)
    else
        CSAPI.SetGOActive(lockImg,false)
        CSAPI.SetText(txtLock, "")
    end
end

-- 字体
function SetText()
    local color = isSelect and {255,255,255,255}  or {195, 195, 200, 255}
    CSAPI.SetTextColor(txtTitle, color[1], color[2], color[3], color[4])
end

-- 选中
function SetSelect(_isSelect,_isCloseAnim)
    isSelect = _isSelect
    local width = isSelect and 630 or 472
    if lastW ~= width then
        CSAPI.SetGOActive(select, isSelect)
        if _isCloseAnim then
            CSAPI.SetRTSize(node,width,145)
        else
            local offset = width - lastW
            sizeAction.scaleW = offset
            sizeAction:Play()
            if isSelect then
                fadeT:Play()
            end
        end       
        lastW = width
    end 
end

--进入动效
function PlayAnim()
    moveAction.delay = 50 * (index - 1)
    moveAction:Play()
    fade:Play(0,1,200,50 * (index - 1))
end

function GetData()
    return data
end
 
function GetIndex()
    return index
end

function OnClick()
    if not isOpen then
        local _isOpen, openStr = MenuMgr:CheckModelOpen(OpenViewType.section, cfg.id)
        if _isOpen or not cfg.conditions then
            LanguageMgr:ShowTips(24003)
            return
        end
        local cfgRole = Cfgs.CfgOpenRules:GetByID(cfg.conditions[1])
        local preCfg = cfgRole and Cfgs.MainLine:GetByID(cfgRole.val) or nil
        local str = ""
        if preCfg then
            str = preCfg.chapterID .. " " .. preCfg.name
        end
        LanguageMgr:ShowTips(1010,str)
        return
    end
    if clickCallBack then
        clickCallBack(this)
    end
end

function RefreshTag()
    local dungeonCfgs = data:GetDungeonCfgs()
    local isNew = false
    if dungeonCfgs then
        for i, dungeonCfg in ipairs(dungeonCfgs) do
            if DungeonMgr:GetIsNew(dungeonCfg.id) then
                isNew = true
                break
            end
        end
    end
    isNew = isOpen and isNew or false
    SetNew(isNew)

    local isLimitDouble = DungeonUtil.IsLimitDropAdd(data:GetID())
    SetLimitDouble(isLimitDouble)
    if isLimitDouble and isNew then
        CSAPI.SetAnchor(newParent,-34,65)
    else
        CSAPI.SetAnchor(newParent,-34,39)
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
