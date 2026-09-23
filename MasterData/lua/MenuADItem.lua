function Awake()
    c_MenuADItem = ComUtil.GetCom(gameObject, "MenuADItem") -- TODO 优化下载存储
end

function Refresh(_data)
    data = _data
    SetImg()
    SetFrame()
end

function SetFrame()
    local curID = MenuThemeMgr:GetTempMenuThemeID()
    local cfg = Cfgs.CfgUiTheme:GetByID(curID)
    local path = nil
    if (cfg.LD2) then
        local num = curID == 1 and "" or curID
        path = "UIs/Menu" .. num .. "/img_10_01.png"
        CSAPI.LoadImg(frame, path, true, nil, true)
    end
    CSAPI.SetGOActive(frame, path ~= nil)
end

function SetImg()
    local imgName = data:GetImageName()
    if (imgName and imgName ~= "") then
        -- LogError(data:GetImgUrl().."/"..imgName)
        c_MenuADItem:SetImage(clickNode, "menuaditem", imgName, data:GetImgUrl(), function()
            CSAPI.SetScale(clickNode, 1, 1, 1)
        end)
    end
end

function OnClick()
    local jumpId = data:GetSkipID()
    if (jumpId) then
        JumpMgr:Jump(tonumber(jumpId))
        -- 统计点击次数
        RecordMgr:SaveCount(RecordMode.Count, RecordViews.AD, jumpId)
        if CSAPI.IsADV() or CSAPI.IsDomestic() then
            BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_CLICK_ANNOUNCEMENT_BUTTON)
        end
    end
end

function OnDestroy()
    ReleaseCSComRefs()
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    clickNode = nil;
    view = nil;
end
----#End#----
