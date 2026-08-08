---@class LevelUpgradeToast : LevelUpgradeToast_Generate
---##################### 【LevelUpgradeToast Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LevelUpgradeToast Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local LevelUpgradeToast = require "LevelUpgradeToast_Generate"

function LevelUpgradeToast:InitLogic(data)
    self.animOverCallBack:SetCallBack(function()
		ClientData:CheckLevelUpBackFunc()
	end)
end

--function LevelUpgradeToast:StartCreating(time)
--
--end

--function LevelUpgradeToast:StartRemoving(time)
--
--end

--function LevelUpgradeToast:StartShowing(time)
--
--end

-- {
--     newLevel = number    -- 新等级
-- }
function LevelUpgradeToast:OnOpen(data, initiative)
    LuaLogger.ds("LevelUpgradeToast:OnOpen", tablex.dump(data), initiative)
    if initiative then
        self:SetPostProcessing()
        local originalLevel = data.oldLevel
        local newLevel = data.newLevel
        self.level.text.text = tostring(newLevel)
        local startEffect = self.effectStart
        -- local loopEffect = self.effectLoop
        --重置状态
        startEffect:SetActive(false)
        -- loopEffect:SetActive(false)
        -- --开始特效播完接上循环特效
        -- DLuaTimer:DoAfter(0.9, function()
        --     startEffect:SetActive(false)
        --     loopEffect:SetActive(true)
        -- end)
        startEffect:SetActive(true)

        --体力信息设置
        local itemInfo = Config.GetItemInfo(GE.ResourceType.Strength)
        self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemInfo.icon), function (s)
            self.ticketIcon.image.sprite = s
        end)
        local newNum = data.newTicketNum
        self.newTicketNum.text.text = newNum
        --战斗完成体力恢复特殊显示
        local battleWinPanel = UIMgr:getUIData("BattleWinPanel")
        if battleWinPanel then
            local levelConfig = battleWinPanel.ui.levelConfig
            local oldNum = data.oldTicketNum - levelConfig.victoryCost[2]
            self.oldTicketNum.text.text = oldNum
        else
            self.oldTicketNum.text.text = data.oldTicketNum
        end
    end

    local btnSoundPath = string.format(Config.AudioPath.SE, "gacha_new")
    self:play2DSound(btnSoundPath)
end

--设置相机的后处理
function LevelUpgradeToast:SetPostProcessing()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.volume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--function LevelUpgradeToast:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function LevelUpgradeToast:OnRefresh(data)
--
--end

return LevelUpgradeToast
