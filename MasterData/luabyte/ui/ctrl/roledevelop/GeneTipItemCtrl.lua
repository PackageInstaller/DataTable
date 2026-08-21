local GeneTipItemCtrl = BaseClass("GeneTipItemCtrl",UIBaseComponent)
local M = GeneTipItemCtrl 
local attrNum = 4 

function M:__init()
    self.Attrs = {}
    for i = 1, attrNum do
        self.Attrs[i] = self._view["AttrText"..i]
    end
end

function M:SetTipItemInfo(cfg)
    self._view.Title:SetText(cfg.haloDesc)
    self._view.gameObject:SetActive(true)
    for i = 1, #cfg.attributeType do
        if i <= attrNum then 
            self.Attrs[i]:SetLabel(cfg.attributeType[i],cfg.attributeValue[i])
            self.Attrs[i].gameObject:SetActive(true)
        else
            Logger.LogError("AttrText 数量超标，UI只支持"..attrNum.."个，但heroAiEffect.attributeType的数量超标")
        end
    end
    for i = #cfg.attributeType+1, #self.Attrs do
        self.Attrs[i].gameObject:SetActive(false)
    end
end
return GeneTipItemCtrl