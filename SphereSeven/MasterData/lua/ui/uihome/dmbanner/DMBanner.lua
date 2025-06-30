local DMBanner = {}
local this = DMBanner
local DMBannerItemPath = "UI/Prefabs/View/Items/DMItem.prefab"
local imagePath = "UI/SummonRareFrame/"

local imageNameConfig = {
    [1] = "R.png";
    [2] = "SR.png";
    [3] = "SSR.png";
    [4] = "UR.png";
}

function this.InitPanel(self, drawMarqueeBanner)
    self.drawMarqueeBanner = drawMarqueeBanner;
    self.dMItemParent = drawMarqueeBanner:Find("Mask").gameObject.transform;
    self.LastMoveTottleLength = 0;
    this.OnUpdateDM(self);
end

function this.TransDataStructure(self)
    local tab = DMBannerData:GetInstance():GetDMBannerData();      -- 正式拿服务器数据
    --local tab = {{paramMsg ="ffff(11888559)|1025",paramId = 5000},{paramMsg ="nihao(11888559)|100101",paramId = 3000}};  -- 测试用
    local currData = {};                                           -- 组装后数据结构，用于逻辑
    for key, value in pairs(tab) do
        local v_data = {};
        local tabMsg = string.split(value.paramMsg,"|");
        v_data.nick = tabMsg[1];
        v_data.cardId = tonumber(tabMsg[2]);
        table.insert(currData,{msg = v_data,fromId = value.paramId});
    end
    return currData;
end

function this.OnUpdateDM(self)
    DMBannerData:GetInstance():SetDMBIsStart(false);
    local delayMove = self.LastMoveTottleLength/170;
    local data = this.TransDataStructure(self);
    if #data == 0 then
        return;
    end
    DMBannerData:GetInstance():ClearDMBannerData();
    self.drawMarqueeBanner.gameObject:SetActive(true);
    for key, value in pairs(data) do
        this.InitRoleItem(self,delayMove,data,key,value);
    end
 end

 function this.InitRoleItem(self,delayMove,data,key,value)
    local txtMsgL;
    local txtMsgR;
    local spritPath;
    local msgConfigTab;
    local moveTottleLength;
    local item = GameObjectPool:GetInstance():CoGetGameObjectAsync(DMBannerItemPath);
    local txtLGo = item.transform:Find("TxtL").gameObject;
    local imageGo = txtLGo.transform:Find("Image").gameObject;
    local txtRGo = imageGo.transform:Find("TxtR").gameObject;
    local imageRect = imageGo.transform:GetComponent("RectTransform");
    if value.fromId == 3000 then -- 皮肤
        msgConfigTab = string.split(LangUtil.GetSysLang(4076),"|");
        txtMsgL = string.format(msgConfigTab[1],value.msg.nick);
        txtMsgR = string.format(msgConfigTab[2],LangUtil.GetConfLang(Z_Skin[value.msg.cardId],"Name"));
        imageRect.sizeDelta = Vector2.New(0,1);
    elseif value.fromId == 5000 then -- 角色卡
        msgConfigTab = string.split(LangUtil.GetSysLang(4075),"|");
        txtMsgL = string.format(msgConfigTab[1],value.msg.nick);
        txtMsgR = string.format(msgConfigTab[2],LangUtil.GetConfLang(Z_Card[value.msg.cardId],"Name"));
        if Z_Card[value.msg.cardId].Rare ~= 0 then
            spritPath = imagePath..imageNameConfig[Z_Card[value.msg.cardId].Rare];
            imageGo.transform:GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync(spritPath);
            imageGo.transform:GetComponent("Image"):SetNativeSize();
        else
            imageRect.sizeDelta = Vector2.New(0,1);
        end
    end
    LangUtil.BindText( txtLGo ).text = txtMsgL;
    LangUtil.BindText( txtRGo ).text = txtMsgR;
    item.transform:SetParent(self.dMItemParent)
    item.transform.localScale = Vector3.one;
    item.transform.localPosition = Vector3.New(350,0,0);
    txtLGo.transform:GetComponent("ContentSizeFitter"):SetLayoutHorizontal();
    txtRGo.transform:GetComponent("ContentSizeFitter"):SetLayoutHorizontal();
    local txtLWidth = txtLGo.transform:GetComponent("RectTransform").sizeDelta.x;
    local imageWidth = imageGo.transform:GetComponent("RectTransform").sizeDelta.x;
    local txtRWidth = txtRGo.transform:GetComponent("RectTransform").sizeDelta.x;
    moveTottleLength = txtLWidth + imageWidth + txtRWidth + 900;
    item.transform:DOLocalMoveX(350 - moveTottleLength,moveTottleLength/150):SetEase(Ease.Linear):SetDelay((key-1)*delayMove):OnComplete(function ()
        local nextRollData = this.TransDataStructure(self);
        if key == #data then
            self.drawMarqueeBanner.gameObject:SetActive(#nextRollData > 0);
            if #nextRollData > 0 then
                self.LastMoveTottleLength = moveTottleLength;
                this.OnUpdateDM(self);
            else
                self.LastMoveTottleLength = 0;
                DMBannerData:GetInstance():SetDMBIsStart(true);
            end
        end
        GameObjectPool:GetInstance():RecycleGameObject(DMBannerItemPath, item)
    end);
 end

return this