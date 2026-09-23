local curIndex = nil
local baseIndex = nil

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/RoleLittleCard/CreateBDItem", LayoutCallBack, true)
end

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end
function OnDestroy()
    eventMgr:ClearListener()
end
function OnViewOpened(viewKey)
    if (viewKey == "RoleInfo") then
        CSAPI.SetAnchor(gameObject, 0, 10000, 0)
    end
end
function OnViewClosed(viewKey)
    if (viewKey == "RoleInfo") then
        CSAPI.SetAnchor(gameObject, 0, 0, 0)
    end
end


local elseData = {}
function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)

        elseData.curIndex = curIndex
        elseData.baseIndex = baseIndex

        lua.Refresh(_data, elseData)
    end
end

function ItemClickCB(index)
    if (curIndex and curIndex == index) then
        curIndex = nil
    else
        curIndex = index
    end
    layout:UpdateList()
    SetBtns()
end

function OnOpen()
    sel_infos = data:GetBDData()
    -- datas
    InitDatas()
    -- btn
    SetBtns()
end

function InitDatas()
    local curID = sel_infos and sel_infos.num
    curDatas = {}
    local list = data:GetCfg().sel_card_ids
    for i, v in ipairs(list) do
        local cfg = Cfgs.CardData:GetByID(v)
        if (curID and curID == v) then
            baseIndex = i
            curIndex = i
        else
            table.insert(curDatas, cfg)
        end
    end
    -- 选中的放到最前 
    if (baseIndex ~= nil) then
        local cfg = Cfgs.CardData:GetByID(list[baseIndex])
        table.insert(curDatas, 1, cfg)
        baseIndex = 1
        curIndex = 1
    end
    layout:IEShowList(#curDatas)
end

function SetBtns()
    tipsID = nil
    local strID = 1001 -- 确定
    local alpha = 1
    if (curIndex == nil or (baseIndex ~= nil and baseIndex == curIndex)) then
        if (baseIndex) then
            strID = 17054 -- "取消"
            tipsID = 10012
        end
    else
        if (baseIndex) then
            strID = 17053 -- 更换
            tipsID = 10011
        end
    end

    LanguageMgr:SetText(txtOk, strID)
    LanguageMgr:SetEnText(txtOk2, strID)

    if (not canvasGroup) then
        canvasGroup = ComUtil.GetCom(btnOk, "CanvasGroup")
    end
    canvasGroup.alpha = alpha
end

function OnClickL()
    view:Close()
end

function OnClickR()
    if (tipsID) then
        local dialogdata = {}
        dialogdata.content = LanguageMgr:GetTips(tipsID)
        dialogdata.okCallBack = function()
            if (tipsID == 10011) then
                PlayerProto:SetCardPoolSelCard(data:GetId(), curDatas[curIndex].id)
            else
                PlayerProto:SetCardPoolSelCard(data:GetId(), 0)
            end
            view:Close()
        end
        CSAPI.OpenView("Dialog", dialogdata)
    else
        if (curIndex) then
            PlayerProto:SetCardPoolSelCard(data:GetId(), curDatas[curIndex].id)
            view:Close()
        end
    end
end
