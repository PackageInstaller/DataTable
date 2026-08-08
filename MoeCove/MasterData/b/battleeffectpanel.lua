---@class BattleEffectPanel : BattleEffectPanel_Generate
---##################### 【BattleEffectPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BattleEffectPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local BattleEffectPanel = require "BattleEffectPanel_Generate"

function BattleEffectPanel:InitLogic(data)
    self.effectTimerList = {}
end

--function BattleEffectPanel:StartCreating(time)
--
--end

--function BattleEffectPanel:StartEnter(time)
--
--end

---{
    --  data = {
    --     tipsName = string    特效图片路径
    --  }
-- }
function BattleEffectPanel:OnOpen(data, initiative)
    if initiative then
        --动态替换boss特效名称texture
        -- data.name = "test"
        local namepath = string.format(Config.SpritePath.BossEffectIconPath, data.tipsName)
        LuaLogger.ds("namepath", namepath)
        self:LoadSpriteAsync(namepath, function(s)
            if s then
                LuaLogger.ds("namepath", namepath)
                self.mingZi1.particleSystemRenderer.material.mainTexture = s.texture
                self.mingZi2.particleSystemRenderer.material.mainTexture = s.texture
            end
        end)
        
        local namepath = string.format(Config.SpritePath.BossEffectIconPath, data.tipsDesc)
        self:LoadSpriteAsync(namepath, function(s)
            if s then
                self.shenHai1.particleSystemRenderer.material.mainTexture = s.texture
                self.shenHai2.particleSystemRenderer.material.mainTexture = s.texture
                self.shenHai3.particleSystemRenderer.material.mainTexture = s.texture
                self.shenHai4.particleSystemRenderer.material.mainTexture = s.texture
            end
        end)
        self.warning1:SetActive(false)
        self.warning2:SetActive(false)
    end
end

--显示特效提示
---@param name string 特效节点名称
---@param time number 显示时间
function BattleEffectPanel:ShowEffectTips(name, time)
    local targetEffect = self[name]
    if targetEffect then
        targetEffect:SetActive(true)
        local num = tablex.size(self.effectTimerList) + 1
        local timer = DLuaTimer:DoAfter(time/Time.timeScale, function()
            targetEffect:SetActive(false)
            self.effectTimerList[num] = nil
        end)
        self.effectTimerList[num] = timer
    end
end

--清空所有特效 删除timer
function BattleEffectPanel:ClearEffectTipsAll()
    for k, timer in pairs(self.effectTimerList) do
        DLuaTimer:RemoveTimer(timer)
    end
    for i = 0, self.effectGroup.transform.childCount - 1 do
        local child = self.effectGroup.transform:GetChild(i)
        child.gameObject:SetActive(false)
    end
end

--function BattleEffectPanel:StartRemoving(time)
--
--end

--function BattleEffectPanel:StartExit(time)
--
--end

function BattleEffectPanel:OnClose(initiative)
    self:ClearEffectTipsAll()
end

--function BattleEffectPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function BattleEffectPanel:OnRefresh(data)
--
--end

return BattleEffectPanel
