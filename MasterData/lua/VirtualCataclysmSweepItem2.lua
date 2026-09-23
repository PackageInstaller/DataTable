local data = nil
local items = nil
local isKill = false
local isCardBattle = false
local cfgActive = nil
local isEnough = false

function SetIndex(idx)
    index = idx
end

function Refresh(_data,elseData)
    data = _data
    isKill = elseData and elseData.isKill
    if data then
        CSAPI.SetGOActive(teamInfo,not data.isEmpty)
        CSAPI.SetGOActive(empty,data.isEmpty)
        CSAPI.SetText(txtIndex,index .. "")
        if not data.isEmpty then
            cfgActive = Cfgs.CfgVirtualCataclysm:GetByID(VirCatMgr:GetActiveId())
            SetTime()
            SetCards()
            SetDamage()
            SetReward()
            SetBtnState()
        end
    end
end

function SetTime()
    CSAPI.SetText(txtTime,TimeUtil:GetTimeHMS(data:GetTime(),"%Y.%m.%d"))
end

function SetCards()
    items = items or {}
    local datas = data:GetCards()
    ItemUtil.AddItems("VirtualCataclysm/VirtualCataclysmCard",items,datas,gridParent)
    isCardBattle = false
    if datas then
        for i, v in ipairs(datas) do
            if not v.isEmpty and not VirCatMgr:IsCardShow(v:GetID()) then
                isCardBattle = true
                break
            end
        end
    end
end

function SetDamage()
    CSAPI.SetText(txtDamage,data:GetDamage() .. "")
end

function SetReward()
    if cfgActive and cfgActive.goodsId then
        local goodsData = GoodsData({id = cfgActive.goodsId})
        if goodsData:GetIcon() then
            goodsData:GetIconLoader():Load(rewardIcon,goodsData:GetIcon() .. "_1")
        end
    end
    local rewards = data:GetRewards()
    if rewards and rewards[1] then
        CSAPI.SetText(txtReward,rewards[1].num .. "")
    else
        CSAPI.SetText(txtReward,"0")
    end
end

function SetBtnState()
    CSAPI.SetGOActive(btnSweep,not isKill and not isCardBattle)
    CSAPI.SetGOActive(layout2,not isKill and not isCardBattle)
    CSAPI.SetGOActive(txt_close,isCardBattle and not isKill)
    CSAPI.SetGOActive(txt_close2,isKill)

    if not isKill and not isCardBattle then
        isEnough = true
        if cfgActive and cfgActive.enterCost then
            local cost = cfgActive.enterCost[1]
            local goodsData = GoodsData({id = cost[1]})
            if goodsData:GetIcon() then
                goodsData:GetIconLoader():Load(costIcon,goodsData:GetIcon() .. "_1")
            end
            CSAPI.SetText(txtCost,"X" .. cost[2])
            isEnough = BagMgr:GetCount(cost[1]) >= cost[2]
        end
    end
end

function OnClickSweep()
    if not isEnough then
        LanguageMgr:ShowTips(80002)
        return
    end

    CrossBossProto:CrossBossModUp(VirCatMgr:GetActiveId(),data:GetID(),data:GetIndex())
end

function OnClickDelete()
    local dialogData = {}
    dialogData.content = LanguageMgr:GetByID(380073)
    dialogData.okCallBack = function()
        CrossBossProto:CrossBossModSaveDel(VirCatMgr:GetActiveId(),data:GetID(),data:GetIndex(),OnSaveDelete)
    end
    CSAPI.OpenView("Dialog",dialogData)
end

function OnSaveDelete(proto)
    VirCatMgr:RemoveSaveData(data:GetID(),data:GetIndex())
end