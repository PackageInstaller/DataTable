-- local timer = 0
local isPlay = false
local colors1 = {
    ["1"] = "b3b2b1",
    ["2"] = "b8862e",
    ["3"] = "00a4b3",
    ["4"] = "00b386",
    ["5"] = "00b386",
    ["6"] = "00b386",
}
local colors2 = {
    ["1"] = "ffffff",
    ["2"] = "ffc146",
    ["3"] = "00e9ff",
    ["4"] = "00ffbf",
    ["5"] = "00ffbf",
    ["6"] = "00ffbf",
}

function Awake()
    anim = ComUtil.GetOrAddCom(bg, "ActionFade")
    -- c_slider = ComUtil.GetCom(Fill, "Image")
end

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
end

function OnDestroy()
    eventMgr:ClearListener()
    ReleaseCSComRefs()
end

-- 其它界面打开
function OnViewOpened(viewKey)
    local cfg = Cfgs.view:GetByKey(viewKey)
    if (viewKey == "FightOverResult") then
        Play() -- 弹出结算时，重新开始执行播放
    end
end

function Refresh(_datas)
    datas = datas or {}
    for i, v in ipairs(_datas) do
        table.insert(datas, v)
    end
    if (not isPlay) then
        Play()
    end
end

-- 能否播放
function CanPlay()
    -- 在战斗界面时停止播放
    local scene = SceneMgr:GetCurrScene()
    if (scene and scene.key ~= "MajorCity" and not CSAPI.IsViewOpen("FightOverResult")) then
        return false
    end
    return true
end

-- 获取一条数据
function GetCurData()
    local curData = nil
    if (#datas > 0) then
        curData = datas[1]
        table.remove(datas, 1)
    end
    return curData
end

-- 顺序播放
function Play()
    if (isPlay or not CanPlay()) then
        return
    end
    local curData = GetCurData()
    CSAPI.SetGOActive(gameObject, curData ~= nil)
    if (curData) then
        isPlay = true
        CSAPI.SetGOActive(gameObject, true)
        -- name
        CSAPI.SetText(txtDesc, curData:GetDesc())
        -- count
        -- local cur, max = curData:GetCount()
        -- CSAPI.SetText(txtCount, cur .. "/" .. max)
        -- slider
        -- c_slider.fillAmount = cur / max
        -- anim 
        UIUtil:SetPObjMove(bg, 0, 0, 0, -125, 0, 0, nil, 500)
        FuncUtil:Call(function()
            UIUtil:SetPObjMove(bg, 0, 0, -125, 0, 0, 0, PlayCB, 500)
        end, nil, 1500)
        -- img
        local index = eTaskTypeTipsImg[curData:GetType()] or "4"
        CSAPI.LoadImg(icon, "UIs/Tips/img_01_0" .. index .. ".png", true, nil, true)
        CSAPI.SetImgColorByCode(icon2, colors1[index])
        CSAPI.SetImgColorByCode(imgBg, colors2[index])
        CSAPI.SetImgColorByCode(line1, colors2[index])
    else
        isPlay = false
        CSAPI.SetAnchor(bg, 0, 0, 0)
        Tips.ShowMisionTips() -- 全部播完，去获取新数据  由 self.tipsTimer.Timer触发
    end
end

function PlayCB()
    isPlay = false
    Play()
end

-- 退出游戏,清除数据并还原
function ClearAll()
    isPlay = false
    datas = {}
    anim:SetRun(false)
    CSAPI.SetAnchor(bg, 0, 0, 0)
    CSAPI.SetGOActive(gameObject, false)
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    bg = nil;
    txtDesc = nil;
    txtCount = nil;
    Fill = nil;
    view = nil;
end
----#End#----
