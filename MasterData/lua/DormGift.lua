local curRole
local curDatas = {}
local giftDatas = {}
local totaleExp = 0
local roleItem1
local roleItem2
local mExp = 0
local openType = nil
local isChoose = false

function Clear()
    curDatas = {}
    giftDatas = {}
    totaleExp = 0
end

function Awake()
    mFill0 = ComUtil.GetCom(Fill0, "Image")
    slider = ComUtil.GetCom(Slider, "Slider")
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/Grid/GridGiftItem", LayoutCallBack, true)
    -- bar = Bar.New()
    -- bar:Init(Slider, CfgCardRoleUpgrade, "nExp", SetCLv, SetCExp, 2, SetExp, false)
    CSAPI.SetGOActive(mask, false)
end

-- --设置等级
-- function SetCLv(_lv)
-- 	_lv = _lv or 1
-- 	CSAPI.SetText(txtLv, string.format("%d", _lv))
-- end
-- function SetCExp(curExp, curmaxExp)
-- 	CSAPI.SetText(txtExp, string.format("<color=#ffffff>%s</color><color=#929296>/%s</color>", curExp, curmaxExp))
-- end
function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        local _giftData = giftDatas[_data:GetID()]
        lua.Refresh(_data, _giftData, totaleExp >= mExp)
    end
end

function Init(_dormView)
    dormView = _dormView
end

function OnOpen()
    CSAPI.SetGOActive(mask, true)
    openType = 1
    Refresh(data)
end

function Refresh(_role)
    if (curRole and curRole == _role) then
        return
    end
    curRole = _role
    CSAPI.SetGOActive(bg1, curRole == nil)
    CSAPI.SetGOActive(bg2, curRole ~= nil)
    RefreshPanel()
end

function RefreshPanel()
    if (curRole ~= nil) then
        curDatas = {}
        giftDatas = {}
        totaleExp = 0
        SetBg2()
    end
end

function SetBg2()
    cRoleData = curRole.data

    mExp = cRoleData:GetMExp()
    -- child
    SetRole1()
    SetRole2()
    -- lv
    CSAPI.SetText(txtLv1, cRoleData:GetLv() .. "")
    CSAPI.SetText(txtLv2, cRoleData:GetLv() .. "")
    -- exp
    SetExp()
    -- grids
    SetGrids()
end
function SetRole1(roleItem, childParent)
    if (not roleItem1) then
        ResUtil:CreateUIGOAsync("CRoleItem/MatrixRole", childParent1, function(go)
            roleItem1 = ComUtil.GetLuaTable(go)
            roleItem1.SetIcon(cRoleData:GetBaseIcon())
        end)
    else
        roleItem1.SetIcon(cRoleData:GetBaseIcon())
    end
end
function SetRole2(roleItem, childParent)
    if (not roleItem2) then
        ResUtil:CreateUIGOAsync("CRoleItem/MatrixRole", childParent2, function(go)
            roleItem2 = ComUtil.GetLuaTable(go)
            roleItem2.SetIcon(cRoleData:GetBaseIcon())
        end)
    else
        roleItem2.SetIcon(cRoleData:GetBaseIcon())
    end
end

function SetGrids()
    curDatas = {}
    local cRoleID = cRoleData:GetID()
    local cfgs = Cfgs.CfgGifts:GetAll()

    for i, v in pairs(cfgs) do
        local num = BagMgr:GetCount(v.itemId)
        local data = BagMgr:GetFakeData(v.itemId, num)
        if (isChoose or num > 0) then
            table.insert(curDatas, data)
        end
        if (not giftDatas[v.itemId]) then
            local _giftData = {}
            _giftData.had = num
            _giftData.removeFunc = RemoveFunc
            _giftData.slectFunc = SlectFunc
            _giftData.num = 0 -- 当前选择个数
            local percent = 0 -- 额外加成百分比
            for k, m in ipairs(v.infos) do
                if (m.index == cRoleID) then
                    percent = m.percent
                    break
                end
            end
            _giftData.percent = percent
            _giftData.val = v.val
            _giftData.totalVal = v.val + math.floor(percent / 100 * v.val) -- 基础+额外
            giftDatas[v.itemId] = _giftData
        end
    end
    if (#curDatas > 1) then
        table.sort(curDatas, function(a, b)
            return a:GetID() < b:GetID()
        end)
    end
    layout:IEShowList(#curDatas)
    --
    CSAPI.SetGOActive(empty, #curDatas <= 0)
    CSAPI.SetGOActive(sel, isChoose)
end

-- 选择
function SlectFunc(item)
    if (item.giftData.num >= item.giftData.had) then
        return
    end
    if (totaleExp >= mExp) then
        LanguageMgr:ShowTips(21000)
        return
    end
    item.giftData.num = item.giftData.num + 1
    layout:UpdateOne(item.index)
    totaleExp = totaleExp + item.giftData.totalVal
    SetExp()
    SetNextLv()

    CSAPI.SetText(txtLv2, cRoleData:GetNextLvByExp(totaleExp) .. "")
end

-- 移除
function RemoveFunc(item)
    if (item.giftData.num <= 0) then
        return
    end
    item.giftData.num = item.giftData.num - 1
    layout:UpdateOne(item.index)
    totaleExp = totaleExp - item.giftData.totalVal
    SetExp()
    SetNextLv()

    CSAPI.SetText(txtLv2, cRoleData:GetNextLvByExp(totaleExp) .. "")
end

function SetNextLv()

end

function SetExp()
    -- exp
    local curExp, maxExp = cRoleData:GetExp()
    CSAPI.SetText(txtExp,
        string.format("%s<color=#ffc146>+%s</color><color=#929296>/%s</color>", curExp, totaleExp, maxExp))
    -- bar
    slider.value = curExp / maxExp
    mFill0.fillAmount = (curExp + totaleExp) / maxExp
end

function OnClickBg2()
    Refresh(nil)
end

function OnClickCancel()
    if (not openType) then
        Refresh(nil)
    else
        view:Close()
    end
end

function OnClickSure()
    local items = {}
    for i, v in pairs(giftDatas) do
        if (v.num > 0) then
            table.insert(items, {
                id = i,
                num = v.num,
                type = RandRewardType.ITEM
            })
        end
    end
    if (#items > 0) then
        DormProto:UseGift(cRoleData:GetID(), items)
        -- dormView:Back()
        -- Clear()

        OnClickCancel()
        LanguageMgr:ShowTips(21038)
    end
end

function OnClickMask()
    view:Close()
end

-- 显示未拥有礼物
function OnClickChoose()
    isChoose = not isChoose
    SetGrids()
end
