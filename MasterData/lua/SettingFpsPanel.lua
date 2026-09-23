-- 画质数据
local hzDatas = {{
    index = 1,
    iconName = "quality_1",
    name = LanguageMgr:GetByID(14006),
    desc = LanguageMgr:GetTips(7002)
}, {
    index = 2,
    iconName = "quality_2",
    name = LanguageMgr:GetByID(14007),
    desc = LanguageMgr:GetTips(7003)
}, {
    index = 3,
    iconName = "quality_3",
    name = LanguageMgr:GetByID(14008),
    desc = LanguageMgr:GetTips(7004)
}}

local selGOs = {"zsSel", "mbSel", "jsSel"} -- 已开启
local nolGos = {"zsNol", "mbNol", "jsNol"} -- 未开启
local bools = {isZsOn = false,isMbOn = false,isJcOn = false}

local pFade
local bFade
local dFade

function Awake()
    pFade = ComUtil.GetCom(picFade, "ActionFade")
    bFade = ComUtil.GetCom(bjFade, "ActionFade")
    dFade = ComUtil.GetCom(btmFade, "ActionFade")
end

function Start()
    -- 画质
    SetHzItems()
    if CSAPI.IsADV() then
        if 	UnityEngine.Application.platform ==UnityEngine.RuntimePlatform.WindowsEditor or
                UnityEngine.Application.platform ==UnityEngine.RuntimePlatform.WindowsPlayer then
            if (not PCResolution) then
                local go = ResUtil:CreateUIGO("Setting/SettingPCResolution", bjParent.transform)
                PCResolution = ComUtil.GetLuaTable(go)
                picture.transform.localPosition=UnityEngine.Vector3( picture.transform.localPosition.x, picture.transform.localPosition.y-180,0)
                bjParent.transform.localPosition=UnityEngine.Vector3( bjParent.transform.localPosition.x, bjParent.transform.localPosition.y+480,0)
            end
        end
    else
        -- 边距
        if (not jmItem) then
            local go = ResUtil:CreateUIGO("Setting/SettingSliderItem", bjParent.transform)
            jmItem = ComUtil.GetLuaTable(go)
            jmItem.Init(s_screen_scale_key)
        end
    end


    -- 帧数
    local zsValue = SettingMgr:GetValue(s_toggle_zs_key)
	bools.isZsOn = zsValue == 1
    SetState(1, bools.isZsOn)
    -- 描边
    local mbValue = SettingMgr:GetValue(s_toggle_mb_key)
	bools.isMbOn = mbValue == 1
    SetState(2, bools.isMbOn)
    -- 锯齿
    local jcValue = SettingMgr:GetValue(s_toggle_jc_key)
	bools.isJcOn = jcValue == 1
    SetState(3, bools.isJcOn)

    -- fade
    SetFade(true)
end

-- 画质
function SetHzItems()
    if (hzItems == nil) then
        local imgQuality = SettingMgr:GetGameImgLv();
        hzItems = {}
        for i, v in ipairs(hzDatas) do
            ResUtil:CreateUIGOAsync("Setting/SettingPicItem", grid1, function(go)
                local item = ComUtil.GetLuaTable(go)
                item.Refresh(v)
                item.SetClickCB(PicItemClickCB)
                item.SetSelect(imgQuality == i)
                table.insert(hzItems, item)
            end)
        end
    end
end

function PicItemClickCB(_data)
    for i, v in ipairs(hzItems) do
        v.SetSelect(v.data.index == _data.index)
        if _data.index == 3 or _data.index == 1 then
            bools.isZsOn = _data.index ~= 3
            bools.isMbOn = _data.index ~= 3
            bools.isJcOn = _data.index ~= 3
            OnClickZS()
            OnClickMB()
            OnClickJC()
        end
    end
end

-- 帧数
function OnClickZS()
	bools.isZsOn = not bools.isZsOn
    local value = bools.isZsOn and 1 or 2
	SetState(1, bools.isZsOn)
    SettingMgr:SaveValue(s_toggle_zs_key, value)

    --高帧率改成45测试下
--    local rate = bools.isZsOn and SettingMgr:GetHighFPS() or 30
--    CSAPI.SetTargetFrameRate(rate)
    SettingMgr:SetHighFPS(bools.isZsOn);
    -- CSAPI.SetVSyncCount(SettingMgr:GetValue(s_toggle_zs_key))
end

-- 描边
function OnClickMB()
	bools.isMbOn = not bools.isMbOn
    local value = bools.isMbOn and 1 or 2
	SetState(2, bools.isMbOn)
    SettingMgr:SaveValue(s_toggle_mb_key, value)
    CSAPI.SetShaderOutline(value == 1)
end

-- 抗锯齿
function OnClickJC()
	bools.isJcOn = not bools.isJcOn
    local value = bools.isJcOn and 1 or 2
	SetState(3, bools.isJcOn)
    SettingMgr:SaveValue(s_toggle_jc_key, value)
    CSAPI.SetAA(value == 1)
end

-- 设置状态
function SetState(idx, isOn)
    local selGO = this[selGOs[idx]].gameObject
    local nolGo = this[nolGos[idx]].gameObject
    CSAPI.SetGOActive(selGO, isOn)
    CSAPI.SetGOActive(nolGo, not isOn)
end

function SetFade(isOpen, callback)
    if not isOpen then
        pFade.delayValue = 1
        bFade.delayValue = 1
        dFade.delayValue = 1
        pFade:Play(1, 0, 200)
        bFade:Play(1, 0, 200, 67)
        dFade:Play(1, 0, 200, 133, function()
            if callback then
                callback()
            end
            CSAPI.SetGOActive(gameObject, false)
        end)
    else
        pFade.delayValue = 0
        bFade.delayValue = 0
        dFade.delayValue = 0
        CSAPI.SetGOActive(gameObject, true)
        pFade:Play(0, 1, 200, 100)
        bFade:Play(0, 1, 200, 200)
        dFade:Play(0, 1, 200, 300)
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
    grid1 = nil;
    bjParent = nil;
    zs = nil;
    txt_zs = nil;
    togglezs = nil;
    txt_zs1 = nil;
    txt_zs2 = nil;
    bg_zs = nil;
    mb = nil;
    txt_mb = nil;
    togglemb = nil;
    txt_mb1 = nil;
    txt_mb2 = nil;
    bg_mb = nil;
    jc = nil;
    txt_jc = nil;
    togglejc = nil;
    txt_jc1 = nil;
    txt_jc2 = nil;
    bg_jc = nil;
    picFade = nil;
    bjFade = nil;
    btmFade = nil;
    view = nil;
end
----#End#----
