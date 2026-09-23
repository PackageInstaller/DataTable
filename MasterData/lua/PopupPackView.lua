local curIndex = nil
local finishTime = nil
local timer = nil
local curData = nil

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Menu_PopupPack, RefreshPanel)
end

function OnDestroy()
    eventMgr:ClearListener()
    PopupPackMgr:TrackEvents_2()
end

function Update()
    if (timer and Time.time >= timer) then
        timer = Time.time + 1
        SetTime()
    end
end

-- data 表id
function OnOpen()
    RefreshPanel()
end

function RefreshPanel()
    SetData()
    SetCur()
    SetBtns()
    -- 
    --UIUtil:SetPrice(curData:GetCurShowItemCfg().shopItem, rmbIcon, rmbText, rmbNum)
end

function SetData()
    arr = PopupPackMgr:GetArr()
    if (curIndex == nil and data) then
        for k, v in ipairs(arr) do
            if (v:GetCfgID() == data) then
                curIndex = k
                break
            end
        end
        data = nil
    end
    curIndex = curIndex == nil and 1 or curIndex
    curIndex = curIndex > #arr and #arr or curIndex
    if (curIndex <= 0) then
        view:Close()
    end
end

function SetCur()
    if (curIndex <= 0) then
        return
    end
    curData = arr[curIndex]
    local cfg = curData:GetCurShowItemCfg()
    local shopCfg = Cfgs.CfgCommodity:GetByID(cfg.shopItem)
    CSAPI.SetText(txtName, shopCfg.sName)
    CSAPI.SetText(txtGoodValue, cfg.goodValue * 100 .. "%")
    CSAPI.SetText(txtDesc, shopCfg.sDesc)
    SetItem(shopCfg.nSumBuyLimit or 1)
    -- time
    finishTime = curData:GetFinishTime()
    timer = 0
    -- 
    UIUtil:SetPrice(curData:GetCurShowItemCfg().shopItem, rmbIcon, rmbText, rmbNum)
end

function SetItem(nSumBuyLimit)
    --local cfg = curData:GetCfg()
    -- CSAPI.SetText(txtCnt, cfg.loopCount)
    LanguageMgr:SetText(txtCnt, 38005, nSumBuyLimit)
    -- local cfg = curData:GetCurShowItemCfg()
    -- if (cfg.item) then
    --     local rewardData = BagMgr:GetFakeData(cfg.item[1][1], cfg.item[1][2])
    -- ResUtil.IconGoods:Load(imgReward, rewardData:GetIcon())
    -- if rewardItem == nil then
    --     ResUtil:CreateUIGOAsync("Grid/GridItem", itemParent, function(go)
    --         local _lua = ComUtil.GetLuaTable(go)
    --         _lua.Refresh(rewardData)
    --         _lua.SetClickCB(GridClickFunc.OpenInfoSmiple)
    --         rewardItem = _lua
    --     end)
    -- else
    --     rewardItem.Refresh(rewardData)
    -- end
    -- end
end

function SetTime()
    local needTime = finishTime - TimeUtil:GetTime()
    needTime = needTime <= 0 and 0 or needTime
    LanguageMgr:SetText(txtTime,81002, TimeUtil:GetTimeStr(needTime))
    if (needTime <= 0) then
        timer = nil
        PopupPackMgr:UpdateDatas()
        RefreshPanel()
    end
end

function SetBtns()
    CSAPI.SetGOActive(btnL, curIndex > 1)
    CSAPI.SetGOActive(btnR, curIndex < #arr)
end

function OnClickMask()
    view:Close()
end

function OnClickL()
    curIndex = curIndex - 1
    SetBtns()
    SetCur()
end

function OnClickR()
    curIndex = curIndex + 1
    SetBtns()
    SetCur()
end

function OnClickBuy()
    UIUtil:ShowBuy(curData:GetCurShowItemCfg().shopItem)
    -- 
    PopupPackMgr:TrackEvents_3()
end

function OnClickItem()
    OnClickBuy()
    -- local cfg = curData:GetCurShowItemCfg()
    -- if (cfg.item) then
    --     local rewardData = BagMgr:GetFakeData(cfg.item[1][1], cfg.item[1][2])
    --     GridClickFunc.OpenInfoSmiple({
    --         data = rewardData
    --     })
    -- end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end

