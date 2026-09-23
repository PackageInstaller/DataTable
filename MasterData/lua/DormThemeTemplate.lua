-- 主题curIndex_1
curIndex1, curIndex2 = 1, 1 -- 父index,子index
local maxCount = 0 -- 一行可放置数量
local perLimit = 3 -- 一次最多请求数量，因为服务器消息长度限制  用于每页多次请求
local itemX = 382
local space = 17.5

local curIndex_1 = 1 -- 1：发现主题 2：我的主题 3：我的收藏
local curIndex_2 = 2 -- 1：最新 2：热门  
local curIndex_3 = 1 -- 我的主题下： 1：当前主题  2：我的模板  3：我的分享

local newDatas = {} -- 最新
local hotDatas = {}

local findData = nil -- 查找到的数据
local curSelectIndex = 1 -- 当前选择第几个数据（当前展示列表下标）
local curPage = 1 -- 第几页

local shareCount = 0

function Awake()
    input = ComUtil.GetCom(InputField, "InputField")
    dormThemeIcon = ComUtil.GetCom(icon, "DormThemeIcon")
    -- dormThemeIcon2 = ComUtil.GetCom(icon2, "DormThemeIcon")
    layout = ComUtil.GetCom(downSV, "UIInfinite")
    layout:Init("UIs/Dorm/DormThemeTemplateItem", LayoutCallBack, true)
end

function OnInit()
    UIUtil:AddTop2("DormThemeTemplate", gameObject, function()
        view:Close()
    end)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Dorm_GetWorldTheme, GetWroldThemeCB)
    eventMgr:AddListener(EventType.Dorm_Theme_Buy, DormThemeBuy)
    eventMgr:AddListener(EventType.Dorm_Share, SetIndex2)

end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClick)
        if (StringUtil:IsEmpty(inputStr)) then
            local isRoom = curIndex_1 == 2 and curIndex_3 == 1 and true or false
            lua.Refresh(_data, {curSelectIndex, isRoom})
        else
            lua.Refresh(_data, {1, false})
        end
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    local width = CSAPI.GetMainCanvasSize()[0]
    maxCount = math.floor((width + space) / (itemX + space)) -- 一行可放置数量
    InitIndex()
    InitLeftPanel()

    RefreshPanel()
end

function InitIndex()
    curIndex1 = openSetting == nil and 1 or openSetting
end
function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftPoint.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {{32045, "Dorm/btn_18_01"}, {32046, "Dorm/btn_19_01"}, {32047, "Dorm/btn_19_01"}} -- 多语言id，需要配置英文
    local leftChildDatas = {} -- 子项多语言，需要配置英文
    leftPanel.Init(this, leftDatas, leftChildDatas)
end

function RefreshPanel()
    curIndex_1 = curIndex1

    inputStr = ""
    -- items = items or {}
    curSelectIndex = 1
    findData = nil
    curPage = 1

    SetNum(nil)
    CSAPI.SetGOActive(l1Btns, curIndex_1 == 1)
    CSAPI.SetGOActive(l2Btns, curIndex_1 == 2)
    -- CSAPI.SetGOActive(rPanel1, curIndex_1 == 1 or(curIndex_1 == 2 and curIndex_3 == 3) or curIndex_1 == 3)
    -- CSAPI.SetGOActive(rPanel2, curIndex_1 == 2 and curIndex_3 ~= 3)
    CSAPI.SetGOActive(rPanel1, false)
    CSAPI.SetGOActive(rPanel2, false)

    if (curIndex_1 == 1) then
        -- 发现主题
        input.text = inputStr
        SetIndex1()
    elseif (curIndex_1 == 2) then
        -- 我的主题
        -- if(shareCount == nil) then
        -- 	ShareThemeCB()
        -- end
        SetIndex2()
    else
        -- 我的收藏
        SetIndex3()
    end

    -- 侧边动画
    leftPanel.Anim()
    -- 红点
    -- SetRed()
end

function SetNum(id, num1, num2)
    CSAPI.SetGOActive(objNum, id ~= nil)
    if (id) then
        LanguageMgr:SetText(txtNum1, id)
        CSAPI.SetText(txtNum2, string.format("%s/%s", num1, num2))
    end
end

