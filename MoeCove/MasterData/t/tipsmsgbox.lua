---@class TipsMsgBox : TipsMsgBox_Generate
---##################### 【TipsMsgBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【TipsMsgBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local TipsMsgBox = require "TipsMsgBox_Generate"

function TipsMsgBox:InitLogic(data)

end

---@param targetObject UnityEngine.GameObject 目标对象
---@param tipsId integer 对应Tips表中id字段
function TipsMsgBox:initPanel(targetObject, tipsId)
    LuaLogger.ds("TipsMsgBox:initPanel")
    local tipsConfig = Config.GetNormalExplainInfo(tipsId)

    local nowBox = self["type"..tipsConfig.type]
    if tipsConfig.type == 1 then--纯文字tips
        nowBox.tipsBg.transform.sizeDelta = Vector2.New(tipsConfig.size[1], tipsConfig.size[2])
        nowBox.tipsBg.transform.position = targetObject.transform.position

        --设置弹窗位置偏移量
        local offestX, offestY = 0, 0
        if tipsConfig.Offest == 1 then
            offestY = (nowBox.tipsBg.transform.sizeDelta.y + targetObject.transform.sizeDelta.y) / 2
        elseif tipsConfig.Offest == 2 then
            offestY = (nowBox.tipsBg.transform.sizeDelta.y + targetObject.transform.sizeDelta.y )/ -2
        elseif tipsConfig.Offest == 3 then
            offestX = (nowBox.tipsBg.transform.sizeDelta.x + targetObject.transform.sizeDelta.x) / 2
        elseif tipsConfig.Offest == 4 then
            offestX = (nowBox.tipsBg.transform.sizeDelta.x + targetObject.transform.sizeDelta.x) / -2
        end
        nowBox.tipsBg.transform.localPosition = nowBox.tipsBg.transform.localPosition + Vector3.New(offestX, offestY, 0)

        --显示
        nowBox.tipsTxt.text.text = tipsConfig.des
    end
    self.boxTweener = nowBox.canvasGroup:DOFade(1, 0.5)
    self.closeMask.image.raycastTarget = true
    --穿透关闭按钮
    self.closeMask.pointerListener.onPointerClickEvent = function ()
        self.boxTweener:Kill()
        nowBox.canvasGroup.alpha = 0
        self.closeMask.image.raycastTarget = false
    end
end

--function TipsMsgBox:OnDestroy()
--	self.super:OnDestroy(self)
--end

return TipsMsgBox
