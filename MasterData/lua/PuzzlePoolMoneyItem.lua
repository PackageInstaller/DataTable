function OnEnable()
    if (eventMgr) then
        eventMgr:ClearListener()
    end
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Player_HotChange, HotChange)
    eventMgr:AddListener(EventType.Bag_Update, function()
        if (datas and #datas > 0) then
            SetMoney()
        end
    end)

    -- transform.offsetMin = UnityEngine.Vector2(0, 0)
    -- transform.offsetMax = UnityEngine.Vector2(0, 0)
end

function OnDisable()
    eventMgr:ClearListener()
    eventMgr = nil
end

-- datas ={{id,跳转id}......}
function Init(_datas)
    datas = _datas -- or {ITEM_ID.DIAMOND, ITEM_ID.GOLD, ITEM_ID.Hot}

    SetMoney()
end

-- datas ={{id,跳转id}......}
function SetMoney(_datas)
    datas = _datas or datas
    CSAPI.SetGOActive(moneys, datas ~= nil)
    if (datas == nil) then
        return
    end
    for i = 1, 3 do
        local isShow = i <= #datas and datas[i] ~= nil
        CSAPI.SetGOActive(this["btnMoney" .. i], isShow)
    end
    -- money
    for i = 1, #datas do
        local _data = datas[i]
        if _data ~= nil then
            -- icon
            local cfg = Cfgs.ItemInfo:GetByID(_data[1])
            if cfg==nil then LogError("物品表不存在物品id："..table.tostring(_data,true)); end
            ResUtil.IconGoods:Load(this["moneyIcon" .. i], cfg.icon .. "_1")
            -- num
            if (_data[1] == ITEM_ID.Hot) then
                HotChange()
            else
                local num = BagMgr:GetCount(_data[1])
                -- if (num >= 100000) then
                --     CSAPI.SetText(this["txtMoney" .. i], math.floor(num / 1000) .. "K")
                -- else
                CSAPI.SetText(this["txtMoney" .. i], num .. "")
                -- end
            end
            -- add 

            -- CSAPI.SetGOActive(this["add" .. i], _data[2] ~= nil)
            if (_data[2] ~= nil) then
                local colorName = cfg.addColor
                CSAPI.SetImgColorByCode(this["add" .. i], colorName)
            end
        end
    end
end

function OnClickMoney1()
    OnClickMoney(1)
end
function OnClickMoney2()
    OnClickMoney(2)
end
function OnClickMoney3()
    OnClickMoney(3)
end

function OnClickMoney(index)
    if (index <= #datas) then
        local jumpID = datas[index][2]
        if (jumpID) then
            local isOpen, desc = JumpMgr:CheckCanJump(jumpID)
            if (isOpen) then
                local cfg = Cfgs.CfgJump:GetByID(jumpID)
                if (cfg and cfg.closeAll) then
                    CSAPI.CloseAllOpenned() -- 关闭上级所有界面
                end
                JumpMgr:Jump(jumpID)
            else
                Tips.ShowTips(desc)
            end
        else--打开物品UI
            local goods=BagMgr:GetFakeData(datas[index][1]);
            if goods then
                CSAPI.OpenView("GoodsFullInfo",{data=goods});
            end
        end
    end
end

-- 体力变化
function HotChange()
    if (not datas) then
        return
    end
    for i = 1, #datas do
        if (datas[i][1] == ITEM_ID.Hot) then
            local cur = PlayerClient:Hot()
            local max1, max2 = PlayerClient:MaxHot()
            CSAPI.SetText(this["txtMoney" .. i], cur .. "/" .. max1)
            break
        end
    end
end