-- 发现主题
function SetIndex1(isNeedGet)
    if (curIndex_1 ~= 1) then
        return
    end
    -- 搜索数据
    if (not StringUtil:IsEmpty(inputStr)) then
        -- local _datas = findData and {findData} or {}
        -- ItemUtil.AddItems("Dorm/DormThemeTemplateItem", items, _datas, grids, nil, 1, {1, false})
        curDatas = findData and {findData} or {}
        curSelectIndex = 1
        layout:IEShowList(#curDatas)
        return
    end

    -- isNeedGet = isNeedGet == nil and true or isNeedGet
    -- 请求数据
    local _baseDatas = curIndex_2 == 1 and newDatas or hotDatas
    RequestDatas = RequestDatas or {}
    RequestDatas[curIndex_2] = RequestDatas[curIndex_2] or {}
    if (not RequestDatas[curIndex_2][curPage]) then
        -- 当前页未请求过（如果请求过则不再处理）
        RequestDatas[curIndex_2][curPage] = 1
        isGetWorldTheme = true -- 请求中
        DormProto:GetWroldTheme(#_baseDatas + 1, maxCount, curIndex_2)
        return
    else
        -- 如果当前页没有内容，则返回上一页
        if (curPage > 1 and curPage > math.ceil(#_baseDatas / maxCount)) then
            curPage = curPage - 1
        end
    end
    -- --发现的
    -- local _baseDatas = curIndex_2 == 1 and newDatas or hotDatas
    -- local endNum = curPage * maxCount
    -- if(isNeedGet and #_baseDatas < endNum) then
    -- 	local startNum =(curPage - 1) * maxCount + 1
    -- 	--请求更多
    -- 	if(startNum == 1 or math.fmod(_baseDatas, maxCount) == 0) then
    -- 		isGetWorldTheme = true --请求中
    -- 		DormProto:GetWroldTheme(startNum, maxCount, curIndex_2)  --todo
    -- 		return
    -- 	else
    -- 		--不是初始请求并且数据长度不是一页的整数倍，那么就是后面没数据了
    -- 	end
    -- end
    SetItems(_baseDatas)

    SetHotNewBtns()

    SetIndex1Right()
end

function SetHotNewBtns()
    CSAPI.SetTextColorByCode(txtHot, curIndex_2 == 2 and "ffc146" or "FFFFFF")
    CSAPI.SetTextColorByCode(txtNew, curIndex_2 == 1 and "ffc146" or "FFFFFF")
end

-- function Requset1()
--     isGetWorldTheme = true
--     perMaxLimit = #_baseDatas + maxCount
--     local _baseDatas = curIndex_2 == 1 and newDatas or hotDatas
--     local _perLimit = (perMaxLimit-#_baseDatas)>perLimit and (perMaxLimit-#_baseDatas) or perLimit
--     DormProto:GetWroldTheme(#_baseDatas + 1, perLimit, curIndex_2)
-- end
-- -- 请求回调
-- function GetWroldThemeCB(proto)
--     local _baseDatas = proto.byType == 1 and newDatas or hotDatas
--     local len = #_baseDatas
--     for i, v in ipairs(proto.themes) do
--         table.insert(_baseDatas, v)
--     end
--     if(not proto.themes or #proto.themes<=0 or #_baseDatas==perMaxLimit) then 
--         isGetWorldTheme = false
--         SetIndex1(false)
--     else 
--         --再次请求
--         local _perLimit = (perMaxLimit-#_baseDatas)>perLimit and (perMaxLimit-#_baseDatas) or perLimit
--         DormProto:GetWroldTheme(#_baseDatas + 1, _perLimit, curIndex_2)
--     end 
-- end

-- 请求回调
function GetWroldThemeCB(proto)
    local _baseDatas = proto.byType == 1 and newDatas or hotDatas
    local len = #_baseDatas
    for i, v in ipairs(proto.themes) do
        table.insert(_baseDatas, v)
    end
    if (proto.isFinish) then
        isGetWorldTheme = false
        SetIndex1(false)
    end
end

-- -- 请求回调
-- function GetWroldThemeCB(proto)
--     isGetWorldTheme = false
--     local _baseDatas = proto.byType == 1 and newDatas or hotDatas
--     local len = #_baseDatas
--     for i, v in ipairs(proto.themes) do
--         table.insert(_baseDatas, v)
--     end
--     SetIndex1(false)
-- end

-- 主题购买返回
function DormThemeBuy(proto)
    -- todo
end

function SetImg()
    local fileName = nil
    if (curIndex_1 == 2 and curIndex_3 == 1) then
        local roomData = curDatas[curSelectIndex]
        fileName = roomData:GetImg()
    else
        theme = curDatas[curSelectIndex]
        fileName = theme.img
    end

    SetIcon(fileName)
end

function SetIcon(fileName)
    if (StringUtil:IsEmpty(fileName)) then
        ResUtil:LoadBigImg(icon, "UIs/Dorm/bg1/bg", true)
        CSAPI.SetScale(icon, 1, 1, 1)
    else
        dormThemeIcon:SetByLocal(fileName, function(b)
            if (not b) then
                DormIconUtil.DownAndLoad(dormThemeIcon, fileName)
            end
        end)

        CSAPI.SetScale(icon, 1.4, 1.4, 1)
    end
end

function SetIndex1Right()
    theme = curDatas[curSelectIndex]

    CSAPI.SetGOActive(rPanel1, theme ~= nil)
    CSAPI.SetGOActive(rPanel2, false)
    if (not theme) then
        return
    end
    -- role
    SetRole(theme.icon)
    -- lv name
    CSAPI.SetText(txtName11, theme.cName)
    -- id
    CSAPI.SetText(txtThemeID, theme.id .. "")
    -- time
    CSAPI.SetText(txtTime2, os.date("%Y-%m-%d", theme.cTime))
    -- comfort
    CSAPI.SetText(txtComfort1, theme.comfort .. "")
    -- num1,btn3
    local code1 = theme.isAgree and "FF7781" or "ffffff"
    local str1 = theme.agree > 999 and "999+" or theme.agree .. ""
    StringUtil:SetColorByName(txtR3, str1, code1)
    CSAPI.SetImgColorByCode(objR3, code1, true)
    -- num2,btn4
    local code2 = theme.isStore and "FF7781" or "ffffff"
    local str2 = theme.store > 999 and "999+" or theme.store .. ""
    StringUtil:SetColorByName(txtR4, str2, code2)
    CSAPI.SetImgColorByCode(objR4, code2, true)

    SetR2()

    SetImg()
end

function SetR2()
    local cShare = (curIndex_1 == 2 and curIndex_3 == 3) and true or false
    CSAPI.SetGOActive(btnR2, not cShare)
    CSAPI.SetGOActive(btnCShare, cShare)
end

function SetRole(_modelID)
    local cfg = Cfgs.character:GetByID(_modelID)
    if (not cRoleItem) then
        ResUtil:CreateUIGOAsync("CRoleItem/MatrixRole", rolePoint1, function(go)
            cRoleItem = ComUtil.GetLuaTable(go)
            cRoleItem.SetIcon(cfg.icon)
        end)
    else
        cRoleItem.SetIcon(cfg.icon)
    end
end

-- 明细
function OnClickR1()
    OpenDormTheme(theme)
end

-- 打开主题页面
function OpenDormTheme(_data, isRoom)
    -- if(dormTheme) then
    -- 	CSAPI.SetGOActive(dormTheme.gameObject, true)
    -- else
    -- 	local go = ResUtil:CreateUIGO("Dorm/DormTheme", themePanel.transform)
    -- 	--dormTheme.SetAllBuyCB(AllBuyCB)
    -- 	dormTheme = ComUtil.GetLuaTable(go)
    -- end
    -- if(isRoom) then
    -- 	--dormTheme.RfreshRoomData(_data)
    -- 	dormTheme.Refresh(_data, DormThemeOpenType.Room)
    -- else
    -- 	--dormTheme.RfreshTheme(_data)
    -- 	dormTheme.Refresh(_data, DormThemeOpenType.Theme, AllBuyCB)
    -- end
    local _d = isRoom and {_data, DormThemeOpenType.Room} or {_data, DormThemeOpenType.Theme, AllBuyCB}
    CSAPI.OpenView("DormTheme", _d)
end

-- 一键购买回调（购买后提示布局）
function AllBuyCB()
    -- 购买后可能缺家具，暂不提示，看后期需求
    -- if(curIndex_1 == 1 and theme) then
    -- 	UIUtil:OpenDialog(LanguageMgr:GetTips(21007), function()
    -- 		local b = DormMgr:CheckEnoughByThemeID(curThemeType, theme.id)
    -- 		if(not b) then
    -- 			LanguageMgr:ShowTips(21006)
    -- 		else
    -- 			EventMgr.Dispatch(EventType.Dorm_Theme_Change, {0, theme})
    -- 			view:Close()
    -- 		end
    -- 	end)
    -- end
end

-- 使用主题
function OnClickR2()
    -- 家具是否足够（未去除已使用）
    local isEnough = DormMgr:CheckEnoughForOther(theme)
    local is
    local str = isEnough and LanguageMgr:GetTips(21008) or LanguageMgr:GetTips(21009) -- "是否使用当前主题进行布置？" or "未拥有该主题所需的全部家具，继续布置或前往购买"
    local okFunc = isEnough and function()
        -- local b = DormMgr:CheckEnoughByThemeID(curThemeType, theme.id)
        -- if(not b) then
        -- 	LanguageMgr:ShowTips(21006)
        -- else
        EventMgr.Dispatch(EventType.Dorm_Theme_Change, {curThemeType, theme})
        view:Close()
        -- end
    end or function()
        OnClickR1()
    end
    UIUtil:OpenDialog(str, okFunc)
end

-- 取消分享
function OnClickCShare()
    UIUtil:OpenDialog(LanguageMgr:GetTips(21016), function()
        DormProto:UnShareTheme(theme.id)
    end)
end

-- 点赞
function OnClickR3()
    if (theme.cId == PlayerClient:GetID()) then
        LanguageMgr:ShowTips(21020)
        return
    end
    if (theme.isAgree) then
        UIUtil:OpenDialog(LanguageMgr:GetTips(21014), function()
            DormProto:AgreeTheme(theme.id, theme.isAgree, AgreeCB)
        end)
    else
        DormProto:AgreeTheme(theme.id, theme.isAgree, AgreeCB)
    end
end
function AgreeCB(proto)
    if (not proto.isCancel) then
        LanguageMgr:ShowTips(21018)
    end
    if (theme and theme.id == proto.themeId) then
        theme.agree = theme.isAgree and (theme.agree - 1) or (theme.agree + 1)
        theme.isAgree = not theme.isAgree
    else
        ChangeState(proto)
    end
    SetIndex1Right()
end

-- 收藏
function OnClickR4()
    if (theme.cId == PlayerClient:GetID()) then
        LanguageMgr:ShowTips(21021)
        return
    end
    if (theme.isStore) then
        UIUtil:OpenDialog(LanguageMgr:GetTips(21015), function()
            DormProto:AgreeTheme(theme.id, theme.isStore, AgreeCB)
        end)
    else
        DormProto:AgreeTheme(theme.id, theme.isStore, AgreeCB)
    end
end
function StoreCB(proto)
    if (not proto.isCancel) then
        LanguageMgr:ShowTips(21019)
    end
    if (theme and theme.id == proto.themeId) then
        theme.store = theme.isStore and (theme.store - 1) or (theme.store + 1)
        theme.isStore = not theme.isStore
    else
        ChangeState(proto)
    end
    SetIndex3()
end
-- 如果不是当前主题则在全部主题中找，这是避免点击过快，或者服务器回调过慢
function ChangeState(proto)
    local isFind = false
    for i, v in pairs(hotDatas) do
        if (v.id == proto.themeId) then
            isFind = true
            hotDatas[i] = not proto.isCancel
            break
        end
    end
    if (not isFind) then
        for i, v in pairs(newDatas) do
            if (v.id == proto.themeId) then
                isFind = true
                newDatas[i] = not proto.isCancel
                break
            end
        end
    end
end

-- 热门
function OnClickHot()
    if (curIndex_2 ~= 2) then
        curIndex_2 = 2
        curSelectIndex = 1
        SetIndex1(true)
    end
end

-- 最新
function OnClickNew()
    if (curIndex_2 ~= 1) then
        curIndex_2 = 1
        curSelectIndex = 1
        SetIndex1(true)
    end
end

-- 精准搜索
function OnClickFind()
    if (inputStr == input.text) then
        return
    end
    inputStr = input.text
    if (StringUtil:IsEmpty(inputStr)) then
        findData = nil
        SetIndex1(false)
    else
        DormProto:SearchTheme(tonumber(inputStr), FindCB)
    end
end
function FindCB(proto)
    if (curIndex_1 == 1 and not StringUtil:IsEmpty(inputStr)) then
        findData = proto.info.id ~= nil and proto.info or nil
        SetIndex1(false)
    end
end

--------------------------------------------------------------------------------------
-- 我的主题
function SetIndex2(isNeedGet)
    if (curIndex_1 ~= 2) then
        return
    end

    SetNum(nil)
    -- isNeedGet = isNeedGet == nil and true or isNeedGet
    -- share 
    local shareDatas = DormMgr:GetThemes(ThemeType.Share) -- 必定请求过（登录时请求了）
    shareCount = #shareDatas

    local _baseDatas = {}
    if (curIndex_3 == 1) then
        local _baseDatas0 = DormMgr:GetDormDatas()
        for i, v in pairs(_baseDatas0) do
            table.insert(_baseDatas, v)
        end
        if (#_baseDatas > 0) then
            table.sort(_baseDatas, function(a, b)
                return a:GetID() < b:GetID()
            end)
        end
    elseif (curIndex_3 == 2) then
        _baseDatas = DormMgr:GetThemes(ThemeType.Save)
        if (_baseDatas == nil) then
            -- 未请求过，去请求
            DormProto:GetSelfTheme({ThemeType.Save}, function()
                SetIndex2()
            end)
            return
        end
    else
        _baseDatas = shareDatas
    end
    SetItems(_baseDatas)

    SetNum(32055, shareCount, g_DormShareLimt)

    if (curIndex_3 == 3) then
        SetIndex1Right()
    else
        SetIndex2Right()
    end

    -- btn 
    CSAPI.SetTextColorByCode(txtMy, curIndex_3 == 1 and "ffc146" or "ffffff")
    CSAPI.SetTextColorByCode(txtTemplate, curIndex_3 == 2 and "ffc146" or "ffffff")
    CSAPI.SetTextColorByCode(txtShare, curIndex_3 == 3 and "ffc146" or "ffffff")
end

function SetIndex2Right()
    CSAPI.SetGOActive(rPanel1, false)
    local iconName = nil
    local comfort = 0
    local roomName = ""
    if (curIndex_3 == 1) then
        CSAPI.SetGOActive(rPanel2, true)
        -- 当前房间
        local roomData = curDatas[curSelectIndex]
        iconName = roomData:GetImg()
        comfort = roomData:GetComfort()
        roomName = roomData:GetName()
    else
        theme = curDatas[curSelectIndex]

        CSAPI.SetGOActive(rPanel2, theme ~= nil)
        if (not theme) then
            return
        end

        iconName = theme.img
        comfort = theme.comfort
        roomName = theme.name
    end
    -- role
    -- SetIcon2(iconName)
    -- comfort
    CSAPI.SetText(txtComfort2, comfort .. "")
    -- in
    CSAPI.SetText(txtName22, roomName)

    SetImg()
end

-- function SetIcon2(fileName)
-- 	if(StringUtil:IsEmpty(fileName)) then
-- 		ResUtil:LoadBigImg(icon2, "UIs/Dorm/bg1/bg", true)
-- 	else
-- 		dormThemeIcon2:SetByLocal(fileName, function(b)
-- 			if(not b) then
-- 				DownAndLoad2(fileName)
-- 			end
-- 		end)
-- 	end
-- end
-- function DownAndLoad2(fileName)
-- 	local url = ActivityMgr:GetDormDownAddress() .. fileName
-- 	CSAPI.GetServerInfo(url, function(str)
-- 		if str then
-- 			local count = 0
-- 			local json = Json.decode(str)
-- 			if(json and not StringUtil:IsEmpty(json.data)) then
-- 				dormThemeIcon2:SaveAndLoad(fileName, json.data)
-- 			end
-- 		end
-- 	end)
-- end
-- 明细
function OnClickR5()
    if (curIndex_3 == 1) then
        local roomData = curDatas[curSelectIndex]
        if (not roomData:GetIsInit()) then
            -- 房间数据未获取
            DormProto:GetDorm(nil, roomData:GetID(), function()
                OnClickR5()
            end)
            return
        end
        OpenDormTheme(roomData, true)
    else
        OpenDormTheme(theme)
    end
end

-- 分享
function OnClickR6()
    if (shareCount >= g_DormShareLimt) then
        -- Tips.ShowTips("分享数量已达到上限，需要清理分享后才能继续上传。")
        LanguageMgr:ShowTips(21010)
        return
    end
    if (curIndex_3 == 1) then
        local roomData = curDatas[curSelectIndex]
        DormProto:ShareTheme(roomData:GetID(), roomData:GetName())
    elseif (curIndex_3 == 2) then
        DormProto:ShareTheme(nil, nil, theme.id)
    end
end

-- function ShareThemeCB()
-- 	local _baseDatas = DormMgr:GetThemes(ThemeType.Share)
-- 	shareCount = #_baseDatas
-- 	CSAPI.SetText(txtNum, string.format("分享上限：%s/%s", shareCount, g_DormShareLimt))
-- end
function OnClickMy()
    if (curIndex_3 ~= 1) then
        curIndex_3 = 1
        curSelectIndex = 1
        SetIndex2()
    end
end

function OnClickTemplate()
    if (curIndex_3 ~= 2) then
        curIndex_3 = 2
        curSelectIndex = 1
        SetIndex2()
    end
end

function OnClickShare()
    if (curIndex_3 ~= 3) then
        curIndex_3 = 3
        curSelectIndex = 1
        SetIndex2()
    end
end
--------------------------------------------------------------------------------------
function SetIndex3()
    if (curIndex_1 ~= 3) then
        return
    end
    local _baseDatas = DormMgr:GetThemes(ThemeType.Store)
    if (_baseDatas == nil) then
        -- 未请求过，去请求
        DormProto:GetSelfTheme({ThemeType.Store}, function()
            SetIndex3()
        end)
        return
    end
    SetItems(_baseDatas)

    SetNum(32056, #_baseDatas, g_DormStoreLimt)
    SetIndex1Right()
end

--------------------------------------------------------------------------------------
function SetItems(_baseDatas)
    baseDatas = _baseDatas
    curDatas = {}
    local startNum = (curPage - 1) * maxCount + 1
    local endNum = curPage * maxCount
    local len = #baseDatas < endNum and #baseDatas or endNum
    for i = startNum, len do
        table.insert(curDatas, baseDatas[i])
    end
    -- local isRoom = curIndex_1 == 2 and curIndex_3 == 1 and true or false
    curSelectIndex = curSelectIndex > #curDatas and #curDatas or curSelectIndex
    -- ItemUtil.AddItems("Dorm/DormThemeTemplateItem", items, curDatas, grids, ItemClick, 1, {curSelectIndex, isRoom})
    layout:IEShowList(#curDatas)
end

function ItemClick(newIndex)
    if (curIndex_1 == 1) then
        ItemClick1(newIndex)
    elseif (curIndex_1 == 2) then
        ItemClick2(newIndex)
    else
        ItemClick3(newIndex)
    end
end

-- todo 
function ItemClick1(newIndex)
    -- if(findData ~= nil) then
    -- 	items[1].Select(true)
    -- 	return
    -- end
    SetItemSelect(newIndex)
    SetIndex1Right()
end

function ItemClick2(newIndex)
    SetItemSelect(newIndex)
    if (curIndex_3 == 3) then
        SetIndex1Right()
    else
        SetIndex2Right()
    end
end

function ItemClick3(newIndex)
    SetItemSelect(newIndex)
    SetIndex1Right()
end

function SetItemSelect(newIndex)
    -- if(items[curSelectIndex]) then
    -- 	items[curSelectIndex].Select(false)
    -- end
    -- curSelectIndex = newIndex
    -- if(items[curSelectIndex]) then
    -- 	items[curSelectIndex].Select(true)
    -- end
    curSelectIndex = newIndex
    layout:UpdateList()
end

--------------------------------------------------------------------------------------
-- function OnClickL1()
-- 	if(curIndex_1 ~= 1) then
-- 		curIndex_1 = 1
-- 		RefreshPanel()
-- 	end
-- end
-- function OnClickL2()
-- 	if(curIndex_1 ~= 2) then
-- 		curIndex_1 = 2
-- 		RefreshPanel()
-- 	end
-- end
-- function OnClickL3()
-- 	if(curIndex_1 ~= 3) then
-- 		curIndex_1 = 3
-- 		RefreshPanel()
-- 	end
-- end
-- 上一页
function OnClickL()
    if (curIndex_1 == 1) then
        if (StringUtil:IsEmpty(inputStr)) then
            if (curPage > 1) then
                curPage = curPage - 1
                SetIndex1(false)
            end
        end
    else
        if (curPage > 1) then
            curPage = curPage - 1
            if (curIndex_1 == 2) then
                SetIndex2(false)
            else
                SetIndex3()
            end
        end
    end
end

-- 下一页 todo 
function OnClickR()
    if (curIndex_1 == 1) then
        if (not isGetWorldTheme and StringUtil:IsEmpty(inputStr)) then
            local count = math.ceil(#baseDatas / maxCount)
            if (count > curPage) then
                curPage = curPage + 1
                SetIndex1()
            elseif (math.fmod(#baseDatas, maxCount) == 0) then -- 当前页不满，那就是没下一页了
                curPage = curPage + 1
                SetIndex1(true)
            end
        end
    else
        local num = curPage * maxCount
        if (num < #baseDatas) then
            curPage = curPage + 1
            if (curIndex_1 == 2) then
                SetIndex2(false)
            else
                SetIndex3()
            end
        end
    end
end

