---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/7/11 17:09
---

local AddLogic = {};
local this = AddLogic;
local addPfbName = "FriendItem"

---@type SocietyRole[]
local addFriends = {}
local function OnClickAddButton(self,id)
    PublicRequest.SendRequest(
        PROTOCOL.RequestFriendReq,
        {
            role_id = id,
        },
        nil
       )
    -- UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipAddFriend, {
    --     title = LangUtil.GetSysLang(9),
    --     maxLength = 16,
    --     callBack = function(msg)
          
    --     end
    -- })
end

function this.OnClickSearchButton(self,input)
    if string.IsNullOrEmpty(input.text) then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(4031))
        return
    end
    
    ---@param response protocol.SearchRoleResp
    PublicRequest.SendRequest(
        PROTOCOL.SearchRoleReq,
        {
            keyword = input.text
        },
        function(response, error)
            addFriends = {}
            if response.results ~= nil and table.count(response.results) > 0 then
                for index, result in ipairs(response.results) do
                    table.insert(
                            addFriends,
                            Game.Registry:NewObject("SocietyRole", result)
                    )
                end
            else
                UIUtil.ToolTipFourth(LangUtil.GetSysLang(1457)) -- 找不到玩家
                return
            end
            this.Init(self)
        end
    )
end

function this.OnClickFreshButton(self)
    this.OnClickSearchButton(self,self.add_InputField)
end

function this.InitContent(self)
    ListChildPool:GetInstance():ClearContent(self.add_Content);
    self.hint:SetActive(table.count(addFriends) == 0)
    coroutine.start(function()
        ---@param v SocietyRole
        for k,v in table.pairsByKeys(addFriends) do
            ListChildPool:GetInstance():GetChild(addPfbName,self.add_Content,function(object)
                if self.active == false then ListChildPool:GetInstance():Remove(object) return end
                local rc = object:GetComponent("ReferenceCollector")
                local avatar_Image = rc:GetObject("Avatar"):GetComponent("Image")
                local name_Text = rc:GetObject("Name")
                local level_Text = rc:GetObject("Level"):GetComponent("Text")
                local StateLX = rc:GetObject("StateLX")
                local StateZX = rc:GetObject("StateZX")
                local IDText= rc:GetObject("IDText")
            
                LangUtil.GetSpriteLang(456, function(sprite) StateLX:GetComponent("Image").sprite = sprite end)
                LangUtil.GetSpriteLang(457, function(sprite) StateZX:GetComponent("Image").sprite = sprite end)
                LangUtil.GetSpriteLang(458, function(sprite) rc:GetObject("SupportImage"):GetComponent("Image").sprite = sprite end)
                LangUtil.GetSpriteLang(459, function(sprite) rc:GetObject("NoFightSoulImage"):GetComponent("Image").sprite = sprite end)
                
                LangUtil.BindText(IDText, FontType.All_Number).text = v.info.roleId

                ---@type UnityEngine.Transform
                local buttonRoot = rc:GetObject("ButtonRoot").transform
                local addButton
                for i = 0, buttonRoot.childCount - 1 do
                    local child = buttonRoot:GetChild(i)
                    if child.gameObject.name == "Add" then
                        child.gameObject:SetActive(true)
                        addButton = child.transform:Find("Button")
                    else
                        child.gameObject:SetActive(false)
                    end
                end
                LangUtil.BindText(addButton:Find("Text")).text = LangUtil.GetSysLang(322)
            
                if not v.isOnLine then
                    local timeDate = ""
                    local timeData = TimeUtil.ConvertTimeForm(os.time() - v.info.logoutTime)
                    local day = timeData.day
                    local hour = timeData.hour
                    if day < 1 then
                        if hour < 1 then
                            local min = timeData.minute
                            if min < 1  then
                                min = 1
                            end
                            timeDate = string.gsub(LangUtil.GetSysLang(728),"X",min)
                        else
                            timeDate = string.gsub(LangUtil.GetSysLang(726),"X",hour)
                        end
                    else
                        if day>30 then
                            day = 30
                        end
                        timeDate = string.gsub(LangUtil.GetSysLang(727),"X",day)
                    end
                    --end
                    LangUtil.BindText(rc:GetObject("OneLineTimeValue")).text = "[" .. timeDate .. "]"
                    rc:GetObject("BgImage"):GetComponent("Image").material = DeActiveMat -- 离线
                else
                    rc:GetObject("BgImage"):GetComponent("Image").material = nil -- 在线
                end
                if v.info.avatar ~= nil and Z_HeadPortrait[v.info.avatar] ~= nil then
                    UIUtil.SetPlayerIcon(avatar_Image,Z_HeadPortrait[v.info.avatar].Resourse)
                end
                LangUtil.BindText(name_Text).text = v.info.username
                level_Text.text = "LV.".. v.info.level
                StateLX:SetActive(not v.isOnLine)--离线
                StateZX:SetActive(v.isOnLine)--在线

                local cardItem = rc:GetObject("CardItemLittle")
                local fightSoulItem = rc:GetObject("FightVisitItemMid")
                cardItem:SetActive(v.supportUnits.cardData ~= nil)
                if v.supportUnits.cardData ~= nil then
                    UIPublic.InitCardItemLittle(
                        v.supportUnits.cardData,
                        cardItem
                    )
                end
                fightSoulItem:SetActive(v.supportUnits.fight_soul ~= nil and v.supportUnits.fight_soul.id ~= 0)
                if v.supportUnits.fight_soul ~= nil and v.supportUnits.fight_soul.id ~= 0 then
                    UIPublic.InitVsFightSoulItemMId(
                        v.supportUnits.fightSoulEntity,
                        fightSoulItem
                    )
                end
            
                -- 已經是好友或者在黑名單不添加
                if self.friends[v.info.roleId] ~= nil then
                    addButton.gameObject:SetActive(false)
                else
                    addButton.gameObject:SetActive(true)
                end
                if Game.Scene.Player.Id == v.info.roleId then
                    addButton.gameObject:SetActive(false)
                end
                UIUtil.AddBtnEvent(addButton,function(go) OnClickAddButton(self,v.info.roleId) end)
                UIUtil.AddBtnEvent(avatar_Image.gameObject,function()
                    UIPublic.OpenRoleInfo(v)
                end)
            end)
        end
    end)
end

function this.Init(self)
    this.InitContent(self);
end

return this;

