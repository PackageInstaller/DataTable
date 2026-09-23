local mainCfg
local endTime
local timer = nil
local canClose = false

function Update()
    if ((endTime and TimeUtil:GetTime() > endTime) or (timer and TimeUtil:GetTime() > timer)) then
        endTime = nil
        OnOpen()
    end
end

function OnOpen()
    canClose = false
    OperateActiveProto:PhysicalRewardInfo(RefreshPanel)
end

function Refresh()
    canClose = false
    OperateActiveProto:PhysicalRewardInfo(RefreshPanel)
end

function RefreshPanel()
    mainCfg, endTime = PhysicalRewardMgr:GetMainCfg()
    if (not mainCfg) then
        Log("活动已过期或当前时间在实物奖励抽奖表不存在对应的活动下标")
        view:Close()
        return
    end
    -- 
    allNums = mainCfg.rewardNums
    nums = PhysicalRewardMgr:GetNums()
    CSAPI.SetText(txtTime, mainCfg.showTime)
    SetItems()

    timer = TimeUtil:GetTime() + g_PhysicalRewardRefreshTime
    canClose = true
end

function SetItems()
    for k = 1, 3 do
        local had = allNums[k] - nums[k]
        had = had <= 0 and 0 or had
        local str = string.format("%s<color=#bd2a3e><size=28>/%s</size></color>", had, allNums[k])
        CSAPI.SetText(this["txtNum" .. k], str)
        -- 

        local childCfg = PhysicalRewardMgr:GetChildCfg()
        local cfg = Cfgs.cfgPhysicalRewardGroup:GetByID(childCfg.index)
        CSAPI.SetText(this["txtName" .. k], cfg.infos[k].name)
    end
end

function OnClickMask()
    if (canClose) then
        view:Close()
    end
end

function OnClickQuestion()
    local cfg = Cfgs.CfgModuleInfo:GetByID("PhysicalReward")
    CSAPI.OpenView("ModuleInfoView", cfg)
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    OnClickMask()
end
