local curIndex = nil

function Awake()
    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)

    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    layout1:Init("UIs/ExerciseR/ExerciseRRankRewardItem1", LayoutCallBack1, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)
    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/ExerciseR/ExerciseRRankRewardItem1", LayoutCallBack2, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.Normal)
    layout3 = ComUtil.GetCom(vsv3, "UIInfinite")
    layout3:Init("UIs/ExerciseR/ExerciseRRankRewardItem2", LayoutCallBack3, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout3, UIInfiniteAnimType.Normal)
    layout4 = ComUtil.GetCom(vsv4, "UIInfinite")
    layout4:Init("UIs/ExerciseR/ExerciseRRankRewardItem2", LayoutCallBack4, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout4, UIInfiniteAnimType.Normal)
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas1[index]
        lua.SetClickCB(RefreshPanel)
        lua.Refresh(_data,ePVPTaskType.Join)
    end
end
function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas2[index]
        lua.SetClickCB(RefreshPanel)
        lua.Refresh(_data,ePVPTaskType.Win)
    end
end
function LayoutCallBack3(index)
    local lua = layout3:GetItemLua(index)
    if (lua) then
        local _data = curDatas3[index]
        lua.Refresh1(_data)
    end
end
function LayoutCallBack4(index)
    local lua = layout4:GetItemLua(index)
    if (lua) then
        local _data = curDatas4[index]
        lua.Refresh2(_data)
    end
end
function OnTabChanged(_index)
    if (curIndex and curIndex == _index) then
        return
    end
    curIndex = _index
    RefreshPanel()
end

function OnOpen()
    tab.selIndex = curIndex or 0
end

function RefreshPanel()
    CSAPI.SetGOActive(vsv1, curIndex == 0)
    CSAPI.SetGOActive(vsv2, curIndex == 1)
    CSAPI.SetGOActive(vsv3, curIndex == 2)
    CSAPI.SetGOActive(vsv4, curIndex == 3)
    if (curIndex == 0) then
        curDatas1 = {}
        local rewardInfo = ExerciseRMgr:GetRewardInfo()
        local get_join_cnt_id = rewardInfo.get_join_cnt_id or 0
        local cfg = Cfgs.CfgPvpTaskReward:GetByID(1)
        if (cfg.fold==1) then
            local _i = get_join_cnt_id == 0 and 1 or (get_join_cnt_id + 1)
            _i = _i > #cfg.infos and #cfg.infos or _i
            cfg.infos[_i]._isSuccess = _i <= get_join_cnt_id
            table.insert(curDatas1, cfg.infos[_i])
        else
            for k, v in ipairs(cfg.infos) do
                v._isSuccess = k <= get_join_cnt_id
                table.insert(curDatas1, v)
            end
            if (#curDatas1 > 1) then
                table.sort(curDatas1, function(a, b)
                    if (a._isSuccess == b._isSuccess) then
                        return a.order < b.order
                    else
                        return b._isSuccess
                    end
                end)
            end
        end
        layout1:IEShowList(#curDatas1)
    elseif (curIndex == 1) then
        curDatas2 = {}
        local rewardInfo = ExerciseRMgr:GetRewardInfo()
        local get_win_cnt_ix = rewardInfo.get_win_cnt_ix or 0
        local cfg = Cfgs.CfgPvpTaskReward:GetByID(2)
        if (cfg.fold==1) then
            local _i = get_win_cnt_ix == 0 and 1 or (get_win_cnt_ix + 1)
            _i = _i > #cfg.infos and #cfg.infos or _i
            cfg.infos[_i]._isSuccess = _i <= get_win_cnt_ix
            table.insert(curDatas2, cfg.infos[_i])
        else
            for k, v in ipairs(cfg.infos) do
                v._isSuccess = k <= get_win_cnt_ix
                table.insert(curDatas2, v)
            end
            if (#curDatas2 > 1) then
                table.sort(curDatas2, function(a, b)
                    if (a._isSuccess == b._isSuccess) then
                        return a.order < b.order
                    else
                        return b._isSuccess
                    end
                end)
            end
        end
        layout2:IEShowList(#curDatas2)
    elseif (curIndex == 2) then
        if (not curDatas3) then
            local _curDatas3 = Cfgs.CfgPvpRankLevel:GetAll()
            curDatas3 = table.copy(_curDatas3)
            table.remove(curDatas3, 1)
        end
        layout3:IEShowList(#curDatas3)
    elseif (not curDatas4) then
        if (not curDatas4) then
            curDatas4 = Cfgs.CfgPvpRanklistReward:GetAll()
        end
        layout4:IEShowList(#curDatas4)
    end
    SetRed()
end

function SetRed()
    local _data = RedPointMgr:GetData(RedPointType.PVP)
    local isRed1, isRed2 = false, false
    if (_data) then
        isRed1 = _data == 3 or _data == 1
        isRed2 = _data == 3 or _data == 2
    end
    UIUtil:SetRedPoint2("Common/Red2", item1, isRed1, 171, 11, 0)
    UIUtil:SetRedPoint2("Common/Red2", item2, isRed2, 171, 11, 0)
end

function OnClickMask()
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end

