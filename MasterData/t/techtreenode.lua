---@class TechTreeNode : TechTreeNode_Generate
---##################### 【TechTreeNode Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【TechTreeNode Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local TechTreeNode = require "TechTreeNode_Generate"

function TechTreeNode:InitLogic(data)
    -- self.msgEventHandler = {
    --     {GameMsgType.TechTreeNodeSelect, self.onClickNode},
    -- }
end

---@class TechTreeNodeData
---@field groupId number
---@field level number
---@field maxLv number
---@field isLight boolean
---@field openObj UnityEngine.GameObject

---@param data TechTreeNodeData
function TechTreeNode:refreshUI(data)
    self.data = data
    --self.sel:SetActive(false)
    self:refreshCanUp(data)
    self.black:SetActive(false)
    self.lvtext.text.text = data.level
    self.maxLvtext.text.text = data.maxLv
    local pointCfg = Config.GetTechnologyTreePointInfo(data.groupId)
    if pointCfg then
        self:LoadSpriteAsync(string.format(Config.SpritePath.TechnologyTreeIcon, pointCfg.pointPic), self.icon.image)
    end
    if data.level == 0 then
        self.black:SetActive(true)
        if data.openObj then
            local canUp = Me:getTechTreeNodeCanUp(data.groupId)
            data.openObj:SetActive(canUp)
        end
        return
    end
    if data.openObj then
        data.openObj:SetActive(true)
    end
    local isMax = data.level == data.maxLv
    --self.normal:SetActive(not isMax)
    self.max:SetActive(isMax)
    if data.isLight then
        self.activeEf:SetActive(false)
        self.activeEf:SetActive(true)
    end
end

function TechTreeNode:refreshCanUp(data)
    local canUp = Me:getTechTreeNodeCanUp(data.groupId)
    self.move:SetActive(canUp)
    self.move.animation:Play("TreeNodeUp")
    self.lvBg:SetActive(true)
    self.lock:SetActive(false)
    

    if canUp == false then
        if data.level == 0 then
            self.lvBg:SetActive(false)
            self.lock:SetActive(true)
        end
    end
end

---@param data TechTreeNodeData
function TechTreeNode:onClickNode(data)
    if not data then
        self.sel:SetActive(false)
        return
    end
    self.sel:SetActive(data.groupId == self.data.groupId)
end

--function TechTreeNode:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/Root onClick 
--]]
function TechTreeNode:scaleButton_ScaleButton_onClick(scaleButton)
    local btnSoundPath = string.format(Config.AudioPath.SE, "pointselect")
    self:play2DSound(btnSoundPath) 
    GameMsgMgr:sendEvent(GameMsgType.TechTreeNodeSelect, self.data)
end

return TechTreeNode
